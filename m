From: tom fogal <tfogal@sci.utah.edu>
Subject: Re: Git branch workflow
Date: Mon, 22 Nov 2010 17:43:22 -0700
Message-ID: <4CEB0E2A.5080304@sci.utah.edu>
References: <20101122170805.8jtzkqwxpcog0kgk@dennymagicsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: denny@dennymagicsite.com
X-From: git-owner@vger.kernel.org Tue Nov 23 01:44:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PKgzd-0004Pt-BO
	for gcvg-git-2@lo.gmane.org; Tue, 23 Nov 2010 01:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932617Ab0KWAoK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Nov 2010 19:44:10 -0500
Received: from mail.sci.utah.edu ([155.98.58.80]:4405 "EHLO sci.utah.edu"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S932612Ab0KWAoJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Nov 2010 19:44:09 -0500
Received: from dummy.name; Mon, 22 Nov 2010 17:44:09 -0700
User-Agent: Mozilla-Thunderbird 2.0.0.24 (X11/20100329)
In-Reply-To: <20101122170805.8jtzkqwxpcog0kgk@dennymagicsite.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/161922>

Hi Dennis,

denny@dennymagicsite.com wrote:
> my website was small enough where I usually fixed everything live on 
> production server, including adding new features, doing bug fixes and so 
> on.
> 
> Now, with git I can create branches in whatever order I want, and then 
> merge them whenever I want and push things to production whenever I want.
> With this, comes confusion of what a good branch workflow is.  And this 
> will be my question -- in what order and from which branches to I create 
> new branches and how do I merge them back.

This is, of course, a matter of opinion.  Despite what I say below, I
would say the best advice with git is: try it!  Experiment with a few
different workflows.  Give each a week or two.  I think you'll find
there are advantages to any approach, but there's one that works best
for *you*.

The nice thing about git is that you don't have to use the workflow that
works for "me" (for generic "me") -- you get to adapt git to fit the
workflow you have, instead of adapting your workflow to fit the git
you've got.

> Consider a specific scenario:
> I am on dev server on master branch and I want to develop a specific 
> feature F.
> I cut a Feature branch F from master and start working on the feature. 
>  Once I am done with most of the work on F and it works reasonably well, 
> I want to push it to production, but .. before I do I realize that I 
> want to make some CSS fixes to the site, unrelated to other branches, 
> and I can wait with pushing Feature branch to Production until I fix up 
> CSS reasonably well.
> Here is the question:  do I cut the CSS branch from Master or do I cut 
> it from the Feature branch?

I would personally base 'css' off of master.  Although with the caveat,
since I just recently did something dumb and lost data <g>, that I would
(now) push 'feature' to some backup repo first.  Not make it live, just
push it somewhere so it's backed up.

My logic is: a) the two things are logically disjoint.  I can always 
decide later that I want to bring them together.  It's much harder to
decide later that I want to pull them apart (though, admittedly, still 
possible); b) pushing to production involves certain risks.  Maybe you 
had a silly PEBKAC and broke some shell script, and now your entire site 
gives 401 errors.  By keeping them separate you can push to production + 
verify each branch separately, which hopefully makes the problem easier 
to figure out should you have a hand-to-forehead moment.

[snip]
> Supplementary questions that may help define a good workflow for my case:
> *  What if later a bug is discovered in the Feature.  If I already 
> merged Feature branch into Master and deleted Feature branch, do I 
> create a FeatureBugFix branch?  Or do I keep the original Feature branch 
> without removing it for a while?  If so, for how long do I keep it?  Do 
> I perhaps keep a general BugFix branch instead that I don't remove?

I don't have a set guide for doing this myself.  I go through and delete 
old branches whenever "git branch" grows so many lines of output that it 
annoys me.  That said, it's extremely rare that I use a branch which has
been merged back to master: instead I make a new bugfix-branch which is 
based off of master (or, more commonly: the release branch).

Cheers && HTH,

-tom
