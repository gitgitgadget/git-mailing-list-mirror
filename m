From: P Baker <me@retrodict.com>
Subject: [RFC GSoC 2009: git-submodule for multiple, active developers on 
	active trees]
Date: Wed, 25 Mar 2009 16:14:58 -0400
Message-ID: <526944450903251314o622711b5u3665bac90398d6be@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 21:16:39 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmZWf-0007cM-H4
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 21:16:38 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753636AbZCYUPF convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 25 Mar 2009 16:15:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753265AbZCYUPE
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 16:15:04 -0400
Received: from mail-qy0-f118.google.com ([209.85.221.118]:64675 "EHLO
	mail-qy0-f118.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752153AbZCYUPC convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 16:15:02 -0400
Received: by qyk16 with SMTP id 16so451442qyk.33
        for <git@vger.kernel.org>; Wed, 25 Mar 2009 13:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:sender:received:date
         :x-google-sender-auth:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        bh=wyDH/7moBV1WPNDddtiQkVdLTNLrH6rF3rq5ja5u+Cw=;
        b=kNOpvT+nTjcof2+9nT6uMCA9I/5WT89oq15Aao5cGbdS3CDkyq5u+YeMz6LdAIYQQF
         73g3UgzS48m0mlBktNdolWgK0ydy1XUTejThWyaQwRnR3P+Sul9TrZOhulVBhhUBC7M/
         6WDRAF/zHRrDVojzliv1kvOev/1KHMxf6Bx9o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        b=kAL54ue5mICu/wkMsBw+Z77orzha0JylS1t+krG9wrpgkYfQNSec4UryPZ7L2DDOj0
         v3ft/O/bIN/5u1cxkCsZKRNPFkmYGOWLw0mg+y2Xyu/x8yqUCbDhkIEKkJayYRO3wwiB
         7KFPpHfw07tqyaCEvf5zPDAvGPxf/PjniwgxA=
Received: by 10.220.76.1 with SMTP id a1mr3685010vck.101.1238012099188; Wed, 
	25 Mar 2009 13:14:59 -0700 (PDT)
X-Google-Sender-Auth: 03c7fdb31da57792
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114656>

Greetings, I've been working on this for a while, but figured I'd send
it out while I've still got some time left before I submit it!

Any comments/questions would be welcome, as I'd really love to spend a
summer working on git.

Abstract:
	This project focuses on upgrading git-submodule to manage code
created in external projects in ways that allow users to safely branch
and merge that code without loss of data or routine merge conflicts.
This will incorporate some changes made on the =E2=80=98pu=E2=80=99 bra=
nch, but will
also include making substantial changes to git-submodule underlying
code.

Content:
git-submodule is currently a good tool designed to allow developers to
leverage the work of others by incorporating external code into a
project. However, its implementation is underdeveloped as most core
users/developers are not heavy users of the application. In contrast
to much of the rest of the project, these holes create usage problems
when git does not act according to developers=E2=80=99 expectations. Th=
is
project would devote a summer of work to filling in the gaps so that
git-submodules contains the features necessary to fully exploit its
potential to track, update and edit external codebases incorporated
into a super-project.

As opposed to =E2=80=9Cremotes,=E2=80=9D which also incorporate externa=
l code into a
project, submodules maintain the distinct nature of code and separate
the projects=E2=80=99 history. This is perfect for the intended nature =
of
=E2=80=9Cembedding foreign repositories in dedicated subdirectories of =
the
source tree.=E2=80=9D For example, managing plug-ins within a larger,
standalone project that depends on the plug-ins. However, the
shortcomings of git-submodule create headaches for developers
attempting to use git and might prevent its adoption among those
developers not willing to either create laborious workarounds or
explicitly create manual management techniques.

Adding the features to fully enable git-submodule would allow heavy
users of projects built on other actively developed projects to use
git to manage this interaction in intuitive and predictable ways.
Adding this feature set would give current users a desired tool, boost
git=E2=80=99s credibility by providing a common feature among revision
systems, make git=E2=80=99s adoption for new and existing projects easi=
er and,
as a result, likely boost git=E2=80=99s usage.

This project will consist of several stages: an initial community
based design review and investigation of specific requirements;
specifying and documenting the planned changes; writing and debugging
the code and related tests; and finally merging it into a public
release. The tentative timeline is:

End of May =E2=80=93 Conclusively finish the public discussion regardin=
g where
git-submodules needs to go
Beginning of June =E2=80=93 Produce final specifications (including met=
hod stubs)
Middle of July =E2=80=93 Finish active code and test development
End of July =E2=80=93 Merge code into production release, fix public su=
bmitted bugs
Middle of August =E2=80=93 Prepare code for final release and finish
user-facing documentation

This timeline should allow adequate flexibility while establishing
deadlines that ensure that the project will be completed in a timely
and efficient manner.

A few specific changes that this project will likely include are:

*use .git instead of .gitmodules
*move objects of submodules into .git/ directory
*git submodule update --init should initialize nested levels of submodu=
les
*protect changes in local submodules when doing =E2=80=9Cgit submodule =
update=E2=80=9D

These changes, compiled from feature requests on the git mailing list
and formulated in response to blog posts regarding git-submodule=E2=80=99=
s
issues, are representative of the full list of changes. Most
development will need to occur within git-submodules.sh, without
changing much plumbing, however, other files might be affected by more
substantial changes.

While git-submodule is stable and operational, it is not widely
updated and has not seen much change beyond bug-fixes. After reaching
its current feature complete status, the last time a feature of any
novelty was included in a public release was August 2008. However,
some work has already been started on the =E2=80=98pu=E2=80=99 branch, =
which will need
to be reviewed and probably incorporated into this project. At the
conclusion of the project, one metric by which to evaluate its success
will be its acceptance in online communities. The final goal is to
make git a top-tier version control system in its management of
external code repositories.

My main usage of git started when managing a summer project as an
intern that had many of the requirements that make git-submodule
problematic: built in Ruby on Rails and dependent on other plug-ins,
some of which were managed in SVN. Even though the Ruby on Rails
community has popularized within itself the use of sub-modules to
manage plug-ins and quite a bit has been written on the topic, a
significant portion end either in frustration or convoluted
work-arounds. The problems and extremely confusing nature of
git-submodule led me to give up on it altogether (an unfortunately
common occurrence), and manage the code and updates to it by hand.

I currently am finishing my sophomore year as an Electrical Engineer
at the University of Pennsylvania (and dual-majoring in the Wharton
School of Business). I started to develop professionally when I took a
year off between high school and college to work for a small firm in
Silicon Valley, California developing diagnostic imaging software for
quality assurance and research on their products. Last summer I
developed an Ruby on Rails-based engine to test user-designed
investment strategies for QED Benchmark, a boutique hedge fund.

Thanks,
Phill Baker
