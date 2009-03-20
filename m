From: skillzero@gmail.com
Subject: Re: Push tag from shallow clone?
Date: Thu, 19 Mar 2009 17:01:55 -0700
Message-ID: <2729632a0903191701k4af0045clfb99dd28119e97b3@mail.gmail.com>
References: <2729632a0903191056w4efdbec6hd1656d7b47d0d8a3@mail.gmail.com>
	 <20090319180216.GT23521@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Mar 20 01:04:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LkSCv-0008Sr-Op
	for gcvg-git-2@gmane.org; Fri, 20 Mar 2009 01:03:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751894AbZCTAB7 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Mar 2009 20:01:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751670AbZCTAB6
	(ORCPT <rfc822;git-outgoing>); Thu, 19 Mar 2009 20:01:58 -0400
Received: from yx-out-2324.google.com ([74.125.44.29]:17261 "EHLO
	yx-out-2324.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751484AbZCTAB6 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Mar 2009 20:01:58 -0400
Received: by yx-out-2324.google.com with SMTP id 31so769941yxl.1
        for <git@vger.kernel.org>; Thu, 19 Mar 2009 17:01:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=3o8T7GzcQoz5VlWtTBkwRVowNZJewG+TM1fH1yKnvUk=;
        b=WVT1UyUWICXly/ESMpAf8HfUPrAFeSQc69cuOhdPMc3ozyQ4Rd6RmK0fBCZ4P9rrpn
         l6gbsvm7fQwlPoEd8mVennkGT1UxJRz6nao0xkBubdUx4gvfWUCUaJ1hMxDRQgh6AfJw
         g+MNO6HDi6cg+kh4sSzNalISbkCVnKXFUaDIs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=M+Mnnx4o/07UZ9CiUibS7tErHvT+kj/wxzkGPY4bhMKioUGEk+3H530+vYt+cXiggo
         /tmta+6Uj5uQr3ViiB2/dwkEvIUt7ZwgWo6MxtpSU+Cz6+LEailaalrtxOM0Y18SWEs0
         qMmOHxs8kjmKHRpTwcv2jyRtnmx3JM9y0UFSU=
Received: by 10.90.80.18 with SMTP id d18mr60093agb.36.1237507315971; Thu, 19 
	Mar 2009 17:01:55 -0700 (PDT)
In-Reply-To: <20090319180216.GT23521@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113867>

On Thu, Mar 19, 2009 at 11:02 AM, Shawn O. Pearce <spearce@spearce.org>=
 wrote:
> skillzero@gmail.com wrote:
>> The documentation for git clone says that if you use --depth=3D1 to =
make
>> a shallow clone that you can't push it. But I made a shallow clone,
>> created a tag, then tried to push that tag and it worked. Am I just
>> getting lucky or is it safe to push a tag with a shallow clone?
>
> Yea, you are getting lucky. =C2=A0The tag is easily identified as one
> object head of the current branch on the remote, and the client is
> able to produce the pack and send it.
>
> If the remote branch gets modified in the interm, the builder may
> not be able to deduce what it needs to send, and will attempt to
> pack a lot more data, potentially finding the missing parents from
> where it is shallow.
>
> Why not just have a central area on the build server that keeps
> full clones of everything, and use "git clone -s" or "git clone
> --reference" in order to create the new work area for the builder?

Thanks for the info. As for using --reference, one of the things that
the builder does is archive the build in its entirety so it can be
reproduced later on a different machine. I'll probably just need to
use a full clone (or do some kind of stripping after the build
succeeds and before it archives).
