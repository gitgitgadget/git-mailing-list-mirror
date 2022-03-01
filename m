Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C263CC433FE
	for <git@archiver.kernel.org>; Tue,  1 Mar 2022 04:42:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232412AbiCAEmz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 28 Feb 2022 23:42:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232383AbiCAEmj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 28 Feb 2022 23:42:39 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BFFD7085B
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:56 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id m3-20020a17090a3f8300b001bd33af55f2so837191pjc.1
        for <git@vger.kernel.org>; Mon, 28 Feb 2022 20:41:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=GyEA+1lz1JcECQYAa9X3hotxFkOrXrOERDK70avC8tM=;
        b=fCB9AczGoOi6LsWsdDiHOab+cygQA/ZV64WK7xtCqUrAp+ROyXmQEFWqZL3Plw6tcK
         5UmjWtsuWQQ3JLx4PhFX4PHx1j+mbJsCA/n782PzVrxkQ3IyxyVXZ4Pze3ikw89o7OK/
         pX60kfxC8MwurlWh5Ljrkfts6lfCsCOHSVysNOSkSSQ4QrMmBFTbeID5H7tJaAF/ZbSP
         mN9Djly3bSLqfqC83jF8BvFDQQ+MWiWmekNOyxaoyzlXS0XpYimeFnQ92HSgQSl3VbQ2
         eab7nvEmFLIXuXcfgvY8pnk4ucTcDhFUH/GubxpoOTJoAwZWuZywV2+0RHXhj15WY4Xr
         pSUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=GyEA+1lz1JcECQYAa9X3hotxFkOrXrOERDK70avC8tM=;
        b=znWyHDHVyDdrZZnzaq1c971HjVVASd4oUXBE37GYaf/uMZvLn1XrYh/DWER340li1g
         86ltTra1j/yClMLylXVXPrZIod/X4fdTm+c62OgOASa/Iue7dpQDX70GmkaRI1Yd+Tjf
         j4nWHXV12lT4Bwt4OZKlpAeEFDnwVqoWUOAYeifjeZKUcYEXzg/QNQUJN7EULluiY+Mm
         1tQ1fBhBLal7CHDjLkxdsCZCXC6A1TaaQYvnGfyP+6F5n861hZQOaH2cm1aQE5F9bVDc
         PFGIJMvD6EfaDzkT2Bxm2qjJ3oS0ULyZH/6FhlV5LE5kqjEGnYTZEmcHXrE6bfF6ls+l
         E5Rw==
X-Gm-Message-State: AOAM532RoknVieHNAgLNR+uhpvoOe/j2SD3OicXtXYD2cDQxwAbvgUr8
        SzYyqabw04aIzDk9s3siF44GEwPiqAS+55BId4dj7T2AUaKco+l/IzOJm72jt2nr0ve5DRpPeVP
        tqCdF9qMGmzn+zF67YPAkQqeg+1Yy01oguRKT4W6uFukk37JqNqC5gA5bIz7Xq3g=
X-Google-Smtp-Source: ABdhPJxiTvJbi4oqFwnMqmgbB1eER1bs9pCwS0eHER6eG3u2RJ86WDT+ZD3ld+SH/UA9r0HMv9A+BgR5NJeQtw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:f242:b0:14f:e2d3:e251 with SMTP
 id j2-20020a170902f24200b0014fe2d3e251mr23498630plc.19.1646109716059; Mon, 28
 Feb 2022 20:41:56 -0800 (PST)
Date:   Mon, 28 Feb 2022 20:41:29 -0800
In-Reply-To: <20220301044132.39474-1-chooglen@google.com>
Message-Id: <20220301044132.39474-11-chooglen@google.com>
Mime-Version: 1.0
References: <20220301000816.56177-1-chooglen@google.com> <20220301044132.39474-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v2 10/13] submodule--helper: allow setting superprefix for init_submodule()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

We allow callers of the `init_submodule()` function to optionally
override the superprefix from the environment.

We need to enable this option because in our conversion of the update
command that will follow, the '--init' option will be handled through
this API. We will need to change the superprefix at that time to ensure
the display paths show correctly in the output messages.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 11afdeea8a..052b247726 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -592,18 +592,22 @@ static int module_foreach(int argc, const char **argv=
, const char *prefix)
=20
 struct init_cb {
 	const char *prefix;
+	const char *superprefix;
 	unsigned int flags;
 };
 #define INIT_CB_INIT { 0 }
=20
 static void init_submodule(const char *path, const char *prefix,
-			   unsigned int flags)
+			   const char *superprefix, unsigned int flags)
 {
 	const struct submodule *sub;
 	struct strbuf sb =3D STRBUF_INIT;
 	char *upd =3D NULL, *url =3D NULL, *displaypath;
=20
-	displaypath =3D get_submodule_displaypath(path, prefix);
+	/* try superprefix from the environment, if it is not passed explicitly *=
/
+	if (!superprefix)
+		superprefix =3D get_super_prefix();
+	displaypath =3D do_get_submodule_displaypath(path, prefix, superprefix);
=20
 	sub =3D submodule_from_path(the_repository, null_oid(), path);
=20
@@ -677,7 +681,7 @@ static void init_submodule(const char *path, const char=
 *prefix,
 static void init_submodule_cb(const struct cache_entry *list_item, void *c=
b_data)
 {
 	struct init_cb *info =3D cb_data;
-	init_submodule(list_item->name, info->prefix, info->flags);
+	init_submodule(list_item->name, info->prefix, info->superprefix, info->fl=
ags);
 }
=20
 static int module_init(int argc, const char **argv, const char *prefix)
--=20
2.33.GIT

