Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 45124C4332F
	for <git@archiver.kernel.org>; Sun, 13 Nov 2022 21:28:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235416AbiKMV2z (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Nov 2022 16:28:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235399AbiKMV2x (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2022 16:28:53 -0500
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D7913D7E
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 13:28:53 -0800 (PST)
Received: by mail-pj1-x102b.google.com with SMTP id k5so8738603pjo.5
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 13:28:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JNlTujIhSePUkZ7fXPGpdf5z9rmXsh6KK6wwHYrfSqQ=;
        b=dSPUQy/yw4UbgyVrJ2DSunSozMbBZutxkXFIYiCUtu5jS/JWuQ/zreBi7veF5ZtQEO
         JNmvKXvGykLhKGIyJc8B8LijNLIbj5lQpHMgZIclTCXVhUXy1IxtarrNmKwadfFZpylO
         fgSTK6W4cM/jrzxiWhUNcjisrIWWYZLwktray5ICZgcX9uZyJGTFVFMmY4QhhqarrJjJ
         qD40JWvMnW0XERWaTrdSJsuc8AgWv/0/tUpGMVXHlhfSWQoF9mmmn8MdJxa/V5OWxGUl
         sECcW/hUlvO3OPWgT2xwBLFcmEL6jPmATDHoQQTsKG+ay1NKMrxQ0LI8gjIYwBpmibrw
         5c7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JNlTujIhSePUkZ7fXPGpdf5z9rmXsh6KK6wwHYrfSqQ=;
        b=xSxj1lEKj3qQ/ng+1h5/Pa64vRFBhblwu/OnwmaUN6FkW0ix9a2kCNeatTVBeM6ml4
         vVseK/tr5lMqYn4vo0K3GuDBVV6oT21gSif8R59W1T0aXV+66Sgu3XKO2ZbUyxRNMipD
         PBO8m/TKkOmCFnAGO4JAjDNNmFEJGbG/kHeNO5GEjg9Q23ZkFQNrAxsWKLL3iJxCoI05
         MVGvya8lgeCmbttJzFqDhcsTrt+z3XC4QuVcvW1cecSFK/2pChko7HRWrj9GlWuEtAVk
         B/EmVjHQsDw+S3o5Le8hUWlQNYjOvpPo7va+JJjrxjM6LFQ8zWUYGYpjdne3ItOtJJHf
         aA+Q==
X-Gm-Message-State: ANoB5plRw6YuGNtxurCAJEXtWqfCTx52Y3aMOOcobuU8eETUVNBvI20d
        PDIX2Sr19XwnyCYNTolGcqmWXOI/CxZ+uac1
X-Google-Smtp-Source: AA0mqf7oIWpLV2Xi+jTy9e1xiSVJB/efu6KI1L9LrHW6siySjn8l7uSEE7VIuabmS4KkNzVR7Nc4qA==
X-Received: by 2002:a17:90a:8cf:b0:213:8cf1:4d9d with SMTP id 15-20020a17090a08cf00b002138cf14d9dmr11287061pjn.5.1668374932070;
        Sun, 13 Nov 2022 13:28:52 -0800 (PST)
Received: from HB2.. ([2409:4043:4c81:51c0:8e7b:5efe:71ba:3c2f])
        by smtp.gmail.com with ESMTPSA id 79-20020a621552000000b0056c704abca7sm5116337pfv.220.2022.11.13.13.28.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 13:28:51 -0800 (PST)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, me@ttaylorr.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v4 1/3] cat-file: add mailmap support to -s option
Date:   Mon, 14 Nov 2022 02:58:28 +0530
Message-Id: <20221113212830.92609-2-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.1.423.g41b4650b24
In-Reply-To: <20221113212830.92609-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221113212830.92609-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though the cat-file command with `-s` option does not complain when
`--use-mailmap` option is given, the latter option is ignored. Compute
the size of the object after replacing the idents and report it instead.

In order to make `-s` option honour the mailmap mechanism we have to
read the contents of the commit/tag object. Make use of the call to
`oid_object_info_extended()` to get the contents of the object and store
in `buf`. `buf` is later freed in the function.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Helped-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 builtin/cat-file.c | 13 +++++++++++++
 t/t4203-mailmap.sh | 29 +++++++++++++++++++++++++++++
 2 files changed, 42 insertions(+)

diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index fa7bd89169..8a6e2343ec 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -132,8 +132,21 @@ static int cat_one_file(int opt, const char *exp_type, const char *obj_name,
 
 	case 's':
 		oi.sizep = &size;
+
+		if (use_mailmap) {
+			oi.typep = &type;
+			oi.contentp = (void**)&buf;
+		}
+
 		if (oid_object_info_extended(the_repository, &oid, &oi, flags) < 0)
 			die("git cat-file: could not get object info");
+
+		if (use_mailmap && (type == OBJ_COMMIT || type == OBJ_TAG)) {
+			size_t s = size;
+			buf = replace_idents_using_mailmap(buf, &s);
+			size = cast_size_t_to_ulong(s);
+		}
+
 		printf("%"PRIuMAX"\n", (uintmax_t)size);
 		ret = 0;
 		goto cleanup;
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index cd1cab3e54..b500b31c92 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -1022,4 +1022,33 @@ test_expect_success '--mailmap enables mailmap in cat-file for annotated tag obj
 	test_cmp expect actual
 '
 
+test_expect_success 'git cat-file -s returns correct size with --use-mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	cat >expect <<-\EOF &&
+	209
+	220
+	EOF
+	git cat-file -s HEAD >actual &&
+	git cat-file --use-mailmap -s HEAD >>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file -s returns correct size with --use-mailmap for tag objects' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	Orig <orig@example.com> C O Mitter <committer@example.com>
+	EOF
+	git tag -a -m "annotated tag" v3 &&
+	cat >expect <<-\EOF &&
+	141
+	130
+	EOF
+	git cat-file -s v3 >actual &&
+	git cat-file --use-mailmap -s v3 >>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.38.1.420.g319605f8f0

