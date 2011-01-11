From: =?utf-8?B?0JDQu9C10LrRgdC10Lkg0KjRg9C80LrQuNC9?= <zapped@mail.ru>
Subject: Re[2]: Merge two different repositories (v2.4 + v2.5) into the one (v2.4 -> v2.5). Possible?
Date: Tue, 11 Jan 2011 15:33:29 +0300
Message-ID: <76067992.20110111153329@mail.ru>
References: <746745466.20110111134101@mail.ru> <20110111114943.40890@gmx.net>
Reply-To: =?utf-8?B?0JDQu9C10LrRgdC10Lkg0KjRg9C80LrQuNC9?= <zapped@mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: =?utf-8?Q?=22Martin_Kr=C3=BCger=22?= <martin.krueger@gmx.com>
X-From: git-owner@vger.kernel.org Tue Jan 11 13:33:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PcdPs-0006Jk-GZ
	for gcvg-git-2@lo.gmane.org; Tue, 11 Jan 2011 13:33:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754139Ab1AKMdd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Jan 2011 07:33:33 -0500
Received: from smtp5.mail.ru ([94.100.176.132]:48872 "EHLO smtp5.mail.ru"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753663Ab1AKMdb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Jan 2011 07:33:31 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mail.ru; s=mail;
	h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Subject:CC:To:Message-ID:Reply-To:From:Date; bh=k2OEGSAM4H86pf6TJZdyrPRAgbkmhe/3jp6I8ku7Bz4=;
	b=QIVsjyu9SILljHTfLC//aVzUci9PXc2tlWpdEXDIudtxJeI98iWw8pRRz0xEH9XNsQh0KKP7l/H7lhg/CelRsneusJP6JSenecuHLmONfzbCSgKZqryyhCMOlINXA5WJ;
Received: from [85.140.106.43] (port=13473 helo=ppp85-140-106-43.pppoe.mtu-net.ru)
	by smtp5.mail.ru with asmtp 
	id 1PcdPl-0006EF-00; Tue, 11 Jan 2011 15:33:30 +0300
X-Mailer: The Bat! (v3.99.3) Professional
X-Priority: 3 (Normal)
In-Reply-To: <20110111114943.40890@gmx.net>
X-Mras: Ok
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164933>

Thank you for the answer, but it's not what I want ))
Applying patches is the same as rebasing, I guess.
But I do not want to change v2.5-repo (let's call it so) that much.
I'd like to know is there any method (low-level I suppose, as far as Git
manages tree-objects as files) to make v2.4 LAST commit to be the
parent of v2.5 FIRST commit?

MK> It's possible with a little arts an crafts.
MK> You have 2 friends:  git format-patch & git am .
MK> With "git format-patch" you  will see what a branch really is:
MK> a serie of patches.  With "git am"  you can apply these patches
MK> to a branch created on the correct point of the commit-history . E
MK> voila the branch is recreated in the repository.

MK> In your case:

MK> On the 2.5 repository master branch:
MK> git format-patch  INITIAL_COMMITID

MK> On the 2.4 repository master branch:
MK> git branch 2.5
MK> git checkout 2.4
MK> git reset --hard  INITIAL_COMMITID 
MK> cat *.patch | git am

MK> E voila you habe both branches in a single repository.

MK> Nearly  same procedure for every  branch of the  2.5 repository
MK> git checkout branchname 
MK> git format-patch master

MK> In the 2.4(Contains now both branches.) respository:
MK> git checkout 2.5
MK> git branch branchname
MK> git reset --hard CORRECT_BRANCHBASE
MK> cat *.patch | git am
