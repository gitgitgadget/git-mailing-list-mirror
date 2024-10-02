Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5692F198E63
	for <git@vger.kernel.org>; Wed,  2 Oct 2024 22:38:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727908711; cv=none; b=Mrf0lX829ezuS6ItXHyh9uPSyutdwUNDyQSXytJNXrQo8FjBYkXuaZYd/BememVuQFf2mJzh4nsOkzgLAhvChCq+KaVwGL4zNBvcrlk8eerqsWRb9uo5g1K06BVxjTCFNdAyJNknROzAJ4hDgy5F7qeC+WQ0ciubVlDBy2v6r+4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727908711; c=relaxed/simple;
	bh=PQtK9SInZgg5FVuy68YAlzlaBJyYYv/o9gGa574VBB8=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=e5Uo9ALzRGRRGzweqx3z4RYIsScTwbeJOW2F/2Egkn6heJZ2r9cLrb2l/ZSE7EZhHnn76mF1ju0jEYsNaZYjVj87rJE1qMNKP0IEJ+kpGqzJYzfdBTky07+sMY+a/SqqCvlLTAGf63lYVYu7ZCL9+uks1am6I9bU9TjMut5UJVc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=MXRJpiq6; arc=none smtp.client-ip=209.85.128.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MXRJpiq6"
Received: by mail-wm1-f49.google.com with SMTP id 5b1f17b1804b1-42e5e758093so2027965e9.1
        for <git@vger.kernel.org>; Wed, 02 Oct 2024 15:38:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1727908708; x=1728513508; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=E7q4XCYNGu6fjW6sQ/QitPDoHVRA0GMJX+LsvdhudjU=;
        b=MXRJpiq6pTAoxj7n/JKbnkazEEU8R9aCzgQHW8vf736DsfQVim57sGFOHB/KFO8hC8
         I9q6uwhNd9zsukX2TAv/b7yBj9gxSqv3rfHt/xNsw6r/AKq7bNMihK7Bvx8ZyV5MVymw
         8AI+9rmnu/OTFpWuHGX9IIlktWnyLugDRTJ+8PUlZH1BZAmoucDguKKYFHuF5tbHp9JF
         vNztFD8LuHag3OabEuJ6GT+v/jiJ8NDV/yHrb2TYedLKtw04dwCM3SGBDn1v3ssiufM3
         YDc6RlJSMCZgneZYFDmnYQcB+lHlJl2CGP2s0NwdbITFBqMmZt7kvp+6yeRZqfRNm5TR
         Et/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727908708; x=1728513508;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=E7q4XCYNGu6fjW6sQ/QitPDoHVRA0GMJX+LsvdhudjU=;
        b=NN5XBXc2mklkzY21KMqCsk4AbHmErUNFu4mfcYcnszhzpestBWaeYM0FIZ4Q09p1V5
         PxzSXaDyMOcWLYMHe/Kr9xuXpg4EaKtkmg/FOqY1Zy4my5sFtGTOCHDtOjMhzWSPgOX9
         +Gq2io+iPbrB55rjRpuY+179QL0jb3VBJ5lxfTvoyvsWNXhb85tXiCJ5NlURX/e7Zdhi
         eDP2tI8vARyXtcIOo1oiw0W1j3MzvIyErznwxAMFD1kHmj9sagxaMakUmEgXRSMHPEZ+
         oY0dLFjWNY42gHEYUiAxo/ayYKVC6cM6fzGgN60xJQCuevTugh63HKSOYXz0GXRP7a4e
         OLxA==
X-Gm-Message-State: AOJu0YwPAYjVRnYWAPiccpBwQXAWMOAX7gR+3FCWijBJXmBii0k6suc+
	XbYw6rb6MoE9HIGYU+w7GLOkU10s13uPI+0pqnoJKH9gbuabfsT3QBwLHfAd
X-Google-Smtp-Source: AGHT+IEJEVN53iMC3OT2IPjA1Z3426sIVkAhov2sYOaDFBFOXRq0fiuxeKwKDpm6aUiepUmCSQAL8A==
X-Received: by 2002:a05:600c:1d81:b0:42c:c37b:4d53 with SMTP id 5b1f17b1804b1-42f7776371amr30797945e9.0.1727908707792;
        Wed, 02 Oct 2024 15:38:27 -0700 (PDT)
Received: from void.void ([141.226.9.42])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42f79eacba2sm29753095e9.14.2024.10.02.15.38.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Oct 2024 15:38:26 -0700 (PDT)
From: Andrew Kreimer <algonell@gmail.com>
To: git@vger.kernel.org
Cc: Andrew Kreimer <algonell@gmail.com>
Subject: [PATCH 4/5] gitk: fix a typo
Date: Thu,  3 Oct 2024 01:38:15 +0300
Message-Id: <20241002223816.14858-5-algonell@gmail.com>
X-Mailer: git-send-email 2.39.5
In-Reply-To: <20241002223816.14858-1-algonell@gmail.com>
References: <20241002223816.14858-1-algonell@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Fix a typo in comments.

Signed-off-by: Andrew Kreimer <algonell@gmail.com>
---
 gitk-git/gitk | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/gitk-git/gitk b/gitk-git/gitk
index 7a087f123d..f85c421c5f 100755
--- a/gitk-git/gitk
+++ b/gitk-git/gitk
@@ -3687,7 +3687,7 @@ proc external_diff {} {
         set diffidto [lindex $diffids 1]
     }
 
-    # make sure that several diffs wont collide
+    # make sure that several diffs won't collide
     set diffdir [gitknewtmpdir]
     if {$diffdir eq {}} return
 
-- 
2.39.5

