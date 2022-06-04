Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27AB7C433EF
	for <git@archiver.kernel.org>; Sat,  4 Jun 2022 08:29:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233236AbiFDI3X (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Jun 2022 04:29:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232801AbiFDI3W (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Jun 2022 04:29:22 -0400
Received: from eggs.gnu.org (eggs.gnu.org [IPv6:2001:470:142:3::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B2537A29
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 01:29:21 -0700 (PDT)
Received: from fencepost.gnu.org ([2001:470:142:3::e]:47188)
        by eggs.gnu.org with esmtps (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1nxP9r-0002b8-Uw
        for git@vger.kernel.org; Sat, 04 Jun 2022 04:29:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=gnu.org;
        s=fencepost-gnu-org; h=MIME-Version:Date:Subject:To:From:in-reply-to:
        references; bh=U82fWe/6Y4grmlRBg7tLF7bKCHR84BnOsaKmUIZ1dk4=; b=jXHs1yoxN4gvhY
        wzsFHZzPdyxh4qclX82jT3n077zDX4jN/Q06NQuhuP/ZVKBHh4hPrAPVfiALPvqZLxVe+xlWr39jw
        /L205CTEKXff4GJqxPeDQ7mryWPejHwOSpXz7bpoixiwJB0qUD4aerdM75xHQP3mJpcqc6+RhWMvo
        rcrXYQPHSXDneAEwy/9N4vIrikt8s8pVAVZOCbzV1PJvmVsykyIAPG4b2v+vGru+JO1SV4pdmomDe
        PoiyTEpoYp9dCV6wfV+aGqk3+CWEhDp405iN6g5nUxpardGDs6mfvoB0N/E4vaE9voBoZypXtDasl
        cElXP3mkpRrEnb8+4PyQ==;
Received: from auth2-smtp.messagingengine.com ([66.111.4.228]:59351)
        by fencepost.gnu.org with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <tsdh@gnu.org>)
        id 1nxP9r-0002Yw-CS
        for git@vger.kernel.org; Sat, 04 Jun 2022 04:29:19 -0400
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9E24427C0054
        for <git@vger.kernel.org>; Sat,  4 Jun 2022 04:29:16 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 04 Jun 2022 04:29:16 -0400
X-ME-Sender: <xms:3BebYtbXF5QJFV4lGyBZDsJZRE-EXA3tkLnNy-4ak8JTUoG_6E_SyA>
    <xme:3BebYkZGT0-lJ7GYaZi2V4pEthpeIfsMhXc0j54yER8c3p6I-fEbcZZcUn0MZUPG-
    aS5EjWPXjsXSQ>
X-ME-Received: <xmr:3BebYv8nzHHyLipUGODlGroMJuGpkhv48-eb0iHzBUhMiLKaFxLC8ybxRv0M8RQ0pLIymKOxicgFZ_ZBXiszNjZsGhcCPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrleekgddthecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepfgfhvffufffkgggtgfesthhqredttd
    erjeenucfhrhhomhepvfgrshhsihhlohcujfhorhhnuceothhsughhsehgnhhurdhorhhg
    qeenucggtffrrghtthgvrhhnpeehveetieetkeegkeehveejudefjeeuieetkeetfeejte
    dvvdeuheduudfggeekieenucffohhmrghinhepmhgrghhithdrvhgtnecuvehluhhsthgv
    rhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepthhhohhrnhdomhgvshhmth
    hprghuthhhphgvrhhsohhnrghlihhthidqkeeijeefkeejkeegqdeifeehvdelkedqthhs
    ughhpeepghhnuhdrohhrghesfhgrshhtmhgrihhlrdhfmh
X-ME-Proxy: <xmx:3BebYrqN0yW51eX6YVa2CQPqxVzLf0TFnQGVMzh6Duron4MYyJ2ozA>
    <xmx:3BebYoo4JFzwhM-ks4m7iE6z7Bglmjm9aooUG_UATXDHy_usi_7uyQ>
    <xmx:3BebYhSrVhJExwXNv4lUzQoOTriGRP5upuINHCb45K_8Ys4ZfR8U0g>
    <xmx:3BebYuG7v4eVYAEr_SYFcZU7VtAxscP2sWw8Ow9e2JHAsL9_X3C1Aw>
Feedback-ID: ib2b94485:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <git@vger.kernel.org>; Sat, 4 Jun 2022 04:29:16 -0400 (EDT)
User-agent: mu4e 1.7.26; emacs 29.0.50
From:   Tassilo Horn <tsdh@gnu.org>
To:     git@vger.kernel.org
Subject: [BUG?] Major performance issue with some commands on our repo's
 master branch
Date:   Sat, 04 Jun 2022 09:39:35 +0200
Message-ID: <87h750q1b9.fsf@gnu.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi all,

[spoiler alert: I've figured out the config option causing the problem
while writing this long mail, so you might jump straight to the SOLUTION
section at the bottom of this mail.]

at my day job, I work on a git repo (sadly non-public, proprietary) with
these stats:

- master has about 150000 commits, the last release branch I've also benchm=
arked above has 144000 commits
- the history dates back to 2001
- .git/ is about 1.8 GB

So it's quite big but not unusually big when compared to linux or other
free software projects.

The typical git commands I use (status, fetch, pull, commit, push,
rebase, ...) are all quick.  However, I use the git porcelain Magit [1]
which invokes several plumbing commands in order to present to the user
an always up-to-date extended status buffer of the currently checked out
branch showing the current branch.  Some of those plumbing commands are
extremely slow for no obvious reasons.  The most outstanding command I
could pinpoint is this:

--8<---------------cut here---------------start------------->8---
=E2=9D=AF time git show --no-patch --format=3D"%h %s" "master^{commit}" --
6192a0cfdc6 Merge remote-tracking branch 'origin/SHD_ECORO_3_9_7'

________________________________________________________
Executed in   13.21 secs    fish           external
   usr time   12.99 secs  462.00 micros   12.99 secs
   sys time    0.17 secs  119.00 micros    0.17 secs
--8<---------------cut here---------------end--------------->8---

The interesting thing is that I have this problem only with the master
branch.  When I run it for the last release branch, I get these times:

--8<---------------cut here---------------start------------->8---
=E2=9D=AF time git show --no-patch --format=3D"%h %s" "SHD_ECORO_3_9_7^{com=
mit}" --
994334fc9fb ECOJ-33833 HTML-Formbrief: Bestellungs-Anh=C3=A4nge im KV-Konte=
xt

________________________________________________________
Executed in   22.68 millis    fish           external
   usr time    7.71 millis  761.00 micros    6.95 millis
   sys time   10.47 millis  194.00 micros   10.28 millis
--8<---------------cut here---------------end--------------->8---

So you see, it's almost a factor of 1000 difference!  How can that be?

The split between master and the SHD_ECORO_3_X_X series of branches has
happened almost 2 years ago and master is way ahead of those.

--8<---------------cut here---------------start------------->8---
=E2=9D=AF git log --oneline master...origin/SHD_ECORO_3_9_7 | wc -l
5013
--8<---------------cut here---------------end--------------->8---

But there are around 9 merges from the last release branch into master
daily.

--8<---------------cut here---------------start------------->8---
=E2=9D=AF git log --merges --oneline --since 6months | wc -l
1611
--8<---------------cut here---------------end--------------->8---

From my memory, the issue hasn't popped up out of sudden but has gotten
worse slowly over time.  I have the impression that the worsening
increased pace over the last few month which might be the result of our
workflow.  Before, I've been the merge guy doing two "merge waves" from
the last supported release branch upwards into master once or twice a
day (usually release-branch -> next-release-branch -> master).  Since
about 3 month, we've switched to a workflow where every developer does
merge upwards herself just after committing/pushing to some lesser
branch than master simply because branches have diverged so much that
you'd need to be an expert in everything in order to be able to resolve
conflicts sensibly.

I should mention that I haven't seen this issue with any other repo I
have.  But that's also the biggest one I use.  The Emacs repository I
also work on is comparable in the number of commits but with much less
merges.

At last, here's the git bugreport sysinfo section on that machine and
repository.

--8<---------------cut here---------------start------------->8---
[System Info]
git version:
git version 2.36.1
cpu: x86_64
no commit associated with this build
sizeof-long: 8
sizeof-size_t: 8
shell-path: /bin/sh
uname: Linux 5.18.1-zen1-1-zen #1 ZEN SMP PREEMPT_DYNAMIC Mon, 30 May 2022 =
17:53:16 +0000 x86_64
compiler info: gnuc: 11.2
libc info: glibc: 2.35
$SHELL (typically, interactive shell): /usr/bin/fish

[Enabled Hooks]
--8<---------------cut here---------------end--------------->8---

SOLUTION
=3D=3D=3D=3D=3D=3D=3D=3D

While writing this long mail, I've figured out that the performance
penalty is caused by my setting of diff.renameLimit =3D 10000.  If I
comment that option in my ~/.gitconfig, the above command finishes in
150 millis instead of 13 seconds:

--8<---------------cut here---------------start------------->8---
=E2=9D=AF time git show --no-patch --format=3D"%h %s" "master^{commit}" --
6192a0cfdc6 Merge remote-tracking branch 'origin/SHD_ECORO_3_9_7'

________________________________________________________
Executed in  147.99 millis    fish           external
   usr time  114.52 millis  713.00 micros  113.81 millis
   sys time   34.78 millis  193.00 micros   34.59 millis
--8<---------------cut here---------------end--------------->8---

But there's still the question why diff.renameLimit has an influence
here when --no-patch is provided so no diff should be generated.

Bye,
Tassilo

[1] https://magit.vc/
