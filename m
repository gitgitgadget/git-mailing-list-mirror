From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH 0/3] Documentation: rebase and workflows
Date: Sat, 13 Sep 2008 18:10:59 +0200
Message-ID: <1221322263-25291-1-git-send-email-trast@student.ethz.ch>
References: <7v8wtwk4yp.fsf@gitster.siamese.dyndns.org>
Cc: Junio C Hamano <junio@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Sep 13 18:12:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KeXjT-0001Zh-Rg
	for gcvg-git-2@gmane.org; Sat, 13 Sep 2008 18:12:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751758AbYIMQLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Sep 2008 12:11:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751674AbYIMQLM
	(ORCPT <rfc822;git-outgoing>); Sat, 13 Sep 2008 12:11:12 -0400
Received: from xsmtp0.ethz.ch ([82.130.70.14]:42895 "EHLO XSMTP0.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751174AbYIMQLL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2008 12:11:11 -0400
Received: from xfe0.d.ethz.ch ([82.130.124.40]) by XSMTP0.ethz.ch with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 13 Sep 2008 18:11:08 +0200
Received: from localhost.localdomain ([77.56.223.244]) by xfe0.d.ethz.ch over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Sat, 13 Sep 2008 18:11:08 +0200
X-Mailer: git-send-email 1.6.0.2.408.g3709
In-Reply-To: <7v8wtwk4yp.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 13 Sep 2008 16:11:09.0011 (UTC) FILETIME=[55403A30:01C915BB]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95803>

Junio C Hamano wrote:
>

First of all, thanks for your excellent criticism of my patch.
(Thanks also to Marcus for spotting the typo, though I eventually
decided to remove the corresponding part again.)

I'm rerolling the entire series, with a few improvements to 3/3, and
following that with an interdiff.  1/3 is almost a complete rewrite.
(I realise that 3/3 is not really related to the first two, so we may
eventually have to split it off the series if it takes more time.)

All snipped comments have been addressed ... hopefully ;-)

> In other words, draw it like this.  It is much easier to see what's
> changed and what's unchanged, if the part that hasn't changed stayed
> unchanged in the picture:
[...]
>        o---o---o---o---o---o---o---o  master
>             \                       \ 
>              o---o---o---o---o       o'--o'--o'--o'--o' subsystem
>                               \
>                                *---*---*  topic

I had the old one in the other style to emphasise that all commits on
'topic' are "indistinguishable" w.r.t. source.  But this indeed makes
for nicer graphs.

> Thomas Rast <trast@student.ethz.ch> writes:
> > +on 'subsystem'.  Luckily, 'git-rebase' knows to skip commits that are
> > +textually the same as commits in the upstream.  So if you say
> 
> There is no luck involved in "git rebase" knowing how to do this -- this
> is by design.

Luckily for the user! :-)

> But more importantly, at this point, there is a break in the flow of
> thought in this section.  Step back and read what you wrote, pretending as
> if you are reading the section for the first time, and notice:
[...]

Indeed, you are right.  I stole your "merge without rebase" drawing,
and added a paragraph about the reasons for a rebase.  However:

> The problem is that the resulting history will keep two copies of the
> morally equivalent commits from the subsystem.  You know that, and I know
> that, but the purpose of the document is to explain it to people who do
> not know it yet.

Maybe that's just me, but I always thought the duplication argument
was a bit weak.  I think reasons such as "resurrects changes that have
been (presumably for a reason) undone" are far scarier and more likely
to stop users from rebasing.  Eventually, I omitted it to keep the
justification paragraph shorter, but if others feel the same, maybe it
should go in.

- Thomas


Thomas Rast (3):
  Documentation: new upstream rebase recovery section in git-rebase
  Documentation: Refer to git-rebase(1) to warn against rewriting
  Documentation: add manpage about workflows

 Documentation/Makefile              |    2 +-
 Documentation/git-commit.txt        |    4 +
 Documentation/git-filter-branch.txt |    4 +-
 Documentation/git-rebase.txt        |  129 +++++++++++++-
 Documentation/git-reset.txt         |    4 +-
 Documentation/gitworkflows.txt      |  330 +++++++++++++++++++++++++++++++++++
 6 files changed, 465 insertions(+), 8 deletions(-)
 create mode 100644 Documentation/gitworkflows.txt
