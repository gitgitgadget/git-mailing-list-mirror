From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] read-tree: at least one tree-ish argument is required
Date: Fri, 18 Dec 2009 20:04:25 +0100
Organization: Viscovery Software GmbH
Message-ID: <200912182004.25520.j.sixt@viscovery.net>
References: <4B274BDE.8000504@viscovery.net> <4B2B5085.1050906@viscovery.net> <7v4onoywws.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Dec 18 20:05:23 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NLi8d-00052l-Ia
	for gcvg-git-2@lo.gmane.org; Fri, 18 Dec 2009 20:05:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755350AbZLRTFG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Dec 2009 14:05:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754522AbZLRTFF
	(ORCPT <rfc822;git-outgoing>); Fri, 18 Dec 2009 14:05:05 -0500
Received: from bsmtp1.bon.at ([213.33.87.15]:15597 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753261AbZLRTFB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Dec 2009 14:05:01 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 2C431CDF8E;
	Fri, 18 Dec 2009 20:04:55 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id CB8F919F5F0;
	Fri, 18 Dec 2009 20:04:25 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <7v4onoywws.fsf@alter.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135428>

On Freitag, 18. Dezember 2009, Junio C Hamano wrote:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> > You have queued 1/2 (filter-branch: remove an unnecessary use of
> > 'git read-tree') of this 2-patch series, but I haven't seen any comments
> > about this 2/2 nor is it queued. Did it fall through the cracks?
>
> No.  I think saying "is not allowed" is going a bit too far [*1*].

Yes, you said that, but in response to the footnote in 1/2.

> The 
> documentation does not list it as a commonly useful thing, that's all.

IMO, not only is it not useful, but it is also dangerous - it erases the 
index!

> When a user wants to have an empty index, and does not want to touch files
> under $GIT_DIR with any non-git tools (e.g. "rm -f $GIT_DIR/index) for
> some religious reasons, "read-tree" without a tree would be one valid way
> to do so [*2*].
> *2* I suspect "rm --cached ." might be another, but it would probably be
> much more expensive.

For an operation like this, shouldn't we advocate this alternate instruction 
(which explicitly tells what is wanted) rather than the implicit and 
undocumented operation of parameter-less read-tree?

> We need to make arguments like "'read-tree' given by mistake to empty the
> index is risky", "'read-tree' as 'rm -f $GIT_DIR/index' replacement has
> little value", and "'read-tree' as 'rm -f $GIT_DIR/index' replacement is
> the best way to get an empty index" to weigh pros and cons between two
> possible approaches before deciding which way to go, but in a pre-release
> freeze, I wasn't in the mood to be one who is doing the arguments myself.

Sorry to drag you into this discussion, but I felt this change is maint-worthy 
(because the behavior is not only risky, but dangerous).

-- Hannes
