Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68638C433FE
	for <git@archiver.kernel.org>; Fri,  8 Apr 2022 04:54:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234361AbiDHE4I (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 8 Apr 2022 00:56:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiDHE4G (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 8 Apr 2022 00:56:06 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C26152B34
        for <git@vger.kernel.org>; Thu,  7 Apr 2022 21:54:04 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id b16so9376201ioz.3
        for <git@vger.kernel.org>; Thu, 07 Apr 2022 21:54:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=krlpQJAT0KN+Sn0OtEsPo3Sz9gXvV1hAXAxd1UQBSzk=;
        b=m+X9MSWjGqfTFpcMH8r1dUOL3zf7O/qkVoYT/cIrE8cXhdyiXbq7NAxJI5Mfl0Lg46
         7f0T/4qMBGAJ8FltCbPgFrl15c1LKFck2lo0KSgSTLsfFyiZdjkUtDgAbcQxdRJAmw/z
         8D9iwcSj/kZS7QawUEC3pVoGab+4Ncr2aUPj/QV/4+Zc2iCtAMQ+Fg6I2fqDnmswv97m
         IK7oF9W54EhqOnAthpIm/wFBcG/+PaLKSCs5V/uCe5KG6IUTFeLAQNrM9cLb6q1fUvdN
         r2m56TFgIheNtMDBmnjMNhUrwU7zDfSUYZiPQUMj5EAgHLddAXQMalhKBXpFYbDM/yJY
         GYLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=krlpQJAT0KN+Sn0OtEsPo3Sz9gXvV1hAXAxd1UQBSzk=;
        b=hVOmgeyNLGo7GpS6ULkEbhPQ3XvTc3T/pHVkgzqiMJiCc8pSN9UPa5m/YkTu+EU3jy
         XMPF+BInfkCFlsCCS5BofT+UfJB0L+VlYvg08k3ZtEQ12MXqcbs+oGWvDjV5q+7wPDYJ
         cZOjr0anUhK65HBDr2b+SjFd+uxPRZJSS3o1dLf/yrmRg/Sbuq5W5daHVffjR/xyx+Go
         7YEggYa6BzslCHu5JxY7l9WzjM1jxt8q6upRxGc7q3MjdAF+ZaS+Eyq2vE/fIlgNQVox
         0GsGvPOVJR1Q5WBqSQe5UZUVN7b2ie61IOJMLQFfc4h7uH1o2amlHTBSzUILuUBQebti
         1eCw==
X-Gm-Message-State: AOAM5323H25+Qg0QhcKMQCdMr9xNQSKaTnJfuYxbku3d88wbbSwy3YkW
        KWp7qZYBmrqwTUf/v2FTArj0QQKbDYk=
X-Google-Smtp-Source: ABdhPJwov30zk5kC6BIreC5xZ3QuzNkwyDTFP9x7wEJL5iIK7JhzudVnp4UnZkLS2yVfawfVq2hreA==
X-Received: by 2002:a02:5b85:0:b0:319:ff85:ff5 with SMTP id g127-20020a025b85000000b00319ff850ff5mr9188165jab.250.1649393641977;
        Thu, 07 Apr 2022 21:54:01 -0700 (PDT)
Received: from xavier.801labs.org (hackerspace.801labs.org. [63.228.208.98])
        by smtp.gmail.com with ESMTPSA id d15-20020a92d78f000000b002ca4c409d1asm7714295iln.83.2022.04.07.21.54.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Apr 2022 21:54:01 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, avarab@gmail.com, tao@klerks.biz,
        gitster@pobox.com, tboegi@web.de, prohaska@zib.de,
        eyvind.bernhardsen@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v3] convert: clarify line ending conversion warning
Date:   Thu,  7 Apr 2022 22:41:54 -0600
Message-Id: <20220408044154.9947-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220405053559.1072115-1-alexhenrie24@gmail.com>
References: <20220405053559.1072115-1-alexhenrie24@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The warning about converting line endings is extremely confusing. Its
two sentences each use the word "will" without specifying a timeframe,
which makes it sound like both sentences are referring to the same
timeframe. On top of that, it uses the term "original line endings"
without saying whether "original" means LF or CRLF.

Rephrase the warning to be clear about when the line endings will be
changed and what they will be changed to.

On a platform whose native line endings are not CRLF (e.g. Linux), the
"git add" step in the following sequence triggers the warning in
question:

$ git config core.autocrlf true
$ echo 'Hello world!' >hello.txt
$ git add hello.txt
warning: LF will be replaced by CRLF in hello.txt
The file will have its original line endings in your working directory

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
v3:
- Start the warning with a lowercase letter
- Add the phrase "the working copy of" - hopefully this resolves the
  last concerns about clarity
---
 convert.c            | 12 ++++++------
 t/t0027-auto-crlf.sh |  8 ++++----
 2 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/convert.c b/convert.c
index 8e39731efb..4d153729da 100644
--- a/convert.c
+++ b/convert.c
@@ -195,9 +195,9 @@ static void check_global_conv_flags_eol(const char *path,
 		if (conv_flags & CONV_EOL_RNDTRP_DIE)
 			die(_("CRLF would be replaced by LF in %s"), path);
 		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
-			warning(_("CRLF will be replaced by LF in %s.\n"
-				  "The file will have its original line"
-				  " endings in your working directory"), path);
+			warning(_("in the working copy of '%s', CRLF will be"
+				  " replaced by LF the next time Git touches"
+				  " it"), path);
 	} else if (old_stats->lonelf && !new_stats->lonelf ) {
 		/*
 		 * CRLFs would be added by checkout
@@ -205,9 +205,9 @@ static void check_global_conv_flags_eol(const char *path,
 		if (conv_flags & CONV_EOL_RNDTRP_DIE)
 			die(_("LF would be replaced by CRLF in %s"), path);
 		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
-			warning(_("LF will be replaced by CRLF in %s.\n"
-				  "The file will have its original line"
-				  " endings in your working directory"), path);
+			warning(_("in the working copy of '%s', LF will be"
+				  " replaced by CRLF the next time Git touches"
+				  " it"), path);
 	}
 }
 
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 0feb41a23f..7f80f46393 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -77,12 +77,12 @@ create_NNO_MIX_files () {
 
 check_warning () {
 	case "$1" in
-	LF_CRLF) echo "warning: LF will be replaced by CRLF" >"$2".expect ;;
-	CRLF_LF) echo "warning: CRLF will be replaced by LF" >"$2".expect ;;
-	'')	                                                 >"$2".expect ;;
+	LF_CRLF) echo "LF will be replaced by CRLF" >"$2".expect ;;
+	CRLF_LF) echo "CRLF will be replaced by LF" >"$2".expect ;;
+	'')	                                    >"$2".expect ;;
 	*) echo >&2 "Illegal 1": "$1" ; return false ;;
 	esac
-	grep "will be replaced by" "$2" | sed -e "s/\(.*\) in [^ ]*$/\1/" | uniq  >"$2".actual
+	sed -e "s/^.* \([^ ]* will be replaced by [^ ]*\) .*$/\1/" "$2" | uniq  >"$2".actual
 	test_cmp "$2".expect "$2".actual
 }
 
-- 
2.35.1

