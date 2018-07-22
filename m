Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 3222C1F597
	for <e@80x24.org>; Sun, 22 Jul 2018 05:49:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727981AbeGVGoc (ORCPT <rfc822;e@80x24.org>);
        Sun, 22 Jul 2018 02:44:32 -0400
Received: from mail-wm0-f66.google.com ([74.125.82.66]:40299 "EHLO
        mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727780AbeGVGob (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 22 Jul 2018 02:44:31 -0400
Received: by mail-wm0-f66.google.com with SMTP id z13-v6so13322851wma.5
        for <git@vger.kernel.org>; Sat, 21 Jul 2018 22:49:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=PnRrNz0JZ1U1p8KtmM78mejW1jWcDKlw1FF76uipqQk=;
        b=ieRnb5XpgYiKOY7mkjWDuJlxB21abzU1wwWr90fcUKw8GDa1GcVaz5QbAKFqzzdGaj
         lsmpohqQIccyP3hFdcNZFV1IRAVnI155l9OFch9xffffk1T/ogRAJB78y8OWK6bHs25X
         dnrsaHlq307Xz23nbgHCT/0JF7cU2cq5FVV6sN/ans879YrmBrW7vU8pFko6MFAN62HN
         VRLJfUbMET2Ryl1kbGXQtVFpa/MeXxKxhIpGGNQ1N1UlfibHDRd2ZwwkLYqRD29E0S2g
         bglOXgix3N1KEf6p8fJvftAiL9Ui6n/edVUEE9KaEc7zSBDRQpJtxkgNglXkMcoXaSog
         SaGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=PnRrNz0JZ1U1p8KtmM78mejW1jWcDKlw1FF76uipqQk=;
        b=nOqvzFAQ1Z13KLlM5U0MpBAPkExEvrN8QZcEswA8EIPbe22TOsqS/Q4wSniBDwDI/z
         vmYRhuZuQdQa8RwjV/i2JIjwdqKCpz0HY1VJLEyFU9CmJeLAAHiEDuned/aDIB/PZpnh
         DCtnqqynPF6hKLXBro0gkRfIGgAkM0hgOWBGgNeZYnUO1dOIDsJprd64c7XAoMwOT6w8
         XwZovRFeNr5wSBRGfOt5/S2WqDaBxYntcw8IvPx4w/9uwOdSBDsYDaNov6icFuU68rdB
         2t33tTUF9/4XAqFzIeTC1evm5jasYIvi6OHVdT4iFOf6nDtBD5roaVBzefhVtNiBKWUN
         6AeA==
X-Gm-Message-State: AOUpUlE3XfV5huKb7p7omM+jYMjjEVztzUcpSFIuy9jqvz9hRc1OMFzc
        dBVHHwIrdm9uVZg5oqL4bBptj3tu
X-Google-Smtp-Source: AAOMgpdJxMkxOgfy9VNv+WGdxUEUJZ/u2zjJ0YdwF2hiSepCPVhhotljIF2tUYTWePv19ZSNIDXabg==
X-Received: by 2002:a1c:2dc8:: with SMTP id t191-v6mr4977922wmt.94.1532238543422;
        Sat, 21 Jul 2018 22:49:03 -0700 (PDT)
Received: from localhost.localdomain (188.10.112.78.rev.sfr.net. [78.112.10.188])
        by smtp.gmail.com with ESMTPSA id d102-v6sm10591856wma.10.2018.07.21.22.49.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 21 Jul 2018 22:49:02 -0700 (PDT)
From:   Christian Couder <christian.couder@gmail.com>
X-Google-Original-From: Christian Couder <chriscool@tuxfamily.org>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>
Subject: [RFC PATCH 5/5] t: add t9930-delta-islands.sh
Date:   Sun, 22 Jul 2018 07:48:36 +0200
Message-Id: <20180722054836.28935-6-chriscool@tuxfamily.org>
X-Mailer: git-send-email 2.18.0.237.gffdb1dbdaa
In-Reply-To: <20180722054836.28935-1-chriscool@tuxfamily.org>
References: <20180722054836.28935-1-chriscool@tuxfamily.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jeff King <peff@peff.net>

Signed-off-by: Jeff King <peff@peff.net>
Signed-off-by: Christian Couder <chriscool@tuxfamily.org>
---
 t/t9930-delta-islands.sh | 143 +++++++++++++++++++++++++++++++++++++++
 1 file changed, 143 insertions(+)
 create mode 100755 t/t9930-delta-islands.sh

diff --git a/t/t9930-delta-islands.sh b/t/t9930-delta-islands.sh
new file mode 100755
index 0000000000..fea92a5777
--- /dev/null
+++ b/t/t9930-delta-islands.sh
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
2.18.0.237.gffdb1dbdaa

