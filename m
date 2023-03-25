Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C22CEC6FD1F
	for <git@archiver.kernel.org>; Sat, 25 Mar 2023 10:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231825AbjCYKEk (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 25 Mar 2023 06:04:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231473AbjCYKEi (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 25 Mar 2023 06:04:38 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C49A5DBC5
        for <git@vger.kernel.org>; Sat, 25 Mar 2023 03:04:36 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 0EFF05C0098;
        Sat, 25 Mar 2023 06:04:34 -0400 (EDT)
Received: from imap49 ([10.202.2.99])
  by compute6.internal (MEProxy); Sat, 25 Mar 2023 06:04:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=khaugsbakk.name;
         h=cc:cc:content-transfer-encoding:content-type:content-type
        :date:date:from:from:in-reply-to:message-id:mime-version
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1679738674; x=
        1679825074; bh=v1Vs1rHry8ythKKS3vPyqIiO3YaBGmOOaRFVzkuxXZ8=; b=I
        snjhLcdpfRLidlJZUh+2NELIK0PxGnnf8B4OGOeVND2XTkLSqXWycvLMhGnnDTk5
        4AFe+4TgTjIynI22R70TkXo+l/ADOPUXitLZKexcIf5rZxrtHAzLkTos+DWpC+Zj
        yipygxUGGxCk9IR/hFF+Dnqoz3BGxA/yr91/PdW/lo2ZA59022vqbUb9oW/41XgO
        tz71vFNWg7h7uvioo/Zl1mWqGUmGmTVlSD7wUt3kobFkGwY77T+X4HVxqbDQ162b
        YXOs8CY9IVL7wOgMcFlbVHMbTuugLw8EIp/gxXMdDWb93Il2GtEZlZjyi1Pz/tqF
        l8i6prVeJOOQCPtmKqWdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; t=1679738674; x=1679825074; bh=v
        1Vs1rHry8ythKKS3vPyqIiO3YaBGmOOaRFVzkuxXZ8=; b=YhkLiLjFBfse1hBZ1
        +SAoSFGEM9gCDSdIy9FroX9NMWU65b+UCu99CHclfMOg2/GsXn/4eIbAgGdvAwf1
        ORoQAHYFCXM286ve0NguQIaGveJ5RITGKxnJIhHQ8pAXP0sBGt7xMNvCyHKvZmTb
        6uVZ6Cgr2zTg3n1yJWOLHTWAaVrLc0X52zrLZkK8S6SwhZetyOWOl7Z3DL9Fj2Qa
        NBvkrlKw8ZeHfIVqYGfg6HGjSuQ4DHelGeaSdmM5ts1rZytpyL+U3lcYa0x8fdg+
        7CUFHoTW7rLwVd3ysINmz7cG4RxFFoPigjO0oebAcBULTyiaxuqHBeyGhunfK2aa
        fAslA==
X-ME-Sender: <xms:McceZNmfABG4A3qsR40GfBVeXws8E0pL7IvVYC-KAEg2sDFfAqJmNsQ>
    <xme:McceZI0h455WOTkQn__qu-qx18i2i8vG8Jq8mVxWmsK2el8wbkZtCvrJbRaebaRwz
    1EjWzBDfzfEPbiA3A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdegkedguddvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    goufhushhpvggtthffohhmrghinhculdegledmnecujfgurhepofgfggfkfffhvfevufgt
    gfesthhqredtreerjeenucfhrhhomhepfdfmrhhishhtohhffhgvrhcujfgruhhgshgsrg
    hkkhdfuceotghouggvsehkhhgruhhgshgsrghkkhdrnhgrmhgvqeenucggtffrrghtthgv
    rhhnpefggedujeetjeeiffffteduueduleeuiefgiedvtedvjedvtddvveeigeefvddvtd
    enucffohhmrghinhepghhoohhglhgvrdgtohhmnecuvehluhhsthgvrhfuihiivgeptden
    ucfrrghrrghmpehmrghilhhfrhhomheptghouggvsehkhhgruhhgshgsrghkkhdrnhgrmh
    gv
X-ME-Proxy: <xmx:McceZDpPNuJb_32zuCL1R87YTOh9L36vrjzfEhuxEMjU7yZVTQMmdw>
    <xmx:McceZNlDqbZxeNOM64j-pG4vMUjODIluz2Qq1tA0mGvryCNtMduEGQ>
    <xmx:McceZL2dVs_p-VWSSZmoo234i3uGSWngwlGwGfOHwNRt6urvTDnH-w>
    <xmx:MsceZAgZQ2kFZ2ZZrJufhUZBMd5_1RV8Ds8FpaZT0CrRPKithooEuQ>
Feedback-ID: i2671468f:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C86FC15A008E; Sat, 25 Mar 2023 06:04:33 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-236-g06c0f70e43-fm-20230313.001-g06c0f70e
Mime-Version: 1.0
Message-Id: <b93934a2-91e7-4645-9a24-4f2354172f31@app.fastmail.com>
Date:   Sat, 25 Mar 2023 11:04:12 +0100
From:   "Kristoffer Haugsbakk" <code@khaugsbakk.name>
To:     git@vger.kernel.org
Cc:     "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
Subject: range-diff: slight usability problem with mistyped ref
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I was using `git range-diff`:[1]

    $ git range-diff main feature-v2 HEAD

And got an error message:

    fatal: need two commit ranges

I intended to give three arguments to the command. I started to wonder
if I maybe had just typed `main feature-v2` (forgot the third
argument). No, it was three arguments.

The problem was that I had mistyped one argument; it was `feature-v3`,
not `feature-v2`.

I thought that this error message was a little misleading or too
generic. I looked at the history of the file (`builtin/range-diff.c`)
and saw this commit: b75747829f (range-diff: optionally accept
pathspecs, 2022-08-26).

Maybe it works better with a `pathspec` marker (`--`)?

    $ git range-diff HEAD main feature-v2 --
    fatal: not a revision: 'feature-v2'

    usage: git range-diff [<options>] <old-base>..<old-tip> <new-base>..=
<new-tip>
       or: git range-diff [<options>] <old-tip>...<new-tip>
       or: git range-diff [<options>] <base> <old-tip> <new-tip>

Yes it does: `not a revision: 'feature-v2'`.

So I tried to contrast the behavior on the current release with the
behavior on the release before the aforementioned commit.

    $ git checkout v2.40.0
    $ make clean
    $ NO_CURL=3Dtrue make -j 4
    $ # Misspelled ref `seen` as `seent`
    $ ./bin-wrappers/git range-diff master next seent
    fatal: need two commit ranges

    usage: git range-diff [<options>] <old-base>..<old-tip> <new-base>..=
<new-tip>
       or: git range-diff [<options>] <old-tip>...<new-tip>
       or: git range-diff [<options>] <base> <old-tip> <new-tip>
    [=E2=80=A6]

Expected behavior: tell me that `seent` is not a revision.

Actual behavior: generic error message.

But I get a nice error message if I append `--`:

    $ ./bin-wrappers/git range-diff master next seent --
    fatal: not a revision: 'seent'

    usage: git range-diff [<options>] <old-base>..<old-tip> <new-base>..=
<new-tip>
       or: git range-diff [<options>] <old-tip>...<new-tip>
       or: git range-diff [<options>] <base> <old-tip> <new-tip>

Contrast the behavior on `v2.37.2`, which is one of the tags before
rev. b75747829f (range-diff: optionally accept pathspecs,
2022-08-26).

    $ git checkout v2.37.2
    $ make clean
    $ NO_CURL=3Dtrue make -j 4
    $ ./bin-wrappers/git range-diff master next seent
    fatal: not a revision: 'seent'

    usage: git range-diff [<options>] <old-base>..<old-tip> <new-base>..=
<new-tip>
       or: git range-diff [<options>] <old-tip>...<new-tip>
       or: git range-diff [<options>] <base> <old-tip> <new-tip>
    [=E2=80=A6]

    $ # Tag before rev. b75747829f (range-diff: optionally
    $ # accept pathspecs, 2022-08-26)
    $ git checkout v2.37.2
    $ ./bin-wrappers/git range-diff HEAD master seent
    fatal: ambiguous argument 'HEAD..seent': unknown revision or path no=
t in the working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'
    error: could not parse log for 'HEAD..seent'

This error message is exactly what I expect to see when I mistype a ref
(my git(1) conditioning).

But the `v2.40.0` error message with `--` is better: `fatal: not a
revision: 'seent'`.

So what if I give a `--`:

    $ # Still on v2.37.2
    $ ./bin-wrappers/git range-diff master next seent --
    fatal: ambiguous argument 'master..seent': unknown revision or path =
not in the working tree.
    Use '--' to separate paths from revisions, like this:
    'git <command> [<revision>...] -- [<file>...]'
    error: could not parse log for 'master..seent'

It=E2=80=99s the same. Oh, right=E2=80=94I guess rev. b75747829f taught =
`range-diff`=20
about `--`.

In conclusion: IMO and assuming that my cross-version testing is
correct, `range-diff` has a slight usability regression for when you
mistype the ref. It would be nice if the error message without a
pathspec separator (`--`/`dash_dash`) was as nice as the one without it.

[1]: Original thread: https://groups.google.com/g/git-users/c/O5uB-E68S_0

--=20
Kristoffer Haugsbakk
