Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 88D3F1F859
	for <e@80x24.org>; Fri, 19 Aug 2016 17:08:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755456AbcHSRIv (ORCPT <rfc822;e@80x24.org>);
        Fri, 19 Aug 2016 13:08:51 -0400
Received: from mail-pf0-f193.google.com ([209.85.192.193]:35708 "EHLO
        mail-pf0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1755424AbcHSRIs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2016 13:08:48 -0400
Received: by mail-pf0-f193.google.com with SMTP id h186so1730614pfg.2
        for <git@vger.kernel.org>; Fri, 19 Aug 2016 10:08:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=1XnKoXdp3jCPL3LK31VvOnakngp5tTHNrw+A/lT7Z+0=;
        b=aB/S1FHbb1DzW9NPND15FwVwzQg45WCgbl32nQvzC9utHe6kNLVdbzOqPU0bCnwMxQ
         rptSbl5SS7mr1U78U6EckI082g8S9i82sly1IIg/z8SQGkSzMAvZgHPhDDTWcIrR7GYx
         MLBA8N0vgxSxTDkyKb9atOehWwA3LLqBMUabQYs4xh0MX4SG3+o0fgvMF3zKauk2T1iq
         um0RgKe/GUm2UhtkiA97ItwWxTpxsGhSe4jGqZHPMdP+JSmGo0X7nz4064T2wyFFocps
         +IN2fuSsgSiOzOelhxMFf4M6NC9RHmvkF5gR2v3YCRyweyvRfT8ISrUu4iWJb5PoC5xH
         iXDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=1XnKoXdp3jCPL3LK31VvOnakngp5tTHNrw+A/lT7Z+0=;
        b=JmEZss6VNOBP0Tr7rIiZg8+YGglQQGgujdIzsA+nhyAIhggVARSvsLCHrHYbgVbKq0
         AsmUglAtyMK5C1+Tnfn37khVPhFIQKqV345Nrm5/YPROHHnCEYCpl29ARc0fjWoqFMuI
         oLVcXbIc7bOKyEMrtHXVYwmXxLsLPt2zG1EP4t43K8XlnD1O8xXqlSPeLMgxHVMnrR27
         LcUOh9H5X97XzXMRJMoqdiuYKwAnLaYqXkZjMOOr2ns+5Do6XMj2qQxcJ2AdpBUvvIN2
         Wb/9ey8NgWuB2/6bzfSK8ctwfn247meg1BVH0BsK0ct9osoIPTlpev1W5/I3RxpIvojY
         N8NQ==
X-Gm-Message-State: AEkooutWFGF5FA2VOACJ7mLaPZhIwqr+WYCSdI4wGdgP9ElepOfhj1dF3SQf6D6I2hZcSg==
X-Received: by 10.98.99.67 with SMTP id x64mr16109143pfb.26.1471626506089;
        Fri, 19 Aug 2016 10:08:26 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id m128sm7930676pfm.42.2016.08.19.10.08.25
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 19 Aug 2016 10:08:25 -0700 (PDT)
From:   Brian Henderson <henderson.bj@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, e@80x24.org, gitster@pobox.com,
        Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH v3 2/3] diff-highlight: add failing test for handling --graph output.
Date:   Fri, 19 Aug 2016 10:08:11 -0700
Message-Id: <20160819170812.1676-3-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.0
In-Reply-To: <20160819170812.1676-1-henderson.bj@gmail.com>
References: <20160819170812.1676-1-henderson.bj@gmail.com>
In-Reply-To: <20160819145123.73hf7ffysy53l3kz@sigill.intra.peff.net>
References: <20160819145123.73hf7ffysy53l3kz@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Signed-off-by: Brian Henderson <henderson.bj@gmail.com>
---
 contrib/diff-highlight/t/t9400-diff-highlight.sh | 54 ++++++++++++++++++++++++
 1 file changed, 54 insertions(+)

diff --git a/contrib/diff-highlight/t/t9400-diff-highlight.sh b/contrib/diff-highlight/t/t9400-diff-highlight.sh
index 6b8a461..3b3c831 100755
--- a/contrib/diff-highlight/t/t9400-diff-highlight.sh
+++ b/contrib/diff-highlight/t/t9400-diff-highlight.sh
@@ -85,10 +85,50 @@ dh_commit_test () {
 	test_cmp commit.exp commit.act
 }
 
+# dh_test_setup_history takes a series (3) of changes and generates a contrived graph
+# of commits and merges
+dh_test_setup_history () {
+	a="$1" b="$2" c="$3"
+
+	printf "$a" >file &&
+	git add file &&
+	git commit -m"Add a file" &&
+
+	printf "$b" >file &&
+	git commit -am"Update a file" &&
+
+	git checkout -b branch &&
+	printf "$c" >file &&
+	git commit -am"Update a file on branch" &&
+
+	git checkout master &&
+	printf "$a" >file &&
+	git commit -am"Update a file again" &&
+
+	git checkout branch &&
+	printf "$b" >file &&
+	git commit -am"Update a file similar to master" &&
+
+	git merge master &&
+	git checkout master &&
+	git merge branch --no-ff
+}
+
+
 test_chomp_eof () {
 	"$PERL_PATH" -pe 'chomp if eof'
 }
 
+left_trim () {
+	"$PERL_PATH" -pe 's/^\s+//'
+}
+
+trim_graph_el () {
+	# graphs start with * or |
+	# followed by a space or / or \
+	"$PERL_PATH" -pe 's@^((\*|\|)( |/|\\))+@@'
+}
+
 test_expect_success 'diff-highlight highlights the beginning of a line' '
 	dh_test \
 		"aaa\nbbb\nccc\n" \
@@ -145,6 +185,20 @@ test_expect_failure 'diff-highlight highlights mismatched hunk size' '
 
 # TODO add multi-byte test
 
+test_expect_failure 'diff-highlight works with the --graph option' '
+	dh_test_setup_history \
+		"aaa\nbbb\nccc\n" \
+		"aaa\n0bb\nccc\n" \
+		"aaa\nb0b\nccc\n" &&
+
+	# topo-order so that the order of the commits is the same as with --graph
+	# trim graph elements so we can do a diff
+	# trim leading space because our trim_graph_el is not perfect
+	git log -p --topo-order | "$DIFF_HIGHLIGHT" | left_trim >graph.exp &&
+	git log -p --graph | "$DIFF_HIGHLIGHT" | trim_graph_el | left_trim >graph.act &&
+	test_cmp graph.exp graph.act
+'
+
 test_done
 
 # vim: set noet
-- 
2.9.0

