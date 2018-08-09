Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4CF851F405
	for <e@80x24.org>; Thu,  9 Aug 2018 15:56:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732531AbeHISVi (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 Aug 2018 14:21:38 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:44685 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732503AbeHISVh (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 Aug 2018 14:21:37 -0400
Received: by mail-wr1-f68.google.com with SMTP id r16-v6so5553671wrt.11
        for <git@vger.kernel.org>; Thu, 09 Aug 2018 08:56:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Uv92MbcxCHxIuO/VdFsUH9zDgQqRzH8TBq/JEDTvCPM=;
        b=Y3+VhadU4xzKBbCysZrZAyfinqfnhRHgKtWu04Dt1DVMTm+Szvpy+YBRK7j9C0TlOP
         zEkOZqp76zHhGNdAfwVCxy/6Ie6FgT8di5lkYR1BsNNpAG2/KYDW6s1Qg/W/V4/2Bshw
         goxawiGeG89FC7UYLCjl5bnQtDsZRq0XYDqzeV3q/xXnQhsOkE/H9NMqonpDYkvd8geA
         CTmSBObYUEbmDwQROkcRk3QKxyEPlJ58/JaS63DhzYFkbIvm4mJo16BYpCrireBMxnaz
         2v7alAJlPBZPWyaPUnxQeb+Cy2uwFGUOoMw7G91Bu0hByL/rdd71cZCqke/jwvYOJ2He
         Ndng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Uv92MbcxCHxIuO/VdFsUH9zDgQqRzH8TBq/JEDTvCPM=;
        b=IbADpwnmaYv1eC0vlnEW8+3LmJ6IokGXqDsno6wg9DZZujWDz3HB8PVHLaOvm+JArh
         IVGs7wglMI+QWIRuLBgbk6wD+aEighaoQx6op3/+Mk/NECAS/mc8ODYKHNs6cPKgpsVD
         HHY5I7SnpmIzzyL+kX/h6e0W5wHUxeiSCrZ0c7fo32lapjz59XjCQMz+aHLtpTS+EnON
         wYHkLHC2hE8D35I/c3DTwYq9grv+tJnDsDCJkonJFdsRjc2G2fWrN5udgaDuSkjD4p3g
         IHnoZugQlGlQpE1xHHMdnjgu8DuEDxD7Qb684vO+EX0glK+Hl48NYstbHxqqWXd7qwmZ
         WDSg==
X-Gm-Message-State: AOUpUlFsyA6XltEmh26pRA0G3LA7y7M00vWXRzPJ9Zzx3uCKRWQ5EdTf
        3vqB7iAhKBYdMeU43uxYLupyvxje
X-Google-Smtp-Source: AA+uWPw2o7KLTi2heKpO5wf9YA+CY5SNpTtEKDk5bQHO77Qtfb0vLz5Bkkj5kUtCV2h4/E+3Vszbkg==
X-Received: by 2002:a5d:67c6:: with SMTP id n6-v6mr1795306wrw.39.1533830165192;
        Thu, 09 Aug 2018 08:56:05 -0700 (PDT)
Received: from localhost.localdomain (89-95-107-230.abo.bbox.fr. [89.95.107.230])
        by smtp.gmail.com with ESMTPSA id t69-v6sm10913762wmt.40.2018.08.09.08.56.04
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Aug 2018 08:56:04 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Duy Nguyen <pclouds@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Beller <sbeller@google.com>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [PATCH v3 6/8] t: add t5319-delta-islands.sh
Date:   Thu,  9 Aug 2018 17:55:30 +0200
Message-Id: <20180809155532.26151-7-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.555.g17f9c4abba
In-Reply-To: <20180809155532.26151-1-chriscool@tuxfamily.org>
References: <20180809155532.26151-1-chriscool@tuxfamily.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t5319-delta-islands.sh | 143 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100755 t/t5319-delta-islands.sh

diff --git a/t/t5319-delta-islands.sh b/t/t5319-delta-islands.sh
new file mode 100755
index 0000000000..fea92a5777
--- /dev/null
+++ b/t/t5319-delta-islands.sh
@@ -0,0 +1,143 @@
+#!/bin/sh
+
+test_description='exercise delta islands'
+. ./test-lib.sh
+
+# returns true iff $1 is a delta based on $2
+is_delta_base () {
+	delta_base=$(echo "$1" | git cat-file --batch-check='%(deltabase)') &&
+	echo >&2 "$1 has base $delta_base" &&
+	test "$delta_base" = "$2"
+}
+
+# generate a commit on branch $1 with a single file, "file", whose
+# content is mostly based on the seed $2, but with a unique bit
+# of content $3 appended. This should allow us to see whether
+# blobs of different refs delta against each other.
+commit() {
+	blob=$({ test-tool genrandom "$2" 10240 && echo "$3"; } |
+	       git hash-object -w --stdin) &&
+	tree=$(printf '100644 blob %s\tfile\n' "$blob" | git mktree) &&
+	commit=$(echo "$2-$3" | git commit-tree "$tree" ${4:+-p "$4"}) &&
+	git update-ref "refs/heads/$1" "$commit" &&
+	eval "$1"'=$(git rev-parse $1:file)' &&
+	eval "echo >&2 $1=\$$1"
+}
+
+test_expect_success 'setup commits' '
+	commit one seed 1 &&
+	commit two seed 12
+'
+
+# Note: This is heavily dependent on the "prefer larger objects as base"
+# heuristic.
+test_expect_success 'vanilla repack deltas one against two' '
+	git repack -adf &&
+	is_delta_base $one $two
+'
+
+test_expect_success 'island repack with no island definition is vanilla' '
+	git repack -adfi &&
+	is_delta_base $one $two
+'
+
+test_expect_success 'island repack with no matches is vanilla' '
+	git -c "pack.island=refs/foo" repack -adfi &&
+	is_delta_base $one $two
+'
+
+test_expect_success 'separate islands disallows delta' '
+	git -c "pack.island=refs/heads/(.*)" repack -adfi &&
+	! is_delta_base $one $two &&
+	! is_delta_base $two $one
+'
+
+test_expect_success 'same island allows delta' '
+	git -c "pack.island=refs/heads" repack -adfi &&
+	is_delta_base $one $two
+'
+
+test_expect_success 'coalesce same-named islands' '
+	git \
+		-c "pack.island=refs/(.*)/one" \
+		-c "pack.island=refs/(.*)/two" \
+		repack -adfi &&
+	is_delta_base $one $two
+'
+
+test_expect_success 'island restrictions drop reused deltas' '
+	git repack -adfi &&
+	is_delta_base $one $two &&
+	git -c "pack.island=refs/heads/(.*)" repack -adi &&
+	! is_delta_base $one $two &&
+	! is_delta_base $two $one
+'
+
+test_expect_success 'island regexes are left-anchored' '
+	git -c "pack.island=heads/(.*)" repack -adfi &&
+	is_delta_base $one $two
+'
+
+test_expect_success 'island regexes follow last-one-wins scheme' '
+	git \
+		-c "pack.island=refs/heads/(.*)" \
+		-c "pack.island=refs/heads/" \
+		repack -adfi &&
+	is_delta_base $one $two
+'
+
+test_expect_success 'setup shared history' '
+	commit root shared root &&
+	commit one shared 1 root &&
+	commit two shared 12-long root
+'
+
+# We know that $two will be preferred as a base from $one,
+# because we can transform it with a pure deletion.
+#
+# We also expect $root as a delta against $two by the "longest is base" rule.
+test_expect_success 'vanilla delta goes between branches' '
+	git repack -adf &&
+	is_delta_base $one $two &&
+	is_delta_base $root $two
+'
+
+# Here we should allow $one to base itself on $root; even though
+# they are in different islands, the objects in $root are in a superset
+# of islands compared to those in $one.
+#
+# Similarly, $two can delta against $root by our rules. And unlike $one,
+# in which we are just allowing it, the island rules actually put $root
+# as a possible base for $two, which it would not otherwise be (due to the size
+# sorting).
+test_expect_success 'deltas allowed against superset islands' '
+	git -c "pack.island=refs/heads/(.*)" repack -adfi &&
+	is_delta_base $one $root &&
+	is_delta_base $two $root
+'
+
+# We are going to test the packfile order here, so we again have to make some
+# assumptions. We assume that "$root", as part of our core "one", must come
+# before "$two". This should be guaranteed by the island code. However, for
+# this test to fail without islands, we are also assuming that it would not
+# otherwise do so. This is true by the current write order, which will put
+# commits (and their contents) before their parents.
+test_expect_success 'island core places core objects first' '
+	cat >expect <<-EOF &&
+	$root
+	$two
+	EOF
+	git -c "pack.island=refs/heads/(.*)" \
+	    -c "pack.islandcore=one" \
+	    repack -adfi &&
+	git verify-pack -v .git/objects/pack/*.pack |
+	cut -d" " -f1 |
+	egrep "$root|$two" >actual &&
+	test_cmp expect actual
+'
+
+test_expect_success 'unmatched island core is not fatal' '
+	git -c "pack.islandcore=one" repack -adfi
+'
+
+test_done
-- 
2.18.0.555.g17f9c4abba

