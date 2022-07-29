Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4985C00144
	for <git@archiver.kernel.org>; Fri, 29 Jul 2022 19:29:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbiG2T3q (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Jul 2022 15:29:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238602AbiG2T3p (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Jul 2022 15:29:45 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A97455FACB
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:43 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id id17so3023641wmb.1
        for <git@vger.kernel.org>; Fri, 29 Jul 2022 12:29:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=Fjy29URKj3Un18HszCKExbcLlsxvb1I2+KYxkv7oJvo=;
        b=QtLC1caupuqHOtsspy7OVwzsBaW2uMAzoklI0gpDb7qM08EAVRqpUmcd75YWcpaDfr
         Xj/yAANF2KqWnVme1uSD4UY6F/lNR7YPuIY4xyBPzn0W6o2MkvbX0de2q1vWNay8A2nv
         KOx436ZZj4NQ8xA4DvBCW463WdooA7OKIJzw188Iug5fvHgVtPNGCzbHGRP44RRYaZUR
         582knrz5nsQCcpv9L4fphGKWTyvaiZ86FublgYbOANU5nQhRHKUbLF1UyJ6z9bLrD8dh
         KEDP+AuzVybmulI+HRCIP+GUs3U2gIM/pXZiyeKDQCtIaIVIqDFhIsn1pXGAWSEJglOj
         8/1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=Fjy29URKj3Un18HszCKExbcLlsxvb1I2+KYxkv7oJvo=;
        b=xUIUrjegGA9uNVUhyFgHNBFrXtDFWyJBZ8f9Fl9vBcLt6aJp7lYBdu730up3/lmUcV
         YQ/fS8x0jNTtjoia7/7jPbSHRvBo8rnhJ19Wf20FQFvLHOjV2xy5PPGwpH/alUbi07/8
         2CLCHPLqDOhkrmbjUAZrrKwLxYFY0qbqRfTMlXSIDhM5OGLKBkn55zWwoPENWGy6Bqh7
         ave32sCxEy9ybLEXnVA/OTNT6mUsODSK5u53bAMxs7j0gq/F6HV8JDlwgoT5i66MjwvA
         XaqQrklpyEjzbmOUulEXd7VAU3m1RhKXBCBTRhWN43foDD1SZDpQoIdj2wgeX0JO4rUZ
         zJGQ==
X-Gm-Message-State: AJIora97QVA2S7dTbu+eVdR1rUTdjcxPrelhCbN1VEXvDTDccUEFy6cO
        B9p/Dy+eA+kwTombtd0V/nzgNFiEQOs=
X-Google-Smtp-Source: AGRyM1ttUmroLNQcwdH/dLR5npzphqePicsMaJgzGUZaoB6xEfF6NRiIyl1vSM+ss1P3D2ZuWVXlBQ==
X-Received: by 2002:a05:600c:a146:b0:3a3:1e79:4446 with SMTP id ib6-20020a05600ca14600b003a31e794446mr3631504wmb.158.1659122981703;
        Fri, 29 Jul 2022 12:29:41 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id f12-20020a05600c154c00b003a31169a7f4sm11095015wmg.12.2022.07.29.12.29.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 Jul 2022 12:29:41 -0700 (PDT)
Message-Id: <c2e5a0b3a50237f3b7f5ceb5d05faa83fd41de68.1659122979.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
References: <pull.1301.git.1658844250.gitgitgadget@gmail.com>
        <pull.1301.v2.git.1659122979.gitgitgadget@gmail.com>
From:   "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 29 Jul 2022 19:29:30 +0000
Subject: [PATCH v2 01/10] refs: allow "HEAD" as decoration filter
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, vdye@github.com,
        steadmon@google.com,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>, Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <derrickstolee@github.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Derrick Stolee <derrickstolee@github.com>

The normalize_glob_ref() method was introduced in 65516f586b693 (log:
add option to choose which refs to decorate, 2017-11-21) to help with
decoration filters such as --decorate-refs=<filter> and
--decorate-refs-exclude=<filter>. The method has not been used anywhere
else.

At the moment, it is impossible to specify HEAD as a decoration filter
since normalize_glob_ref() prepends "refs/" to the filter if it isn't
already there.

Allow adding HEAD as a decoration filter by allowing the exact string
"HEAD" to not be prepended with "refs/". Add a test in t4202-log.sh that
would previously fail since the HEAD decoration would exist in the
output.

It is sufficient to only cover "HEAD" here and not include other special
refs like REBASE_HEAD. This is because HEAD is the only ref outside of
refs/* that is added to the list of decorations.

Signed-off-by: Derrick Stolee <derrickstolee@github.com>
---
 refs.c         | 4 ++--
 t/t4202-log.sh | 6 ++++++
 2 files changed, 8 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 90bcb271687..ec3134e4842 100644
--- a/refs.c
+++ b/refs.c
@@ -457,8 +457,8 @@ void normalize_glob_ref(struct string_list_item *item, const char *prefix,
 
 	if (prefix) {
 		strbuf_addstr(&normalized_pattern, prefix);
-	}
-	else if (!starts_with(pattern, "refs/"))
+	} else if (!starts_with(pattern, "refs/") &&
+		   strcmp(pattern, "HEAD"))
 		strbuf_addstr(&normalized_pattern, "refs/");
 	strbuf_addstr(&normalized_pattern, pattern);
 	strbuf_strip_suffix(&normalized_pattern, "/");
diff --git a/t/t4202-log.sh b/t/t4202-log.sh
index 6e663525582..6b7d8e269f7 100755
--- a/t/t4202-log.sh
+++ b/t/t4202-log.sh
@@ -1025,6 +1025,12 @@ test_expect_success 'decorate-refs and simplify-by-decoration without output' '
 	test_cmp expect actual
 '
 
+test_expect_success 'decorate-refs-exclude HEAD' '
+	git log --decorate=full --oneline \
+		--decorate-refs-exclude="HEAD" >actual &&
+	! grep HEAD actual
+'
+
 test_expect_success 'log.decorate config parsing' '
 	git log --oneline --decorate=full >expect.full &&
 	git log --oneline --decorate=short >expect.short &&
-- 
gitgitgadget

