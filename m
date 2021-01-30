Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.7 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD723C433E0
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 10:27:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 810AA64DE4
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 10:27:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbhA3K0x (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 05:26:53 -0500
Received: from wforward2-smtp.messagingengine.com ([64.147.123.31]:41599 "EHLO
        wforward2-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229814AbhA3K0w (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 30 Jan 2021 05:26:52 -0500
X-Greylist: delayed 413 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Jan 2021 05:26:52 EST
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailforward.west.internal (Postfix) with ESMTP id 23F08C9B;
        Sat, 30 Jan 2021 05:19:18 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 30 Jan 2021 05:19:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=date:from:message-id:subject:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; bh=397zJM2g+eyDtP0UG7T3G6obkTkhMA+WLsSd/kYaYs4=; b=AxTfWdHr
        u1DlQcadMtQCiUPhWJrvOq2q7EOJp4HoCj5KW8JUy+cRKv1TVyAKgfEw/inAEmy9
        wrkqgkatYObpiYv6Pgb/ZUIucxR2bluThCr0eoNguXSINGC5D17iXR4Deup1VKvr
        TC8p98srC1Gz0pdDYO9qagK5quhcbTR3iPSUqQiwW05jEQqKNPCmtcbQiD33lZFK
        tMZ+fAPNPfjnXC47qQCw3o7WdI+KdNwdb14SNuyr+9LQN+swXToYxkrrcJkUIP/E
        5JxMM3FaUuwc0qpk7ZA2Y5zhkErQY3RNufStpbkppc63QCG6PEZa2z57RTHUiHp+
        qpUdDMiOOOo6SA==
X-ME-Sender: <xms:pTIVYFv40qfXLeyGLgPduD_OcxUkxOny2KP3LfIhd73Rt7itjC1WDg>
    <xme:pTIVYOeczyU0GDOn4mfrQjhsE6gulyRZBQBxHgH3rBgdXJpJR41lY1lEzB9T8Mdhv
    nEux3MAWF-9_JiTwQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeeggdduiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecunecujfgurhephffvufffkfestddtredttddttdenuc
    fhrhhomhepfdfmhihlvgculfdrucfotgfmrgihfdcuoehmrggtkhihlhgvsehgmhgrihhl
    rdgtohhmqeenucggtffrrghtthgvrhhnpeetudeivdekteevheelueehgeekgfeiveelte
    ehffeffedugfdttdegfeffgfekieenucffohhmrghinhepghhithhhuhgsrdgtohhmnecu
    kfhppeejiedrudekrdduvddvrddvfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepmhgrtghkhihlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:pTIVYIywsY5BNyTnfACiGBamssYMnj56d2Q0gndNMlo0P5kkvaz_5Q>
    <xmx:pTIVYMNfOdRX9nMwrQLLRbyXE0Sge6-4pEWxVS_72IA6RLpT_Bd-3g>
    <xmx:pTIVYF-8foZLgO82lVwzX2o73RsJmT49wSD1WVqpoeh5lyMUl5x-mA>
    <xmx:pTIVYAZEJb1YnWMwkf1ehhtFx5a6L6NT7Qq8NdOfHom5wcCUva5a6JQf9bM>
Received: from localhost.localdomain (unknown [76.18.122.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id DD1D124005B;
        Sat, 30 Jan 2021 05:19:16 -0500 (EST)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>,
        Git mailing list <git@vger.kernel.org>
Subject: [PATCH 0/2] Eliminate extraneous ref log entries
Date:   Sat, 30 Jan 2021 03:19:07 -0700
Message-Id: <7c7e8679f2da7e1475606d698b2da8c@72481c9465c8b2c4aaff8b77ab5e23c>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since Git version v2.29.0, the `git symbolic-ref` command has started
adding extraneous entries to the ref log of the symbolic ref it's
updating.

This change was inadvertently introduced in commit 523fa69c36744ae6
("reflog: cleanse messages in the refs.c layer", 2020-07-10, v2.29.0).

A bug report [1] was made about a failing test in the TopGit test
suite.  Further investigations into the cause led to this patch set.

1/2 - adds new tests to monitor this behavior
2/2 - corrects the problem

The tests added in 1/2 are marked `test_expect_failure` and then
changed to `test_expect_success` in 2/2.

-Kyle

[1]: <https://github.com/mackyle/topgit/issues/17>

Kyle J. McKay (2):
  t/t1417: test symbolic-ref effects on ref logs
  refs.c: avoid creating extra unwanted reflog entries

 refs.c                   | 16 +++----
 t/t1417-reflog-symref.sh | 91 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 100 insertions(+), 7 deletions(-)
 create mode 100755 t/t1417-reflog-symref.sh

-- 
