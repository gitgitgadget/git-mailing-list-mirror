Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CEF8C00140
	for <git@archiver.kernel.org>; Mon,  8 Aug 2022 05:35:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233759AbiHHFfL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 Aug 2022 01:35:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbiHHFfK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 Aug 2022 01:35:10 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE447B1C6
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 22:35:08 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 04D2032004ED;
        Mon,  8 Aug 2022 01:35:05 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Mon, 08 Aug 2022 01:35:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1659936905; x=1660023305; bh=8G
        ELgTz7egS3iaK+B+Gad/Cygxl/gVdLcb7itypytsY=; b=ClvgyYi3PHIjF5r4Qd
        ifF2OKKVsSh1FPDmk8aTWWVl3+sfY9x+R6CE9QS2X06DvyJ+xnEjyagEL8Fxpt/E
        if+NYwalf7iRf4j0fbpTpyNhrEHzQvFCseGucHEyB22JfQpmquGIB9YxEQ/TU8jC
        6pIXKMfwxHWwX5x/ET/+X4QH7Xz01mJUGIlAB1kqU6lgYLAb5G4A1YMMOYeoLJL8
        2z6zERl3YHgi93lh0lBOspOkpWf8JZed5zuVP5gyS7hn1ddHk/6HsUCEqYoJOIrd
        b9fA4SkihYuj670tdhg9/g52YmAG19UI34tODvShvvvbHWkTtDhEbeJDHRqwxKSI
        f8xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1659936905; x=1660023305; bh=8GELgTz7egS3i
        aK+B+Gad/Cygxl/gVdLcb7itypytsY=; b=3yWyVVN5k8MT1ut6I11MY9w1+ysMr
        9C2fW/qZqkiozslhEI/yiHFcM0EDcfk4SpY70Tzlerdhaf0sUv1Ndwgq9lBU/LJW
        PLIJJ6tQffo2WPdpzK/9iRMpcdEhdpf0WChCgqPi1+XlndE6NsCW1eA/uqs5z3vi
        kXnAIO8OVQQ9XDvUeFgEcHKktv3utIzjLWecPJyhmq4kbgc/9oyCjJVu1j/vPnGz
        hsqs1tuLykIR8w7fDE4VamLRSN8arg4nH4S1lfhpCuNUHx6JgegJaHklQVrCYYKC
        Y3Dgh4SldF2R8DaKGqrNpN+JIbCM1L/al8/1jf2t2vsufIOkzHY8XeVqQ==
X-ME-Sender: <xms:iaDwYtrHEAnDdjSixutN3jI2aLmr3fFORHeBRJjG1p9U5CltfHKKkQ>
    <xme:iaDwYvoPoYD7qx-BdFvX61SoEwzrCHpirE7gsFE6_u_666HXaGspWz9keTkD44K0C
    QG_jP9eIScrWlLNHg>
X-ME-Received: <xmr:iaDwYqPBxvZK9BCCXQHZhnSheM7wsxmVxKbfsuNSQxjdIbw4y9pyUCMUGFo3t5y6Oy0-11882dkv>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefjedgleegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhephfgvrhhnrghnughoucft
    rghmohhsuceoghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrthhtvghrnhepie
    euvdeggfdvteetkeevtedtgfehudettdelvdegvdfffefgffevgfeujeehveeunecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfoh
    hosehuledvrdgvuh
X-ME-Proxy: <xmx:iaDwYo5QwMWlL3g9cWLDEoDv0skQ3md5X6jgF_dOxJqCFx88vRCmRw>
    <xmx:iaDwYs6kbZ6nd4hvKPDaeIaosQY0Qwbejg8-bVNC7gsF_AcDc1rmKw>
    <xmx:iaDwYgjcjgn5oDiRtNU1RidTvJdH1BpY_ux2ZYE7KB0RvZ833uhmow>
    <xmx:iaDwYqSfr-FLOrfJSwj9I8g0bYVPu29qv4GRNE_7cz4z-8QQn_qO0g>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Aug 2022 01:35:03 -0400 (EDT)
From:   Fernando Ramos <greenfoo@u92.eu>
To:     greenfoo@u92.eu
Cc:     felipe.contreras@gmail.com, git@vger.kernel.org
Subject: [PATCH v3 0/3] mergetools: vimdiff: regression fix (vimdiff3 mode)
Date:   Mon,  8 Aug 2022 07:34:56 +0200
Message-Id: <20220808053459.184367-1-greenfoo@u92.eu>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220807024941.222018-1-felipe.contreras@gmail.com>
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Felipe detected that color highlighting no longer worked when running "git
mergetools -t vimdiff3".

Deeper inspection of the problem revealed that color highlighting was also not
working in other cases (layouts that contained a single window in one of their
tabs)

The current patch series fixes the issue by doing two things:

  1. Making single tab + single window modes (such as "vimdiff3") use the same
     code path as all other layouts.

  2. Fixing the general "single window" case so that color highlighting also
     works there (and this is achieved by adding all buffers to the diff group
     in single window tabs).

In other words, after this patch:

  A) Tabs with more than one window will only highlight differences between the
     buffers shown in those windows.

  B) Tabs with just one window (and this also covers the more specific case of
     layouts with just one tab containing one window) will highlight differences
     between all buffers (LOCAL, BASE, REMOTE, MERGED).


Felipe Contreras (1):
  mergetools: vimdiff: fix comment

Fernando Ramos (2):
  mergetools: vimdiff: fix single tab mode, single window mode and
    colors
  mergetools: vimdiff: update unit tests

 mergetools/vimdiff | 109 +++++++++++++++++++++++++++++----------------
 1 file changed, 70 insertions(+), 39 deletions(-)

-- 
2.37.1

