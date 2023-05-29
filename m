Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5E46C77B7A
	for <git@archiver.kernel.org>; Mon, 29 May 2023 19:23:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjE2TXe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 May 2023 15:23:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229483AbjE2TXd (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 May 2023 15:23:33 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1262C93
        for <git@vger.kernel.org>; Mon, 29 May 2023 12:23:32 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-64fbfe0d037so1390401b3a.0
        for <git@vger.kernel.org>; Mon, 29 May 2023 12:23:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685388211; x=1687980211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+ppY+8GVgdGPon/J9/txfSb7CRebPN/ECpJvaUM0MpA=;
        b=jvvcXevfmmDYoq5GVIlW7/Vg+KfgBMr5o4Rd+Rbs4ihK23mvQik2dLwG0XuwzZZER9
         v/t7jmRFnPTDd721LR+9PTH/cLDy8u9sYBZGTRqv3M+Gv2Sl4kW2ljxG/FUB/5DrvYl7
         JrloMNRN5hb0bvYKljRfYs5EpAzDzo/WIx3pKgkq1cOT+HFOt6rHDjAcPDc3UH3PybS3
         eAa5qFe+3gh2dpVCZjwBLgxzOh1ybr5Q66j6OodpsXkY6BWL9f6368cpPdcSVIJgl0hP
         jMjJgND4JjJ1iFOoUTvLHLCTrA5JfyMapbFKM2ODDwFxP+DdfaDnYbuPQzRCWtG6wUBl
         nBww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685388211; x=1687980211;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+ppY+8GVgdGPon/J9/txfSb7CRebPN/ECpJvaUM0MpA=;
        b=OGO5PAnlX36p73+6pNURgyCuQzowI0DTEFvNgwg5rJLagG/tgDfRIGHdXKUY2MQ5XC
         4LhBXycz4D4/S/eNjr/zEzQuI0XD0/aO26C2oP0CxupKLmDxIgPNKLnDgNk+JtB50MGB
         i/Tky/Zcm6hRHHc6en1h5yfEyI+iusFrdgVq8HFdA91VztMHcTPB69Z2RRpNXQKuxrvS
         B29TkLdVsnzWIiGrs/FMWZcuUmgiNap1/svAuxM8SZID1ZIbk99tOcw14VhcH0PvnUZo
         40bUFuRSpGbXhTi+p/sutZODX70v6etuzmuW2/XbQ704XGsp/KJbORdkMAknP4bsGa5F
         rHDQ==
X-Gm-Message-State: AC+VfDxZZGUXRpFPt/Ye1ntAkhYpqt/GBd8ijOE7Ztct1mvoaTbwtQls
        hkoXvAjDGZeLcXqCtNxry+6tByqP9aSMLSDH
X-Google-Smtp-Source: ACHHUZ4DEvR5jaQ/E7N3c/shhVqfrbJdrZ1JmjZOgVGYSvEDW6HaZx9/pXXQhMMtChkBSHMF4fsM1g==
X-Received: by 2002:a05:6a20:3c88:b0:10b:c843:9522 with SMTP id b8-20020a056a203c8800b0010bc8439522mr19518pzj.20.1685388211168;
        Mon, 29 May 2023 12:23:31 -0700 (PDT)
Received: from fivlite-virtual-machine.localdomain ([49.37.145.178])
        by smtp.gmail.com with ESMTPSA id i16-20020aa78d90000000b0064fa43129fcsm277694pfr.130.2023.05.29.12.23.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 12:23:30 -0700 (PDT)
From:   Kousik Sanagavarapu <five231003@gmail.com>
To:     git@vger.kernel.org
Cc:     Kousik Sanagavarapu <five231003@gmail.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>
Subject: [PATCH 1/2] t/lib-gpg: introduce new prereq GPG2
Date:   Tue, 30 May 2023 00:02:05 +0530
Message-ID: <20230529192209.17747-2-five231003@gmail.com>
X-Mailer: git-send-email 2.41.0.rc0
In-Reply-To: <20230529192209.17747-1-five231003@gmail.com>
References: <20230529192209.17747-1-five231003@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

GnuPG v2.0.0 released in 2006, which according to its release notes

	https://gnupg.org/download/release_notes.html

is the "First stable version of GnuPG integrating OpenPGP and S/MIME".

Use this version or it's successors for tests that will fail for
versions less than v2.0.0 because of the difference in the output on
stderr between the versions (v2.* vs v0.* or v2.* vs v1.*). Skip if
the GPG version detected is less than v2.0.0.

Do not, however, remove the existing prereq GPG yet since a lot of tests
still work with the prereq GPG (that is even with versions v0.* or v1.*)
and some systems still use these versions.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: Hariom Verma <hariom18599@gmail.com>
Signed-off-by: Kousik Sanagavarapu <five231003@gmail.com>
---
 t/lib-gpg.sh             | 21 +++++++++++++++++++++
 t/t7510-signed-commit.sh |  7 +++++++
 2 files changed, 28 insertions(+)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 114785586a..4287ea8621 100644
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -51,6 +51,27 @@ test_lazy_prereq GPG '
 	esac
 '
 
+test_lazy_prereq GPG2 '
+	gpg_version=$(gpg --version 2>&1)
+	test $? != 127 || exit 1
+
+	case "$gpg_version" in
+	!"gpg (GnuPG) 2."*)
+		say "This test requires a GPG version >= v2.0.0"
+		exit 1
+		;;
+	*)
+		(gpgconf --kill all || : ) &&
+		gpg --homedir "${GNUPGHOME}" --import \
+			"$TEST_DIRECTORY"/lib-gpg/keyring.gpg &&
+		gpg --homedir "${GNUPGHOME}" --import-ownertrust \
+			"$TEST_DIRECTORY"/lib-gpg/ownertrust &&
+		gpg --homedir "${GNUPGHOME}" </dev/null >/dev/null \
+			--sign -u committer@example.com
+		;;
+	esac
+'
+
 test_lazy_prereq GPGSM '
 	test_have_prereq GPG &&
 	# Available key info:
diff --git a/t/t7510-signed-commit.sh b/t/t7510-signed-commit.sh
index ccbc416402..96b316ae01 100755
--- a/t/t7510-signed-commit.sh
+++ b/t/t7510-signed-commit.sh
@@ -218,6 +218,13 @@ test_expect_success GPG 'amending already signed commit' '
 	! grep "BAD signature from" actual
 '
 
+test_expect_success GPG2 'bare signature' '
+	git verify-commit fifth-signed 2>expect &&
+	echo "" >>expect &&
+	git log -1 --format="%GG" fifth-signed >actual &&
+	test_cmp expect actual
+'
+
 test_expect_success GPG 'show good signature with custom format' '
 	cat >expect <<-\EOF &&
 	G
-- 
2.41.0.rc0

