Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 209D71F4BD
	for <e@80x24.org>; Thu,  3 Oct 2019 20:27:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388654AbfJCU1Z (ORCPT <rfc822;e@80x24.org>);
        Thu, 3 Oct 2019 16:27:25 -0400
Received: from mail-pg1-f172.google.com ([209.85.215.172]:44921 "EHLO
        mail-pg1-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388597AbfJCU1Y (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 3 Oct 2019 16:27:24 -0400
Received: by mail-pg1-f172.google.com with SMTP id i14so2393419pgt.11
        for <git@vger.kernel.org>; Thu, 03 Oct 2019 13:27:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=8K3d17QGmELONI57a8uJFQsHlRUn6PkHEfuZqdESHHo=;
        b=ZGiYc/MNUfS9XAb9tuMp8iU7pAQEgTWU4F8nVIUbyOuEB+L54caYmRn9GMBJKm9QW5
         Vb5Jb3VyFqpw5M2jjuCG6leQPNQk9yQufya15EznIWLEyDhJy2MoryB07JS+kb6GwXFF
         yzIGKIQhNngQMiBLFQ2tqj1kSJXrSrH7Mh8Fxos2XgbYDsKwT5ARU13OZE6fnYjznrcL
         WWpjcBwmG3HNUovaj0y8BDzLqa+iOD97PvjWBWp7UVRzHDY2H7FMv4Hpeo+n38/ehUXB
         lOjziHUgnny4OE7Va0AJtBqkb7OtH1nU3Npc5KWkterUPBZxzGwI7P013lD8LUEPsqdo
         SPGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=8K3d17QGmELONI57a8uJFQsHlRUn6PkHEfuZqdESHHo=;
        b=JZN2HW8PqgV+ZDx+ooX2qdHZanCaJEVw6zRcHteefsPZrwfIRWT/QMjyJNYNj3A7rz
         f0FGa6v5S35ss0/WT7qX2b08COaaoNhsPDtZkJSjw9UgT0//nHgVzuwsmdg9iiHXJpMV
         3fLLOoV8+Bn4ePVavrnZsOs+ldCA4u+ag1ye3zvu3X0qrsZLgCdCaACT2WTzzdJzuB+x
         UdizC4qgOHWiHt3oI0ehPAzoB9qY84uhT0xZUkX3yombojkTA1fS+6s6ThHbFpB3oHX+
         A/dYuhdXeN55SSPtv6b3gbCmdbYdvR93tXT19t14ReS/VcgU3+gBJ8fujMy1eqv/FcRH
         SAag==
X-Gm-Message-State: APjAAAV4+72kUUsuPGCFJIyx1UekJxDAvyrIkkCO4uCAYFdzRtxQDFcs
        oSE+9ltlgLapzqRxFFIZwWg=
X-Google-Smtp-Source: APXvYqzI5h5LB124bYnH/lWR0GXkBYz+uhmD05l4g+Bb5ZSlRf+XbEhAnvA9vX15cQyh8tWbnauO/Q==
X-Received: by 2002:a17:90a:8d0c:: with SMTP id c12mr12148465pjo.112.1570134443198;
        Thu, 03 Oct 2019 13:27:23 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id c64sm4055498pfc.19.2019.10.03.13.27.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 03 Oct 2019 13:27:22 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH -v3 7/8] t9350: add tests for tags of things other than a commit
Date:   Thu,  3 Oct 2019 13:27:08 -0700
Message-Id: <20191003202709.26279-8-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.264.g3b9f7f2fc6
In-Reply-To: <20191003202709.26279-1-newren@gmail.com>
References: <20190930211018.23633-1-newren@gmail.com>
 <20191003202709.26279-1-newren@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Multiple changes here:
  * add a test for a tag of a blob
  * add a test for a tag of a tag of a commit
  * add a comment to the tests for (possibly nested) tags of trees,
    making it clear that these tests are doing much less than you might
    expect

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 t/t9350-fast-export.sh | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/t/t9350-fast-export.sh b/t/t9350-fast-export.sh
index b3fca6ffba..9ab281e4b9 100755
--- a/t/t9350-fast-export.sh
+++ b/t/t9350-fast-export.sh
@@ -540,10 +540,41 @@ test_expect_success 'tree_tag'        '
 '
 
 # NEEDSWORK: not just check return status, but validate the output
+# Note that these tests DO NOTHING other than print a warning that
+# they are ommitting the one tag we asked them to export (because the
+# tags resolve to a tree).  They exist just to make sure we do not
+# abort but instead just warn.
 test_expect_success 'tree_tag-obj'    'git fast-export tree_tag-obj'
 test_expect_success 'tag-obj_tag'     'git fast-export tag-obj_tag'
 test_expect_success 'tag-obj_tag-obj' 'git fast-export tag-obj_tag-obj'
 
+test_expect_success 'handling tags of blobs' '
+	git tag -a -m "Tag of a blob" blobtag $(git rev-parse master:file) &&
+	git fast-export blobtag >actual &&
+	cat >expect <<-EOF &&
+	blob
+	mark :1
+	data 9
+	die Luft
+
+	tag blobtag
+	from :1
+	tagger $GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL> $GIT_COMMITTER_DATE
+	data 14
+	Tag of a blob
+
+	EOF
+	test_cmp expect actual
+'
+
+test_expect_failure 'handling nested tags' '
+	git tag -a -m "This is a nested tag" nested muss &&
+	git fast-export --mark-tags nested >output &&
+	grep "^from $ZERO_OID$" output &&
+	grep "^tag nested$" output >tag_lines &&
+	test_line_count = 2 tag_lines
+'
+
 test_expect_success 'directory becomes symlink'        '
 	git init dirtosymlink &&
 	git init result &&
-- 
2.23.0.264.g3b9f7f2fc6

