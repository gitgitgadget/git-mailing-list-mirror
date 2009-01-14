From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: git merge and cherry-pick and duplicated commits?
Date: Wed, 14 Jan 2009 08:34:10 +0100
Message-ID: <496D9572.2090303@viscovery.net>
References: <2729632a0901131840v5c7ce0c7l3f87c03caabf68de@mail.gmail.com>	 <5EA96780-EF4C-4B31-9C60-6ABAF21663FA@silverinsanity.com> <2729632a0901132221r746144a1y9628615be1c6ad04@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Wed Jan 14 08:35:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN0Hq-000897-18
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 08:35:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755141AbZANHeO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 02:34:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755040AbZANHeN
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 02:34:13 -0500
Received: from lilzmailso01.liwest.at ([212.33.55.23]:36781 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992AbZANHeM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 02:34:12 -0500
Received: from cm56-163-160.liwest.at ([86.56.163.160] helo=linz.eudaptics.com)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1LN0GQ-0007CF-Ic; Wed, 14 Jan 2009 08:34:10 +0100
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.96])
	by linz.eudaptics.com (Postfix) with ESMTP
	id 54866A865; Wed, 14 Jan 2009 08:34:10 +0100 (CET)
User-Agent: Thunderbird 2.0.0.18 (Windows/20081105)
In-Reply-To: <2729632a0901132221r746144a1y9628615be1c6ad04@mail.gmail.com>
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105596>

skillzero@gmail.com schrieb:
> Is there any way to apply a commit to 2 different branches (which have
> diverged) in a way that git will remember so that when the 2 branches
> merge later, it won't result in duplicate commits? I find that I often
> make changes that days or weeks later find out that some other branch
> needs that change and by then, there have been lots of commits to both
> branches after the commit I want.

Well, the way to do it is "careful planning".

If you have a *slight* suspicion that some change *might* be needed on a
different branch, then:

1. you commit the change on a branch of its own that forks off of the
merge-base of *all* the branches that *might* need it;

2. next, you merge this fix-up branch into the branch where you need it
first, which is very likely your current topic-under-development.

3. Later you can merge the branch into the other branches if you find that
it is really needed.

If you don't have the slight suspicion, then you have to take the
second-best route, namely to cherry-pick the commit onto a branch just
like in 1. above, and continue with 2. and 3. In this case you have the
commit twice, but not more than that.

-- Hannes
