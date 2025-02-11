Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE89B1F1510
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 08:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739263865; cv=none; b=FKwc0VEHUo7js+LBwq2kMmKUrO07UD8SVkvtsr87aYTwPQDeYGZc1uBxNoal2rYKVwNqxV9JN4Jjum0wQ9AEWwmqEU3IIbD8rD1yH44Wg7WlNnT2AukQcN2q/LktgVzTLNtZlHKS8ySZr2JXqiDybvNWdCSgAzltthqOpqA3PVw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739263865; c=relaxed/simple;
	bh=at0aJg0TAgmlpPYtiUNOgwEq/y1ZzMivTl9xaEzT55k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KF90DDkXpnzSNo6Z09lzhmlSOg/ISzUp9I3nF4/Nqqdrti4X0hzBHySTPkXw0El6b4T8Anhh0zRYku1zVg4ZagmHhU9Lw1wXhaE3ZQ+7TchsF/8WH56LiGNdGFqHB/d9qJhWrLm8EkbLi9+RMoL/Ggdz94XJlSGU6CABzmYQNUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ifje3y18; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ifje3y18"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-2fa51743d80so3797843a91.2
        for <git@vger.kernel.org>; Tue, 11 Feb 2025 00:51:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739263863; x=1739868663; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWUP9PAoX6nXGAi7BUu9ADVDebYFDrcl3z3wLBs5/5U=;
        b=ifje3y18GWcpofGLhePkVC3kNYVkifc+RMSMddz/cMdo/aypWOBUjhfHZFPcaq/YcK
         9n64PEfPakeVoidn8rKlsXU+NtRaNzWoOvmDualUTjWF4DBxhrOtc5PNuNukGTeaNa81
         nWp7jFfbQGSh8lMA2IxQtyXQI2bk7DnampuGH+943uHvR4A1s2+adLmrjI+ptzSEj/8p
         CDBUGSlhq0Bq7/VPN7nkwhRH8S3kX6bpIv7DkcPAj2vY+qMLlfazQgINuy00jqBOEYtq
         ZAlwP4EoEx02HlrKCyIiVJX0EdznzYNMghUEG7/7vzfi6ZihNpE/FLMDbVEvSGKFJNVk
         BvrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739263863; x=1739868663;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xWUP9PAoX6nXGAi7BUu9ADVDebYFDrcl3z3wLBs5/5U=;
        b=GowlZkTwfbjGcUQUR6rwjN44K/bgV1lB9zdEChUwdN0qXJRQ58izHDyoXJDUyouBzd
         wb8EfNBygvQbBDRdVW5Z6ekG+Oc252sa8VpYVyzcB9VDW4D/7vGIynFQOZlxiNoUC+HP
         MLcLWHM5I958XvcJaD/Ka7hqrfVxp9H+OCr9y8HAIS+lQxGxSV7hYID8KCB+Zq59Snx2
         h/eF1xDhgDgxWKSr3P0nBU0WVGfjhUaeOPbEYykqZt1Y/Fx/XbNCsSbxl19jRG7VKnw1
         457pDCT3HQhabFPNGo0auvLc+wcrY8F2v3YAGR7ly8TROxBEK3zPGBGWS+DcmuKXRZTR
         sE5A==
X-Forwarded-Encrypted: i=1; AJvYcCXBhyn+BSmhTfPHiRg0oKExShnEm5YjGZa6k6D1+zk8njd4aqdSXqWf2r4m4MlPWXcMfYU=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw2xEhEQG2r7Cn+A5/cdxC3dq1o26pD2/KvrCZHyfos1lSqM46D
	zEtXB6EIB/nQqEkrNzfmLpsexi5BKuO8/2TMIqxmobnvaBfQsnSvX4X7CfU4
X-Gm-Gg: ASbGncuqFXSO0uhcY7lMRz6JteCLakzYqGJlLvk2ynLEPm/zEaRgwc2Gz4avd2wVY66
	zvvLG66swN8iybSUwTqNHdkzQjQkGN8nQ1AW0Wy1+fx2LcFwZKTRafNjb8E/+mHWNnTsNBb+r8T
	3rMSXrqFVwO2vNlTht2jOusEu02atp5LMuszq5GJROh3dlmnXni36/nKqK8guI+ORUu9QmffI2t
	vOlUG280jUGh9O4I1LFexXi7waKv2ugCrwhQDF024ehwrsDLHhGfdgOt3B9d1Af2HGgKbHPlyAE
	7LAqQZ8TcYo0uIf0fJy5sfugtsbU06ObzyYfPOw=
X-Google-Smtp-Source: AGHT+IHTZhADEuyNSWSwsNGtvWWzQRGjENjJsFCTW0zEoAxwt3GcHekdva4OqVr+m6fw+ifkxOnhwg==
X-Received: by 2002:a17:90a:6fa1:b0:2f8:b2c:5ef3 with SMTP id 98e67ed59e1d1-2fa24063babmr29549220a91.14.1739263863231;
        Tue, 11 Feb 2025 00:51:03 -0800 (PST)
Received: from gamma.hsd1.ca.comcast.net ([2601:647:5580:5760:3858:1e16:caad:e1d4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-2fa09a46534sm10201701a91.21.2025.02.11.00.51.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2025 00:51:02 -0800 (PST)
From: Illia Bobyr <illia.bobyr@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Illia Bobyr <illia.bobyr@gmail.com>,
	git@vger.kernel.org
Subject: [PATCH v4 09/10] diff: --pickaxe-{all,regex} help: Add --patch-{grep,modifies}
Date: Tue, 11 Feb 2025 00:50:21 -0800
Message-ID: <20250211085028.3923875-10-illia.bobyr@gmail.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20250206014324.1839232-1-illia.bobyr@gmail.com>
References: <20250206014324.1839232-1-illia.bobyr@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

For less experienced users --patch-{grep,modifies} should be easier to
understand than just -S or -G.  By mentioning the long argument names in
the help messages we save those users from having to search the list of
options for an explanation of what -S or -G stand for.
---
 diff.c | 4 ++--
 diff.h | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/diff.c b/diff.c
index ac2cd..a9e78 100644
--- a/diff.c
+++ b/diff.c
@@ -5871,10 +5871,10 @@ struct option *add_diff_options(const struct option *opts,
 			       N_("look for differences where a patch contains the specified regex"),
 			       0, diff_opt_pickaxe_regex),
 		OPT_BIT_F(0, "pickaxe-all", &options->pickaxe_opts,
-			  N_("show all changes in the changeset with -S or -G"),
+			  N_("show all changes in the changeset with -S/--patch-modifies or -G/--patch-grep"),
 			  DIFF_PICKAXE_ALL, PARSE_OPT_NONEG),
 		OPT_BIT_F(0, "pickaxe-regex", &options->pickaxe_opts,
-			  N_("treat <string> in -S as extended POSIX regular expression"),
+			  N_("treat <string> in -S/--patch-modifies as extended POSIX regular expression"),
 			  DIFF_PICKAXE_REGEX, PARSE_OPT_NONEG),
 		OPT_FILENAME('O', NULL, &options->orderfile,
 			     N_("control the order in which files appear in the output")),
diff --git a/diff.h b/diff.h
index ed48a..9ad37 100644
--- a/diff.h
+++ b/diff.h
@@ -613,9 +613,9 @@ void diffcore_fix_diff_index(void);
 "  --patch-modifies=<string>\n" \
 "                find filepair who differ in the number of occurrences of string.\n" \
 "  --pickaxe-grep\n" \
-"                treat <string> as a regex in the -S argument.\n" \
+"                treat <string> as a regex in the -S/--patch-modifies argument.\n" \
 "  --pickaxe-all\n" \
-"                show all files diff when -G or -S is used and hit is found.\n" \
+"                show all files diff for -G/--patch-grep and -S/--patch-modifies.\n" \
 "  -a  --text    treat all files as text.\n"
 
 int diff_queue_is_empty(struct diff_options *o);
-- 
2.45.2

