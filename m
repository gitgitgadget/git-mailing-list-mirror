Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4ADFC433FE
	for <git@archiver.kernel.org>; Wed, 23 Nov 2022 15:03:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238191AbiKWPDb (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 23 Nov 2022 10:03:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238200AbiKWPDH (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 23 Nov 2022 10:03:07 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9906A5E3C6
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 07:02:40 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id t17so15416685pjo.3
        for <git@vger.kernel.org>; Wed, 23 Nov 2022 07:02:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gMXvPv4HoZ9tzeFV9f/URkCwEVLLDpFLgZLYN1Uf13U=;
        b=UB4GlKnGQ8ezci++yBgLDg0QsrW2orHqXYWW3uqPAjfE7LOV1L07wl1gLF+lSKbI7V
         5FMNUsRBkRFPRnhBQT0PkwNGysJYBIhdT8kRj5TmwscRHNxTlPtZ4oQnjq3kzlG4MMAu
         hc1vWisKIv9VH3V0WbtF9HOG7snY83P282fR2NIac/LB0CYFCk+F2Y4jlIzbGfv8dj44
         08J/RXHIu3pH0rPkihyweimJAgx1dx9ngV12VODdsonHPRMgaSYICrxHE9XV7aZKaf/i
         go7L6/k4p/FSwZWwkC0EI+fb5edj3Hg5Ll9SXFPju7MWpxCEEjNjODTsV1a18LDhzoz4
         GdDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gMXvPv4HoZ9tzeFV9f/URkCwEVLLDpFLgZLYN1Uf13U=;
        b=1sme+cTZfR95Yv3AmY928fdAZqTPE4/PA7mK7DiC0x55u1GnGRg9ffb68MEm2iWKa3
         1WHl9EIQ4jaoE/B4ZVwKLBx+MY+5Bz1TH7XxC/H3VLDDdqZoQCPj8K+S0n+9DQKvHojP
         G2MUIK2Rm+bikzd4eWpJ+G+mCPw4jaShOwhyzcHx/Dv1CsEWA7QpggPfWYZ85dRXBKzE
         h16LunzJrM6OeTKD5FZ8FvFtosQHRNg60T0qjFcbQwZ+O8u1Uj0NPttmnUd2ck4yjZ3e
         kiF4U8b6MoeYy4ApQfqvRGl9LfpmbrhdmV1TCK87cc1O3yPQGDIx7IZCAmTNDHQr/DHI
         L8nw==
X-Gm-Message-State: ANoB5pmoD1EwfDL1D22RTC9Mbnih6cVM6mJ/YYO9n72uKM7zFtwWP5iQ
        9ohaXPU/hL9kRcZoNOQEcjCXIFhU9JA=
X-Google-Smtp-Source: AA0mqf6btCbZzI60PEPcz5bn9CZ1vo4N3Si6Qso5PGu2v3dmrFHhxpcYskkAybZWdJ2ZK+Mm4+ZeEQ==
X-Received: by 2002:a17:902:7881:b0:185:5537:f399 with SMTP id q1-20020a170902788100b001855537f399mr13643738pll.39.1669215758824;
        Wed, 23 Nov 2022 07:02:38 -0800 (PST)
Received: from tigtog-proxy.localdomain.localdomain (144.34.163.219.16clouds.com. [144.34.163.219])
        by smtp.gmail.com with ESMTPSA id y185-20020a6232c2000000b0056ddd2b5e9bsm12783263pfy.41.2022.11.23.07.02.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 23 Nov 2022 07:02:38 -0800 (PST)
From:   Jiang Xin <worldhello.net@gmail.com>
To:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Cc:     Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Jiang Xin <worldhello.net@gmail.com>
Subject: [PATCH 2/2] ci: upgrade version of p4
Date:   Wed, 23 Nov 2022 23:02:33 +0800
Message-Id: <20221123150233.13039-3-worldhello.net@gmail.com>
X-Mailer: git-send-email 2.32.0.rc3
In-Reply-To: <20221123150233.13039-1-worldhello.net@gmail.com>
References: <20221123150233.13039-1-worldhello.net@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Jiang Xin <zhiyou.jx@alibaba-inc.com>

There would be a segmentation fault when running p4 v16.2 on ubuntu
22.04 which is the latest version of ubuntu runner image for github
actions. Upgrade p4 from version 16.2 to 19.2 will fix this issue.

Also add some instructions to show errors of command "p4 -V", so we can
see why the output doesn't match.

Signed-off-by: Jiang Xin <zhiyou.jx@alibaba-inc.com>
---
 ci/install-dependencies.sh | 4 ++--
 ci/lib.sh                  | 2 +-
 2 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/ci/install-dependencies.sh b/ci/install-dependencies.sh
index f639263a62..291e49bdde 100755
--- a/ci/install-dependencies.sh
+++ b/ci/install-dependencies.sh
@@ -83,9 +83,9 @@ esac
 if type p4d >/dev/null 2>&1 && type p4 >/dev/null 2>&1
 then
 	echo "$(tput setaf 6)Perforce Server Version$(tput sgr0)"
-	p4d -V | grep Rev.
+	p4d -V | grep Rev. || { echo >&2 "p4d: bad version"; p4d -V; exit 1; }
 	echo "$(tput setaf 6)Perforce Client Version$(tput sgr0)"
-	p4 -V | grep Rev.
+	p4 -V | grep Rev. || { echo >&2 "p4: bad version"; p4 -V; exit 1; }
 else
 	echo >&2 "WARNING: perforce wasn't installed, see above for clues why"
 fi
diff --git a/ci/lib.sh b/ci/lib.sh
index 0c0767d354..8474b0f249 100755
--- a/ci/lib.sh
+++ b/ci/lib.sh
@@ -246,7 +246,7 @@ ubuntu)
 	# were recorded in the Homebrew database upon creating the OS X
 	# image.
 	# Keep that in mind when you encounter a broken OS X build!
-	export LINUX_P4_VERSION="16.2"
+	export LINUX_P4_VERSION="19.2"
 	export LINUX_GIT_LFS_VERSION="1.5.2"
 
 	P4_PATH="$HOME/custom/p4"
-- 
2.39.0.rc0

