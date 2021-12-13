Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28B4BC433EF
	for <git@archiver.kernel.org>; Mon, 13 Dec 2021 06:32:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbhLMGcD (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 13 Dec 2021 01:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232226AbhLMGcB (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Dec 2021 01:32:01 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B131C061748
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:01 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id p23so17350418iod.7
        for <git@vger.kernel.org>; Sun, 12 Dec 2021 22:32:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RV005bYLYVmT+17RQVAImFfKQLb6x+KwNGMizg4pl1U=;
        b=OAZcNgtSEczsiTwd8bBTRYJ1PZzU9zLe5gBX0+DpVKB0ugxQ+YTxbiWmvV+QsekCOs
         oBc9HbZFCdtR4qfqZwkfn7j4uHFzJ/JbB4Cp/SqgzRgKZh/Hj9KRBzv/M8xxhsQ00VCy
         Sdkb10e/NWr5GwXxDJcCBpGhNZvk2z7+m3IMXhrGAklEG7iOgvRYZaojbCIxIZUSu/ue
         qzFbIkXk+AeZ8iRY+Jhv+PLVIF/xqSZBxaJw9be4/z3XarUIEMGaRznLsbZ6YxwGXKkY
         cu3ybu93eZv9TYoh14f+Mquv6L8KDYCjKxSgbs19yU74BSUuH17leog8DRerk+eI6W7J
         KEhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references:mime-version:content-transfer-encoding;
        bh=RV005bYLYVmT+17RQVAImFfKQLb6x+KwNGMizg4pl1U=;
        b=Inuq43Y2uO5TZ9sO6dBtWRGC4DRA7FqNag42FFuo6P5OTJKP9ZUwzu88VeqGBCtMv4
         CL3OFepRoVjrO9jhawvwPOowlQawSgIa9DyHNQ9FUpNmuPaKQZSK6LGeeFCtkvXr9rzn
         xSZ60dztAZlvoDcr/+Lad6H2EcJCLsphQfUO3e0erhpRVhSy9pGay4ACULIVGN1e8ufv
         kTFIQuDRII3nahHLXhcfQPHiiZyjeNn0cIT11zGz3Az6+dMxZ98wDrhBfMKu62LoVKFP
         YonLkWG4gXSAU3NDxKaPperg8Vg8ksjDDWzbf0eTrImb4MtCRkjnVt9j3kpFiqnONOvN
         EnyQ==
X-Gm-Message-State: AOAM532/V+xTn3VbzuJpoz7EoV4LVR/nfHUnw8IHtvtUaqqqvEp9k6PV
        RfwmI500/IqfALqYH/+IXzWpIoOdbw5TLA==
X-Google-Smtp-Source: ABdhPJw4oQvn7bnhre+pdW6G2BxiPvZ1jb+WDAb9SygxODhJNYCxFbfIS9Y1ScChKuneDJ55T7ZLHQ==
X-Received: by 2002:a6b:d904:: with SMTP id r4mr30531589ioc.165.1639377120301;
        Sun, 12 Dec 2021 22:32:00 -0800 (PST)
Received: from localhost.localdomain (097-069-216-153.res.spectrum.com. [97.69.216.153])
        by smtp.gmail.com with ESMTPSA id f10sm7305408ils.13.2021.12.12.22.31.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 12 Dec 2021 22:32:00 -0800 (PST)
Sender: Eric Sunshine <ericsunshine@gmail.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
To:     git@vger.kernel.org
Cc:     Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>,
        Fabian Stelzer <fs@gigacodes.de>,
        Eric Sunshine <sunshine@sunshineco.com>
Subject: [PATCH 03/15] t/chainlint/*.test: generalize self-test commentary
Date:   Mon, 13 Dec 2021 01:30:47 -0500
Message-Id: <20211213063059.19424-4-sunshine@sunshineco.com>
X-Mailer: git-send-email 2.34.1.397.gfae76fe5da
In-Reply-To: <20211213063059.19424-1-sunshine@sunshineco.com>
References: <20211213063059.19424-1-sunshine@sunshineco.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The purpose of chainlint.sed is to detect &&-chain breakage only within
subshells (one level deep); it doesn't bother checking for top-level
&&-chain breakage since the &&-chain checker built into t/test-lib.sh
should detect broken &&-chains outside of subshells by making them
magically exit with code 117. However, this division of labor may not
always be the case if a more capable chainlint implementation is ever
developed. Beyond that, due to being sed-based and due to its use of
heuristics, chainlint.sed has several limitations (such as being unable
to detect &&-chain breakage in subshells more than one level deep since
it only manually emulates recursion into a subshell).

Some of the comments in the chainlint self-tests unnecessarily reflect
the limitations of chainlint.sed even though those limitations are not
what is being tested. Therefore, simplify and generalize the comments to
explain only what is being tested, thus ensuring that they won't become
outdated if a more capable chainlint is ever developed.

Signed-off-by: Eric Sunshine <sunshine@sunshineco.com>
---
 t/chainlint/blank-line.test      | 2 +-
 t/chainlint/block.test           | 3 +--
 t/chainlint/cuddled.test         | 3 +--
 t/chainlint/nested-subshell.test | 1 -
 t/chainlint/one-liner.test       | 2 +-
 t/chainlint/semicolon.test       | 4 ++--
 6 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/t/chainlint/blank-line.test b/t/chainlint/blank-line.test
index f6dd14302b..0fdf15b3e1 100644
--- a/t/chainlint/blank-line.test
+++ b/t/chainlint/blank-line.test
@@ -3,7 +3,7 @@
 	nothing &&
 
 	something
-# LINT: swallow blank lines since final _statement_ before subshell end is
+# LINT: ignore blank lines since final _statement_ before subshell end is
 # LINT: significant to "&&"-check, not final _line_ (which might be blank)
 
 
diff --git a/t/chainlint/block.test b/t/chainlint/block.test
index d859151af1..0a82fd579f 100644
--- a/t/chainlint/block.test
+++ b/t/chainlint/block.test
@@ -1,6 +1,5 @@
 (
-# LINT: missing "&&" in block not currently detected (for consistency with
-# LINT: --chain-lint at top level and to provide escape hatch if needed)
+# LINT: missing "&&" after first "echo"
 	foo &&
 	{
 		echo a
diff --git a/t/chainlint/cuddled.test b/t/chainlint/cuddled.test
index 0499fa4180..257b5b5eed 100644
--- a/t/chainlint/cuddled.test
+++ b/t/chainlint/cuddled.test
@@ -1,5 +1,4 @@
-# LINT: first subshell statement cuddled with opening "("; for implementation
-# LINT: simplicity, "(..." is split into two lines, "(" and "..."
+# LINT: first subshell statement cuddled with opening "("
 (cd foo &&
 	bar
 ) &&
diff --git a/t/chainlint/nested-subshell.test b/t/chainlint/nested-subshell.test
index 998b05a47d..440ee9992d 100644
--- a/t/chainlint/nested-subshell.test
+++ b/t/chainlint/nested-subshell.test
@@ -7,7 +7,6 @@
 
 	cd foo &&
 	(
-# LINT: nested multi-line subshell not presently checked for missing "&&"
 		echo a
 		echo b
 	) >file
diff --git a/t/chainlint/one-liner.test b/t/chainlint/one-liner.test
index ec9acb9825..69796d7505 100644
--- a/t/chainlint/one-liner.test
+++ b/t/chainlint/one-liner.test
@@ -3,7 +3,7 @@
 (foo && bar) |
 (foo && bar) >baz &&
 
-# LINT: top-level one-liner subshell missing internal "&&"
+# LINT: top-level one-liner subshell missing internal "&&" and broken &&-chain
 (foo; bar) &&
 (foo; bar) |
 (foo; bar) >baz
diff --git a/t/chainlint/semicolon.test b/t/chainlint/semicolon.test
index d82c8ebbc0..67e1192c50 100644
--- a/t/chainlint/semicolon.test
+++ b/t/chainlint/semicolon.test
@@ -15,11 +15,11 @@
 	cat foo; echo bar
 ) &&
 (
-# LINT: unnecessary terminating semicolon
+# LINT: semicolon unnecessary but legitimate
 	foo;
 ) &&
 (cd foo &&
 	for i in a b c; do
-# LINT: unnecessary terminating semicolon
+# LINT: semicolon unnecessary but legitimate
 		echo;
 	done)
-- 
2.34.1.397.gfae76fe5da

