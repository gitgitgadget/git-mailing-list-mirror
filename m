Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F089C19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 07:54:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233544AbiHGHyn (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 03:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53260 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiHGHyl (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 03:54:41 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 131C9FD15
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 00:54:41 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 4EDAB5C008E;
        Sun,  7 Aug 2022 03:54:40 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 07 Aug 2022 03:54:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659858880; x=1659945280; bh=+QRtf/Ugvd
        fok+OoaIY76oCVKvJW5Nsb4Tteks8YGSw=; b=PFcgR7klJwp4+uSuvk4TIoPD0N
        qjUDxFB5aR/Nmbi9KK4Wwpqp6NgzlrGEh1XvOQYVfQixYsZxH2FkKjkA5W4CkOsB
        MS9Fu7Jxcs84zB6nzJklNiozbqcFNXUYYyRIKOz8lYyWwUa3T5RQP/KFHWNIQEmy
        F205CtLmRzhhjEOUARv652yMrVusPKEG5JwEnBnmIo8jPwO3CYqPMHHW8MO9gxdB
        B2YxHfG9ad59Fc3Eb5J4mvgchLNrhuV7uICZHKXZXnTseCsrhkD2Py+yMaieMs+E
        fLCK7Jchv9CB3CM792QCDr+RZXLEMy8ojMoVlsBy3sJdPVs9hvvxjE3Rve8A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659858880; x=1659945280; bh=+QRtf/Ugvdfok+OoaIY76oCVKvJW
        5Nsb4Tteks8YGSw=; b=kL8aIyUw7PIP3UloSBlhZoQM6ahDbzXDgdY4AuU/A1X+
        16fTwGiLa10wawXIBjYvJwnI0aBThDjNXBgAZTCpc+/Lb3AQBnCKpPTtjl1nvD9t
        Gf+SlfrH9e694sL4IkhgA2TztF0h7WCl62AjSCP8ZOMIZmccIg3wqBHyu5DL7pP6
        f9WgYbIGLb0MfSLCGLu1eYJodp12zInxUDSvjj3Pn+TVnhay5jlTfPZwgS7ZHp7T
        bRNHhykAFBVSJPpyWkuXRH9U4jkF98nQ3QI8+XNrtBZssA/l82PfTpmV52P88Qhj
        vPyKOzIpp+CH3W8mbnV2E39KaDQYT6i/L7BLO54/wg==
X-ME-Sender: <xms:wG_vYv4cLPjbXprE9T3Pn1iNNVQpRymykJkx6tohmgv4Zje1oU3NyA>
    <xme:wG_vYk6o8pK0H1ZRx02B5QSAxUC2r5Nws-2W52HAXLRgQp-R5Mls1O92ktpaX_isi
    RqsNLsahhgmDiuuGw>
X-ME-Received: <xmr:wG_vYmcV0Fdn3aWl68Y1AH_UJ-kIhZmN5J3zKl126v9LirQpnW9Glpes-CaeeUYz03Gv91XOrVU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefhedgvdefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhephfgvrhhn
    rghnughoucftrghmohhsuceoghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrth
    htvghrnhepffehveetfeejveeikeehueejieevgfeuvdeifeelueeigfdttdelleehveel
    vdejnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:wG_vYgITq6hWOKTgcBEd9aCfA97jnjkl-tvNkKbfYwZvalQ08CB8aA>
    <xmx:wG_vYjKoBgKqe1dM19sifQGjiZCpjIVTbSaORfwYBiLxRf8Yxw6pdg>
    <xmx:wG_vYpwl8cIKg7eZNi2uqGGMfzRJNoKPmkdfU_8JLwBILiOv7jAQPQ>
    <xmx:wG_vYlzYTcjlXRiEsBImm0ZDusxjZGIOT8dyxgo8uj2KkLRYiBCTlg>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Aug 2022 03:54:39 -0400 (EDT)
Date:   Sun, 7 Aug 2022 09:54:36 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 0/9] mergetools: vimdiff: regression fix and reorg
Message-ID: <Yu9vvAKJzOpoQ5AS@zacax395.localdomain>
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220807024941.222018-1-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks Felipe, this new patch is much cleaner than mine.

Just two comments:

    1. Due to the way single windows are now detected, layouts with multiple
       tabs but single windows on each of them do not work. Example:

         layout = LOCAL + BASE + REMOTE + MERGED

       (we should probably add a test case for this)

       I noticed it did also not work in "master" (but it looks like it does in
       the patch I sent yesterday)


    2. Tabs with a single window are not highlighted (this was also a problem in
       "master", I just noticed this when testing your changes)


I'll try to figure out how to fix this (but I won't be able to do so until
tomorrow).

Thanks.

