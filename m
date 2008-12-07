From: Grzegorz Kossakowski <grek@tuffmail.com>
Subject: Re: How to clone git repository with git-svn meta-data included?
Date: Sun, 07 Dec 2008 20:08:38 +0100
Message-ID: <493C1F36.7050504@tuffmail.com>
References: <493A6CEC.4060601@tuffmail.com> <eaa105840812070857i27f8e920keaba3f92f5260b38@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Peter Harris <git@peter.is-a-geek.org>
X-From: git-owner@vger.kernel.org Sun Dec 07 20:12:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1L9P2y-00034f-Rn
	for gcvg-git-2@gmane.org; Sun, 07 Dec 2008 20:12:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753994AbYLGTIn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 7 Dec 2008 14:08:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753461AbYLGTIn
	(ORCPT <rfc822;git-outgoing>); Sun, 7 Dec 2008 14:08:43 -0500
Received: from mxout-03.mxes.net ([216.86.168.178]:1824 "EHLO
	mxout-03.mxes.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753209AbYLGTIm (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 7 Dec 2008 14:08:42 -0500
Received: from [192.168.0.125] (unknown [82.210.157.165])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.mxes.net (Postfix) with ESMTP id 41F1A23E3E9;
	Sun,  7 Dec 2008 14:08:40 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081112)
In-Reply-To: <eaa105840812070857i27f8e920keaba3f92f5260b38@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/102504>

Peter Harris pisze:
> Make sure you don't use the --no-metadata flag when setting up
> git-svn. This will embed the metadata into commit messages, so git-svn
> can rebuild it from scratch whenever it needs to. (You probably also
> want git 1.6.1rc for incremental rebuild support). This also has the
> advantage that you can see the svn revision number when looking at a
> commit message.

Not sure what you exactly mean here. Do you mean that if metadata is included in commit messages
then there is an easy way to initialize git-svn after cloning the repo?

By easy I mean:
a) it does not require to much of interactive actions to be performed
b) it does not pull too much from svn server

Point b) is important because we usually have quite large repositories.

Also, could you point me to a place where this rebuild support is described? I would like to know
what our committer has to do after cloning from Jukka's server.

> svn doesn't really know what a merge is (not even 1.5). You MUST
> rebase in order to commit to svn. This is a limitation of svn, not
> git.

Yep, I'm aware of the fact that history has to be flattened but I was more worried about the point
you address below.

> In terms of re-pulling from the git-svn mirror, git-svn will create
> the same commits (with the same sha1s) from svn every time, so there
> will be no conflicts there.

Just to make sure: so if one person pulls from git-svn mirror and another one pulls using git svn
rebase they result in the same tree right?

>> Is it possible with Git right now?
> 
> Yes, but it might not be possible with svn, depending on which part of
> the above "it" is.

It referred mostly to cloning from git svn mirror and then being able to use git svn dcommit to push
changes back to svn. Since git svn data is not being cloned the question is how to recreate it.

>> What if A was not fair and has rewritten a few commits coming from B so they contain malicious code?
>> How we can detect something like that and how C be sure that what he merges is really work
>> attributed by correct names?
> 
> If C doesn't trust A, C should not pull from A. C should pull only
> from (trusted) B. Presumably B knows who (of A and B) did which work,
> and B's repository can be trusted?
> 
> If neither of A or B can be trusted, then you have problems that a
> computer cannot solve for you.

Yep, I was having in mind the case when both A and B are untrusted. I don't want my computer to
check if something coming from A or B is safe or not I just want to know which bits are coming from
A and which from B.

This is really important for us because of legal reasons.

> You could maybe use signed tags ("git help tag") - each contributor
> could sign a certain tree state, and if you see commits attributed to
> the other contributor after their last tag, you know something is
> fishy. But that might be more effort than either you or your
> contributors want to go through. And while it might help with
> attribution problems, it still doesn't help with all the other
> problems you might have with untrusted contributors.

The question is why Git doesn't sign all commits by default but only tags? Creating tags all the
time is rather tedious process and seems to have no sense, right?

Does it mean that with current Git design it's the best to not use advanced features of Git like
tree merging but simply go with posting e-mails with patches instead if contributors cannot be trusted?

Thanks for your reply.

-- 
Best regards,
Grzegorz Kossakowski
