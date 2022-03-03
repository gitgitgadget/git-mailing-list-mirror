Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FE87C433FE
	for <git@archiver.kernel.org>; Thu,  3 Mar 2022 00:58:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbiCCA6w (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Mar 2022 19:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231195AbiCCA6t (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Mar 2022 19:58:49 -0500
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0728A15470D
        for <git@vger.kernel.org>; Wed,  2 Mar 2022 16:58:00 -0800 (PST)
Received: by mail-pg1-x549.google.com with SMTP id n63-20020a632742000000b00378b20298a2so1877848pgn.22
        for <git@vger.kernel.org>; Wed, 02 Mar 2022 16:58:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=8EAxdsA/GfXKOQ8ZUmn1Xxfw1B6J+Y02IU6IksgGGVM=;
        b=bVms1hx9q+Ql5LyliSrSDtfTvhGOwzLVrssIEL9QxsIc7MgdkdKRzP9F9E2Dtj/nQ9
         13MPT6kPFlNcrkv9lECXzfruUsysAiZkiwFhoRBMw3H8I41zh4JotRio0Sw1azmdK8Vq
         xwbuj7btG91RWQANRWSYiCZ5QVMCR9gkXi25orvcgIu2uL5inf2sSnKPztmeMOfhdH4I
         1tVO5LVv53ZBjYpAu5HtSooMJ/3fP2RicSX7KQ/LyHHKoRrjc3YXAqZe5uuU2bAGeMgK
         JOnog7zVjPvsfn4cOsaEhTU1GsAtJ8kHMRNLsf4w+fagpyjDOHeJ5Nmj77o/709soNTy
         UD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=8EAxdsA/GfXKOQ8ZUmn1Xxfw1B6J+Y02IU6IksgGGVM=;
        b=t0xTWUzBHZwnUUNSdWM86lLm4Xl2dqNuO+2eQUQ74ngFHfBVhdbV72sMfi3Viy3Y5B
         jt0OSRbM2ZDyB/bpGObvaXxLa/5Ln34dRtpUMxpYAU8U1JknkE6udfNQgMjNziEwF8cd
         CnxqCV6yMwoZgx3H2a3pk4NbyHB2bcIuYXCDYRxtwRbNaLq/dUdqlLclVagGzmn0q7kw
         zzCvUZS4U6sLqY2QIYRnCdHDYxkhZqOxqDsuJG74euo9OATLG/G4OSm+s410YrxleHmZ
         l9PCafWHuHmSA3e9eroKwpLmFrrqxJduWlZ93Dl8qSJNGVhSauCCi2fyHFEgMAGKHUOh
         Rr0A==
X-Gm-Message-State: AOAM532W7qPoTMmRo8aeX3BE8zIFecq44+OASE/N6JJeYTLZIoUu5X45
        sTB/HQx0BwQBKhGJ8vk2QVpN1GWLffQn3Cl1S0gn4TRtUjfNmGp4uJztp6aT5v+8bUo9oy5fuHK
        xq8cpVqYZveEXFWOFn3W4r0kf/d34jVLWX+A7jXvOmU602oSiNgf7mINLR4aWajI=
X-Google-Smtp-Source: ABdhPJw1TVQDJI/zuapU1eQelKWtoeiNguH/famB3wY53ctEh3/cTncNNXOb75+7Vz6MOmIjGPVHMzPbGt9bPQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a17:90b:4b52:b0:1bc:b208:dc5c with SMTP
 id mi18-20020a17090b4b5200b001bcb208dc5cmr830799pjb.1.1646269079755; Wed, 02
 Mar 2022 16:57:59 -0800 (PST)
Date:   Wed,  2 Mar 2022 16:57:23 -0800
In-Reply-To: <20220303005727.69270-1-chooglen@google.com>
Message-Id: <20220303005727.69270-10-chooglen@google.com>
Mime-Version: 1.0
References: <20220301044132.39474-1-chooglen@google.com> <20220303005727.69270-1-chooglen@google.com>
X-Mailer: git-send-email 2.35.1.574.g5d30c73bfb-goog
Subject: [PATCH v3 09/13] submodule--helper: refactor get_submodule_displaypath()
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Glen Choo <chooglen@google.com>,
        Junio C Hamano <gitster@pobox.com>,
        Atharva Raykar <raykar.ath@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Josh Steadmon <steadmon@google.com>,
        Christian Couder <christian.couder@gmail.com>,
        Shourya Shukla <periperidip@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Atharva Raykar <raykar.ath@gmail.com>

We create a function called `do_get_submodule_displaypath()` that
generates the display path required by several submodule functions, and
takes a custom superprefix parameter, instead of reading it from the
environment.

We then redefine the existing `get_submodule_displaypath()` function
as a call to this new function, where the superprefix is obtained from
the environment.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Shourya Shukla <periperidip@gmail.com>
Signed-off-by: Atharva Raykar <raykar.ath@gmail.com>
Signed-off-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/submodule--helper.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/builtin/submodule--helper.c b/builtin/submodule--helper.c
index 99341fb343..e6df99a884 100644
--- a/builtin/submodule--helper.c
+++ b/builtin/submodule--helper.c
@@ -247,11 +247,10 @@ static int resolve_relative_url_test(int argc, const =
char **argv, const char *pr
 	return 0;
 }
=20
-/* the result should be freed by the caller. */
-static char *get_submodule_displaypath(const char *path, const char *prefi=
x)
+static char *do_get_submodule_displaypath(const char *path,
+					  const char *prefix,
+					  const char *super_prefix)
 {
-	const char *super_prefix =3D get_super_prefix();
-
 	if (prefix && super_prefix) {
 		BUG("cannot have prefix '%s' and superprefix '%s'",
 		    prefix, super_prefix);
@@ -267,6 +266,13 @@ static char *get_submodule_displaypath(const char *pat=
h, const char *prefix)
 	}
 }
=20
+/* the result should be freed by the caller. */
+static char *get_submodule_displaypath(const char *path, const char *prefi=
x)
+{
+	const char *super_prefix =3D get_super_prefix();
+	return do_get_submodule_displaypath(path, prefix, super_prefix);
+}
+
 static char *compute_rev_name(const char *sub_path, const char* object_id)
 {
 	struct strbuf sb =3D STRBUF_INIT;
--=20
2.33.GIT

