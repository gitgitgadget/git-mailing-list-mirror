Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 16A97C433F5
	for <git@archiver.kernel.org>; Mon,  4 Apr 2022 05:52:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377373AbiDDFx7 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 Apr 2022 01:53:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377371AbiDDFx6 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 4 Apr 2022 01:53:58 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21BAB326F0
        for <git@vger.kernel.org>; Sun,  3 Apr 2022 22:52:03 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id m18so7277923plx.3
        for <git@vger.kernel.org>; Sun, 03 Apr 2022 22:52:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OPpi0kyAkohMLDZJDhhz4UQwoNx/YNWvvo3piyD2NU=;
        b=oqvv6jccu29GmZeoiJdwFTG94s2pwapATiinlbEGSz+mVSaYBZl2FTFJlUbaWO8exJ
         L6y6P1Sox7XZUgX0K7KeOzVXehI5+3S48AFz5Y756t7vSGjwYUaJbtakJR6WEBVYUSs7
         ZD7qndN4kMXGgryCnpF2IFxe6LQmt/jDQvKzTSxi8okANLktwupjTYTjp0G4CSa72LC7
         OkuxgUhIhJQYzoFL24OviHdjL9MUmltzMcgspmYcTE618nrz/uoQoWoyOvagfo6Nbnzf
         NnugxjCTzZVPf2/bJvwjnsZl3TW1VlFPTfDTorIFXuQuZXvTUBfLawN1cGJYgzX9bi+N
         q8EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=1OPpi0kyAkohMLDZJDhhz4UQwoNx/YNWvvo3piyD2NU=;
        b=AsQsQ+OliN5KQRxGn8nJBPjixqnDGqUcPVwAYxVy7aD18sLRZUzMhziF+UuUDXLTc8
         SKvJmnV32qpyG0ePyli3erUljeROPan2+8f4W1kNjMhMxqcIS+KS13UVhqRxven3Ifuw
         pGmu/XMd6dX68yyFIVeaD9cpLM6qcO0Xx3EaI1HyLCf4c9mAXuzonBvLMKhX2dbvrhju
         uZ92n8ngseS5fQKlDdg0iyM6cXU+2PUV38E1OQH5hfQ2jLdQzZhE4l1/+6BAQvFFhBXK
         sVzxAY/ri3gNWa4lYED0YvLY8kNh5d/NVqfh2RNlhYOL36S/100jpFMjUIWCB+KyOCzB
         JRpA==
X-Gm-Message-State: AOAM530HAMCxBxaBlBt6PS+oZZ3OtVUnz3ImKE0mjVPneUPssDl0ruj4
        5ikHluS6iX+IQqHD7kh5scuq/e0vCQD0Qw==
X-Google-Smtp-Source: ABdhPJxKvKAsu4X9WzrC/9ypy6D5r6YzR+mc/nP5nZKrjPWkef2nlDI4FMy+ms2VXDPP35f1JxPkSQ==
X-Received: by 2002:a17:902:ce87:b0:156:5c6e:b6e4 with SMTP id f7-20020a170902ce8700b001565c6eb6e4mr17862666plg.12.1649051522306;
        Sun, 03 Apr 2022 22:52:02 -0700 (PDT)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id z5-20020a056a00240500b004e15d39f15fsm10611488pfh.83.2022.04.03.22.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Apr 2022 22:52:01 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, prohaska@zib.de, eyvind.bernhardsen@gmail.com,
        gitster@pobox.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH] convert: clarify line ending conversion warning
Date:   Sun,  3 Apr 2022 23:51:51 -0600
Message-Id: <20220404055151.160184-1-alexhenrie24@gmail.com>
X-Mailer: git-send-email 2.35.1
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

Rephrase the warning to be clear that line endings have not been changed
in the working directory but will be changed on the next checkout, and
explicitly say which line endings the file currently has in the working
directory.

Example commands to trigger the warning on Linux:

git config core.autocrlf true
echo 'Hello world!' > hello.txt
git add hello.txt
git commit -m "Add hello.txt"

Signed-off-by: Alex Henrie <alexhenrie24@gmail.com>
---
 convert.c            | 14 ++++++++------
 t/t0027-auto-crlf.sh |  2 +-
 2 files changed, 9 insertions(+), 7 deletions(-)

diff --git a/convert.c b/convert.c
index 8e39731efb..b024d74222 100644
--- a/convert.c
+++ b/convert.c
@@ -195,9 +195,10 @@ static void check_global_conv_flags_eol(const char *path,
 		if (conv_flags & CONV_EOL_RNDTRP_DIE)
 			die(_("CRLF would be replaced by LF in %s"), path);
 		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
-			warning(_("CRLF will be replaced by LF in %s.\n"
-				  "The file will have its original line"
-				  " endings in your working directory"), path);
+			warning(_("CRLF will be replaced by LF in %s the next"
+				  " time you check it out.\n"
+				  "For now, the file still has CRLF line"
+				  " endings in your working directory."), path);
 	} else if (old_stats->lonelf && !new_stats->lonelf ) {
 		/*
 		 * CRLFs would be added by checkout
@@ -205,9 +206,10 @@ static void check_global_conv_flags_eol(const char *path,
 		if (conv_flags & CONV_EOL_RNDTRP_DIE)
 			die(_("LF would be replaced by CRLF in %s"), path);
 		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
-			warning(_("LF will be replaced by CRLF in %s.\n"
-				  "The file will have its original line"
-				  " endings in your working directory"), path);
+			warning(_("LF will be replaced by CRLF in %s the next"
+				  " time you check it out.\n"
+				  "For now, the file still has LF line"
+				  " endings in your working directory."), path);
 	}
 }
 
diff --git a/t/t0027-auto-crlf.sh b/t/t0027-auto-crlf.sh
index 0feb41a23f..31f471c4b1 100755
--- a/t/t0027-auto-crlf.sh
+++ b/t/t0027-auto-crlf.sh
@@ -82,7 +82,7 @@ check_warning () {
 	'')	                                                 >"$2".expect ;;
 	*) echo >&2 "Illegal 1": "$1" ; return false ;;
 	esac
-	grep "will be replaced by" "$2" | sed -e "s/\(.*\) in [^ ]*$/\1/" | uniq  >"$2".actual
+	grep "will be replaced by" "$2" | sed -e "s/\(.*\) in .*$/\1/" | uniq  >"$2".actual
 	test_cmp "$2".expect "$2".actual
 }
 
-- 
2.35.1

