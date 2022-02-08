Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76CEC433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 08:40:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350668AbiBHIkV (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 03:40:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350480AbiBHIkM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 03:40:12 -0500
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF397C03FECA
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 00:40:04 -0800 (PST)
Received: by mail-pf1-x44a.google.com with SMTP id d5-20020a623605000000b004e01ccd08abso735088pfa.10
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 00:40:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=d5OdSxOJpSIJ8Imz8Plwa6pJa7oLeJV7xRwU926Etao=;
        b=JzCr4ouGq2rmGB3cJ8DTjSEBlfkxOHmgbZ/kLv5OU5d0aeZAfZ7FVYqWtEuPdIOO1W
         UIgyAHpYJcRZGiP9PkdwkJXFAo8/ewZYMa7cKwFbRriF/ITswswFp+g0SibfjKM6MvB6
         LMRFaxSrG/S+5BGDTGdqxXW0gXl96oT6SaqjSXKa4adEPdLJ4esf9IW0AiwZhloefovD
         wlFB0yQCb23GpAypih7PRtpi2GWZFO76SPzw3buwGkYdTBI2TATIw9bPv8X8eIuLirz4
         5XcnZn4jGCdG3nFvCVdF6Hprz5VHPhSsFan5DLgRWd5MkPcmyvVeHs0Jd7Jd2yUnO4R3
         ID+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=d5OdSxOJpSIJ8Imz8Plwa6pJa7oLeJV7xRwU926Etao=;
        b=1uKbI3/BmKe/lJ3sZN5Rq4gKWZ86XP+7wkDz4d1dQ9PVAqM/uhVNEFKxDmmuhoN+SO
         OF0wnq83SqU3UuYrWAwskkB5VWW9ygTx5wRsUwNTLh3Y5iWVKjdu7B/wJk1hqpCj6Fz7
         mtcMa3JJVYHkkzVs7EsiwBndkT7cAPdP7xX9796cj+D4zMduMq+qEqAR4/GyRidzgpBQ
         5NN60hiEwUZGwdP5mMcQfgDCiIJwtBuyF++oA9DyOZcy4i2+nydRq2/Jt13fZ1apWGOU
         6Y1Yy+I/YlQDo3+wo3U875MfEGJxFt2PE8HCM7AI/tb4cSWhN9jf0OSKK91ydxdO3/du
         L8Gg==
X-Gm-Message-State: AOAM532+ZY8n64sBntDwBEXdIFyu4d2DAlYCHo61Pu+A08mGwmjmLV6k
        uCKOcE8kCxKF8a48rRp0Ws2UNYKYsN6D6SqxD4tNAyKF4PKtg6iOhP8O3lA92oaXu0I/75Ad7nY
        hIzB4UDrZ/Ki4oj8eBcCWAqneHXeGCa2c8J1Txs/aSrutV8zFNYvhPsDNXNOotrU=
X-Google-Smtp-Source: ABdhPJzSpfvrXHj+tmEqGfJxrEzbQkwek8Xb/HkJu4UQP2MltN12VgGzpWuaeC8mbln98puMYbhl3yqSiXymRA==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:4717:: with SMTP id
 u23mr2729402pga.74.1644309604179; Tue, 08 Feb 2022 00:40:04 -0800 (PST)
Date:   Tue,  8 Feb 2022 16:39:39 +0800
In-Reply-To: <20220208083952.35036-1-chooglen@google.com>
Message-Id: <20220208083952.35036-4-chooglen@google.com>
Mime-Version: 1.0
References: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com> <20220208083952.35036-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 03/16] submodule--helper: allow setting superprefix for init_submodule()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Jonathan Nieder <jrn@google.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
        pc44800@gmail.com, Shourya Shukla <periperidip@gmail.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>
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
index 5efceb9d46..09cda67c1e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -606,18 +606,22 @@ static int module_foreach(int argc, const char **argv=
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
@@ -691,7 +695,7 @@ static void init_submodule(const char *path, const char=
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

