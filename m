Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 196551FC19
	for <e@80x24.org>; Fri, 24 Mar 2017 18:41:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S935985AbdCXSlj (ORCPT <rfc822;e@80x24.org>);
        Fri, 24 Mar 2017 14:41:39 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:34845 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934744AbdCXSl3 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Mar 2017 14:41:29 -0400
Received: by mail-wm0-f68.google.com with SMTP id z133so2297446wmb.2
        for <git@vger.kernel.org>; Fri, 24 Mar 2017 11:41:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=aq8y1v8W9rTeUtHVseEccwh8kGLm7OnM4IDMGOw2xLA=;
        b=O6h0/vqKtgBkDM3NTpZlc6rF+Jf8ifG6NmN1DgJzI3rTqpyVTrg2PWzP9Aiv3hi/dD
         L1TBgpOHkgtE+E9Ebw4ZbiTX2Tgo7HHh2H0Z6adL8LM/qonGWemi4W1jwPlN3xsTw0dB
         ECEgUxjxInQ3GHotg8QLjwEv6n2GEvSAbQBBNJ3gN8iro4XwUR5kZcBlnoZWKOtj34Ee
         fAmn/GBbSKEIBgGa/+K355KFj+sj5JhlzdgNQ4AV2XIEmLXs+gPxm5D3GtBq5ftauT/Y
         adHWOJ1jvUONw3nEnBAytJRbwLWXdWfcLIjsQIBfKIyUkB/N1OmOfuhoEYSUfVzYWpUD
         r40w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aq8y1v8W9rTeUtHVseEccwh8kGLm7OnM4IDMGOw2xLA=;
        b=MA9Vpu+Q6zy7e+m0xP/2DcjIIfSy4l0zF3sRIR1GPaD0VTpnqMwaoJU8wzWc6rb37x
         eU8AI3sc4VOP1KjypZKO1u7aOzbksHThYJZYlofpMBy5z7TJhuiPQub5tzfdcViKanY/
         d1vBeUZykGulMMrPuG6KYzdTZQ66H0NDe9MzfreblCL8THacsk2Ok4JKGmZ0rNkEJvKw
         YEjziqp7C1jKZkAaMhz/o+omSq47JGYyESP6iPLuJBd4g5keeZ5jgGm6F7Xm0cYy0ASi
         kqAdepnMVA2QEvonwF9nUvgsY92pgKRdd9tXb6AY7TlJ9Jg06vvox/np5yOyw8XPvd8O
         fuyA==
X-Gm-Message-State: AFeK/H2S+qfHGVTh4/8u546+HLEnBGjZgigo69ht48U0jSLlHrBpwpVjcRrZ75kFfGmvoQ==
X-Received: by 10.28.136.81 with SMTP id k78mr4400516wmd.36.1490380887089;
        Fri, 24 Mar 2017 11:41:27 -0700 (PDT)
Received: from u.nix.is ([2a01:4f8:190:5095::2])
        by smtp.gmail.com with ESMTPSA id j77sm3440560wmj.3.2017.03.24.11.41.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 24 Mar 2017 11:41:26 -0700 (PDT)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Lars Hjemli <hjemli@gmail.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <christian.couder@gmail.com>,
        Carlos Rica <jasampler@gmail.com>,
        Samuel Tardieu <sam@rfc1149.net>,
        Tom Grennan <tmgrennan@gmail.com>,
        Karthik Nayak <karthik.188@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 05/16] ref-filter: add test for --contains on a non-commit
Date:   Fri, 24 Mar 2017 18:40:48 +0000
Message-Id: <20170324184059.5374-6-avarab@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20170324184059.5374-1-avarab@gmail.com>
References: <20170324184059.5374-1-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Change the tag test suite to test for --contains on a tree & blob. It
only accepts commits and will spew out "<object> is a tree, not a
commit".

It's sufficient to test this just for the "tag" and "branch" commands,
because it covers all the machinery shared between "branch" and
"for-each-ref".

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t3201-branch-contains.sh | 9 +++++++++
 t/t7004-tag.sh             | 4 +++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/t/t3201-branch-contains.sh b/t/t3201-branch-contains.sh
index 7f3ec47241..daa3ae82b7 100755
--- a/t/t3201-branch-contains.sh
+++ b/t/t3201-branch-contains.sh
@@ -130,6 +130,15 @@ test_expect_success 'implicit --list conflicts with modification options' '
 
 '
 
+test_expect_success 'Assert that --contains only works on commits, not trees & blobs' '
+	test_must_fail git branch --contains master^{tree} &&
+	blob=$(git hash-object -w --stdin <<-\EOF
+	Some blob
+	EOF
+	) &&
+	test_must_fail git branch --contains $blob
+'
+
 # We want to set up a case where the walk for the tracking info
 # of one branch crosses the tip of another branch (and make sure
 # that the latter walk does not mess up our flag to see if it was
diff --git a/t/t7004-tag.sh b/t/t7004-tag.sh
index 45790664c1..3439913488 100755
--- a/t/t7004-tag.sh
+++ b/t/t7004-tag.sh
@@ -1461,7 +1461,9 @@ test_expect_success 'mixing incompatibles modes and options is forbidden' '
 	test_must_fail git tag -n 100 &&
 	test_must_fail git tag -l -m msg &&
 	test_must_fail git tag -l -F some file &&
-	test_must_fail git tag -v -s
+	test_must_fail git tag -v -s &&
+	test_must_fail git tag --contains tag-tree &&
+	test_must_fail git tag --contains tag-blob
 '
 
 # check points-at
-- 
2.11.0

