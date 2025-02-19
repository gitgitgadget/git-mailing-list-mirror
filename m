Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 464DE23CEE5
	for <git@vger.kernel.org>; Wed, 19 Feb 2025 20:34:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739997247; cv=none; b=rXruefP1XUDn33oHV1JQKF5khqPJnlZGZ9kBvyeqiaV14p7qbUqyUd53EF6ATjwy5/LFKfRUkQJCdL8wxB2CO9NjXaTqabW1pF1ygbayuE7nAUxwQ/+fdqGHkGL0RHE1hTJFZxbGPZ2pc8ZemqSG6bPv5aaGAdM5i3C5+HwW+bk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739997247; c=relaxed/simple;
	bh=8Y5qAmfAHj2xGohPG7roCX/TmrVPqnuJyxvgDjkp44I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IqVyLR5K3r/jAfJxddBwaOVAOIyGRoCkTKhk0yjCGssB0Eu+W81mAoQYr39ysihFFPhP86IZHZ7OqeaubEXasykwhOM6vIUkXwl39A1aj+wMFpOE6LzWwOo2nwO3wcqcPvtnoNdqfqD2njuMPJ3r+uwh50mmfeYLOBI95EUfafY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FfndDZqC; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FfndDZqC"
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-221050f3f00so3135365ad.2
        for <git@vger.kernel.org>; Wed, 19 Feb 2025 12:34:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739997245; x=1740602045; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QJNmNL3sjFhLYsKKrH02VTj/a+jrK06hc/fki+sCs3M=;
        b=FfndDZqCCcCo0m3LvvS6U/7B1eDjJcrqSR0jeIZ6JIdDfJxmy0OBQE7hQwg47D8O0/
         Df5OmrUlL7WRxxc8srJ2Uo178zYg40M9iw2dbO911OZxVmvslghUNXrhdX3YOJF/9LEB
         9TlHT8905MqjAbbFWJZcwhANO+yjm2IBRZx2nbFQpHo8BmFWIaHx0cdQWQJRvazY8bpC
         YQ5RniKvkxA2vRGl/0dJMcBkChfLretDyiGxAbChhRZQcDqerGAbInsXaw4Oa/X8B3Fn
         LkfuAcgCZAHX+eA4BPPaqRRptBTwS0MpoPF1Lal18rUMY57z85TD2Pv7643aEBPecu3g
         +Kfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739997245; x=1740602045;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QJNmNL3sjFhLYsKKrH02VTj/a+jrK06hc/fki+sCs3M=;
        b=QpT8rJT+FLboj7JDposWAOeHIp2eOXxiETAhIgiAJx2RU14sOXnVTjVkPFHCjJrwmZ
         nCuRZmF2AddImNaOCy/5L63Lf+pITC65w7/X5E+wRAw5h5Wg7iZIDwQyQNO7Tbkarlxe
         +PXZ0Uz3dZABRSuOPGpMvQ1kdG1wmfx73DtUGX6e/Y9y/mAOZrB74BSDD5NmvU2227f/
         D/VnB4XBg1fpr7lRbdOjc8loqnQ4J+hjTjFwqZ/U8q8xvEnaoHHpyfj1V7aRgbiUMM3e
         TJpMBOWgiSeeSVI+RXBh/+pd4qMztkwyJW+tOws8SDJQah1iNROcuFexc7kxuT9nD1uN
         MQCA==
X-Forwarded-Encrypted: i=1; AJvYcCUovgk+y3goiZGO9MnQPi3ISIPz39QvdC9/+SgS1Tz5tLn343aUB6V29EIvc2NQnk6n7Zs=@vger.kernel.org
X-Gm-Message-State: AOJu0YypNx1xxu+ksRs9v6J2lYdaqqfGDV+MSgSFe1JuvtC7Pon+hlDB
	9/2vNgvMSH5qUILi8p4dgG7hKfX8xz8uPrFPL4bPXV5Td49fxsDa
X-Gm-Gg: ASbGncuEOEAnOcFJmjL+mz7Wn+ElcSnYV9TTjdjZQU5TleL46Cqh5XMb10ExVuRpKsN
	iR++glbQ7qucakLnB0FaMr/iYC1xunIT9Iwa8clxyqaKjTvVRtHfFV2l2mdl8hITZKN4ysUq15L
	TVyKs7GvWm5JlyaCrUrDE2T2Q54/VQ44iEHF+N63L8GCHKXW9TRdHpqOszj75d9OLA5PKX7G6b5
	QS971FoVIIMEgLtqf0Lw+GAqwKTQzZRBog1Wh6vtxk7yPz4n7Tc3cs0nvQpJpSC755XUnl48gNR
	m5Ut+Of5fAFdhQScOFtUgqSLgjRjadwbq+fxSoUV
X-Google-Smtp-Source: AGHT+IF01SpZSY+TeK0oQLIvPCCNUcDIL69Ivnltnsxt7pHJQs+F1yXemW7vyQ28tym2MYR9Nw8Ntw==
X-Received: by 2002:a17:903:1ce:b0:220:d909:1734 with SMTP id d9443c01a7336-22103f16a3emr310560235ad.14.1739997245505;
        Wed, 19 Feb 2025 12:34:05 -0800 (PST)
Received: from archlinux.plaksha.edu.in ([202.164.41.66])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-220d53499dasm107791355ad.12.2025.02.19.12.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Feb 2025 12:34:05 -0800 (PST)
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
To: gitster@pobox.com,
	christian.couder@gmail.com,
	git@vger.kernel.org
Cc: me@ttaylorr.com,
	chriscool@tuxfamily.org,
	johncai86@gmail.com,
	ps@pks.im,
	shejialuo@gmail.com
Subject: [PATCH v2 03/12] builtin/verify-commit: refactor `cmd_verify_commit()`
Date: Thu, 20 Feb 2025 02:02:51 +0530
Message-ID: <20250219203349.787173-4-usmanakinyemi202@gmail.com>
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
 builtin/verify-commit.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 779b7988ca..ae0c625777 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -64,8 +64,6 @@ int cmd_verify_commit(int argc,
 		OPT_END()
 	};
 
-	git_config(git_default_config, NULL);
-
 	argc = parse_options(argc, argv, prefix, verify_commit_options,
 			     verify_commit_usage, PARSE_OPT_KEEP_ARGV0);
 	if (argc <= i)
@@ -74,6 +72,8 @@ int cmd_verify_commit(int argc,
 	if (verbose)
 		flags |= GPG_VERIFY_VERBOSE;
 
+	git_config(git_default_config, NULL);
+
 	/* sometimes the program was terminated because this signal
 	 * was received in the process of writing the gpg input: */
 	signal(SIGPIPE, SIG_IGN);
-- 
2.48.1

