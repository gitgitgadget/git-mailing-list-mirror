Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B97AC433EF
	for <git@archiver.kernel.org>; Sun, 26 Jun 2022 18:18:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbiFZSST (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 26 Jun 2022 14:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229727AbiFZSSS (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 26 Jun 2022 14:18:18 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B5372DC4
        for <git@vger.kernel.org>; Sun, 26 Jun 2022 11:18:17 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E38085C0154;
        Sun, 26 Jun 2022 14:18:13 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Sun, 26 Jun 2022 14:18:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1656267493; x=1656353893; bh=QBFULvA279
        CqobYE4EbQEL3kWATIrneO47cbd0ebZsI=; b=QC+eJtFbh0IIyR50N96zYrRcAD
        V+2u2Qoui8UBFz8b1Qiv5aTQyX/BRNT5OB5ShPDKwF1ZX0B7J+6iH1JpY+1QNOvO
        dZYQdG7yEeux8/S4FMsfkA3v4+pPnYRP5GyXlvN5B80LFsXbp6HE88xWlLDu3/RE
        RKfQCKColA9w9fGai8S8oPWkzC1MZp2TKa2OhwOqem7X+LF3ztuoSoaBJyNzCgct
        JUt0N/hPxSP9kO44FRzCZBwbLcnd/NCEUoHs/kBvC/01vXzohchoTOaWBAFaeTaZ
        yNfzl77QlZ1mnJbR5f2nY67GMWKkS93jOg9n8FwCZEn1T3JZxw+13lAvN7mQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1656267493; x=1656353893; bh=QBFULvA279CqobYE4EbQEL3kWATI
        rneO47cbd0ebZsI=; b=HnReLrrMP7JqmIGxfK3xpHMeD9/YMnfGu8vY3G7AFfIt
        gzFj60UXetHn00LRKPxnEIhgEQVUDqIwocPFl2LMzg4ZhAg2GYaREPtlzsPJOlVc
        0wTjRWptTbkQUDcCIb5WC+YBJmjDvFpjZQPZ7w7qQo4tSma0na9PIq9D3mvi57qc
        l91JGYFtXianGHTxkwsZjNepi65hGetdZxbr7ORAgvQiMfPW1soOmaMh6WB+wdEq
        3KnoeUbpnKUTs12uqhJnCdgADayhLF8Cbz3q6zmPTSb2W4Ho9Piln39wzmpExUE0
        C1JCEGnEzpkpf+5REoKwz2T+ZgYuzlyZ/5kOMuYtVg==
X-ME-Sender: <xms:5aK4YrcgB8lV7Q1PoycR_uzIuLHWsaUC8sdV7UzJN2DQP1xvBRBLtw>
    <xme:5aK4YhN0FyLNonyhFTiJJvPdXvKhXX_G1GBuvkDqrQSFOF1Fr46rB6hNnIy30oig6
    m7GtGcFHVuEs6sTYw>
X-ME-Received: <xmr:5aK4YkjWKQlFw_ouA9h6pVKYMtY8Qu37VfVUF1SW_3s5OeEzrN1n-Zs3ToGVwElZMPFYH_7RdOQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrudegfedguddvhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuffkfhggtggujgesth
    dtredttddtjeenucfhrhhomhephfgvrhhnrghnughoucftrghmohhsuceoghhrvggvnhhf
    ohhosehuledvrdgvuheqnecuggftrfgrthhtvghrnhepgedvieffveejteejueegudehgf
    ekueehvdfgkeeutefgjefhffdugeettdefjeefnecuffhomhgrihhnpehuledvrdgvuhen
    ucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvg
    hnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:5aK4Ys9YmLwIRF_vT64NTrRiMlC4RhPZFBsonG8gdSVJ_2ugRZtUNw>
    <xmx:5aK4YnuOv8mC3S-9jbzRpCaD54fD-w9kjUktP_9UOZcX-sw4cajqaA>
    <xmx:5aK4YrHI3IQ0ne4KAQ2ER6oM3-qlqoftK1ugwaGHNO41HXqBRHYwaA>
    <xmx:5aK4Yl10MAON_yqmjdh6mewFb7QGhzBKNE8iUoLg0oLh3LI1DqnSJg>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Jun 2022 14:18:12 -0400 (EDT)
Date:   Sun, 26 Jun 2022 20:18:09 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [ANNOUNCE] Git v2.37.0-rc2
Message-ID: <Yrii4Wj+c0YuQy61@zacax395.localdomain>
References: <xmqqedzg4hqj.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqedzg4hqj.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/06/22 12:32PM, Junio C Hamano wrote:
>  * "vimdiff[123]" mergetool drivers have been reimplemented with a
>    more generic layout mechanism.

Hi. Maybe because this is my first contribution to git I was strangely excited
and decided to create a small blog post describing how the new mechanism works.

There is no javascript nor tracking nor ads... just good old html/css/pngs
explaining how and when to use `mergetool.vimdiff.layout`:

  https://u92.eu/blog/git-vimdiff/

Hope someone finds this useful :)

PS: Please let me know if this type of message is not appropriate for this
mailing list and I will never do it again... I just thought it might be good to
explain the new feature in a blog post to prevent it from going unnoticied
considering how "hidden" the new configuration variable is. Thanks!
