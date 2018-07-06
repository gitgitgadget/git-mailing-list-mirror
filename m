Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.4 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 445971F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 19:34:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S934892AbeGFTeV (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 15:34:21 -0400
Received: from mail-vk0-f73.google.com ([209.85.213.73]:57010 "EHLO
        mail-vk0-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S934885AbeGFTeT (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 15:34:19 -0400
Received: by mail-vk0-f73.google.com with SMTP id q184-v6so4947612vke.23
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 12:34:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:date:in-reply-to:message-id:references:subject:from:to
         :cc;
        bh=XX8Zn4ztwgBW8q/ruX6hBIouO9o+qutC/qcKplie0Ic=;
        b=tyDhu7NeOfuMxltQpxPSjEu5493XX0xvF4cacnsNwYRE6JMyfjRGYIWAQpzMYFd6Mx
         0ebPSM3fwfKGW3OSeoO4UFngAVtOejLTEPI4mkoq2mzfFpQakyw6K2mDiVnY2s48a1ZY
         SDhzrVF6HjgvE7HIb9pUuDUh9+Fu9GEgLGS8pKCc7gUsdv9HI0P4muRYlDYDKcaZ8ZWv
         YtXI02zMsoiqFcO+MiLboZGdNfpDgOedHH/wNgQz6o1+iBjMlpfZWA8BFFDdBDl9W3OX
         ULxH1HizuqeXxI6IR9x71fJe8Iiso9DjhTmcybxEehnMGQkjKG2o0YQathVrprIiLDIc
         781Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:date:in-reply-to:message-id
         :references:subject:from:to:cc;
        bh=XX8Zn4ztwgBW8q/ruX6hBIouO9o+qutC/qcKplie0Ic=;
        b=iUKSAPheZbSmcXY+k/Gb0Ssx37GO541ik1/7XF83Go7KGxcGLkBmqjGniRxltnIDJs
         oBH+FmgXbSFYQ74dsjCyUePawBP2NI+QuzyzveRyPhGr+HwZ9kRhly1uBOn/0kUHCAbg
         /A1byDt985+WA9WU58eYD4crneDevkEAr6m82VgPU0yd/Fu6IMbPNsexQNALXeQItw3g
         yDYsKmB/osmAXCpT8aJec9B7uVQLDC4X6fzD0Fp7XTviRBPItSIcIYFJ0CDYE/5CzKtw
         BgoPD+z6f1PvLVfoV61nPWDJtjV6pKgHrvGasVjxHXUqiSlI5W89LYcYZrmuu8VOshLa
         T0sQ==
X-Gm-Message-State: APt69E1kIi+R0qiaDVa70kf1wl5Q4NDg9UOgkqIBkOcdQWDraZk7rBuq
        SAjrpFQYf1goalfWsg6N9PgxNQ+PgUB8QvcvYH1iWPE3mDhg6KfULNs2a80MvM5a5DYgclLnThY
        MsWFz+bmw7reQPO0I0onUAq6HaY2Gq4admSKV69kJrai8SR/84JmdXYCCPGMKqAsGiQR7eU0B+E
        c6
X-Google-Smtp-Source: AAOMgpcnsBSaQ5lIsJMwU+N73JSkuSq0WZZsaOgt581HRrxVQiZ2H0UBZZzGP40LnKLP6wfwlj8uZOLMg08oFxW72G/b
MIME-Version: 1.0
X-Received: by 2002:a1f:308c:: with SMTP id w134-v6mr5056932vkw.94.1530905658386;
 Fri, 06 Jul 2018 12:34:18 -0700 (PDT)
Date:   Fri,  6 Jul 2018 12:34:10 -0700
In-Reply-To: <cover.1530905323.git.jonathantanmy@google.com>
Message-Id: <09abde498b73c49fbf71c0dbb7680d23bd63e3b2.1530905323.git.jonathantanmy@google.com>
References: <cover.1530905323.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.18.0.203.gfac676dfb9-goog
Subject: [PATCH 2/2] clone: check connectivity even if clone is partial
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>, git@jeffhostetler.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The commit that introduced the partial clone feature - 548719fbdc
("clone: partial clone", 2017-12-08) - excluded connectivity checks
for partial clones, but this also meant that it is possible for a clone
to succeed, yet not have all objects either present or promised.
Specifically, if cloning with --filter=blob:none from a repository that
has a tag pointing to a blob, and the blob is not sent in the packfile,
the clone will pass, even if the blob is not referenced by any tree in
the packfile.

Turn on connectivity checks for partial clone.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/clone.c          |  2 +-
 t/t5616-partial-clone.sh | 48 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 49 insertions(+), 1 deletion(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 8f86d99c51..fa53550758 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -1201,7 +1201,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	update_remote_refs(refs, mapped_refs, remote_head_points_at,
 			   branch_top.buf, reflog_msg.buf, transport,
-			   !is_local && !filter_options.choice);
+			   !is_local);
 
 	update_head(our_head_points_at, remote_head, reflog_msg.buf);
 
diff --git a/t/t5616-partial-clone.sh b/t/t5616-partial-clone.sh
index 8a2bf86491..44d8e80171 100755
--- a/t/t5616-partial-clone.sh
+++ b/t/t5616-partial-clone.sh
@@ -170,4 +170,52 @@ test_expect_success 'partial clone fetches blobs pointed to by refs even if norm
 	git -C dst fsck
 '
 
+. "$TEST_DIRECTORY"/lib-httpd.sh
+start_httpd
+
+# Converts bytes into a form suitable for inclusion in a sed command. For
+# example, "printf 'ab\r\n' | hex_unpack" results in '\x61\x62\x0d\x0a'.
+sed_escape () {
+	perl -e '$/ = undef; $input = <>; print unpack("H2" x length($input), $input)' |
+		sed 's/\(..\)/\\x\1/g'
+}
+
+test_expect_success 'upon cloning, check that all refs point to objects' '
+	SERVER="$HTTPD_DOCUMENT_ROOT_PATH/server" &&
+	rm -rf "$SERVER" repo &&
+	test_create_repo "$SERVER" &&
+	test_commit -C "$SERVER" foo &&
+	test_config -C "$SERVER" uploadpack.allowfilter 1 &&
+	test_config -C "$SERVER" uploadpack.allowanysha1inwant 1 &&
+
+	# Create a tag pointing to a blob.
+	BLOB=$(echo blob-contents | git -C "$SERVER" hash-object --stdin -w) &&
+	git -C "$SERVER" tag myblob "$BLOB" &&
+
+	# Craft a packfile not including that blob.
+	git -C "$SERVER" rev-parse HEAD |
+		git -C "$SERVER" pack-objects --stdout >incomplete.pack &&
+
+	# Replace the existing packfile with the crafted one. The protocol
+	# requires that the packfile be sent in sideband 1, hence the extra
+	# \x01 byte at the beginning.
+	printf "1,/packfile/!c %04x\\\\x01%s0000" \
+		"$(($(wc -c <incomplete.pack) + 5))" \
+		"$(sed_escape <incomplete.pack)" \
+		>"$HTTPD_ROOT_PATH/one-time-sed" &&
+
+	# Use protocol v2 because the sed command looks for the "packfile"
+	# section header.
+	test_config -C "$SERVER" protocol.version 2 &&
+	test_must_fail git -c protocol.version=2 clone \
+		--filter=blob:none $HTTPD_URL/one_time_sed/server repo 2>err &&
+
+	grep "did not send all necessary objects" err &&
+
+	# Ensure that the one-time-sed script was used.
+	! test -e "$HTTPD_ROOT_PATH/one-time-sed"
+'
+
+stop_httpd
+
 test_done
-- 
2.18.0.203.gfac676dfb9-goog

