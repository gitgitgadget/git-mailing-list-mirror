Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA176C38A02
	for <git@archiver.kernel.org>; Sat, 29 Oct 2022 10:25:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiJ2KZ2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 29 Oct 2022 06:25:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbiJ2KZ0 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 29 Oct 2022 06:25:26 -0400
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3686A4D4FC
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 03:25:25 -0700 (PDT)
Received: by mail-pj1-x1034.google.com with SMTP id c15-20020a17090a1d0f00b0021365864446so6531477pjd.4
        for <git@vger.kernel.org>; Sat, 29 Oct 2022 03:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2jadvYko80VCk/BVwjSWNNxXM71/oC0gxA/TwrPTEME=;
        b=cobXjMnXrtkL+ZCc/aBm3OfBwt8Ymj3+mTt4/EZo0wqRQyJJjOE0SvOAsDj0xRgNjG
         9GgvT7YX2lPyhm+Qg1Go1KAH4tpKvnF+KigB+A1FIQJv3po8w09JiVbXGquPTYTvgCNq
         UB/G7CejPmDU2jwmk+nnZCopyYHiRfa8fvPytcRpD5iWJKkPsbDbdZ7M8sv06TKrZa3i
         lj+ZJNPNKf2/ISaxJFf9GNKolMvL5XSlJ+3cA7mkxxw9GwvQHfJWLFa+SrOuWDIuqYPv
         xs5N0qfhGmhCIbJIP7mEubJPvfKbJLN7u5efEnigD/k8C14sX/UKvSNmp6hiTMAb9zKm
         svYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jadvYko80VCk/BVwjSWNNxXM71/oC0gxA/TwrPTEME=;
        b=wt0h0idOOq1ybK5mGGmi+F7fZX/wgyTzPbWT9t1iF5T20bJ0ja2o/6ORbv4xzAgfcN
         MbuJ8CB+Vkd7/B+45vUQAtsj327MhLkQldzmX+tnPiEU/l//UVsM63rfG+Y9BFbNf1eN
         iaGWc5ufJ++F3bTotQ216sIpTdSLT1h/uP1iXq0VPG0RRYPHKmG5DoxaCONE0yGsor6N
         efuVWWLprd+6kYxhB3RGCDPn7uchkTWn/T/cXCg7jAzX5KGSEQQatcHghNX9+2ctEZNh
         0ycXkoc2dLW+KMwQTJt40g8fM0embsdlibpyC+r4jfuVXnX2VDOJ6VtW7EvANCHGjZm5
         0NBA==
X-Gm-Message-State: ACrzQf0MFtnIDAipxE9uXYkVqqvu5uUtnfPVAENbN4huCAyEuuov5QB7
        fHCbZSgFGOE9BFo8MN4NTNjUEiLNN/QH+A==
X-Google-Smtp-Source: AMsMyM58dLTOmZA55WKBjQCJwrCQhM/bOTagKE9K6J5VdvMCCIwQe8mOb0VwrhP/CgNWtsGFx5JPDA==
X-Received: by 2002:a17:902:c942:b0:187:3c1:ad3d with SMTP id i2-20020a170902c94200b0018703c1ad3dmr3531728pla.139.1667039122675;
        Sat, 29 Oct 2022 03:25:22 -0700 (PDT)
Received: from HB2.. ([223.190.251.111])
        by smtp.gmail.com with ESMTPSA id e10-20020aa798ca000000b0056286c552ecsm902449pfm.184.2022.10.29.03.25.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 29 Oct 2022 03:25:22 -0700 (PDT)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v3 2/2] cat-file: add mailmap support to --batch-check option
Date:   Sat, 29 Oct 2022 15:54:59 +0530
Message-Id: <20221029102459.82428-3-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.1.282.g2e87897fbb
In-Reply-To: <20221029102459.82428-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221029102459.82428-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Even though the cat-file command with `--batch-check` option does not
complain when `--use-mailmap` option is given, the latter option is
ignored. Compute the size of the object after replacing the idents and
report it instead.

In order to make `--batch-check` option honour the mailmap mechanism we
have to read the contents of the commit/tag object.

There were two ways to do it:

1. Make two calls to `oid_object_info_extended()`. If `--use-mailmap`
   option is given, the first call will get us the type of the object
   and second call will only be made if the object type is either a
   commit or tag to get the contents of the object.

2. Make one call to `oid_object_info_extended()` to get the type of the
   object. Then, if the object type is either of commit or tag, make a
   call to `read_object_file()` to read the contents of the object.

I benchmarked the following command with both the above approaches and
compared against the current implementation where `--use-mailmap`
option is ignored:

`git cat-file --use-mailmap --batch-all-objects --batch-check --buffer
--unordered`

The results can be summarized as follows:
                       Time (mean ± σ)
default               827.7 ms ± 104.8 ms
first approach        6.197 s ± 0.093 s
second approach       1.975 s ± 0.217 s

Since, the second approach is faster than the first one, I implemented
it in this patch.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-cat-file.txt |  2 ++
 builtin/cat-file.c             | 14 ++++++++++++++
 t/t4203-mailmap.sh             | 30 ++++++++++++++++++++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index 594b6f2dfd..a8e7906b3d 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -103,6 +103,8 @@ OPTIONS
 	`--textconv` or `--filters`, in which case the input lines also
 	need to specify the path, separated by whitespace.  See the
 	section `BATCH OUTPUT` below for details.
+	If used with `--use-mailmap` option, will show the size of
+	updated object after replacing idents using the mailmap mechanism.
 
 --batch-command::
 --batch-command=<format>::
diff --git a/builtin/cat-file.c b/builtin/cat-file.c
index 8a6e2343ec..39f2a2483f 100644
--- a/builtin/cat-file.c
+++ b/builtin/cat-file.c
@@ -444,6 +444,9 @@ static void batch_object_write(const char *obj_name,
 	if (!data->skip_object_info) {
 		int ret;
 
+		if (use_mailmap)
+			data->info.typep = &data->type;
+
 		if (pack)
 			ret = packed_object_info(the_repository, pack, offset,
 						 &data->info);
@@ -457,6 +460,17 @@ static void batch_object_write(const char *obj_name,
 			fflush(stdout);
 			return;
 		}
+
+		if (use_mailmap && (data->type == OBJ_COMMIT || data->type == OBJ_TAG)) {
+			size_t s = data->size;
+			char *buf = NULL;
+
+			buf = read_object_file(&data->oid, &data->type, &data->size);
+			buf = replace_idents_using_mailmap(buf, &s);
+			data->size = cast_size_t_to_ulong(s);
+
+			free(buf);
+		}
 	}
 
 	strbuf_reset(scratch);
diff --git a/t/t4203-mailmap.sh b/t/t4203-mailmap.sh
index b500b31c92..b4355c3e51 100755
--- a/t/t4203-mailmap.sh
+++ b/t/t4203-mailmap.sh
@@ -1051,4 +1051,34 @@ test_expect_success 'git cat-file -s returns correct size with --use-mailmap for
 	test_cmp expect actual
 '
 
+test_expect_success 'git cat-file --batch-check returns correct size with --use-mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	cat >expect <<-\EOF &&
+	92d99959b011b1cd69fe7be5315d6732fe302575 commit 209
+	92d99959b011b1cd69fe7be5315d6732fe302575 commit 220
+	EOF
+	echo "HEAD" >in &&
+	git cat-file --batch-check <in >actual &&
+	git cat-file --use-mailmap --batch-check <in >>actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'git cat-file --batch-command returns correct size with --use-mailmap' '
+	test_when_finished "rm .mailmap" &&
+	cat >.mailmap <<-\EOF &&
+	C O Mitter <committer@example.com> Orig <orig@example.com>
+	EOF
+	cat >expect <<-\EOF &&
+	92d99959b011b1cd69fe7be5315d6732fe302575 commit 209
+	92d99959b011b1cd69fe7be5315d6732fe302575 commit 220
+	EOF
+	echo "info HEAD" >in &&
+	git cat-file --batch-command <in >actual &&
+	git cat-file --use-mailmap --batch-command <in >>actual &&
+	test_cmp expect actual
+'
+
 test_done
-- 
2.38.1.282.g2e87897fbb

