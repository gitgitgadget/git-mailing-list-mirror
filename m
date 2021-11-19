Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8CF84C433EF
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:26:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D87661B27
	for <git@archiver.kernel.org>; Fri, 19 Nov 2021 20:26:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233297AbhKSU3c (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Nov 2021 15:29:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232048AbhKSU3c (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Nov 2021 15:29:32 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 121DAC061574
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:26:30 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id n33-20020a05600c502100b0032fb900951eso11376306wmr.4
        for <git@vger.kernel.org>; Fri, 19 Nov 2021 12:26:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=CUTyVAh89CaSp2qVj80mPs0V07IA8jfB/iHDJsH8/1M=;
        b=ZQ4EgA+r6+5GEvehQTLqpLTN5aQd88nBzdPSdohNs9OqNGLNlBd8l+OhVZiGJcFnNr
         YR7iMSKTYQRDFewUhxFeTevzehH/v2YyaFVvYQ1K97rIcrl1Lqm7CYYZJKIsRbGuwQAK
         U5HmgZATctPapOhuTzDDwuf08zyfc9//BU2JCEybCmMO4ChZI5aGGDJa4svNnPVaCG5u
         6g87cV05vX0GBuWTXmy6hsGIieJoTjkHl/Wg9t8wBrFnzDTfmU0R3vcM8i0fg6R41fX5
         9PKlMhe+/n4n43tppv/GJfJGIE1pfCAk4PkkvZscw6jlbw5ol6Mc5IwrreHT9F1ZZFU/
         3xkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CUTyVAh89CaSp2qVj80mPs0V07IA8jfB/iHDJsH8/1M=;
        b=shQQ0sI6EwO8iumBHs0YBxK9dJUlzLIKeJGhlC60TQ4wS0DdbiEEs10vaRDlaxUMG5
         gebG0kwQYC1m/Q3El+i3/BMGFrlx9MqGW5So6uDFnfwsNEQ5O/l5kRhBOrhlUZ25lCkr
         4du6wGuOUcQELwfI/mWgTkMWFoSrTIdTdiLmelil//gGDdTSlK0vW0wLnaZLrpkgBO4i
         NqdNuEUp9qNdbt8ngf5X3UaU06tcRP/72zZ3w6HHHlEXBjwf0ktl06KY2nWUH9k/KEvv
         DwK8hnbuJKjuwIKymLTaUJX0zsDOGg1yrKayrPw2/UgEkuUFs8c738FiJj5jGUqTJscg
         nXGw==
X-Gm-Message-State: AOAM533Mopq1NNRj3Ns7WKbwrc70Eb0qCeiAPRJLrsNb60hftEzBsEe0
        GKnEV4xyUXNrHdmj+ZiTpGC6nm4vfrgLEQ==
X-Google-Smtp-Source: ABdhPJxmlhxk7bzLY4kd0feTAkU8EFrrMEgLuREXkvaBIb8mPjmDu4/dirGRKzcpGx7/0mKmxzik9A==
X-Received: by 2002:a05:600c:19cc:: with SMTP id u12mr3185820wmq.24.1637353588424;
        Fri, 19 Nov 2021 12:26:28 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id bg14sm856202wmb.5.2021.11.19.12.26.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Nov 2021 12:26:27 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 1/5] xdiff/xmacros.h: remove unused XDL_PTRFREE
Date:   Fri, 19 Nov 2021 21:26:21 +0100
Message-Id: <patch-v2-1.5-1e7e6d8d482-20211119T202455Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.823.gcc3243ae16c
In-Reply-To: <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
References: <cover-0.6-00000000000-20211119T124420Z-avarab@gmail.com> <cover-v2-0.5-00000000000-20211119T202455Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This macro was added in 3443546f6ef (Use a *real* built-in diff
generator, 2006-03-24), but none of the xdiff code uses it, it uses
xdl_free() directly.

If we need its functionality again we'll use the FREE_AND_NULL() macro
added in 481df65f4f7 (git-compat-util: add a FREE_AND_NULL() wrapper
around free(ptr); ptr = NULL, 2017-06-15).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 xdiff/xmacros.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/xdiff/xmacros.h b/xdiff/xmacros.h
index 2809a28ca96..ae4636c2477 100644
--- a/xdiff/xmacros.h
+++ b/xdiff/xmacros.h
@@ -34,7 +34,6 @@
 #define XDL_ADDBITS(v,b)	((v) + ((v) >> (b)))
 #define XDL_MASKBITS(b)		((1UL << (b)) - 1)
 #define XDL_HASHLONG(v,b)	(XDL_ADDBITS((unsigned long)(v), b) & XDL_MASKBITS(b))
-#define XDL_PTRFREE(p) do { if (p) { xdl_free(p); (p) = NULL; } } while (0)
 #define XDL_LE32_PUT(p, v) \
 do { \
 	unsigned char *__p = (unsigned char *) (p); \
-- 
2.34.0.823.gcc3243ae16c

