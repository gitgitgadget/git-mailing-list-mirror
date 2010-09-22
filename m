From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: Really beginner on Version Control
Date: Tue, 21 Sep 2010 23:52:19 -0400
Message-ID: <1AF8A1BC-1E52-4385-A0FC-16A04B4724FF@kellerfarm.com>
References: <1285080133451-5555023.post@n2.nabble.com> <m3mxrak937.fsf@localhost.localdomain> <1285114417273-5557145.post@n2.nabble.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: FernandoBasso <FernandoBasso.br@gmail.com>
X-From: git-owner@vger.kernel.org Wed Sep 22 05:54:36 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OyGPj-0000sT-6L
	for gcvg-git-2@lo.gmane.org; Wed, 22 Sep 2010 05:54:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752352Ab0IVDwY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Sep 2010 23:52:24 -0400
Received: from sanjose.tchmachines.com ([208.76.86.38]:55713 "EHLO
	leia.tchmachines.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751989Ab0IVDwX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 21 Sep 2010 23:52:23 -0400
Received: from c-208-53-115-13.customer.broadstripe.net ([208.53.115.13] helo=[192.168.0.101])
	by leia.tchmachines.com with esmtpsa (TLSv1:AES128-SHA:128)
	(Exim 4.69)
	(envelope-from <andrew@kellerfarm.com>)
	id 1OyGNP-0000uT-3T; Tue, 21 Sep 2010 23:52:11 -0400
In-Reply-To: <1285114417273-5557145.post@n2.nabble.com>
X-Mailer: Apple Mail (2.1081)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - leia.tchmachines.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - kellerfarm.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156780>

On Sep 21, 2010, at 8:13 PM, FernandoBasso wrote:

> I really appreciate your help. All of you. This is all starting to make sense
> to me thanks to you guys.
> 
> Now, what are the possible ways that we can get to a conflict when merging
> branches ? I'm doing some study tests, and some times I get conflicts, some
> times I don't. I couldn't really understand what causes them or not yet. 
> 
> For instance, I have 'hello' in line 2 of site.php in the master branch. I
> go to the  testing branch, edit site.php, change 'hello' for 'world' at the
> same line, commit and got back to master. I merge testing into master and I
> get no conflicts. Shouldn't it conflict ? (site.php in master also contains
> the string 'world' in the place of 'hello' now).

If I am understanding correctly, then this is an example of a fast-forward merge.

It sometimes helps to think of a series of commits as a series of changes, rather than a series of snapshots.  A merge conflict will occur when you *modify* overlapping sections of the same file in each branch.  The key word here is modify.  When you ask git to merge testing into master, you are not asking git to look at the code and figure out which one is "correct".  Instead, you are asking git to take the changes in testing, and the changes in master, each since they diverged, and create a new commit that incorporates both changes.

The only thing is, in your example, since master did not progress since testing diverged, git simply thinks of it as being "behind" testing, so you end up with a fast-forward merge, where master simply acquires the newer commits that testing has.  You can think of it as a special case optimization.  No need to make a merge commit if master is just behind and needs to be caught up.

If you would like to cause a merge conflict, then you should modify the same line of the same file in two different branches, and then try to merge the branches.  This is similar to what you just did, except that both master and testing must progress individually before you merge.

~ Andrew Keller
