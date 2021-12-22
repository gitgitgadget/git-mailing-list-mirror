Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38B24C433F5
	for <git@archiver.kernel.org>; Wed, 22 Dec 2021 04:13:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239101AbhLVENL (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Dec 2021 23:13:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232586AbhLVENK (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 21 Dec 2021 23:13:10 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EA72C061574
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:09 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id d198-20020a1c1dcf000000b0034569cdd2a2so709480wmd.5
        for <git@vger.kernel.org>; Tue, 21 Dec 2021 20:13:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Z/gArmVFh3AmmHb8FcDN5tNlI3BpS/dBZJFr3XTARAw=;
        b=DIKXP9eBO49BECzVpYYwpxrtNQw5wPnyzrrmVKu+fdo+9bndGSt02ycqrL8e2pArTy
         lLa6SVY968Qt8V3hqLWd1buz0MBmvp4897qrLvphbd3MVNEYMfh6BSQNSAouXJ99sHuK
         3UO8mrqHSPdPGF9X28bdWwjQofICV7Jy9gRJuX8r6hxQks6BJDa4dy2eomaD/h7K/FL+
         tLyC1X9EaqyelxTdP/iYifHJoy79fIXC5IJhChWC23Lu3Jc5rGSku3/pP+wg5jnPCVHb
         BjMLvNv9i2eM06TyQvJi3dwiLgEXMtFj+fqNwaTmXRBoQGiWeyTkEchZBVvehu6RuZ0G
         kAzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Z/gArmVFh3AmmHb8FcDN5tNlI3BpS/dBZJFr3XTARAw=;
        b=cmQuFV3EsNGaaRHnsggc1IvSxsqWgWHYAASNyrRaWXBpg7zcwCLF+b4X2rA+6pxCrf
         08CPWniVYUgh1uFX4SNRmzY7x/NT4nsiqxmmv2FiybNlV3i8eFYTfRIpZCOsxNfdMR5y
         6+EboFsX5x+dox5NwL1WnfRm6iXClsE7MtANBcgAlP5uI/n+4V4J4StUXv9xxZGQgC2R
         j4xY/2laEH+4mrgkjqAJ94VOGp94B4DgpaRvCf+jFkQFbOgVaUehvbLxB/Qvg24owpa+
         AIMnrNAuJ4aRI+/GcGAlu+ub/e72kc302ZPi9FCEmIWZMfbzynX0UYYKHt8szMeYWtuB
         CHHQ==
X-Gm-Message-State: AOAM531eizfSkt639XIY4ofsVNVc0x+57w4JXwUdSIt0doHop6W+hflx
        VZDZ0RFGgbE1JoyKswlLxUKTH7tI3xRZ7g==
X-Google-Smtp-Source: ABdhPJwvVYYHD2hlKf5VSb+7zM7ayKLgTGp015kfbBSNHtv8YhCVn7xccJTid7Z9CWLdNJvmNnRz9A==
X-Received: by 2002:a7b:c450:: with SMTP id l16mr784375wmi.21.1640146387572;
        Tue, 21 Dec 2021 20:13:07 -0800 (PST)
Received: from vm.nix.is (vm.nix.is. [2a01:4f8:120:2468::2])
        by smtp.gmail.com with ESMTPSA id b1sm749650wrd.92.2021.12.21.20.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Dec 2021 20:13:07 -0800 (PST)
From:   =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
To:     git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        John Cai <johncai86@gmail.com>,
        Sergey Organov <sorganov@gmail.com>,
        Jiang Xin <worldhello.net@gmail.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>
Subject: [PATCH v5 01/10] cat-file tests: test bad usage
Date:   Wed, 22 Dec 2021 05:12:54 +0100
Message-Id: <patch-v5-01.10-e771bd38792-20211222T041050Z-avarab@gmail.com>
X-Mailer: git-send-email 2.34.1.1146.gb52885e7c44
In-Reply-To: <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
References: <cover-v4-00.10-00000000000-20211208T123151Z-avarab@gmail.com> <cover-v5-00.10-00000000000-20211222T041050Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Stress test the usage emitted when options are combined in ways that
isn't supported. Let's test various option combinations, some of these
we buggily allow right now.

E.g. this reveals a bug in 321459439e1 (cat-file: support
--textconv/--filters in batch mode, 2016-09-09) that we'll fix in a
subsequent commit. We're supposed to be emitting a relevant message
when --batch-all-objects is combined with --textconv or --filters, but
we don't.

The cases of needing to assign to opt=2 in the "opt" loop are because
on those we do the right thing already, in subsequent commits the
"test_expect_failure" cases will be fixed, and the for-loops unified.

Signed-off-by: Ævar Arnfjörð Bjarmason <avarab@gmail.com>
---
 t/t1006-cat-file.sh | 94 +++++++++++++++++++++++++++++++++++++++++++++
 1 file changed, 94 insertions(+)

diff --git a/t/t1006-cat-file.sh b/t/t1006-cat-file.sh
index 0d4c55f74ec..8a29f96809d 100755
--- a/t/t1006-cat-file.sh
+++ b/t/t1006-cat-file.sh
@@ -4,6 +4,100 @@ test_description='git cat-file'
 
 . ./test-lib.sh
 
+test_cmdmode_usage () {
+	test_expect_code 129 "$@" 2>err &&
+	grep "^error:.*is incompatible with" err
+}
+
+for switches in \
+	'-e -p' \
+	'-p -t' \
+	'-t -s' \
+	'-s --textconv' \
+	'--textconv --filters'
+do
+	test_expect_success "usage: cmdmode $switches" '
+		test_cmdmode_usage git cat-file $switches
+	'
+done
+
+test_incompatible_usage () {
+	test_expect_code 129 "$@" 2>err &&
+	grep -E "^error:.**needs" err
+}
+
+for opt in --batch --batch-check
+do
+	test_expect_success "usage: incompatible options: --path with $opt" '
+		test_incompatible_usage git cat-file --path=foo $opt
+	'
+done
+
+short_modes="-e -p -t -s"
+cw_modes="--textconv --filters"
+
+for opt in $cw_modes
+do
+	test_expect_success "usage: $opt requires another option" '
+		test_expect_code 129 git cat-file $opt
+	'
+
+	test_expect_failure "usage: incompatible options: --batch-all-objects with $opt" '
+		test_incompatible_usage git cat-file --batch-all-objects $opt
+	'
+done
+
+for opt in $short_modes
+do
+	test_expect_success "usage: $opt requires another option" '
+		test_expect_code 129 git cat-file $opt
+	'
+
+	for opt2 in --batch \
+		--batch-check \
+		--follow-symlinks
+	do
+		test_expect_failure "usage: incompatible options: $opt and $opt2" '
+			test_incompatible_usage git cat-file $opt $opt2
+		'
+	done
+
+	opt2="--path=foo HEAD:some-path.txt"
+	test_expect_success "usage: incompatible options: $opt and $opt2" '
+		test_incompatible_usage git cat-file $opt $opt2
+	'
+done
+
+for opt in $short_modes $cw_modes
+do
+	args="one two three"
+	test_expect_success "usage: too many arguments: $opt $args" '
+		test_expect_code 129 git cat-file $opt $args
+	'
+
+	for opt2 in --buffer --follow-symlinks
+	do
+		test_expect_success "usage: incompatible arguments: $opt with batch option $opt2" '
+			test_expect_code 129 git cat-file $opt $opt2
+		'
+	done
+done
+
+for opt in --buffer \
+	--follow-symlinks \
+	--batch-all-objects
+do
+	status=success
+	if test $opt = "--buffer"
+	then
+		status=failure
+	fi
+	test_expect_$status "usage: bad option combination: $opt without batch mode" '
+		test_expect_code 129 git cat-file $opt &&
+		test_expect_code 129 git cat-file $opt commit HEAD
+	'
+done
+
 echo_without_newline () {
     printf '%s' "$*"
 }
-- 
2.34.1.1146.gb52885e7c44

