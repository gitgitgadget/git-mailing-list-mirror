Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 38F8353364
	for <git@vger.kernel.org>; Thu, 22 Feb 2024 14:36:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708612612; cv=none; b=sD1tvkHIhY8Dbjw04vorV2CJN/aSv24SAxL9TH1gkPu6NhopRFioe4+0hc+m37KkoRL97hgFawOWnvXO79GFq4AScjf+SGqE8mF3rgexigWX0gJJ69vdd3U8OlnSD9BwzKVOIxWQwff3flYjmOBtvIFBrypazqTuIn6/A+ohgf8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708612612; c=relaxed/simple;
	bh=C05rXEareOoDG82WPd99xJmYGLU1fbzABBWmtXJTWMY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=P17I7reFWYwbZL/ILGCwFk0msgjcLOMLUWR/24RiDi7rNDstZwWPgaiptNCZ+0jeVSsjcvs3dZpz5huan902B1NkruJMvHr4Tynl804S2+/LcIxPNL2QpuCNn+9CbPwhY64ddNC9aJjHQ8arMZ9B6I65ciUJGfciydBXhSBd9Xk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Tv+A7Pjy; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tv+A7Pjy"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-41278553016so13759555e9.2
        for <git@vger.kernel.org>; Thu, 22 Feb 2024 06:36:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708612609; x=1709217409; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zzXXrTR1654PTduFx3oEOukzzhnQP7ss3KpbX4fLdqU=;
        b=Tv+A7Pjyk7MvMa8l5x+sOUmSeBcK5vnRn29CrhyjH5ofuLDwekH2eU8kAc/Ygmro79
         73/EWIR/WkyWjDOs7PULRcUX/2/q0nv1MM0xN8jsgIF6gYU+nT/f+DWwR8latHZnG06e
         4CtKnsH9PanzQfN0Wb7JPJmHH6yIF2kcgHvRrzZrZqjGo6YTI3CiOVazTiUqXB/vW3IT
         Ww4mY/kVqIHNlKqsi8j1/wViz/jE57wcZh549ShbB8Bh1cleBrmZRoC9u+GJgk80fPC9
         t5l6Cw18z78Juc/KqpVbgfq+jSB5qIdafRNW7FoULOSsh4GqxoSOg+ZBClOsi5bMOlvO
         NMfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708612609; x=1709217409;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zzXXrTR1654PTduFx3oEOukzzhnQP7ss3KpbX4fLdqU=;
        b=ToSs9pQ5BqeCrHBl1uLM2Olp+1sTQxAOgzMLv/M7qu0GQpSH7sEcoLTTQNsONyphDK
         ckhh4LMHLX0sNIK4z9/5lqJcSU9AgNUjFjJIC6AToC/FD+gh0Nkhnj4dR9okH1aPb+iv
         c8cAJD9EV+6M2RAnUGMz4KK+Ljy2gNuKsOSRuDqKyZI7Ege3GpOY5erDx3APn9YMz5mV
         seTpH9vVtPay4Q9bctksC90ylRM9xuHndbdHR8iFqfVZg/B+6AHGY6S44IG+vHGp54t9
         w3HfxgUyKx7MWpok7N7yw8dn8oTq3uYYZcaHzq4RlHrxHS/D/Zo/iua3nGICn0cIOlXN
         N0XQ==
X-Gm-Message-State: AOJu0YzeEHphic53cWENOeeOgx/I1DD07TYYtPyy++9y5ohA1C5kc9cq
	9bHYxWtqrS/INoFuCYWE1vcjviPkPodsPiC0tYc8RuQYDhFTwWRKz/lLB/El
X-Google-Smtp-Source: AGHT+IHkSJZPmXj3Qwr/RZLSrs66Pwmg3IpXPzSm58vcsUr0UQcRAC2C2qHKfHtW7OCzbxUMMyKlLg==
X-Received: by 2002:a05:600c:314b:b0:412:71fb:7732 with SMTP id h11-20020a05600c314b00b0041271fb7732mr4839559wmo.38.1708612609077;
        Thu, 22 Feb 2024 06:36:49 -0800 (PST)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id co3-20020a0560000a0300b0033d70dd0e04sm8625414wrb.8.2024.02.22.06.36.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Feb 2024 06:36:48 -0800 (PST)
Message-ID: <e82fdf7fbcbf12fffdf4a720927c2f4f006068f8.1708612605.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
References: <pull.1651.v2.git.1707324461.gitgitgadget@gmail.com>
	<pull.1651.v3.git.1708612605.gitgitgadget@gmail.com>
From: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Date: Thu, 22 Feb 2024 14:36:43 +0000
Subject: [PATCH v3 3/5] t4301: verify that merge-tree fails on missing blob
 objects
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
Cc: Patrick Steinhardt <ps@pks.im>,
    Eric Sunshine <sunshine@sunshineco.com>,
    Johannes Schindelin <johannes.schindelin@gmx.de>,
    Johannes Schindelin <johannes.schindelin@gmx.de>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

We just fixed a problem where `merge-tree` would not fail on missing
tree objects. Let's ensure that that problem does not occur with blob
objects (and won't, in the future, either).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 t/t4301-merge-tree-write-tree.sh | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/t/t4301-merge-tree-write-tree.sh b/t/t4301-merge-tree-write-tree.sh
index 908c9b540c8..d4463a45706 100755
--- a/t/t4301-merge-tree-write-tree.sh
+++ b/t/t4301-merge-tree-write-tree.sh
@@ -962,4 +962,20 @@ test_expect_success 'error out on missing tree objects' '
 	test_must_be_empty actual
 '
 
+test_expect_success 'error out on missing blob objects' '
+	echo 1 | git hash-object -w --stdin >blob1 &&
+	echo 2 | git hash-object -w --stdin >blob2 &&
+	echo 3 | git hash-object -w --stdin >blob3 &&
+	printf "100644 blob $(cat blob1)\tblob\n" | git mktree >tree1 &&
+	printf "100644 blob $(cat blob2)\tblob\n" | git mktree >tree2 &&
+	printf "100644 blob $(cat blob3)\tblob\n" | git mktree >tree3 &&
+	git init --bare missing-blob.git &&
+	cat blob1 blob3 tree1 tree2 tree3 |
+	git pack-objects missing-blob.git/objects/pack/side1-whatever-is-missing &&
+	test_must_fail git --git-dir=missing-blob.git >actual 2>err \
+		merge-tree --merge-base=$(cat tree1) $(cat tree2) $(cat tree3) &&
+	test_grep "unable to read blob object $(cat blob2)" err &&
+	test_must_be_empty actual
+'
+
 test_done
-- 
gitgitgadget

