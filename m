Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CB3FC636CC
	for <git@archiver.kernel.org>; Wed, 15 Feb 2023 05:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231966AbjBOF6k (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 15 Feb 2023 00:58:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231656AbjBOF6j (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Feb 2023 00:58:39 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AD9B5BA1
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 21:58:38 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id f47-20020a05600c492f00b003dc584a7b7eso666340wmp.3
        for <git@vger.kernel.org>; Tue, 14 Feb 2023 21:58:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=y58J+ptFTXHyKWNLAk1mN3psp3/lv9/qkcmigBsKj+Q=;
        b=PG5/9AWwwZLwdnmxaXDZiRDF/QnT80YLSiWm40ML7keWHUJbXUVI7T+yC6FBe/RWCv
         mVNKAMoVdgNtbeDvO1y30olHHOsnfp255ycVFho5cZcNDIKFDkcH7CXv1bqcw9gLglg0
         4L0jwGSGQhUa6+/m1W7Uo5BtonBDuvF/kxT8bQRVCFKc41RMtGaeRh06Z1pN1k+fGUh5
         6E/FcQWJj5x1eSiie5ANBpChGg1gEWpNF+YTFx60xgneUdulRNIN8KJOrTVu1nLusBj2
         DrZE1E3XV6CJ97GzgV48atyQUUX1PpcRjxB1rdBvEUeXMQiBAHKZmW95D9vGgB0kwcg9
         PjoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=y58J+ptFTXHyKWNLAk1mN3psp3/lv9/qkcmigBsKj+Q=;
        b=4JSkhOpal2br3abXZvd8VPdXXIqps0AeZuZ1Zu0H24OcbuQ7quQkj8NlOLc8GH+2Fq
         Anrt125dslTO+CnKfBEeIwxWSMdMG4MZok/UQycUtBezhu0yIE59QdA7Dno9SXK6dCDW
         vlyNUnbyIZ1fe73OI/C0bVR79rw9I3PJXx9n6FqZ2sBB5ScbZa8Uj2KFF4/y2TBmiD4U
         EouC9ltGAOwxrRlWmy+VLJlh0WLXo5tLQr8pWUL886bS+VnHr1zhNpIvP1mW/z8yQnQJ
         4KTSxLdx83OwwrkCYua7srrY+wFjSVQGnTw3ghTtuHrDapOm8oVnW1eWBrGMiw0Q5pVn
         ZvvA==
X-Gm-Message-State: AO0yUKWSfmeHMwZ2WxfCMBro3m9NMRK65keHSO1AGsA5hr/03kD304zV
        I75bsKKEawL9QeaKjIvkbipl0htjSec=
X-Google-Smtp-Source: AK7set9LvWYT8hX4z0CpA8ct+2k2nisEtDPDwp393qH32XGyDeH7z9/wqoBFoz2GIqjpce5G4WjM/A==
X-Received: by 2002:a05:600c:18a2:b0:3dd:393c:20b5 with SMTP id x34-20020a05600c18a200b003dd393c20b5mr975600wmp.35.1676440716530;
        Tue, 14 Feb 2023 21:58:36 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id he7-20020a05600c540700b003e118684d56sm859683wmb.45.2023.02.14.21.58.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Feb 2023 21:58:35 -0800 (PST)
Message-Id: <fe55654b993c84b59f3d00e418d662189325eb3a.1676440714.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1480.git.1676440714.gitgitgadget@gmail.com>
References: <pull.1480.git.1676440714.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Wed, 15 Feb 2023 05:58:33 +0000
Subject: [PATCH 1/2] t7510: add a test case that does not need gpg
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

This test case not only increases test coverage in setups without
working gpg, but also prepares for verifying that the error message of
`gpg.program` is shown upon failure.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t7510-signed-commit.sh | 36 ++++++++++++++++++++++++++++++++++++
 1 file changed, 36 insertions(+)

diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index bc7a31ba3e7..ec07c8550f5 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -387,4 +387,40 @@ test_expect_success GPG 'verify-commit verifies multiply signed commits' '
 	! grep "BAD signature from" actual
 '
 
+test_expect_success 'custom `gpg.program`' '
+	write_script fake-gpg <<-\EOF &&
+	args="$*"
+
+	# skip uninteresting options
+	while case "$1" in
+	--status-fd=*|--keyid-format=*) ;; # skip
+	*) break;;
+	esac; do shift; done
+
+	case "$1" in
+	-bsau)
+		cat >sign.file
+		echo "[GNUPG:] SIG_CREATED $args" >&2
+		echo "-----BEGIN PGP MESSAGE-----"
+		echo "$args"
+		echo "-----END PGP MESSAGE-----"
+		;;
+	--verify)
+		cat "$2" >verify.file
+		exit 0
+		;;
+	*)
+		echo "Unhandled args: $*" >&2
+		exit 1
+		;;
+	esac
+	EOF
+
+	test_config gpg.program "$(pwd)/fake-gpg" &&
+	git commit -S --allow-empty -m signed-commit &&
+	test_path_exists sign.file &&
+	git show --show-signature &&
+	test_path_exists verify.file
+'
+
 test_done
-- 
gitgitgadget

