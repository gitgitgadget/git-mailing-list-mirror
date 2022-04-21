Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A4E1C433EF
	for <git@archiver.kernel.org>; Thu, 21 Apr 2022 15:34:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390142AbiDUPhA (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 21 Apr 2022 11:37:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349101AbiDUPgz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 21 Apr 2022 11:36:55 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B766B2ED78
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 08:34:05 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id u3so7252902wrg.3
        for <git@vger.kernel.org>; Thu, 21 Apr 2022 08:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2+ggnS5gF/FMbeaKLNYrNSBn0d7GYH4Ak96vH44Ih5w=;
        b=m77ch3LKmRSUtXWsjxbXA8jmoY70hp3rU9jTK3gyq9Q6WNv66XrclGIlzCR50UaS65
         FstzZKXPl8fYJ2bHYKVpDE2II+KzKlj/3dOyKYagAPkHzJwdu+OJdL0XlNwfKJJjKqUC
         AYNBZaIh7oZ1olRH76ol74KHR7SqN9MWQfHjsPNISR91L2eViSZPJjliploO3ZnLvSts
         fxky6AnkmjlcUol1H5O+dl8ZTGWaH/QF+G2t1XCcZQEmlfXjK7Whw0WmAfLty/9O50x3
         r9EyiRRki6zyljbzHMRsLYb8SVA8RI9e+ot8JAA1Jf/YWeR3W+YEF9Z9mGDfVoyqv5lO
         2eKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2+ggnS5gF/FMbeaKLNYrNSBn0d7GYH4Ak96vH44Ih5w=;
        b=oMZurJxQFaDy2Wx61QP/SbtlxU8iBjj3Y7lA7PaiYn5r99kYwawumuAroQ6rxLDKGh
         LFExIC6gz+d7HTUjrORCfveOlSt6JRg1J6xd1UXxTjQPrHLIUq1zDegTH3bSNmflRVmy
         HRRnozOqPn/tx4np4pGuRx0nuiaZ62vyx34Rvp1wmVU593Fr+UVjPn1mgElB5qnSxXS+
         +C921t7LHFfBZuNTBAoQx5/5IRMBW57FmuysSFvaZ7GhCKEQow157CkGiOyxNfdcqQjU
         8gdMFmH5cBoRqnVhj+UGKQCvse449aA9z53iz/5PF6xFksPV7obMSFWH4SGdNOe6Uiu8
         fksw==
X-Gm-Message-State: AOAM531ztp5LTYYCni6+E9FlaiGQjm21BZGc01KZ7KyoyCWbZpeYzz6g
        LO0Y2LqBxdZ1DKlGmt0tU+cEeidhvwBofg==
X-Google-Smtp-Source: ABdhPJzR3LTm00pRdca24sD/zEIsoW5OQ7G0qJlCNQmHGozETp1qpL9tuC13Kut0sKtA+SREATDwqA==
X-Received: by 2002:adf:e0c5:0:b0:206:1ba3:26aa with SMTP id m5-20020adfe0c5000000b002061ba326aamr201054wri.645.1650555243929;
        Thu, 21 Apr 2022 08:34:03 -0700 (PDT)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id l126-20020a1c2584000000b00387d4f35651sm2370516wml.10.2022.04.21.08.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 08:34:03 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Gregory David <gregory.david@p1sec.com>,
        ptm-dev <ptm-dev@p1sec.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 2/2] show-branch: fix SEGFAULT when `--current` and `--reflog` together
Date:   Thu, 21 Apr 2022 17:33:48 +0200
Message-Id: <patch-v3-2.2-396c3338533-20220421T152704Z-avarab@gmail.com>
X-Mailer: git-send-email 2.36.0.876.g7efc8a7728c
In-Reply-To: <cover-v3-0.2-00000000000-20220421T152704Z-avarab@gmail.com>
References: <225b410d-2d98-8c0b-c289-22f753c175d4@p1sec.com> <cover-v3-0.2-00000000000-20220421T152704Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Gregory David <gregory.david@p1sec.com>

If run `show-branch` with `--current` and `--reflog` simultaneously, a
SEGFAULT appears.

The bug is that we read over the end of the `reflog_msg` array after
having `append_one_rev()` for the current branch without supplying a
convenient message to it.

It seems that it has been introduced in:
Commit 1aa68d6735 (show-branch: --current includes the current branch.,
2006-01-11)

Signed-off-by: Gregory DAVID <gregory.david@p1sec.com>
Thanks-to: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 builtin/show-branch.c  | 13 +++++++++++++
 t/t3202-show-branch.sh | 43 ++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 56 insertions(+)

diff --git a/builtin/show-branch.c b/builtin/show-branch.c
index 499ef76a508..50c17fb5c31 100644
--- a/builtin/show-branch.c
+++ b/builtin/show-branch.c
@@ -821,6 +821,19 @@ int cmd_show_branch(int ac, const char **av, const char *prefix)
 		}
 		if (!has_head) {
 			const char *name = head;
+			struct object_id oid;
+			char *ref;
+			char *msg;
+			timestamp_t ts;
+			int tz;
+
+			if (!dwim_ref(*av, strlen(*av), &oid, &ref, 0))
+				die(_("no such ref %s"), *av);
+			read_ref_at(get_main_ref_store(the_repository), ref,
+				    flags, 0, i, &oid, &msg, &ts, &tz, NULL);
+
+			reflog_msg[ref_name_cnt] = fmt_reflog(msg, ts, tz,
+							      "(%s) (current) %s");
 			skip_prefix(name, "refs/heads/", &name);
 			append_one_rev(name);
 		}
diff --git a/t/t3202-show-branch.sh b/t/t3202-show-branch.sh
index 7a1be73ce87..7f6ffcf8a57 100755
--- a/t/t3202-show-branch.sh
+++ b/t/t3202-show-branch.sh
@@ -161,4 +161,47 @@ test_expect_success 'show branch --reflog=2' '
 	test_cmp actual expect
 '
 
+test_expect_success 'show branch --reflog=2 --current' '
+	sed "s/^>	//" >expect <<-\EOF &&
+	>	! [refs/heads/branch10@{0}] (4 years, 5 months ago) commit: branch10
+	>	 ! [refs/heads/branch10@{1}] (4 years, 5 months ago) commit: branch10
+	>	  * [branch10] (4 years, 5 months ago) (current) branch: Created from initial
+	>	---
+	>	+ * [refs/heads/branch10@{0}] branch10
+	>	++* [refs/heads/branch10@{1}] initial
+	EOF
+	git show-branch --reflog=2 --current >actual &&
+	test_cmp actual expect
+'
+
+test_expect_success 'show branch --current' '
+	sed "s/^>	//" >expect <<-\EOF &&
+	>	! [branch1] branch1
+	>	 ! [branch2] branch2
+	>	  ! [branch3] branch3
+	>	   ! [branch4] branch4
+	>	    ! [branch5] branch5
+	>	     ! [branch6] branch6
+	>	      ! [branch7] branch7
+	>	       ! [branch8] branch8
+	>	        ! [branch9] branch9
+	>	         * [branch10] branch10
+	>	          ! [master] initial
+	>	-----------
+	>	         *  [branch10] branch10
+	>	        +   [branch9] branch9
+	>	       +    [branch8] branch8
+	>	      +     [branch7] branch7
+	>	     +      [branch6] branch6
+	>	    +       [branch5] branch5
+	>	   +        [branch4] branch4
+	>	  +         [branch3] branch3
+	>	 +          [branch2] branch2
+	>	+           [branch1] branch1
+	>	+++++++++*+ [master] initial
+	EOF
+	git show-branch --current >actual &&
+	test_cmp actual expect
+'
+
 test_done
-- 
2.36.0.876.g7efc8a7728c

