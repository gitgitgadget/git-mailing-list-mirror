Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4B9FC433FE
	for <git@archiver.kernel.org>; Sat,  2 Apr 2022 16:12:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244986AbiDBQNw (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 2 Apr 2022 12:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357801AbiDBQMx (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 2 Apr 2022 12:12:53 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D743C62115
        for <git@vger.kernel.org>; Sat,  2 Apr 2022 09:11:00 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id 123-20020a1c1981000000b0038b3616a71aso3106886wmz.4
        for <git@vger.kernel.org>; Sat, 02 Apr 2022 09:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:in-reply-to:references:from:date:subject:mime-version
         :content-transfer-encoding:fcc:to:cc;
        bh=oPGaaJhxrabAKvb/cOHoN2g3vo5BKYuWyxUt8mGzUow=;
        b=PYB07+kZJDDCwbDomPJnc6839gY32DyyUjrGnatNUgQ+Ei4Cm0mtxHCBQF4sKo+WzT
         52G/szyZnbYW/D1b5qn5FHCpPtXNCRu4dnOnOzgjf1dELmeZ96UDRaU4AwQaon5lZ3Ce
         hfgvXpju3lsxlxrLE+DCWxXEDA0HfbXzZBAWVg/BdykhBwIAvds/c4s/PB44e9ZEcmdl
         vVhdp1ykpbTJlKITuJD9eg1FXnM9ZRbSzS+gFClLrqXrflXg7+2hweeMSciCpKFRW25O
         fhSYFjFrfQZsOaAvLJVOtP/fOkjrdT2ZEm+7ajhYoYd1BA24RsECpjukWNMU+HiZ9vOv
         NXGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:mime-version:content-transfer-encoding:fcc:to:cc;
        bh=oPGaaJhxrabAKvb/cOHoN2g3vo5BKYuWyxUt8mGzUow=;
        b=A3mxhpfx1Zo1R0iyfKTxZzyBb9Zldxxh/J7TSe7J5+hUnU7E4KaEr8eXlJ084LedYa
         1kPhx3Zm5gza1/Q2b7BcSu3nWS2LjZDyLc8/pKbXM7uuhnMksbhEXfRJfXRmezkxxYsD
         yvw3yLobNPYkENoRdBfDy2wbzi+j8D+dbH2ZNx9T5sHhRhH8M0t9TEvS73omysXInC63
         afEOyCNfw8UPIReHoUsUdNEjtNAAjCw+u0Y8nFA/nkBqY5YeVia+1hd+UD4ke6MwejiA
         tp91nE6bkyf9bSQIRCuWuKp1ErNuwgofO8gEtDi3hrl6SDs2npf2Vy9s28RZ2z5XXH+W
         O/dw==
X-Gm-Message-State: AOAM532b2I8I2/4AjKnywVj3/4s8idUEi1qgZsIpEISFVhVgooAD8cII
        NkPmpGUriCck6jR7ds6Rm0s33M9zCX4=
X-Google-Smtp-Source: ABdhPJyAS5ZjNPm4TV7/8wI13OEWuWoXsn7AwCSJRXLWMpdyvSD8DyZw1gd+bXspxup8OX6ShZ6ndA==
X-Received: by 2002:a05:600c:3c8c:b0:38e:4c59:6852 with SMTP id bg12-20020a05600c3c8c00b0038e4c596852mr9393881wmb.194.1648915859194;
        Sat, 02 Apr 2022 09:10:59 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id i206-20020a1c3bd7000000b0038bfc3ab76csm4749482wma.48.2022.04.02.09.10.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 02 Apr 2022 09:10:58 -0700 (PDT)
Message-Id: <6221c37145c22a79bc1598be1e82be50d61636cc.1648915853.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1181.v2.git.1648915853.gitgitgadget@gmail.com>
References: <pull.1181.git.1647813291.gitgitgadget@gmail.com>
        <pull.1181.v2.git.1648915853.gitgitgadget@gmail.com>
From:   "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" 
        <gitgitgadget@gmail.com>
Date:   Sat, 02 Apr 2022 16:10:51 +0000
Subject: [PATCH v2 4/6] i18n: factorize "foo does not take arguments" messages
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc:    Sent
To:     git@vger.kernel.org
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>, Johannes Sixt <j6t@kdbg.org>,
        =?UTF-8?Q?=C3=86var_Arnfj=C3=B6r=C3=B0?= Bjarmason 
        <avarab@gmail.com>,
        =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
        =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

The messages are split into the ones for ref-filter which deal with
atoms and scalar which has an option.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 contrib/scalar/scalar.c | 2 +-
 ref-filter.c            | 8 ++++----
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/contrib/scalar/scalar.c b/contrib/scalar/scalar.c
index 7db2a97416e..7ef1f141366 100644
--- a/contrib/scalar/scalar.c
+++ b/contrib/scalar/scalar.c
@@ -502,7 +502,7 @@ cleanup:
 static int cmd_list(int argc, const char **argv)
 {
 	if (argc != 1)
-		die(_("`scalar list` does not take arguments"));
+		die(_("the '%s' command does not take arguments"), "scalar list");
 
 	if (run_git("config", "--global", "--get-all", "scalar.repo", NULL) < 0)
 		return -1;
diff --git a/ref-filter.c b/ref-filter.c
index 7838bd22b8d..8497f9e25d8 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -317,7 +317,7 @@ static int objecttype_atom_parser(struct ref_format *format, struct used_atom *a
 				  const char *arg, struct strbuf *err)
 {
 	if (arg)
-		return strbuf_addf_ret(err, -1, _("%%(objecttype) does not take arguments"));
+		return strbuf_addf_ret(err, -1, _("the atom '%s' does not take arguments"), "%(objecttype)");
 	if (*atom->name == '*')
 		oi_deref.info.typep = &oi_deref.type;
 	else
@@ -349,7 +349,7 @@ static int deltabase_atom_parser(struct ref_format *format, struct used_atom *at
 				 const char *arg, struct strbuf *err)
 {
 	if (arg)
-		return strbuf_addf_ret(err, -1, _("%%(deltabase) does not take arguments"));
+		return strbuf_addf_ret(err, -1, _("the atom '%s' does not take arguments"), "%(deltabase)");
 	if (*atom->name == '*')
 		oi_deref.info.delta_base_oid = &oi_deref.delta_base_oid;
 	else
@@ -361,7 +361,7 @@ static int body_atom_parser(struct ref_format *format, struct used_atom *atom,
 			    const char *arg, struct strbuf *err)
 {
 	if (arg)
-		return strbuf_addf_ret(err, -1, _("%%(body) does not take arguments"));
+		return strbuf_addf_ret(err, -1, _("the atom '%s' does not take arguments"), "%(body)");
 	atom->u.contents.option = C_BODY_DEP;
 	return 0;
 }
@@ -565,7 +565,7 @@ static int rest_atom_parser(struct ref_format *format, struct used_atom *atom,
 			    const char *arg, struct strbuf *err)
 {
 	if (arg)
-		return strbuf_addf_ret(err, -1, _("%%(rest) does not take arguments"));
+		return strbuf_addf_ret(err, -1, _("the atom '%s' does not take arguments"), "%(rest)");
 	format->use_rest = 1;
 	return 0;
 }
-- 
gitgitgadget

