From: Vincent Legoll <vincent.legoll@gmail.com>
Subject: Re: [PATCH] stash: complain about unknown flags
Date: Sun, 1 Nov 2015 09:16:40 +0100
Message-ID: <CAEwRq=p5AGE4ingzp8QFyUPetkiY7bgCyx6ZeaetzO5uQayXpg@mail.gmail.com>
References: <CAEwRq=r=iMmnnzS2F_2rr9Tjem9khn1d=os3krjEjOg5iK5bww@mail.gmail.com>
	<20150520180132.GB14561@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 01 09:16:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zsnoj-0007uy-T3
	for gcvg-git-2@plane.gmane.org; Sun, 01 Nov 2015 09:16:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbbKAIQm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Nov 2015 03:16:42 -0500
Received: from mail-ig0-f170.google.com ([209.85.213.170]:37542 "EHLO
	mail-ig0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750972AbbKAIQl (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Nov 2015 03:16:41 -0500
Received: by igbhv6 with SMTP id hv6so36597159igb.0
        for <git@vger.kernel.org>; Sun, 01 Nov 2015 01:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=wsZ2xRLMosdFPZYQxmLAA3DL4e7fOdtQ3TqtW75UNqY=;
        b=dZSogsxT9+mMXmQuWwpaHJxPdjfP0OpccN8FsUdHyDhDSeBCOwipMgPjGPHwmaOQxc
         +b1BTyNKwCHI++Tb+cIhlciFNwz05DR8r2cyu8oCqWzLslcVPNGlv7IFG3QKirGizdio
         8kyQBc7H5ikuDzxmG2VCxwsmPJqQQrJS0EeUrzRA4V1qH8Q9WIXMvYseZ/Nj/nQbjdAS
         sqxAJoxTrvTXepWGVadGfxwEXsg/uLaUfpnyu5Ugd7ElcxHW9XtlPl1R5H5DRKlPD0tQ
         ZcFUB8+zQ12TlZ+55Jz7t9IHwSqkt92UwpWCluT1BMxaz2d0+GXbaTKTEKaUFPHipI0l
         7/Wg==
X-Received: by 10.50.61.34 with SMTP id m2mr6212505igr.34.1446365800687; Sun,
 01 Nov 2015 01:16:40 -0700 (PDT)
Received: by 10.64.10.129 with HTTP; Sun, 1 Nov 2015 01:16:40 -0700 (PDT)
In-Reply-To: <20150520180132.GB14561@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280610>

Hello,

On Wed, May 20, 2015 at 8:01 PM, Jeff King <peff@peff.net> wrote:
> The option parser for git-stash stuffs unknown flags into
> the $FLAGS variable, where they can be accessed by the
> individual commands. However, most commands do not even look
> at these extra flags, leading to unexpected results like
> this:
>
>   $ git stash drop --help
>   Dropped refs/stash@{0} (e6cf6d80faf92bb7828f7b60c47fc61c03bd30a1)
>
> We should notice the extra flags and bail. Rather than
> annotate each command to reject a non-empty $FLAGS variable,
> we can notice that "stash show" is the only command that
> actually _wants_ arbitrary flags. So we switch the default
> mode to reject unknown flags, and let stash_show() opt into
> the feature.

Better late than never, that does look good...

-- 
Vincent Legoll
