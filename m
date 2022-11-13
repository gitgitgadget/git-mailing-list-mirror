Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BE1A2C4332F
	for <git@archiver.kernel.org>; Sun, 13 Nov 2022 21:29:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234149AbiKMV3T (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 13 Nov 2022 16:29:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235482AbiKMV3I (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 Nov 2022 16:29:08 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36E4EDEC6
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 13:29:06 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id i3so9339429pfc.11
        for <git@vger.kernel.org>; Sun, 13 Nov 2022 13:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bUcvnsDHdg+ilZcYaBYTYakIkceiUTnGV3Kd9QPe5Hs=;
        b=dGlEFmJ0JwNVqgPOv5ZJIiuQUH8cuQyjdV/QgItVy+vaOWlKtTEfEDmjYDl+jXOj9N
         RSFhJSz4Q73VCiQ4qEIfNtAMVgRN77M7FLkpvagmaSW+2q5VVBy4+LEltsU0Ik47khX+
         suRbZn6dXUSTqjzxIUADdJ1Y6kynH4PKtji1HnJ62bGj9Zc1d0eEYIRnDwYiTTkPDuEY
         xBufta4TRtA6jnf51/fXbzxJWPHeHEFdIiMPbzo6n9Q3Ts7Vnfv8hzhdWFXWYvMsqOlL
         qr0Is2SpDgt8zgysYVi6MaB22TU90ANLfHlxmBmcCrXoLc6zU3taY8rxLz81W7A1dHjY
         7FKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bUcvnsDHdg+ilZcYaBYTYakIkceiUTnGV3Kd9QPe5Hs=;
        b=Zr7mucgDj6B+Zyw1YZk9f2JSVRWTUhM+BDolWQoVEF4Z/Z26qTW6i+dju65W29lOg/
         vlSo01lrqfOA0UoToi8ugTf47xqbu1sAwoKXhgo+hcNkrdCa2C9VTncrk7T0ezEDWs3G
         dvBKFfSPMCfFqC8jOO8fvUm2QXxBGNPkhe67OOI/MDkSdhSHoaleApWNfQBO9cEByPtM
         6NycJImxeOVxwhi3QjEHIqrCfP4m6Z/ooJkt7QZ6irtkBIgHVdkT5oKE+LFCR+8j8Tgf
         190wnBLcWy9aiIpXc+fYMSUl45TfZV/WErZ5IAiFekophVzBzCBQb/mPFsdZ63hKSLnz
         TaDA==
X-Gm-Message-State: ANoB5plu3fb+7P6a2WX8pdsPyAXjHByGeMnqwpY0arNr+70fk0xQ4fJ2
        bKamOTmqePVQUBe4j0O6WB68m376xz4REfWR
X-Google-Smtp-Source: AA0mqf5xDXbWUfmBIpvWzPr2qwpHxszXaZldj9q51Da1J996TyGO3yvpiK6p8vHCxgu0ge4iJNLTBw==
X-Received: by 2002:a65:5a02:0:b0:449:8676:833f with SMTP id y2-20020a655a02000000b004498676833fmr9364204pgs.126.1668374944987;
        Sun, 13 Nov 2022 13:29:04 -0800 (PST)
Received: from HB2.. ([2409:4043:4c81:51c0:8e7b:5efe:71ba:3c2f])
        by smtp.gmail.com with ESMTPSA id 79-20020a621552000000b0056c704abca7sm5116337pfv.220.2022.11.13.13.29.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Nov 2022 13:29:04 -0800 (PST)
From:   Siddharth Asthana <siddharthasthana31@gmail.com>
To:     git@vger.kernel.org
Cc:     christian.couder@gmail.com, gitster@pobox.com, johncai86@gmail.com,
        Johannes.Schindelin@gmx.de, avarab@gmail.com, me@ttaylorr.com,
        Siddharth Asthana <siddharthasthana31@gmail.com>
Subject: [PATCH v4 3/3] doc/cat-file: allow --use-mailmap for --batch options
Date:   Mon, 14 Nov 2022 02:58:30 +0530
Message-Id: <20221113212830.92609-4-siddharthasthana31@gmail.com>
X-Mailer: git-send-email 2.38.1.423.g41b4650b24
In-Reply-To: <20221113212830.92609-1-siddharthasthana31@gmail.com>
References: <20220916205946.178925-1-siddharthasthana31@gmail.com>
 <20221113212830.92609-1-siddharthasthana31@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The command git cat-file can now use the mailmap mechanism to replace
idents with their canonical versions for commit and tag objects. There
are several options like `-s`, `--batch`, `--batch-check` and
`--batch-command` that can be combined with `--use-mailmap`. But the
documentation for `-s`, `--batch`, `--batch-check` and `--batch-command`
doesn't say so. This patch fixes that documentation.

Mentored-by: Christian Couder <christian.couder@gmail.com>
Mentored-by: John Cai <johncai86@gmail.com>
Helped-by: Taylor Blau <me@ttaylorr.com>
Signed-off-by: Siddharth Asthana <siddharthasthana31@gmail.com>
---
 Documentation/git-cat-file.txt | 53 +++++++++++++++++++++++++---------
 1 file changed, 39 insertions(+), 14 deletions(-)

diff --git a/Documentation/git-cat-file.txt b/Documentation/git-cat-file.txt
index ec30b5c574..81235c60a3 100644
--- a/Documentation/git-cat-file.txt
+++ b/Documentation/git-cat-file.txt
@@ -45,7 +45,9 @@ OPTIONS
 
 -s::
 	Instead of the content, show the object size identified by
-	`<object>`.
+	`<object>`. If used with `--use-mailmap` option, will show
+	the size of updated object after replacing idents using the
+	mailmap mechanism.
 
 -e::
 	Exit with zero status if `<object>` exists and is a valid
@@ -89,26 +91,49 @@ OPTIONS
 --batch::
 --batch=<format>::
 	Print object information and contents for each object provided
-	on stdin.  May not be combined with any other options or arguments
-	except `--textconv` or `--filters`, in which case the input lines
-	also need to specify the path, separated by whitespace.  See the
-	section `BATCH OUTPUT` below for details.
+	on stdin. May not be combined with any other options or arguments
+	except --textconv, --filters, or --use-mailmap.
+	+
+	* When used with `--textconv` or `--filters`, the input lines
+	  must specify the path, separated by whitespace. See the section
+	  `BATCH OUTPUT` below for details.
+	+
+	* When used with `--use-mailmap`, for commit and tag objects, the
+	  contents part of the output shows the identities replaced using the
+	  mailmap mechanism, while the information part of the output shows
+	  the size of the object as if it actually recorded the replacement
+	  identities.
 
 --batch-check::
 --batch-check=<format>::
-	Print object information for each object provided on stdin.  May
-	not be combined with any other options or arguments except
-	`--textconv` or `--filters`, in which case the input lines also
-	need to specify the path, separated by whitespace.  See the
-	section `BATCH OUTPUT` below for details.
+	Print object information for each object provided on stdin. May not be
+	combined with any other options or arguments except --textconv, --filters
+	or --use-mailmap.
+	+
+	* When used with `--textconv` or `--filters`, the input lines must
+	 specify the path, separated by whitespace. See the section
+	 `BATCH OUTPUT` below for details.
+	+
+	* When used with `--use-mailmap`, for commit and tag objects, the
+	  printed object information shows the size of the object as if the
+	  identities recorded in it were replaced by the mailmap mechanism.
 
 --batch-command::
 --batch-command=<format>::
 	Enter a command mode that reads commands and arguments from stdin. May
-	only be combined with `--buffer`, `--textconv` or `--filters`. In the
-	case of `--textconv` or `--filters`, the input lines also need to specify
-	the path, separated by whitespace. See the section `BATCH OUTPUT` below
-	for details.
+	only be combined with `--buffer`, `--textconv`, `--use-mailmap` or
+	`--filters`.
+	+
+	* When used with `--textconv` or `--filters`, the input lines must
+	  specify the path, separated by whitespace. See the section
+	  `BATCH OUTPUT` below for details.
+	+
+	* When used with `--use-mailmap`, for commit and tag objects, the
+	  `contents` command shows the identities replaced using the
+	  mailmap mechanism, while the `info` command shows the size
+	  of the object as if it actually recorded the replacement
+	  identities.
+
 +
 `--batch-command` recognizes the following commands:
 +
-- 
2.38.1.420.g319605f8f0

