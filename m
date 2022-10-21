Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75DBDC43219
	for <git@archiver.kernel.org>; Fri, 21 Oct 2022 15:14:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiJUPOF (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Oct 2022 11:14:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230093AbiJUPNr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Oct 2022 11:13:47 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED22124A575
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:13:45 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id a3so5467224wrt.0
        for <git@vger.kernel.org>; Fri, 21 Oct 2022 08:13:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pKtxY62K0AkC/Kytym1KJ2VlVW72vK4Z2r9tgOTQi+o=;
        b=mza6cSF8sFMKwOsXq/1ydKzNlGORjHV4tZrcnPeB4ESlwIMDgZI2FQikoe+pPpasb9
         bcSFX74keATIjuI3EzJieheoKoRW4wFzp/ZEv3nhZqU7Ga0gglsb+4Ovw182g+dVqThT
         F7Uqxl2fhKPAn5IJOKNhPwNPMt6gL8Llh7S6vDAoxMqjjv6vW0IzNu2UB+UUH3NQmTy7
         uHkuJRFlilr07xIM8QhDmxDSf3/9MRurGSquxcOb5q3Nd7UAc0XL1v6mWeWuRgoy36of
         B7pca1QC+UJnb05CCOoM1yuKg8b5z0gX4YiRJAQndKRYcOflmNoZ1pA4FA1w5t9f4C3G
         HOpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pKtxY62K0AkC/Kytym1KJ2VlVW72vK4Z2r9tgOTQi+o=;
        b=XrXlqnuC2LLDyWmalVt+cz2upZJNUMtMbPyJhiOz0VTG+hXE61YoTsb6jhvod8/NWg
         4nWu6buRibslVCzFFYRNT5lTqZsVoMvLDcE4wG7R910LlZ2FAxVuz5ipBVQ+ObeVnumG
         /sgurMuo3l2v1IcT2ttXhRWlEb98fJ5PMLctTldVIJrfithQvhppXCbcxN9mCEEnWvFq
         Sjvc5odN8cCTGheMzWDVAhwUDkXS91LOCMieQMcKs+d6alHXFlULqeVO9i44WGqUxZLe
         jHeX0v65btWnmX4uIfP5VmiKqExAvJ6g1eWTGEe5fPw00oX2dPn3SpC58nKznf5HC0fL
         CsxA==
X-Gm-Message-State: ACrzQf1f0Xq/60znyyvcZYZGbjNqunPRX2GU7eQgJcmw9R8VBt25FVjO
        BOJ9cYc4/2/OS/h/XGIi9YSuUX130FQ=
X-Google-Smtp-Source: AMsMyM4SgRFwm3bFemcBWUu7LxmFx0mz+PF3KX8kXYbYAFTpeNc50AT3JF1qkmIfCvoWcwNYSGYLng==
X-Received: by 2002:a5d:4c43:0:b0:236:547f:bd3c with SMTP id n3-20020a5d4c43000000b00236547fbd3cmr2491814wrt.380.1666365224315;
        Fri, 21 Oct 2022 08:13:44 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id v1-20020adfedc1000000b00228daaa84aesm19483926wro.25.2022.10.21.08.13.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Oct 2022 08:13:43 -0700 (PDT)
Message-Id: <832e910aadc47309392feed69927c2e8693cbfc5.1666365220.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
References: <pull.1390.git.1666365219.gitgitgadget@gmail.com>
From:   "Philippe Blain via GitGitGadget" <gitgitgadget@gmail.com>
Date:   Fri, 21 Oct 2022 15:13:31 +0000
Subject: [PATCH 1/9] test-lib-functions: mark 'test_commit' variables as
 'local'
Fcc:    Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
To:     git@vger.kernel.org
Cc:     Luke Shumaker <lukeshu@datawire.io>,
        Thomas Koutcher <thomas.koutcher@online.fr>,
        James Limbouris <james@digitalmatter.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>,
        Philippe Blain <levraiphilippeblain@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Philippe Blain <levraiphilippeblain@gmail.com>

Some variables in 'test_commit' have names that are common enough that
it is very likely that test authors might use them in a test. If they do
so and use 'test_commit' between setting such a variable and using it,
the variable value from 'test_commit' will leak back into the test and
most likely break it.

Prevent that by marking all variables in 'test_commit' as 'local'. This
allow a subsequent commit to use a 'tag' variable.

Signed-off-by: Philippe Blain <levraiphilippeblain@gmail.com>
---
 t/test-lib-functions.sh | 16 ++++++++--------
 1 file changed, 8 insertions(+), 8 deletions(-)

diff --git a/t/test-lib-functions.sh b/t/test-lib-functions.sh
index 527a7145000..adc0fb6330c 100644
--- a/t/test-lib-functions.sh
+++ b/t/test-lib-functions.sh
@@ -273,13 +273,13 @@ debug () {
 # <file>, <contents>, and <tag> all default to <message>.
 
 test_commit () {
-	notick= &&
-	echo=echo &&
-	append= &&
-	author= &&
-	signoff= &&
-	indir= &&
-	tag=light &&
+	local notick= &&
+	local echo=echo &&
+	local append= &&
+	local author= &&
+	local signoff= &&
+	local indir= &&
+	local tag=light &&
 	while test $# != 0
 	do
 		case "$1" in
@@ -322,7 +322,7 @@ test_commit () {
 		shift
 	done &&
 	indir=${indir:+"$indir"/} &&
-	file=${2:-"$1.t"} &&
+	local file=${2:-"$1.t"} &&
 	if test -n "$append"
 	then
 		$echo "${3-$1}" >>"$indir$file"
-- 
gitgitgadget

