Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 030057710C
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 03:05:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730775917; cv=none; b=M8HrPROlAQxrmlmTwGJ9w6kTihR+M1lzFPYitSOvMRbxlYH9OM3EON6wl7RBMV28Ufc6CE/F9edqUV0A0jiF7WtRU7C8PyWML+1B15S5lk5cWYS3B7mFvF4kP/50Z2Vc75aFYAK1fG1OB9VIHY6dn6q59cj6Zfpq4j7kM5vuQwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730775917; c=relaxed/simple;
	bh=gRpljDWjR3OMqD0aJV440PpLHuXp9KN/OJYg2UN4KPM=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=YiZ0UlzRuC5MwO/jobROigTZ6tlqO5fN/tyIDQDXAuA2/45y1Cx3/8x9zR88XOKO6V+pGsEa13E1AZFX5ThCpc/V3L+b06JMs4qygpy6IQyStp5sxUZ2bwccndulJZ0KiJP6X6dId2vGA7uIJsDWG7lK7zWnHPW7/BbJmdoVvUc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=As1+5nRa; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="As1+5nRa"
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-37d4fd00574so3254922f8f.0
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 19:05:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730775914; x=1731380714; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xs+Pht2+gzyD7dxVpUnI8S2Q1uLapJ9F7I/UQvTS+ww=;
        b=As1+5nRah2bL64hIjjwSQG4pllxOsntngiSQeN+Gh6JgAr31YHq7ioGA6xBkkFQue4
         YWxWpgs2v2WWRaIasIdJnlfyblH4/KVGI7ykcVNbJWpK5d30DnMPa5fXTIQb4V+1Qt99
         fDRXZk90/0h7OQPc5gHnUgdwl6WiKIEStdw5zNWHIm/XCuT98ALSUpl6hxAh1J7S6gRL
         Kvbnsxab3Be5ut4OH46jgpAqSHD2fvE0BP4Nn6DdWsZ0ZcLtTBEY9UGljsoVhibs+OEV
         6V2JxwDmViT8BfmsoJZsx7E4W+gSikDkoG1JwbCUK9IAmwBQI/GUfqs1byd5cSEA+92j
         QY5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730775914; x=1731380714;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Xs+Pht2+gzyD7dxVpUnI8S2Q1uLapJ9F7I/UQvTS+ww=;
        b=sM23FIeYJdaO0a+jrrGfXjg5ZKXI/EURDqfk6A+qL6fD/bzZUAkUub8FxXZJlvyPPV
         ZBYxkxWumA+UYrVg3nvNnwW7vjSbeC2LIgJFkFWBLQ99mSr/jMUk30AZncI3SAog0FGF
         OFOnpatPh/xnWbycr9whLE8Ka+xd/52F9dPG/YIoAXDJTsQZDeaNi5NDHZOnP6KGx1wV
         YUQ5sC62BhrjalmutI5Dwrml+mS5ZUUqWWoXwaD7ZN99TZXDxupmO6hJ3Mvh0VYnBGJY
         d85Bx90nE5uIRGhEHEXJXrjNonFmBHi30ZEjfTWzWDyuHCH2ozw/OUwl9cArzEBzgbA9
         NrNg==
X-Gm-Message-State: AOJu0Ywb0osAdxzbR81X3OgAmTkhh1XxnhAdjm7E2LXGarj1+0sdD+A6
	9KvHnekBo9uKr1g2033KN5iFMUdtk2CHpKi1tm/1L3iGUHMA4U6bScvWhw==
X-Google-Smtp-Source: AGHT+IFegWYNIDrBxd9NRiZSedOwnoDeAR+bCKtr6mc4hN7id6F+OHP6g5mLbb667uAB/NrmRU19Gg==
X-Received: by 2002:a5d:5f93:0:b0:371:6fc7:d45d with SMTP id ffacd0b85a97d-381c13069b6mr15956822f8f.2.1730775913704;
        Mon, 04 Nov 2024 19:05:13 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-381c10d439esm14757705f8f.44.2024.11.04.19.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 19:05:13 -0800 (PST)
Message-Id: <65784f85bce943e6a6bf29d7a57bb106aff8226b.1730775908.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
References: <pull.1823.git.1730775907.gitgitgadget@gmail.com>
From: "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 05 Nov 2024 03:05:04 +0000
Subject: [PATCH 4/7] git-repack: update usage to match docs
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
Cc: gitster@pobox.com,
    johannes.schindelin@gmx.de,
    peff@peff.net,
    ps@pks.im,
    me@ttaylorr.com,
    johncai86@gmail.com,
    newren@gmail.com,
    Derrick Stolee <stolee@gmail.com>,
    Derrick Stolee <stolee@gmail.com>

From: Derrick Stolee <stolee@gmail.com>

This also adds the '--full-name-hash' option introduced in the previous
change and adds newlines to the synopsis.

Signed-off-by: Derrick Stolee <stolee@gmail.com>
---
 Documentation/git-repack.txt | 4 +++-
 builtin/repack.c             | 4 +++-
 t/t0450/txt-help-mismatches  | 1 -
 3 files changed, 6 insertions(+), 3 deletions(-)

diff --git a/Documentation/git-repack.txt b/Documentation/git-repack.txt
index c902512a9e8..457a793fa89 100644
--- a/Documentation/git-repack.txt
+++ b/Documentation/git-repack.txt
@@ -9,7 +9,9 @@ git-repack - Pack unpacked objects in a repository
 SYNOPSIS
 --------
 [verse]
-'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m] [--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>] [--write-midx]
+'git repack' [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]
+	[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]
+	[--write-midx] [--full-name-hash]
 
 DESCRIPTION
 -----------
diff --git a/builtin/repack.c b/builtin/repack.c
index ab2a2e46b20..e5f53a6eac7 100644
--- a/builtin/repack.c
+++ b/builtin/repack.c
@@ -39,7 +39,9 @@ static int run_update_server_info = 1;
 static char *packdir, *packtmp_name, *packtmp;
 
 static const char *const git_repack_usage[] = {
-	N_("git repack [<options>]"),
+	N_("git repack [-a] [-A] [-d] [-f] [-F] [-l] [-n] [-q] [-b] [-m]\n"
+	   "[--window=<n>] [--depth=<n>] [--threads=<n>] [--keep-pack=<pack-name>]\n"
+	   "[--write-midx] [--full-name-hash]"),
 	NULL
 };
 
diff --git a/t/t0450/txt-help-mismatches b/t/t0450/txt-help-mismatches
index 28003f18c92..c4a15fd0cb8 100644
--- a/t/t0450/txt-help-mismatches
+++ b/t/t0450/txt-help-mismatches
@@ -45,7 +45,6 @@ rebase
 remote
 remote-ext
 remote-fd
-repack
 reset
 restore
 rev-parse
-- 
gitgitgadget

