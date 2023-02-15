Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4556CC6379F
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 05:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232124AbjBOF6m (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 00:58:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231915AbjBOF6j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 00:58:39 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0745055B1
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 21:58:39 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id bk16so17891406wrb.11
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 21:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=itDWRfol/WbOFdzmUXxIKieBwsj0T/+WpC9yvFBFi2s=;
        b=hOXWyusVs64bZD5/9vkKUoaO2aPq8SG/ggpjDU/jUj4lSsONItMZENN+DZfEyXuSaX
         t/Ns4OvBKfcc09sm3RRrRO7KTpJN7ODDrk3M+O0q5vjO8i5QUGdAamjkAx5mNYYao6ds
         HB4M7uxqTjF8MXT9tzvJh5jD0QkCGCctZ3I0Mk0wH6BlCkn2d9HMeH6jPMZsYrxS1Dnf
         JoFGcHXwfyHaGm2fPqXlafXM18tjUoYKlSQFrDWbHingtBV4d8SWbL9wV7ubJWF4Yrwq
         G8vNHIc9DLcgteCJ604vu0yT/cEEVDD4xPLCjSxebgHQ/ivH50eMzEyuqVEWSGEzaDBc
         bmGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=itDWRfol/WbOFdzmUXxIKieBwsj0T/+WpC9yvFBFi2s=;
        b=G45PtpaM3ntC/tIFR0pxhZELAQZxBKO0TtKP4zcIuECD+KnSHOHWxifrKSSda2X/OB
         lwveVoysulKRJgtB9mE3tQ6U+tKdVhohAPQOnJNV64tX2QvZA9wPozRBqfvtFoGaXaPO
         Le61CwBQW+ZCNFjttUx/U5KOsBQTGGoL3PEcoQGpRhIuk9XuhxyliAdJ+SCnFfcRLtXl
         jU+M5o+EhqfkDGFxDjX2j4Qb4d21UrhCZBvTWRlU4fV/B3kUenGscj+Wwo/JOJBij79s
         IGHHXaG4T67xB6hUotoOdFbtktGDdb1ClVJQNJBtjb+CrCZq2l3bjq73EUtwKupw4jXO
         Snvw==
X-Gm-Message-State: AO0yUKVH2HIRI2eMUMFPepMsxdHQcft4mS++IvQtd7E9Xttqh6LODJBz
        gVajazuRYF0ezA0jGN2GQr/5Jc3v+gQ=
X-Google-Smtp-Source: AK7set/hc1mkVGpUpd/x5x3Qv9g/OGVi7qMaFYyFI8CSOzaAY8C1oma3+xJNEeWA9V6dHRqLsjTObw==
X-Received: by 2002:a5d:50c1:0:b0:2c5:4bdf:8f5b with SMTP id f1-20020a5d50c1000000b002c54bdf8f5bmr946194wrt.20.1676440717281;
        Tue, 14 Feb 2023 21:58:37 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id l17-20020a5d6691000000b002c549dd0a4bsm12475289wru.37.2023.02.14.21.58.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 21:58:36 -0800 (PST)
Message-Id: <ead90d343b1f4f4ce8998b2f31558fd30d7d2675.1676440714.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1480.git.1676440714.gitgitgadget@gmail.com>
References: <pull.1480.git.1676440714.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Feb 2023 05:58:34 +0000
Subject: [PATCH 2/2] gpg: do show gpg's error message upon failure
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There are few things more frustrating when signing a commit fails than
reading a terse "error: gpg failed to sign the data" message followed by
the unsurprising "fatal: failed to write commit object" message.

In many cases where signing a commit or tag fails, `gpg` actually said
something helpful, on its stderr, and Git even consumed that, but then
keeps mum about it.

Teach Git to stop withholding that rather important information.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 gpg-interface.c          |  8 ++++++--
 t/t7510-signed-commit.sh | 10 +++++++++-
 2 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/gpg-interface.c b/gpg-interface.c
index 687236430bf..5cd66d3a786 100644
--- a/gpg-interface.c
+++ b/gpg-interface.c
@@ -977,9 +977,13 @@ static int sign_buffer_gpg(struct strbuf *buffer, struct strbuf *signature,
 			break; /* found */
 	}
 	ret |= !cp;
+	if (ret) {
+		error(_("gpg failed to sign the data:\n%s"),
+		      gpg_status.len ? gpg_status.buf : "(no gpg output)");
+		strbuf_release(&gpg_status);
+		return -1;
+	}
 	strbuf_release(&gpg_status);
-	if (ret)
-		return error(_("gpg failed to sign the data"));
 
 	/* Strip CR from the line endings, in case we are on Windows. */
 	remove_cr_after(signature, bottom);
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index ec07c8550f5..48f86cb3678 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -399,6 +399,10 @@ test_expect_success 'custom `gpg.program`' '
 
 	case "$1" in
 	-bsau)
+		test -z "$LET_GPG_PROGRAM_FAIL" || {
+			echo "zOMG signing failed!" >&2
+			exit 1
+		}
 		cat >sign.file
 		echo "[GNUPG:] SIG_CREATED $args" >&2
 		echo "-----BEGIN PGP MESSAGE-----"
@@ -420,7 +424,11 @@ test_expect_success 'custom `gpg.program`' '
 	git commit -S --allow-empty -m signed-commit &&
 	test_path_exists sign.file &&
 	git show --show-signature &&
-	test_path_exists verify.file
+	test_path_exists verify.file &&
+
+	test_must_fail env LET_GPG_PROGRAM_FAIL=1 \
+	git commit -S --allow-empty -m must-fail 2>err &&
+	grep zOMG err
 '
 
 test_done
-- 
gitgitgadget
