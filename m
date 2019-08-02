Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2879F1F731
	for <e@80x24.org>; Fri,  2 Aug 2019 16:29:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391233AbfHBQ3Y (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Aug 2019 12:29:24 -0400
Received: from mail-pg1-f177.google.com ([209.85.215.177]:36414 "EHLO
        mail-pg1-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2391044AbfHBQ3Y (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Aug 2019 12:29:24 -0400
Received: by mail-pg1-f177.google.com with SMTP id l21so36316866pgm.3
        for <git@vger.kernel.org>; Fri, 02 Aug 2019 09:29:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zFYTnCjbjzjCnIJDJAAS0ie/LdQaE/Pmv7zKhbBIs+A=;
        b=iPZ7tFkNN6BNZnuLKp3S9RuGHPL0YgrcKxFDubp0M5TbhgJnYSY8KBvmAuhEDqOIBr
         RRQBgvlu0C3jupC7lwkbUJNtlQX5D3dinsJwp8pmhTM4GXX5Knp9FlX40tqK4rzjd/LL
         TqjCi/z4xFNu4Fl+NeK3BtGo7oJ+1JregK/E7MaJBSVXbGYVOqA+3LI9PEadcJWbAk4w
         0y9f4gGKTZy1p0wnWkHsVzdobfvfanQBh6q1n3uM0xSLRXnAMJR3dyxH03T3foHUDbUH
         rAJrOUru80x3Un6ug9QZSlfJ+s3iY44UaTAsL2LjQV6TYy1tDkMRGpdT+AZbfSnAMHPi
         3Z7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zFYTnCjbjzjCnIJDJAAS0ie/LdQaE/Pmv7zKhbBIs+A=;
        b=s6Vcult/TFpc9oio7mcEYglVJoPCGhkT3zyr9tzhMhjaIGbIob8J5TfzZnfBh80oY4
         nG5ZUEXff8LK1QIbDIuUKFXxEfwfUysQNfswg9EjFG5aHpp/nb5w5dncMgd+vNgH44Bq
         lErB1p9N+kH2c2y2TpbJQSO/+kSLd1KT5BC7rS2hEXuPNv4sHk837HCt/7ZVFc8X4kDQ
         nI+dEw4imbZ7OdHMvBQXrdcdApEUb8SKoqLZI0j7wq7KMFgXOrzYubWi6+hg3BQu51nq
         d4ADmJuzJlABFgdSIQGqqqEbXZofjdIBbRH0OUMSryB0Vr3UUhfiUC5olRVbSX/5uh8H
         lBCw==
X-Gm-Message-State: APjAAAXxH2SIcI/zicJiWvj8hp91KSWgA9Oy+Iuexo3bpcmml/fdTq4Z
        iETCA2lzULVmRk9hI5mB20k=
X-Google-Smtp-Source: APXvYqzgCRSb+qqayQ/k0Y9HzpOqwtt9DMBPPJ+zB8q++/yPYdlXuFScbqRjEk8Rts1zuhjmbVnTHA==
X-Received: by 2002:aa7:96a4:: with SMTP id g4mr62852559pfk.193.1564763363538;
        Fri, 02 Aug 2019 09:29:23 -0700 (PDT)
Received: from localhost.localdomain (92.18.24.136.in-addr.arpa. [136.24.18.92])
        by smtp.googlemail.com with ESMTPSA id f14sm75877915pfn.53.2019.08.02.09.29.22
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Fri, 02 Aug 2019 09:29:23 -0700 (PDT)
From:   Varun Naik <vcnaik94@gmail.com>
To:     vcnaik94@gmail.com
Cc:     git@vger.kernel.org, peff@peff.net, gitster@pobox.com
Subject: [PATCH v3] checkout.c: unstage empty deleted ita files
Date:   Fri,  2 Aug 2019 09:28:52 -0700
Message-Id: <20190802162852.14498-1-vcnaik94@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190726045645.2437-1-vcnaik94@gmail.com>
References: <20190726045645.2437-1-vcnaik94@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

It is possible to delete a committed file from the index and then add it
as intent-to-add. After `git checkout HEAD <pathspec>`, the file should
be identical in the index and HEAD. The command already works correctly
if the file has contents in HEAD. This patch provides the desired
behavior even when the file is empty in HEAD.

`git checkout HEAD <pathspec>` calls tree.c:read_tree_1(), with fn
pointing to checkout.c:update_some(). update_some() creates a new cache
entry but discards it when its mode and oid match those of the old
entry. A cache entry for an ita file and a cache entry for an empty file
have the same oid. Therefore, an empty deleted ita file previously
passed both of these checks, and the new entry was discarded, so the
file remained unchanged in the index. After this fix, if the file is
marked as ita in the cache, then we avoid discarding the new entry and
add the new entry to the cache instead.

This change should not affect newly added ita files. For those, inside
tree.c:read_tree_1(), tree_entry_interesting() returns
entry_not_interesting, so fn is never called.

Helped-by: Jeff King <peff@peff.net>
Signed-off-by: Varun Naik <vcnaik94@gmail.com>
---
This patch fixes and tests "checkout". New in v3 is an improved commit
message that clarifies that the affected command is `git checkout HEAD
<pathspec>`.

 builtin/checkout.c        |  1 +
 t/t2022-checkout-paths.sh | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/builtin/checkout.c b/builtin/checkout.c
index ffa776c6e1..c41dfa53a9 100644
--- a/builtin/checkout.c
+++ b/builtin/checkout.c
@@ -105,6 +105,7 @@ static int update_some(const struct object_id *oid, struct strbuf *base,
 	if (pos >= 0) {
 		struct cache_entry *old = active_cache[pos];
 		if (ce->ce_mode == old->ce_mode &&
+		    !ce_intent_to_add(old) &&
 		    oideq(&ce->oid, &old->oid)) {
 			old->ce_flags |= CE_UPDATE;
 			discard_cache_entry(ce);
diff --git a/t/t2022-checkout-paths.sh b/t/t2022-checkout-paths.sh
index fc3eb43b89..6844afafc0 100755
--- a/t/t2022-checkout-paths.sh
+++ b/t/t2022-checkout-paths.sh
@@ -78,4 +78,15 @@ test_expect_success 'do not touch files that are already up-to-date' '
 	test_cmp expect actual
 '
 
+test_expect_success 'checkout HEAD adds deleted intent-to-add file back to index' '
+	echo "nonempty" >nonempty &&
+	>empty &&
+	git add nonempty empty &&
+	git commit -m "create files to be deleted" &&
+	git rm --cached nonempty empty &&
+	git add -N nonempty empty &&
+	git checkout HEAD nonempty empty &&
+	git diff --cached --exit-code
+'
+
 test_done
-- 
2.22.0

