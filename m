Received: from mail-ot1-f46.google.com (mail-ot1-f46.google.com [209.85.210.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3283336ED4
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765981143; cv=none; b=EEtQwsBOzAzhExOmixuDwqe8IF1TX55hujqgDknoQa1PCFOI2E4GwylA+O9XBPVj3LblPJxVMZ8cjPhylSQsrIp9gSNQTSXyhW08597zOEraJIu+7rkLCAoiMNeC2eskxDb0TjkjlSsAVQlUHHho0vPzsGMAOYo+OthKy/it8a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765981143; c=relaxed/simple;
	bh=O6EElKeKhS/+ysBMW1WfpuWyFSwKhNdEdQuMPUOF9X8=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=fAmf1s5kX4coTj72ZjGkHYDESNGbPuUYzIzFNWLaRkZ6kTCXpJsuZYeStNQ5iMYkmaDz+VYQ76BD97zvo9VS7uVfe+r8udsKUo7nPHpRiz/3VhTf8DYoenqDukYYoRCHhui8OExOLtiPF6MGZ+CMZKef02CGimziZzaq5SsI6rc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BLzxpwmj; arc=none smtp.client-ip=209.85.210.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BLzxpwmj"
Received: by mail-ot1-f46.google.com with SMTP id 46e09a7af769-7c7545310b8so3267371a34.1
        for <git@vger.kernel.org>; Wed, 17 Dec 2025 06:18:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765981138; x=1766585938; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1v95A+ZphT0efPuJgA2huEtwXQ34whmACedkSr3ysbY=;
        b=BLzxpwmjlnG6x5dpKhjZb/N0izEWLVOfp90Jf0tLIV7p7Gn0AnugJwcutyAdmPwJ2U
         BTCTOOpH99LYviSzSMOOskVIh+qtBZZBxgt8CFraBIaLV/4ubTpTE1ybAcuip2NC/WH7
         nllK2XDQ/hpNbVnXKrCqzM33/yPVwrvOfyhvQC3g0DlsMtKwsfKeZ4535zlNfNplp4j3
         g9EOLJQhsUZ4gQ44AB2FTmUkfDQHSxOpPw6dFiI3G9I9pDLVdk/TI9xFJtodXwuh/Rx7
         fK9hyhUkDJz3ZEsrDLrojmxu5kFd41O4xEOJlRGtpA+ZyxhYe+EtlZRrXQrPw9pYugRr
         nJYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765981138; x=1766585938;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=1v95A+ZphT0efPuJgA2huEtwXQ34whmACedkSr3ysbY=;
        b=HauQhB6GAD3oo3gy9I674wqexVsvAMe7LDSfj55gJHwwQMdVjca7A+AXJ7dvpRs8FD
         kfOw/qFV30putJICtewSUeF/lBPaW9tnbxcGrx96VPdjTZXq8gNnqmBW31jXFvQ5Uk7c
         7IfLBqWQ8YCqT/3staQEbaYnBjT2782HBheIxDEELZuLmHqjn3+CLPB53++eUt/SqvCY
         aa4MP4bGo9yeYCB/IDlthIG4Nzib5Y6nsBTY1LYOr6y2zLh/x/e9CTrtBnJnYdMKP63P
         yWVJmqjmcSOSc6/9xdiQNfLtqxbtsb++LHtTTMjVhLLgIG8AhQYLTd75swVsRzW4YQFy
         lpCA==
X-Gm-Message-State: AOJu0YwVRCmGe3HzrGYcai6vvJljpy3ameLk4wYdgRZDSz4c3ymCtL2f
	VSRO5+VnfDclB96L+nrTNyto/a7+sEEGQC8djQTGPLPYRUTFzvqgxPv6AantgMUjsyjJSg==
X-Gm-Gg: AY/fxX5v6Uo4gw6svaRKukdsDhbIddpGgjgZ4tseAGO4fLwtK93zVmXbuefYNGq8HPH
	iz4UOT1I/Y290Aq+jmqTZN8j4/8ADDfOivzrJJv1HOzaO/N5LAccIN+slErSoUjuZ2EkYjEQ7tQ
	YKEqCp0xM2cxflw5PfGOp3SIH+4N6tNfo2owfGYv126MHD42PrnfXE6fPc1uPqrsn7jZL8YXbSR
	6oFUvPb6hfjnMpLp7Anq62gOEFpXz4TtGzQXjiO04644vCf0F40Ri1Tn+jMXrlcPee0+ToyMgez
	f3bqpitVa4rZG7PZIhoeSZKqZho25UAIV3YxV4xWlDnXEBNO24ET5kqZdktRJgYHwr2/ENkmpY7
	egLtHysZUlOM9t/4FiE2NI0ccfEP2MnghEtXDn6XHTrmtHvreGy89HNi9Ri83qLAEJ8wTVScrEr
	3myCMiH/BadYqJ
X-Google-Smtp-Source: AGHT+IGWdLHs/NdbIXPvY83X/rT6itnSUTYDjywd1p81QOIDS3Jct1lZszzklFaFwwJkMyPqZKoW8A==
X-Received: by 2002:a05:6808:bd5:b0:450:32d4:3d17 with SMTP id 5614622812f47-455ac92c076mr8969928b6e.44.1765981138062;
        Wed, 17 Dec 2025 06:18:58 -0800 (PST)
Received: from [127.0.0.1] ([135.119.38.57])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-45598b47de4sm9610445b6e.1.2025.12.17.06.18.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Dec 2025 06:18:57 -0800 (PST)
Message-Id: <37f9614ef5c62ef9619c43acdf9b26e81b99940c.1765981126.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
References: <pull.2009.v3.git.1765885577.gitgitgadget@gmail.com>
	<pull.2009.v4.git.1765981126.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 17 Dec 2025 14:18:44 +0000
Subject: [PATCH v4 08/10] t1305: skip symlink tests that do not apply to
 Windows
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
Cc: Eric Sunshine <sunshine@sunshineco.com>,
    Patrick Steinhardt <ps@pks.im>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

In Git for Windows, the gitdir is canonicalized so that even when the
gitdir is specified via a symbolic link, the `gitdir:` conditional
include will only match the real directory path.

Unfortunately, t1305 codifies a different behavior in two test cases,
which are hereby skipped on Windows.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t1305-config-include.sh | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t1305-config-include.sh b/t/t1305-config-include.sh
index 8ff2b0c232..6e51f892f3 100755
--- a/t/t1305-config-include.sh
+++ b/t/t1305-config-include.sh
@@ -286,7 +286,7 @@ test_expect_success SYMLINKS 'conditional include, relative path with symlinks'
 	)
 '
 
-test_expect_success SYMLINKS 'conditional include, gitdir matching symlink' '
+test_expect_success SYMLINKS,!MINGW 'conditional include, gitdir matching symlink' '
 	ln -s foo bar &&
 	(
 		cd bar &&
@@ -298,7 +298,7 @@ test_expect_success SYMLINKS 'conditional include, gitdir matching symlink' '
 	)
 '
 
-test_expect_success SYMLINKS 'conditional include, gitdir matching symlink, icase' '
+test_expect_success SYMLINKS,!MINGW 'conditional include, gitdir matching symlink, icase' '
 	(
 		cd bar &&
 		echo "[includeIf \"gitdir/i:BAR/\"]path=bar8" >>.git/config &&
-- 
gitgitgadget

