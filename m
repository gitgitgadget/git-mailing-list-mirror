Return-Path: <SRS0=nPiP=6T=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 962BFC47247
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:39:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77186206B9
	for <git@archiver.kernel.org>; Tue,  5 May 2020 01:39:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oAalX+HK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727786AbgEEBjp (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 21:39:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726516AbgEEBjo (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 21:39:44 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83F5AC061A0F
        for <git@vger.kernel.org>; Mon,  4 May 2020 18:39:43 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id w3so161022plz.5
        for <git@vger.kernel.org>; Mon, 04 May 2020 18:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Rdd23K0VKYArxPfWBu9HOIWcLwj56JRKrRMqxp2eb6U=;
        b=oAalX+HKNsIdHtiC1q2iYZOLzU76FjjgFMK0zyKeca+cxA0/zxNdJwUnmPymm0agA+
         6Nm7DU3p/CVi+lcQyHQpr54ujrQcvzqvJEGPHPtvmOP6o7Ap3P3dFMiwnEAOxOP/cQmH
         abObbRmhHfDMyv9FaLbuWHVfhGpl895mQKN1F5wXTvLxy/i4gNHKXOMIcPuHJMyZFS6P
         h1ps+p+yvYPLMNVgSBdKdLr/SggAw8bOKIEdG9Hr3pK/R2mv6vU8AO/CA4gpekPGxHcX
         hjtqzl1HXn/97T4NzucTzynPDYFQon2TNQRbCSiq/hrPSyN0wQ+rsHJZqUOMecFatMgq
         lRnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Rdd23K0VKYArxPfWBu9HOIWcLwj56JRKrRMqxp2eb6U=;
        b=bcrfIPWy5EC/+ZubpLmrjxlZrce/2881MfM8cAYGq233fzB2ehWCwoweSfgzKWf38C
         S7c8Zf2esMSCBhUqsd2DPbalL/i+YXV0oN9+/KNQjhmJtfLoeZwgDuBh6NGSKqf3OEN6
         sz9EsQR3gF4IlrrtuGZCmue+WVzGxFjTqf3c6Jqn7ZjI5MCPX8wB/5E1EUUIwJGPd/LS
         SxeYoO0UsoRSt21JZLQOT9ooS/O7WbXecKppeniE7w0GVZbUqbVHV1KKs2IiJ4t65ZX3
         Y4Mcqp1+BwZuW6Qm/NUqZcRyAfq9BZUEg2hOSr+GDUJujTNiQ5aAgd2kxA/kdDZgmnOl
         i9DA==
X-Gm-Message-State: AGi0PuavYTagoQziDd3YaxEltNsV9TrbkoixiQ6F3ICRYxgLy8WkMdWL
        /IhoII4WUYbdfCrOws2Yz0oqnf0K
X-Google-Smtp-Source: APiQypKCuuwX3bAB1LKnwJkKZZ+iVjkzj/AaIaBQiOo1LM0eLr+bly5kZEglkUHfZ5p8xy+hK1uS7A==
X-Received: by 2002:a17:902:b58e:: with SMTP id a14mr505734pls.247.1588642782780;
        Mon, 04 May 2020 18:39:42 -0700 (PDT)
Received: from localhost.localdomain (c-67-188-192-166.hsd1.ca.comcast.net. [67.188.192.166])
        by smtp.gmail.com with ESMTPSA id e196sm352027pfh.43.2020.05.04.18.39.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 04 May 2020 18:39:42 -0700 (PDT)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com,
        =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
Subject: [PATCH 2/4] credential: correct order of parameters for credential_match
Date:   Mon,  4 May 2020 18:39:06 -0700
Message-Id: <20200505013908.4596-3-carenas@gmail.com>
X-Mailer: git-send-email 2.26.2.686.gfaf46a9ccd
In-Reply-To: <20200505013908.4596-1-carenas@gmail.com>
References: <20200503063423.83152-1-carenas@gmail.com>
 <20200505013908.4596-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the beginning in 118250728e (credential: apply helper config,
2011-12-10), the declaration for that function used a different order
than the implementation.

All callers use the same order than the implementation, so update
the declaration in credential.h to match.

Reviewed-by: Jeff King <peff@peff.net>
Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 credential.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/credential.h b/credential.h
index f51703d9ce..c0e17e3554 100644
--- a/credential.h
+++ b/credential.h
@@ -189,7 +189,7 @@ void credential_write(const struct credential *, FILE *);
 void credential_from_url(struct credential *, const char *url);
 int credential_from_url_gently(struct credential *, const char *url, int quiet);
 
-int credential_match(const struct credential *have,
-		     const struct credential *want);
+int credential_match(const struct credential *want,
+		     const struct credential *have);
 
 #endif /* CREDENTIAL_H */
-- 
2.26.2.686.gfaf46a9ccd

