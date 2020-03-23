Return-Path: <SRS0=3T2S=5I=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC962C54FD0
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 13:10:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 834262072D
	for <git@archiver.kernel.org>; Mon, 23 Mar 2020 13:10:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sOBHbLwU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728474AbgCWNJ4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 09:09:56 -0400
Received: from mail-ed1-f47.google.com ([209.85.208.47]:43866 "EHLO
        mail-ed1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728454AbgCWNJz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 09:09:55 -0400
Received: by mail-ed1-f47.google.com with SMTP id bd14so2231117edb.10
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 06:09:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=message-id:in-reply-to:references:from:date:subject:fcc
         :content-transfer-encoding:mime-version:to:cc;
        bh=d+CdihV/MaXlOsmdA1HIYg2dPk7X4+olTFP2vNVSVCU=;
        b=sOBHbLwUc5Nufz9+xSurAFofCBJDGhrivljevKDLIKXpCfUbqY3NU3oo1pEQwx7Bkq
         JeWSbQNyiV8XI6Zkrk2URqOE2xBdYSbi6fbo9GnI7uBmQeKGPxl1zjTLXuhJmbissSAh
         /auvoQSkBSc/WgE6iQwU+xSpN+PCUuVhr7X0Q9tE+ydl9uKtRF9baAcWktfTVC8ays3C
         CP/ZoqNnwFtjElMrYoWfWO9SHORb+yjK2Z2QepYl51iI8nO1B6s44q07AoAE3e7R0jwV
         wF1w8spCrh16vcSuTinkyojEagPKRZDB1A+XBaXiw0+19OxFl9nCpcDGZmtmEuDCyPyt
         ogrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:message-id:in-reply-to:references:from:date
         :subject:fcc:content-transfer-encoding:mime-version:to:cc;
        bh=d+CdihV/MaXlOsmdA1HIYg2dPk7X4+olTFP2vNVSVCU=;
        b=Pw+pLEpzKGaPaVYHX1NB5ZB6wd0b5ZXZoYKPzAcUWgsmJK/FrZ6wVC1E87Mn1ky9Dw
         P0vUYlwdDG6FHV4g9emEmW8WSaI9jo1+Kqbv9u4n9BoVrrNxQOMMdBk2qO1VMXYPcnkl
         SQQ794Uba8sfw6/P7EBJffmFeedeiXy+x6rIbW2SPyZ0ETEiOk7MibjaBwtQ7WI4zBBf
         d19t2juVJDgTtGG+/dcNZwa4PvYLXCdwKWTlxVMsPeA6oKd+c4RhX+K1t61x+s4L9gvG
         QNSclebVqpslIA7iygM6W47GwnUojhbrFPrHTmng0O/i0e5P+l/4D81UbIfYai0T2Zw1
         vKfA==
X-Gm-Message-State: ANhLgQ1MtmVp1dqZMHhFGFDDwa7u+rExqPCfxMrcWUDJUI5oBz9HRpCA
        ZrxYiS9fbmuWtGoGHcp8MDyn2rkn
X-Google-Smtp-Source: ADFU+vvt+KHNpGKAYwY2nV19cAgl/J7ROyzRY2D+YXfLZ+u+iZypP63LdoFo/1jzmuL+8A3bxAojQQ==
X-Received: by 2002:a17:906:259:: with SMTP id 25mr1319841ejl.105.1584968992548;
        Mon, 23 Mar 2020 06:09:52 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id rl28sm881983ejb.28.2020.03.23.06.09.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2020 06:09:52 -0700 (PDT)
Message-Id: <287a21f1033b2a74420029c529ad4db956051a85.1584968990.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
References: <pull.728.git.git.1584968990.gitgitgadget@gmail.com>
From:   "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Mon, 23 Mar 2020 13:09:49 +0000
Subject: [PATCH 1/2] tests(gpg): allow the gpg-agent to start on Windows
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In Git for Windows' SDK, we use the MSYS2 version of OpenSSH, meaning
that the `gpg-agent` will fail horribly when being passed a `--homedir`
that contains colons.

Previously, we did pass the Windows version of the absolute path,
though, which starts in the drive letter followed by, you guessed it, a
colon.

Let's use the same trick found elsewhere in our test suite where `$PWD`
is used to refer to the pseudo-Unix path (which works only within the
MSYS2 Bash/OpenSSH/Perl/etc, as opposed to `$(pwd)` which refers to the
Windows path that `git.exe` understands, too).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/lib-gpg.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/t/lib-gpg.sh b/t/lib-gpg.sh
index 8d28652b729..11b83b8c24a 100755
--- a/t/lib-gpg.sh
+++ b/t/lib-gpg.sh
@@ -29,7 +29,7 @@ then
 		#		> lib-gpg/ownertrust
 		mkdir ./gpghome &&
 		chmod 0700 ./gpghome &&
-		GNUPGHOME="$(pwd)/gpghome" &&
+		GNUPGHOME="$PWD/gpghome" &&
 		export GNUPGHOME &&
 		(gpgconf --kill gpg-agent >/dev/null 2>&1 || : ) &&
 		gpg --homedir "${GNUPGHOME}" 2>/dev/null --import \
-- 
gitgitgadget

