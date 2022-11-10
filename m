Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF0BDC433FE
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:37:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbiKJQhf (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:37:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231871AbiKJQhV (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:37:21 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5271840905
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:15 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k7so1816511pll.6
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:37:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qEhTixhlQz9ABrhB8csiGzQyXYqx/rm2yfkhpb3GgGY=;
        b=LLhSeRBzBM8iP2cK68cVQvRAh0yvbNUXNrU7TDOLVygEsLZjGKJR7iJJb9u41hAT6q
         D7PAZbtavfx7w14X0G+kRVk94e5OqNOPKlplpV6jTAF5C4o8tyANxoqToI7HcJvmg/UP
         hTuM4zyFKPLeK+/2NkMwm7cpsg4fpm5HPhdRKurqe7YnkmSTI1lNCCm4GdLAiBxJOl3r
         eoqEzRftxLLgGlmIeJZqFS9S9M8zS+RRaQ/DLOPjFHFUFz+aXFqkErthcOPW8+LLbKuU
         GTZaaNMYdPGZj19216xjqVqX1fci3OySvSBWD9p/NN1pIKQ6I8uFgeYly5dWH4/CMTnS
         eGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qEhTixhlQz9ABrhB8csiGzQyXYqx/rm2yfkhpb3GgGY=;
        b=IIPVcTqxjdHCESjU6AnzXKpgzhGOA/bmF946KLyhez8wcJzA7T7c6d1StdYkLrN9Ge
         qq10dKYORk+vcQfMI8tFs4uo0q0irhcff86OMv7Tiws7faoDik0nOXfqoFJ9YGP+Tgav
         KtXNH0u3AsVJBFV7N/x6eTYE9uRn7Bqy2XX8MdBaf1DTrkrCYr/j8AukIuGJ4vxhnN5L
         fyTLDohmu5/FYv2BsnEWwI0d57xpGGT66AK1syufFBRZifxx8Sy1WFC1P1vADBH+x2d4
         w3Go0qZm5wVlIl0vfIl3yQ1gORCARXYqttvg1j+mOlAu6kLA5If80aeJzylL6Wq9JjSt
         7E+A==
X-Gm-Message-State: ACrzQf3CKB+ZcZsjPng29so8mbMit9bBtZpARumkll7IDYYFH2Ao4OzA
        A8RcY9qkO/sy5VOOBcYHZVnVDNjCZW0=
X-Google-Smtp-Source: AMsMyM4n7YSJiIBZvCPm7t5djgFgEwq6hiWOesCh9Bp13u2xlnigx5+kh9V89Getc2vUQrodUqJl4Q==
X-Received: by 2002:a17:902:d508:b0:186:944a:2560 with SMTP id b8-20020a170902d50800b00186944a2560mr1524442plg.84.1668098234689;
        Thu, 10 Nov 2022 08:37:14 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id w7-20020a170902e88700b0016d9b101413sm11579258plg.200.2022.11.10.08.37.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:37:14 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v2 05/11] bisect-run: verify_good: account for non-negative exit status
Date:   Thu, 10 Nov 2022 23:36:40 +0700
Message-Id: <d6c57af9cc12eb64a71e2effcdb4585952ccb3aa.1668097966.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1668097962.git.congdanhqx@gmail.com>
References: <cover.1668097286.git.congdanhqx@gmail.com> <cover.1668097962.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Some system never reports negative exit code at all, they reports them
as bigger-than-128 instead.  We take extra care for those systems in the
later check for normal 'do_bisect_run' loop.

Let's check it here, too.

Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c    | 2 +-
 t/t6030-bisect-porcelain.sh | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index 180c2faa7f..e214190599 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1211,7 +1211,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 		if (is_first_run && (res == 126 || res == 127)) {
 			int rc = verify_good(terms, command.buf);
 			is_first_run = 0;
-			if (rc < 0) {
+			if (rc < 0 || 128 <= rc) {
 				error(_("unable to verify %s on good"
 					" revision"), command.buf);
 				res = BISECT_FAILED;
diff --git a/t/t6030-bisect-porcelain.sh b/t/t6030-bisect-porcelain.sh
index 34fd45a48e..03d99b22f1 100755
--- a/t/t6030-bisect-porcelain.sh
+++ b/t/t6030-bisect-porcelain.sh
@@ -347,7 +347,7 @@ test_expect_success 'git bisect run: negative exit code' "
 	test_cmp expect actual
 "
 
-test_expect_failure 'git bisect run: unable to verify on good' "
+test_expect_success 'git bisect run: unable to verify on good' "
 	write_script fail.sh <<-'EOF' &&
 	head=\$(git rev-parse --verify HEAD)
 	good=\$(git rev-parse --verify $HASH1)
-- 
2.38.1.157.gedabe22e0a

