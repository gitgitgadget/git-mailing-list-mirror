Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58C2C433F5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 05:40:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9AD08615E5
	for <git@archiver.kernel.org>; Thu, 30 Sep 2021 05:40:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348124AbhI3Fm2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 30 Sep 2021 01:42:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348119AbhI3Fm1 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 30 Sep 2021 01:42:27 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF1CAC06161C
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 22:40:45 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id i132so4750035qke.1
        for <git@vger.kernel.org>; Wed, 29 Sep 2021 22:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nql0m/41/l/6E1bul7GcWxLAZkRG7BTDO/YfGgZAD3s=;
        b=EP8Y6Jvq5YxZzo1O5cuOkOQIQATXnfJXrGbNj3zMA5fKE2fswvluE1Sq2lwNIBkjdf
         jvqwYhJPr69TgAd6fg7sJbUCXB63O9yBkTsfXaGHiiuPejfze5jBnTGjTPsUaH0RRttW
         9/KRSedLIoDNloUjU4tq6XBxl+BGhQrdMyrzP3roVu+p3Ck3tKobyLpH/Bym3NrU9eyF
         ND/8RSjNhfdnV9aY2y1FjPhZXDO4z/kXJTmVnkhLGF3SZ4zGI096ZVBWDPWioseIS09c
         KqvJWHS7d6xw+MSguUCUsBKhweAxtrQZeI8+ZuYnY/utW1SLMCBWWTObL6SteYOJFlgD
         NPjA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nql0m/41/l/6E1bul7GcWxLAZkRG7BTDO/YfGgZAD3s=;
        b=XMWmPv9xB65HCpT0QqPLRTUig+sIohjVNX+JpmVQhrWgC3femZhy8ItmJCQUoyf/mq
         yegurQXvGyCuFvH7AnjXcL09X3fRhbxQ9TodG2J13tWh+Gs1FZK78zw7IvkoWYzy4H+p
         J4z7W7G28H5h0w3r61ZWZuJIMDE+VNbAftvpKCOuIPhxhz/S6lALZCShQNXp3FeJPXqv
         8xwnTe2iTazJc0oEJCuolvZvr+eMIl76+uhXXVTd/005II2N4WP9rUYfw9Yry+Rem52z
         cM6+fHoD0HGbic6FFByGYjJTnKInlo7NNEXmxy/N12PGS8p3gWgLWj4OFxpxS32JLDTJ
         UC/Q==
X-Gm-Message-State: AOAM533bk68xkI9wr5tZWuHNuauGz+NvFinq+AiawtgprHuxrNW6ugNR
        1Hz0nZR3cs+SnkHCyWijF3OFCNGa1r6bKA==
X-Google-Smtp-Source: ABdhPJzX9f6uc1gZ/PE+pthtxVBGp7z6ug8u+Jf3dI08OtF2DaXEz3QJEP+eNVgnFcu4qhvOB2msvA==
X-Received: by 2002:a37:a703:: with SMTP id q3mr3270786qke.412.1632980444598;
        Wed, 29 Sep 2021 22:40:44 -0700 (PDT)
Received: from carlos-mbp.lan (104-1-92-200.lightspeed.sntcca.sbcglobal.net. [104.1.92.200])
        by smtp.gmail.com with ESMTPSA id a2sm1006826qkk.53.2021.09.29.22.40.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 29 Sep 2021 22:40:44 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     hanwen@google.com, avarab@gmail.com, gitster@pobox.com
Subject: hn/reftable "fixes"
Date:   Wed, 29 Sep 2021 22:40:28 -0700
Message-Id: <20210930054032.16867-1-carenas@gmail.com>
X-Mailer: git-send-email 2.33.0.955.gee03ddbf0e
In-Reply-To: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
References: <pull.1081.v3.git.git.1632841817.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Patch 1, was discussed before and might be solved in a better way as an
alternative.

Patch 2 and 3 are "nice to have" for portability and hopefully not controversial
but could be dropped, if someone feels strongly against it.

Patch 4 is not something I'd found failing anywhere, but the fact that Microsoft
mentions it is only supported as an extension and it needs to be supported by
the dynamic linker and I couldn't find anything clear about it in POSIX means,
that is probably safer this way.

  [PATCH 1/4] fixup! reftable: add a heap-based priority queue for
  [PATCH 2/4] fixup! reftable: implement stack, a mutable database of
  [PATCH 3/4] config.mak.uname: last release and snapshots of Minix
  [PATCH 4/4] reftable: avoid non portable compile time pointer to

