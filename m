From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Teach git-commit about commit message templates.
Date: Mon, 23 Jul 2007 11:04:04 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0707231059490.14781@racer.site>
References: <20070723041741.GA22461@midwinter.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Steven Grimm <koreth@midwinter.com>
X-From: git-owner@vger.kernel.org Mon Jul 23 12:04:29 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ICumC-0001g6-SH
	for gcvg-git@gmane.org; Mon, 23 Jul 2007 12:04:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754639AbXGWKEW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 23 Jul 2007 06:04:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752414AbXGWKEW
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Jul 2007 06:04:22 -0400
Received: from mail.gmx.net ([213.165.64.20]:55766 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751233AbXGWKEV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Jul 2007 06:04:21 -0400
Received: (qmail invoked by alias); 23 Jul 2007 10:04:19 -0000
Received: from wbgn013.biozentrum.uni-wuerzburg.de (EHLO openvpn-client) [132.187.25.13]
  by mail.gmx.net (mp038) with SMTP; 23 Jul 2007 12:04:19 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX19NA8tjnlVN/zPLbt3/tLpHmzbI3V6HzgI2ZnB/+c
	eKbYhE6ntWl8rD
X-X-Sender: gene099@racer.site
In-Reply-To: <20070723041741.GA22461@midwinter.com>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/53420>

Hi,

On Sun, 22 Jul 2007, Steven Grimm wrote:

> @@ -572,10 +591,35 @@ else
>  fi |
>  git stripspace >"$GIT_DIR"/COMMIT_MSG
>  
> -if cnt=`grep -v -i '^Signed-off-by' "$GIT_DIR"/COMMIT_MSG |
> -	git stripspace |
> -	wc -l` &&
> -   test 0 -lt $cnt
> +# Test whether the commit message has any content we didn't supply.
> +have_commitmsg=
> +grep -v -i '^Signed-off-by' "$GIT_DIR"/COMMIT_MSG |
> +	git stripspace > "$GIT_DIR"/COMMIT_BAREMSG

Up until here, I was with you.  But this feels very wrong.

Why not compare COMMIT_MSG to the templatefile, if there is one?  I.e.

test ! -z "$templatefile" && cmp "$GIT_DIR"/COMMIT_MSG "$templatefile" &&
	die "Unchanged message; will not commit"

Hmm?

Ciao,
Dscho
