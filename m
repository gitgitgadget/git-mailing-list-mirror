Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C48C23ED40
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 20:34:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997260; cv=none; b=GoQETWRVP5lf0p7wTAQb+w4/FhQWOdxlHV0ZpTwhuP7SyP4RbAhSjLKpE6LQCAtB+PuwCzPZkWtNoyslZPfM35VTU9vwV9zK3VCYSF9WjNX4BgIK1qRIOPc9gfkpTQ4Xyt9xYGF1NY2rVEVR8D4JlUIddVS2X/hOPX11VNmUz9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997260; c=relaxed/simple;
	bh=U7hxxSQ61EVylqutpUsj3GSWPgEB9M6Rf/qs0DFQLNw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X+21boN6qaQYs1zb2Jny/E29W1B2IPzItra4k4GKRfBMHiloBW8/8vmC+YDrxfnq68WG6RWa54yYnkPwRuy8S1VTEErf5yyp6cvmfVDXL2DpXYnNRwyQtulVctpPPUNoPIpaP+0oYK5Boxj6mhsWjHJIpcUP9VPs4VaskQ4KPlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jkxe5gCJ; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jkxe5gCJ"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-220e989edb6so4032535ad.1
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:34:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739997258; x=1740602058; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=x3zcETK7eZ2sts1H9XzlGGNw6Y/886v1blXgieinuwQ=;
        b=jkxe5gCJntaFs0bDzs7QuMNYR2dmHlzLJNGuqEBaG3qSZcqJUUOa6oO7lnc8ZtlSZH
         I2bCLvC/OYAR1b8PISrlWqImezgCZ44xh6al7Klof977mRj2kBVNKmbQOZyt92vaW4/I
         RXdBZ1GAJNYMJrfWTHNl/I2RaRF8ztZ1SzTDhUZWU0ZrFDld0HIk5qYEp3ajuzN9jPeU
         IpWY9YRgV/++LutkYL/4BBIJyrkLNqK5iqt9LqzMYp3DEKBbu3SmI5kM1VVfUntjgJya
         u3mnG3WwLX6koTXKT0B6mWnS1JtI0WH2koijdq7V3Pva7yZRrJzPMrP/GVxxKIJLCOli
         6yIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997258; x=1740602058;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=x3zcETK7eZ2sts1H9XzlGGNw6Y/886v1blXgieinuwQ=;
        b=X5La8DV1xnZuKuGvU4p7rEEaRMRQcGWaHqZ5VYFcdwTsSasW4F93pSAl962o0ubYn+
         9BX9PUjjpDFZ1KhlFlposIQ2B4EoYrCcLz1x1yWOIbCElwSnRMTk1M+Yit6VrRcYdf/f
         bqRbYAGqEu9N+KkMY0NpsXfIdfCgP33bDhkEsp3WDJA/uwhyzr43HK3POup4ZdGIExFW
         e4jtCcauElEOH0W1S312/SzP4589fzM2gXLe/kg5vhln8YPTntXI9OF+aiu7A9NQZEk2
         YLkoFc4LiGeQq9j8nokr18P77LxJm8YEW2MWLIV3ff7LkYNITOGDSELZCCuAZpUkOLIm
         l8Qw==
X-Forwarded-Encrypted: i=1; AJvYcCXDu65zFeQtsYadKd844bFhwnbaMMXLs81xjqkmwgCA3rg7DdkOOJy0OHr0NL/ULDiKZCs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyTKO8VzFzIQBZXa6hNDMRIKxnN20W/TmqUmPInQcL7EfT7YTYG
	F7DU2qkSSD5NpfwzTKkOV4mmVwOpQGpFsYYMBB+34XoWxsn7Eyqq
X-Gm-Gg: ASbGncu4ARm4rAo+WeMFih1CZnEFED0JqaPF+J90ZQ++DS2nB9Cfp6UB+uMX7fOp5gO
	C1pmd6MEJkG0NHnMMucRkltOfU6MCWko7IqwUvg2EmdX+YsGBkriD3RuLopzb6o5D/80djZAaek
	1iMM0gpuNG6HnkzwobWOCV6zPK+yeLgzATDL4bzFzlSBQJOI6GtIR+RCVt744sQQ6K0RP+NqkeW
	Wt6g8mpz7XxPQlok51PcN+gKIKRa5o8qK+Guk1GvHgrLfY0590b1xicxEuTQ7tzVvQm6n9Vefsk
	6fIaHln3TWcoqx7p20qdPYpiMX05G2872uOZWG2p
X-Google-Smtp-Source: AGHT+IE/CORsXkvkx7bJzwEvc051BaB28booLrfPGddzxwB9An14QTN6Kic7T62k4zxdi4N0YHcAdA==
X-Received: by 2002:a17:903:240b:b0:216:3c36:69a7 with SMTP id d9443c01a7336-221040bdbefmr303814095ad.45.1739997258432;
        Wed, 19 Feb 2025 12:34:18 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53499dasm107791355ad.12.2025.02.19.12.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:34:18 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: gitster@pobox.com,
	christian.couder@gmail.com,
	git@vger.kernel.org
Cc: me@ttaylorr.com,
	chriscool@tuxfamily.org,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH v2 07/12] builtin/pack-refs: refactor `cmd_pack_refs()`
Date: Thu, 20 Feb 2025 02:02:55 +0530
Message-ID: <20250219203349.787173-8-usmanakinyemi202@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250219203349.787173-1-usmanakinyemi202@gmail.com>
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
 <20250219203349.787173-1-usmanakinyemi202@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Move `git_config()` call after `usage_with_options()` to avoid NULL `repo`
check.

When "-h" is passed to builtins using the RUN_SETUP macro, `repo` passed
by `run_builtin()` will be NULL. If we use the `repo` instead of the
global `the_repository` variable. We will have to switch from `git_config()`
to `repo_config()` which takes in `repo`. We must check for NULL `repo`
if `repo_config()` comes before `usage_with_options()`. Moving `git_config()`
after `usage_with_options()` eliminates this need, as `usage_with_options()`
exit before calling `repo_config()`.

This will be useful in the following patch which remove `the_repository`
global variable in favor of the `repo` passed by `run_builtin()`.

Mentored-by: Christian Couder <chriscool@tuxfamily.org>
Signed-off-by: Usman Akinyemi <usmanakinyemi202@gmail.com>
---
 builtin/pack-refs.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/pack-refs.c b/builtin/pack-refs.c
index 4fdd68880e..bd09366738 100644
--- a/builtin/pack-refs.c
+++ b/builtin/pack-refs.c
@@ -39,10 +39,11 @@ int cmd_pack_refs(int argc,
 			N_("references to exclude")),
 		OPT_END(),
 	};
-	git_config(git_default_config, NULL);
+
 	if (parse_options(argc, argv, prefix, opts, pack_refs_usage, 0))
 		usage_with_options(pack_refs_usage, opts);
 
+	git_config(git_default_config, NULL);
 	for_each_string_list_item(item, &option_excluded_refs)
 		add_ref_exclusion(pack_refs_opts.exclusions, item->string);
 
-- 
2.48.1

