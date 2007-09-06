From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: [PATCH 1/3] git-gui/Makefile: Replace libdir with gitgui_libdir
Date: Wed, 5 Sep 2007 22:32:27 -0400
Message-ID: <20070906023227.GH18160@spearce.org>
References: <20070905232153.GA331@nomad.office.altlinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: "Dmitry V. Levin" <ldv@altlinux.org>
X-From: git-owner@vger.kernel.org Thu Sep 06 04:32:41 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT7Ac-0000Qq-PM
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 04:32:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756698AbXIFCcd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 22:32:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756817AbXIFCcd
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 22:32:33 -0400
Received: from corvette.plexpod.net ([64.38.20.226]:35890 "EHLO
	corvette.plexpod.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755689AbXIFCcc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 22:32:32 -0400
Received: from [74.70.48.173] (helo=asimov.home.spearce.org)
	by corvette.plexpod.net with esmtpa (Exim 4.66)
	(envelope-from <spearce@spearce.org>)
	id 1IT7AI-00068n-5r; Wed, 05 Sep 2007 22:32:18 -0400
Received: by asimov.home.spearce.org (Postfix, from userid 1000)
	id 3FC7120FBAE; Wed,  5 Sep 2007 22:32:28 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <20070905232153.GA331@nomad.office.altlinux.org>
User-Agent: Mutt/1.5.11
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - corvette.plexpod.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - spearce.org
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57802>

"Dmitry V. Levin" <ldv@altlinux.org> wrote:
> On GNU/Linux, libdir is used to mean "/usr/lib or /usr/lib64"
> depending on architecture.  Different libdir meaning breaks
> idiomatic expressions like rpm specfile "make libdir=%_libdir".
> 
> Signed-off-by: Dmitry V. Levin <ldv@altlinux.org>
> ---
>  git-gui/Makefile |   16 ++++++++--------
>  1 files changed, 8 insertions(+), 8 deletions(-)

Although I could apply this with `am -3` I'm NACK'ing this right
now because...
 
> diff --git a/git-gui/Makefile b/git-gui/Makefile
> index 1bac6fe..f143b2c 100644
> --- a/git-gui/Makefile
> +++ b/git-gui/Makefile
> @@ -76,8 +76,8 @@ SHELL_PATH_SQ = $(subst ','\'',$(SHELL_PATH))
>  TCL_PATH_SQ = $(subst ','\'',$(TCL_PATH))
>  TCLTK_PATH_SQ = $(subst ','\'',$(TCLTK_PATH))
>  
> -libdir   ?= $(sharedir)/git-gui/lib
> -libdir_SQ = $(subst ','\'',$(libdir))
> +gitgui_libdir   ?= $(sharedir)/git-gui/lib
> +gitgui_libdir_SQ = $(subst ','\'',$(gitgui_libdir))

git-gui is its own project with its own Makefile.  Junio includes
it in git.git to help widen its audience, and because it is quite
portable and easy for him to include.   In the future git-gui will
become a proper subproject of git.git.

If you want to define libdir in git's toplevel Makefile *and*
that definition is being exported down into git-gui's Makefile
then I think git's toplevel Makefile should arrange for it to
not export libdir down into git-gui.

Of course one has to wonder if that is even possible in GNU make.
I'm not a GNU make expert so I don't really know.

-- 
Shawn.
