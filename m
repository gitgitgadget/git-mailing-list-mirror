Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34E7EC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:42:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 210E86109E
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 17:42:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232699AbhJLRor (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 12 Oct 2021 13:44:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232654AbhJLRoo (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Oct 2021 13:44:44 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E6D0C061749
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 10:42:42 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id x16-20020a25b910000000b005b6b7f2f91cso169780ybj.1
        for <git@vger.kernel.org>; Tue, 12 Oct 2021 10:42:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc:content-transfer-encoding;
        bh=9T1h04Eih6Of+i2mDz9JDnho3wH3tZN1ibZDMTT3UoE=;
        b=QzdWg3kQUptcbVMvZSTegj38AkDrqJVUxfAgSw+ZBkBI/Lfo1Fw478c3r9I7o3Ejww
         v9mJLOwWZgqIjZHFFI/2E/P2U+hT4u7/uN5MOesqN29hQYzirIMy24ZsF0UXEtFBNdTs
         pxl6J32ZurvnNZuaqpNqId8/oXoLY7pg0m4NNI2bP+pNpsY6fQpfpJ+71aQ7lW7FC783
         fx8PcpOOab/bKfZUSHIdBNFQr/n9nQY4lsHXzEMR0C0abkQNtxMF0ASDR370XxyLvmzr
         AW/vaHKtJcPhIDKvHKKqycnbvJ6Co5KP02HSPaFOgsrtZZCtBY8G1cCrLqjJ9WGPvbFs
         KmyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc:content-transfer-encoding;
        bh=9T1h04Eih6Of+i2mDz9JDnho3wH3tZN1ibZDMTT3UoE=;
        b=FIn4jw0ZaVjltXSQeX5b8VjxXYAmBXvbPPwHzdLbwcr5g87KG2pjUBzuwrXDvul/wF
         6BoPwkFLmsQxwSFNhcauAevQr8ue7hd5VSIUBUQSERJ2ez2ObFRPyBYRsGe9r9THUfaQ
         5vuZIPIj+27BcHeaJpLgSltJ/1XKc/zTbQwoFR4hCrh1GR7EibD7TqZqjWaAAIux5nNF
         K8ut3OxO2HZ96Ly/egHIwb/wg0/d/8oznN/RU3FyRqmNFBNhGDPJ4Lo1DviIjWPuGAov
         JoAUahCDygnYs65Ae+G0INyJlHrnrpvnRrgPAMCxoUGDbG5uTc8LIXF+T5d7TMXvkzfp
         pXkA==
X-Gm-Message-State: AOAM532WOSfcxj6GwsD5qeyPvaSTA5HESWNewklU1mlrIrtfE1mX95aE
        DaZRPbtLftp4WHfzwM8nx5FJFIlV7DAR/UcZXs3ynnGGyNZkwmH+I/t2PaXe8uJV3zfn4OAcJOw
        n7LRyNtR6ni/z99QBe212cz/YEETFI+EbfTvvDbPXP0hQSbENGFipYv63bYUhpN4=
X-Google-Smtp-Source: ABdhPJyjtcmoyXS6aGc24bERI3195TvBwNRG4GFjk8DIz0NJfl1Gvy3XxeVFL0le0XHv6ghLKwnetLXf+5FXqQ==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a25:244e:: with SMTP id
 k75mr28994795ybk.346.1634060561439; Tue, 12 Oct 2021 10:42:41 -0700 (PDT)
Date:   Tue, 12 Oct 2021 10:42:07 -0700
In-Reply-To: <20211012174208.95161-1-chooglen@google.com>
Message-Id: <20211012174208.95161-3-chooglen@google.com>
Mime-Version: 1.0
References: <20211005001931.13932-1-chooglen@google.com> <20211012174208.95161-1-chooglen@google.com>
X-Mailer: git-send-email 2.33.0.882.g93a45727a2-goog
Subject: [PATCH v4 2/3] fsck: verify multi-pack-index when implictly enabled
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Eric Sunshine <sunshine@sunshineco.com>,
        Taylor Blau <me@ttaylorr.com>,
        "=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?=" 
        <avarab@gmail.com>, Junio C Hamano <gitster@pobox.com>,
        Glen Choo <chooglen@google.com>
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
2.33.0.882.g93a45727a2-goog

