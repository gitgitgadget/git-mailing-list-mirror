From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [Support] Branch pointer does not move
Date: Tue, 15 Mar 2011 16:27:42 +0100
Message-ID: <4D7F856E.2030005@drmicha.warpmail.net>
References: <op.vsb4lif0bl4hj1@metalltrottel.fritz.box> <AANLkTik5MGyw_6vnT8055Yap3Ca1pDQYpJ_RXiZQbwA4@mail.gmail.com> <op.vsb95dilbl4hj1@metalltrottel.fritz.box> <AANLkTimW+01wriSjvEVEyQ8SE5RPxhGv_o2Rus9kw6ZQ@mail.gmail.com> <op.vscae5mbbl4hj1@metalltrottel.fritz.box> <4D7E38C6.4010804@drmicha.warpmail.net> <op.vsccqtbobl4hj1@metalltrottel.fritz.box> <4D7E4277.8040202@drmicha.warpmail.net> <op.vscd3mnbbl4hj1@metalltrottel.fritz.box>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: Sverre Rabbelier <srabbelier@gmail.com>, git@vger.kernel.org
To: Franz Liedke <franz@develophp.org>
X-From: git-owner@vger.kernel.org Tue Mar 15 16:27:55 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzWA5-0002yx-TO
	for gcvg-git-2@lo.gmane.org; Tue, 15 Mar 2011 16:27:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758035Ab1COP1q (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 11:27:46 -0400
Received: from out5.smtp.messagingengine.com ([66.111.4.29]:50125 "EHLO
	out5.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757953Ab1COP1p (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 15 Mar 2011 11:27:45 -0400
Received: from compute3.internal (compute3.nyi.mail.srv.osa [10.202.2.43])
	by gateway1.messagingengine.com (Postfix) with ESMTP id 3580020A1C;
	Tue, 15 Mar 2011 11:27:44 -0400 (EDT)
Received: from frontend2.messagingengine.com ([10.202.2.161])
  by compute3.internal (MEProxy); Tue, 15 Mar 2011 11:27:44 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=messagingengine.com; h=message-id:date:from:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding; s=smtpout; bh=fBOyZI/NUuNFyt1VqWxaKMXqh8M=; b=es2ezZRS1O/1PQhdgTId2nHXA90r55VjJCHt+HSUM/mJs8byuXgHH6OkDPeskxSxpcQGvAMIXy/fhhqpp6wOVAxyK1WQ8ZqCuaoPoDkNvO/qEfqVN2BIP4XQ5T1PKRN8fyJSvoMRzgG/mDztoW5BQHbBJt90g9d6FWFYrzMTBTo=
X-Sasl-enc: uIZSm30iI3kjB0fSWahC4RDkF9N8t2cDawpRhw/q2mEG 1300202863
Received: from localhost.localdomain (p54859037.dip0.t-ipconnect.de [84.133.144.55])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 3D50E44AB7D;
	Tue, 15 Mar 2011 11:27:43 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.15) Gecko/20110305 Remi/fc14 Lightning/1.0b3pre Thunderbird/3.1.9
In-Reply-To: <op.vscd3mnbbl4hj1@metalltrottel.fritz.box>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169074>

Franz Liedke venit, vidit, dixit 14.03.2011 17:44:
> On Mon, 14 Mar 2011 17:29:43 +0100, Michael J Gruber  
> <git@drmicha.warpmail.net> wrote:
> 
>> I don't know how smartgit reacts when you switch the branch in git while
>> smartgit is running, for example.
>>
> That works just fine. SmartGit does really well when it comes to  
> refreshing.
> 
>>> I ran some sort of cleanup tool yesterday, possibly about the time when
>>> the problem started (I only noticed it today). Something along the lines
>>> of 'git gc' maybe, if I remember correctly. Could that be the cause?
>>
>> git gc does not do any evil as long as you're not accessing the repo
>> with another client at the same time.
> Ah, there we go. I was.
> 
>> So, have you lost any commits? Maybe something like
>>
>> git log --graph --abbrev-commit --pretty=oneline --decorate --all
>>
>> will give you a clearer picture of where your commits went. If they're
>> not there then inspecting the reflog of HEAD may help:
>>
>> git log -g --abbrev-commit --pretty=oneline --decorate HEAD
> No, I did not lose anything. Commits were added to the log correctly, but  
> the branch pointer stayed where it was.
> 
> I've appended the output of the second command below. Is it correct that  
> the branch name appears in front of every commit in that branch

No, I'm afraid I've confused you with the "--decorate" option. It means
that every sha1 in the log or reflog is "decorated" with a refname
(branch, tag) if its current (!) value matches the sha1.

In the reflog of HEAD (git log -g HEAD), you see the current branch only
by keeping track of the "checkout: moving from x to y" messages.

You can also look at the reflog of branches, of course. There you see
branchname@{n} for the nth prior value of that branch.

(Also note that the most current values come first.)

> ("168-...", down to the one where the problem started, actually; that's  
> where it stops displaying the name)?

You've done a lot of resetting. Which commit is the problem - e1dcbf6?

You have to read my following comments backwards (just like the reflog):

> 
> ---
> 
> d07b4b6 (HEAD, lie2815/fluxbb-1.4, fluxbb-1.4) HEAD@{0}: commit: #168: Fix  
> query bug and don't display buttons when we don't show any results?
Commit on fluxbb-1.4

> 57d8f07 HEAD@{1}: checkout: moving from 168-users-mass-edit to fluxbb-1.4
Switch to fluxbb-1.4

> e5b0b91 (168-users-mass-edit) HEAD@{2}: HEAD^ --: updating HEAD
> 099c040 HEAD@{3}: commit: Test
More testing and resetting

> e5b0b91 (168-users-mass-edit) HEAD@{4}: checkout: moving from fluxbb-1.4  
> to 168-users-mass-edit
Switch to branch 168...

> 57d8f07 HEAD@{5}: commit (amend): #168: Merge commits that were ignored in  
> previous commits. Mainly related to moving users to different groups.
Amend previous commit on master

> f27510a HEAD@{6}: commit: #168: Merge commits that were ignored in  
> previous merge.
Commit on master

> e1dcbf6 HEAD@{7}: checkout: moving from master to fluxbb-1.4
Switch to fluxbb-1.4

> be38cd6 (master) HEAD@{8}: checkout: moving from 168-users-mass-edit to  
> master
Switch to master

> e5b0b91 (168-users-mass-edit) HEAD@{9}: HEAD^ --: updating HEAD
> 327259b HEAD@{10}: commit: test
> e5b0b91 (168-users-mass-edit) HEAD@{11}: HEAD^ --: updating HEAD
> 7137c68 HEAD@{12}: commit: test
More of the same experimenting.

> e5b0b91 (168-users-mass-edit) HEAD@{13}: HEAD^ --: updating HEAD
Reset branch 168... to previous commit.

> 70169b6 HEAD@{14}: commit: Foobar test commit.
Commit on branch 168...

> e5b0b91 (168-users-mass-edit) HEAD@{15}: checkout: moving from fluxbb-1.4  
> to 168-users-mass-edit
Switch to branch 168...

> e1dcbf6 HEAD@{16}: commit: #168: Add batch actions for banning, deleting  
> and moving users to the admin users page.
Commit on fluxbb-1.4

> 1587022 (origin/fluxbb-1.4) HEAD@{17}: merge origin/fluxbb-1.4:  
> Fast-forward
You merged origin/fluxbb-1.4 with a fast-forward.

> 7c4b93b HEAD@{18}: checkout: moving from 168-users-mass-edit to fluxbb-1.4
The above moved you to fluxbb-1.4

> e5b0b91 (168-users-mass-edit) HEAD@{19}: commit: Change form markup. #168
> 15186ad HEAD@{20}: commit: #168: Implement moving users to another group.
> 02a4541 HEAD@{21}: commit: Don't allow moderators to mass ban other  
> moderators. #168. Related to #343.
> ccb44c8 HEAD@{22}: checkout: moving from fluxbb-1.4 to 168-users-mass-edit
> 7c4b93b HEAD@{23}: rebase: #343: Moderators could ban other moderators.
> e313ed0 HEAD@{24}: checkout: moving from fluxbb-1.4 to  
> e313ed0a936071a6abe7efcabcd79f6de295822e^0
> 5980b56 HEAD@{25}: commit: #343: Moderators could ban other moderators.
> d9824a9 HEAD@{26}: checkout: moving from 168-users-mass-edit to fluxbb-1.4
> ccb44c8 HEAD@{27}: commit (amend): Add button for changing user group. #168
> ccbdebd HEAD@{28}: commit: Add button for changing user group. #168
> 731a790 HEAD@{29}: commit: Display admin menu on user deletion  
> confirmation page, too. #168
> a494a13 HEAD@{30}: HEAD^ --: updating HEAD
> ac9bdf9 HEAD@{31}: commit: Display admin menu on user deletion  
> confirmation page, too. #168
> a494a13 HEAD@{32}: HEAD^ --: updating HEAD
> d73a7b3 HEAD@{33}: commit: Display admin menu on user deletion  
> confirmation page, too. #168
> a494a13 HEAD@{34}: HEAD^ --: updating HEAD
> c99c40c HEAD@{35}: commit: foobarba
> a494a13 HEAD@{36}: HEAD^ --: updating HEAD
> 6345b66 HEAD@{37}: commit: foobarba
> a494a13 HEAD@{38}: commit (amend): Implement banning of multiple users.  
> #168
> 7bea1d7 HEAD@{39}: commit: Implement banning of multiple users. #168
> d4cd3f9 HEAD@{40}: HEAD^ --: updating HEAD
> 9de9d8f HEAD@{41}: commit: Implement banning of multiple users. #168
> d4cd3f9 HEAD@{42}: HEAD^ --: updating HEAD
> 54eb388 HEAD@{43}: commit (amend): Implement banning of multiple users.  
> #168
> 29f8471 HEAD@{44}: commit: Implement banning of multiple users. #168
> d4cd3f9 HEAD@{45}: commit: Only show checkboxes and action buttons on  
> admin users list when permissions are sufficient. #168.
> 7560b75 HEAD@{46}: commit: More logical check for valid user IDs when  
> deleting users. #168.
> 9f73b8d HEAD@{47}: commit: Switch order of action buttons and "select all"  
> link in admin users page. #168
> 891c4fe HEAD@{48}: checkout: moving from fluxbb-1.4 to 168-users-mass-edit
> d9824a9 HEAD@{49}: checkout: moving from fluxbb-1.2 to fluxbb-1.4
> f233870 (origin/fluxbb-1.2, lie2815/fluxbb-1.2, fluxbb-1.2) HEAD@{50}:  
> commit: #240: Fix authentication cookie being set incorrectly in some  
> cases.
> 0a71ae9 (tag: fluxbb-1.2.23) HEAD@{51}: checkout: moving from  
> 168-users-mass-edit to fluxbb-1.2
> 891c4fe HEAD@{52}: commit: Move JavaScript code to a file common.js and  
> only use one link for toggling checkboxes.
> e9349be HEAD@{53}: checkout: moving from fluxbb-1.4 to 168-users-mass-edit
> d9824a9 HEAD@{54}: HEAD^ --: updating HEAD
> f39af9d HEAD@{55}: commit: #294: Limit size of tracking cookie so that  
> there is some more space in nginx.
> d9824a9 HEAD@{56}: commit: #330: Fix my feed fix. XML-namespace-related.
> 2b470b6 HEAD@{57}: commit: #331: Fix hard-coded language entry on admin  
> reports page.
> e0fa124 HEAD@{58}: commit: Enhance RSS feeds by adding atom:link with  
> rel="self".
> 5abbbfc HEAD@{59}: checkout: moving from master to fluxbb-1.4
> be38cd6 (master) HEAD@{60}: checkout: moving from fluxbb-2.0 to master
> 20b0441 (origin/fluxbb-2.0, lie2815/fluxbb-2.0, fluxbb-2.0) HEAD@{61}:  
> checkout: moving from 168-users-mass-edit to fluxbb-2.0
> e9349be HEAD@{62}: commit: Implement mass deletion of users. #168.
> 1dff30b HEAD@{63}: checkout: moving from master to 168-users-mass-edit
> be38cd6 (master) HEAD@{64}: merge origin/master: Fast-forward
> f813ef5 HEAD@{65}: checkout: moving from 168-users-mass-edit to master
> 1dff30b HEAD@{66}: commit: Add JavaScript code for selecting / unselecting  
> multiple checkboxes.
> 4acd8f8 HEAD@{67}: checkout: moving from master to 168-users-mass-edit
> f813ef5 HEAD@{68}: pull origin master: Fast-forward
> d55266d HEAD@{69}: checkout: moving from 168-users-mass-edit to master
> 4acd8f8 HEAD@{70}: checkout: moving from master to 168-users-mass-edit
> d55266d HEAD@{71}: commit: #272: Add new language string to install.php  
> for default name of Guests group
> 4291ae6 HEAD@{72}: pull origin master: Fast-forward
> 28d33cf HEAD@{73}: commit: Change breadcrumbs text in search results  
> depending on whether we're searching for posts or topics.
> 1bef6cc HEAD@{74}: commit: #274: Fix usernames in breadcrumbs being  
> converted to lower-case when searching for posts by author name.
> 971f14e HEAD@{75}: commit: #257: Apply my last commit to edit.php, too.
> ---
> 
> Thanks for your help again
> Franz
> 
