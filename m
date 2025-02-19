Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B42811E04BF
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 20:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997254; cv=none; b=dysTwgYzTtK222XFHMiTQ8T2xab8mVXlghlIrpelDhXKdNvnjcKiEduoxKZQY3ADf3sSi/48Gg+q3JenNMhmum0Stj5CK1eA3SF4m1bCwI8oujHX09zHpeX7XDUcHNI1mSJbFnCqwpPapLkJNxWtkiBrolXmWxdgtZ8TUxOxdnA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997254; c=relaxed/simple;
	bh=0Spg3KmYuHwAMzyAKisp3ZMckGL+Mh2IIYLqwFFFUas=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IteOGQwdtUq0ChpKO0fjsegPbDNOTWhr8irPy3CDBcGayYDCEOjnlo+8ldB7EwzRZmcB9li5rAuaHDEEiBzK7L5AQ43q5Z/vPa2D9HnJHZ/6xnlZo1EemAqvUeb/bn3vJfu/M+1NxrY43DMb0vAYjD8Dtpr2e10jPs7BZNtNYMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RpgnYxKg; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RpgnYxKg"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-219f8263ae0so3688195ad.0
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:34:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739997252; x=1740602052; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=o/zYfYLxb8HB6W0rj50rAQ0zfF5Ar0AEk1JmVCN5YuE=;
        b=RpgnYxKgnbaOdpsqwOMolqqnAk67Bli5dpkZ8x2BStYlkMedFImuLLo/vFkjpkzkID
         yIU3W8KqS1g/x/u7P+ekaPMIpJal2ig8OE2tHLNSh6vCMSJVQ4IPp0CC3P1D2nkj1eNL
         NKzLgLP0e7T70W15mLd/CwQ0Vh6j22XU7nRQ7cVpxYZ83CqsSFsI45KmawV9z8VQ0s3o
         M+28mPC9HkS6nu/o/94XTY+ZuUowxAKYBrAXQHJhEqy2fW0+fTtEU1nDbzmDVObJOk02
         F0xIFIr14kRrwDR9l15771MAPO+UZqqA4IXvURmc4XNhn9xToy8Y72U3fgLKnFUEf6P8
         Jz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997252; x=1740602052;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=o/zYfYLxb8HB6W0rj50rAQ0zfF5Ar0AEk1JmVCN5YuE=;
        b=A8bDJXvb8OnyTG9+WdoaaorZB3B83Yzt4Ypg1mA4NvyNeIIYGYXxkkqEGf5PHUhn+u
         FONqoZOzu+0lMg6zp80FxdqV7SW2tz7AFF/I5rLE6Z9/Hwc3kLUzA/aG9Sef8oGq59Lx
         Xnlj9aUYAMGiNG2fw29lolOngwUH+S44aV3KgHziGqPktHIDkrjfwoiz35qnYtMnbhXV
         C4+1J0yo88VLzWw++QD3NYOSIvYLxGwd5Nhmfr0ZtXbai7aXWGdx3mEltRPZqVYUHtKr
         cfvRXtju61TD+5IV4NaXFtd79kWk2AuPVB9eJXFpEtihYWb/A0cezwJkGquBoQ9rB2Yx
         uq8w==
X-Forwarded-Encrypted: i=1; AJvYcCVNYKxMhbb/B6NIqx27JfnssLz2bjqvHEVepiSH59b/wUXT/TiU0xRmb6GuAryu/8eEcZM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxVqqw2NYPEZ/DH27W6Xtzj7KrbS2mlbxFRwnNJKUimVr18VLh4
	2VQxgB28tAVaup3oEemVs+U0YeUg5/Hrww5kBPF2D5cPUWOm36Lj
X-Gm-Gg: ASbGncupo63EYC96y3etzgHBEFNlPzBwTFfTXRSJj9+25cPLaZboEFNh8AN4znzLuT3
	8ISqoqH/xfd92esRJ6ahnRh7yFZOUnnZZ+srfVZTNhcywX4iMFW1aEnQ+Mkv/a12fRUDvYjrQgZ
	XxHZnZpG/yUM9/JxrgDMPUojjgW7IS/pldReSGnnXGLoH3h/OpQu9G2vhH64vizUYNx70LdLoZL
	86o7yAIfVdFvRDqwArUwb5w6TIJ5gEAAk1vKfXe+24o1vFcogqcBleIn1QhCeomA8HHNG55mD5J
	KIOvY/MAONnxJSO3gyeobk2kS4+VYo/oo7CEbOsF
X-Google-Smtp-Source: AGHT+IGJ0wpV1MSF5G5uj2qj3xiHcBLFeTiyGZsQQy1W7LuANQWTjwrJ9NXvsJUHDmGUfUOrTVDtdA==
X-Received: by 2002:a17:902:dac4:b0:216:485f:bf90 with SMTP id d9443c01a7336-221040613admr254565585ad.27.1739997251875;
        Wed, 19 Feb 2025 12:34:11 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53499dasm107791355ad.12.2025.02.19.12.34.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:34:11 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: gitster@pobox.com,
	christian.couder@gmail.com,
	git@vger.kernel.org
Cc: me@ttaylorr.com,
	chriscool@tuxfamily.org,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH v2 05/12] builtin/send-pack: refactor `cmd_send_pack()`
Date: Thu, 20 Feb 2025 02:02:53 +0530
Message-ID: <20250219203349.787173-6-usmanakinyemi202@gmail.com>
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
 builtin/send-pack.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index 8d461008e2..0848d23171 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -212,7 +212,6 @@ int cmd_send_pack(int argc,
 		OPT_END()
 	};
 
-	git_config(send_pack_config, NULL);
 	argc = parse_options(argc, argv, prefix, options, send_pack_usage, 0);
 	if (argc > 0) {
 		dest = argv[0];
@@ -222,6 +221,8 @@ int cmd_send_pack(int argc,
 	if (!dest)
 		usage_with_options(send_pack_usage, options);
 
+	git_config(send_pack_config, NULL);
+
 	args.verbose = verbose;
 	args.dry_run = dry_run;
 	args.send_mirror = send_mirror;
-- 
2.48.1

