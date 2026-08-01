Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C396B48987E
	for <git@vger.kernel.org>; Sat,  1 Aug 2026 17:41:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785606121; cv=none; b=mPKOoogjMScGtQjT6jfQt5rADNUKiuYBb99ko+4u6r+vPMecfkb/rviNVuTyeJma3N/0aP50QGi/AbOau6gfsi6q4aUEjbsCvhBWw849jA6FbsUQaRH566kOM3THrvLwfwdNZLppnTihrjine6bCQbwE2uJCMsWEe/JRgRUGLMg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785606121; c=relaxed/simple;
	bh=pXtnb3FzOm8AzReNdtQuRwhrY4a3kNWGKMQdByU2PnM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Ab3efnfS5vIA+XBcGmTXXwidCTC5EGDTtblNIP+WX49AyMMKO9wZfWnzEBnuUvsq/Kr8AMo+8ahT4oqBuR9w/e0oODD0JAjQ4zXPTvNGB5gUzcmGBkcEmi2IiPpXn3hYMe9DpHxlYTOIvL0BVE1SxQUC17JZCmDnvjpiYycbxlE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QT02kylm; arc=none smtp.client-ip=209.85.216.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QT02kylm"
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-38e08baf860so1942757a91.2
        for <git@vger.kernel.org>; Sat, 01 Aug 2026 10:41:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785606119; x=1786210919; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=KEUfRELN9xIDcq+kNn7AiQCo1355PPXjNlWMX+WQl1Q=;
        b=QT02kylmi9TSDFjJWkbZukgUUEyhcaIs+Amyk7k7I6QuWrI1xWkjIpjma79OCRWZk7
         Y+GpK9pfvJy4OFec/crrFFqHKcCdl95W5QmYyXlvckPuIr9yRlPbeA497Uf9JMNQcScC
         JTIoS3Z32UlHPt9ZDULagu7ApYrI/k/L5SW4Qrj9pvYTDORjAWMK+sj8Y2toN9s7m+Jl
         +0N1KnBYKBibUCNoKLBag982MJ9iGDL0CoUfxwNN2RVuTqmda4H/r/nXwhK6Mhkf+5he
         cG3xP2lDaxiGOfL5x2/8m/uPXg7nJJYMuBqeiaCO2ISceAlo1s+cFbz6RtJf4dLiUQiF
         ypkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785606119; x=1786210919;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=KEUfRELN9xIDcq+kNn7AiQCo1355PPXjNlWMX+WQl1Q=;
        b=ePWZ9+WmjLrtJbDj2Y65o6EUsXIotYkvstkT+5P50FRPjchkhk1xM7mRXCFfAtP9CU
         hcOh/FLukH6UR/MziTRthOfKWBw0cLwcYKBYmtL65pk6Anq06JOlwCzgPZoPysYkje8H
         yY8zT/cnbxct7Ezd8tYB5EraWg+0gsI9m8Tl4HRl563FzUw28y94tiDKr++ZSDXxk6Jf
         auwGaZ4fE+vj1zroJElSl3tYLa7JWJgLSfzgew8oL2qiE1x/B0TDPzg0hwF6ZDhmhYsX
         P+EmPHSkkBqPmyU0n4I+OsTe3sj47PUfNz7FMGpLCiWD/uQMfrQuYJ8rljfYEIx5GsNu
         ThBg==
X-Gm-Message-State: AOJu0Yzhs9pvXPsj3MBwuUKSxDwyHhG8LZjMC52gRCf0wVLnu2kJ1hbm
	R/ee5VXFcVeJKIepdQ0MV0+4DJUiEqsYjbcyatazvd6/CIZf39cltq/tiX92GA==
X-Gm-Gg: AR+sD12qsJsBQ5yXN6PG2NhorYKzR7mcIjstoSuFuj4oDGf6l52TkNuqiwrGRhajz62
	/LArYcpVHMzHrBTrSxppqlOkOKekfUxa8qdQWrXuNxSqRHqBZVE77CBMW9k5oHg8YzHwjcce2De
	8hl2ZVmZyel1FvAsfUSY25T9K0cPqnIzWev6O9iDMFcIU3GAVQvYClUnMugPrExxGn3SHq0gBO3
	vpMa0WkqxjzZWiNS8LZtrOdvR2qKnmbtTkRZBPTQWI4VuCN4k34BMhbpxocwuol6TDAQbd2cYHu
	HNyrOjkTfAbchBHfo7QXwJk3hVslWz68TIzKLRka2O+thHimGVzYIgoexXRJMXaSsnc+WsX2ENI
	PqWn2FRoPNAMmF6ankv6ucLmUtb8v5mF03GxntVWNN7Mu8nCZLXO2lsyULlpX/9WfDXGJ57RGPS
	iKRwnF5ILZOy3jCkyefYAq2Fna1oCizuGa0/yZ6NwdPw8gSfcDFEEvNc3fKuFu3mhfL3WalR3nL
	mkOTHyWUKMbYVI8+w16IVz6WQ/sDPXX6CkMDQ0KBQXI4/PKthxT59DCoFRpcbWOZiMYN21CPkYk
	tch1LXtkWNIb6+eQuqa8D3AmwJ0yfush6lQT5Syql8Q7/Q==
X-Received: by 2002:a05:6a21:3511:b0:3c3:cf9b:fb8b with SMTP id adf61e73a8af0-3c92a90579bmr4956647637.68.1785606118894;
        Sat, 01 Aug 2026 10:41:58 -0700 (PDT)
Received: from localhost (192-184-169-91.fiber.dynamic.sonic.net. [192.184.169.91])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3153e045022sm18450658eec.18.2026.08.01.10.41.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 10:41:58 -0700 (PDT)
From: Michael Montalbo <mmontalbo@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [RFC PATCH v7 01/10] gitattributes: document how external diff drivers relate to diff features
Date: Sat,  1 Aug 2026 10:41:44 -0700
Message-ID: <20260801174156.2998808-2-mmontalbo@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260801174156.2998808-1-mmontalbo@gmail.com>
References: <pull.2120.v6.git.1785091889.gitgitgadget@gmail.com>
 <20260801174156.2998808-1-mmontalbo@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The "Defining an external diff driver" section explains how to
configure diff.<driver>.command but not how the driver relates to the
rest of Git's diff machinery.  In particular, the command only
replaces the textual patch: word diff, function context, color, and
the like cannot apply to its output, while the summary formats, blame,
and git log -L do not run it at all and keep using the builtin diff.

Spell this out so the scope of an external diff driver is clear.

Signed-off-by: Michael Montalbo <mmontalbo@gmail.com>
---
 Documentation/gitattributes.adoc | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/Documentation/gitattributes.adoc b/Documentation/gitattributes.adoc
index bd76167a45..da773e2924 100644
--- a/Documentation/gitattributes.adoc
+++ b/Documentation/gitattributes.adoc
@@ -784,6 +784,17 @@ with the above configuration, i.e. `j-c-diff`, with 7
 parameters, just like `GIT_EXTERNAL_DIFF` program is called.
 See linkgit:git[1] for details.
 
+An external diff driver replaces the patch Git would otherwise
+produce for the path: Git runs the command and shows its output in
+place of its own.  Output features that post-process Git's diff do
+not apply to the driver's output; word diff, function context (`-W`),
+`--color-moved`, and coloring all act on Git's builtin diff, not the
+driver's output.
+The driver is consulted only when Git generates a textual patch.  The
+summary formats (`--stat`, `--numstat`, `--shortstat`, and
+`--dirstat`), `git blame`, and `git log -L` do not run it and
+continue to use Git's builtin diff.
+
 If the program is able to ignore certain changes (similar to
 `git diff --ignore-space-change`), then also set the option
 `trustExitCode` to true.  It is then expected to return exit code 1 if
-- 
2.54.0

