Return-Path: <SRS0=WTnS=CW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DAAAC43461
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 14:55:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FA272151B
	for <git@archiver.kernel.org>; Sun, 13 Sep 2020 14:55:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oy2uRU9u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725971AbgIMOzX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Sep 2020 10:55:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725950AbgIMOyw (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Sep 2020 10:54:52 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D852C06174A
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 07:54:49 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id 34so9478050pgo.13
        for <git@vger.kernel.org>; Sun, 13 Sep 2020 07:54:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WjIEd6L3pTCTHBWUYunr67NGJoW05SWEjdvDtuaeO3c=;
        b=oy2uRU9ujafhA3ue/lQBpPbnWKCinnHN8bAotlajXEXFjEtuyIol3R1Zx9zAP0oRg4
         WQZSCmmKEA/5DUYG7UlZmcSoD/3SKvmlqVP7E9MGGyIZx6F/HSJXG6MDzpfJRJtxVIEX
         lQABn7oBWv/Jbfm0phERo8OmmV6kSqTxbu5cR2cwSjfOdpf95krKz0gKkqd6+9dh9tKv
         KZfcyLKzd58LYmRRHrw7fuE8r3n9KeoVUDEGDl7YViMW1oTbVdnWybDj+WQc48pwgi8i
         LWlaKjcdqO6rmppE6Su9XTu3N0cNdK6EPhJ7GJklcWl8zcoIxmD3+uhDcy9GESaqpqTU
         6VCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WjIEd6L3pTCTHBWUYunr67NGJoW05SWEjdvDtuaeO3c=;
        b=mfcXd+g/UcbtgSjSIn8SknET1m6Z3MKvmBMQaeJy/Iu8+QY3jA3q3pT/gYSe1Psc0X
         b6+tj+2Y9Ts+wIE0Fduntd007UVGmzh3ZSeLk/wLs4jBu9Ta86g/BqnSYC8nTV40D+8m
         0FyzOY4Cx+wRZYWfMBg4ZERQ9Op2KcOtxZo2xRefZpTF9xfpFig7ELbqyNWa9XzO6e07
         tR7DHTSnCTWmI8XxPcM/6fVijTx0UBGX0P9hWBU4wElR/MgPFY6lq94xDAMNKnCopoS4
         DdzWoUcf7wcn/ny9YwbCUMc/CUSgJI3M587bN0q/DVeZefAUBZIVxMFLakzCaFZgep/d
         +TiA==
X-Gm-Message-State: AOAM533IbGaDfzjdQRqzXe3S8qr3DPzsVPIGE5ctbeTFHd1ZpKjOZCVu
        RE2RFHh2+pyXRnB1DlS7WDJ9lY+UvM4+4UwYmzg=
X-Google-Smtp-Source: ABdhPJwUeK2gA8C2dB2VnIOAt3lbFasmZAbwBhmSRAhwbksUPJaYLkTWywDOZQxqttBch2G3yX1uYw==
X-Received: by 2002:a62:5586:0:b029:13e:d13d:a12c with SMTP id j128-20020a6255860000b029013ed13da12cmr9618345pfb.20.1600008885062;
        Sun, 13 Sep 2020 07:54:45 -0700 (PDT)
Received: from localhost.localdomain ([66.115.146.77])
        by smtp.gmail.com with ESMTPSA id z1sm2774650pfj.113.2020.09.13.07.54.42
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 13 Sep 2020 07:54:44 -0700 (PDT)
From:   Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
To:     git@vger.kernel.org
Cc:     Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
Subject: [PATCH v3 7/7] t: add tests for "force-if-includes"
Date:   Sun, 13 Sep 2020 20:24:13 +0530
Message-Id: <20200913145413.18351-8-shrinidhi.kaushik@gmail.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
References: <20200912150459.8282-1-shrinidhi.kaushik@gmail.com>
 <20200913145413.18351-1-shrinidhi.kaushik@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

t/5533:
  * Add a test cases to verify when "--force-if-includes" is used
    along with "--force-with-lease[=<refname>[:expect]]" (when the
    "<expect>" value is unspecified) can help prevent unintended
    remote overwrites when remote refs are updated in the background.

t/t5549:
  * Add test for the new option to cover the following scenarios:
    - Reject forced updates to remote, if the remote ref is updated
      in-between the time of checkout, rewrite and before the push,
      with cases for a specific ref, and "--all".
    - Allow forced updates for "--force", or if the refspec is
      prepended with a "+".
    - Allow deletes on the remote for "--delete", or if refspec is
      specified as ":<ref>".
    - Skip the reflog check introduced by the new option if `git-push`
      is specified with "--force-with-lease=<refname>:<expect>".

Signed-off-by: Srinidhi Kaushik <shrinidhi.kaushik@gmail.com>
---
 t/t5533-push-cas.sh               |  26 +++++
 t/t5549-push-force-if-includes.sh | 161 ++++++++++++++++++++++++++++++
 2 files changed, 187 insertions(+)
 create mode 100755 t/t5549-push-force-if-includes.sh

diff --git a/t/t5533-push-cas.sh b/t/t5533-push-cas.sh
index 0b0eb1d025..6580aab49c 100755
--- a/t/t5533-push-cas.sh
+++ b/t/t5533-push-cas.sh
@@ -256,4 +256,30 @@ test_expect_success 'background updates of REMOTE can be mitigated with a non-up
 	)
 '
 
+test_expect_success 'background updates of REMOTE can be mitigated with "--force-if-includes"' '
+	rm -rf src dst &&
+	git init --bare src.bare &&
+	test_when_finished "rm -rf src.bare" &&
+	git clone --no-local src.bare dst &&
+	test_when_finished "rm -rf dst" &&
+	(
+		cd dst &&
+		test_commit G &&
+		git push origin master:master
+	) &&
+	git clone --no-local src.bare dst2 &&
+	test_when_finished "rm -rf dst2" &&
+	(
+		cd dst2 &&
+		test_commit H &&
+		git push
+	) &&
+	(
+		cd dst &&
+		test_commit I &&
+		git fetch origin &&
+		test_must_fail git push --force-with-lease --force-if-includes origin
+	)
+'
+
 test_done
diff --git a/t/t5549-push-force-if-includes.sh b/t/t5549-push-force-if-includes.sh
new file mode 100755
index 0000000000..e5d1675478
--- /dev/null
+++ b/t/t5549-push-force-if-includes.sh
@@ -0,0 +1,161 @@
+test_description='Test push "--force-if-includes" forced update safety.'
+
+. ./test-lib.sh
+
+setup_src_dup_dst () {
+	rm -fr src dup dst &&
+	git init --bare dst &&
+	git clone --no-local dst src &&
+	git clone --no-local dst dup
+	(
+		cd src &&
+		test_commit foo &&
+		git push
+	) &&
+	(
+		cd dup &&
+		git fetch &&
+		git merge origin/master &&
+		test_commit bar &&
+		git switch -c branch master~1 &&
+		test_commit baz &&
+		test_commit D &&
+		git push --all
+	) &&
+	(
+		cd src &&
+		git switch master &&
+		git fetch --all &&
+		git branch branch --track origin/branch &&
+		git rebase origin/master
+	) &&
+	(
+		cd dup &&
+		git switch master &&
+		test_commit qux &&
+		git switch branch &&
+		test_commit quux &&
+		git push origin --all
+	)
+}
+
+test_expect_success 'reject push if remote changes are not integrated locally (protected, all refs)' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	git ls-remote dst refs/heads/master >expect.master &&
+	git ls-remote dst refs/heads/master >expect.branch &&
+	(
+		cd src &&
+		git switch branch &&
+		test_commit wobble &&
+		git switch master &&
+		test_commit wubble &&
+		git fetch --all &&
+		test_must_fail git push --force-if-includes --all
+	) &&
+	git ls-remote dst refs/heads/master >actual.master &&
+	git ls-remote dst refs/heads/master >actual.branch &&
+	test_cmp expect.master actual.master &&
+	test_cmp expect.branch actual.branch
+'
+
+test_expect_success 'reject push if remote changes are not integrated locally (protected, specific ref)' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	git ls-remote dst refs/heads/master >expect.master &&
+	(
+		cd src &&
+		git switch branch &&
+		test_commit wobble &&
+		git switch master &&
+		test_commit wubble &&
+		git fetch --all &&
+		test_must_fail git push --force-if-includes origin master
+	) &&
+	git ls-remote dst refs/heads/master >actual.master &&
+	test_cmp expect.master actual.master
+'
+
+test_expect_success 'allow force push if "--force" is specified (forced, all refs)' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git switch branch &&
+		test_commit wobble &&
+		git switch master &&
+		test_commit wubble &&
+		git fetch --all &&
+		git push --force --force-if-includes origin --all 2>err &&
+		grep "forced update" err
+	)
+'
+
+test_expect_success 'allow force push if "--delete" is specified' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git switch branch &&
+		test_commit wobble &&
+		git switch master &&
+		test_commit wubble &&
+		git fetch --all &&
+		git push --delete --force-if-includes origin branch 2>err &&
+		grep "deleted" err
+	)
+'
+
+test_expect_success 'allow forced updates if specified with refspec (forced, specific ref)' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git switch branch &&
+		test_commit wobble &&
+		git switch master &&
+		test_commit wubble &&
+		git fetch --all &&
+		git push --force-if-includes origin +branch 2>err &&
+		grep "forced update" err
+	)
+'
+
+test_expect_success 'allow deletes if specified with refspec (delete, specific ref)' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	(
+		cd src &&
+		git switch branch &&
+		test_commit wobble &&
+		git switch master &&
+		test_commit wubble &&
+		git fetch --all &&
+		git push --force-if-includes origin :branch 2>err &&
+		grep "deleted" err
+	)
+'
+
+test_expect_success 'must be disabled for --force-with-lease="<ref>:<expect>" (protected, specific ref)' '
+	setup_src_dup_dst &&
+	test_when_finished "rm -fr dst src dup" &&
+	git ls-remote dst refs/heads/master >expect.master &&
+	git ls-remote dst refs/heads/master >expect.branch &&
+	(
+		cd src &&
+		git switch branch &&
+		test_commit wobble &&
+		git switch master &&
+		test_commit wubble &&
+		r_head="$(git rev-parse refs/remotes/origin/master)" &&
+		git fetch --all &&
+		test_must_fail git push --force-if-includes --force-with-lease="master:$r_head" 2>err &&
+		grep "stale info" err
+	) &&
+	git ls-remote dst refs/heads/master >actual.master &&
+	git ls-remote dst refs/heads/master >actual.branch &&
+	test_cmp expect.master actual.master &&
+	test_cmp expect.branch actual.branch
+'
+
+test_done
-- 
2.28.0

