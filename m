Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com [209.85.128.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC01B2E6138
	for <git@vger.kernel.org>; Wed, 11 Jun 2025 14:02:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749650560; cv=none; b=cIQ2uuVu/AhDconaVrWH6DLIQrHz1bAC9FtelCWjzdfRHxO8sAakVokX5zW99+pxHhEqr18+NOAUhm91I0AJZzKlJk4qRr4Id1eGxya3OFAHt6qbIZMm/FSzgDYMARIc/VsoOrmNI/0soAjaFzF3Z/DDmm84a3X3U/wrDlObcaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749650560; c=relaxed/simple;
	bh=El+OzkCI4hBW27VlCl51IGQ/tWn67vb1PPN82ide7uc=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=CxRu+UdJoDOd72F9vvo3mdvg8n6y3p4AQum5gYvKx7nmSBykiLfuZg/jm1+YW6wT7FfSrMC11bZwtB9wqL1nRmfJb8hNWDms1Bqsdl0rCzwcjN1CD7IpHkhxMvQ881tlkRlwHnLnyYUukbynY+s9P4HxyGO+0AitgJSzmGgh90s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=D6kIpCJZ; arc=none smtp.client-ip=209.85.128.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D6kIpCJZ"
Received: by mail-wm1-f53.google.com with SMTP id 5b1f17b1804b1-43edecbfb94so81816995e9.1
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 07:02:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749650557; x=1750255357; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7yqMxrl893bvHTYqVMus6/HM9UqDLYkLnXamnEhJ2Cc=;
        b=D6kIpCJZ9w5ZxF0gvzpwdq8atA4FZdDyOhqtj9fjZN1QsWrFOfMEfKTbXQTmUTop6G
         NSZzPwicvpjhV/jU3qymoJyaiac5cqUWmUoul5MQ0IeUnTkDFB9gINEFST8E4LP7Dckn
         OgzHTQ5gwBQA4s/ZseeGe88ZNt2KLOZ2dDeb9UD8NTM+zXiNV8YlsVTbeT6iQvT9qlFh
         wtbZ7wjLeKZPutXEN3jIauXxLhmZaxOOvI9DMgqBReQH5BTBmAumd1fD1iobHLqC+eIa
         +VUXSXUxUrQQ9YzNEszyGfqUbfeRkQXgI9mTOctPxSM72H890hCPaRfXlVlMnoyMGYHq
         Znrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749650557; x=1750255357;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7yqMxrl893bvHTYqVMus6/HM9UqDLYkLnXamnEhJ2Cc=;
        b=kma/q+nX3uWB7I/7f1N+BXwn19X2WGWyr4Cnzkew3hzYV6/jtiZVWHCCjCAalcd1Cw
         5Lt2QM3MyV+86jLaetFA+IXBBWowkL+hJyK09V6QNxQE7mjEHsSuBTX9aXQqTovfA8zx
         9ykpGsP0RDy4JIoE5bxvmIX6+IKN9gNcMQyKkm0PHP8mOTB7RWe/qAMTRGAdfO+jHxDU
         wxGtDNFw4Ukk2U/Pr9mm0Ra6QwHeVQaaD9xCrz9mXQHtS6dUW6pAG39417PNtn3S7Q7N
         1rxQMCCkhD/MsZlhQtU2v6Rzfrts/Pw1RcV8IoOB+L9zW2kK2rG9OmPOfRVtgBmR4oPq
         TiZg==
X-Gm-Message-State: AOJu0Ywl+IwVH0eVRSP8M6z3bd7mkojmjtxkR8nMk4wPS8/Hf81rkyoY
	+s5qGmO9Vmz0RUp/SNOLfsEykHzimksKyiB/uLCsknk8zaE7+B6YRX6BnX1oaA==
X-Gm-Gg: ASbGncsJyNdLUpbrZXEsKsyIEc9PEwRoAI1haR0cc10qORX6IC0AzFdub8P+Q4+JENf
	s6BO0sqefLUCJRVSTbB0yV78PzlEY6sDN4VSA4orckFmBuKwzOdgPX0Edv5L8bmk1jhkhOFa0as
	agQvmL7mQyJKWA1jbi/2AWDrlOMQQdVGHk66VV3be75dy3J6AiQUh15EnS6UMu5qLBpqER/lFtC
	VjhZWQDbJMlMHpG3RoYSBdQl2zKb6OI2pbUZOntEeaDd7wDwUaug0wmpvNwSY2fBKS7nDRFvgTq
	Fm8+R+dj5DrABT2Pd+uWAv7yQtlhsGweXMTstk/pgMxte23Puj/omKGWLdapDFQ=
X-Google-Smtp-Source: AGHT+IHW+CQqWOkoZ5GLywGXiAhcY5D3PsaQpTFM9reH7ChwCLEz7ZfkvIodUH5/4/5TrtIuhJsZag==
X-Received: by 2002:a05:600c:8b08:b0:43d:9f2:6274 with SMTP id 5b1f17b1804b1-4532489444cmr35462325e9.14.1749650556143;
        Wed, 11 Jun 2025 07:02:36 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-3a53229de01sm15782323f8f.11.2025.06.11.07.02.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 07:02:35 -0700 (PDT)
Message-Id: <3a829f11c07ddbb0a57a1ac832db686f29a9b632.1749650552.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1934.git.1749650552.gitgitgadget@gmail.com>
References: <pull.1934.git.1749650552.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 11 Jun 2025 14:02:32 +0000
Subject: [PATCH 2/2] ci(coverity): output the build log upon error
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
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

It is quite helpful to know what Coverity said, exactly, in case it
fails to analyze the code.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 .github/workflows/coverity.yml | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/.github/workflows/coverity.yml b/.github/workflows/coverity.yml
index a5d99e59d4eb..1e8bd85ecd4e 100644
--- a/.github/workflows/coverity.yml
+++ b/.github/workflows/coverity.yml
@@ -149,7 +149,11 @@ jobs:
         run: |
           export PATH="$PATH:$(cygpath -au "$RUNNER_TEMP")/cov-analysis/bin" &&
           cov-configure --gcc &&
-          cov-build --dir cov-int make
+          if ! cov-build --dir cov-int make
+          then
+            cat cov-int/build-log.txt
+            exit 1
+          fi
       - name: package the build
         run: tar -czvf cov-int.tgz cov-int
       - name: submit the build to Coverity Scan
-- 
gitgitgadget
