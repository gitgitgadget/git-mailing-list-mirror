Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RCVD_IN_SORBS_SPAM,RP_MATCHES_RCVD shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BABF520285
	for <e@80x24.org>; Thu, 24 Aug 2017 22:54:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754056AbdHXWyP (ORCPT <rfc822;e@80x24.org>);
        Thu, 24 Aug 2017 18:54:15 -0400
Received: from mail-pg0-f51.google.com ([74.125.83.51]:35939 "EHLO
        mail-pg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753998AbdHXWyC (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Aug 2017 18:54:02 -0400
Received: by mail-pg0-f51.google.com with SMTP id r133so4709541pgr.3
        for <git@vger.kernel.org>; Thu, 24 Aug 2017 15:54:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=xedp72fGq9Y7oru8ZUtjndUhAF1KJ56mcCQxBQfpYRw=;
        b=qZIQjl0C2duKZVf7Gt+OzeHDEtpgyaM5ZOBLVHpScdUtyPHK/zCOEKUTXHsrbGQ/GX
         Au6pzEUwHbIfHHJzx88+0udpIHKl9A4UzOJ/TSUoLdJLTgf3jP1N31qMF3SnV42M/gn0
         cYes282zmMtqH+wloJfGGFx5nrcaNMGGKO94fmaKDG9pShNOPOkhdJZbL5xXkGniJAro
         NqzvmflcsfbMe/6ELLhhJ0GASgkyhSzmwUqj7dIfWkubgDJntWkHYV65Ro2h4R2l5i5O
         ivFvshEEqkK01MJlTlfhCB7ICRb449ucrappXDNsskvSLAURmSzYVQtZ+UOa8hDTLAff
         QLPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=xedp72fGq9Y7oru8ZUtjndUhAF1KJ56mcCQxBQfpYRw=;
        b=RWHpbq1aGC/UGyG+XMyRJGhPxFxlVHhngpN32NNGbIHtG8AZkjHbpf3LzA8BNQBwpD
         O2lXvdJzf4TLgjCIb6xVfmR7btCqg5EQRDh9+mENWuoJVeA++/XPwcLRdTTMJnTtc/si
         qm1Dz287BXIs9tZLri2OIE/ude4Hmvk00/aUuRm4QIx7KmMmsq/Y3rLmutioCQF2Rev5
         KWMgLjrsUsj8teufambPEQRjv7yfqXePJOfOea+Y73FJguMGEELE31kIkNGKIGAdM8Wh
         4jlqRDz4CUx55Wqqy1q0wE4pM+HFt71Q/afoRxVLh8FUdEeM5CPEPDrdHjhghbV3i8z2
         EGAg==
X-Gm-Message-State: AHYfb5ivBYOQwzZoACAbiyZ++LURPgWjoupcSP/OEV9VGkmIxt4kuUqQ
        u6Co/dHhzWcnMNZPadHFBw==
X-Google-Smtp-Source: ADKCNb7Dl5MKGssxCS3HEzTiIIZs2vexwc4lrjkq0CQXYAt5vhWmfP9T3r0CEdF0HG84j85O+VFyUw==
X-Received: by 10.99.4.143 with SMTP id 137mr7688222pge.62.1503615240497;
        Thu, 24 Aug 2017 15:54:00 -0700 (PDT)
Received: from roshar.svl.corp.google.com ([100.96.218.30])
        by smtp.gmail.com with ESMTPSA id x8sm9402667pfi.174.2017.08.24.15.53.59
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Thu, 24 Aug 2017 15:53:59 -0700 (PDT)
From:   Brandon Williams <bmwill@google.com>
To:     git@vger.kernel.org
Cc:     peff@peff.net, jrnieder@gmail.com, sbeller@google.com,
        gitster@pobox.com, jonathantanmy@google.com,
        Brandon Williams <bmwill@google.com>
Subject: [RFC 4/7] t: fix ssh tests to cope with using '-o SendEnv=GIT_PROTOCOL'
Date:   Thu, 24 Aug 2017 15:53:25 -0700
Message-Id: <20170824225328.8174-5-bmwill@google.com>
X-Mailer: git-send-email 2.14.1.342.g6490525c54-goog
In-Reply-To: <20170824225328.8174-1-bmwill@google.com>
References: <20170824225328.8174-1-bmwill@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Update some of our tests to cope with ssh being launched with the option
to send the protocol version.

Signed-off-by: Brandon Williams <bmwill@google.com>
---
 t/lib-proto-disable.sh       |  1 +
 t/t5601-clone.sh             | 10 +++++-----
 t/t5602-clone-remote-exec.sh |  4 ++--
 3 files changed, 8 insertions(+), 7 deletions(-)

diff --git a/t/lib-proto-disable.sh b/t/lib-proto-disable.sh
index 83babe57d..d19c88f96 100644
--- a/t/lib-proto-disable.sh
+++ b/t/lib-proto-disable.sh
@@ -194,6 +194,7 @@ setup_ssh_wrapper () {
 	test_expect_success 'setup ssh wrapper' '
 		write_script ssh-wrapper <<-\EOF &&
 		echo >&2 "ssh: $*"
+		shift; shift
 		host=$1; shift
 		cd "$TRASH_DIRECTORY/$host" &&
 		eval "$*"
diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
index 9c56f771b..7e65013c5 100755
--- a/t/t5601-clone.sh
+++ b/t/t5601-clone.sh
@@ -332,13 +332,13 @@ expect_ssh () {
 		1)
 			;;
 		2)
-			echo "ssh: $1 git-upload-pack '$2'"
+			echo "ssh: -o SendEnv=GIT_PROTOCOL $1 git-upload-pack '$2'"
 			;;
 		3)
-			echo "ssh: $1 $2 git-upload-pack '$3'"
+			echo "ssh: -o SendEnv=GIT_PROTOCOL $1 $2 git-upload-pack '$3'"
 			;;
 		*)
-			echo "ssh: $1 $2 git-upload-pack '$3' $4"
+			echo "ssh: $1 -o SendEnv=GIT_PROTOCOL $2 $3 git-upload-pack '$4'"
 		esac
 	} >"$TRASH_DIRECTORY/ssh-expect" &&
 	(cd "$TRASH_DIRECTORY" && test_cmp ssh-expect ssh-output)
@@ -390,7 +390,7 @@ test_expect_success 'double quoted plink.exe in GIT_SSH_COMMAND' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink.exe" &&
 	GIT_SSH_COMMAND="\"$TRASH_DIRECTORY/plink.exe\" -v" \
 		git clone "[myhost:123]:src" ssh-bracket-clone-plink-3 &&
-	expect_ssh "-v -P 123" myhost src
+	expect_ssh "-v" "-P 123" myhost src
 '
 
 SQ="'"
@@ -398,7 +398,7 @@ test_expect_success 'single quoted plink.exe in GIT_SSH_COMMAND' '
 	copy_ssh_wrapper_as "$TRASH_DIRECTORY/plink.exe" &&
 	GIT_SSH_COMMAND="$SQ$TRASH_DIRECTORY/plink.exe$SQ -v" \
 		git clone "[myhost:123]:src" ssh-bracket-clone-plink-4 &&
-	expect_ssh "-v -P 123" myhost src
+	expect_ssh "-v" "-P 123" myhost src
 '
 
 test_expect_success 'GIT_SSH_VARIANT overrides plink detection' '
diff --git a/t/t5602-clone-remote-exec.sh b/t/t5602-clone-remote-exec.sh
index cbcceab9d..b0d80cadd 100755
--- a/t/t5602-clone-remote-exec.sh
+++ b/t/t5602-clone-remote-exec.sh
@@ -13,14 +13,14 @@ test_expect_success setup '
 
 test_expect_success 'clone calls git upload-pack unqualified with no -u option' '
 	test_must_fail env GIT_SSH=./not_ssh git clone localhost:/path/to/repo junk &&
-	echo "localhost git-upload-pack '\''/path/to/repo'\''" >expected &&
+	echo "-o SendEnv=GIT_PROTOCOL localhost git-upload-pack '\''/path/to/repo'\''" >expected &&
 	test_cmp expected not_ssh_output
 '
 
 test_expect_success 'clone calls specified git upload-pack with -u option' '
 	test_must_fail env GIT_SSH=./not_ssh \
 		git clone -u ./something/bin/git-upload-pack localhost:/path/to/repo junk &&
-	echo "localhost ./something/bin/git-upload-pack '\''/path/to/repo'\''" >expected &&
+	echo "-o SendEnv=GIT_PROTOCOL localhost ./something/bin/git-upload-pack '\''/path/to/repo'\''" >expected &&
 	test_cmp expected not_ssh_output
 '
 
-- 
2.14.1.342.g6490525c54-goog

