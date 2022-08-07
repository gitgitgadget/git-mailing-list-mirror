Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50115C19F2A
	for <git@archiver.kernel.org>; Sun,  7 Aug 2022 14:46:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234091AbiHGOqe (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 7 Aug 2022 10:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233475AbiHGOqd (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 7 Aug 2022 10:46:33 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7599765CD
        for <git@vger.kernel.org>; Sun,  7 Aug 2022 07:46:32 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id D9FD55C0083;
        Sun,  7 Aug 2022 10:46:31 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Sun, 07 Aug 2022 10:46:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=u92.eu; h=cc:cc
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1659883591; x=1659969991; bh=4VxISxINll
        hIsriXOEZPR0AXTISFXRGeCkrfQh5rgNk=; b=j6PRJ1Rp1fAFloZ9uGPZyFaWVu
        aljV/Th8/thRcUbGF/Q0akvaubcCDMXvWUjtAHUA0xCVxFNO2GNq1P2v3xsPzqMh
        vqCvDYJ9g1KC1+Z+0xDGFzxviRz93IO0hord1mxh6JHaBo92p3rFerUzhvk+M+Yq
        Nfm6cV47HSQq9zl0NYBA2hVMAG67riNQDdWuUSMT4ocnUkh3sRgDpgO444HMAb09
        jt1wSDVGMGkDMIM9lSH4tDTVZm1MVQ7BXD1MNN0J85Oc4hQFulbjIyMjqPBpxoVI
        p3m/X7czznY4FEWIQLdyY/kOqyk505wstprdJycGmC9UjEJl3oYkOsFhQb9Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1659883591; x=1659969991; bh=4VxISxINllhIsriXOEZPR0AXTISF
        XRGeCkrfQh5rgNk=; b=cagvMb6Ad++tL++GhbvPbgNGdh6vg55eEbOr9t4qoX/u
        Vpf1+X0nfuIDZ6iOg7P9rlEWBOYYg4E00Oni8qEQuY2vevtmVb3rOEbHRKDqCs/7
        3V/Yt94PHUF0iQLZt39A66jQ7xTaYjbYFZnGqmBCHpWbVjXsQ4W9N/Z3VhcFHUq1
        vLENfxkJwBRkgijx6fva4DKD6OAnGdolFP+j7bAGm8epgnFss40mWfhqEqS0t7/P
        Xf9yU+2kFvsCoFdnoXPCY+g1tuNv9Q/mbTy+aCWIrpGEM5vbQd6mb9ScfIevlo6+
        HOcmGsSSx/2F3lBlFd/+qy49gWkNNiT7HWkSqAWogQ==
X-ME-Sender: <xms:R9DvYoAcWsLgYtaxHX4t3rGuhlvwuqWUUVrhmayyPSzlnVeTimt3zw>
    <xme:R9DvYqg-70N0vpZ46skuFj3huaC1AsMiB4wPTBM-rEPN44Xx2hO3h0v9viKdUjEPf
    S0UFwhAt3n0AqEPNw>
X-ME-Received: <xmr:R9DvYrn1aEnj9eLGvjIddZ1OjeLV-qWLnVPkqW6Yia4wnyUEBfzp6aZXaEcOT9Z2ppN-e15GTt0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrvdefiedgkedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtjeenucfhrhhomhephfgvrhhn
    rghnughoucftrghmohhsuceoghhrvggvnhhfohhosehuledvrdgvuheqnecuggftrfgrth
    htvghrnhepfeelteegfefhudeiiedtgeeihefhudduhfdutddtkefgudfhudeifeetkefh
    udevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgrhgvvghnfhhoohesuhelvddrvghu
X-ME-Proxy: <xmx:R9DvYuxB5MdNy7KaXzf9wcU0upMmOx2lhJfD22VayPyteXEm0dL2zQ>
    <xmx:R9DvYtTdPdnQ8RE6ZZdIaZbZHnNaG47kUCNtSK-d2O1enVBtMCvdiQ>
    <xmx:R9DvYpaH-uwmNJYPk3toP4n_DyXlbsZNROaQKvk-mTuPkFDcjTKErA>
    <xmx:R9DvYu6wLzqXhleUgpbYHPkfBFPs0-MKUru7Yhl8ySnXjbIB8ypXtQ>
Feedback-ID: i96f14706:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 7 Aug 2022 10:46:30 -0400 (EDT)
Date:   Sun, 7 Aug 2022 16:46:25 +0200
From:   Fernando Ramos <greenfoo@u92.eu>
To:     Felipe Contreras <felipe.contreras@gmail.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH v2 2/9] mergetools: vimdiff: shuffle single window case
Message-ID: <Yu/QQe4lz2MhiCQp@zacax395.localdomain>
References: <20220807024941.222018-1-felipe.contreras@gmail.com>
 <20220807024941.222018-3-felipe.contreras@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220807024941.222018-3-felipe.contreras@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 22/08/06 09:49PM, Felipe Contreras wrote:
>
> +	# A single window is handled specially
> +
> +	if ! echo "$LAYOUT" | grep ",\|/" >/dev/null
> +	then
> +		CMD=$(gen_cmd_aux "$LAYOUT")
> +		FINAL_CMD="-c \"$CMD | bufdo diffthis\" -c \"tabfirst\""
> +		return
> +	fi

If you make this change, it fixes the first issue I was referring to in [1]

-       if ! echo "$LAYOUT" | grep ",\|/" >/dev/null
+       if ! echo "$LAYOUT" | grep ",\|/\|\+" >/dev/null


[1] https://lore.kernel.org/git/Yu9vvAKJzOpoQ5AS@zacax395.localdomain/

