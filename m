Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C05402018E
	for <e@80x24.org>; Mon, 29 Aug 2016 17:34:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753493AbcH2ReI (ORCPT <rfc822;e@80x24.org>);
        Mon, 29 Aug 2016 13:34:08 -0400
Received: from mail-pf0-f196.google.com ([209.85.192.196]:33280 "EHLO
        mail-pf0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752958AbcH2ReF (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Aug 2016 13:34:05 -0400
Received: by mail-pf0-f196.google.com with SMTP id i6so9655382pfe.0
        for <git@vger.kernel.org>; Mon, 29 Aug 2016 10:34:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=Fq9kHTQVWwCLO/1l7rb1oFyI1432hbtuA4z82On7M3k=;
        b=zVLMQns4viktSdtGap9OU+HAOnFFlR8HvLKDPQWdCWVNainxsRu6DIUGXNHPnRB5Ad
         jr7uBNRZksZIyoXUr974wtG8wlUdOmCwLCsebBpN8m0rswxzvlO4PX8ARMs9nW+4Mm7O
         Lgk1W5+uqiNY6NbqAE2nbgkPVqMyn+ppZfMoegfn7nHIhcFaItgeJoOfLxvo2ie3EDnb
         OWz5a2Qc1eS0LwgQ5rsC64+rlrMqvlKLZY+M/zChI6kMMZCoi8mk9kad74XqQ+/ocvWr
         3e9kc11e1wvIS+br27lBWQdAJfyTmxXka+RxwGVqzMYCglijMi6oUykahfKzubUjigYu
         wwPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=Fq9kHTQVWwCLO/1l7rb1oFyI1432hbtuA4z82On7M3k=;
        b=YZaPZxl9ghkpHcY2I9L6RfXEBbuCWlyDjIOZwNc809q3Kw4qnrZdDbP7RgEKEqjmDl
         WMjPdHpRtEQTuxGnsu0cgD3GiZUjDgzdR1G5nrBn9F48ZznSsTa2ppH3ydQg9Pe3u3to
         AcXEb4f8TCFGV8QvCh/5Z6upmBKwXsNUH4bfM5qovih7+taQXbuXHRLtky1AMIWUvgti
         BmQF8EL3V8UEYQX1UI4rwrmem7KcAh7pv4YcUd9fnOSPuZ8azwLi8z52icRCrPWxpoja
         8rFFOFIJYJGeEg68KWU5mERXufPhcLJA21jLu9W4oq3HKd2So2GWjRnjD3HvclpvCf9S
         9raQ==
X-Gm-Message-State: AE9vXwNzm+QGZiFneD6e4CzSIk1cKFwDNQk/dFXTLMAIrVaLDyKk7TAKbJFF73z66kJ1tQ==
X-Received: by 10.98.71.91 with SMTP id u88mr34722924pfa.145.1472492045011;
        Mon, 29 Aug 2016 10:34:05 -0700 (PDT)
Received: from tci.int.yp.com ([216.2.203.2])
        by smtp.gmail.com with ESMTPSA id h125sm50721234pfg.54.2016.08.29.10.34.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 29 Aug 2016 10:34:04 -0700 (PDT)
From:   Brian Henderson <henderson.bj@gmail.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, e@80x24.org, gitster@pobox.com,
        Brian Henderson <henderson.bj@gmail.com>
Subject: [PATCH v4 2/3] diff-highlight: add failing test for handling --graph output.
Date:   Mon, 29 Aug 2016 10:33:46 -0700
Message-Id: <20160829173347.454-3-henderson.bj@gmail.com>
X-Mailer: git-send-email 2.9.3
In-Reply-To: <20160829173347.454-1-henderson.bj@gmail.com>
References: <20160823041252.53ldwacgdey2euxt@sigill.intra.peff.net>
 <20160829173347.454-1-henderson.bj@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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

