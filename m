Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0E40F1F404
	for <e@80x24.org>; Fri, 16 Feb 2018 03:34:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750743AbeBPDeG (ORCPT <rfc822;e@80x24.org>);
        Thu, 15 Feb 2018 22:34:06 -0500
Received: from mail-lf0-f65.google.com ([209.85.215.65]:34755 "EHLO
        mail-lf0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750727AbeBPDeF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Feb 2018 22:34:05 -0500
Received: by mail-lf0-f65.google.com with SMTP id l191so2352216lfe.1
        for <git@vger.kernel.org>; Thu, 15 Feb 2018 19:34:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:from:date:message-id:subject:to:cc;
        bh=2zoE3xnTLI9v4k5Levxk+PcpRIsGi7ExTfs4XLr+eYs=;
        b=ZL8QtFvpCtB3PCxvidjRU62uIg2DMIiHMHknHsbzZfXHl2wkEwlvo6pQVyH3MZhc67
         qUyxMUq7RY0rNo7rDfMmK2XKXS+jIIaPlcRq6GNNHUXtdX8qRCJoHJfL1QRjRCOuofVg
         jZgnkD59rX0ErCCKAp4GKHhkWyWq3Fel5BpPubjlTJRNOVZTnhmwSCxbTUsntb2tMZ/C
         BSSKwZlp+lXB94K/vyPDHVko00uMTYk85IZ+IR0scqbB6CLucWMN9+uvoKi0YRAXIcoa
         5dqNaPGLZVrXY43tuRhFYBNxixfdijyCjfpWcjhI+f3DOdoxzWl2G9Mstwdy2hZBL3QE
         ymGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to:cc;
        bh=2zoE3xnTLI9v4k5Levxk+PcpRIsGi7ExTfs4XLr+eYs=;
        b=YzBw1Gl/V+h1q3ZSNSP9Z5dJUt4qLBtgb1TzI6VXox7LGj7rmtr18rxuLfyqRvsWJj
         Tf9Wj/fn4fixgRNlwh+CoTJ8yZVBVzHRcAokrVcKnIF1kZh5mdhAJZfX+yv6xZj9VQvl
         /i1uaZ5yIq9kLgdveGNwHrLgFVf4CBQkmmXHkHWqPG+NkhPkUXw+84pIodKc2NToMtty
         WCXCef2D8gRK5vIfp+E7LCpG6cm0lDqPmL56gaKs2SgIAyYBPZWh665zcSheru9SK0Ax
         ZgT9QK1rwKunFVIyQF1IQupG876zDVMe2gHBC7VHOKJ5hgJv7I8tJvozBCz++MRnSazK
         4yGQ==
X-Gm-Message-State: APf1xPCSoxW2AIeWCMDrl8s9UjgnHSu+DBh4+VdZg9+af6WqQVV8du21
        MgESvanbD5rbbU0HpsCqUR1sH76P+iqTnja7c+FnGkDE
X-Google-Smtp-Source: AH8x224kCEup1ofNHga500zdi1dBDdooZQq7B0lTP/YKNSxGBuDJcrg3tDW+XKO3NSQneWzFP4EZhEZxCkawl/KnkBY=
X-Received: by 10.25.206.131 with SMTP id e125mr3453414lfg.145.1518752043677;
 Thu, 15 Feb 2018 19:34:03 -0800 (PST)
MIME-Version: 1.0
Received: by 10.46.125.26 with HTTP; Thu, 15 Feb 2018 19:34:03 -0800 (PST)
From:   Stephen R Guglielmo <srguglielmo@gmail.com>
Date:   Thu, 15 Feb 2018 22:34:03 -0500
Message-ID: <CADfK3RXjK9ExcSLLxkbkDvb2o_U9+7Ykua5cHEXc9+uUU17z9g@mail.gmail.com>
Subject: [PATCH] subtree: hide GPG signatures in calls to log
To:     git <git@vger.kernel.org>
Cc:     Avery Pennarun <apenwarr@gmail.com>,
        Stefan Beller <sbeller@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This fixes `add` and `pull` for GPG signed objects.

Signed-off-by: Stephen R Guglielmo <srg@guglielmo.us>
---
 contrib/subtree/git-subtree.sh | 12 ++++++------
 1 file changed, 6 insertions(+), 6 deletions(-)

diff --git a/contrib/subtree/git-subtree.sh b/contrib/subtree/git-subtree.sh
index dec085a23..9594ca4b5 100755
--- a/contrib/subtree/git-subtree.sh
+++ b/contrib/subtree/git-subtree.sh
@@ -297,7 +297,7 @@ find_latest_squash () {
     main=
     sub=
     git log --grep="^git-subtree-dir: $dir/*\$" \
-        --pretty=format:'START %H%n%s%n%n%b%nEND%n' HEAD |
+        --no-show-signature --pretty=format:'START %H%n%s%n%n%b%nEND%n' HEAD |
     while read a b junk
     do
         debug "$a $b $junk"
@@ -341,7 +341,7 @@ find_existing_splits () {
     main=
     sub=
     git log --grep="^git-subtree-dir: $dir/*\$" \
-        --pretty=format:'START %H%n%s%n%n%b%nEND%n' $revs |
+        --no-show-signature --pretty=format:'START %H%n%s%n%n%b%nEND%n' $revs |
     while read a b junk
     do
         case "$a" in
@@ -382,7 +382,7 @@ copy_commit () {
     # We're going to set some environment vars here, so
     # do it in a subshell to get rid of them safely later
     debug copy_commit "{$1}" "{$2}" "{$3}"
-    git log -1 --pretty=format:'%an%n%ae%n%aD%n%cn%n%ce%n%cD%n%B' "$1" |
+    git log --no-show-signature -1
--pretty=format:'%an%n%ae%n%aD%n%cn%n%ce%n%cD%n%B' "$1" |
     (
         read GIT_AUTHOR_NAME
         read GIT_AUTHOR_EMAIL
@@ -462,8 +462,8 @@ squash_msg () {
         oldsub_short=$(git rev-parse --short "$oldsub")
         echo "Squashed '$dir/' changes from $oldsub_short..$newsub_short"
         echo
-        git log --pretty=tformat:'%h %s' "$oldsub..$newsub"
-        git log --pretty=tformat:'REVERT: %h %s' "$newsub..$oldsub"
+        git log --no-show-signature --pretty=tformat:'%h %s' "$oldsub..$newsub"
+        git log --no-show-signature --pretty=tformat:'REVERT: %h %s'
"$newsub..$oldsub"
     else
         echo "Squashed '$dir/' content from commit $newsub_short"
     fi
@@ -475,7 +475,7 @@ squash_msg () {

 toptree_for_commit () {
     commit="$1"
-    git log -1 --pretty=format:'%T' "$commit" -- || exit $?
+    git rev-parse --verify "$commit^{tree}" || exit $?
 }

 subtree_for_commit () {
-- 
2.16.1
