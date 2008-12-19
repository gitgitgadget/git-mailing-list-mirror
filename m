From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge
 commit.
Date: Fri, 19 Dec 2008 03:57:57 +0100 (CET)
Message-ID: <alpine.DEB.1.00.0812190353520.14632@racer>
References: <200812182039.15169.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Fri Dec 19 04:00:12 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDVb2-00076o-BQ
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 04:00:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752214AbYLSC6y (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 21:58:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751955AbYLSC6y
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 21:58:54 -0500
Received: from mail.gmx.net ([213.165.64.20]:57465 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751480AbYLSC6x (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 21:58:53 -0500
Received: (qmail invoked by alias); 19 Dec 2008 02:58:51 -0000
Received: from pD9EB3AF0.dip0.t-ipconnect.de (EHLO noname) [217.235.58.240]
  by mail.gmx.net (mp047) with SMTP; 19 Dec 2008 03:58:51 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX18M60ofBpMM4xyIAU95w+3XSFVi817A6CAfvg8WeR
	J43rSav/dWXCg7
X-X-Sender: gene099@racer
In-Reply-To: <200812182039.15169.bss@iguanasuicide.net>
User-Agent: Alpine 1.00 (DEB 882 2007-12-20)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.57
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103533>

Hi,

On Thu, 18 Dec 2008, Boyd Stephen Smith Jr. wrote:

> +		do {
> +			switch (action) {
> +			case REVERT:
> +				warning("revert on a merge commit may not do what you expect.");
> +				continue;
> +			case CHERRY_PICK:
> +				/* Cherry picking a merge doesn't merge the history, but
> +				 * I don't think many people expect that.
> +				 */
> +				continue;
> +			}
> +			/* Unhandled enum member. */
> +			die("Unknown action on a merge commit.");
> +		} while (0);
> +

Wow.  That must be one of the, uhm, less beautiful ways to write

		if (action == REVERT)
			warning("revert on a merge commit may not do what you "
				"expect.");
		else if (action != CHERRY_PICK)
			die("Unknown action on a merge commit.");

Besides, I am actually pretty much against this change.  You already have 
to ask very explicitely to revert a merge, by specifying a parent number.  
If I ask for something explicitely, I do not want the tool to tell me that 
it's dangerous.  I know that already, thankyouverymuch.

Ciao,
Dscho
