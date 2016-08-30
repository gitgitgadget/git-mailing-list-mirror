Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id F14B11F6C1
	for <e@80x24.org>; Tue, 30 Aug 2016 14:07:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753219AbcH3OHl (ORCPT <rfc822;e@80x24.org>);
        Tue, 30 Aug 2016 10:07:41 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35233 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750766AbcH3OHj (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 30 Aug 2016 10:07:39 -0400
Received: by mail-pf0-f195.google.com with SMTP id h186so1241781pfg.2
        for <git@vger.kernel.org>; Tue, 30 Aug 2016 07:07:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=WDcrV6g7QJWkqrYzb3ZJ2ZKWrMKVK5hP/3tef1QWFa8=;
        b=EMrXRatCGUPVPdswzvUc2tvx1tghHyY4UQO7M2k7rnqE3NNIGEyDvCLLBPpfG3PMZS
         iVKmTB1CPgzMHro06M8bD5/SzcYloUw0hnoWWAv/ew8xMrpdnXxbNO80zTs/bAYsOq60
         lkqOrzN0at1UZIwBKljNiGUjdgWWuTYDNByiCTdj9b5FoYNIAcGeq+aCFOCUCVbXXqHj
         4vyyLf++sAN4nWXq6ZMO1Z7NJrPt0AWxdtDydhTEC1Nc4nXurM0WG1dyGNxgSdpxv73J
         LUTGEqdq4uPdER45LVa2VuIgQ0k4xaDwVCuAySiZalSsklENb9LnmItHUmJttUKtn/Fv
         aP/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=WDcrV6g7QJWkqrYzb3ZJ2ZKWrMKVK5hP/3tef1QWFa8=;
        b=IWlJZqxOiykz0GDCBrQGatcUQNw1QRYnpH13mRW4TEQsSo2z19eFwt/p75dbtixu4t
         2hupk/nGYBdFo4PKRQ5tpYilGmcg3o6mcXzO1/N1zrgtNKXwPjhvctoeG79OBODkvkZq
         /WsinCI70nK0/IDMDjoSYZKVk4fglv2UztsCL3BWKoId+Mhj/A7bgL9FAfJHOWnad6fq
         nZni5oWdOmlz6SME1/1WM48oDnj/S6begwbxYfC6Evs4PtD7hwrtZ7Tiyagxj7GoRpD9
         im8MBmg8NN+0pK305cuT7j0SOgAUweekGcNKFW/jz0gDHEXA0Oyn8oXqkJK5aNoCPodj
         YhpA==
X-Gm-Message-State: AE9vXwOaruKeeYvqUXcEw3/ld7ct2rPA79t+HJPPjYUp1shx7hErknc9tt/QWAp27IcMDw==
X-Received: by 10.98.87.90 with SMTP id l87mr6521672pfb.133.1472566058565;
        Tue, 30 Aug 2016 07:07:38 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id j2sm57711654paa.46.2016.08.30.07.07.37
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Tue, 30 Aug 2016 07:07:38 -0700 (PDT)
From:   Brian Henderson <henderson.bj@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, e@80x24.org, gitster@pobox.com,
        Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH v4 2/3] diff-highlight: add failing test for handling --graph output
Date:   Tue, 30 Aug 2016 07:07:13 -0700
Message-Id: <20160830140714.19048-3-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160830140714.19048-1-henderson.bj@gmail.com>
References: <xmqq4m638ded.fsf@gitster.mtv.corp.google.com>
 <20160830140714.19048-1-henderson.bj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brian Henderson <henderson.bj@gmail.com>
---
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 60 ++++++++++++++++++++++++
 1 file changed, 60 insertions(+)

diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index 7c303f7..54e11fe 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -49,6 +49,55 @@ test_strip_patch_header () {
 	sed -n '/^@@/,$p' $*
 }
 
+# dh_test_setup_history generates a contrived graph such that we have at least
+# 1 nesting (E) and 2 nestings (F).
+#
+#	      A branch
+#	     /
+#	D---E---F master
+#
+#	git log --all --graph
+#	* commit
+#	|    A
+#	| * commit
+#	| |    F
+#	| * commit
+#	|/
+#	|    E
+#	* commit
+#	     D
+#
+dh_test_setup_history () {
+	echo "file1" >file1 &&
+	echo "file2" >file2 &&
+	echo "file3" >file3 &&
+
+	cat file1 >file &&
+	git add file &&
+	git commit -m "D" &&
+
+	git checkout -b branch &&
+	cat file2 >file &&
+	git commit -am "A" &&
+
+	git checkout master &&
+	cat file2 >file &&
+	git commit -am "E" &&
+
+	cat file3 >file &&
+	git commit -am "F"
+}
+
+left_trim () {
+	"$PERL_PATH" -pe 's/^\s+//'
+}
+
+trim_graph () {
+	# graphs start with * or |
+	# followed by a space or / or \
+	"$PERL_PATH" -pe 's@^((\*|\|)( |/|\\))+@@'
+}
+
 test_expect_success 'diff-highlight highlights the beginning of a line' '
 	cat >a <<-\EOF &&
 		aaa
@@ -160,4 +209,15 @@ test_expect_failure 'diff-highlight highlights mismatched hunk size' '
 
 # TODO add multi-byte test
 
+test_expect_failure 'diff-highlight works with the --graph option' '
+	dh_test_setup_history &&
+
+	# topo-order so that the order of the commits is the same as with --graph
+	# trim graph elements so we can do a diff
+	# trim leading space because our trim_graph is not perfect
+	git log --branches -p --topo-order | "$DIFF_HIGHLIGHT" | left_trim >graph.exp &&
+	git log --branches -p --graph | "$DIFF_HIGHLIGHT" | trim_graph | left_trim >graph.act &&
+	test_cmp graph.exp graph.act
+'
+
 test_done
-- 
2.9.3

