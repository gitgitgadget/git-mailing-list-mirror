Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21644C433EF
	for <git@archiver.kernel.org>; Tue,  5 Apr 2022 05:38:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229874AbiDEFkO (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 5 Apr 2022 01:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229914AbiDEFkM (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 5 Apr 2022 01:40:12 -0400
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E2BB6E2A8
        for <git@vger.kernel.org>; Mon,  4 Apr 2022 22:38:14 -0700 (PDT)
Received: by mail-pj1-x1029.google.com with SMTP id gt4so4935429pjb.4
        for <git@vger.kernel.org>; Mon, 04 Apr 2022 22:38:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QDhGjc+ElLxgSDykG+0OI8GT892haLQcrNXHenIPO7A=;
        b=WcX85Ziwbqro0+mbzy5GKVI5RrbCmJJevJdT3zoDQqKHBIUY1tTqdpdiru1fb7V8c4
         cEkeL/cU4QBsiq/D1vY10SUrBzNYv2/nkOdflGokDDbrvKgpBAKVbuazxk680b/004jq
         mW6EYQo0d03eh0Fkz5BOBzbTNFk6UObSBij32/Irap2UYN9lIiMwYj8gbFXGjvOxlzoI
         Gm/ZOeGVlyn1Svoo+SN3fgdTQwFiHO0dPb003ndDSeIDbYivVHTVmvdZq6XFu7xR1D7O
         F5aMwK0hOWazhjFI7tG/zygfoq8+yIUTzVEQFSyKQ36ForukM/syCO7tmJKtILuXF7BK
         OiKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=QDhGjc+ElLxgSDykG+0OI8GT892haLQcrNXHenIPO7A=;
        b=PKRL9zTPiPATJ34uZToPecgYgOAWnhHVWAaEEoPgBz+GT7XhLG5+ZDLVkwTS5x+GRT
         fqP61zOEt49Pg64pulLaJR2uCaicufAB4WdHS/CKtjkbbjCT5NU0IXT6n+i1qYYObogw
         HUsbkjkSya9m3I6J4EIgsfXDbyogBsKUDTnQC2I0t+oWmDvqd/zvgi/1lN1Scu6vU4kE
         nrmp/Hc4uYVzCXQkxO5QGjIZGls+Qo+zKKUTA54yI/J+H2JtXeHKe2Wry4zJ/IpIuGJT
         6Qf/YeUHCldo0ogeI6c4fvCg0huTJ0AvQgvyXuXgvIhu2hM7Riwf1riqsVYxl5vtLTG0
         Tmag==
X-Gm-Message-State: AOAM530ZBkatsNBzq/pOdzHBBSuouZXdOGNbouvxa02Gb+GHkFzvPCCr
        flXBFjww+5EZ6GcFt71kswAZK6MCoO8OIA==
X-Google-Smtp-Source: ABdhPJxD/qMY1a6W4ZCB6jxgt0ngaF1y4s9cqR+TcMXqatY7UPbHAOAEHEiUekAp/h/PQLxEfQj0nQ==
X-Received: by 2002:a17:903:244d:b0:154:3bb0:7b8c with SMTP id l13-20020a170903244d00b001543bb07b8cmr1754527pls.115.1649137093649;
        Mon, 04 Apr 2022 22:38:13 -0700 (PDT)
Received: from xavier.lan ([2001:470:b:114::cc1])
        by smtp.gmail.com with ESMTPSA id 75-20020a62144e000000b004fae56c42a0sm13847254pfu.211.2022.04.04.22.38.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Apr 2022 22:38:13 -0700 (PDT)
From:   Alex Henrie <alexhenrie24@gmail.com>
To:     git@vger.kernel.org, avarab@gmail.com, tao@klerks.biz,
        gitster@pobox.com, prohaska@zib.de, eyvind.bernhardsen@gmail.com
Cc:     Alex Henrie <alexhenrie24@gmail.com>
Subject: [PATCH v2] convert: clarify line ending conversion warning
Date:   Mon,  4 Apr 2022 23:35:59 -0600
Message-Id: <20220405053559.1072115-1-alexhenrie24@gmail.com>
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
v2:
- Quote the confusing warning in the above commit message
- Move the file name to the beginning of the warning message
- Put the file name in single quotes
- Use the arguably broader verb "touch" instead of "check out"
- Remove the period at the end of the sentence
- Remove the second sentence entirely
---
 convert.c            | 10 ++++------
 t/t0027-auto-crlf.sh |  8 ++++----
 2 files changed, 8 insertions(+), 10 deletions(-)

diff --git a/convert.c b/convert.c
index 8e39731efb..733e581cb9 100644
--- a/convert.c
+++ b/convert.c
@@ -195,9 +195,8 @@ static void check_global_conv_flags_eol(const char *path,
 		if (conv_flags & CONV_EOL_RNDTRP_DIE)
 			die(_("CRLF would be replaced by LF in %s"), path);
 		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
-			warning(_("CRLF will be replaced by LF in %s.\n"
-				  "The file will have its original line"
-				  " endings in your working directory"), path);
+			warning(_("In '%s', CRLF will be replaced by LF the"
+				  " next time Git touches it"), path);
 	} else if (old_stats->lonelf && !new_stats->lonelf ) {
 		/*
 		 * CRLFs would be added by checkout
@@ -205,9 +204,8 @@ static void check_global_conv_flags_eol(const char *path,
 		if (conv_flags & CONV_EOL_RNDTRP_DIE)
 			die(_("LF would be replaced by CRLF in %s"), path);
 		else if (conv_flags & CONV_EOL_RNDTRP_WARN)
-			warning(_("LF will be replaced by CRLF in %s.\n"
-				  "The file will have its original line"
-				  " endings in your working directory"), path);
+			warning(_("In '%s', LF will be replaced by CRLF the"
+				  " next time Git touches it"), path);
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

