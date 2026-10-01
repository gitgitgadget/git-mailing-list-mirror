Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDA13363C75
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 21:29:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790890177; cv=none; b=WQVGmV37PvwD/z8aP89/zIX76ZVLiSNDu3gJeVK77aaqqlRtoggu/lJZSEZ1fHvKxL1Tp3bAH4FNFTY0KCM07FbZAoydIpFAZYkB7goOVh2i1HXpP91fOJFY+ghqmBWvSL163469LCdDnz7AltEY0sIYJlH0ghauStYS1A8yaQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790890177; c=relaxed/simple;
	bh=PhBZBzqy+ifKlRY/ptqnalKncTAWk4VB5/EfeA664E0=;
	h=From:To:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ExhVxBuFZn8ra7ILrYI/rZ8OekOHSP+AGaMwgPa4Lr1j2Ahi8wWeTe9jgVvqTRczBBDpKX9kczbkryriPqzPkgrViuLyvtyhFBRqk67Cvm0NcqIeM0VK6w8FZlanRgz1NCAH6bOgtTMW7DrlRrwC4pZ6PppmqgpBQGSmZrbcE9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=icxaof/c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZSfGvjG1; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="icxaof/c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZSfGvjG1"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id CF983EC0288
	for <git@vger.kernel.org>; Thu,  1 Oct 2026 17:29:31 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Thu, 01 Oct 2026 17:29:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:subject:subject:to:to; s=fm3;
	 t=1790890171; x=1790976571; bh=kDZ8sHd+xYyOPL+FFeTaOsECGPvCtx6I
	NPAFV+QcY/U=; b=icxaof/cndkQW2/rTRxAS+X/2Nms7ek70hWFbXZbCTCPvLsE
	BTc55DZUC+QZObL8oi02PImKDMcUn5nfn7OiD+nnSlRJyU2HiUuEqRvBxFcoTrEL
	iI/m7RYabsPdCnpTxW/llL6x7GpioRNNRae5Mgex0pVIvJ2XSg8E5IcHDp5AnQ+Q
	iFzpHNzPJDOnt15QrKfqbRVlBliTn0pepiB+LrNdK9FdPvc8xaxd7D+CHGixEFEI
	RnEi2FCyLXgEj0Rj8muI4oxsMMT05VznabdhW0LeLcnGt3LyevXwJtR5Ueknojyv
	F5WNfL46ec37EySjtRc1F0xqIJCt7YRolf3/+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1790890171; x=
	1790976571; bh=kDZ8sHd+xYyOPL+FFeTaOsECGPvCtx6INPAFV+QcY/U=; b=Z
	SfGvjG16dNbESSRZVnf7iGmII8Pc5uh5bLMfeugOGMvhR3DI3b3MxIZy4p1CY650
	piCDuDjvr8JSfHonN/eVQvTk9h7h5pajgVBObI6zVfeh9P3D55v11S5AyiiG2iVO
	2E92/zGxj2xhuwU8+3Os9LmQ5iFB6bBBHCZ5z81NeOxc+0QCwuzFAF9H9PfgPtpv
	+fzzurqlPVDO17JgnnO8p5zw5/HOaraUUfkUDGEuZmFoUYeOvLH7oGPmnl3zw5+v
	wSXM0KkYXJhwS6Uu/L0SJiSYbOozFdDHOphk6hSIXE3AqmK39WUROXSoqkM5dvs2
	7laAzs1V3hHkSCXyn28mQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1790890171; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm3:rsa-sha256:uFIaovh32S8CYQk+2d1NXA2S1i927tSGvdjtVlnQYb5N6vT
	pxvbgUKXF7JkM3Nj4PV6PgzPisHMfeXQG9kHYk2GQkurQVNKy001UtEJUcATPaQD
	baAQjjvhIXSYQWZ77ygFBAHGhAT1M2r8RXBeM9zGPNYetTIM46wKUcMHZIgj2IKO
	rejOTeRK1CoSt3F2u9ZCtdnXy8LaH2nV0V216h0rpgx4/1HBvRp5Xz5I5Ky7tCQZ
	FLwiaN4X5m73OMAmJUqkvJfj/IRtbMGhZr/WRCkAx9ROw2DUPw1jXAhG8XAONjNi
	X1Kni4SwuDkgMdODJJSbrWY+Mx1nrrbZAQuhKSw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-09-30; sw=lmtpprox;
	action=mi-m=1; hc=9;
	hn=content-type,date,feedback-id,from,message-id,mime-version,
	subject,to,user-agent;
Message-Instance: m=1; h=sha256:xBKhhLHGmToES7ZUL8RpAFKWgl+vfmQuGPLBehAK/6Y=:PhBZBzqy+ifKlRY/ptqnalKncTAWk4VB5/EfeA664E0=;
X-ME-Sender: <xms:u9C-akfw9NmMqWAhdVo2JNut8UdTcLKffquAm7HEdOdwo4RxMZD-hA>
    <xme:u9C-asO3Mcnq_KY9YNz8jPFX-aVdRoYliNxJkMDQvpJG6LhUTnTbAChbxbsaXEClm
    _e37RsGq0a7XnWkEhFaUK5NLv3hu6PmHB_nceoymIZpuJOZVcxfK6Q>
X-ME-Received: <xmr:u9C-ajJmUQvlOeA1Od2_VPwQsh48MU4XX-9S63aa_jkvhQY6WDXRQS6dbnB6Wgqk-ZgUFKYJeu8FNugzRuGbbeA3dw_cIS7_vzHV>
X-ME-Proxy-Cause: dmFkZTEIY0WD6o2DbxoeUlDKHQIvEcpEAnxZ5ofFX6mqKQIjguZGPBgA70VZoehCFEunfw
    LYkXC5BiLIyEnj95+tbI52LkgAtJhAJcG6B/IZ6ts2Ds6RTfSojJDnR5oj2PkTY7byzczI
    /bi5+oHOCxoq2Mo3EE/kK2bk72JF7nZNf6frXy4GtQQekAB53B4s+ttVHiHzai3fDHpDY+
    yR7xw3VLb5WI8UQogUdUxONsO7EMCZkqtMYE1vQTwhCBvHoLMCKYqFs5Pw7rjoNBNb0r3P
    tHPGJxYYtnAzqCM7UgS0zheLgm/MIGu90SjEmyaNFBw4m8JBeWFPqH5J1LYPs0bcYiI3Vt
    SuLbIZpvjz6MYnTRb52sdXSohJQ/zx6ql5qxS34jLD4CrkKApKdpO5wjZ7Ktv2+8wZO4Co
    O2ExJdTWHG/4lJW93M+Q1kCsF7o7xo88nTuSFbRxo9IAurJPzGr87Dxk7mEH0ZV1XSRho1
    Y3nw9ogtMjk/iOmIZX2N9ZDXMF5ZLNbpIkDXeYc3g3U/FD6QbS334jNoUTiO4d7oFZRVH6
    xZpl6xGeYdBImdf25StaTSUhAwApv1LzEjGntAo3/I0De0DGHsqwDKwsoTx004XQckRBRq
    7w8vUCDsgPOrK8EfSUVYznLz9G3kGDour6NieMQwValptOXemGyNPkkl5ocg
X-ME-Proxy: <xmx:u9C-alG4a63010YmUi5aCkp0NrDWwrbZIqksGCpOGu0B4TPYYwlVtQ>
    <xmx:u9C-ajS-6LDJ0ch3HuuU6MSSh89TMzivGBA3f9LnYvwIzYh2c4T02A>
    <xmx:u9C-apGfg3sJVfrE-Xa4B-itpjoZ_dxfJzbhtEo4efPD1yyKIPdoaA>
    <xmx:u9C-an_pp4sC1Cor5gdbNgckY_T2yrrocSejTdYdbg7G-peDYnO3AQ>
    <xmx:u9C-av2tQhV6LBqHoCJdduOF4Vx5dyj9odgR3RRMXRJ01q-Uon92bFLm>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Oct 2026 17:29:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: A note from the maintainer
Date: Thu, 01 Oct 2026 14:29:30 -0700
Message-ID: <xmqqbj9d3y9x.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Welcome to the Git development community.

This message is written by the maintainer and talks about how Git
project is managed, and how you can work with it.

	Note.  The section on integration branches has been heavily
	rewritten in this edition; this is partly in preparation for
	a medium version bump.

The current maintainer is Junio C Hamano <gitster@pobox.com>.  Spam
filters learned that legitimate messages come to this address only
from a very few sender addresses that are known to be good, and all
other messages are likely to be spam unless they are also sent to the
mailing list at the same time (i.e. "Reply-all" to the list message
would reach the mailbox, but "Reply" will likely be thrown into the
spam folder), so please do not send a message to this address unless
it is also sent to the mailing list as well.


* Mailing list and the community

The development is primarily done on the Git mailing list. Help
requests, feature proposals, bug reports and patches should be sent to
the list address <git@vger.kernel.org>.  You don't have to be
subscribed to send messages.  The convention on the list is to keep
everybody involved on Cc:, so it is unnecessary to say "Please Cc: me,
I am not subscribed".

As an anti-spam measure, the mailing list software may reject messages
that are not text/plain and drops them on the floor.  If you are a
GMail user, you'd want to make sure "Plain text mode" is checked.

The mailing list, while welcoming non code contributions like bug
reports, mostly discusses updating contents of the source tree to the
(core) Git software, including documentation "git help" gives.
Non-code contributions may have places other than the mailing list
that are more preferrable.  See the "other places" section near the
end.

Before sending patches, please read Documentation/SubmittingPatches
and Documentation/CodingGuidelines to familiarize yourself with the
project convention.

If you sent a patch and you did not hear any response from anybody for
several days, it does not necessarily mean that your patch was totally
uninteresting; it may merely mean that it was lost in the noise.
Please do not hesitate to send a reminder message in such a case.
Messages getting lost in the noise may be a sign that those who can
evaluate your patch don't have enough mental/time bandwidth to process
them right at the moment, and it often helps to wait until the list
traffic becomes calmer before sending such a reminder.

The list archive is available at a few public sites:

        https://lore.kernel.org/git/
        https://marc.info/?l=git
        https://www.spinics.net/lists/git/

For those who prefer to read it over NNTP:

	nntp://nntp.lore.kernel.org/org.kernel.vger.git
        nntp://news.public-inbox.org/inbox.comp.version-control.git
	nntp://news.gmane.io/gmane.comp.version-control.git

are available.

When you point at a message in a mailing list archive, using its
message ID is often the most robust (if not very friendly) way to do
so, like this:

	https://lore.kernel.org/git/Pine.LNX.4.58.0504150753440.7211@ppc970.osdl.org

Often these web interfaces accept the message ID with enclosing <>
stripped (like the above example to point at one of the most important
message in the Git mailing list).

Some members of the development community can sometimes be found on
the #git and #git-devel IRC channels on Libera Chat.  Their logs are
available at:

        https://colabti.org/ircloggy/git/last
        https://colabti.org/ircloggy/git-devel/last

There is a volunteer-run newsletter to serve our community ("Git Rev
News" https://git.github.io/rev_news/).

Git is a member project of Software Freedom Conservancy, a non-profit
organization (https://sfconservancy.org/).  To reach a committee of
liaisons to the conservancy, contact them at <git@sfconservancy.org>.

For our expectations on the behaviour of the community participants
towards each other, see CODE_OF_CONDUCT.md at the top level of the source
tree, or:

    https://github.com/git/git/blob/master/CODE_OF_CONDUCT.md


* Reporting bugs

When you think git does not behave as you expect, please do not stop
your bug report with just "git does not work".  "I used git in this
way, but it did not work" is not much better, neither is "I used git
in this way, and X happend, which is broken".  It often is that git is
correct to cause X happen in such a case, and it is your expectation
that is broken.  People would not know what other result Y you
expected to see instead of X, if you left it unsaid.

Please remember to always state

 - what you wanted to achieve;

 - what you did (the version of git and the command sequence to reproduce
   the behavior);

 - what you saw happen (X above);

 - what you expected to see (Y above); and

 - how the last two are different.

See https://www.chiark.greenend.org.uk/~sgtatham/bugs.html for further
hints.  Our `git bugreport` tool gives you a handy way you can use to
make sure you do not forget these points when filing a bug report.

If you think you found a security-sensitive issue and want to disclose
it to us without announcing it to wider public, please contact us at
our security mailing list <git-security@googlegroups.com>.  This is
a closed list that is limited to people who need to know early about
vulnerabilities, including:

  - people triaging and fixing reported vulnerabilities
  - people operating major git hosting sites with many users
  - people packaging and distributing git to large numbers of people

where these issues are discussed without risk of the information
leaking out before we're ready to make public announcements.


* Repositories and documentation.

My public git.git repositories are (mirrored) at:

  https://git.kernel.org/pub/scm/git/git.git/
  https://kernel.googlesource.com/pub/scm/git/git
  https://repo.or.cz/alt-git.git/
  https://github.com/git/git/
  https://gitlab.com/git-scm/git/

This one shows not just the main integration branches, but also
individual topics broken out:

  https://github.com/gitster/git/

A few web interfaces are found at:

  https://git.kernel.org/pub/scm/git/git.git
  https://kernel.googlesource.com/pub/scm/git/git
  https://repo.or.cz/w/alt-git.git

Preformatted documentation from the tip of the "master" branch can be
found in:

  https://git.kernel.org/pub/scm/git/git-{htmldocs,manpages}.git/
  https://repo.or.cz/git-{htmldocs,manpages}.git/
  https://github.com/gitster/git-{htmldocs,manpages}.git/

The manual pages formatted in HTML for the tip of "master" can be
viewed online at:

  https://git.github.io/htmldocs/git.html


* How various branches are used.

There are four integration branches in the git.git repository that
track the source tree of Git: 'master', 'maint', 'next', and 'seen'.
Commits are almost never made directly to them.  Instead, after review
on the mailing list, each new feature or bugfix is applied to its own
topic branch forked from 'master' or 'maint' (or an older base when
fixing an earlier bug), and kept out of 'master' while it is tested.
The quality of topic branches is judged primarily by list discussions.

The 'master' branch holds well-tested changes ready for production and
aims to be more stable than any released version.  Feature releases
are cut from its tip and named with two-dotted decimal digits (e.g.,
Git 2.56, tagged 'v2.56.0', made on September 28, 2026).

Whenever a feature release is made, 'maint' is forked from 'master'.
Obvious, safe bugfixes for the latest feature release (and occasional
developer aids such as CI updates, but almost never new features) are
merged into it to cut maintenance releases named by incrementing the
third digit (e.g., '2.47.1' for the '2.47' series).  Bugfix topics are
usually merged into 'master' before 'maint' to avoid last-minute
issues, though embargoed security fixes may appear in both at the same
time.  'maint' is merged up into 'master', primarily to propagate
release notes forward.

Topic branches in good shape are merged into 'next', where new and
exciting things take place.  'next' generally contains the tip of
'master' and is expected to work without major breakage while topics
in it are polished to perfection before graduating to 'master'.  Being
in 'next' is no guarantee of appearing in any release: flawed commits
or whole topics may be reverted from 'next' (or even from 'master' if
a regression is found late).  Because a bug may manifest only in your
unique workflow, please help by building and using 'next' for your
daily work and reporting problems to the mailing list before they
reach 'master'.

The 'seen' branch bundles the remaining topics that the maintainer has
seen and found potentially interesting; please do not read anything
more into a topic being in 'seen', as topics whose ideas do not pan
out are discarded before reaching 'next', just as topics can wither on
the list without support.  Contributors can use 'seen' to anticipate
conflicts with others' in-flight topics and coordinate early.  Before
sending patches to the list (or via GitGitGadget), it is a good idea
to test your topic in isolation and with temporary merges to 'next'
and 'seen'.

You can run 'git log --oneline --first-parent master..seen' to see
what topics are currently in flight.  Its output mentions a 'jch'
branch, an early part of 'seen' that contains all of 'next' and a bit
more, used by the maintainer for his daily work.

'master' and 'maint' are never rewound, and 'next' is rebuilt from the
tip of 'master' only after a feature release (using the topics that
did not make the cut, possibly ejecting some).  Consequently, until a
topic is merged into 'next', updates should replace its patches with
an improved version; once in 'next', updates must come as incremental
patches explaining what reviewers missed and how it was corrected.


* Other people's trees.

Documentation/SubmittingPatches outlines to whom your proposed changes
should be sent.  As described in contrib/README, I would delegate fixes
and enhancements in contrib/ area to the primary contributors of them.

Although the following are included in git.git repository, they have their
own authoritative repository and maintainers:

 - git-gui/ comes from git-gui project, maintained by Johannes Sixt:

        https://github.com/j6t/git-gui

 - gitk-git/ comes from gitk project, maintained by Johannes Sixt:

        https://github.com/j6t/gitk

 - po/ comes from the localization coordinator, Jiang Xin:

	https://github.com/git-l10n/git-po/

When sending proposed updates and fixes to these parts of the system,
please base your patches on these trees, not git.git (the former two
even have different directory structures).


* Other places.

As the Git ecosystem has grown larger over the years, there are
documentation sites and third-party tools that have been created and
maintained by friendly third-parties.  Reporting issues with them to
the main mailing list is still welcomed by the list participants, but
most likely you will be asked to contact these third-parties directly.

 - git-scm website (https://www.git-scm.com/) is maintained directly
   on its GitHub repository and its issues are managed there.

   https://github.com/git/git-scm.com/issues
   https://github.com/git/git-scm.com/?tab=readme-ov-file#contributing

 - Git for Windows (https://gitforwindows.org/) is a project that
   packages (core) Git software with some other goodies for the
   Windows platform.  They manage their own issues list and their
   changes are managed directly on GitHub via pull requests, focused
   primarily on Windows specific issues and their additions (like
   Windows installer).

   https://github.com/git-for-windows/git/wiki/How-to-participate
   https://github.com/git-for-windows/git/issues

 - The online edition of ProGit Book hosted at git-scm.com/book/ is
   managed by the Pro Git book folks, and they maintain their work and
   issues at their GitHub repository.

   https://github.com/progit/progit2/issues
   https://github.com/progit/progit2/blob/main/CONTRIBUTING.md
