Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27C30C433F5
	for <git@archiver.kernel.org>; Sat,  5 Mar 2022 00:15:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230174AbiCEAP7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Mar 2022 19:15:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbiCEAPx (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Mar 2022 19:15:53 -0500
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 174B0244A01
        for <git@vger.kernel.org>; Fri,  4 Mar 2022 16:15:04 -0800 (PST)
Received: by mail-pl1-x64a.google.com with SMTP id j9-20020a170903024900b0015195e68490so5383714plh.19
        for <git@vger.kernel.org>; Fri, 04 Mar 2022 16:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=AuVbI191/O5fPuaIwnxwbQn3XJU3aiYUEwW2YMjR/sg=;
        b=pbHmkdVpgAyJDswo6R/xBOMJgnZXHrd1U+KFByqM6l6Qk6ceoCyfZw7wPOhlJ1g+1a
         rALtA6RewmfGvUsdI/vgdphimRU2wQDZfQz7q8KnlGM7X31yQvSCjFfdy0cJg1qoPOSd
         NA/ZhQisfj37K/C0qKDsZN09Z3koI8NRIRtnABW0M1u1OtlymAW5QTUCb3GybU80K4mp
         /y/WupNrT6PreBAEW0XRtXdATjqDwxwqoppkKn3Vv3OvYzXaJU59jpFhbqdF2q/X7e3n
         6LaiGT3ak5sg94teTX00JtxlO82VbRfGBu/OqoCS4So4nhH94uB0CWR465HElzAATG5X
         mY/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=AuVbI191/O5fPuaIwnxwbQn3XJU3aiYUEwW2YMjR/sg=;
        b=DhcZ04UqprfueRR6SBo4GCgJ1/QCH0ycWrFErhOahQ11QH0bFYVUW9VyiBBHKB4sx7
         LiK8BgHG+6WsMYCMLH6SGg5kL0Vufav2vyyYzXCdkvQGs8h9Us1kMl1Cq7SHWNAk1YVu
         uqBnxWvSYS8Lbr/syup4gTkIlR99k6i+bCrGHQUW0fGXy3JYmfS70dAvrRvvw3AqJnzn
         6aK1i/SW5dVJUeqUjP5xMDlYTOIXPajGBfAbHCEE3+SYFqRE3uVt3Hj9AuclZgR6fdE7
         mNnhmMLf2DQsm98lW/xPVRolZQIEzxC/iicwm3BDk2I7C5nJX1iwqpV7luf1z8cTG82S
         waAQ==
X-Gm-Message-State: AOAM530OhL39S7Vwo4guwA8I1zllDLT13U5CXcKrbEHaJ4VBb0nBr6Za
        aNzdSSYpE42r+Rx3KNe/OuFyACDzi6cSRnM88QEk17L+RtH4URBLa8j3oeeBhsZ1XGnEDryZ0av
        4h7Zp1aJVGB7IjVJwAEU0/cH3uzpmUwectXRx+95sEZZbYoz+552PE3QQ2vJbmW0=
X-Google-Smtp-Source: ABdhPJw4PL7BhZqHDFZEyvSemQYhqxxovAhI7AbuwkpKrNCNO14bWrGlqz7b2/jBKT8cmHbU30JVJ79w+Du1gQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:902:f54c:b0:151:4cff:3f28 with SMTP
 id h12-20020a170902f54c00b001514cff3f28mr846323plf.125.1646439304194; Fri, 04
 Mar 2022 16:15:04 -0800 (PST)
Date:   Fri,  4 Mar 2022 16:13:54 -0800
In-Reply-To: <20220305001401.20888-1-chooglen@google.com>
Message-Id: <20220305001401.20888-7-chooglen@google.com>
Mime-Version: 1.0
References: <20220303005727.69270-1-chooglen@google.com> <20220305001401.20888-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.616.g0bdcbb4464-goog
Subject: [PATCH v4 06/13] submodule--helper: don't use bitfield indirection
 for parse_options()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Do away with the indirection of local variables added in
c51f8f94e5b (submodule--helper: run update procedures from C,
2021-08-24).

These were only needed because in C you can't get a pointer to a
single bit, so we were using intermediate variables instead.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/submodule--helper.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index b5a2d83029..3832dccae5 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2023,10 +2023,10 @@ struct update_data {
 	struct object_id suboid;
 	struct submodule_update_strategy update_strategy;
 	int depth;
-	unsigned int force: 1;
-	unsigned int quiet: 1;
-	unsigned int nofetch: 1;
-	unsigned int just_cloned: 1;
+	unsigned int force;
+	unsigned int quiet;
+	unsigned int nofetch;
+	unsigned int just_cloned;
 };
 #define UPDATE_DATA_INIT { .update_strategy =3D SUBMODULE_UPDATE_STRATEGY_=
INIT }
=20
@@ -2578,16 +2578,17 @@ static int update_clone(int argc, const char **argv=
, const char *prefix)
=20
 static int run_update_procedure(int argc, const char **argv, const char *p=
refix)
 {
-	int force =3D 0, quiet =3D 0, nofetch =3D 0, just_cloned =3D 0;
 	char *prefixed_path, *update =3D NULL;
 	struct update_data update_data =3D UPDATE_DATA_INIT;
=20
 	struct option options[] =3D {
-		OPT__QUIET(&quiet, N_("suppress output for update by rebase or merge")),
-		OPT__FORCE(&force, N_("force checkout updates"), 0),
-		OPT_BOOL('N', "no-fetch", &nofetch,
+		OPT__QUIET(&update_data.quiet,
+			   N_("suppress output for update by rebase or merge")),
+		OPT__FORCE(&update_data.force, N_("force checkout updates"),
+			   0),
+		OPT_BOOL('N', "no-fetch", &update_data.nofetch,
 			 N_("don't fetch new objects from the remote site")),
-		OPT_BOOL(0, "just-cloned", &just_cloned,
+		OPT_BOOL(0, "just-cloned", &update_data.just_cloned,
 			 N_("overrides update mode in case the repository is a fresh clone")),
 		OPT_INTEGER(0, "depth", &update_data.depth, N_("depth for shallow fetch"=
)),
 		OPT_STRING(0, "prefix", &prefix,
@@ -2615,10 +2616,6 @@ static int run_update_procedure(int argc, const char=
 **argv, const char *prefix)
 	if (argc !=3D 1)
 		usage_with_options(usage, options);
=20
-	update_data.force =3D !!force;
-	update_data.quiet =3D !!quiet;
-	update_data.nofetch =3D !!nofetch;
-	update_data.just_cloned =3D !!just_cloned;
 	update_data.sm_path =3D argv[0];
=20
 	if (update_data.recursive_prefix)
--=20
2.33.GIT

