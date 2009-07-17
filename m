From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] Fix rebase -p --onto
Date: Fri, 17 Jul 2009 08:38:17 +0200
Message-ID: <4A601C59.8040108@viscovery.net>
References: <20090716230031.GM7503@vinegar-pot.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio Hamano <gitster@pobox.com>,
	Stephen Haberman <stephen@exigencecorp.com>
To: Greg Price <price@ksplice.com>
X-From: git-owner@vger.kernel.org Fri Jul 17 08:38:38 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MRh5Y-000786-Ot
	for gcvg-git-2@gmane.org; Fri, 17 Jul 2009 08:38:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934149AbZGQGi2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 17 Jul 2009 02:38:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S934147AbZGQGi2
	(ORCPT <rfc822;git-outgoing>); Fri, 17 Jul 2009 02:38:28 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:37752 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934146AbZGQGi2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 17 Jul 2009 02:38:28 -0400
Received: from cpe228-254.liwest.at ([81.10.228.254] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1MRh5G-00082K-D1; Fri, 17 Jul 2009 08:38:18 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 18C3C6D9; Fri, 17 Jul 2009 08:38:18 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.21 (Windows/20090302)
In-Reply-To: <20090716230031.GM7503@vinegar-pot.mit.edu>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/123443>

Greg Price schrieb:
> In a rebase with --onto, the correct test for whether we can skip
> rewriting a commit is if it is already on top of $ONTO, not $UPSTREAM.
> Without --onto, this distinction does not exist and the behavior does
> not change.
> 
> 
> In the situation
> 
>  X---o---o---o---M
>   \             /
>    x---x---x---x
> 
>  Y
> 
> if we try to move the branches merged at M from their base on X to be
> based on Y, so as to get
> 
>  X
> 
>  Y---o'--o'--o'--M'
>   \             /
>    x'--x'--x'--x'
> 
> then we fail.  The command `git rebase -p --onto Y X M` moves only the
> first-parent chain, like so:
> 
>  X
>   \
>    x---x---x---x
>                 \
>  Y---o'--o'--o'--M'
> 
> because it mistakenly drops the other branch(es) x---x---x---x from
> the TODO file.  This tests and fixes this behavior.

I think the current behavior is by design. There is nothing to fix.

The purpose of rebase -p is to leave non-first children alone and rebase
only the first child parenthood chain. It is not the purpose to reseat an
entire history DAG.

-- Hannes
