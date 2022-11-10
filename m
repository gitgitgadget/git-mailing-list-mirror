Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1812C4332F
	for <git@archiver.kernel.org>; Thu, 10 Nov 2022 16:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231809AbiKJQgd (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Nov 2022 11:36:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231336AbiKJQgc (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Nov 2022 11:36:32 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 107AF1AF11
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:36:31 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z26so2699902pff.1
        for <git@vger.kernel.org>; Thu, 10 Nov 2022 08:36:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Yv1calcASwxGHffXf0/vh9YJFWt41fBlF2GOsUAqmTQ=;
        b=N7lmEzkh0H6USWUQ4raA7cuGcuP4qGdKtK0TBs4/5gmldGAwCYZF9qGPyH6qDcu8TU
         a5oR40xGTIwRT4GeGf/7C0OR6/ZHA28TESXHnaLozjJERG9gipHV75GpxUJbqmmxLgQe
         P+d7tmgBwEG0+jEbXQQh9GgWWXrcLKvfZG+2NrotRCI9f4zzHuqzr3oSAYq9RVsoBnrF
         iaLz762wU0llwhBiKZExcbJO5z/jhWVSprO6g9MzECvHEOYKm6QOfCnNKdEQmdEud+6v
         VnurjxUKGBPS76h756OVNVBrCBXJ2FoT89fRmyMmq1+3pCd8k2omWTptReYReJni5kvo
         4XKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Yv1calcASwxGHffXf0/vh9YJFWt41fBlF2GOsUAqmTQ=;
        b=ezi7+t1TQ4DXtJUW6Jrt5VUXVWivEPa4K7vX6+ojo02YDDoehlh1nBSSYHI2zdk5U3
         ClbD4nInG8KmCK8jPlLxhJfB84Bv7ab5Nfz0J5lMoQVzdGu3ZuPAvc3GVIHq6ENaV1rH
         C2E8yqXbExYrKvOOnSI9jsepjNlA6p1QMZBG8xVd0fWI+sVwCtrvWBd8r/s1ZEftzdDD
         8YbezKc4JqhKwUfn1jwTqHpS2RBJtpmTDQNNwBZa1kpLtGl4S1JM3/wyGhCxWSOl+hI0
         D0f1uqwpMcEcscg9Yj7rvec4qcNvwatjiiKNYxax8AD3VyH3LQbhkcK3RU32hBPtuGnW
         2h8w==
X-Gm-Message-State: ACrzQf3vVZJsbDAzZOANcovVZUcopyLbtBFH1WvHIqBNSeN9kXrCoe6y
        t8cMzyUp9lQQFlylBN9sJk3xJuj42fM=
X-Google-Smtp-Source: AMsMyM6dvqiaQnru1u2CdM304EAFzavuGB4E5jDtHBj8apcrUybdSdugMiIDCFJ9UR8GDWI+aneWVw==
X-Received: by 2002:a05:6a00:2409:b0:54e:a3ad:d32d with SMTP id z9-20020a056a00240900b0054ea3add32dmr64850865pfh.70.1668098190151;
        Thu, 10 Nov 2022 08:36:30 -0800 (PST)
Received: from localhost.localdomain ([2001:ee0:500b:6370:da47:cda5:dbd5:6e77])
        by smtp.gmail.com with ESMTPSA id b29-20020a631b5d000000b0047022e07035sm9371372pgm.47.2022.11.10.08.36.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 08:36:29 -0800 (PST)
From:   =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>
To:     git@vger.kernel.org
Cc:     =?UTF-8?q?=C4=90o=C3=A0n=20Tr=E1=BA=A7n=20C=C3=B4ng=20Danh?= 
        <congdanhqx@gmail.com>,
        =?UTF-8?q?Luk=C3=A1=C5=A1=20Doktor?= <ldoktor@redhat.com>,
        Jeff King <peff@peff.net>,
        Christian Couder <chriscool@tuxfamily.org>,
        Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v3 0/3] Convert git-bisect--helper to OPT_SUBCOMMAND
Date:   Thu, 10 Nov 2022 23:36:19 +0700
Message-Id: <cover.1668097286.git.congdanhqx@gmail.com>
X-Mailer: git-send-email 2.38.1.157.gedabe22e0a
In-Reply-To: <cover.1667561761.git.congdanhqx@gmail.com>
References: <cover.1667561761.git.congdanhqx@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Despite this series has been merged into next.
I'm sending this because Taylor said he wanted a (combined) reroll?
<Y2riRSL+NprJt278@nand.local>

Change from v2 is only about cosmetic things, (structure zero-initialization)

This series aims to fix the problem that bisect--helper incorrectly consumes
"--log" when running:

	git bisect run cmd --log

This also clears a way for turning git-bisect into a built-in in a later day.

The series that convert git-bisect to builtin will be posted later as a reply
to this series

Đoàn Trần Công Danh (3):
  bisect--helper: remove unused options
  bisect--helper: move all subcommands into their own functions
  bisect--helper: parse subcommand with OPT_SUBCOMMAND

 builtin/bisect--helper.c    | 229 ++++++++++++++++++++----------------
 git-bisect.sh               |  23 +---
 t/t6030-bisect-porcelain.sh |  10 ++
 3 files changed, 142 insertions(+), 120 deletions(-)

Range-diff against v2:
-:  ---------- > 1:  6b80fd9398 bisect--helper: remove unused options
1:  9d8a3cdd7a ! 2:  248ed392ea bisect--helper: move all subcommands into their own functions
    @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, cons
     +static int cmd_bisect__terms(int argc, const char **argv, const char *prefix UNUSED)
     +{
     +	int res;
    -+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
    ++	struct bisect_terms terms = { 0 };
     +
     +	if (argc > 1)
     +		return error(_("--bisect-terms requires 0 or 1 argument"));
    @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, cons
     +static int cmd_bisect__start(int argc, const char **argv, const char *prefix UNUSED)
     +{
     +	int res;
    -+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
    ++	struct bisect_terms terms = { 0 };
     +
     +	set_terms(&terms, "bad", "good");
     +	res = bisect_start(&terms, argv, argc);
    @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, cons
     +static int cmd_bisect__next(int argc, const char **argv UNUSED, const char *prefix)
     +{
     +	int res;
    -+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
    ++	struct bisect_terms terms = { 0 };
     +
     +	if (argc)
     +		return error(_("--bisect-next requires 0 arguments"));
    @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, cons
     +static int cmd_bisect__state(int argc, const char **argv, const char *prefix UNUSED)
     +{
     +	int res;
    -+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
    ++	struct bisect_terms terms = { 0 };
     +
     +	set_terms(&terms, "bad", "good");
     +	get_terms(&terms);
    @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, cons
     +static int cmd_bisect__replay(int argc, const char **argv, const char *prefix UNUSED)
     +{
     +	int res;
    -+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
    ++	struct bisect_terms terms = { 0 };
     +
     +	if (argc != 1)
     +		return error(_("no logfile given"));
    @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, cons
     +static int cmd_bisect__skip(int argc, const char **argv, const char *prefix UNUSED)
     +{
     +	int res;
    -+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
    ++	struct bisect_terms terms = { 0 };
     +
     +	set_terms(&terms, "bad", "good");
     +	get_terms(&terms);
    @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, cons
     +static int cmd_bisect__visualize(int argc, const char **argv, const char *prefix UNUSED)
     +{
     +	int res;
    -+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
    ++	struct bisect_terms terms = { 0 };
     +
     +	get_terms(&terms);
     +	res = bisect_visualize(&terms, argv, argc);
    @@ builtin/bisect--helper.c: static int bisect_run(struct bisect_terms *terms, cons
     +static int cmd_bisect__run(int argc, const char **argv, const char *prefix UNUSED)
     +{
     +	int res;
    -+	struct bisect_terms terms = { .term_good = NULL, .term_bad = NULL };
    ++	struct bisect_terms terms = { 0 };
     +
     +	if (!argc)
     +		return error(_("bisect run failed: no command provided."));
2:  a62ac72e24 = 3:  b67691f600 bisect--helper: parse subcommand with OPT_SUBCOMMAND
-- 
2.38.1.157.gedabe22e0a

