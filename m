Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B726C433F5
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 11:04:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3BE0561056
	for <git@archiver.kernel.org>; Tue,  9 Nov 2021 11:04:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241641AbhKILHh (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 9 Nov 2021 06:07:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236771AbhKILHf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 9 Nov 2021 06:07:35 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00532C061766
        for <git@vger.kernel.org>; Tue,  9 Nov 2021 03:04:49 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id i5so32317667wrb.2
        for <git@vger.kernel.org>; Tue, 09 Nov 2021 03:04:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=hknDpvs1k3QFye5nmo2jrrwD1+nhbeqI5U64YlEdrQE=;
        b=GkkSdI7qKFDaa2Gn7GWYMbo+ZJUlCKIGskxftWXAqTWZelhirSGusH4vQJKC5wh0fA
         dx85ox84POwLnNcr0I/a/67OpKTCNycu0Pqbbbwl6QusZnmbgQlHlDr4o2kSeIfIQ+6T
         xEaWcVDHuNSGFAjLDPMF4tyMD8uDI9NEB/wZh+7B3QpUFxX7PRcwduVlyUYQaG+FQYHL
         T2571B/y1NFmNFXPp0cyHA4timYkvVDZZvIUKIRybHZAZT+El1ZAdyUTDNvypNWS3dHD
         facMMGYZ1iT5mkDQsiRFidm8QFNDwKmgh8Pmi1/4j8YEoGvlA3k1muI6CF2i6NLiHHBL
         rmKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=hknDpvs1k3QFye5nmo2jrrwD1+nhbeqI5U64YlEdrQE=;
        b=YosHbam+FqpXEFxKuXFUMMlkoZy1Fe58MufweVdMxkgxPAkfeY0zsnxJzFoIafZZE0
         dVMkMbGNcd3Kig1UCsAOR1oWsLnEusBiK55LlJnKgZAhtwarEIiZkotCtxFldn19MomY
         tvZuBH/4ipU/t0ryWWsKFqPkWel94micMUsiojUUJtTscecm+SyBdJ0F5I6N3/VFDm9a
         yxRI79+bzinM7EfslJ3uye4FMmVztdewjoFyFWma9YwP3XosuIogpdhs4VCSoQf9JMMn
         qAApXA8TgZe3kW2DCAAn6wHFnWPMAq+4OSAmcULyyulOPdTaCJ3V2tkuLb6xP1edDJ+i
         mJYA==
X-Gm-Message-State: AOAM530PfkYEa3c3Us0HKD7UMr1AOKSj1JshgpcNFYmjMXetutxfka6L
        6nWKwPXJb/Bp9vVtvHIZ7mq6lmCInH2u5g==
X-Google-Smtp-Source: ABdhPJwN+8ypV5xFylBOr0HvIXIs2uLUnPQ5UCkx4VhX967zmtwSeP63yGhUwqrb3PMoerCM2x6ImQ==
X-Received: by 2002:a5d:6ac7:: with SMTP id u7mr7991767wrw.57.1636455888350;
        Tue, 09 Nov 2021 03:04:48 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id o12sm2480755wmq.12.2021.11.09.03.04.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Nov 2021 03:04:47 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder.dev@gmail.com>,
        Thomas Rast <tr@thomasrast.ch>,
        =?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH 1/2] parse-options.[ch]: revert use of "enum" for parse_options()
Date:   Tue,  9 Nov 2021 12:04:43 +0100
Message-Id: <patch-1.2-057a9f81b47-20211109T110113Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.0.rc1.741.gab7bfd97031
In-Reply-To: <cover-0.2-00000000000-20211109T110113Z-avarab@gmail.com>
References: <211106.86lf21ezqx.gmgdl@evledraar.gmail.com> <cover-0.2-00000000000-20211109T110113Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Revert the parse_options() prototype change in my recent
352e761388b (parse-options.[ch]: consistently use "enum
parse_opt_result", 2021-10-08) was incorrect. The parse_options()
function returns the number of argc elements that haven't been
processed, not "enum parse_opt_result".

Reported-by: SZEDER Gábor <szeder.dev@gmail.com>
Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 parse-options.c | 10 +++++-----
 parse-options.h |  9 ++++-----
 2 files changed, 9 insertions(+), 10 deletions(-)

diff --git a/parse-options.c b/parse-options.c
index 9a0484c8831..fc5b43ff0b2 100644
--- a/parse-options.c
+++ b/parse-options.c
@@ -860,11 +860,11 @@ int parse_options_end(struct parse_opt_ctx_t *ctx)
 	return ctx->cpidx + ctx->argc;
 }
 
-enum parse_opt_result parse_options(int argc, const char **argv,
-				    const char *prefix,
-				    const struct option *options,
-				    const char * const usagestr[],
-				    enum parse_opt_flags flags)
+int parse_options(int argc, const char **argv,
+		  const char *prefix,
+		  const struct option *options,
+		  const char * const usagestr[],
+		  enum parse_opt_flags flags)
 {
 	struct parse_opt_ctx_t ctx;
 	struct option *real_options;
diff --git a/parse-options.h b/parse-options.h
index bdea052c399..275fb440818 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -213,11 +213,10 @@ struct option {
  * untouched and parse_options() returns the number of options
  * processed.
  */
-enum parse_opt_result parse_options(int argc, const char **argv,
-				    const char *prefix,
-				    const struct option *options,
-				    const char * const usagestr[],
-				    enum parse_opt_flags flags);
+int parse_options(int argc, const char **argv, const char *prefix,
+		  const struct option *options,
+		  const char * const usagestr[],
+		  enum parse_opt_flags flags);
 
 NORETURN void usage_with_options(const char * const *usagestr,
 				 const struct option *options);
-- 
2.34.0.rc1.741.gab7bfd97031

