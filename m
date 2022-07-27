Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E554C04A68
	for <git@archiver.kernel.org>; Wed, 27 Jul 2022 23:14:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232259AbiG0XOf (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Jul 2022 19:14:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiG0XON (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jul 2022 19:14:13 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D9EA4F663
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:14:07 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v5so92707wmj.0
        for <git@vger.kernel.org>; Wed, 27 Jul 2022 16:14:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=4tk6gYIST59lKaFZjp2IBbYUQDw456zXvSPFm2b3aU0=;
        b=NruTjVWqYtairGkyZdXM8Oj/NYK7zDQ6O+b3btE2sHb9NrNuN34b7A2lQdWOAo3WVl
         0YPBekKK0nf8GgUVKJflphVGvZhebmqGSNYMh2vUCQk9QGOniMLRO2SmBjwb81eO7qaN
         kv4RQYt6IJQTPubQWoP4MaMD9JLhmUWebQT5cYw4EWgtjmMW8Gzujlmex0eP3MFOme9W
         If8DZU7YluuHkot1TW29mGPaxMPac6gFsggqkQtZaKOTSRz1oA/2/azsAAE6JnYrnAh/
         1VYmS4JEfqPGpYT3chZbBbERrzbjhk1K8xX1/HXRA6URlmqXJxJg2k7tZ1+8qRn0ruqR
         7cOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=4tk6gYIST59lKaFZjp2IBbYUQDw456zXvSPFm2b3aU0=;
        b=smIfX6740U//UhMerSQPdzZl1REuc9jR8szBinukdpU3NdNetuMlsR6XfpLh4vfAJ+
         yJrGUSxD+Ez6BfFTDT0DR8YfYHIXFzi0S5FVCxdz40hpZO9/Ps7rGFOgZ2XqXtZFCW3x
         6lUAS3sRFD4kdQ5p3kmag2py8XC3G9kilQ1rr5hFS4yixqJ1nBYSj0oxUVo/xA8dL2qs
         0+/m0+Nwh4LWUfnLVdFwwk231U6NFCxXcmVlhGmd15gg8nyK/n5DUFwCXj7kYReJJbN3
         lEQ+d5w5wwAz0Yh5ixasMPOJ9erpXszpWmY/JyjW9SNLUfJ14gf64QbfenfPWDm3lXiY
         GjxA==
X-Gm-Message-State: AJIora9pa/6W0TtoPqMZVeL+mQbgWSj+OIFMqUXKnFyhPltkFaqgDmg9
        6WfUnjmR2M4qGXEu4lx+vmgGswWMMMy73Q==
X-Google-Smtp-Source: AGRyM1s2wIUDLkD7EHBU3PkJLclwRoZgo7foKYLgNd3wbRiR+CsM6dk93bIj5qJCwEDU7nz8wVgiPg==
X-Received: by 2002:a7b:ca47:0:b0:3a3:1874:648 with SMTP id m7-20020a7bca47000000b003a318740648mr4526999wml.139.1658963645456;
        Wed, 27 Jul 2022 16:14:05 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id z3-20020adfec83000000b0021dd08ad8d7sm1692806wrn.46.2022.07.27.16.14.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 16:14:04 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <stolee@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 14/15] upload-pack: fix a memory leak in create_pack_file()
Date:   Thu, 28 Jul 2022 01:13:42 +0200
Message-Id: <patch-v3-14.15-c1436269c64-20220727T230800Z-avarab@gmail.com>
X-Mailer: git-send-email 2.37.1.1127.g4ecf1c08f67
In-Reply-To: <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
References: <cover-v2-00.14-00000000000-20220720T211221Z-avarab@gmail.com> <cover-v3-00.15-00000000000-20220727T230800Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Fix a memory leak that's been reported by some versions of "gcc" since
"output_state" became malloc'd in 55a9651d26a (upload-pack.c: increase
output buffer size, 2021-12-14).

In e75d2f7f734 (revisions API: have release_revisions() release
"filter", 2022-04-13) it was correctly marked as leak-free, the only
path through this function that doesn't reach the free(output_state)
is if we "goto fail", and that will invoke "die()".

Such leaks are not included with SANITIZE=leak (but e.g. valgrind will
still report them), but under some gcc optimization (I have not been
able to reproduce it with "clang") we'll report a leak here
anyway. E.g. gcc v12 with "-O2" and above will trigger it, but not
clang v13 with any "-On".

The GitHub CI would also run into this leak if the "linux-leaks" job
was made to run with "GIT_TEST_SANITIZE_LEAK_LOG=true".

See [1] for a past case where gcc had similar trouble analyzing leaks
involving a die() invocation in the function.

1. https://lore.kernel.org/git/patch-v3-5.6-9a44204c4c9-20211022T175227Z-avarab@gmail.com/

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1060-object-corruption.sh | 1 +
 upload-pack.c                | 1 +
 2 files changed, 2 insertions(+)

diff --git a/t/t1060-object-corruption.sh b/t/t1060-object-corruption.sh
index e8a58b15897..5b8e47e346c 100755
--- a/t/t1060-object-corruption.sh
+++ b/t/t1060-object-corruption.sh
@@ -2,6 +2,7 @@
 
 test_description='see how we handle various forms of corruption'
 
+TEST_PASSES_SANITIZE_LEAK=true
 . ./test-lib.sh
 
 # convert "1234abcd" to ".git/objects/12/34abcd"
diff --git a/upload-pack.c b/upload-pack.c
index 09f48317b02..b217a1f469e 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -455,6 +455,7 @@ static void create_pack_file(struct upload_pack_data *pack_data,
 	return;
 
  fail:
+	free(output_state);
 	send_client_data(3, abort_msg, sizeof(abort_msg),
 			 pack_data->use_sideband);
 	die("git upload-pack: %s", abort_msg);
-- 
2.37.1.1127.g4ecf1c08f67

