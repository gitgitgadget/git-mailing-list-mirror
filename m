Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-1.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BC3BC20401
	for <e@80x24.org>; Sun, 18 Jun 2017 21:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752679AbdFRVRy (ORCPT <rfc822;e@80x24.org>);
        Sun, 18 Jun 2017 17:17:54 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:36306 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752399AbdFRVRx (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2017 17:17:53 -0400
Received: by mail-wm0-f66.google.com with SMTP id d17so13804411wme.3
        for <git@vger.kernel.org>; Sun, 18 Jun 2017 14:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=QUfSk7Dgi3M+77vPuMorW7EK+CMZOQvVCa0/HNj+uyw=;
        b=b/tLvbrBLms5zp+h2tWyQXFmZodczDqWawNOE0OkX4YUjyYh5QRcUAWgUTPOusGTQk
         kKD2m1dx/qMCJIm+RHpMnCzduD4AkHA/18CtICPpwER0COOFvAY8g+FE5BsIiWmlf3ay
         z0B6HF/Xx/zNenRKIhkDSCLJDvYVlSgbyBq7pVLY2Uep/qG+b3nJc10MCJxIr06j+L7c
         VZcsbiTyUn7xaQWv5+mSxClNceE6S2XUofymNOAOpu/k+2e8amf3ez1Usq3lsHADSg4l
         mc7jZUBSggjBlhEpREh1sAvCJumHjKuLanP6IryL1EMIxAkcgOo4tPvn2DnKe8QBiInh
         IxzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QUfSk7Dgi3M+77vPuMorW7EK+CMZOQvVCa0/HNj+uyw=;
        b=E7uzRMv3kAIFX8pjLqbo9m4d7YYAclY+uFTxoTmcawzAN/07sxa+gxG/BK6vqg6h4K
         olAjnABpkYUfBNceZ5Cbr70TrOWNu7kIUMokqIHaLeuak1H2t8f8ecjb4868KPWi7PQw
         EpsSh9x/9I7nUq+sEOi34kndr6iJT+g/gzdbUsZhlPs+2JDzUoG/df6sIA/P6EKjWKSe
         2w/H9l1fLH2tHlD/B9lDfgEwKyLaguyCWxe0l4Zg8oZKSgJE7hy4ogWH0PAwVd36jryV
         aSQv/9oi0rl3ayXjBORhjA+AD8JkxtosRuIc2xl5m93GHOKvfU1kvt2GwF7eEg7zWW1a
         VlFQ==
X-Gm-Message-State: AKS2vOxYYeJff6Q5QgAuhw5cppdCjgAS9YfGuorKvraTCjy40IEb99iZ
        8sE+1hzLq4Z1aHUs
X-Received: by 10.80.173.24 with SMTP id y24mr14239787edc.16.1497820672051;
        Sun, 18 Jun 2017 14:17:52 -0700 (PDT)
Received: from localhost.localdomain (ip-213-127-51-182.ip.prioritytelecom.net. [213.127.51.182])
        by smtp.gmail.com with ESMTPSA id r28sm4820521edd.33.2017.06.18.14.17.51
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Sun, 18 Jun 2017 14:17:51 -0700 (PDT)
From:   Sahil Dua <sahildua2305@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v2 2/3] branch: add test for -m renaming multiple config sections
Date:   Sun, 18 Jun 2017 23:17:50 +0200
Message-Id: <1497820670-93537-1-git-send-email-sahildua2305@gmail.com>
X-Mailer: git-send-email 2.7.4 (Apple Git-66)
In-Reply-To: <0102015ca23f0529-c860f75d-e3bb-48b0-b2c0-502f7ab9d667-000000@eu-west-1.amazonses.com>
References: <0102015ca23f0529-c860f75d-e3bb-48b0-b2c0-502f7ab9d667-000000@eu-west-1.amazonses.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

Add a test for how 'git branch -m' handles the renaming of multiple
config sections existing for one branch.

The config format we use is hybrid machine/human editable, and we do
our best to preserve the likes of comments and formatting when editing
the file with git-config.

This adds a test for the currently expected semantics in the face of
some rather obscure edge cases which are unlikely to occur in
practice.

Helped-by: Sahil Dua <sahildua2305@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Sahil Dua <sahildua2305@gmail.com>
---

Changes
  * Use 'sed -n -e' instead of 'grep -A'.
  * Add mixed indentation for different config sections to
    test that formatting of renamed sections is preserved.

Note (from Avar): I ended up not taking Junio's commentary to use
<<-\EOF with spaces. I think it's important that this codepath be
tested for the exact formatting of the config being preserved, so the
test now does that with more exhaustive checks for the formatting at
the trivial expense of making the test not look like the usual
test idiom.

 t/t3200-branch.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 10f8f02..5eb752c 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -341,6 +341,47 @@ test_expect_success 'config information was renamed, too' '
 	test_must_fail git config branch.s/s.dummy
 '
 
+test_expect_success 'git branch -m correctly renames multiple config sections' '
+	test_when_finished "git checkout master" &&
+	git checkout -b source master &&
+
+	# Assert that a config file with multiple config sections has
+	# those sections preserved...
+	cat >expect <<-\EOF &&
+	branch.dest.key1=value1
+	some.gar.b=age
+	branch.dest.key2=value2
+	EOF
+	cat >config.branch <<\EOF &&
+;; Note the lack of -\EOF above & mixed indenting here. This is
+;; intentional, we are also testing that the formatting of copied
+;; sections is preserved.
+
+;; Comment for source. Tabs
+[branch "source"]
+	;; Comment for the source value
+	key1 = value1
+;; Comment for some.gar. Spaces
+[some "gar"]
+    ;; Comment for the some.gar value
+    b = age
+;; Comment for source, again. Mixed tabs/spaces.
+[branch "source"]
+    ;; Comment for the source value, again
+	key2 = value2
+EOF
+	cat config.branch >>.git/config &&
+	git branch -m source dest &&
+	git config -f .git/config -l | grep -F -e source -e dest -e some.gar >actual &&
+	test_cmp expect actual &&
+
+	# ...and that the comments for those sections are also
+	# preserved.
+	cat config.branch | sed "s/\"source\"/\"dest\"/" >expect &&
+	sed -n -e "/Note the lack/,\$p" .git/config >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success 'deleting a symref' '
 	git branch target &&
 	git symbolic-ref refs/heads/symref refs/heads/target &&
-- 
2.7.4 (Apple Git-66)

