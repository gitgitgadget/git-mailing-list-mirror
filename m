Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-26.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80B52C49EA5
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 22:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 689DE61375
	for <git@archiver.kernel.org>; Wed, 23 Jun 2021 22:31:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbhFWWdX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Jun 2021 18:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229926AbhFWWdV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Jun 2021 18:33:21 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61EA1C06175F
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 15:31:02 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id k196-20020a6284cd0000b0290301abd2c063so2572384pfd.14
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 15:31:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=iZHx0mPJ+cYf9CwrlhS+XsLgiCdB2dH3jKi4OFfFaB4=;
        b=BcCnOzIyU09FITTVoWUZQYYljDG26XNT+S2t/dRnDdxrMFJzIZslqLLDrlfu+aC6Tk
         rzF6/EeknbX60ZbDyOJ099XLGN8Z78TBwGvh2ZKAOftUTNuy6TI62t+ONOJe5FYjFOjj
         tqxhD0uYf1xtozGxHx1W+WgjPVDxnEqyt7PkUTZu5ELm77nWAvYQwoQrYNRXgotMg6P5
         zL0JT6FxD9jkn4kfwNIwfYLQAjLI90YvZelxzyN6ISJHwanDi+4UMru/dLgLSBI0CJuM
         MvxN597B3v94R3TSkcUrHBcJvO6fB8ElK92OaH2q29/d7W2oIAA7F+snDHzCoufp6lCF
         wmjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=iZHx0mPJ+cYf9CwrlhS+XsLgiCdB2dH3jKi4OFfFaB4=;
        b=QJ08/RwMNOmpzVkl2T2YyTLpxvKSyUzhDwA401StMS3XDviqwCoe15TvZl2KB9sjOw
         WhhRz3vzXQHmuMw/le6yuUU/8MHoGb+2whUVLzwH/VJTX+zN6UWPilrmbgPTSiPaXej/
         HuXS0xU+Lf7YQ84G5CkfUQgDnmC2/gEuqVzxjSkFIzRU5TI7bM1ohA2igegLpb68IWoy
         yANIFOC/+ktajid4bwAKVm9BmOCt7lO/Ck/u9RFtq4Ni80HttpjCoBewTzUK9FL8T4DD
         +0Y8JO+xsY+DDc7AEVa/6Aar+SG88xQo/vtqMnUYxzFFhJHw7BcaFKA3k4doGbdqsn3V
         i/vQ==
X-Gm-Message-State: AOAM532LuuBvrFJ3Q4GGyiukXIUjWAB5JcZ64X96SXFE9owjHlZ81+zv
        iOe5pIWhx0UEeMTZw6TITPW+EFYccif9cyIZ6TV/6skVtaEiaK41Y61KjdijYAcih+oZhZ+kBpK
        E1MjJmcv76TxG2C03PZnKQE/Ez2/gOA9M5gvL+vjy7T+aKLAziZks96Gz+9tttWe5uoM1OO3qe7
        qo
X-Google-Smtp-Source: ABdhPJy9jJUYKQtu/EPD6I/YUQLYYcO4h+FqC68e3+XJCtG9p4eCpMwB9vVXr/jumQ73oovPblZ3Sj/r2ddWPdji9PtN
X-Received: from twelve4.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:437a])
 (user=jonathantanmy job=sendgmr) by 2002:a17:902:968a:b029:11d:6448:1352 with
 SMTP id n10-20020a170902968ab029011d64481352mr1465234plp.59.1624487461774;
 Wed, 23 Jun 2021 15:31:01 -0700 (PDT)
Date:   Wed, 23 Jun 2021 15:30:53 -0700
In-Reply-To: <cover.1624486920.git.jonathantanmy@google.com>
Message-Id: <8df607f4cfb3064200bf4effc91726c92804e637.1624486920.git.jonathantanmy@google.com>
Mime-Version: 1.0
References: <cover.1624486920.git.jonathantanmy@google.com>
X-Mailer: git-send-email 2.32.0.288.g62a8d224e6-goog
Subject: [PATCH 3/3] fetch: die on invalid --negotiation-tip hash
From:   Jonathan Tan <jonathantanmy@google.com>
To:     git@vger.kernel.org
Cc:     Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

If a full hexadecimal hash is given as a --negotiation-tip to "git
fetch", and that hash does not correspond to an object, "git fetch" will
segfault if --negotiate-only is given and will silently ignore that hash
otherwise. Make these cases fatal errors, just like the case when an
invalid ref name or abbreviated hash is given.

While at it, mark the error messages as translatable.

Signed-off-by: Jonathan Tan <jonathantanmy@google.com>
---
 builtin/fetch.c  | 4 +++-
 t/t5510-fetch.sh | 9 +++++++++
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 9191620e50..2c50465cff 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -1428,7 +1428,9 @@ static void add_negotiation_tips(struct git_transport_options *smart_options)
 		if (!has_glob_specials(s)) {
 			struct object_id oid;
 			if (get_oid(s, &oid))
-				die("%s is not a valid object", s);
+				die(_("%s is not a valid object"), s);
+			if (!has_object(the_repository, &oid, 0))
+				die(_("%s is not a valid object"), s);
 			oid_array_append(oids, &oid);
 			continue;
 		}
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index e83b2a6506..5fc5750d8d 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -1214,6 +1214,15 @@ test_expect_success '--negotiation-tip understands abbreviated SHA-1' '
 	check_negotiation_tip
 '
 
+test_expect_success '--negotiation-tip rejects missing OIDs' '
+	setup_negotiation_tip server server 0 &&
+	test_must_fail git -C client fetch \
+		--negotiation-tip=alpha_1 \
+		--negotiation-tip=$(test_oid zero) \
+		origin alpha_s beta_s 2>err &&
+	test_i18ngrep "is not a valid object" err
+'
+
 . "$TEST_DIRECTORY"/lib-httpd.sh
 start_httpd
 
-- 
2.32.0.288.g62a8d224e6-goog

