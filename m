From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git-submodule: Remove duplicate entries during merge
 with conflict
Date: Fri, 15 Jul 2011 21:27:48 +0200
Message-ID: <4E2094B4.3090009@web.de>
References: <4D81C1AA.5010008@morey-chaisemartin.com> <1310668419989-6584432.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: funeeldy <Marlene_Cote@affirmednetworks.com>
X-From: git-owner@vger.kernel.org Fri Jul 15 21:28:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qho3K-0001Hg-7y
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 21:27:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754216Ab1GOT1x (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 15 Jul 2011 15:27:53 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:38736 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753844Ab1GOT1x (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Jul 2011 15:27:53 -0400
Received: from smtp04.web.de  ( [172.20.0.225])
	by fmmailgate01.web.de (Postfix) with ESMTP id 60101193C00DA;
	Fri, 15 Jul 2011 21:27:51 +0200 (CEST)
Received: from [93.240.112.253] (helo=[192.168.178.43])
	by smtp04.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Qho3D-0006JV-00; Fri, 15 Jul 2011 21:27:51 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <1310668419989-6584432.post@n2.nabble.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX190NCVeCKCJpldHNypfPNsYaxEmPkxUdi/qX8Ud
	cLz0ZwWcZ2vqBF1MftVqghaSXpDdOo9bQlQBvv5Xs/JEylQga+
	g+b8gG3NfLPUfV89NFuQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177215>

Am 14.07.2011 20:33, schrieb funeeldy:
> How can new users of git submodules learn about merge conflicts?  When and
> why they occur, and how to resolve them in a way that doesn't lose commits?  

That is pretty similar to merge conflicts in regular files: They happen
when you merge two branches where both sides changed the recorded submodule
commit to another one (and those are not the same). The resolution can be
done by finding a submodule commit that has both changes. In most cases that
will be based on a merge (maybe even a fast forward) with both commits in
its history.

If git finds a fast forward from the merge base to commit1 and commit2
(let's say they both are on master and newer than the merge base), the
newer one is picked automatically. If git finds a single merge from which
both commits are reachable, it proposes that as conflict resolution and
tells you  how you can stage that. Only if it doesn't find any or more
than two merges, you are on your own and have to resolve the conflict
manually by finding an appropriate commit.

> If I have to choose my version or their version, that isn't really a merge,
> or is it?

It would be if the merge strategy is "ours" or "theirs". But in most normal
cases you would want to have both commits reachable from the merge result.
