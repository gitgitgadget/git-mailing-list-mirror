Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E458FC433DB
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 23:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7FA464E0A
	for <git@archiver.kernel.org>; Sat, 30 Jan 2021 23:12:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbhA3XLq (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 30 Jan 2021 18:11:46 -0500
Received: from forward1-smtp.messagingengine.com ([66.111.4.223]:40781 "EHLO
        forward1-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230168AbhA3XLq (ORCPT
        <rfc822;git@vger.kernel.org>); Sat, 30 Jan 2021 18:11:46 -0500
X-Greylist: delayed 532 seconds by postgrey-1.27 at vger.kernel.org; Sat, 30 Jan 2021 18:11:46 EST
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailforward.nyi.internal (Postfix) with ESMTP id D61AF1953288;
        Sat, 30 Jan 2021 18:02:12 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 30 Jan 2021 18:02:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :date:from:in-reply-to:message-id:mime-version:references
        :subject:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; bh=D1gm4c4QW0sERbFT0cx7bO+AN3REDY5+ORf6C8Y87
        hY=; b=eEKe/XWE3OYct4mPL309WTkl3kheBbSKRJK2Cs0mX++Em9Gy7aVA7Jazv
        VfTcvWNwwlub5wiDDKUPWXwH2DPbl/6YjXtS35zpn3kycrLWqCU2SYiJWLvupN6Y
        xdiZt5fF7Il12Gz4f+QTxS43Fn9CC2LznJdZhET+NAHdMWN6uGCJjUCESVCy55Gz
        ++nSPFokR5zTp9Uv7UnBdI39UHUagXeSpZI4mVhy6Ko8T4HbXrwHF7+Cyesgc4JB
        ssc5pgPHuRFMOxIhV4PVTJv0zts7gwId89F42MMQDI1p+LT3Fh89MQU19cy8tIom
        2PPM/IBs7f8WdDskzobzAgcPrt1vg==
X-ME-Sender: <xms:dOUVYGFuUyeLEpb59Nz4nWCfzRMPDJhapH41Kk-8GDuGzSQ8c8O4Jg>
    <xme:dOUVYHVBE9sNhpDnsqESoWNd9QWmRmdUbiSm8lpthkMg1ccuGACYRzUqqbE0-I0pX
    oYbvmaB9goSlzG8WA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeduledrfeehgddtfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfgjufhfkfgtgfggffesthejmhdttddtvdenucfhrhhomhepfdfmhihlvgcu
    lfdrucfotgfmrgihfdcuoehmrggtkhihlhgvsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejleekjedvjeejjedvkeektdelvedvvddugffgkeeiheeukedvffehhfei
    geejteenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecukfhppeejiedrudekrdduvd
    dvrddvfedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhho
    mhepmhgrtghkhihlvgesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:dOUVYAJVPlkD2qRUgp1Tn0Pt28en8aWGm5gwB7FiYlAj69xjS8Jm-Q>
    <xmx:dOUVYAFqpV6kdatvnbu9pfi4rKjHVeOhxjenmPOGU049pQNCxiafzw>
    <xmx:dOUVYMXM2ryxdNHl88Ag32cql6vPNQJiqJqRmpj0f9T8ubNU7YVfKQ>
    <xmx:dOUVYKxUcppxbfT5eQ-59rSvjD456AQi0Ev3FperoD2M_hnCqwetvA>
Received: from [172.16.16.105] (unknown [76.18.122.232])
        by mail.messagingengine.com (Postfix) with ESMTPA id 1F3E924005A;
        Sat, 30 Jan 2021 18:02:12 -0500 (EST)
From:   "Kyle J. McKay" <mackyle@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
In-Reply-To: <xmqqa6sqp827.fsf@gitster.c.googlers.com>
Subject: Re: [PATCH 1/2] t/t1417: test symbolic-ref effects on ref logs
References: <7c7e8679f2da7e1475606d698b2da8c@72481c9465c8b2c4aaff8b77ab5e23c> <fec7ef37962da584a89012234ae4a1a@72481c9465c8b2c4aaff8b77ab5e23c> <xmqqa6sqp827.fsf@gitster.c.googlers.com>
Message-Id: <028152B6-DA5B-40F7-B944-FF4F31C2BC56@gmail.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Mime-Version: 1.0 (Apple Message framework v936)
Date:   Sat, 30 Jan 2021 16:02:03 -0700
Cc:     Git mailing list <git@vger.kernel.org>,
        Han-Wen Nienhuys <hanwen@google.com>
X-Mauler: Craptastic (2.936)
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Jan 30, 2021, at 11:56, Junio C Hamano wrote:

> The said commit came as part of this topic, ...
>
> https://lore.kernel.org/git/pull.669.v2.git.1594401593.gitgitgadget@gmail.com/
>
> ... so I've added the true author of it on the Cc: list.

Out of curiosity, if Han-Wen Nienhuys is the true author of commit  
523fa69c36744ae6 why is it that you are both the committer and author  
of that commit in the commit's header?

The answer may also inform others trying to determine the best list of  
recipients for patches...
