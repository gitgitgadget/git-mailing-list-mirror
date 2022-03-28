Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 746C5C433F5
	for <git@archiver.kernel.org>; Mon, 28 Mar 2022 22:39:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230053AbiC1Wk5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Mar 2022 18:40:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230038AbiC1Wk4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Mar 2022 18:40:56 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89484A3C3
        for <git@vger.kernel.org>; Mon, 28 Mar 2022 15:39:14 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.west.internal (Postfix) with ESMTP id EE7D33201DD2;
        Mon, 28 Mar 2022 18:39:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Mon, 28 Mar 2022 18:39:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=Nr94l0v0qE6rC/kDacmYKCt8pQ8ULAiXKmIbn7
        92TSE=; b=s/xvyoBNdo8ekp7ECv8oJxuTeyb3DojLTs+XACryvpryFIueGVrr6h
        W9XGrAgmT/k2q4++bNRd1JthG8V+T0qoKXurrzx5wrncE/LDCs27YtWDkP85g3zk
        mDa1XNfYI40GhJvyL2lxSLMpefVJ3C1bje0BM04yg4dokuIMuMbUEEHu3Gfz7r+V
        Wrip8oZVbf6jQLQ5R7fzLWHxzCcvo5JoVX/lnym4ENQm9WI/INzj+4VIFvCt8N2U
        4NiLPyQlLZTXq/U6Gu1nH7tvZPr8oJCvh+vCTmFYum9q2xAyiqdK8jQ6HlayAHH/
        aJ8FfNMaINd5rUid5qPzUCbmzd+F2INA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=Nr94l0v0qE6rC/kDa
        cmYKCt8pQ8ULAiXKmIbn792TSE=; b=fjQ2Kag8cZg8nMx7PcgdsYpBHYubw6iv5
        o3hh3zc6PvpdHcsdk3XauxOrc21e2KctDTrHmpWNIcw3bW1DUOpkukqj0Xx4LSIp
        kEegwQKguRkR8qBGNWctXyCTpPkJakEphhOoBsdmn4Vw/od/QrCoWUETsZaqq2Rb
        jwCDSlxsCONpDg5Zv8K9rrXMnsgIt+DShY7sCJa5ewAH+eqLo9ifFbkuvccdXcI1
        GpLQ9sn67x4j6DiazkeS2BGXncWwxU/NTJe/IxbaB6Kohl5EqwSWbY3PkwxUwIYE
        aS2C2GoYwlCtVuWd8OWyuDQ5Raft6Ow3MToiHo+YNPpx9tJMVnjsQ==
X-ME-Sender: <xms:ETlCYlGDQolNHwgxaewkjfbpu4MINkp8Oz8YUUSx2rSPm7p45M_8qg>
    <xme:ETlCYqXL7sfXUBX8lujj6qv_Xi4M-K1o621bkTi4sd2qOARL1Akshh7nd5_w2dtSg
    kDUm-tBldwA_dFm9w>
X-ME-Received: <xmr:ETlCYnJLH3WWlDpKpNqobmWnXfiqB_TUfw2GZOXsNAyxNf72Ib9wVuC8l2nraiY6Ce8S3fB50TY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudehkedgudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkfhggtggujgesthdtre
    dttddtjeenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhfohho
    sehuledvrdgvuheqnecuggftrfgrthhtvghrnhepvdejieeflefhteeihffhtdfhfeekhf
    fhuedttedvgfevgfevfeehfffgkeejfeehnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhrvggvnhhfohhosehuledvrdgvuh
X-ME-Proxy: <xmx:ETlCYrH3Fqq_HXW4kg0ZvGJXWiRKz58VEOgxLW6Ht6BTOLPKxZS5qQ>
    <xmx:ETlCYrVAwB_Sg1ELsNyunVySXh2diYaoJo-irYW09j_cZUb_ifk88g>
    <xmx:ETlCYmPHwFxN4FlLahS9doqevetxvhTMhSxv9piYZQHCCRmxyosO1w>
    <xmx:ETlCYtJeC-sFQ4QdAX0vlJVlz8eMyxz7sDz0sZjhRJSeiYKnNKTgkw>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Mar 2022 18:39:10 -0400 (EDT)
Date:   Tue, 29 Mar 2022 00:39:08 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, davvid@gmail.com, sunshine@sunshineco.com,
        seth@eseth.com, levraiphilippeblain@gmail.com,
        rogi@skylittlesystem.org, bagasdotme@gmail.com
Subject: Re: [PATCH v7 3/4] vimdiff: add tool documentation
Message-ID: <YkI5Afkyr9H6teMw@zacax395.localdomain>
References: <20220328223019.271270-1-greenfoo@u92.eu>
 <20220328223019.271270-4-greenfoo@u92.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220328223019.271270-4-greenfoo@u92.eu>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When applying this patch I still get "indent with spaces" errors:

    .git/rebase-apply/patch:121: indent with spaces.
               ------------------------------------------
    .git/rebase-apply/patch:122: indent with spaces.
               |             |           |              |
    .git/rebase-apply/patch:123: indent with spaces.
               |             |           |              |
    .git/rebase-apply/patch:124: indent with spaces.
               |   LOCAL     |   MERGED  |   REMOTE     |
    .git/rebase-apply/patch:125: indent with spaces.
               |             |           |              |
    warning: squelched 61 whitespace errors
    warning: 66 lines add whitespace errors.

The thing is these are no real errors (I really want to use spaces here).

Am I doing something wrong?
