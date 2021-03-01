Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 624B1C433E0
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 15:48:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3201164DDE
	for <git@archiver.kernel.org>; Mon,  1 Mar 2021 15:48:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237402AbhCAPsE (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 1 Mar 2021 10:48:04 -0500
Received: from wout2-smtp.messagingengine.com ([64.147.123.25]:38187 "EHLO
        wout2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236767AbhCAPsC (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 1 Mar 2021 10:48:02 -0500
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 49441ACF
        for <git@vger.kernel.org>; Mon,  1 Mar 2021 10:46:52 -0500 (EST)
Received: from imap22 ([10.202.2.72])
  by compute3.internal (MEProxy); Mon, 01 Mar 2021 10:46:52 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=barag.org; h=
        mime-version:message-id:date:from:to:subject:content-type; s=
        fm2; bh=WUDAiweyS7dpnk7Dh8p6j9tASvpfvZw/NeyUpPYmH1A=; b=kGRQLsF/
        vH1/Jtzuq5PaoybU+j/J1AT87U7/OsKqjMcwGV2mWK8QmeWrDcm3bEmzbBoI7LR8
        3R39xqx7dA5ysKYRTeYm8qcqM/oSo9COohQ3nVuc67/mvVIfegvwqffMc70dvFOA
        2pyPsalIBXIn6LZOthkfrI1OcUuTSkygVEZhyo9iY4lb0SkRzmZxHFWV5kbgAXkL
        VxcEe5LMKVmFXv+AaYMZg1IqIN2TY4bYXkCC+F38kTSGJIJhAGh6VstJ6VWhVvJm
        qauIOhoKd+7/OBRD6bAJdCrzu8a0WgHg/qN80Co0UrxtNkq4ikYaCXi9S/2hp74X
        nvI+MGZLByz4Cw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=content-type:date:from:message-id
        :mime-version:subject:to:x-me-proxy:x-me-proxy:x-me-sender
        :x-me-sender:x-sasl-enc; s=fm2; bh=WUDAiweyS7dpnk7Dh8p6j9tASvpfv
        Zw/NeyUpPYmH1A=; b=JYknnt+l7Yk2cZxbRJzWsSmCNKqpyM9DfcvbWLSS1snyr
        pO+qpZ8YHyqPlKtRDAY5bXG5BEaT/s12KToN3Z+urrUH51AgrREbjriQolYCI191
        cf1+9JRA4zq5nCTcHpw+LvfSe4IWM9m/aQcGceJdkKEzYbwui2oyLjOoNCDdlpiZ
        b73potUcs4ZbpkFJfY3T06pXGRRPGnXEIGfMGxKZglwjRhgN50DfE20E91Aic608
        fHVLSBMJg47jPmhSzE0FjA1L8NLDBh73eBygrx5tTlkbUFef2UQ4TaANXL+E/Y9l
        hHGXJ7ZUR1CHnJFMPsy7iQdn1L3cv4FgLW10J0pAQ==
X-ME-Sender: <xms:aww9YPHl8ds5usjiYb8CbOhZeS3OOkL_D5tzajZCJsfkKraBMOnSeQ>
    <xme:aww9YMWJtzooqYHbv9c93zmEUEoJWVCJZw_ep2ZUzrLZmQajM1zwd1ESVMX_BCnVe
    waXhcv3_eehbSj7pSw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrleekgdejlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhepofgfggfkfffhvffutgesthdtredtre
    ertdenucfhrhhomhepfdfuvggrnhcuuegrrhgrghdfuceoshgvrghnsegsrghrrghgrdho
    rhhgqeenucggtffrrghtthgvrhhnpeetveffkedvleegkefgtdejkeeghfefheffteelgf
    fgteetgedvtdfgieefveetgeenucffohhmrghinhepghhithhhuhgsrdgtohhmnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshgvrghnsegsrg
    hrrghgrdhorhhg
X-ME-Proxy: <xmx:aww9YBL_6LR98VG5Ck_mmkZjfdv3kRwLLkwscjmWIKsDE1376KLKWA>
    <xmx:aww9YNEy2mEyoYTJORjdYcaivdf6pD5zBjYFGowZC6f0fuhSrzJ5Hw>
    <xmx:aww9YFUtfwaVVbCByRia3Z8MAvOKdpz72aN1D9zCrj7J0IEdcj6j0Q>
    <xmx:aww9YNi9JA9xdKb4ZP0HU0pcPt49O4gosrrhw0gbKN-l9L2lwGmVDQ>
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 5254462C005F; Mon,  1 Mar 2021 10:46:49 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.5.0-alpha0-206-g078a48fda5-fm-20210226.001-g078a48fd
Mime-Version: 1.0
Message-Id: <2d58fe40-9e8c-4653-8170-5411fd3cf6f4@www.fastmail.com>
Date:   Mon, 01 Mar 2021 07:46:29 -0800
From:   "Sean Barag" <sean@barag.org>
To:     git@vger.kernel.org
Subject: [BUG?] git submodule update --remote assumes 'origin' remote
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I think I've found a bit of an edge case in
`git submodule update --remote` [1] that got easier to reproduce in
2.30+ under certain configurations.
`git submodule--helper print-default-remote` defaults to 'origin' when
run in a submodule in a detached HEAD state or on a branch with no
remote tracking branch [1].  In git < 2.30, the only way for that
default to be incorrect required a user to manually change remote names
with something like `git -C ./some-sm remote rename origin foo`.
`git rev-parse`ing that ref would naturally fail, but at least it's
because the user took manual steps to break git's assumptions.

Under git 2.30+ with clone.defaultRemoteName set however, submodules are
created with that remote name instead of 'origin'.  The same behavior
occurs, but this time without direct user action - only a simple
`git submodule init && git submodule update --remote` is required.

I'm terribly sorry about that regression - I've only just started
working on a few projects that use submodules heavily and probably could
have found this sooner.  I'm happy to fix it, but would *super*
appreciate a little guidance.  It seems the intention is "use the remote
that has the url found in the superproject's .submodules entry", that'd
require `git submodule--helper print-default-remote` to be called from
the superproject from what I can tell.  I've experimented with
introducing fallbacks to `remote_for_branch` in `remote.c` [2] as an
alternative:

1. use remote tracking branch; or
2. if there's only one remote, use that; or
3. if config.defaultRemoteName is set, use that; or
4. fall back to "origin"

This seems to work (at the very least, no tests fail?), but leaves
`cd ./some-sm; git remote add foo bar; git remote rename origin baz`
open to the original behavior.

Something tells me y'all will have a very simple solution that I'm
missing :)

Again, I'm so sorry for introducing a regression here!
Sean Barag

[1] https://github.com/git/git/blob/225365fb5195e804274ab569ac3cc4919451dc7f/git-submodule.sh#L571-L584
[2] https://github.com/git/git/blob/225365fb5195e804274ab569ac3cc4919451dc7f/remote.c#L477-L487
