Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64854C433F5
	for <git@archiver.kernel.org>; Wed, 16 Mar 2022 08:07:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245434AbiCPIIM (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 16 Mar 2022 04:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239061AbiCPIIL (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 16 Mar 2022 04:08:11 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50FA85E773
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 01:06:58 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id rm8-20020a17090b3ec800b001c55791fdb1so1699991pjb.1
        for <git@vger.kernel.org>; Wed, 16 Mar 2022 01:06:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=phDxRz2xY6n59QBhrXklgCqfQZVzQLaNuAXHtL7SWXQ=;
        b=avTbhNPpFxJ2rmgrqrwQjyNDNbWTwZ+PC2ryjfTjOvFceDAvYQfjKqmvzbdETe6JZY
         nzbKxf0SsqGYdZq7httN9CasEZmKa/iUKDxaTiy6owaQ7aEVsV94bD/mkc/w60rZodb4
         kcfPRE7C9LgrS0DM6khCbWkfKE3BNKDDeEcKv5nPEPnNtQnSG4hwPWfGydj6YICY4/C+
         nnfaF/jJRVHAD0KLx1rr1IOLZ+3b2AXnVN5/fSWKA8SxUZ77fntwQO6p8v5Oo90v8TSb
         C7+RZEq2VkdfLIS4L5I5XEqtG8Tg3RY9uH/DSoSAWl8lZnIB/acmQZLOfTYDhFRMJsMG
         BeIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=phDxRz2xY6n59QBhrXklgCqfQZVzQLaNuAXHtL7SWXQ=;
        b=ywdsoIgebXK8RkEqsgp9iJ5RCRN5dQ3/vXX5dBc+dF3FmOhi0w4M6OQ41BXtt476Lh
         TUpQQFHFbbzc/6tYLwme3jdZbRZfaZzIRAlHxdir57x4PVx8/7eMymhGqRm4MP4ucJQ/
         Ls34F8IcgAGEAQfPVndHYjp4hleWlTf6vmST6rkfTFSra/wo1G/5z31he11RZaWvKCBV
         oMTrfiAcOc5P5sMgPxPtCRcTTYNqNiGgoDMdp5rrtEWAmD71zlIQYSjXSXuyZqZgn+qD
         IUd5JDhZi8kK0E7Q1JevvxhH/tK3TOq2Oa1Xn7ROvVnQTzpd985JGliKP4UC6LymiAX+
         lD5A==
X-Gm-Message-State: AOAM531vZR4sts6l6BAc7VsCA5UZzy/MuaUgjsfwuOk3cw5nlT4JBuAt
        M6jCGR4p3+Ufx8eCyef37Wy25CIzHE9SiTDD
X-Google-Smtp-Source: ABdhPJx+OBAA8HOTINRF0WVkET6lAiMouWyvl4B//LX/c00ebc50LTnvDcGqg/oZaYvjgTybGC2mxw==
X-Received: by 2002:a17:902:6941:b0:14c:b815:6d45 with SMTP id k1-20020a170902694100b0014cb8156d45mr32479971plt.49.1647418017603;
        Wed, 16 Mar 2022 01:06:57 -0700 (PDT)
Received: from localhost.localdomain ([47.11.233.137])
        by smtp.gmail.com with ESMTPSA id j13-20020a633c0d000000b0037ffd2e6a4asm1522492pga.86.2022.03.16.01.06.53
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 16 Mar 2022 01:06:56 -0700 (PDT)
From:   Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        git@vger.kernel.org, Derrick Stolee <derrickstolee@github.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH] partial-clone: add a partial-clone test case
Date:   Wed, 16 Mar 2022 13:36:29 +0530
Message-Id: <20220316080629.63999-1-chakrabortyabhradeep79@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <xmqqv8wffb34.fsf@gitster.g>
References: <xmqqv8wffb34.fsf@gitster.g>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> wrote:

> That sounds like pointing at a different issue.  If the test
> repository downloads the blobs at the tip, then the fact that the
> trace output did not have "fetch" in it does not mean much, does it?
> It could be that we refrained from lazily download the blob because
> we did not need its contents for the purpose of following through an
> exact rename, but it could also be that we did not need to lazily
> download it because we already had it.

hmm, you're right.

> So regardless of "--missing=print" vs "grep in trace", there was a
> bug in the test set-up, and we caught it in this discussion, which
> is excellent.

:)

