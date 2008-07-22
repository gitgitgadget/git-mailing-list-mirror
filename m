From: Stephan Beyer <s-beyer@gmx.net>
Subject: Re: [PATCH] rebase -i: only automatically amend commit if HEAD did
	not change
Date: Tue, 22 Jul 2008 23:48:58 +0200
Message-ID: <20080722214858.GC5904@leksak.fem-net>
References: <alpine.DEB.1.00.0807222235520.8986@racer>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Jul 22 23:50:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KLPkG-0003nv-4i
	for gcvg-git-2@gmane.org; Tue, 22 Jul 2008 23:50:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751571AbYGVVtF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Jul 2008 17:49:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751329AbYGVVtE
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Jul 2008 17:49:04 -0400
Received: from mail.gmx.net ([213.165.64.20]:33139 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751404AbYGVVtD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Jul 2008 17:49:03 -0400
Received: (qmail invoked by alias); 22 Jul 2008 21:49:00 -0000
Received: from q137.fem.tu-ilmenau.de (EHLO leksak.fem-net) [141.24.46.137]
  by mail.gmx.net (mp048) with SMTP; 22 Jul 2008 23:49:00 +0200
X-Authenticated: #1499303
X-Provags-ID: V01U2FsdGVkX1+cpeZxG6GceZR8pcotIlNbQaoOxfxB+5Djl9z9co
	rAvt6Qe9sX23vU
Received: from sbeyer by leksak.fem-net with local (Exim 4.69)
	(envelope-from <s-beyer@gmx.net>)
	id 1KLPj8-0007te-3t; Tue, 22 Jul 2008 23:48:58 +0200
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807222235520.8986@racer>
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.64
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89548>

Hi,

Johannes Schindelin wrote:
> If the user called "rebase -i", marked a commit as "edit", "rebase
> --continue" would automatically amend the commit when there were
> staged changes.
> 
> However, this is actively wrong when the current commit is not the
> one marked with "edit".  So guard against this.

Hmm, I like it. ;-)

> @@ -419,7 +419,9 @@ do
>  		else
>  			. "$DOTEST"/author-script ||
>  				die "Cannot find the author identity"
> -			if test -f "$DOTEST"/amend
> +			if test -f "$DOTEST"/amend &&
> +				test $(git rev-parse HEAD) = \
> +					$(cat "$DOTEST"/amend)
>  			then
>  				git reset --soft HEAD^ ||
>  				die "Cannot rewind the HEAD"

So if this fails, a non-amending commit is done.  Agreed. :)

Regards,
  Stephan

-- 
Stephan Beyer <s-beyer@gmx.net>, PGP 0x6EDDD207FCC5040F
