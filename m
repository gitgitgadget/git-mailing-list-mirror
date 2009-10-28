From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: [PATCH] mergetool--lib: add support for p4merge
Date: Wed, 28 Oct 2009 02:21:46 -0700
Message-ID: <76718490910280221u4e1d3e78me7f9b0b45f590e56@mail.gmail.com>
References: <1256721087-72534-1-git-send-email-jaysoffian@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jay Soffian <jaysoffian@gmail.com>,
	David Aguilar <davvid@gmail.com>,
	"Shawn O . Pearce" <spearce@spearce.org>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Scott Chacon <schacon@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 28 10:21:55 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N34j4-0002Nu-0Q
	for gcvg-git-2@lo.gmane.org; Wed, 28 Oct 2009 10:21:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753382AbZJ1JVn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 28 Oct 2009 05:21:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753226AbZJ1JVn
	(ORCPT <rfc822;git-outgoing>); Wed, 28 Oct 2009 05:21:43 -0400
Received: from mail-iw0-f180.google.com ([209.85.223.180]:38179 "EHLO
	mail-iw0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753028AbZJ1JVm (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 28 Oct 2009 05:21:42 -0400
Received: by iwn10 with SMTP id 10so446511iwn.4
        for <git@vger.kernel.org>; Wed, 28 Oct 2009 02:21:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=WYPHvUCwis/qUVukjTmhHP3RLItG7f+y4BDlG3juEks=;
        b=whL+Ou0lt2zUl/jh2/oteBeyGuaXISVWBdFkEMESlHMcJvhqmf2czy2KCtD0eTwJpJ
         S8twAkwxBY0EiJH7RmtZMNTwvp5Kv2qOqAZCfb3iShOBhWK2GVf2Vu4wWAihR8rK4pjo
         TuOgr08/Cx2JmG8OO48I5YXvXGX6oJ9lgw3mg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=GDWR6iaNaZqKqGKqAq7xfetnVsaXX86As2FSLxHDLmJPZwkUtdPtKdK5SWVISPSpla
         YTAyIkWjneCp+eSh5p+32BT0SMVjUzw+4tZw+w52dH4SRAqGJviz79h8NiWJ91JjgCVr
         y+bMmMZNA3qR5aH4E0GqPOLmjS5SPWkpziv14=
Received: by 10.231.3.220 with SMTP id 28mr2885866ibo.40.1256721706805; Wed, 
	28 Oct 2009 02:21:46 -0700 (PDT)
In-Reply-To: <1256721087-72534-1-git-send-email-jaysoffian@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131438>

On Wed, Oct 28, 2009 at 2:11 AM, Jay Soffian <jaysoffian@gmail.com> wrote:
> Add native support for p4merge as a diff / merge tool. There are two
> oddities. First, launching p4merge on Mac OS X requires running a helper
> shim (which in turn is looked for in a couple common locations, as it's
> very unlikely to be in PATH). Second, p4merge seems to require its file
> arguments be absolute paths.
>
> Signed-off-by: Jay Soffian <jaysoffian@gmail.com>
> ---

Amusing. I didn't see Scott's patch.

But, in my testing, for things to work properly I needed to use
launchp4merge per:

http://kb.perforce.com/AllPerforceApplications/StandAloneClients/P4merge/CommandLineP..rgeOnMacOsX

And I also found things didn't work properly unless I provided an absolute path.

(Aside, the "right" way to launch p4merge, at least on 10.6 would be:

/usr/bin/open -b com.perforce.p4merge -W -n --args <args to p4merge...>

This way OS X's launch services would find p4merge.app wherever it is
on the user's system. But, I think some of these options to open are
10.6 specific and in practice looking in /Applications and
$HOME/Applications I think is a sane enough default.)

j.
