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
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B4CE1F463
	for <e@80x24.org>; Wed, 25 Sep 2019 01:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2442112AbfIYBkV (ORCPT <rfc822;e@80x24.org>);
        Tue, 24 Sep 2019 21:40:21 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:45209 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2439273AbfIYBkU (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Sep 2019 21:40:20 -0400
Received: by mail-pg1-f196.google.com with SMTP id 4so2240211pgm.12
        for <git@vger.kernel.org>; Tue, 24 Sep 2019 18:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=bnMBZO0iYMIQ7/qnuO4E6933jCQOYpURaQW8mTFkgfI=;
        b=WddjyPQ+F7rhSp1caUNke1FiF6E49K3Dat77lwZH1JIEvO2r+n1jyqyPyLz3m+e1m8
         1xvN3GoAT91kLuuyDOyOSxuUNIITDfrcs0cehRWH9+2ONVGSg63QO3pwSo2KB186RpH9
         7Kr79z+Q6ZXQi4cAPq4zEKAPCCRaGKnDrjn1DL03Ei+B5QdESAP+Yiao2mMONbi1kSAX
         MUqqKbCxYFpE/tSHC+o9VB0FLnHloQTZFSaBCl2bt1VCFLch4EVfHV6duqt4846jOC3B
         Xst53VUstRFJ3hRnxq8ga4FfrZTaDQ/BQz8pNdhW9Tqbb5PzpVGPaU1ueMfUhXpY9hxG
         +45g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=bnMBZO0iYMIQ7/qnuO4E6933jCQOYpURaQW8mTFkgfI=;
        b=huF5mhpp0eHsUXMQtFo39dpm+UT9c3SVJGP5NJmn5ykpgf7Z40sbZQABgUT5c//WoI
         rdlTLLEwpEbI+pK91VMQ0Z5h9Z40tEpuUZ5dRVUZqVNyjVSL+B8Pnxj10IY0RZWp9nym
         WQUy1+FSvn6tSJ36Hcp18EjbHINRsPhp9798ZK+IUjY57mgW+d/k5R5XCAsxnr9DDdgd
         nggn9avZDJFvdiUJn9+rKN1zhm5ga7du9UFjdPhwr6JiOlwfcOhmSSDMeVT2FSQS+kc5
         PEIWAdar92kev6FtivpJb0IMpm+2MJIWYm6BPOeNAx5vbwzx6OOtDwEapSo65P01pM66
         fz9Q==
X-Gm-Message-State: APjAAAX5RYhQKx/3pLSii9m/3SjlmeRUpTEMx+XfFnyY8iZ6o3CPJ4eb
        jmAzw/Iwmer642nx5N24HvKszOoPUEc=
X-Google-Smtp-Source: APXvYqy0DbCP2yCU4o37wlpQDNx9z9GPJIA153yhkSnv27QwQShTX0eLi4bHX1xXhs9XBycXRaaZ3w==
X-Received: by 2002:a17:90a:191d:: with SMTP id 29mr3515999pjg.60.1569375619155;
        Tue, 24 Sep 2019 18:40:19 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id h4sm3759050pgg.81.2019.09.24.18.40.18
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 24 Sep 2019 18:40:18 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     gitster@pobox.com, Elijah Newren <newren@gmail.com>
Subject: [PATCH 7/8] t9350: add tests for tags of things other than a commit
Date:   Tue, 24 Sep 2019 18:40:04 -0700
Message-Id: <20190925014005.17056-8-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.177.g8af0b3ca64
In-Reply-To: <20190925014005.17056-1-newren@gmail.com>
References: <20190925014005.17056-1-newren@gmail.com>
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
2.23.0.177.g8af0b3ca64

