From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] t9400: Add some tests for checkout
Date: Thu, 4 Oct 2007 19:24:05 +0100 (BST)
Message-ID: <Pine.LNX.4.64.0710041921490.4174@racer.site>
References: Pine.LNX.4.64.0710041731550.4174@racer.site
 <1191521625-2597-1-git-send-email-frank@lichtenheld.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <junkio@cox.net>
To: Frank Lichtenheld <frank@lichtenheld.de>
X-From: git-owner@vger.kernel.org Thu Oct 04 20:25:06 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IdVNg-0006gO-Qg
	for gcvg-git-2@gmane.org; Thu, 04 Oct 2007 20:25:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759519AbXJDSYO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Oct 2007 14:24:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761308AbXJDSYN
	(ORCPT <rfc822;git-outgoing>); Thu, 4 Oct 2007 14:24:13 -0400
Received: from mail.gmx.net ([213.165.64.20]:43120 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1759747AbXJDSYH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Oct 2007 14:24:07 -0400
Received: (qmail invoked by alias); 04 Oct 2007 18:24:05 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp051) with SMTP; 04 Oct 2007 20:24:05 +0200
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/0jxESKJr0f002BLRMqlOE5iOuJChLCa78CswE9t
	3l0Sy70CAtIe4W
X-X-Sender: gene099@racer.site
In-Reply-To: <1191521625-2597-1-git-send-email-frank@lichtenheld.de>
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59992>

Hi,

On Thu, 4 Oct 2007, Frank Lichtenheld wrote:

> +# clean up
> +rm -fr cvswork2
> +rm -fr "$SERVERDIR"
> +cd "$WORKDIR" &&
> +git clone -q --local --bare "$WORKDIR/.git" "$SERVERDIR" >/dev/null 2>&1 &&
> +GIT_DIR="$SERVERDIR" git config --bool gitcvs.enabled true &&
> +GIT_DIR="$SERVERDIR" git config gitcvs.logfile "$SERVERDIR/gitcvs.log" ||
> +exit 1

Should this not be in a test_expect_success, too?

> -#------------
> -# CVS UPDATE
> -#------------
> +#--------------
> +# CVS CHECKOUT
> +#--------------
> +test_expect_success 'cvs checkout failure (HEAD)' \
> +  'if GIT_CONFIG="$git_config" cvs -Q co -d cvswork2 HEAD >cvs.log 2>&1
> +   then
> +     echo unexpected cvs success
> +     false
> +   else
> +     true
> +   fi &&

How about "! GIT_CONFIG..." instead of the "if..then..else..fi" ?

> +   cat cvs.log | grep -q "not a branch" &&
> +   test ! -d cvswork2'
> +rm -fr cvswork2

Again, for consistency, I'd include this in the test case.

Ciao,
Dscho
