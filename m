Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471BCC7EE24
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 02:08:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231811AbjFFCIa (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 5 Jun 2023 22:08:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229681AbjFFCI2 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 5 Jun 2023 22:08:28 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A491114
        for <git@vger.kernel.org>; Mon,  5 Jun 2023 19:08:27 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3f6e1394060so48456025e9.3
        for <git@vger.kernel.org>; Mon, 05 Jun 2023 19:08:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686017305; x=1688609305;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eKnHkWHPlF4MPLsuzOkdEOFk4KoJE6veAx4v7vS/i/8=;
        b=l7FeDsGrh+e0esOwwU4ocBcqnziX/jj/Tx2FlMwBZfobLHXDMv9B+D03e5dcq/l9GL
         7yBHlSCxAkrYRppo54vj5Ij+bcsLmB0+vFxVx01zBuqRqQviG/EEdLATtuJiRcFQb2ez
         JxmoW9JVO8AB1qIZI8v7VgzuqNJts9qZyAMuDYIstsimV7DqGV6Ir3IM/NpQFkxul+I6
         8PR/Wb4eoAZzZ3ksPkwtbn5H20s3KG7TAN7f8ylmIY/mtfT5osc7iILkUyQFYZmV7dVD
         0du4GO2ZHYmcVelci063EOmOIwMGMV5QBPkU2Iav6g/f6544eYh79aQSZNsn9gRoaFJQ
         R42Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686017305; x=1688609305;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eKnHkWHPlF4MPLsuzOkdEOFk4KoJE6veAx4v7vS/i/8=;
        b=BN9SNkLMVgPxXxPm3U7/Dx8J4OWDjNFbZVDPq4w1dPl9lpVszB7JGEALLldNvxyRHU
         Th0P2uD9I+/RoA322dtAr12VHTBMrJ2Ras8NRhawtT8n5UKMAlUe0yTm4feiILMQ2CHj
         vwkU0URKHBHDYXo6srtCe9PJLTQ9zh1CxLY+aVUZ/LGsG9JWgya6r8ph8cHzfUK8l8+7
         cL6I5NRfgIu5g1apaYRUqKg4Pjdq0UO9epEeY9/ZQkgP6G9Zf6KEoXGJGQyP5dD1Lk9E
         Yb/gzNJryjDjuaQSKtUmkFWeQjLgegaxCGA+W7Lnu4eBYk68C2llx+tuP1CVrNjTSo1e
         s0Fw==
X-Gm-Message-State: AC+VfDxzjwUdfUnSfomBontvOn4hPCI4iC1Qv/byIhdDwkxzAA2DUsn+
        dpRmcigsKt50cOZt0kbj2SrKYJv7YPA=
X-Google-Smtp-Source: ACHHUZ6SuHzCa2sO5GvEFSP3yv1UQUNrkex38R5dhNiCnD/nhnHiqMYSYC2bjb8RiFrGCVhUDOn3Hg==
X-Received: by 2002:a05:600c:2288:b0:3f4:16bc:bd1b with SMTP id 8-20020a05600c228800b003f416bcbd1bmr593027wmf.39.1686017305627;
        Mon, 05 Jun 2023 19:08:25 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f18-20020a1cc912000000b003f4e3ed98ffsm12331589wmb.35.2023.06.05.19.08.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 19:08:25 -0700 (PDT)
Message-Id: <7d504700b91c175c952a16f0d82e642393ce7c84.1686017304.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
References: <pull.1506.v2.git.git.1683839975.gitgitgadget@gmail.com>
        <pull.1506.v3.git.git.1686017304.gitgitgadget@gmail.com>
From:   "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Tue, 06 Jun 2023 02:08:16 +0000
Subject: [PATCH v3 1/9] doc: trailer: fix grammar
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Linus Arver <linusa@google.com>,
        Linus Arver <linusa@google.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Linus Arver <linusa@google.com>

Signed-off-by: Linus Arver <linusa@google.com>
---
 Documentation/git-interpret-trailers.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
index 4b97f812be8..35faf837892 100644
--- a/Documentation/git-interpret-trailers.txt
+++ b/Documentation/git-interpret-trailers.txt
@@ -14,7 +14,7 @@ SYNOPSIS
 
 DESCRIPTION
 -----------
-Help parsing or adding 'trailers' lines, that look similar to RFC 822 e-mail
+Parse or add 'trailer' lines that look similar to RFC 822 e-mail
 headers, at the end of the otherwise free-form part of a commit
 message.
 
@@ -249,10 +249,10 @@ for the same <token>, 'trailer.<token>.cmd' is used and
 'trailer.<token>.command' is ignored.
 
 trailer.<token>.cmd::
-	This option can be used to specify a shell command that will be called:
+	This option can be used to specify a shell command that will be called
 	once to automatically add a trailer with the specified <token>, and then
-	each time a '--trailer <token>=<value>' argument to modify the <value> of
-	the trailer that this option would produce.
+	called each time a '--trailer <token>=<value>' argument is specified to
+	modify the <value> of the trailer that this option would produce.
 +
 When the specified command is first called to add a trailer
 with the specified <token>, the behavior is as if a special
-- 
gitgitgadget

