Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1E9422611
	for <git@vger.kernel.org>; Wed, 13 Nov 2024 19:01:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731524473; cv=none; b=Mv374MUeDZ+gwe8kfIJSD+ajuNriRuNPNSR4fGA1+1Yypul6JdK4/vPGYjv6sKrvRnBKKwsxAyJjmalSR6QzChRU9GP8OGyU8h5ITK1LAbZU2TzmBrmhwpdfZNnlYumyvxVX6Gk028HWm0gLnNa9wTVl9JIhiKkf4aSipIYqMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731524473; c=relaxed/simple;
	bh=2nphYwAyofYU/1i0KRbUIGyatXJ6ax0FQAFR9a3JxCg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=qV0InbBGSBgMXyXT7VgP7MZkF8IL7deBH10dZrJKsQYnl7oTSy25arBVqRrpjZsWQbTrM85o+0xmLBL8J6Qwf8kx2HrojBH/mKpLUrbLZg7VVDe/KFJCQiQ/CHVjlXAZbxcHb4TAa1/6S8MNcgzrzthfImS6aaCwD5/VfYI7zdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lcMusCcs; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lcMusCcs"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d462c91a9so4600232f8f.2
        for <git@vger.kernel.org>; Wed, 13 Nov 2024 11:01:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731524469; x=1732129269; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BF2qKCil0c5rZUfRoN15AUKHAXAE0vedQZ2uFpNOMpc=;
        b=lcMusCcsaeBORU3y81qcfHczM+2awhKCCQ010clSuXJXCckZfFWD9dvrGg3F6Dd3L4
         +qZqv46+i8bOAELydLTBkr1zNaXq2pCAZhPsDT9S7H8xtkNFq0rL7NCqEeH4aVwesFfY
         M6atc6TMtYi4gjaElSkxAswTHPYNyKDCA6jcbF6I2RW/CBkrPRFVZ6Z/X3cNiFwuZGd4
         HfOEkFuN0r5A3rQRtqBoxfO4IxcspSi/hNyMC+MvTMC6bqwW2s136SH5fCPTLqK0VNLf
         Tt6liUOGDzwFDad3dPp4q9tycTNsSDbQ3y6TG5c3/4QIpXTVYmquPIGBVLaE0NeJfRGY
         DYDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731524469; x=1732129269;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BF2qKCil0c5rZUfRoN15AUKHAXAE0vedQZ2uFpNOMpc=;
        b=oNS4wTF7EsP7yWK1b7hNmL1D2r/SKdSOPm+R4O1YGWB67lelaKITRiAT1rBuBGOYHa
         vZvOPgojJ7xRyGCHbnNcTVKbyySfMWgwDEom3Uu4j49ozHHT+ad8WM7PfMAPG16LSHsM
         MtqThuj+eENjL3sKNiFCdzgJ2pC5Hf1jTgC95oRIWFoVxtbozxXas3+08B7kDlB2EGbx
         HrvCtRMRscblFefdfdg0kmHgKSSaHkjP9FpO6oBNn61T0OMmYnS53bVpinBV0MANRgQ2
         VAFZQD9wZe5XOtZf2OU9gBjayOqIZWtc1slJx4jorgQcJFXo5fKaUx+3wAdI08NTCBvr
         vgwQ==
X-Gm-Message-State: AOJu0YzwXL3OHgGwSgPLUgqPdhTC+s1BQ6+zJi1fjyVoedk119ULq7TK
	inFxoQK/JnqKY5287cYvsGtXvQ5PkAyQj7G0v7C3fO3z6uEUV620pLy2Kw==
X-Google-Smtp-Source: AGHT+IGpMtkHscHfyGaKBG/YQDjlKq3ck2frHTBebuCFmfd9GMP/2rRSVJb7OXvZ24YF2vcl7VXSLQ==
X-Received: by 2002:a5d:6d8e:0:b0:37d:3735:8fe7 with SMTP id ffacd0b85a97d-3820812dc63mr6603842f8f.32.1731524468572;
        Wed, 13 Nov 2024 11:01:08 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381ed9ea4c5sm19419859f8f.76.2024.11.13.11.01.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 13 Nov 2024 11:01:08 -0800 (PST)
Message-Id: <pull.1828.v2.git.git.1731524467045.gitgitgadget@gmail.com>
In-Reply-To: <pull.1828.git.git.1731347396097.gitgitgadget@gmail.com>
References: <pull.1828.git.git.1731347396097.gitgitgadget@gmail.com>
From: "Usman Akinyemi via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 13 Nov 2024 19:01:06 +0000
Subject: [PATCH v2] diff: update conflict handling for whitespace to issue a
 warning
Fcc: Sent
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
To: git@vger.kernel.org
Cc: Usman Akinyemi <usmanakinyemi202@gmail.com>,
    Usman Akinyemi <usmanakinyemi202@gmail.com>

From: Usman Akinyemi <usmanakinyemi202@gmail.com>

Modify the conflict resolution between tab-in-indent and
indent-with-non-tab to issue a warning instead of terminating
the operation with `die()`. Update the `git diff --check` test to
capture and verify the warning message output.

Suggested-by: Phillip Wood <phillip.wood123@gmail.com>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
    diff: update conflict handling for whitespace to issue a warning
    
    Changes from V1
    
     * Disable both WS_TAB_IN_INDENT and WS_INDENT_WITH_NON_TAB when both
       are set.

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1828%2FUnique-Usman%2Fmaster-v2
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1828/Unique-Usman/master-v2
Pull-Request: https://github.com/git/git/pull/1828

Range-diff vs v1:

 1:  dfb80a7ff2d ! 1:  8531e80811c diff: update conflict handling for whitespace to issue a warning
     @@ t/t4015-diff-whitespace.sh: test_expect_success 'ditto, but tabwidth=1 (must be
       	echo "foo ();" >x &&
      -	test_must_fail git diff --check
      +	git diff --check 2>error &&
     -+	test_grep "warning: cannot enforce both tab-in-indent and indent-with-non-tab, removing tab-in-indent" error
     ++	test_grep "warning: cannot enforce both tab-in-indent and indent-with-non-tab, disabling both" error
       '
       
       test_expect_success 'check tab-in-indent excluded from wildcard whitespace attribute' '
     @@ ws.c: unsigned parse_whitespace_rule(const char *string)
      -	if (rule & WS_TAB_IN_INDENT && rule & WS_INDENT_WITH_NON_TAB)
      -		die("cannot enforce both tab-in-indent and indent-with-non-tab");
      +	if (rule & WS_TAB_IN_INDENT && rule & WS_INDENT_WITH_NON_TAB) {
     -+		warning(_("cannot enforce both tab-in-indent and indent-with-non-tab, removing tab-in-indent"));
     ++		warning(_("cannot enforce both tab-in-indent and indent-with-non-tab, disabling both"));
      +		rule &= ~WS_TAB_IN_INDENT;
     ++		rule &= ~WS_INDENT_WITH_NON_TAB;
      +	}
       	return rule;
       }


 t/t4015-diff-whitespace.sh | 3 ++-
 ws.c                       | 8 ++++++--
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/t/t4015-diff-whitespace.sh b/t/t4015-diff-whitespace.sh
index 851cfe4f32c..849f1854fb9 100755
--- a/t/t4015-diff-whitespace.sh
+++ b/t/t4015-diff-whitespace.sh
@@ -808,7 +808,8 @@ test_expect_success 'ditto, but tabwidth=1 (must be irrelevant)' '
 test_expect_success 'check tab-in-indent and indent-with-non-tab conflict' '
 	git config core.whitespace "tab-in-indent,indent-with-non-tab" &&
 	echo "foo ();" >x &&
-	test_must_fail git diff --check
+	git diff --check 2>error &&
+	test_grep "warning: cannot enforce both tab-in-indent and indent-with-non-tab, disabling both" error
 '
 
 test_expect_success 'check tab-in-indent excluded from wildcard whitespace attribute' '
diff --git a/ws.c b/ws.c
index 9456e2fdbe3..3e9ce55d095 100644
--- a/ws.c
+++ b/ws.c
@@ -6,6 +6,7 @@
 #include "git-compat-util.h"
 #include "attr.h"
 #include "strbuf.h"
+#include "gettext.h"
 #include "ws.h"
 
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
@@ -70,8 +71,11 @@ unsigned parse_whitespace_rule(const char *string)
 		string = ep;
 	}
 
-	if (rule & WS_TAB_IN_INDENT && rule & WS_INDENT_WITH_NON_TAB)
-		die("cannot enforce both tab-in-indent and indent-with-non-tab");
+	if (rule & WS_TAB_IN_INDENT && rule & WS_INDENT_WITH_NON_TAB) {
+		warning(_("cannot enforce both tab-in-indent and indent-with-non-tab, disabling both"));
+		rule &= ~WS_TAB_IN_INDENT;
+		rule &= ~WS_INDENT_WITH_NON_TAB;
+	}
 	return rule;
 }
 

base-commit: facbe4f633e4ad31e641f64617bc88074c659959
-- 
gitgitgadget
