Return-Path: <SRS0=LF8V=6I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 723FCC54FD0
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:11:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A8882071E
	for <git@archiver.kernel.org>; Fri, 24 Apr 2020 17:11:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20150623.gappssmtp.com header.i=@ttaylorr-com.20150623.gappssmtp.com header.b="tcF8xbMz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728524AbgDXRLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 24 Apr 2020 13:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726698AbgDXRLm (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 24 Apr 2020 13:11:42 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46BF2C09B046
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:11:42 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id x26so4901598pgc.10
        for <git@vger.kernel.org>; Fri, 24 Apr 2020 10:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WY4z7aFTRWQg+3YNvvA55UCe+VVpQ0Qa+YyjrFVovHY=;
        b=tcF8xbMzJm5oShU9jAXFpTySbMH1owFK+o1IfaUlFgtgqVa9JgETXVPtdJCCzKUpxU
         ZS1H/JvaZPzCy3wKdW4Z67Zc5NXbEu3cQ9fN89DAqFy4aZzJl3P2e4zGWw+iZyebm+Ni
         05mBd3RyHbuWmfIT9JV3fYmWQwlWVCvfKNK+b67gH7RfPD10uDZREiVqQad6Te0eWxr3
         /refvft+7R4F7XO+Kce5MEcdzhjvkq1JIPqhnwu6PwMaXr8xtK3Dzeg8mRnzwqG/HhqS
         tJiOz8TCZJMlb81/Ai2c01uhvdELTJ/RdpwJc3NFtEHnpQRNGjOIRWOiA3Z51mPcoH1L
         Wy4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WY4z7aFTRWQg+3YNvvA55UCe+VVpQ0Qa+YyjrFVovHY=;
        b=QM1a7xS4dE3k1v6v+wwV5AASRM1y6SSpZQdR94Bkx5bnUpo8sYri9sKs/1ZPxJRTs7
         U1m/D0RCKzcS7MemO70nRhgz+WmmN/BZ2bL/d0YwqADeO756WqIj5mAocvnp8Zh6jb8C
         gX/lpSR0yD1g+9E+qxQnV92Ex5e9TOBpECr1L5Obrxnlmy8tydkxRGptfH+Dh8H70612
         tehw3aftXmmI7WnjkfOm8PrhwOxHYeHdP1Y5SbkQwvufpwW8/ke2hE/4oEcmfIAMFU8j
         MousDN0zTtfvyRMctRLdFomJd8tDH8RKbR4xIzw96ybDwBCZLwHEzKf+7wo6AUnaynrN
         j5+w==
X-Gm-Message-State: AGi0PuYnQO2iOfo7GeoXX4IpZKZAc4ZH1nLAuO3c09Ebb72XuwzQHpRI
        E/pyFmV+XX/WC7mffgMITYrqCw==
X-Google-Smtp-Source: APiQypJyF0dJ3vf1Gv3Rj3Fb6/o7P4iie+k5R+qrVhAwE1a7Ij75NVkoDWhk5/3iFhzDTYqdgZ+NyA==
X-Received: by 2002:a63:d546:: with SMTP id v6mr10055892pgi.228.1587748301574;
        Fri, 24 Apr 2020 10:11:41 -0700 (PDT)
Received: from localhost ([8.44.146.30])
        by smtp.gmail.com with ESMTPSA id f3sm5082487pjo.24.2020.04.24.10.11.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Apr 2020 10:11:40 -0700 (PDT)
Date:   Fri, 24 Apr 2020 11:11:39 -0600
From:   Taylor Blau <me@ttaylorr.com>
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        jonathantanmy@google.com, gitster@pobox.com, newren@gmail.com
Subject: Re: [PATCH v2 1/2] t5537: use test_write_lines, indented heredocs
 for readability
Message-ID: <20200424171139.GA61470@syl.local>
References: <20200423001438.GC19100@syl.local>
 <cover.1587601501.git.me@ttaylorr.com>
 <5c9217ad8fc594fbff46507c4be7961eb5a478e2.1587601501.git.me@ttaylorr.com>
 <20200423011444.GG140314@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200423011444.GG140314@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 22, 2020 at 06:14:44PM -0700, Jonathan Nieder wrote:
> Hi,
>
> Taylor Blau wrote:
>
> > A number of spots in t5537 use the non-indented heredoc '<<EOF' when
> > they would benefit from instead using '<<-EOF' or simply
> > test_write_lines.
> >
> > In preparation for adding new tests in a good style and being consistent
> > with the surrounding code, update the existing tests to improve their
> > readability.
> >
> > Suggested-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Taylor Blau <me@ttaylorr.com>
> > ---
> >  t/t5537-fetch-shallow.sh | 70 +++++++++++-----------------------------
> >  1 file changed, 18 insertions(+), 52 deletions(-)
>
> Sounds like a good idea.  Some nitpicks --- please don't act on them
> all, but only the ones that seem appropriate to you:

Thanks -- here's an updated venison of this patch with some of the more
minor points addressed. I agree that there is room for cleaning up these
tests more substantially, but I think that those can be done in other
patches.

Junio -- would you please used the patch below as PATCH 1/2 instead of
the original here? Thanks.

-- 8< --

Subject: [PATCH] t5537: use test_write_lines, indented heredocs for readability

A number of spots in t5537 use the non-indented heredoc '<<EOF' when
they would benefit from instead using '<<-EOF' or simply
test_write_lines.

In preparation for adding new tests in a good style and being consistent
with the surrounding code, update the existing tests to improve their
readability.

Suggested-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Taylor Blau <me@ttaylorr.com>
---
 t/t5537-fetch-shallow.sh | 70 ++++++++++------------------------------
 1 file changed, 17 insertions(+), 53 deletions(-)

diff --git a/t/t5537-fetch-shallow.sh b/t/t5537-fetch-shallow.sh
index 4f681dbbe1..d02f9b5ae8 100755
--- a/t/t5537-fetch-shallow.sh
+++ b/t/t5537-fetch-shallow.sh
@@ -16,7 +16,7 @@ test_expect_success 'setup' '
 	commit 3 &&
 	commit 4 &&
 	git config --global transfer.fsckObjects true &&
-	test_oid_cache <<-EOF
+	test_oid_cache <<-\EOF
 	perl sha1:s/0034shallow %s/0036unshallow %s/
 	perl sha256:s/004cshallow %s/004eunshallow %s/
 	EOF
@@ -25,10 +25,7 @@ test_expect_success 'setup' '
 test_expect_success 'setup shallow clone' '
 	git clone --no-local --depth=2 .git shallow &&
 	git --git-dir=shallow/.git log --format=%s >actual &&
-	cat <<EOF >expect &&
-4
-3
-EOF
+	test_write_lines 4 3 >expect &&
 	test_cmp expect actual
 '

@@ -38,10 +35,7 @@ test_expect_success 'clone from shallow clone' '
 	cd shallow2 &&
 	git fsck &&
 	git log --format=%s >actual &&
-	cat <<EOF >expect &&
-4
-3
-EOF
+	test_write_lines 4 3 >expect &&
 	test_cmp expect actual
 	)
 '
@@ -56,11 +50,7 @@ test_expect_success 'fetch from shallow clone' '
 	git fetch &&
 	git fsck &&
 	git log --format=%s origin/master >actual &&
-	cat <<EOF >expect &&
-5
-4
-3
-EOF
+	test_write_lines 5 4 3 >expect &&
 	test_cmp expect actual
 	)
 '
@@ -75,10 +65,7 @@ test_expect_success 'fetch --depth from shallow clone' '
 	git fetch --depth=2 &&
 	git fsck &&
 	git log --format=%s origin/master >actual &&
-	cat <<EOF >expect &&
-6
-5
-EOF
+	test_write_lines 6 5 >expect &&
 	test_cmp expect actual
 	)
 '
@@ -89,12 +76,7 @@ test_expect_success 'fetch --unshallow from shallow clone' '
 	git fetch --unshallow &&
 	git fsck &&
 	git log --format=%s origin/master >actual &&
-	cat <<EOF >expect &&
-6
-5
-4
-3
-EOF
+	test_write_lines 6 5 4 3 >expect &&
 	test_cmp expect actual
 	)
 '
@@ -111,15 +93,10 @@ test_expect_success 'fetch something upstream has but hidden by clients shallow
 	git fetch ../.git +refs/heads/master:refs/remotes/top/master &&
 	git fsck &&
 	git log --format=%s top/master >actual &&
-	cat <<EOF >expect &&
-add-1-back
-4
-3
-EOF
+	test_write_lines add-1-back 4 3 >expect &&
 	test_cmp expect actual
 	) &&
 	git --git-dir=shallow2/.git cat-file blob $(echo 1|git hash-object --stdin) >/dev/null
-
 '

 test_expect_success 'fetch that requires changes in .git/shallow is filtered' '
@@ -133,14 +110,10 @@ test_expect_success 'fetch that requires changes in .git/shallow is filtered' '
 	cd notshallow &&
 	git fetch ../shallow/.git refs/heads/*:refs/remotes/shallow/*&&
 	git for-each-ref --format="%(refname)" >actual.refs &&
-	cat <<EOF >expect.refs &&
-refs/remotes/shallow/no-shallow
-EOF
+	echo refs/remotes/shallow/no-shallow >expect.refs &&
 	test_cmp expect.refs actual.refs &&
 	git log --format=%s shallow/no-shallow >actual &&
-	cat <<EOF >expect &&
-no-shallow
-EOF
+	echo no-shallow >expect &&
 	test_cmp expect actual
 	)
 '
@@ -158,21 +131,15 @@ test_expect_success 'fetch --update-shallow' '
 	git fetch --update-shallow ../shallow/.git refs/heads/*:refs/remotes/shallow/* &&
 	git fsck &&
 	git for-each-ref --sort=refname --format="%(refname)" >actual.refs &&
-	cat <<EOF >expect.refs &&
-refs/remotes/shallow/master
-refs/remotes/shallow/no-shallow
-refs/tags/heavy-tag
-refs/tags/light-tag
-EOF
+	cat <<-\EOF >expect.refs &&
+	refs/remotes/shallow/master
+	refs/remotes/shallow/no-shallow
+	refs/tags/heavy-tag
+	refs/tags/light-tag
+	EOF
 	test_cmp expect.refs actual.refs &&
 	git log --format=%s shallow/master >actual &&
-	cat <<EOF >expect &&
-7
-6
-5
-4
-3
-EOF
+	test_write_lines 7 6 5 4 3 >expect &&
 	test_cmp expect actual
 	)
 '
@@ -183,10 +150,7 @@ test_expect_success POSIXPERM,SANITY 'shallow fetch from a read-only repo' '
 	find read-only.git -print | xargs chmod -w &&
 	git clone --no-local --depth=2 read-only.git from-read-only &&
 	git --git-dir=from-read-only/.git log --format=%s >actual &&
-	cat >expect <<EOF &&
-add-1-back
-4
-EOF
+	test_write_lines add-1-back 4 >expect &&
 	test_cmp expect actual
 '

--
2.26.0.113.ge9739cdccc

