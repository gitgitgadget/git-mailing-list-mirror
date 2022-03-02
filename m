Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D13C4332F
	for <git@archiver.kernel.org>; Wed,  2 Mar 2022 17:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243853AbiCBR2r (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 12:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243931AbiCBR2b (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 12:28:31 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D8D613F77
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 09:27:42 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id u10so2272192wra.9
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 09:27:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2fsmGshl7kkXCmKDy14XbDAEO/EEX9bnMvyB5ThBT10=;
        b=pRczs67lixXnzYpv95ZrXOa30ciNqJBKzfiDy6l0P0RCOUVBNUlF0K8GmCOfGQvA5l
         O0XgCfgp8dtu8b9psm7VQZZROPKaS3F/3S6W+7gV131BAVjDwVeNp0wQroP018nzUmmr
         iWRcWxld1P4897CZZgFuCimXQCSdNl9Fxf/lG5bEQHxMQalSsecJR/qeVyzKVAc7QJaQ
         MPcegk3PEap+pKrjX8SS1GJXGFBjX48R4MJAmtdeakk2twNRXptxUu5VCtf2bqk2NuPo
         rbRF2iw8nXVfCC52TrEmb0jiRATJw4+DChHh/RdgLMOxhXPa6G+f9+NCRh7CxXJtwTqp
         UdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2fsmGshl7kkXCmKDy14XbDAEO/EEX9bnMvyB5ThBT10=;
        b=4Ryz2GkhHvNe8kK3W0a3/QPzdcQa59UGkmrba82Dcg4xvwsZMMif8fQohz3FqifpL/
         m5LgreQTQTKP5mvF0Z0HTO5VSbTkYcbECeT/5FJvDA4YWBby/T23VgNQzNN5ApvWYlIb
         PCosqomVuCY0QTjIMyID2u8Ac3NsHMlj1lHucpTRMB4Eyd2qUk+JLREB0MKRUuQUShWb
         gt5OqdC+Pvhmge8D7eeYZzFbhUqLd6s52Is3peRVk+ZV17CLs2e6PO2MLOFd5ExFKy5s
         Hkdgtjevt6GZm4KYTLQJoYuu3mTYFTC+1xcW1fGdV8NnRIuAM6j1i0DYyFyfQT44CZhb
         Helg==
X-Gm-Message-State: AOAM532DW5WZYzJeVVMMcOHqtUVRfF+pg/7phFVl/SG9EC10+mM2QnP6
        LyZIA01U6xF6NUhwCF5VmYmS1hPrSutdfw==
X-Google-Smtp-Source: ABdhPJyFj5J6aeLNMHo7WkyAm81FFBZKyVwNEKu2vcdNw/PPyI2RWL3AxI72s0MATHtPKoeiWeIQDQ==
X-Received: by 2002:a05:6000:1864:b0:1ef:d2b0:560a with SMTP id d4-20020a056000186400b001efd2b0560amr11862654wri.38.1646242060554;
        Wed, 02 Mar 2022 09:27:40 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id r20-20020adfa154000000b001f0326a23e1sm2537377wrr.88.2022.03.02.09.27.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Mar 2022 09:27:39 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Shubham Mishra <shivam828787@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 12/15] gettext tests: don't ignore "test-tool regex" exit code
Date:   Wed,  2 Mar 2022 18:27:21 +0100
Message-Id: <patch-12.15-f3cc5bc7eb9-20220302T171755Z-avarab@gmail.com>
X-Mailer: git-send-email 2.35.1.1226.g8b497615d32
In-Reply-To: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
References: <cover-00.15-00000000000-20220302T171755Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Amend a prerequisite check added in 5c1ebcca4d1 (grep/icase: avoid
kwsset on literal non-ascii strings, 2016-06-25) to do invoke
'test-tool regex' in such a way that we'll notice if it dies under
SANITIZE=leak due to having a memory leak, as opposed to us not having
the "ICASE" support we're checking for.

Because we weren't making a distinction between the two I'd marked
these tests as passing under SANITIZE=leak in 03d85e21951 (leak tests:
mark remaining leak-free tests as such, 2021-12-17).

Doing this is tricky. Ideally "test_lazy_prereq" would materialize as
a "real" test that we could check the exit code of with the same
signal matching that "test_must_fail" does.

However lazy prerequisites aren't real tests, and are instead lazily
materialized in the guts of "test_have_prereq" when we've already
started another test.

We could detect the abort() (or similar) there and pass that exit code
down, and fail the test that caused the prerequisites to be
materialized.

But that would require extensive changes to test-lib.sh and
test-lib-functions.sh. Let's instead simply check if the exit code of
"test-tool regex" is zero, and if so set the prerequisites. If it's
non-zero let's run it again with "test_must_fail". We'll thus make a
distinction between "bad" non-zero (segv etc) and "good" (exit 1 etc.).

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t7812-grep-icase-non-ascii.sh | 11 ++++++++---
 1 file changed, 8 insertions(+), 3 deletions(-)

diff --git a/t/t7812-grep-icase-non-ascii.sh b/t/t7812-grep-icase-non-ascii.sh
index ca3f24f8079..347bf4a12f3 100755
--- a/t/t7812-grep-icase-non-ascii.sh
+++ b/t/t7812-grep-icase-non-ascii.sh
@@ -11,9 +11,14 @@ test_expect_success GETTEXT_LOCALE 'setup' '
 	export LC_ALL
 '
 
-test_have_prereq GETTEXT_LOCALE &&
-test-tool regex "HALLÓ" "Halló" ICASE &&
-test_set_prereq REGEX_LOCALE
+test_expect_success GETTEXT_LOCALE 'setup REGEX_LOCALE prerequisite' '
+	if test-tool regex "HALLÓ" "Halló" ICASE
+	then
+		test_set_prereq REGEX_LOCALE
+	else
+		test_must_fail test-tool regex "HALLÓ" "Halló" ICASE
+	fi
+'
 
 test_expect_success REGEX_LOCALE 'grep literal string, no -F' '
 	git grep -i "TILRAUN: Halló Heimur!" &&
-- 
2.35.1.1226.g8b497615d32

