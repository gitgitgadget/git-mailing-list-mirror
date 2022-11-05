Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3855FC4332F
	for <git@archiver.kernel.org>; Sat,  5 Nov 2022 17:08:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230001AbiKERIG (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 5 Nov 2022 13:08:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbiKERIC (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 5 Nov 2022 13:08:02 -0400
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD09AE021
        for <git@vger.kernel.org>; Sat,  5 Nov 2022 10:08:01 -0700 (PDT)
Received: by mail-pg1-x534.google.com with SMTP id q71so6916418pgq.8
        for <git@vger.kernel.org>; Sat, 05 Nov 2022 10:08:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6w0mg27Ooq5/PSp06862M4FdMMwJ5+ojk2gqcT6CxaM=;
        b=WsqhkzPbmFQDXF51t5/TpkdAVJj7NU/cGjaiNFLyCbgpJskQaXfgOCijAhpm+YlQB6
         66Bhf9KzlD+Ikq6crDfDwKL+BZ/JiFhgHmplUp8e3RZPPApB8UcKhytfWf4w+T5hBDH0
         qdojeajw7iwbkgbfxGS4O9WbR7gj6+z20lMsmagQ76SLX8kVVw3llE84FvnXfk0lCOYt
         3zVBqAWXc5B6+toNaJ2zMDJZBlrg5G3MPb+6Ke8Rdqowd0cHPTHKWZOl3JhCb76I20VY
         i4zR6nUWZMkCNFY7Arq91UdUdedb4dUKLnCLi8Rpf8d+bHDqfkF0ykPQ3sqVXDUiRmM4
         AUDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6w0mg27Ooq5/PSp06862M4FdMMwJ5+ojk2gqcT6CxaM=;
        b=CMjUl3e1+YqMc6QCl8aIp2d2UV6eX8AD0OA9ZzpqH9hXyImIEeKDPCBczXpH/oI3Cf
         fUpf5VipWXsOA1BAHXyKhwmCeZ/iysi3Jt3jfkXlsgoYRNkYm1EWKs0eXmXO/4sscdLK
         Nwjlz/HIRCy+9xp86pAk2qwDVbukiDmncteT4NiyAkMyAPoxAb8CxBzC+DYGsvTqcROO
         2kolRfsurJyTo7nak6SNUXvwC46OuHqOSiYA8pQ8wjDLRLcKMhXusMxyf02whEBoJI0Y
         fHXDRavT/jCiFiElf557t+enBZo3Uyd0ReMZM84Xa4e5y8135EFi7L6xL7o0RvHwcsNf
         4FEQ==
X-Gm-Message-State: ACrzQf2V8vPTpbnuVHzlLnCcZS87L0ykwJ0i0JatSOdypUASxiDqSsoi
        D8LorA9YplgvG09H97LVU8UbFNJ40PA=
X-Google-Smtp-Source: AMsMyM4Y0t5X9lOBtgBInlr7ruhhZuzHHUxyJGxuZavwUM0x7z2l11O5JHQt/3tSAlj9DMiAoRMkNA==
X-Received: by 2002:a05:6a00:846:b0:56e:42f7:dec with SMTP id q6-20020a056a00084600b0056e42f70decmr15083916pfk.65.1667668081051;
        Sat, 05 Nov 2022 10:08:01 -0700 (PDT)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id c16-20020a056a00009000b0056299fd2ba2sm1513192pfj.162.2022.11.05.10.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Nov 2022 10:08:00 -0700 (PDT)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Taylor Blau <me@ttaylorr.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
Subject: [PATCH 02/13] bisect: refactor bisect_run() to match CodingGuidelines
Date:   Sun,  6 Nov 2022 00:07:33 +0700
Message-Id: <dc6ed4c4537a73910043aad70e1b62eb050a770c.1667667460.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667667460.git.congdanhqx@gmail.com>
References: <cover.1667667058.git.congdanhqx@gmail.com> <cover.1667667460.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Ævar Arnfjörð Bjarmason <avarab@gmail.com>

We didn't add "{}" to all "if/else" branches, and one "error" was
mis-indented. Let's fix that first, which makes subsequent commits
smaller. In the case of the "if" we can simply early return instead.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
Signed-off-by: Đoàn Trần Công Danh <congdanhqx@gmail.com>
---
 builtin/bisect--helper.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/builtin/bisect--helper.c b/builtin/bisect--helper.c
index d4d813ebfc..ee1197c8b2 100644
--- a/builtin/bisect--helper.c
+++ b/builtin/bisect--helper.c
@@ -1191,13 +1191,12 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 	if (bisect_next_check(terms, NULL))
 		return BISECT_FAILED;
 
-	if (argc)
-		sq_quote_argv(&command, argv);
-	else {
+	if (!argc) {
 		error(_("bisect run failed: no command provided."));
 		return BISECT_FAILED;
 	}
 
+	sq_quote_argv(&command, argv);
 	while (1) {
 		res = do_bisect_run(command.buf);
 
@@ -1268,7 +1267,7 @@ static int bisect_run(struct bisect_terms *terms, const char **argv, int argc)
 			res = BISECT_OK;
 		} else if (res) {
 			error(_("bisect run failed: 'git bisect--helper --bisect-state"
-			" %s' exited with error code %d"), new_state, res);
+				" %s' exited with error code %d"), new_state, res);
 		} else {
 			continue;
 		}
-- 
2.38.1.157.gedabe22e0a

