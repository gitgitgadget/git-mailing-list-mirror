Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF5EDC433EF
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 20:16:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C765460F48
	for <git@archiver.kernel.org>; Fri, 15 Oct 2021 20:16:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242974AbhJOUSs (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Oct 2021 16:18:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242941AbhJOUSr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Oct 2021 16:18:47 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8CAEC061570
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 13:16:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id z130-20020a256588000000b005b6b4594129so12537911ybb.15
        for <git@vger.kernel.org>; Fri, 15 Oct 2021 13:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=Us6PMDr8Uo9PiCAV9syzwBOKsy0US747gptRPRZAsT8=;
        b=kDMNEYKEEGBqL0QlEECFUAkozfEup2gL5ZDC29MaSZ8HZgnDFZZPZVAO3YgzsRADwc
         p/XGC3YkiztJIyBllACWMRDAiNR8bqxNs93rLVtR1woge8wNHzCeMmGcCZZp91RuNmjY
         TTgsXHMprvd/JrlMill43xKS5anlZxYUvPuqx6nV3GosA2QF0v7emKW75UoTyCiznPuD
         km46/s+blpeGthhVIza3ATD2kfZdIWMLIIezmEOmBQKMOSf8u/NrH4wdO9Ae4tSjWTz8
         kze/QRDLgrBM72PE+fGJhlBe7jTaaxlPfTPeWDIR8qP+eKo3A6Zgm6fCvqgIqzg4Z33W
         os4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=Us6PMDr8Uo9PiCAV9syzwBOKsy0US747gptRPRZAsT8=;
        b=g9FLAlKUHBNlUESGzWA8XlnePlgDuf+NH8KOI4SyPVTNo+9yhdnAB3cWK820KB52Fu
         Gzf5me70HShXsQ1Eb5UPoBK8UdRIAySwTwmyMj6Lv5anWqX7ooGJsdVX83d0S4Qg0Rl6
         ATXDmRZnabbb3bkjKNXqChyIRrW6U0vOZLQcJuVrgT+row55nm3q53tfx3v6rAuTQXRW
         5FIooDQhc9i1QEjUF16ncFOhP1+dcJ4gIf5f6A18N6bQL8mU5cWLWmGCFPSL5U0Vvf4l
         dvbpMQMZFTm34WvtHZJI9fvmSXW5ruiJ21h+G3uOLChR2tyhuXi24JNxX74MqSsiQRvQ
         1+4g==
X-Gm-Message-State: AOAM533ag4Rqvl0gjmZs77wQ73IvNIs+MAwoFaI29SXlPbv1oGQtMPbp
        xIeJM6x0+XRyp42KxEd1KA43otQxD29HlwFGLWfeP9u+sGA6HPykqaemnMcJBvw0y9wODCUD3mi
        FgGpHUvK4+dAcTmZ6Q3tNLPN98XvLz5mog7OhDRA8hoZUm3bx3Rya5Jbo0MAATyU=
X-Google-Smtp-Source: ABdhPJyMLmtZ63FZ7PIRJuP5bkn3Ak83/EcTPE+qUkOIY9HuZ8UkSYir0PodKHZHZmt88oQEFRuSGwhlN8RX3g==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:ccd1:: with SMTP id
 l200mr15528238ybf.140.1634328999847; Fri, 15 Oct 2021 13:16:39 -0700 (PDT)
Date:   Fri, 15 Oct 2021 13:16:30 -0700
In-Reply-To: <20211015201631.91524-1-chooglen@google.com>
Message-Id: <20211015201631.91524-3-chooglen@google.com>
Mime-Version: 1.0
References: <20211012174208.95161-1-chooglen@google.com> <20211015201631.91524-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.1079.g6e70778dc9-goog
Subject: [PATCH v5 2/3] fsck: verify multi-pack-index when implictly enabled
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee <derrickstolee@github.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Glen Choo <chooglen@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Like the previous commit, change fsck to check the
"core_multi_pack_index" variable set in "repo-settings.c" instead of
reading the "core.multiPackIndex" config variable. This fixes a bug
where we wouldn't verify midx if the config key was missing. This bug
was introduced in 18e449f86b (midx: enable core.multiPackIndex by
default, 2020-09-25) where core.multiPackIndex was turned on by default.

Helped-by: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
Signed-off-by: Glen Choo <chooglen@google.com>
---
 builtin/fsck.c              | 2 +-
 t/t5319-multi-pack-index.sh | 5 ++++-
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/fsck.c b/builtin/fsck.c
index 1c4e485b66..5bbe8068ec 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -925,7 +925,7 @@ int cmd_fsck(int argc, const char **argv, const char *p=
refix)
 		}
 	}
=20
-	if (!git_config_get_bool("core.multipackindex", &i) && i) {
+	if (the_repository->settings.core_multi_pack_index) {
 		struct child_process midx_verify =3D CHILD_PROCESS_INIT;
 		const char *midx_argv[] =3D { "multi-pack-index", "verify", NULL, NULL, =
NULL };
=20
diff --git a/t/t5319-multi-pack-index.sh b/t/t5319-multi-pack-index.sh
index bd17f308b3..38999f115f 100755
--- a/t/t5319-multi-pack-index.sh
+++ b/t/t5319-multi-pack-index.sh
@@ -452,7 +452,10 @@ test_expect_success 'verify incorrect offset' '
 test_expect_success 'git-fsck incorrect offset' '
 	corrupt_midx_and_verify $MIDX_BYTE_OFFSET "\377" $objdir \
 		"incorrect object offset" \
-		"git -c core.multipackindex=3Dtrue fsck"
+		"git -c core.multiPackIndex=3Dtrue fsck" &&
+	test_unconfig core.multiPackIndex &&
+	test_must_fail git fsck &&
+	git -c core.multiPackIndex=3Dfalse fsck
 '
=20
 test_expect_success 'corrupt MIDX is not reused' '
--=20
2.33.0.1079.g6e70778dc9-goog

