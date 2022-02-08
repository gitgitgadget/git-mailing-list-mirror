Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0C2EC433EF
	for <git@archiver.kernel.org>; Tue,  8 Feb 2022 08:40:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350470AbiBHIkY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Feb 2022 03:40:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350499AbiBHIkP (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Feb 2022 03:40:15 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA63FC03FEC1
        for <git@vger.kernel.org>; Tue,  8 Feb 2022 00:40:14 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id n4-20020a17090ade8400b001b8bb511c3bso4417576pjv.7
        for <git@vger.kernel.org>; Tue, 08 Feb 2022 00:40:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=puu5AcCYsaaMCyP0Miw6o/BQAKwD83xVxXobDV0qE4M=;
        b=rAkicTeYXxRkr1ZY4gqppCfDT18V7xofK13eEHPKHLe8/ObuT3tNs+FeGvaEEkm52d
         42pfdRsRkohkhRDf2ULxLDEhLx0J51RA17OOyie+6BKHyUgxNbGjSuLbEaSNRZNaqjhl
         5Ymb7WbLFQNtk6nNf3K/EGiWquQB3tBURy1jo7W9djTsi6Ye7Ecwr1TIiVLm5ZpORP2h
         XEd8uhZlV5hqNJuLFyRdzI2lr2YeUDrGEDeoW7gyJhPSZDyoOR/AsKXctcRlBqlWeKd7
         b+im9iBPXxsSaKJwxwa14Y4YjchoEnO1zVpqgsova2qZpwCFV1hs7mTo5TXM1uNRcJa7
         jCTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=puu5AcCYsaaMCyP0Miw6o/BQAKwD83xVxXobDV0qE4M=;
        b=EH8mx7JcViUpF9x9e3aEwCpxQ8i5RicYPJqvr3rXeM78BrpVgtZlZ8udVRF3DafgO9
         1cgGOA/BbdyBzciHviShbTZUTgczzSmBXLqN8Mpb5x6wMu7ncqJ3rte22QdnFLmYFmUM
         ldXgiS8sT9ulIIsYA2r1pVGdkgADu3sPd0ULmArV3Kpc7nUvAs1xvFY5LuMtS8VKctsQ
         kyHACOal7aVP1CXqdkcB5qUUwCngDcUuOC6Pk15wVQode57o7Q2lzUaqnyZS9jp9umio
         ELnERx/NXvZFpiJeNg9iwEfgDe3sMjj+t3P+EfdazVc5ZQqKrTZ0nL/8yWRevWA59Xps
         fDMQ==
X-Gm-Message-State: AOAM531LuPJNoUDikbgtdXXwpnpKI7/4qxbNMuTa0/RWXZ/Ovy/h7y9W
        70YmHzwlSXu11Sr5piqVHoZP9ALHvUSRwqC71UEGxt3F+cerB2g6YSwzbtPCxaUf/9UcI9W8S9P
        XksoG968mGT192yGnd6DuQqZJCKXbrwV7xKtZs0EQ9iF8WAg42ByLlf+zEaX85WU=
X-Google-Smtp-Source: ABdhPJzmYXol8wGBfasXrn8AcU5gJ4+8ne6tLLiWPavkwzxjkwkuffYx8yVJizSs254fMHqr0zNLdrIgZR4ymg==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a05:6a00:134b:: with SMTP id
 k11mr3480040pfu.33.1644309613702; Tue, 08 Feb 2022 00:40:13 -0800 (PST)
Date:   Tue,  8 Feb 2022 16:39:43 +0800
In-Reply-To: <20220208083952.35036-1-chooglen@google.com>
Message-Id: <20220208083952.35036-8-chooglen@google.com>
Mime-Version: 1.0
References: <cover-v5-0.9-00000000000-20220128T125206Z-avarab@gmail.com> <20220208083952.35036-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.0.263.gb82422642f-goog
Subject: [PATCH v6 07/16] submodule--helper: don't use bitfield indirection
 for parse_options()
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

From: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>

Do away with the indirection of local variables added in
c51f8f94e5b (submodule--helper: run update procedures from C,
2021-08-24).

These were only needed because in C you can't get a pointer to a
single bit, so we were using intermediate variables instead.

This will also make a subsequent large commit's diff smaller.

Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 23 ++++++++++-------------
 1 file changed, 10 insertions(+), 13 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index c2d4fd0347..4a0890954e 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -2045,10 +2045,10 @@ struct update_data {
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
 #define UPDATE_DATA_INIT { \
 	.update_strategy =3D SUBMODULE_UPDATE_STRATEGY_INIT, \
@@ -2578,16 +2578,17 @@ static int update_clone(int argc, const char **argv=
, const char *prefix)
=20
 static int run_update_procedure(int argc, const char **argv, const char *p=
refix)
 {
-	int force =3D 0, quiet =3D 0, nofetch =3D 0, just_cloned =3D 0;
 	char *prefixed_path, *update =3D NULL;
 	struct update_data opt =3D UPDATE_DATA_INIT;
=20
 	struct option options[] =3D {
-		OPT__QUIET(&quiet, N_("suppress output for update by rebase or merge")),
-		OPT__FORCE(&force, N_("force checkout updates"), 0),
-		OPT_BOOL('N', "no-fetch", &nofetch,
+		OPT__QUIET(&opt.quiet,
+			   N_("suppress output for update by rebase or merge")),
+		OPT__FORCE(&opt.force, N_("force checkout updates"),
+			   0),
+		OPT_BOOL('N', "no-fetch", &opt.nofetch,
 			 N_("don't fetch new objects from the remote site")),
-		OPT_BOOL(0, "just-cloned", &just_cloned,
+		OPT_BOOL(0, "just-cloned", &opt.just_cloned,
 			 N_("overrides update mode in case the repository is a fresh clone")),
 		OPT_INTEGER(0, "depth", &opt.depth, N_("depth for shallow fetch")),
 		OPT_STRING(0, "prefix", &prefix,
@@ -2618,10 +2619,6 @@ static int run_update_procedure(int argc, const char=
 **argv, const char *prefix)
 	if (argc !=3D 1)
 		usage_with_options(usage, options);
=20
-	opt.force =3D !!force;
-	opt.quiet =3D !!quiet;
-	opt.nofetch =3D !!nofetch;
-	opt.just_cloned =3D !!just_cloned;
 	opt.sm_path =3D argv[0];
=20
 	if (opt.recursive_prefix)
--=20
2.33.GIT

