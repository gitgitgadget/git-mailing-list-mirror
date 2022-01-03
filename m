Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98B30C433EF
	for <git@archiver.kernel.org>; Mon,  3 Jan 2022 15:20:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233889AbiACPU1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Jan 2022 10:20:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233877AbiACPU0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Jan 2022 10:20:26 -0500
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E565C061761
        for <git@vger.kernel.org>; Mon,  3 Jan 2022 07:20:26 -0800 (PST)
Received: by mail-wr1-x436.google.com with SMTP id s1so70529345wra.6
        for <git@vger.kernel.org>; Mon, 03 Jan 2022 07:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=49xW7CPFByB0bh8tMhtQZQb24p3bKSZ4ZfW/MD9vf1U=;
        b=IWI/lE6cd5Bg6FB095SGL0T6BOhmhr1iJ+kFpEES995sOIKViXSF6J3MCpi/lhUPA/
         Mm+vHgJdMmmXm5jIqEpB3WNJmMfG8fOPE6j0QOO73J6TyywqYrTF0Pen9XQxCgJKGuNC
         b2fiec0Cramgfng9YTnbXn9Wv4JR5XrUvY3q8lBN3rJZb7JoHJfsEir3zR3uFXWsDerC
         dDpwQgZegvA2szXpgOCU+XYVrc8lJ+0Gj32hQbsqBefx6h2mhSrbyxdRyg1uABZjfXCt
         piXUdpEeVQDQk75KT9915v3ClmOTAYCNiyMxRqUSPHeCjwcDw/LFFCAMDvFauMBJwUd3
         ERYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=49xW7CPFByB0bh8tMhtQZQb24p3bKSZ4ZfW/MD9vf1U=;
        b=YIEYPyKQCxOvTV+dtrFBLlziMBF6F/ucycanfqxLcHCyWG1OQhyeuSMYy5nmhSHi5o
         8CfeUr6FXa1NyE3kmq1zVkx086WAL3KQvcOqQ73I+OtA8TQkJzQQaj8TbRiuOQNQp8xT
         fvNLS2MfUH7Mc5ZrrALStG1gqLV/1J4V2jTmYtCMantuO2pjZhmxROVsvY0L4EtYB/Rg
         ZB79TokvU5rbzPJBdFsZ/52pGCa9Yhd1i7QtuREwLxRDxI9AwKo4O2kPdZXeUtiUFXAr
         v+fm7UsAxGT0LfwQ4nOkryuvqMRCpj9tCTObsJCYsS2x7cgG//4mH851hYuIvnoMOuWO
         WahQ==
X-Gm-Message-State: AOAM532aQnL8snoh7R/OC667aJJV2yiswn0q5WRiuWMTTDR+sHU4W8na
        TBu2Jrgn2Wp7p3xjvgiEyE77+kUgCwQ=
X-Google-Smtp-Source: ABdhPJwCnma8Ve3++f9UW04pbeqbk0SWOrePAT0tKhnicao1ByAzr33eXwRAfT/23E7NBeQA5oobeQ==
X-Received: by 2002:adf:f188:: with SMTP id h8mr38880639wro.663.1641223224853;
        Mon, 03 Jan 2022 07:20:24 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id h4sm35520035wrf.93.2022.01.03.07.20.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Jan 2022 07:20:24 -0800 (PST)
Message-Id: <bcd74559c2474451687c81e97834b13a859d2191.1641223223.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1175.v2.git.git.1641223223.gitgitgadget@gmail.com>
References: <pull.1175.git.git.1640932151.gitgitgadget@gmail.com>
        <pull.1175.v2.git.git.1641223223.gitgitgadget@gmail.com>
From:   "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 03 Jan 2022 15:20:21 +0000
Subject: [PATCH v2 1/2] parse-options.h: add parse_opt_expiry_date helper
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     =?UTF-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
        John Cai <johncai86@gmail.com>, John Cai <johncai86@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: John Cai <johncai86@gmail.com>

Extract the logic in parse_opt_expiry_date_cb into a helper
parse_opt_expiry_date. This is to prepare for the following commit where
we need to parse an expiry date that gets passed into a callback
function in opt->value as part of a struct.

The next commit will utilize this helper in a callback function that
aims to wrap the functionality in parse_opt_expiry_date_cb.

Signed-off-by: "John Cai" <johncai86@gmail.com>
---
 parse-options-cb.c | 7 ++++++-
 parse-options.h    | 1 +
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/parse-options-cb.c b/parse-options-cb.c
index 3c811e1e4a7..3edb88a54d8 100644
--- a/parse-options-cb.c
+++ b/parse-options-cb.c
@@ -34,10 +34,15 @@ int parse_opt_abbrev_cb(const struct option *opt, const char *arg, int unset)
 
 int parse_opt_expiry_date_cb(const struct option *opt, const char *arg,
 			     int unset)
+{
+	return parse_opt_expiry_date((timestamp_t *)opt->value, arg, unset);
+}
+
+int parse_opt_expiry_date(timestamp_t *t, const char *arg, int unset)
 {
 	if (unset)
 		arg = "never";
-	if (parse_expiry_date(arg, (timestamp_t *)opt->value))
+	if (parse_expiry_date(arg, t))
 		die(_("malformed expiration date '%s'"), arg);
 	return 0;
 }
diff --git a/parse-options.h b/parse-options.h
index 275fb440818..0a15bac8619 100644
--- a/parse-options.h
+++ b/parse-options.h
@@ -301,6 +301,7 @@ enum parse_opt_result parse_opt_unknown_cb(struct parse_opt_ctx_t *ctx,
 					   const char *, int);
 int parse_opt_passthru(const struct option *, const char *, int);
 int parse_opt_passthru_argv(const struct option *, const char *, int);
+int parse_opt_expiry_date(timestamp_t *, const char *, int);
 
 #define OPT__VERBOSE(var, h)  OPT_COUNTUP('v', "verbose", (var), (h))
 #define OPT__QUIET(var, h)    OPT_COUNTUP('q', "quiet",   (var), (h))
-- 
gitgitgadget

