Return-Path: <SRS0=Vx3J=3N=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA157C2D0DB
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9F8AB2075D
	for <git@archiver.kernel.org>; Fri, 24 Jan 2020 21:19:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="inWhiu/L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387468AbgAXVTz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Jan 2020 16:19:55 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42281 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387398AbgAXVTu (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Jan 2020 16:19:50 -0500
Received: by mail-wr1-f68.google.com with SMTP id q6so3677758wro.9
        for <git@vger.kernel.org>; Fri, 24 Jan 2020 13:19:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=7g3RInPRozRcqfiodm1wMBj88ZZT+XDAcmQ//AaX4/c=;
        b=inWhiu/LzSXLmp+CIVRGtbn//4Mxp/akDkVRgQiHGVbqNXHD7iMnZ0mo4XfhN9YGr8
         9CyO9Z8gwzbfws3yG3rlzONYOT8/zRA5wBRg/Rmu4aqQfPDyRKfYLp2XbY0DF8MwS0o8
         Qdy64bJzA9Q+GSef8zXQlllVPLnU2S92TqBZd4Yr4IJ982N3JF8AGoJEQaQ7EZPO9uCJ
         JxbOn2DJ5gxuNak8mJXd7FO+0QGx7CpCKVTvOWm4brOk3f1nBRRCJzAtX4GbwQWIAOAy
         QfI+Sri3tvggOhVaYjtEWycEZL7PK7hWz9X4Ie47vxmkRTmgR5ktsg4u/6ut4gFUW7nw
         VNPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=7g3RInPRozRcqfiodm1wMBj88ZZT+XDAcmQ//AaX4/c=;
        b=FD5nDXOpm1qySOZyJop5JgDX04Zp0+4RSrnEd3M6XAq9EQ9eSispTuaGl/1kx2/ioG
         YPrMjAQCMRMnpgoLyWShNG/+GzOBq75BIylvGErbV5IFHFb5d/GmU2XhnfkxpFkfFsY5
         MdxaIihY0qEXpcGMqqtYMoZWnaKesyLAEZCOVFzhSCJb4NS+460yUwIe5igjPtS/CvNE
         hxhqGJcrr5sM4+JZV//w/CTZsU8fDGnZutHvqJ8IDLu6xOt6SXlmiXDJQ9qd72ApiyhO
         CYfo0F4N0miDy4kjWmI12YGz78acL4/Hi8i/gNf0U2F0663mk1RCiwEDPmZTMomwajJi
         d8JQ==
X-Gm-Message-State: APjAAAWwaY2G7pKw0NjCsyMXyZubUfe3Mi1V6dmBPgIG8kXT0eWXVBQm
        pdPj1yElyT8A2dN61FanhRUlbBAW
X-Google-Smtp-Source: APXvYqzrkDrhxC4ep/2MV1e+HL9nUEvubBCg5uIibJ/0vOb6F7p7jbTQZsQ7gt0SOW1abfyM/VRtEw==
X-Received: by 2002:a5d:404b:: with SMTP id w11mr6269183wrp.171.1579900788700;
        Fri, 24 Jan 2020 13:19:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f1sm9002790wru.6.2020.01.24.13.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Jan 2020 13:19:48 -0800 (PST)
Message-Id: <aace0645107719f62c611296adc44f8c286d8403.1579900782.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
References: <pull.513.git.1579029962.gitgitgadget@gmail.com>
        <pull.513.v2.git.1579900782.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 24 Jan 2020 21:19:37 +0000
Subject: [PATCH v2 07/12] sparse-checkout: detect short patterns
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     me@ttaylorr.com, peff@peff.net, newren@gmail.com,
        Derrick Stolee <dstolee@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <dstolee@microsoft.com>

In cone mode, the shortest pattern the sparse-checkout command will
write into the sparse-checkout file is "/*". This is handled carefully
in add_pattern_to_hashsets(), so warn if any other pattern is this
short. This will assist future pattern checks by allowing us to assume
there are at least three characters in the pattern.

Signed-off-by: Derrick Stolee <dstolee@microsoft.com>
---
 dir.c                              | 3 ++-
 t/t1091-sparse-checkout-builtin.sh | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/dir.c b/dir.c
index 40fed73a94..c2e585607e 100644
--- a/dir.c
+++ b/dir.c
@@ -651,7 +651,8 @@ static void add_pattern_to_hashsets(struct pattern_list *pl, struct path_pattern
 		return;
 	}
 
-	if (strstr(given->pattern, "**")) {
+	if (given->patternlen <= 2 ||
+	    strstr(given->pattern, "**")) {
 		/* Not a cone pattern. */
 		warning(_("unrecognized pattern: '%s'"), given->pattern);
 		goto clear_hashmaps;
diff --git a/t/t1091-sparse-checkout-builtin.sh b/t/t1091-sparse-checkout-builtin.sh
index e2e45dc7fd..2e57534799 100755
--- a/t/t1091-sparse-checkout-builtin.sh
+++ b/t/t1091-sparse-checkout-builtin.sh
@@ -339,4 +339,13 @@ test_expect_success 'pattern-checks: /A/**/B/' '
 	check_files repo/deep/deeper1 "deepest"
 '
 
+test_expect_success 'pattern-checks: too short' '
+	cat >repo/.git/info/sparse-checkout <<-\EOF &&
+	/*
+	!/*/
+	/a
+	EOF
+	check_read_tree_errors repo "a" "disabling cone pattern matching"
+'
+
 test_done
-- 
gitgitgadget

