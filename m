From: Stephen Bash <bash@genarts.com>
Subject: Re: Workflow Recommendation - Probably your 1000th
Date: Thu, 01 Dec 2011 13:55:03 -0500 (EST)
Message-ID: <363b3901-eee6-4265-adae-267f4662a1f7@mail>
References: <CAEbKVFSXn3we7Btb3fN5DUW7BMub_ZrBeUwLUZrRFTmESoW97A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: bradford <fingermark@gmail.com>
X-From: git-owner@vger.kernel.org Thu Dec 01 19:55:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RWBnF-0000cj-BV
	for gcvg-git-2@lo.gmane.org; Thu, 01 Dec 2011 19:55:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755995Ab1LASzJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Dec 2011 13:55:09 -0500
Received: from hq.genarts.com ([173.9.65.1]:63611 "HELO mail.hq.genarts.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755728Ab1LASzH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 1 Dec 2011 13:55:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 4D5DEBE7AA2;
	Thu,  1 Dec 2011 13:55:09 -0500 (EST)
X-Virus-Scanned: amavisd-new at mail.hq.genarts.com
Received: from mail.hq.genarts.com ([127.0.0.1])
	by localhost (mail.hq.genarts.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id zBmoP4g4l17x; Thu,  1 Dec 2011 13:55:03 -0500 (EST)
Received: from mail.hq.genarts.com (localhost [127.0.0.1])
	by mail.hq.genarts.com (Postfix) with ESMTP id 133F9BE7AE4;
	Thu,  1 Dec 2011 13:55:03 -0500 (EST)
In-Reply-To: <CAEbKVFSXn3we7Btb3fN5DUW7BMub_ZrBeUwLUZrRFTmESoW97A@mail.gmail.com>
X-Mailer: Zimbra 7.1.3_GA_3346 (ZimbraWebClient - GC15 (Mac)/7.1.3_GA_3346)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186185>

----- Original Message -----
> From: "bradford" <fingermark@gmail.com>
> To: git@vger.kernel.org
> Sent: Thursday, December 1, 2011 1:26:10 PM
> Subject: Workflow Recommendation - Probably your 1000th
> 
> You guys probably receive a ton of workflow related questions.  I'm
> trying to convert from svn to git.  In order to complete, I would
> like to be able to provide a workflow to our team.  We typically go 
> from dev -> qa -> production (Java and Rails projects).  The problem 
> is that sometimes QA can get backed up and we'll need to release
> something to production while QA is doing their thing.  What is a
> good workflow?  I would like to not use git-flow, because it's another
> tool.  

Hey wow...  I read that Driessen's workflow post [1] a long time ago, but hadn't run into the git-flow tools until a few days ago.  Guess I was just oblivious...  Anyway, if it's any consolation, my company runs a model very much inspired by Driessen's post without using git-flow itself.

[1] http://nvie.com/posts/a-successful-git-branching-model/

> I've read suggestions to use environment branches (master,
> staging, production).  I've also read not to do this and just use
> master, tagging your production releases.  How well would our setup,
> where things can get backed up, work with the latter?  Are there any
> alternative suggestions?

In our workflow we flip Driessen's model on its head.  master is the newest code, while we branch off maintenance branches just before each release.  We tag each release so it's easy to identify which versions in the field contain a given bug or fix (multiple minor versions come off a single maintenance branch).  Our QA guys follow the maintenance branches (they're relatively stable).  We recently had to do a hot-fix release which I think would be similar to your "release to production".  Basically we found the last commit on the maintenance branch that was well tested, created a new branch from there, did the hot fix, QA did some real fast testing (sounds like you'd skip this step), and we shipped that.  As always that hot-fix release gets tagged, so in the future we can still reference t
 hat particular build (and in this case the branch merged back into the maintenance branch -- we've had other situations where the branch was simply deleted after tagging).

In the grand scheme of things our model isn't that different than Driessen's; we just name the branches differently.  Commits go on the oldest branch that's safe for them, and then everything merges to the newer branches.  Tags provide easy reference for where on a given branch a release came from.

Hope that helps.

Stephen
