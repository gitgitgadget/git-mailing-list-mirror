From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 1/3] rebase -i: handle --continue more like non-interactive
 rebase
Date: Sun, 8 Jul 2007 05:40:53 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707080537490.4093@racer.site>
References: <Pine.LNX.4.64.0707080300440.4093@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Sun Jul 08 06:48:19 2007
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I7Oh0-0008RO-S2
	for gcvg-git@gmane.org; Sun, 08 Jul 2007 06:48:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751315AbXGHEsG (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 8 Jul 2007 00:48:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750814AbXGHEsF
	(ORCPT <rfc822;git-outgoing>); Sun, 8 Jul 2007 00:48:05 -0400
Received: from mail.gmx.net ([213.165.64.20]:48970 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751116AbXGHEsE (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 8 Jul 2007 00:48:04 -0400
Received: (qmail invoked by alias); 08 Jul 2007 04:48:02 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO localhost) [132.187.25.13]
  by mail.gmx.net (mp034) with SMTP; 08 Jul 2007 06:48:02 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19KipIxyVdKlo7++HQ+v1Q90RTiqbz17jlTyY4oRS
	KJnIY6epXrkfNr
X-X-Sender: gene099@racer.site
In-Reply-To: <Pine.LNX.4.64.0707080300440.4093@racer.site>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51861>

Hi,

On Sun, 8 Jul 2007, Johannes Schindelin wrote:

> diff --git a/git-rebase--interactive.sh b/git-rebase--interactive.sh
> index 0c2a969..67f2ee2 100755
> --- a/git-rebase--interactive.sh
> +++ b/git-rebase--interactive.sh
>
> [...]
>
> @@ -265,6 +264,14 @@ do
>  
>  		test -d "$DOTEST" || die "No interactive rebase running"
>  
> +		# commit if necessary
> +		git rev-parse --verify HEAD > /dev/null &&
> +		git update-index --refresh &&
> +		git diff-files --quiet &&
> +		! git diff-index --cached --quiet HEAD &&
> +		. "$DOTEST"/author-script &&
> +		git commit -F "$DOTEST"/message -e
> +

Oh well. For this to work, there has to be a line

		export GIT_AUTHOR_NAME GIT_AUTHOR_NAME GIT_AUTHOR_DATE &&

before the "git commit" line, I think.

Ciao,
Dscho
