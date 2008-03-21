From: "alturin marlinon" <alturin@gmail.com>
Subject: [SoC RFC] git statistics - information about commits
Date: Fri, 21 Mar 2008 09:52:38 +0100
Message-ID: <bd6139dc0803210152o529f3b4fi15c515f5385d8f88@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 21 09:53:23 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Jcd04-0001fC-VS
	for gcvg-git-2@gmane.org; Fri, 21 Mar 2008 09:53:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752422AbYCUIwk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 Mar 2008 04:52:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752385AbYCUIwk
	(ORCPT <rfc822;git-outgoing>); Fri, 21 Mar 2008 04:52:40 -0400
Received: from wf-out-1314.google.com ([209.85.200.170]:43448 "EHLO
	wf-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751953AbYCUIwj (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 Mar 2008 04:52:39 -0400
Received: by wf-out-1314.google.com with SMTP id 28so1419153wff.4
        for <git@vger.kernel.org>; Fri, 21 Mar 2008 01:52:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=BP6M40jkEdtcnBxEuiV2P6SCJb+8ORl2KQhrd9lQbgM=;
        b=okQnZztRIlHuFzHT+3Yx5bg3UAOUIG3Avb67jm6729bi+osgiWZUcirkzX57yNTK1LLNbekcMJM2qfJZV2kb57VXC3s8JoNyu1oYtqtmOk/rN78DLzwbLoR9KSNqJPN9LRhqZ5Uu4LAje4R8HxmpNpENZWy6tdYJIgt0X3gu3ZQ=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=hJxjlv4TEOvXSYV4DAfR8wyK0LRbVnt1kVtonpgvjuS1/85zpVf6Vkg0hGuZN+TwGJVKvufSpfVMimnSi2WibqR5iRhdH45WaOCXscMuwWip3Fla5OGLvQe91RPDxsBYAmCFVoExds1S5njuLRx4Z0RAbh92m57qVu4lFWKeBdA=
Received: by 10.142.48.14 with SMTP id v14mr2173340wfv.14.1206089558857;
        Fri, 21 Mar 2008 01:52:38 -0700 (PDT)
Received: by 10.142.77.6 with HTTP; Fri, 21 Mar 2008 01:52:38 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/77728>

Heya,

With regard to Google Summer of Code's application deadline closing in
fast, I could really appreciate it to get some feedback on my
application so far. Especially on what parts of this idea would be
appreciated the most, and what parts could be done without.

I have been using git on several projects so far and am very happy
with the way it does things.
When looking at TortoiseSVN I noticed that it comes with a
'statistics' button that allows you to see which users have done what.
Even though it is limited in that it can only show how many commits
were made, I think this is an important feature to any VCS. I became
aware of the importance of statistics during a project at my
University (we had to use Subversion). During the project I noticed I
used these statistics to talk about fair distribution of work, and it
really helped to get everybody's nose pointing in the right direction.
Keeping that in mind, I tried to get such statistics from git. Git
provides a 'commits per user' feature under 'git shortlog -s -n -c
master' (note the order of the switches).

Consider Ohloh, an external tool that provides commit information
about contributors to a project.
It provides with a quick over of all contributors to a project, and
what their contribution has been so far. At the moment git does not
have anything similar, even though all the data needed for such an
analysis is present. Integration with gitk and git-web would allow the
data to be presented in a clear and informative way.

Another bit of interesting information would be 'who is maintaining
this code?'. Such information is especially useful when trying to
decide whom to send a copy of a patch. Consider that git already
contains the e-mail address of each developer that maintains a certain
bit of code (this information is included in each commit). If we now
find out who maintains the code that was changed in a commit
git-format-patch could automatically include them in the cc: field.
Similarly, one might be interested in what code a maintainer is
currently working on.

In a more broad sense it might be interesting to determine what part
of the code is most actively worked on, and what part of the code is
most stable. This is most interesting when deciding whether an API is
ready to be published. (If the API is changing a lot it might be
better to wait till it has stabilized.) This information could even be
used to find 'edit wars'. (In which a part of the code is changed over
and over again.)

My plan for this summer is to create a 'statistics' feature for git.

It would provide the following functionality:
* Show how many commits a specific user made.
* Show the (average) size of their changes (in lines for example).
* Show a 'total diff', that is, take the difference between the source
with, and without their changes, including its size (with for example
a -c switch).
* Show which contributors have contributed to the part of the code
that a patch modifies.
* Show what part of the code a maintainer is working on the most.
* Define an output format for this information that can be used by
other tools (such as gitk and git-web)
* (Optional) Integrate all this information with gitk and git-web.

Implementation would probably start out with python scripts since
those are easy to modify and combine with other scripts. As milestones
are reached in time, or ahead of time, attention could be shifted to
converting these to C and combining them with the rest of git. When
the other milestones are finished time could be spent on using the
newly added features in gitk and/or git-web.

To achieve all these milestones heavy usage can be made of existing
git commands. For example, getting the total amount of commits from a
maintainer can be achieved with the less-than-intuitive 'git shortlog
-s -n -c master', providing an alias to this command would make it
easier to use this functionality. Since other git commands will be
used a lot, performance may suffer as a result of piping/parsing
results from one command to another. When a feature is converted to C
later on attention could be given to directly passing the result from
one function to another.

Determining which users have been active on a file git's built in
'blame' functionality can be used. Git blame is very fast it would be
no problem to make extensive use of it in determining maintainer
focus. In a similar way it can be used to determine who has worked on
a file recently.

I am a Dutch student, doing my Bachelor at 'Delft University of
Technology'. I study 'Technische Informatica', Dutch for 'Computer
Science'. Even before starting fourth grade in Highschool I learned
C++ so that I could help out as a coder on a MUD (Multi User Dungeon).
In grade four through six I followed the optional "Informatica" (a
High school version of 'Computer Science') course. We learned Java and
SQL, nothing too difficult, but it got me wanting to learn more. I
learned to learn other languages on my own, probably valuable thing I
learned.

I have used git on numerous projects so far, although some of its more
elaborate features I am not yet familiar with. My motivation for this
particular idea I have described above. Enjoying working with git made
me want to work on it as my Google of Summer project. Knowing that an
original idea has more chance of being selected I spent a lot of time
looking for ways to improve git worth a GSoC of coding. I'm really
looking forward to coding for git and I think GSoC would be an awesome
introduction to it's codebase but also to contributing to a large
project.

Thank you for your time and attention,

Sverre Rabbelier
(SRabbelier on #git)
