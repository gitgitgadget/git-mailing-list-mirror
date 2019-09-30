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
	by dcvr.yhbt.net (Postfix) with ESMTP id ACEEB1F463
	for <e@80x24.org>; Mon, 30 Sep 2019 21:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732643AbfI3VKc (ORCPT <rfc822;e@80x24.org>);
        Mon, 30 Sep 2019 17:10:32 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:43959 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732627AbfI3VKb (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Sep 2019 17:10:31 -0400
Received: by mail-pg1-f196.google.com with SMTP id v27so8031038pgk.10
        for <git@vger.kernel.org>; Mon, 30 Sep 2019 14:10:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=5EXF38cBCFVW4sx/PZ/aO7t14RV3nIGLVYjD0I+9JvE=;
        b=Vr8eFYZ+8OqjUX0YR896dNy8e2hmBnXp3fEhM+A4dr/D/vugnxaYCWfPDD8nj1Rv3J
         UwiruQ8po+xB/LFG14Z1tyF50p3vZrGeAL6FzaAVuFXZ1EEQ2SMj+ndivv/cNJSc8SLx
         HUjc9RKKLs9Es9W4l2hI9zO1u5Q/kHsNyHAcpNl8RbVfXr3l/SnRDN7mFhCP8zhlr4J3
         9NCbAycLfGVN1njfqIonb4IE1YDj3KkYFrof8BQMWEzosN9df3zcxT+yfyK425jexKYA
         w/dEd9eXVE9+nkOsNM+rrKmNCYGYYXfa2m54Lc9/y2jbi3LRqnU0Mu5lsyDC7bW5H2I2
         Ez1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5EXF38cBCFVW4sx/PZ/aO7t14RV3nIGLVYjD0I+9JvE=;
        b=N/2Js7qn/kCuZt4frzA/npHJk+sTdcX9aS/FX1t3dIVhfVx+OK94Qw0XTYxCPQIDus
         Czj9RkeiRJvRkG3dXpkWjl0zRlaQ0fLTieAHCCps/1IttGdSRMEWM5b+3hJ48kJlTuYj
         3Xvl+TNXRlypfR4byxdcpBvk95dLcGO2liw8Z0q6kqE3RY5uykw5yL65SQjseHl3ebFG
         3tP6+1wTem5ipcIZ7m2yN5SJdFUe41KdWpyaaY1VGK4ouSjQfvYodQW5rKJQviM5xcj1
         5v+gcABGjMJmFQQ2Ap5txjdYfpPMPzMsvQETRO4G8sBlYOwOW2duNV7cpxyBdMDjM/wd
         wzIg==
X-Gm-Message-State: APjAAAXuFld8/8ag6+7hlV2Nc9A04rIKKaP0KodhyOTJ8XSJqF5XK4CY
        RA14DE/seSvsmPlF51lGT4rno9xdDOI=
X-Google-Smtp-Source: APXvYqwXW6rLE7oukhWJ3WmchWidTkikCi9jhQtOcfODy28wIwuM/XAqGPniGkW7b2evJS5Iw2bbSg==
X-Received: by 2002:a63:d010:: with SMTP id z16mr26145287pgf.327.1569877830327;
        Mon, 30 Sep 2019 14:10:30 -0700 (PDT)
Received: from newren2-linux.yojoe.local ([8.4.231.67])
        by smtp.gmail.com with ESMTPSA id w11sm13404609pfd.116.2019.09.30.14.10.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 30 Sep 2019 14:10:29 -0700 (PDT)
From:   Elijah Newren <newren@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Elijah Newren <newren@gmail.com>
Subject: [PATCH v2 7/8] t9350: add tests for tags of things other than a commit
Date:   Mon, 30 Sep 2019 14:10:17 -0700
Message-Id: <20190930211018.23633-8-newren@gmail.com>
X-Mailer: git-send-email 2.23.0.264.gac739dbb79
In-Reply-To: <20190930211018.23633-1-newren@gmail.com>
References: <20190925014005.17056-1-newren@gmail.com>
 <20190930211018.23633-1-newren@gmail.com>
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
2.23.0.264.gac739dbb79

