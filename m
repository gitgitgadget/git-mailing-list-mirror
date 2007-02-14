From: Junio C Hamano <junkio@cox.net>
Subject: Re: bug: build from tarball uses git-describe
Date: Tue, 13 Feb 2007 17:04:40 -0800
Message-ID: <7vd54dwnvb.fsf@assigned-by-dhcp.cox.net>
References: <eqtfso$7mo$1@sea.gmane.org>
	<Pine.LNX.4.63.0702140159440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Han-Wen Nienhuys <hanwen@xs4all.nl>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Feb 14 02:04:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HH8Zh-0000a0-0i
	for gcvg-git@gmane.org; Wed, 14 Feb 2007 02:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932116AbXBNBEl (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 13 Feb 2007 20:04:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932120AbXBNBEl
	(ORCPT <rfc822;git-outgoing>); Tue, 13 Feb 2007 20:04:41 -0500
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:35099 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932116AbXBNBEl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 Feb 2007 20:04:41 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070214010440.UEXI21668.fed1rmmtao102.cox.net@fed1rmimpo01.cox.net>;
          Tue, 13 Feb 2007 20:04:40 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id PD4f1W0141kojtg0000000; Tue, 13 Feb 2007 20:04:40 -0500
In-Reply-To: <Pine.LNX.4.63.0702140159440.22628@wbgn013.biozentrum.uni-wuerzburg.de>
	(Johannes Schindelin's message of "Wed, 14 Feb 2007 02:00:31 +0100
	(CET)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39604>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Does this (totally untested) patch help?
>
> --
>
>  GIT-VERSION-GEN |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/GIT-VERSION-GEN b/GIT-VERSION-GEN
> index 7a10b60..e6f89cb 100755
> --- a/GIT-VERSION-GEN
> +++ b/GIT-VERSION-GEN
> @@ -8,7 +8,7 @@ LF='
>  
>  # First try git-describe, then see if there is a version file
>  # (included in release tarballs), then default
> -if VN=$(git describe --abbrev=4 HEAD 2>/dev/null) &&
> +if test -d .git && VN=$(git describe --abbrev=4 HEAD 2>/dev/null) &&
>     case "$VN" in
>     *$LF*) (exit 1) ;;
>     v[0-9]*) : happy ;;

Have you checked what the elif part does in the if statement you
are patching?

After all fresh tarball is how we build rpm packages and we do
not have .git in that build environment, so I am quite puzzled.
