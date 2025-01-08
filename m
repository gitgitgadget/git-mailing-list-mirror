Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37FE5126BF1
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 19:31:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736364711; cv=none; b=aBasf4NYg+UoeDTj6Svl8x34Xg8r1R9G/4tV5JXj9FLVD/A9JloWtjobVOrP6DjmKu6T1eOWxJwQAYT3myLfnwn6Vd/RA3GdqYdIa737bEoWFfCEBf75EhYUGllTMl/XKlX4MnI5u5NUnrXohPsiZfWSLkzl9KuT9LA1DgpjYq0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736364711; c=relaxed/simple;
	bh=QpheFLJhQPqbAqoETj1/5bSDHXhhpsYSlqosoNnU8iE=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=ZWQKt5+53oIj3Ogwor3ExTH0c4RhWdCOvYuWc0RuoYY9iR8yGhM8KmJZ+XZzFvN7pAjVJ7qCWMDg6gLXntgVgjjqxwdEzVJwMrWdKL//GFvNMKhJZhM8lFsTpUL1va4tu8rzisph+xzAerHiaPR7PXq5rhMh2oub+w2B2+aVdME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=awK0n/UA; arc=none smtp.client-ip=209.85.221.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="awK0n/UA"
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-385de59c1a0so71422f8f.2
        for <git@vger.kernel.org>; Wed, 08 Jan 2025 11:31:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1736364708; x=1736969508; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=2WZX6Q9x0kWTdAGRx/+GgN+LKXh7rUYR758h+Z3ISzg=;
        b=awK0n/UAuksS4eBsZn4OHzcQWLfZ39NbAvVJy+hWPrhNd6+s64gmhauwpPqfQG6gEy
         fFFZz2qX7Sqpj/IrsdDvjgba6YaLH1qx2uzWYG43+bIJnXjx5QVZqtG1RU39WsNg32r3
         WTdIMkAthzss1VLmAKz5V92Yy9Mhgy2hQP2RBZgghajg6aP4SVrtl/3UPW36kl/hjdd6
         G3a7Bkfu3F6WdOjFtYYvSbeKHwe5XcMeXSYEBpzoSmY1X+C7q6PqyUHtqgOZYuTyQw2o
         x53nw2jkD5flY0/bmo/LZWTrnS1l977j2NxWZsZf2iktiTjPsVGveUPlZw7+bPb+2VYp
         evcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1736364708; x=1736969508;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2WZX6Q9x0kWTdAGRx/+GgN+LKXh7rUYR758h+Z3ISzg=;
        b=pXLpodRtvVAO6TC1XZ1PrvI/x2REq+Iu0DfrNWv2MmWSOqRSdH80ElDKjEehrufTy9
         NnRbWj/wJvIbapVmvg0tb2BNUB5kIjDxLqYXOUh9O6QHtU+ajdrz+esS0oBiBmjBm6oG
         FDfB14tg4ZWYSJvtzv6ZNn4yw6hHe9fMTh3cWJ52clQjKf+3ZcN6ByXjLJo2bQYPkfmZ
         JORDjMXdtlilQiNtO3QOCYWCboqikm+T6VrkzJ9YSTGqLzlgcN2HMcwljZPHZUiWuAZI
         IERqlEfjP3xlHh1Sil7kURy8kSd8kPXub5uxQexzENMr7sIeKNZQOwsOu22mcoe0+Jcy
         qLOw==
X-Gm-Message-State: AOJu0Yw3ZTzRMRcpWvzu9hVA5SvueUZz07pCVtDy1zQ+VU/jgQ61s90v
	iUNmG00Mmzgu8uPWFTfiwQNb7Nsjv/L3eSmEJ50c8chChQD1LxeOl/FCWA==
X-Gm-Gg: ASbGnctdaCsBVFKF96fy4b6leAvq+KOZfGtxFlPuozrLkOedHtCrPYz2IYVgxGEbtHu
	flT+c7GM/2oj3OPAt/CB7dXmYVTc/TxbDv9qr13QqP3RsPzizng2uvCBvUDwyI1R+sfAihGI+n+
	xvEWBVPR7VUsHbzhz5tjTDkl96FpxL3PlzBt8g2P/7aKgB1yq8RIv/slOfwi8wNzPTBdajsIeRN
	ORf3ZBGHm3Un9g1jOMgfIhf/c4sTj8jocEhIBVN0HW394ISMbGb+jIdXA==
X-Google-Smtp-Source: AGHT+IE7w9DcAFaQ6llIKKV+U0IBgQquigNPgdN+t6KdpsbrjebJ5UjG7zp85uk86VwvI42EWPpb/w==
X-Received: by 2002:a05:6000:1fa2:b0:38a:1b94:ecc1 with SMTP id ffacd0b85a97d-38a8730afbcmr2820537f8f.25.1736364708064;
        Wed, 08 Jan 2025 11:31:48 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8a6e19sm53379051f8f.100.2025.01.08.11.31.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jan 2025 11:31:47 -0800 (PST)
Message-Id: <pull.1869.git.git.1736364707068.gitgitgadget@gmail.com>
From: "Scott Chacon via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 08 Jan 2025 19:31:46 +0000
Subject: [PATCH] help: interpret help.autocorrect=1 as "immediate" rather than
 0.1s
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
Cc: Scott Chacon <schacon@gmail.com>,
    Scott Chacon <schacon@gmail.com>

From: Scott Chacon <schacon@gmail.com>

Many people confusingly set the "help.autocorrect" setting to 1 believing it
to be a boolean that turns on the autocorrect feature rather than an integer
value of deciseconds wait time. Since it's impossible for a human being to
react this quickly, the help message stating that it's waiting for 0.1s
before continuing becomes confusingly comical.

This patch simply interprets a "1" value as the same as the "immedate"
autocorrect setting, which makes it skip the 0.1s and simply say that it's
running the command, which is almost certainly what everyone setting it to
that value is actually trying to do.

Signed-off-by: Scott Chacon <schacon@gmail.com>
---
    help: interpret help.autocorrect=1 as "immediate" rather than 0.1s

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-1869%2Fschacon%2Fmaster-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-1869/schacon/master-v1
Pull-Request: https://github.com/git/git/pull/1869

 help.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/help.c b/help.c
index 5483ea8fd29..e6576644b99 100644
--- a/help.c
+++ b/help.c
@@ -568,7 +568,7 @@ static int git_unknown_cmd_config(const char *var, const char *value,
 			return config_error_nonbool(var);
 		if (!strcmp(value, "never")) {
 			cfg->autocorrect = AUTOCORRECT_NEVER;
-		} else if (!strcmp(value, "immediate")) {
+		} else if (!strcmp(value, "immediate") || !strcmp(value, "1")) {
 			cfg->autocorrect = AUTOCORRECT_IMMEDIATELY;
 		} else if (!strcmp(value, "prompt")) {
 			cfg->autocorrect = AUTOCORRECT_PROMPT;

base-commit: 14650065b76b28d3cfa9453356ac5669b19e706e
-- 
gitgitgadget
