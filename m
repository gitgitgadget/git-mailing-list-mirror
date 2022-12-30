Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27F3EC4332F
	for <git@archiver.kernel.org>; Fri, 30 Dec 2022 02:19:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbiL3CTi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 29 Dec 2022 21:19:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234351AbiL3CTB (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 29 Dec 2022 21:19:01 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE96717055
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:55 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id c34so22294667edf.0
        for <git@vger.kernel.org>; Thu, 29 Dec 2022 18:18:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y5vwVH4J9ZvUovy+1FgOcLrPlKbeuZn6CpUZGbs3HQc=;
        b=GYeV4PG19GCRy7LSJkJfH23ajTxwVja4Rz2rodDavi5b1T4v9ZUDfM5l3P7kBkmBue
         fvH2FzGUCQwopxym3alB++y8iALc7THMzrageCazCI+hslf0cEJzfYpU+Iey5KqAR+k9
         kE3aUydYb/X4OSjJf9jfGYOApHv5g/sLP+DstiG0fXMMIG6cJjOsKrstsiO1IipHALSQ
         f1lhpL/DQHOEmVe6xA2Y8J8dgELzBZCY7J91GP/OHUAHZotW+HU+HTf7Wzr1qvAoICeb
         XgLSH9O5eFKppjvO81TCF1M1Z8+mLfxhSYKhQgR/ciQV0WA4LsUnD6BCKmMS+Un2zfhs
         MRtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Y5vwVH4J9ZvUovy+1FgOcLrPlKbeuZn6CpUZGbs3HQc=;
        b=quLD0vKw0uV82M0tr79iOmK00gSXVDWyU+ncNhp5OvrauFpqZDVvrXB8pIKgDk8SqV
         Vw9CfV+dPxrTSoqH7vQdNNNYUU3ReZTt+lUtCdn0DObowxN/PodblsXMKi5Kejm+E3hT
         84fJwZuw7/OV1U0fn1yxp6AhN/GzoZ79IouZ/SnWSAUg1faPovyZJzbEcgsmZDHJ8Aps
         h3+TXXHDG3k9h2vtC3EKbYXQrwLa90l3WZTJX/gOYFDvDBWhENF5B0oHpTqjuWVtfQmM
         Cv68XQqiLy5wBLTc8UwTC95k7mkk1WAE0E1fKigbpZO0BnWatyijtp56I/WHsrdhVc58
         C6ZA==
X-Gm-Message-State: AFqh2kp1PGRq5kgKfPqGwNeFfECQ4Oic7Ym6XS35fiUMEGn/zq4VgEjW
        raaAbxobmEBtjTf2/oIilt8SiqtTO+R3uQ==
X-Google-Smtp-Source: AMrXdXs3WV7UqiqWWGfRbIoZB1JCXComFfTJXzY85bAbnCjsB85ggEQ8omBcvxsR8Vcf4rsJfV9Jyw==
X-Received: by 2002:a05:6402:4518:b0:46c:b2a7:1e03 with SMTP id ez24-20020a056402451800b0046cb2a71e03mr22915998edb.36.1672366733921;
        Thu, 29 Dec 2022 18:18:53 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id ay15-20020a056402202f00b0046dd0c2a08esm8861991edb.36.2022.12.29.18.18.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Dec 2022 18:18:53 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 16/20] object-file.c: release the "tag" in check_tag()
Date:   Fri, 30 Dec 2022 03:18:31 +0100
Message-Id: <patch-v2-16.20-2016b4ddd0b-20221230T020341Z-avarab@gmail.com>
X-Mailer: git-send-email 2.39.0.1153.g589e4efe9dc
In-Reply-To: <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
References: <cover-00.20-00000000000-20221228T175512Z-avarab@gmail.com> <cover-v2-00.20-00000000000-20221230T020341Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been with us ever since c879daa2372 (Make
hash-object more robust against malformed objects, 2011-02-05). With
"HASH_FORMAT_CHECK" (used by "hash-object" and "replace") we'll parse
tags into a throwaway variable on the stack, but weren't freeing the
"item->tag" we might malloc() when doing so.

The clearing that release_tag_memory() does for us is redundant here,
but let's use it as-is anyway. It only has one other existing caller,
which does need the tag to be cleared.

Mark the tests that now pass in their entirety as passing under
"SANITIZE=leak", which means we'll test them as part of the
"linux-leaks" CI job.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-file.c         | 1 +
 t/t3800-mktag.sh      | 1 +
 t/t5302-pack-index.sh | 2 ++
 3 files changed, 4 insertions(+)

diff --git a/object-file.c b/object-file.c
index c1b71c28347..53477a07469 100644
--- a/object-file.c
+++ b/object-file.c
@@ -2331,6 +2331,7 @@ static void check_tag(const void *buf, size_t size)
 	memset(&t, 0, sizeof(t));
 	if (parse_tag_buffer(the_repository, &t, buf, size))
 		die(_("corrupt tag"));
+	release_tag_memory(&t);
 }
 
 static int index_mem(struct index_state *istate,
diff --git a/t/t3800-mktag.sh b/t/t3800-mktag.sh
index e3cf0ffbe59..d3e428ff46e 100755
--- a/t/t3800-mktag.sh
+++ b/t/t3800-mktag.sh
@@ -4,6 +4,7 @@
 
 test_description='git mktag: tag object verify test'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 ###########################################################
diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
index b0095ab41d3..54b11f81c63 100755
--- a/t/t5302-pack-index.sh
+++ b/t/t5302-pack-index.sh
@@ -4,6 +4,8 @@
 #
 
 test_description='pack index with 64-bit offsets and object CRC'
+
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 test_expect_success 'setup' '
-- 
2.39.0.1153.g589e4efe9dc

