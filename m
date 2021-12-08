Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B751EC433EF
	for <git@archiver.kernel.org>; Wed,  8 Dec 2021 12:34:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233621AbhLHMiP (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 8 Dec 2021 07:38:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233575AbhLHMiI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 8 Dec 2021 07:38:08 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB99C0698CB
        for <git@vger.kernel.org>; Wed,  8 Dec 2021 04:34:35 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id q3so3845286wru.5
        for <git@vger.kernel.org>; Wed, 08 Dec 2021 04:34:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=xRNtA+ULfQ5ybKhP2md2ovt6QB7AIICfwiVYWiEVzSw=;
        b=awQcscKjodJe/9/vtMxql6FRk1ns5rjBjPmF62pYZL6x07Ttux/5EHi8D2FPIiC30L
         JfGnst9wp28rYeLDuw5LjgmD33jWJ1aWBfx65tCj8SSMCxv+YDWA8jjMelqtYnKyg9Xr
         NKZ+MrIM8XvIhFCsjkeIX+v4jo4Fnw4UHNj3fg2qwNXsCqv/jN/ZiKd8CEfyRNJ6p7SZ
         kh6lfnmRmGIXVK51EleSZzrTvBo1COEX0tZy/4nZpJXW2Qma0muNx/jNLjVw6hgL4lsY
         Sc1juxw5tLDsuDy/Bv1Ce7PYjZCTooZVP0K1H86kgLlKzU9zC+vR3IvlsOD7Q6wDN8jZ
         Yz8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=xRNtA+ULfQ5ybKhP2md2ovt6QB7AIICfwiVYWiEVzSw=;
        b=FynFgLtFt8iQJ+XVrD9bpcBHJxKtWiqQ7Zvye6mOCFE+Q1wVP3nOEhBriI12h1VwFD
         9VEVCX2DXgy4yNIoliX8t5l0Wfx0ZveKKAsLyoQsbbHBxYwzDU513IXBIMdvdYAzELvK
         LlGioq4AeakIannCc6ZX9O9LW1kDM9LYYlAavAQ7ho6UfAZJP8uFin/uIOBeBU/C/QvM
         Kv9TI/ed/OxGvBQQwr7ac5QlStq9MCpdTUfq0nHy0wECGurS29rOiA9EctPro3i3XhTS
         bexljDuvM7pfjMbo3WMw0HBWlwyHWzqf/yHjem/6fJzXZFVtmVWl+tXuoXzUCvaeRt92
         +7Iw==
X-Gm-Message-State: AOAM532rstFRCGHetk4swuGzyiKjkL0EuR1MMdoAe/ZUHKJEQ1TTPoKg
        H8OAuXaWCkum29XsxgDausRpLo9YzJrL4Q==
X-Google-Smtp-Source: ABdhPJymXgVw7bvrxAfve55Bwo92vknG82X9w8GVNvFsAzf6PluFu4f0kJpIvYAz2bpFbiWcTXX1xw==
X-Received: by 2002:a5d:6a4d:: with SMTP id t13mr58772292wrw.104.1638966874305;
        Wed, 08 Dec 2021 04:34:34 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id d8sm2540692wrm.76.2021.12.08.04.34.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Dec 2021 04:34:33 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v4 09/10] object-name.c: don't have GET_OID_ONLY_TO_DIE imply *_QUIETLY
Date:   Wed,  8 Dec 2021 13:34:22 +0100
Message-Id: <patch-v4-09.10-a7447510e4b-20211208T123151Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.926.g895e15e0c0c
In-Reply-To: <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com>
References: <cover-v3-00.10-00000000000-20211129T195357Z-avarab@gmail.com> <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stop having GET_OID_ONLY_TO_DIE imply GET_OID_QUIETLY in
get_oid_with_context_1().

The *_DIE flag was added in 33bd598c390 (sha1_name.c: teach lookup
context to get_sha1_with_context(), 2012-07-02), and then later
tweaked in 7243ffdd78d (get_sha1: avoid repeating ourselves via
ONLY_TO_DIE, 2016-09-26).

Everything in that commit makes sense, but only for callers that
expect to fail in an initial call to get_oid_with_context_1(), e.g. as
"git show 0017" does via handle_revision_arg(), and then would like to
call get_oid_with_context_1() again via this
maybe_die_on_misspelt_object_name() function.

In the subsequent commit we'll add a new caller that expects to call
this only once, but who would still like to have all the error
messaging that GET_OID_ONLY_TO_DIE gives it, in addition to any
regular errors.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 object-name.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/object-name.c b/object-name.c
index fdff4601b2c..d44a8f3a7ca 100644
--- a/object-name.c
+++ b/object-name.c
@@ -1795,9 +1795,6 @@ static enum get_oid_result get_oid_with_context_1(struct repository *repo,
 	const char *cp;
 	int only_to_die = flags & GET_OID_ONLY_TO_DIE;
 
-	if (only_to_die)
-		flags |= GET_OID_QUIETLY;
-
 	memset(oc, 0, sizeof(*oc));
 	oc->mode = S_IFINVALID;
 	strbuf_init(&oc->symlink_path, 0);
@@ -1932,7 +1929,7 @@ void maybe_die_on_misspelt_object_name(struct repository *r,
 {
 	struct object_context oc;
 	struct object_id oid;
-	get_oid_with_context_1(r, name, GET_OID_ONLY_TO_DIE,
+	get_oid_with_context_1(r, name, GET_OID_ONLY_TO_DIE | GET_OID_QUIETLY,
 			       prefix, &oid, &oc);
 }
 
-- 
2.34.1.926.g895e15e0c0c

