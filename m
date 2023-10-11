Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 968A6CDB47E
	for <git@archiver.kernel.org>; Wed, 11 Oct 2023 21:42:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235170AbjJKVmv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 11 Oct 2023 17:42:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235151AbjJKVmt (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 11 Oct 2023 17:42:49 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D03AB6
        for <git@vger.kernel.org>; Wed, 11 Oct 2023 14:42:47 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id D1D0C5C0349;
        Wed, 11 Oct 2023 17:42:46 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute1.internal (MEProxy); Wed, 11 Oct 2023 17:42:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1697060566; x=1697146966; bh=Ti8XW7UMnlUyYajCezdvm3xYk
        pngAKfd3zQI79yq1h8=; b=eUCSO6DuyVi9ueaVy564vcUVRn1RNC/9qnk3iU6iY
        rTRuph7dld5PzO5G0b622LQiCsIe3p+dZeEB/ot+cuZ+EhgFE+BZsRCAS3qzQk5I
        0NajwTsh4Wbx5Lc3ehv/FChXLVq5SD5SJrwVSzVkpCRMeYhCcPBYDKcq5/YDY4rV
        5/KkzmVdMrCnLzjmFTmY7yTWdBCtnnQ5WiJnKV7FEmyx2sQFvq9zPSjpRl7CtC8L
        gwc2LvuQZz8S5e4pJcV9alFzqkyaxnbOegRV0N2qgu31iwfG6V+wOa58PRh0JwB9
        Sj5iaKs5uIXrTIK8JlPg3vmTW7DE2l1iK7MnV2GGAYs+Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1697060566; x=1697146966; bh=Ti8XW7UMnlUyYajCezdvm3xYkpngAKfd3zQ
        I79yq1h8=; b=FDLALuKCbAu+MoXXJAw2eB+Dtvi+tGqteeeqnwhmqSSBtSq6Dzf
        OW+zlaqyRiX2EcbV8EbHGgA2oaCw/K+LYHzZxbyAdU781CAC43nni5Hv7mdAQ7JW
        2MSP5+h0uIB511RZLS8ouTnYzX8drsf0y1SmafRuHQ6/NJBHlV4Fh6XWA2WQEl/U
        D87dFIcOQPUctKRdxmFQIqrPQJneM3/5NVqqBp+555yByIAahqOPS8rht90urKD1
        6DfY9/D5U3MsV3O03I4UYB8beVopbApH9/mNSSjaWmrEEVW3VZvBcdbzI4fzKt3j
        wPpONZI39JTtctIRmreTaVW+Lyn3DRLZ2Rw==
X-ME-Sender: <xms:1hYnZa0WAlWvHXpACM_jPAy7drfdnI14KTJUnLPfrjvC2wLs9zK8ZIc>
    <xme:1hYnZdExtUcSqMPI2RwW--95fejTKiwfq4-LECoalnf7qpAh63bQado2OEGH9MoEi
    KjRoX0wmiTviRiGAA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvkedrheekgdduieduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdfm
    rhhishhtohhffhgvrhcujfgruhhgshgsrghkkhdfuceotghouggvsehkhhgruhhgshgsrg
    hkkhdrnhgrmhgvqeenucggtffrrghtthgvrhhnpedvveehiedufeehffdvteeuveekhefh
    leeigfektdeifeduteeuheeufeetffefudenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:1hYnZS5U9HTPp6mko1KoSvI7q0xVYv4z1cTPVMDKea0mDl6CqGEVSA>
    <xmx:1hYnZb2X9BKassfbbjp7iQnmaDxftxMgtePAEgZR8rKIQVOOf42q-w>
    <xmx:1hYnZdEt-NZj9ihRbTuWjHPD1_QnoyH5P39oEIS_P5LY9X4HVliswA>
    <xmx:1hYnZQOJurjq2DKdymNwf38lS7RBOIoe4Um0chCyfaq19tvJrcHwTA>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 8CF0215A0091; Wed, 11 Oct 2023 17:42:46 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-1019-ged83ad8595-fm-20231002.001-ged83ad85
MIME-Version: 1.0
Message-Id: <b27782ce-8174-4d72-acc2-2d8f0e6e6ef1@app.fastmail.com>
In-Reply-To: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
References: <79901E6C-9839-4AB2-9360-9EBCA1AAE549@icloud.com>
Date:   Wed, 11 Oct 2023 23:41:26 +0200
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     "Sebastian Thiel" <sebastian.thiel@icloud.com>
Cc:     "Josh Triplett" <josh@joshtriplett.org>, git@vger.kernel.org
Subject: Re: [RFC] Define "precious" attribute and support it in `git clean`
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Oct 10, 2023, at 14:37, Sebastian Thiel wrote:
> [Note: I'm collaborating with Josh Triplett (CCed) on the design.]
>
> I'd like to propose adding a new standard gitattribute "precious".  I'=
ve
> included proposed documentation at the end of this mail, and I'm happy=
 to write
> the code.  I wanted to get feedback on the concept first.
>
> What's a 'precious' file?
>
> "Precious" files are files that are specific to a user or local config=
uration
> and thus not tracked by Git.  As such, a user spent time to create or =
generate
> them, and to tune them to fit their needs.  They are typically also ig=
nored by
> `git` due to `.gitignore` configuration, preventing them to be tracked=
 by
> accident.

How do people deal with these precious files today?

You could track these precious files somewhere else. Maybe a Git directo=
ry
which is a sibling of `.git`.

    .git-local

Files that are useless to the project but important to the individual.

It would get its own =E2=80=9Cexcludes=E2=80=9D file.

    .gitignore-local

Now the normal repository (`.git`) needs to ignore these things.

    # Cast a wide net: could want other siblings
    # Use another pattern if you have something like `.git-blame-ignore-=
revs`
    printf '.git-*\n'       >> .git/info/exclude
    printf '.gitignore-*\n' >> .git/info/exclude

You need to pass in two arguments to `git` every time you want to use
`.git-local`.

    alias gitl=3D'git --git-dir=3D.git-local -c core.excludesFile=3D.git=
ignore-local'

Git Local should ignore everything by default. You should check with
`.gitignore` to make sure that it ignores the files that Git Local does
_not_ ignore.

    printf '*\n'                 >> .gitignore-local
    printf '!.gitignore-local\n' >> .gitignore-local
    printf '!.idea/**\n'         >> .gitignore-local

Now you can backup your local files.

    gitl add .gitignore-local
    gitl add .idea
    gitl commit -m'Update local'

But you can also version control them by providing real (intentional)
messages.

(Maybe `.idea/` is just an XML soup and thus hard to make a VCS narrative
around; I don't know yet.)

`git clean` won't help you. But an alias can.

Or if writing a shell-oneliner alias is too hard for you, I mean me.

    #!/bin/sh
    # git-klean
    git --git-dir=3D.git-local -c core.excludesFile=3D.gitignore-local a=
dd --all
    git --git-dir=3D.git-local -c core.excludesFile=3D.gitignore-local c=
ommit -mUpdate
    git clean -e .gitignore-local -e .git-local "$@"

The two `-e` switches protect the Git Local things from being wiped by
`-xd` (tested with `--dry-run`).

=C2=A7 Sibling repositories

At first I thought that `git clean` could use a `pre-clean` hook. But
that's not very satisfying.

Maybe Git could be told about its siblings via a multi-valued
configuration variable.

    sibling=3Dlocal

Then it expects there to exist `.git-<sibling name>` repository next to
it (`.git/../.git-<sibling name>`).

Then the rule becomes:

Only do destructive operations if all of the working trees[1] of the
sibling repositories are clean (cannot override with `--force`).

Additionally one could say that directories that are Git repositories
should be ignored by `git clean`, always.[2] Or siblings which
match the glob:

    .git-*

... Or if you want something longer:

    .git-sibling-*

(And also ignore `.gitignore-*` and maybe more things)

Then the regular Git repository might still blow away your precious
files. But they will be backed up by the siblings.

Or you put these other Git repositories outside of `.git/..`. Sidesteppi=
ng
the issue at the cost of some path confusion (for yourself). Maybe at:

    /home/user/git-siblings/repository1/local

=E2=80=A0 1: Worktrees not considered.
=E2=80=A0 2: And what would that break? People who make Git repositories=
 in their
   working trees and then delete them? (Well they can still use `rm -r`.)

=E2=A7=AB =E2=A7=AB

=C2=A7 Worktrees

But seriously: worktrees probably makes this not work.

--=20
Kristoffer
