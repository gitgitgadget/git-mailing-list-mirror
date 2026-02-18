Received: from mail-dy1-f176.google.com (mail-dy1-f176.google.com [74.125.82.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FEFC33A9FD
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 09:15:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771406129; cv=none; b=icLIvPCCSOxcoSa1gzBlEOqkR4n+aFqRUBMYGLQLJH9tDd6V6wB25ZmXsIBobABlHr7MfiF9W0tDJRrdtYPRj4nGtcOcYziL63f94siZFPoPWRLpVwq6HGXRus/uLj+s+n9UnrCewfhzi5cq52SwaC4amTuAPN50X3d/ACPpCmw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771406129; c=relaxed/simple;
	bh=Ug3ATGVWusoGqDeD4F1iWd2JVdZ/og3Pkv8LsElQqGg=;
	h=Message-Id:In-Reply-To:References:From:Date:Subject:Content-Type:
	 MIME-Version:To:Cc; b=k/VTjshXxiPNYdLBrihjLrlycJkMs/LATABiouPkLAAiL/0/q5i9aTCnIsEd1xnLyJaP4fl9rut79j4tSpbaRvsz64zkRZC4cow7tqz6V0MZkLcRJNdwzYw+iCFHpOGbRMMUDofmUULNhxdlGX6jKPt7C5YVwxaFLSZGsjbf1hk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=hd8iaJez; arc=none smtp.client-ip=74.125.82.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hd8iaJez"
Received: by mail-dy1-f176.google.com with SMTP id 5a478bee46e88-2b6b0500e06so5951973eec.1
        for <git@vger.kernel.org>; Wed, 18 Feb 2026 01:15:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771406125; x=1772010925; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Xr7OC1+w5JTJC7RsN57JWNKrN0S0n8NINHwKgic739A=;
        b=hd8iaJezVZT+Rw3jjNGzRcGd4BGIKR0mvCUZZYPowX/5f5DBZXykPbCAoj1jw8baQ8
         lsp5yAxcTqS0dMUAdR9c8J2GAPXo/q9Xy9LzXlLhZD4P3whjlrQUqlAq/Z5PaRckcBPi
         vB2HNt//jutdYPyrWtCrfhPhMn169/echt61w8YMky3wyzb8gOVkfDIwrLs5QLu/sWps
         0l9s4WJ6Y5YPGbqvA2LVwoc5chE57FpkD4Xs1wGteTFIqLZy8FNr5/6Ezqzo0lc61Nwe
         w/aSvmJL3MAJvjMKTgLrjWO5vgdph1/rgJbgYqB9tmbEGmscgDfSPdwNGOqbLCuG/Wc/
         dAvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771406125; x=1772010925;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :references:in-reply-to:message-id:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Xr7OC1+w5JTJC7RsN57JWNKrN0S0n8NINHwKgic739A=;
        b=U/GSE0B6n2xyJhIN+zlCUJLseg0xpJ9HJ247nZPecCIBhmYD/itybtsQhBObWfRmXR
         7QkV//cSAg37ldgueCLQq58qByC0ptA6pYnV6Pgyl3ubeXCx/Ol7e8m/xYYjVoNh6LO/
         jIqhMnEeWoC3Pf7TxGM4ceYnT1T8tjgG1pAgBMvGcRlQo5oEkyYskY3ROujDejNjf+Db
         lihsvlPlq+TuhsjaqC42ecygD2t48kNSrev5drjj72lv0hieBhOo8qkE2mNS0O1gy811
         CWj9FdLd0rkDu4SrEl+kHP9oeZnxPafpcHUUCXJlJ247YdP6Ud41BXqfNVsRjr/IuZFo
         GcLg==
X-Gm-Message-State: AOJu0Yyl0oneqGrfuXI0dVnSNATHLp8YC4PYXZlHe9b7//ixNLJ7EPKv
	nUVHztD4I3hhqMzan3J86ZCaoRFj+Dk4tgdu1WeYXRt9u1DZuU3GEI7SJF/dQw==
X-Gm-Gg: AZuq6aItdphXf+LDiJBApn33UqTXwajATMuGxBNWRIAUg+FshGszVtAW9O0gkqpmUgP
	hisNNE1rmFy16ZqamtFcKHu62soA1cmyfJB9hOcrzM8gvLM1syDQGyXW5Jw+rs/mt/GUMt5A6uc
	CUZA5imH6zDIfdbo0UZH/HMuwl06Afeefof1hNi3r11qJlbi0KhmAqNEqOHwEz2xyqs8+MP87XK
	xRewtfJMXoS++UazlwvkFdNy5QetBtrNXPtZfSH37LpXineW357W1InH9H9guCdEqney3aoIvRC
	M5baIR7IwIkk1UkcM1ru+412ir7iWV1L6N2fAq+v4+g27S4okvyuEIcnq0bVx2hiKfGrbUW+itl
	KV5BP/hJLjevoN1MbSC3Q5DBO3Ez3Ny1+uAjg/+uTxiMGKWG6l9hKObEVybClz/Y6ftz2DnUpjU
	xooqV/r6MiY6d1ZD+CoQHiwAxVWg==
X-Received: by 2002:a05:7300:d50e:b0:2ba:68d6:4799 with SMTP id 5a478bee46e88-2baba01011cmr6435508eec.5.1771406124909;
        Wed, 18 Feb 2026 01:15:24 -0800 (PST)
Received: from [127.0.0.1] ([172.182.212.48])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-2bacb543d80sm20336819eec.1.2026.02.18.01.15.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Feb 2026 01:15:24 -0800 (PST)
Message-Id: <d75a71aef97701e476dc8e9c662620e20cc5b17b.1771406115.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
References: <pull.2048.git.1771406115.gitgitgadget@gmail.com>
From: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Date: Wed, 18 Feb 2026 09:15:15 +0000
Subject: [PATCH 5/5] replay: prevent the_repository from coming back
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
Cc: Elijah Newren <newren@gmail.com>,
    Elijah Newren <newren@gmail.com>

From: Elijah Newren <newren@gmail.com>

Due to the use of DEFAULT_ABBREV, we cannot get rid of our usage of
USE_THE_REPOSITORY_VARIABLE.  We have removed all other uses of
the_repository before, but without removing that definition, they keep
coming back.

Define the_repository to make it a compilation error so that they don't
come back any more.

Signed-off-by: Elijah Newren <newren@gmail.com>
---
 replay.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/replay.c b/replay.c
index f97d652f33..a962f53d03 100644
--- a/replay.c
+++ b/replay.c
@@ -11,6 +11,8 @@
 #include "strmap.h"
 #include "tree.h"
 
+#define the_repository DO_NOT_USE_THE_REPOSITORY
+
 static const char *short_commit_name(struct repository *repo,
 				     struct commit *commit)
 {
-- 
gitgitgadget
