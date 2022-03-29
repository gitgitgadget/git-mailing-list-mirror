Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A64BC433EF
	for <git@archiver.kernel.org>; Tue, 29 Mar 2022 21:45:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbiC2VrD (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 29 Mar 2022 17:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234957AbiC2VrB (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 29 Mar 2022 17:47:01 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3FAC343ACD
        for <git@vger.kernel.org>; Tue, 29 Mar 2022 14:45:16 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 8129B3201DFD;
        Tue, 29 Mar 2022 17:45:13 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 29 Mar 2022 17:45:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; bh=RI90Rr2pdI9C358C8ov5lMD5fBubBiZsQJe5D+
        Gv2+k=; b=zGwPTnlMoNGgeB8hmX8KNtCfwHZkGkw6nWA00XRDEGb6LEWt2TOTSQ
        9CenKcg2ll6KpkiymZunxP1rMWV5heWIvRVJGdVdLcL0uKKdayCRfs+Wj3AwsFnD
        HUO4MRU7y9L0FgjlX7Lo6vhtA5Mm0zKPMCSB+ZC4BSdBbPsqjvLFLl0rTV8oFzcN
        e+h6P3B5r2ZgvPRxGCdQoLIBrG2hD7RCoL2W+KUcolUvZGOY+VCf0ZLa/CbIF7Ds
        NxMyXnQj9yolFYSvSAnVy0Om1T/lp/8ZsWV31JSA5+MAnyDh1f+V1wM2QZgoENc4
        YXxJcld+5OOdUk60RSHF2iS+fXEM1n+g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; bh=RI90Rr2pdI9C358C8
        ov5lMD5fBubBiZsQJe5D+Gv2+k=; b=etnCp3MDD/9LaZCsQ1h02JB8EmRdbm9e6
        zpURoU3GKpiWXu5ITVBXWmsSIeaX2ncu4YI9gnnBr2b9c8YRYgIqkTTKiIbmy6eR
        Op+HmhjRKeBUtxHP7BTiYe2dbiiK/9ORbvJS9KSsIhV5eMC3CKwng7q81rbr5jTu
        CWWiZJAGgJklJ105NEECQcLmWtNx70jZ8MiOCRWr4RYt7bOT+LyhueKb+y65fHIQ
        8potZ/EK8u6rcVKgZRzXRSqDNYUMxGt2gkdaGdjbR92nK4fJyrpwjjt9O0tVwgqO
        Zz5RpE7ORkSbjyfZMZ9VGPau2E3jHlUbO8J9a0Pgu/LCVCzw2kCbw==
X-ME-Sender: <xms:6H1DYnoQbq-jZWiWLH7oC3Fl0f015Vl4hyV4DgN9av7ueTPy0tyo0w>
    <xme:6H1DYhq8GNkMIOasWt5cc50he4qvN9YO34VE9H31jPpkinmA-SPBtg5aBnTQV3vfp
    Z1FB1E5OQM6hE836w>
X-ME-Received: <xmr:6H1DYkPL35PyYnucCdC6uzwmLvzKipvH0KnNZ1Vx5YeLZwtVnDdY9ZssSQ0d13cC-fC-RiBXXVA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvvddrudeiuddgtdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvffukfhfgggtuggjsehttdertddttdejnecuhfhrohhmpefhvghrnhgr
    nhguohcutfgrmhhoshcuoehgrhgvvghnfhhoohesuhelvddrvghuqeenucggtffrrghtth
    gvrhhnpedvjeeifeelhfetiefhhfdthfefkefhhfeutdetvdfgvefgveefheffgfekjeef
    heenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrh
    gvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:6H1DYq4pj8fuQnMfWWO4YiZ72jOBilGUSkVw1g7pDPW-Zq21a-AUZg>
    <xmx:6H1DYm7XEiTD0-NTSZzlp_Z-F0eoi-Hi2z_FR3rNPxN36gXl2Qzq6A>
    <xmx:6H1DYigq4cd-nyt3abCznD-qeEHX-jDZ9sEmOV7-pzwIu5Ml_Z-XIw>
    <xmx:6X1DYjuIyEmnFWVv5DR0P4dpC2akW4SviMw8k9wULo98boCK-s-6lA>
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Mar 2022 17:45:10 -0400 (EDT)
Date:   Tue, 29 Mar 2022 23:45:08 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Philippe Blain <levraiphilippeblain@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, davvid@gmail.com,
        sunshine@sunshineco.com, seth@eseth.com, rogi@skylittlesystem.org,
        bagasdotme@gmail.com
Subject: Re: [PATCH v7 0/4] vimdiff: new implementation with layout support
Message-ID: <YkN95Lj/WjGilTTy@zacax395.localdomain>
References: <20220328223019.271270-1-greenfoo@u92.eu>
 <374f45ff-ca55-780c-3b26-8b7c6a761725@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <374f45ff-ca55-780c-3b26-8b7c6a761725@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> Just a small suggestion, it is customary on this list
> to send later versions of a series as a reply to the cover
> letter of the previous iteration. This keeps the whole series
> in a single thread, and also allows tools like 'b4' [1] to apply
> the latest iteration when given any message-id in the thread.

Thanks, I really appreciate this.

It's really hard to find the correct way to interact with different mailing
lists from different projects.

Maybe a monitoring bot could send an email with all the mailing list rules to
someone sending a message for the first time?
