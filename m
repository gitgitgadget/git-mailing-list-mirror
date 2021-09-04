Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A7CC433F5
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 02:13:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02C5361058
	for <git@archiver.kernel.org>; Sat,  4 Sep 2021 02:13:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233140AbhIDCOW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 3 Sep 2021 22:14:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231389AbhIDCOW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 3 Sep 2021 22:14:22 -0400
Received: from mail-qk1-x731.google.com (mail-qk1-x731.google.com [IPv6:2607:f8b0:4864:20::731])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87236C061575
        for <git@vger.kernel.org>; Fri,  3 Sep 2021 19:13:21 -0700 (PDT)
Received: by mail-qk1-x731.google.com with SMTP id c10so986434qko.11
        for <git@vger.kernel.org>; Fri, 03 Sep 2021 19:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oHXmfBUr9xSjqRv6WkzUlYgcWC6BJg4Nc6u7mg9Cp4E=;
        b=cwf6wLUJUpdf9HHccqNsK/F1fojGTQEVHz8B13451LdOCDLAtsknQi4mX8X4z1DF9i
         UmznEDiepQFgqjDbTmpvXqo4YqFBw0V68wdAfNMtxUzOEeGnfS1Hmzd7R/yj+glXquLo
         VUYtasdqTXCzyQbs/YiuJpfqX71/exECQxAiOI7df/OhiRwgZtRdDqYpAXn47GnyGgr8
         MSPKATy+b/eFC8LnxEAV1os+s4eUh3yU0ES6ZGbVUgrr1znK2gLcxQpimUh79gbeN8XD
         IURuQLb0uSFVJ2Mw9D+SBiPmkFQUIT9qso9qwV8eefJpzQ6YlGwLncnzt/fEbjhTnQf9
         fJwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oHXmfBUr9xSjqRv6WkzUlYgcWC6BJg4Nc6u7mg9Cp4E=;
        b=X0pMmx1Txe7bTS1payRWYX2dqSX5Ce4ImkcwnYoonK/NMeFLSI4Iepu0C22u2JOj4z
         pBqrzFevKySkWr13JPqLM2MOO08Meo8guQJZ0x0NJj0YmSqMSMvu6iDXJYIMDjE8x1n6
         XRz9Ne/hvw8agywLUaXKepLiKQ6EDDkK174unXiKT4KEp6HbaoHNwL+PJUvVPQ5w050s
         QsnjykMQVPCGUzJz4mtGsSJAqL9h1Tezca/5uSsVSBlT7+YUb45oU6KeV91mJXCPUlXn
         5qB+Qrw/HifgSl6Lk+WDrobEcbdytxl4nNNPuu/qKNI16oBWzVFTs9znYqHT/sZLwClT
         uwiQ==
X-Gm-Message-State: AOAM533g+g2bdGZP2CJtGRJCOeK4CAousqBY4/ByL6zMmIjsBRD6yupx
        O4yYKAxbzSZTz2K+lCPubNjI4s56FSo=
X-Google-Smtp-Source: ABdhPJycZTJ2eWPhsdl/BifRt/kHULUXAwejnCXrsEzuruaPgkmK2sIl+5aVTwq/8B5iPo+AaKmfOQ==
X-Received: by 2002:a05:620a:bce:: with SMTP id s14mr1690470qki.48.1630721600485;
        Fri, 03 Sep 2021 19:13:20 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id 69sm846624qke.55.2021.09.03.19.13.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 03 Sep 2021 19:13:20 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     bagasdotme@gmail.com, emilyshaffer@google.com
Subject: bugreport papercuts
Date:   Fri,  3 Sep 2021 19:12:29 -0700
Message-Id: <20210904021231.88534-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.481.g26d3bed244
In-Reply-To: <20210903115933.622847-1-bagasdotme@gmail.com>
References: <20210903115933.622847-1-bagasdotme@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

While reviewing this patch, noticed the following other minor issues
as well:

  [PATCH 1/2] bugreport: avoid duplicating options in usage()
  [PATCH 2/2] bugreport: slightly better memory management

Maybe could we join them all in one single "papercuts" thread for
easy of management?

Carlo

