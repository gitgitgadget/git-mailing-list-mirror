Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90AF6C0015E
	for <git@archiver.kernel.org>; Tue,  1 Aug 2023 18:20:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231618AbjHASUa (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 1 Aug 2023 14:20:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36256 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231339AbjHASU2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 1 Aug 2023 14:20:28 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 234EA268C
        for <git@vger.kernel.org>; Tue,  1 Aug 2023 11:20:20 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-583d63ca1e9so66743597b3.1
        for <git@vger.kernel.org>; Tue, 01 Aug 2023 11:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20221208.gappssmtp.com; s=20221208; t=1690914019; x=1691518819;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T2I5XEVCHL9RuSuu6YQT3YGcrA2T1APQTqpUdG4tHMs=;
        b=eTTopF/9mmYUlR+mVgbr0MNhWah9ep1RdnlWTzCGskarnfBXRZfWZDFmQD3XkQJrSO
         Sh3TZYLLT4Iuddx6M9iSWkvv67SYmyUkdN2JkkhsOOJZVYMJ/nK7qoPziP6CSEzyn1IL
         mPmIi1+cQrQ2rjd+pAk61kmD3yNC7rKWMylM3tYEZsMOvbwW8cDb8qWRb+yhjxKz8CRg
         0MLk8g/nL64ZOgMxN/zrMNf65Qsby1C9YeoKoqEzUHtlH8VEqqpAv7BE9GdefzrtKf8Y
         xQbK7IjHabFOjji+4rvduKykv7QzP8nEwRNYcCUqlkARaOQnzXLK4vpUNtqmRl0pPSah
         J1VA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690914019; x=1691518819;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T2I5XEVCHL9RuSuu6YQT3YGcrA2T1APQTqpUdG4tHMs=;
        b=YoTQGmieHzvAhVjMKy9OuhKAIh1HxnWrrx0dQ5mFxsHBxKtfodM/xl1PjZPH975OmB
         GW08A4IyUBvcj820+NVuFP7Fe+B+MEkFeZV4uS1pqKMbYLDYYFXC7EWJRcdEfPCMiB9U
         zdmymZ8gXNRGloF2HqB9rFXs81Du28cLQQytmVLJ8CZJIHfaPTMpxJXEL1YFZQscUK18
         /JiRqukzMbru3fFxzQVl0NED4Z8qsKd9kNUNhZxGQ6AMUhz5xHkDhaUG0sAUYIdJ/1tl
         ZAySKC7gTzWuSOuQy9UOetgLABZFqLWits+XGJgOXiBKeHJwcbLP1DtpkUOOWrbA+9KT
         lD6g==
X-Gm-Message-State: ABy/qLZzIPyPMo8/GnwsS2j5KfSDw7cECRZmmTQ4RDGpVmobrseS3qB1
        mGAfYlzBn3Q1LUzEp54kY0EHerfUsZbr7l3hTFz9bQ==
X-Google-Smtp-Source: APBJJlFZxKmMznRbWEtvt1kHiriC52hr2nsrxGHRQOICNFyPfGqNo/CHY7MxsWFQMx4q2NRmNsUZgg==
X-Received: by 2002:a0d:cad1:0:b0:583:9018:6fbb with SMTP id m200-20020a0dcad1000000b0058390186fbbmr13877829ywd.37.1690914019183;
        Tue, 01 Aug 2023 11:20:19 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id m18-20020a0dca12000000b005865494000dsm763828ywd.115.2023.08.01.11.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Aug 2023 11:20:18 -0700 (PDT)
Date:   Tue, 1 Aug 2023 14:20:18 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Documentation/RelNotes/2.42.0.txt: typofix
Message-ID: <ddd69d9a423e02218916cf647f4f167959f48326.1690914016.git.me@ttaylorr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a typo introduced in aa9166bcc0 (The ninth batch, 2023-07-08).

Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 Documentation/RelNotes/2.42.0.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.42.0.txt b/Documentation/RelNotes/2.42.0.txt
index dd73b28d19..1105b148c8 100644
--- a/Documentation/RelNotes/2.42.0.txt
+++ b/Documentation/RelNotes/2.42.0.txt
@@ -171,7 +171,7 @@ Fixes since v2.41
    been corrected.
    (merge a096a889f4 jk/cherry-pick-revert-status later to maint).
 
- * A few places failed to differenciate the case where the index is
+ * A few places failed to differentiate the case where the index is
    truly empty (nothing added) and we haven't yet read from the
    on-disk index file, which have been corrected.
    (merge 2ee045eea1 js/empty-index-fixes later to maint).
-- 
2.41.0.466.g666a67d3d74
