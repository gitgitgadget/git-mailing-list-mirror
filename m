Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4D3DC04A68
	for <git@archiver.kernel.org>; Thu, 28 Jul 2022 01:24:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234201AbiG1BYO (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 21:24:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231626AbiG1BYM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 21:24:12 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 125E11CFEE
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 18:24:12 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id 15-20020a17090a098f00b001f305b453feso3886321pjo.1
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 18:24:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=MXivgHflub6p50pmbpAYGYiLr5KAdLgqD41VIH55k3E=;
        b=H6/7ElapLyyRv7LAMFaBHbC7b8MamqoxfPtzvzdZ1VgHs8yHz0UA5HIZopkhNQyFrn
         hD41isAV0S6oDIYmbrtZdBNm02rwJz6cQBYUsYMT7b9sMGL2rZz4sC7u+s8bOQvgrs+d
         KIOi9C62UEHJiBtdLJ7bQWhz500XWU5xhvUmrTEAQCHt7nmT1Y6zPtqVPbwi/UWvWQOP
         4bUlKsp7oKwclVWmmkGq/oHmJQjNGPNAWZfJpAdBMR+xEFJeA1iBtR3I51ZJTLEqqeP0
         z2f8+g6Mm3CvltuuAxCEivTEDXZjUkKswN8AXeC4NQK+wvo9NbQJdSz9Sa10dPJYSckT
         P+Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MXivgHflub6p50pmbpAYGYiLr5KAdLgqD41VIH55k3E=;
        b=EpMXL6RZIzNaskMPy7+ucv4HkLD1R9x686L5ih2EKZoNudvx/CUW5wv/v5XmHpLGJa
         YmqbQ5tyC5wLRnTxYLqXKW1BB/eXGaBlE1kDTBodZvZT+X2QKnPjYixLIqA6a775fN2l
         yeVT5o1d5sHXXRdbShV5YJY9iUPCqNFwM+xC7/TIrgKVGYAh7GrCmDFAoAjebZoBgCjD
         vXCmrTkQB9RJZ/H/B9Ag8gWZ/XN9QmVBPOdUPsEtQB+lxP2no50KMJvXJ9WDD+iwxXUB
         mkf7O9TX6crTcJNOigJhbeq9NymUyJxZP6n3kohCuJRYk2wnuEk32+W4KNkJcGXwJVLK
         2cow==
X-Gm-Message-State: AJIora/QiHy9/e+4vzNSUxvvIFpC73+h6KPC8xHpJOr+6vevtMAyR+lj
        2ZTPr/I9Ao7rKjupS1LsawVOF1nkQwdhSrsV3EM=
X-Google-Smtp-Source: AGRyM1tCFD1iCKgeklUQvXUAYQwAdxU3C13ZZ/t0aMbzVRyUCnz/CqJHMskF40jr0QfWXp4kCzUWyg==
X-Received: by 2002:a17:90a:fe10:b0:1f3:1de7:fe1b with SMTP id ck16-20020a17090afe1000b001f31de7fe1bmr843197pjb.189.1658971451498;
        Wed, 27 Jul 2022 18:24:11 -0700 (PDT)
Received: from localhost.localdomain ([125.118.26.253])
        by smtp.gmail.com with ESMTPSA id d9-20020a170902654900b0016d2d0ce376sm3783437pln.215.2022.07.27.18.24.07
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 27 Jul 2022 18:24:11 -0700 (PDT)
From:   "tenglong.tl" <dyroneteng@gmail.com>
X-Google-Original-From: "tenglong.tl" <tenglong.tl@alibaba-inc.com>
To:     gitgitgadget@gmail.com
Cc:     Johannes.Schindelin@gmx.de, avarab@gmail.com,
        derrickstolee@github.com, dyroneteng@gmail.com,
        git@vger.kernel.org, gitster@pobox.com, me@ttaylorr.com,
        mjcheetham@outlook.com, newren@gmail.com, steadmon@google.com,
        szeder.dev@gmail.com
Subject: [PATCH v3 1/2] docs: document bundle URI standard
Date:   Thu, 28 Jul 2022 09:23:58 +0800
Message-Id: <20220728012358.29627-1-tenglong.tl@alibaba-inc.com>
X-Mailer: git-send-email 2.37.1.1.g8cbb44ffc4.dirty
In-Reply-To: <e0f003e1b5fae07e98e89875c047c795396ea494.1658757188.git.gitgitgadget@gmail.com>
References: <e0f003e1b5fae07e98e89875c047c795396ea494.1658757188.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee <derrickstolee@github.com> writes:

> +bundle.heuristic::
> +	If this string-valued key exists, then the bundle list is designed to
> +	work well with incremental `git fetch` commands. The heuristic signals
> +	that there are additional keys available for each bundle that help
> +	determine which subset of bundles the client should download. The only
> +  heuristic currently planned is `creationToken`.

Seem like there is a small indent nit at the last line?

Thanks.
