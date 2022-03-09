Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 49FDAC433F5
	for <git@archiver.kernel.org>; Wed,  9 Mar 2022 12:35:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbiCIMgN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 9 Mar 2022 07:36:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33830 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229981AbiCIMgM (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 9 Mar 2022 07:36:12 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 211E4172E79
        for <git@vger.kernel.org>; Wed,  9 Mar 2022 04:35:12 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id d17so2160849pfv.6
        for <git@vger.kernel.org>; Wed, 09 Mar 2022 04:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=23ZOV+N82wm55qJMXMt7o/0RHo414mxc/dVh8rJn5+k=;
        b=GK/IcHyXXUtXvzuIxTO6MMqa5cKQDTRj26+jqIecI0a345qW4xrgUsND+SEU0jWxRr
         pCyIYXDlYIxblQIbtAjNvzJkz2td7HCYRMBu9ZzyM3hC//sglCd5Iduj81z/lmw6gj6R
         TJUzd3303QbhbBa06zTFfmyoi3vmDXrmEVoTXo1y+Ciunl+/2dkPsSLzDz2pY+J5E1ze
         ZoJKc141BWo9QH+yS8+MWV6S1Byxm6dlzvJVoIIGqIqKBB9WnSBlLozlCtN2ILIVtD9X
         BeaHnsVJw6zb5gItki6SQjQflRD3hrqPJUVk1z/Ghs60wvb0vL/tp7wvkD9yLQL/pM5H
         bu7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=23ZOV+N82wm55qJMXMt7o/0RHo414mxc/dVh8rJn5+k=;
        b=Y6vyRdHl2z/m5OhMypDQdDjUJh/JTdInFmYshb4pXuAaqfMunzohLU0g4tTXa6gvlQ
         jXATQp1fuvWH7mR0kKF4R21RL7SiBthluWfSYks72zvTeI/+XXWyJyl8qRYuO5k5lLQS
         KguW6H0Wcplci74tpPnOGikfNNUz7jDVLx+yI0PH+HiMFeQ8NXzipgDpnT23tG7NWRMA
         V+wvq13M0Rioa2HXHmj88wmNYUNKU8/XdV05h/RBfRVUG48J4WaJtoVTAGLNWuHyId+K
         zq+LiCXe1f7gbX5wmTAaURns+ix4xyk+H8QBgBxVKHsNC0zbWdiYP+ROhayWq+Jg6p/E
         QOVw==
X-Gm-Message-State: AOAM532Vf+Kk1naSyvObisDhLIZViSLmLFNoPJxrYiubu/EDOkjc1kFT
        V4nt+AN1WpGP82YvtXTCvr/VbEbkOKY=
X-Google-Smtp-Source: ABdhPJwP185FW1yrc1d/8mgyJZ0hVHNCSnANuvm9PWTGGqmMHy3IxwHkmv8OMhVBvv6cNvfKmJLu1w==
X-Received: by 2002:a05:6a00:1ac8:b0:4f7:55ba:95ef with SMTP id f8-20020a056a001ac800b004f755ba95efmr3048716pfv.75.1646829311258;
        Wed, 09 Mar 2022 04:35:11 -0800 (PST)
Received: from ubuntu.mate (subs02-180-214-232-94.three.co.id. [180.214.232.94])
        by smtp.gmail.com with ESMTPSA id l17-20020a637011000000b0037d5eac87e3sm2259005pgc.18.2022.03.09.04.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Mar 2022 04:35:10 -0800 (PST)
From:   Bagas Sanjaya <bagasdotme@gmail.com>
To:     git@vger.kernel.org
Cc:     Taylor Blau <me@ttaylorr.com>,
        =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
        <avarab@gmail.com>, Bagas Sanjaya <bagasdotme@gmail.com>
Subject: [PATCH] repack: Sync list of options between synopsis and description in the documentation
Date:   Wed,  9 Mar 2022 19:34:47 +0700
Message-Id: <20220309123447.852883-1-bagasdotme@gmail.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Options list in the synopsis and description section of git-repack(1)
are out of sync. The latest addition was in commit 1d89d88d37
(builtin/repack.c: support writing a MIDX while repacking, 2021-09-28),
which only adds -m/--write-midx option.

Add missing options to the synopsis. Additionaly, sort according to the
order they appear in the description.

Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
---
 Documentation/git-repack.txt | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index ee30edc178..26e997bde1 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,13 @@ git-repack - Pack unpacked objects in a repository
 SYNOPSIS
 --------
 [verse]
-'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>] [--write-midx]
+'git repack' [-a] [-A] [-d] [-l] [-f] [-F] [-q | --quiet] [-n] [--window=<n>]
+	     [--depth=<n>] [--threads=<n>] [--window-memory=<n>]
+	     [--max-pack-size=<n>] [-b | --write-bitmap-index]
+	     [--pack-kept-objects] [--keep-pack=<pack-name>]
+	     [--unpack-unreachable=<when>] [-k | --keep-unreachable]
+	     [-i | --delta-islands] [-g | --geometric <factor>]
+	     [-m | --write-midx]
 
 DESCRIPTION
 -----------

base-commit: c2162907e9aa884bdb70208389cb99b181620d51
-- 
An old man doll... just what I always wanted! - Clara

