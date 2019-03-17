Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.1 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0618E20248
	for <e@80x24.org>; Sun, 17 Mar 2019 18:37:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726748AbfCQSg7 (ORCPT <rfc822;e@80x24.org>);
        Sun, 17 Mar 2019 14:36:59 -0400
Received: from mail-lf1-f53.google.com ([209.85.167.53]:37120 "EHLO
        mail-lf1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726333AbfCQSg7 (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 17 Mar 2019 14:36:59 -0400
Received: by mail-lf1-f53.google.com with SMTP id u2so10069207lfd.4
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 11:36:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=/VHZ6okNGVPzedtErZrbF5RtEXmBVcbXIZYqJXNlcGE=;
        b=Ef+qxrAp3k3hJkdRNLj4RteGevLYLW232qMMSr5R4U0PpfWOHPT6oMe3wJqZJoyorZ
         wp65LKVsWxOS9t/PgPWk0MpcNsiU/gy8NQDbUn9KHJpugr3+3sokXlBm+hVK7dajXGpv
         8q7Z+Ea9U5SwHjY2zrySs3y2d8YXrmcHPsfs7+0GrU3ZrZCoCyEzIwPWTvjcNgEyZTr0
         tPDK0dvhpZonQWQ/8zVf5A8Pm+UNGQjlQslbWDDQRMPNLH1ewxHhikt+pSs3fCEMzWpy
         h4fn+duk2H9Tyzl/RG3waJODsRBv6lKqsEF0FmQidQIpVzeqNLUBXtIiuGcI/MdG1jZ+
         Z3kQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=/VHZ6okNGVPzedtErZrbF5RtEXmBVcbXIZYqJXNlcGE=;
        b=tc3tpJbqE39TPq9rSg+wU9JHixB6Lj0NX+KOMUXXDpfRxyb7BlMYGMfCMvwEKvchRF
         602y+efqvQhg0MvJ0PSaUrknl5Bk81vLvdrtSa2ZZEWnE6L0sHv/rnFafvo0eq8qo2Tt
         MkVnnl4skNmfJxgcmpgYDeDCX4LSL59k09/I8WQARD8Qg2jjhA0gXQWrnKVjGR/YedOF
         BpESbXLbWsWo/PhjyBJR4miUGW1dycHhB2JTET7/6bqx2I3jN+DKQwCJy5B/OCtasMFq
         03LaiIySVGkK8iGcBFB6LdmlrYug9Lz0xg72zRJ6eE+2uYwbGSwiOsoFBXUFh/fEog/H
         vtMg==
X-Gm-Message-State: APjAAAXoK/sDgUJN0rp4cIdKFQP71gAeoaBLyEFBoU/LH5IbuQ0mWWQ/
        GLcnk9mBJZg3wqbf/MvZzNAXIqgc
X-Google-Smtp-Source: APXvYqzBKuOEHPMw3o8Cj6KTO1bodQzuJ4c7onaxWaOeGzdwp75Ry+OgfOFDk0WZ19gelc+UPhVVmA==
X-Received: by 2002:a19:6e0b:: with SMTP id j11mr7432606lfc.124.1552847817191;
        Sun, 17 Mar 2019 11:36:57 -0700 (PDT)
Received: from localhost.localdomain (31-211-229-121.customers.ownit.se. [31.211.229.121])
        by smtp.gmail.com with ESMTPSA id e2sm1589484lfc.75.2019.03.17.11.36.55
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 17 Mar 2019 11:36:56 -0700 (PDT)
From:   =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>
Subject: [PATCH 2/4] doc-diff: let `render_tree()` take an explicit directory name
Date:   Sun, 17 Mar 2019 19:36:01 +0100
Message-Id: <249372bed148417dcc77423f53e7f5f7d7a67757.1552838239.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <cover.1552838239.git.martin.agren@gmail.com>
References: <cover.1552838239.git.martin.agren@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In `render_tree()`, `$1` is documented to be the commit-ish/oid and we
use it as that with `git checkout`, but we mostly use it to form the
name of various directories. To separate these concerns, and because we
are about to construct the directory names a bit differently, take two
distinct arguments instead.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/doc-diff | 28 +++++++++++++++++-----------
 1 file changed, 17 insertions(+), 11 deletions(-)

diff --git a/Documentation/doc-diff b/Documentation/doc-diff
index 32c83dd26f..3e975d3c5d 100755
--- a/Documentation/doc-diff
+++ b/Documentation/doc-diff
@@ -79,6 +79,9 @@ then
 	ln -s "$dots/config.mak" "$tmp/worktree/config.mak"
 fi
 
+from_dir=$from_oid &&
+to_dir=$to_oid &&
+
 # generate_render_makefile <srcdir> <dstdir>
 generate_render_makefile () {
 	find "$1" -type f |
@@ -94,7 +97,7 @@ generate_render_makefile () {
 	done
 }
 
-# render_tree <committish_oid>
+# render_tree <committish_oid> <directory_name>
 render_tree () {
 	# Skip install-man entirely if we already have an installed directory.
 	# We can't rely on make here, since "install-man" unconditionally
@@ -102,28 +105,31 @@ render_tree () {
 	# we then can't rely on during the render step). We use "mv" to make
 	# sure we don't get confused by a previous run that failed partway
 	# through.
-	if ! test -d "$tmp/installed/$1"
+	oid=$1 &&
+	dname=$2 &&
+	if ! test -d "$tmp/installed/$dname"
 	then
-		git -C "$tmp/worktree" checkout --detach "$1" &&
+		git -C "$tmp/worktree" checkout --detach "$oid" &&
 		make -j$parallel -C "$tmp/worktree" \
 			GIT_VERSION=omitted \
 			SOURCE_DATE_EPOCH=0 \
-			DESTDIR="$tmp/installed/$1+" \
+			DESTDIR="$tmp/installed/$dname+" \
 			install-man &&
-		mv "$tmp/installed/$1+" "$tmp/installed/$1"
+		mv "$tmp/installed/$dname+" "$tmp/installed/$dname"
 	fi &&
 
 	# As with "installed" above, we skip the render if it's already been
 	# done.  So using make here is primarily just about running in
 	# parallel.
-	if ! test -d "$tmp/rendered/$1"
+	if ! test -d "$tmp/rendered/$dname"
 	then
-		generate_render_makefile "$tmp/installed/$1" "$tmp/rendered/$1+" |
+		generate_render_makefile "$tmp/installed/$dname" \
+			"$tmp/rendered/$dname+" |
 		make -j$parallel -f - &&
-		mv "$tmp/rendered/$1+" "$tmp/rendered/$1"
+		mv "$tmp/rendered/$dname+" "$tmp/rendered/$dname"
 	fi
 }
 
-render_tree $from_oid &&
-render_tree $to_oid &&
-git -C $tmp/rendered diff --no-index "$@" $from_oid $to_oid
+render_tree $from_oid $from_dir &&
+render_tree $to_oid $to_dir &&
+git -C $tmp/rendered diff --no-index "$@" $from_dir $to_dir
-- 
2.21.0

