From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] read-tree: at least one tree-ish argument is required
Date: Fri, 18 Dec 2009 23:04:27 +0100
Organization: Viscovery Software GmbH
Message-ID: <200912182304.27656.j.sixt@viscovery.net>
References: <4B274BDE.8000504@viscovery.net> <fabb9a1e0912181137t1265f86cs9e02019da136a0a@mail.gmail.com> <7veimsvz8a.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 23:05:13 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLkwj-0007Aw-9z
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 23:05:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753222AbZLRWFH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 17:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752245AbZLRWFG
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 17:05:06 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:11709 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751187AbZLRWFF (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 17:05:05 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 01E4D1001B;
	Fri, 18 Dec 2009 23:04:58 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 3E88319F6BC;
	Fri, 18 Dec 2009 23:04:28 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7veimsvz8a.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135443>

On Freitag, 18. Dezember 2009, Junio C Hamano wrote:
> I'll grant you that at least "rm -rf it" names "it" that will be wiped
> very explicitly.  But just like the index and the work tree plus the index
> are the implicit targets to "reset" and "reset --hard" respectively, the
> index is the implicit target to "read-tree".
>
> [...]  You might type
> "commit" when you meant to say "commit -a" and record an incomplete state;
> it is "dangerous" in that sense.
>
> These are part of their feature.

Really? "rm -rf", "reset --hard", "commit -a": yes, RTFM. But "read-tree" (w/o 
arguments): no. There is no such sign in the documentation. Since the 
operation of the latter is dubious at best, I'd rather change the program 
than the documentation.

How about this commit message, then?

Subject: [PATCH] read-tree: at least one tree-ish argument is required

Running read-tree without any arguments purges the index, but this is not
documented. This behavior is dubious at best because contrary to many
other commands, it does not use HEAD if nothing else is specified.

If one really wants to clear the index, this can be achieved with
'git rm --cached .' or 'rm -f .git/index' in a more explicit way.

Signed-off-by: Johannes Sixt <j6t@kdbg.org>
