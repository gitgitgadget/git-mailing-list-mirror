Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C162A1F97E
	for <e@80x24.org>; Sun, 25 Nov 2018 11:07:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726127AbeKYV6B (ORCPT <rfc822;e@80x24.org>);
        Sun, 25 Nov 2018 16:58:01 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:35674 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbeKYV6B (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Nov 2018 16:58:01 -0500
Received: by mail-pf1-f196.google.com with SMTP id z9so5198703pfi.2
        for <git@vger.kernel.org>; Sun, 25 Nov 2018 03:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:in-reply-to:references:mime-version
         :content-transfer-encoding;
        bh=W+N/7M/qrttJpgRBvHq09c/MW/yd/M5B1fZ8FRHwAJU=;
        b=O1OwBdy1f5TTOtP5r1CChrERjJwnEi60ByOkLrdbbfICc0sUpWot8wMg961kKO23mA
         6mHTDnyOLUypufOfq0B+tPV+ZnzOmK5NzrjYGcyFQ2k6ydrASWajw19hK/TUJ7rKGVaG
         NO03Chgu9VbINap9jNK+y8g6uGmZtM7e8HGipjlwbTDTIiOBvJDrvqZrugfUl3Pi9z6f
         mY9mU92/kknkItmw1fPvUtgu+Q7OYo0x7+sN/xjCxWeFsKYD7rEie4cDX/DDX5mvmFQD
         Swgwbl02eqadgIIq3k8lt5MWNlbqXLTSVZLxGTkranx2jkY0Umg6C6vCj9aFaf84PYjF
         KoYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=W+N/7M/qrttJpgRBvHq09c/MW/yd/M5B1fZ8FRHwAJU=;
        b=mbY8po/gDll24ExkYeIAOd8ut3RMI7H1TqhbAHhSVl62fn34uJKIia6IHwqeDWnx52
         3+kb1KrtSxA3T45cn8mvuv2bCeLXw0eXtS1EwO+y5NxL3wrDIRWaamYNPJpehmch8mrj
         fkVRb8NwlND/Gkc6/P0bhDNJWZNpoWQ9ApGPify93ANVyWDDDdzrv/ZDrKr08PUGghey
         Rf+3loMlwmAtvGrddR3HaD6ysUyqdypHHtxdmn3uyXpJi3JKqzxtcpQ2XGPZ922H6Mkm
         Yp4LC7gYYwVQTtvZPE934h57qNsFjenoBun01iIZHUWj2x0xc8ejxOk5s5uviuFKEL0f
         mLQQ==
X-Gm-Message-State: AGRZ1gKknGi8LCtcVFAFL0u3Mwdr73TZNAJPz4ukM/sfIdZiv11cNVdF
        jRcGnVeSgU042CGsUlNw0908nK7j
X-Google-Smtp-Source: AJdET5dqOCRk+yl0DvoKtrDnIVjlwASEKvHinlH0JjG+kb5POTrqzg28QxO0trL3MxhpLrU+X4oEIQ==
X-Received: by 2002:a62:3647:: with SMTP id d68-v6mr23449142pfa.66.1543144031276;
        Sun, 25 Nov 2018 03:07:11 -0800 (PST)
Received: from localhost.localdomain ([136.179.21.64])
        by smtp.gmail.com with ESMTPSA id h15sm21154301pgl.43.2018.11.25.03.07.10
        for <git@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 25 Nov 2018 03:07:11 -0800 (PST)
From:   =?UTF-8?q?Carlo=20Marcelo=20Arenas=20Bel=C3=B3n?= 
        <carenas@gmail.com>
To:     git@vger.kernel.org
Subject: [RFC PATCH 6/7] t5004: use GNU tar to avoid known issues with BSD tar
Date:   Sun, 25 Nov 2018 03:06:49 -0800
Message-Id: <48f223add200dfcf02f280fcc577cc94255820ce.1543143503.git.carenas@gmail.com>
X-Mailer: git-send-email 2.20.0.rc1
In-Reply-To: <cover.1543143503.git.carenas@gmail.com>
References: <cover.1543143503.git.carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

56ee96572a ("t5004: resurrect original empty tar archive test", 2013-05-09)
added a test to try to detect and workaround issues with the standard tar
from BSD, but at least in NetBSD would be better to instead require GNU tar
which is available from pkgsrc

Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
---
 t/t5004-archive-corner-cases.sh | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/t/t5004-archive-corner-cases.sh b/t/t5004-archive-corner-cases.sh
index ced44355ca..baafc553f8 100755
--- a/t/t5004-archive-corner-cases.sh
+++ b/t/t5004-archive-corner-cases.sh
@@ -31,6 +31,8 @@ test_lazy_prereq UNZIP_ZIP64_SUPPORT '
 	"$GIT_UNZIP" -v | grep ZIP64_SUPPORT
 '
 
+test $uname_s = NetBSD && TAR="gtar"
+
 # bsdtar/libarchive versions before 3.1.3 consider a tar file with a
 # global pax header that is not followed by a file record as corrupt.
 if "$TAR" tf "$TEST_DIRECTORY"/t5004/empty-with-pax-header.tar >/dev/null 2>&1
-- 
2.20.0.rc1

