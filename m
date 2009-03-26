From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: Improve tags
Date: Thu, 26 Mar 2009 17:02:27 +0100
Message-ID: <49CBA713.4040605@drmicha.warpmail.net>
References: <49CB798B.4090107@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Etienne Vallette d'Osia <dohzya@gmail.com>
X-From: git-owner@vger.kernel.org Thu Mar 26 17:04:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lms3r-0004nC-OA
	for gcvg-git-2@gmane.org; Thu, 26 Mar 2009 17:04:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752848AbZCZQCg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Mar 2009 12:02:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752583AbZCZQCg
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Mar 2009 12:02:36 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:48753 "EHLO
	out2.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751675AbZCZQCf (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 26 Mar 2009 12:02:35 -0400
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 838772FE6D5;
	Thu, 26 Mar 2009 12:02:33 -0400 (EDT)
Received: from heartbeat1.messagingengine.com ([10.202.2.160])
  by compute2.internal (MEProxy); Thu, 26 Mar 2009 12:02:33 -0400
X-Sasl-enc: 9gf4Ryh5vDziG04LmAjkfdSM+sgBzj3yNEUAeun1zofZ 1238083352
Received: from localhost.localdomain (p4FC63417.dip0.t-ipconnect.de [79.198.52.23])
	by mail.messagingengine.com (Postfix) with ESMTPSA id 72C09B0AE;
	Thu, 26 Mar 2009 12:02:32 -0400 (EDT)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1b4pre) Gecko/20090326 Lightning/1.0pre Shredder/3.0b3pre
In-Reply-To: <49CB798B.4090107@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114796>

Etienne Vallette d'Osia venit, vidit, dixit 26.03.2009 13:48:
> Hi,
> 
> I search a way to track commits in function of their aim.
> 
> I tried to use branches (test, debugger, etc).
> For example if I search the commits related to tests,
> I can search all commits what are in branch test and not in branch debugger,
> but it's boring (I need to exclude all other branches than test)
> Moreover, if I remove a branch, it will complicate the search.
> 
> In addition, branches are a way to specify streams,
> not a way to specify an aim for a commit.
> (like in ruby a class is a method container, not a type)
> So branch names are often like next, pu, dev, test, stupid-idea, etc.
> They are totally useless for tracking aims.
> 
> The method used in every repositories I looked into
> is to use the "aim: subject" form in their commit messages.
> So search all commits related to a specific aim is equivalent
> to grep "my-aim:" in commit messages.
> The problem is that this method is not used in all commits
> ("aim - subject" or just "subject" are used too),
> so I can't assume to find all commits with a such method...
> And if a search a more generic form ("test"), I might find
> useless commits that will pollute my results...
> 
> The last method I can find, is to use tags.
> But, as CVS and many others do, tags are unique.
> It is usefull for tagging a software version number,
> but not for tracking.
> 
> So, we have branches, which are not stable,
> tags, which are unique,
> and commit messages, which are not normalized.
> 
> What can we do ?
> 
> In my mind, the good ways are to improve the commit message way,
> or, better, to change the current tag concept.
> 
> One improvement could be to add a mechanism similar to "signed-off-by:"
> message: add an option in git-commit to facilitate the creation of "tags"
> and make sure these "tags" will be normalized...
> example: `git commit -t test,debugger -m "add test for debugger"`
>          this will create a commit and add automatically
>          "test: debugger:" at begin or
>          "tags: test, debugger" at end of the message
>            (like the "signed-off-by: xxx" lines)
> It's not really better this current solution,
> but it's a first step to normalization.
> 
> There is still a big problem with this solution : this tags are immutable,
> as they are stored inside the commit.
> 
> An other improvement would be to create new version of tags.
> `git tag v1.6.3` would create a unique tag, and
> `git tag --no-unique test` would create a simple tag.
> (until we can change the default)
> The -t option of git-commit is still possible,
> but it will call the new git-tag.
> 
> Note: Theses tags may be treated like refs (git log fault-tolerance),
> but they can't be stored in $GIT_DIR/refs directory,
> as they reference a list a commits...
> 
> So, I see 2 solutions:
> - Normalize the way to write tags but keep them into commit message:
>   (-) There will be 2 sorts of tags: static immutable and dynamic unique
>   (+) This way is totally retro-compatible
> - Change the tags concept:
>   (-) Need to change the tag object format (ouch)
>   (+) More powerful
> 
> Maybe I have missed a better tool to do my job ?
> Or there is a better improvement which is more simple ?
> 
> 
> Best regards,
> 
> 
> Etienne Vallette d'Osia
> 
> ps: I'm really sorry if my message is full of English errors...

You described your motivation and use case very clearly!

Maybe "label" would be an appropriate name for "non-unique tags". I
assume they should be local and non-versioned. It sounds as if a file
storing a list of sha1s could be the simplest approach (one file per
label in a new subdir of .git), although this may not scale well. A
first step could be implementing a command "git label" in shell which
sets and displays labels. Later on, various builtins would need to be
taught about it if you want labels displayed in log etc.

Michael
