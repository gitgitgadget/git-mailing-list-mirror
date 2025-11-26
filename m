Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A623E2ECD37
	for <git@vger.kernel.org>; Wed, 26 Nov 2025 10:26:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1764152764; cv=none; b=KtP6PBikx9QjtcLctPqRkv5/KDdOXJOD568JCyeaT3O7BLrKkjooAQ0iJqQTLrcxZIQ5nROVJW0wd+7cZ9MwSm9HctyJ9v2QIee+AHu481hxa8hEEYW7istMRFWcYxczzgl8bs7nPMxxq+fbV4GZQiAQu53tlUMfWK2Pd1/DHuI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1764152764; c=relaxed/simple;
	bh=TorFOTT2n2654sX0g52DwaitW8Zw3whH+CMEkXjGseY=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=TdwMNlH+8F8YoD41pupi5oEp68zPhXIZ3523gp1qXov6C5jTwBJkavfzSf5ejKh7LuBKO2+511P4xCjFTYIWHZBu4w0wuurdhZwG0bUuOt6JqSQfYNWM8lEyy+9bTE/LpURdKhzcwxelcDPrrxrbm4VNwCnVfOIfctQTEJo+HO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PXKhzH33; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PXKhzH33"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-433100c59dcso24973305ab.0
        for <git@vger.kernel.org>; Wed, 26 Nov 2025 02:26:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1764152759; x=1764757559; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=vu+xgjdv6tIRko8LM3mCMosTMC7/ghXQ7L1aqYAQLHE=;
        b=PXKhzH336qJleK9zIsX4pscwdqWoPoMYJvrQEo6fAoEccGcJ3Hh/3xRuw0gsMAbZeP
         1gXPFH3R4tR7LKC4gZPsLKEqaIHM2O8dn6mYBhy1bhVMrv6cGvQEBwgNDImTLukJ96CG
         YS0LSD1HUt2bq1n/TA1qruL0m0vhgMHhQKSt/4cU0IPaVLa+hk8ircFOxgUB4ov/D3n2
         25n5K2H+2zADZfvRTIvvlupkIJoHq6nyk+0zhP6MFD/yVx8dqhmoKHBJQrM8e+0wkxhw
         S4YI0YIFN4qvy/3HH0Y49gzXJh733ZSZJbuXGq4fpnf/pdT1aUnHQlZ3Dg+J5iimfDwY
         X2Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1764152759; x=1764757559;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vu+xgjdv6tIRko8LM3mCMosTMC7/ghXQ7L1aqYAQLHE=;
        b=fTj0nIsHx75hi8vulYrH3AQmMaj2hg5ZY37ZZFhlUucKlBXBplPt7GK+r75t37uPE5
         nQ3AT8SoiflSKtAcwaXNOlmi6FOLEKMRogsTrhK0ymeUMmh+aYijJxYNjfnDiUGXhZNb
         8gdbBAJpLaLCh0bqFoaqXzt31suu2fT+JUuv2X5e4gWNtJrGcv5gQKXA5f5/qeHoQ+fx
         3Ac+XYoOZSHmcEFEuuEdRcjpiGIASDL1Ld2LGOxV9D+eNb8dhQ4iyMyL93F8nnxToBg2
         qyCVAoRaKtF/5UpXTo64Gu2PN1D05khiZYzhOxUvB+7u74SdICRa+xzBiIHbMKCo5dD9
         jIuQ==
X-Gm-Message-State: AOJu0Yzhc6OtSdViRGiQRyvyUmkHXRjMbRL9Xg6u05lwpxk36sAJALLA
	S3UmoDF3jy/1u71MOz2rwCvn9zch3mw9RVwqcEL50+VjYKZ1rrlALt+QM7BpKA==
X-Gm-Gg: ASbGncsNgOjUWzWheqwwZ4c0y2s/sN2VdPhsWXFnZb7/+5XkJQcyY4MERe68kD+1/qf
	NNNuikjpUqOawNhq1oNAoCwOKRFqsHMGeYLEhaleHu5ASDyv2WwFutH9sjR0UnmpTRj7rkHKc3Z
	JKEmHX8+qe+oHbLn0rfbXxnRMVSEIS+mr1bxWCMGVcyA1obrvAeNH8035qkcSwGLRwCRsDIFfWk
	22XiFSCBcsM6w+mZiWJIIIKlT04mAfTk++Yr+ROOdzR/jBTBirRw919W0+HlBVoyOAbV7jTMBDN
	GdiWQCGs9fSFEHS4rp4ZiQ/S8CfsFsYp7jDfgeLl4kWR315mfhSpYhuw1/AaNZ+JdBtw09165YQ
	YfRG3c1jE/UOS/O45igRtN3aue2RhqewSsHpbun5f/SHBq/K1FveGbw+5wddeEh3wK+44p/E/LZ
	1yQ6Jo4+KF5kKYl6k=
X-Google-Smtp-Source: AGHT+IGou+0duMuh/DGvyGAyKj1QK2ASu1biOjWnVmzkk3WDKzA0NaTErtOreDw24f8TbdV0u9gtNA==
X-Received: by 2002:a05:6e02:13:b0:433:7673:1d with SMTP id e9e14a558f8ab-435dd1252cdmr61915335ab.31.1764152759296;
        Wed, 26 Nov 2025 02:25:59 -0800 (PST)
Received: from [127.0.0.1] ([135.232.201.224])
        by smtp.gmail.com with ESMTPSA id e9e14a558f8ab-435a90b6dedsm84910935ab.18.2025.11.26.02.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Nov 2025 02:25:58 -0800 (PST)
Message-Id: <pull.2109.git.git.1764152756908.gitgitgadget@gmail.com>
From: "Yee Cheng Chin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 26 Nov 2025 10:25:56 +0000
Subject: [PATCH] xdiff: optimize patience diff's LCS search
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
Cc: Yee Cheng Chin <ychin.git@gmail.com>,
    Yee Cheng Chin <ychin.git@gmail.com>

From: Yee Cheng Chin <ychin.git@gmail.com>

The find_longest_common_sequence() function in patience diff is
inefficient as it calls binary_search() for every unique line it
encounters when deciding where to put it in the sequence. From
instrumentation (using xctrace) on popular repositories, binary_search()
takes up 50-60% of the run time within patience_diff() when performing a
diff.

To optimize this, add a boundary condition check before binary_search()
is called to see if the encountered unique line is located after the
entire currently tracked longest subsequence. If so, skip the
unnecessary binary search and simply append the entry to the end of
sequence. Given that most files compared in a diff are usually quite
similar to each other, this condition is very common, and should be hit
much more frequently than the binary search.

Below are some end-to-end performance results by timing `git log
--shortstat --oneline -500 --patience` on different repositories with
the old and new code. Generally speaking this seems to give at least
8-10% speed up. The "binary search hit %" column describes how often the
algorithm enters the binary search path instead of the new faster path.
Even in the WebKit case we can see that it's quite rare (1.46%).

| Repo     | Speed difference | binary search hit % |
|----------|------------------|---------------------|
| vim      | 1.27x            | 0.01%               |
| pytortch | 1.16x            | 0.02%               |
| cpython  | 1.14x            | 0.06%               |
| ripgrep  | 1.14x            | 0.03%               |
| git      | 1.13x            | 0.12%               |
| vscode   | 1.09x            | 0.10%               |
| WebKit   | 1.08x            | 1.46%               |

The benchmarks were done using hyperfine, on an Apple M1 Max laptop,
with git compiled with `-O3 -flto`.

Signed-off-by: Yee Cheng Chin <ychin.git@gmail.com>
---
    xdiff: optimize patience diff's LCS search

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-git-2109%2Fychin%2Fpatience-optimizations-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-git-2109/ychin/patience-optimizations-v1
Pull-Request: https://github.com/git/git/pull/2109

 xdiff/xpatience.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/xdiff/xpatience.c b/xdiff/xpatience.c
index 669b653580..13ab0d591c 100644
--- a/xdiff/xpatience.c
+++ b/xdiff/xpatience.c
@@ -211,7 +211,10 @@ static int find_longest_common_sequence(struct hashmap *map, struct entry **res)
 	for (entry = map->first; entry; entry = entry->next) {
 		if (!entry->line2 || entry->line2 == NON_UNIQUE)
 			continue;
-		i = binary_search(sequence, longest, entry);
+		if (longest == 0 || entry->line2 > sequence[longest - 1]->line2)
+			i = longest - 1;
+		else
+			i = binary_search(sequence, longest, entry);
 		entry->previous = i < 0 ? NULL : sequence[i];
 		++i;
 		if (i <= anchor_i)

base-commit: 6ab38b7e9cc7adafc304f3204616a4debd49c6e9
-- 
gitgitgadget
