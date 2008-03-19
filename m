From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH] rebase [--onto O] A B: omit needless checkout
Date: Wed, 19 Mar 2008 13:54:37 +0100
Message-ID: <47E10D0D.2080702@viscovery.net>
References: <20080312191041.GF3198@ins.uni-bonn.de> <47D8D5B8.70809@viscovery.net> <20080315103954.GD14769@ins.uni-bonn.de> <7vk5k3n2ho.fsf_-_@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 19 21:48:57 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jc5DR-000683-SY
	for gcvg-git-2@gmane.org; Wed, 19 Mar 2008 21:48:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758819AbYCSU1H (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Mar 2008 16:27:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933157AbYCSU1G
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Mar 2008 16:27:06 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:50935 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758665AbYCSU1E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Mar 2008 16:27:04 -0400
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.66)
	(envelope-from <j.sixt@viscovery.net>)
	id 1Jbxnj-0005wu-0w; Wed, 19 Mar 2008 13:53:51 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.42])
	by linz.eudaptics.com (Postfix) with ESMTP
	id A801A6B7; Wed, 19 Mar 2008 13:54:37 +0100 (CET)
User-Agent: Thunderbird 2.0.0.6 (Windows/20070728)
In-Reply-To: <7vk5k3n2ho.fsf_-_@gitster.siamese.dyndns.org>
X-Enigmail-Version: 0.95.5
X-Spam-Score: 1.7 (+)
X-Spam-Report: ALL_TRUSTED=-1.8, BAYES_99=3.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77537>

Junio C Hamano schrieb:
> This teaches "git rebase [--onto O] A B" to omit an unnecessary checkout
> of branch B before it goes on.
> 
> "git-rebase" originally was about rebasing the current branch to somewhere
> else, and when the extra parameter to name which branch to rebase was
> added, it defined the semantics to the safest but stupid "first switch to
> the named branch and then operate exactly the same way as if we were
> already on that branch".
> 
> But the first thing the real part of "rebase" does is to reset the work
> tree and the index to the "onto" commit.  Which means the "rebase that
> branch" form switched the work tree to the tip of the branch only to
> immediately switch again to another commit.  This was wasteful.

This works for a frequent use-case of mine:

  $ git rebase master devel

where I am already on branch master, and now want to rebase devel on top
of it.

The code seems to take care of a lot of corner cases and less frequent
use-cases, including using --onto, which I don't feel able to judge about.

> +# git reset --hard "$onto^0"

Don't forget to remove this line. ;)

-- Hannes
