Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E87AC202AE
	for <e@80x24.org>; Wed,  5 Jul 2017 23:15:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1752580AbdGEXP2 (ORCPT <rfc822;e@80x24.org>);
        Wed, 5 Jul 2017 19:15:28 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:35434 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbdGEXP1 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 5 Jul 2017 19:15:27 -0400
Received: by mail-wr0-f193.google.com with SMTP id z45so895614wrb.2
        for <git@vger.kernel.org>; Wed, 05 Jul 2017 16:15:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=/G7ObyEWggIMJOVNf93lj0YefkXGciEIlk8viJYOaig=;
        b=AX6mRv/OfPMz8dshlMuxPk5dVvHVH6JgRhslJ/Y6XsCzRpl/tZOvJqn31/vzNiiZF+
         /45pxf1Gjvc1ttqyblCW8+9sB3V23AUSNIAkdKSuXvp1kL6G5JIKoPrCo7gB/yfgZvyQ
         saezBZ8eaNfCS5cIr5Sx7BMzk5ZAc/xLthhyjRCLyss5HUvF8Db+Qwp/KsdE7UqZzNDP
         eM+W1yIVwPV152WMlNELpsSDQBLR9Wjm+R8rCquMRyfueTQo8snQWsItpZNUoHYtO2kA
         FpCdMC7CZZR44jPC6pURJlMCo2st3i8QL283aVntCvhXGcxn1puuihV0Rkrlgveu6sk9
         o8bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=/G7ObyEWggIMJOVNf93lj0YefkXGciEIlk8viJYOaig=;
        b=cW80lGPYwStm9G+jwq8pR98Ao/R21P4Hv75XeTKcqwGL7Z6j6IRAlBAVFX/nbA9ITc
         78/P4OJSxBpIh3EPyMtSKxxoZDeb0yuB0/U04Lz/LX3rtR0+Y+a6/sPc5bubd2jOzB04
         EBD5QorOP9BkYMjR/6Cntut+OIR9//TlHPY4cL9dc0z8Q+AxXlv7WXkdH9wEJ8Pk04UN
         F9hKO5g4ZuiUprSFjONS1aYX/O0OfsGlyNGdVqS/f04KE/GHZ26ALlkZ+yX3/kpMnNTY
         ewQ2JLzHltQrsgeI8sf/qc4aAF/U/1qLmUIeyNAqWTn/PYd/9irRz2PGFwNXtDXpalDV
         yIvQ==
X-Gm-Message-State: AKS2vOx5njdU/BHotCX5+Huz90w0vutWh+eVeP/HXRCdZhy60Hfe6mlY
        +rRIWg5sfPdztfvL6JY=
X-Received: by 10.80.180.141 with SMTP id w13mr18960303edd.42.1499296525456;
        Wed, 05 Jul 2017 16:15:25 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id x36sm8834938edb.64.2017.07.05.16.15.24
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 05 Jul 2017 16:15:24 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Sahil Dua <sahildua2305@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Brandon Williams <bmwill@google.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 2/3] branch: add test for -m renaming multiple config sections
Date:   Wed,  5 Jul 2017 23:14:53 +0000
Message-Id: <20170705231454.15666-3-avarab@gmail.com>
X-Mailer: git-send-email 2.13.1.611.g7e3b11ae1
In-Reply-To: <20170705231454.15666-1-avarab@gmail.com>
References: <20170705231454.15666-1-avarab@gmail.com>
In-Reply-To: <xmqqeftuh5q7.fsf@gitster.mtv.corp.google.com>
References: <xmqqeftuh5q7.fsf@gitster.mtv.corp.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 t/t3200-branch.sh | 41 +++++++++++++++++++++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
index 48d152b9a9..596fbc8483 100755
--- a/t/t3200-branch.sh
+++ b/t/t3200-branch.sh
@@ -358,6 +358,47 @@ test_expect_success 'config information was renamed, too' '
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
2.13.1.611.g7e3b11ae1

