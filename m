Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com [209.85.221.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0C1E3A1A2
	for <git@vger.kernel.org>; Sun, 10 Mar 2024 19:10:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710097839; cv=none; b=Me52Fm0EjpCO8pIbH+y3Q7h7Z1ygbz6eAtyaTWSzkExmDKUsFoVdy/qPzkgpGKd1yoQFeeEY7WoLaCJExWA096yp01uqcjY33aVOBTq9cZjjr/3BHU4jM6QnNf434p63bKO8GFOXF5s/lU4Hw1W8vffchWtxr0YD1z0YEg4V40k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710097839; c=relaxed/simple;
	bh=dS/kGFZ8UdygBtKvlYcjBywO95rAq45nGdWwlT5d5hY=;
	h=Message-ID:In-Reply-To:References:From:Date:Subject:MIME-Version:
	 Content-Type:To:Cc; b=ldE69VwKTQ1BYmRUnfGSEGnN549zIe0oH2BzSRmW0CrPXSMX9jpA1fYyDCswpJrOnzMJ41jewNC6nHoI+uW4GVjJ2AgWpNnuTD8zn+JXVfI6ONliWDFYQ2095QZ82h2rXem/AgroFw8mdOtyzClTrhuaA9SUGx96cd445fyjeRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=R5vqoXDh; arc=none smtp.client-ip=209.85.221.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="R5vqoXDh"
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-33e76d653b5so2379738f8f.3
        for <git@vger.kernel.org>; Sun, 10 Mar 2024 12:10:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1710097836; x=1710702636; darn=vger.kernel.org;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vDV6Y44U3/+qx6Teeh+JIqjoMXZiMeRFuaYW9xgqqqE=;
        b=R5vqoXDhaO8DmuGBwlI5FSHX0hAWor/+kCU0ly0C9Nt6CxJ6SBbz0ry90y8lrWJhfS
         jXuNzVmgGzvVKcvKgGkQBoQX/kAjDP7MdgROLw7P71Loltt3LwqxHaAW1ydJhZYzS4ON
         2p67aUMGczhTfu8ysu0b0T9e/zHXdXdmfJGaJPBqSj0ID6sJnaMIBf4RdEUXkVTfWrxh
         +Mtgy2OekBi2d7zHpWx46T0OsfJEiwFjSM/5WJokC61ev3hkIYvbNCuKCT4nR3cx0aUm
         sWVkCSVLN6iCqxhFx2NoIdpiI4HvDqHr7qR1DwQ+Tt5ml1Mxju+uMnGVB1AJj8smmxdy
         ag2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710097836; x=1710702636;
        h=cc:to:fcc:content-transfer-encoding:mime-version:subject:date:from
         :references:in-reply-to:message-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vDV6Y44U3/+qx6Teeh+JIqjoMXZiMeRFuaYW9xgqqqE=;
        b=LyRGxC9a/g7X9GPFy4oM7a2HjTHs1mWRVWl3VzIXPe5UCpn5cEqD+dz9gZd8qE8IUC
         SP4nnb2X6HyXeavu8N5HOCb4dkUwh6Sg2nDjFshjLJrY5hYHzTKTc3EouDXAILjd3pmu
         mM2N+j6JngBHj2KZA5DEN8heD0r/mUVoy/TeCK5AgYN+PLeG8cenBB5GCyTzdH/4VnIa
         wzsr2Dw8tinMJWluHCalR3D5YhH8Do/TBcRmJQMNfdLri5LTJBDrrAjvrroa6D34tasA
         V3Q7lASlcZ3mRBrVno8Ga0yV6wkYdObNZWJyJQSfMv7T38mFPFVzSMZtkszd9CZWS7BO
         P6kg==
X-Gm-Message-State: AOJu0YxIhrXp0urB4h6JuNZ8OPhIeOvMtNFSV9wjAoztdpdMDVacePdS
	E0CId2f4V9T6/v47exVKDW7FCRrXg4CHq15bHLZ0Y09fL64/W5aCErXy5+fq
X-Google-Smtp-Source: AGHT+IEu83w13CgPktCnlfgIapjI1AA/Zor8QFcvol7iaLViZtkb74xkpxlGk4h88ywYZCSVOT6trA==
X-Received: by 2002:a05:6000:1001:b0:33d:a2f7:ab33 with SMTP id a1-20020a056000100100b0033da2f7ab33mr3052125wrx.55.1710097835956;
        Sun, 10 Mar 2024 12:10:35 -0700 (PDT)
Received: from [127.0.0.1] ([13.74.141.28])
        by smtp.gmail.com with ESMTPSA id m38-20020a05600c3b2600b00412b6fbb9b5sm13218961wms.8.2024.03.10.12.10.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 10 Mar 2024 12:10:35 -0700 (PDT)
Message-ID: <8fda922dddf4278786acab4df8d7b31ed7605bc2.1710097830.git.gitgitgadget@gmail.com>
In-Reply-To: <pull.1687.git.1710097830.gitgitgadget@gmail.com>
References: <pull.1687.git.1710097830.gitgitgadget@gmail.com>
From: "=?UTF-8?q?Jean-No=C3=ABl=20Avila?= via GitGitGadget" <gitgitgadget@gmail.com>
Date: Sun, 10 Mar 2024 19:10:28 +0000
Subject: [PATCH 4/6] doc: git-init: rework config item init.templateDir
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Fcc: Sent
To: git@vger.kernel.org
Cc: =?UTF-8?Q?Jean-No=C3=ABl?= Avila <jn.avila@free.fr>,
    =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

From: =?UTF-8?q?Jean-No=C3=ABl=20Avila?= <jn.avila@free.fr>

When included into a the manpage of git-init, the param section must
not refer to the manpage.

Signed-off-by: Jean-Noël Avila <jn.avila@free.fr>
---
 Documentation/config/init.txt | 9 ++++++---
 Documentation/git-init.txt    | 2 ++
 2 files changed, 8 insertions(+), 3 deletions(-)

diff --git a/Documentation/config/init.txt b/Documentation/config/init.txt
index 79c79d66174..dd1d8332737 100644
--- a/Documentation/config/init.txt
+++ b/Documentation/config/init.txt
@@ -1,7 +1,10 @@
-init.templateDir::
-	Specify the directory from which templates will be copied.
-	(See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
+:see-git-init:
+ifndef::git-init[]
+:see-git-init: (See the "TEMPLATE DIRECTORY" section of linkgit:git-init[1].)
+endif::[]
 
+init.templateDir::
+	Specify the directory from which templates will be copied. {see-git-init}
 init.defaultBranch::
 	Allows overriding the default branch name e.g. when initializing
 	a new repository.
diff --git a/Documentation/git-init.txt b/Documentation/git-init.txt
index 5fce39040f2..2f864e11ed9 100644
--- a/Documentation/git-init.txt
+++ b/Documentation/git-init.txt
@@ -185,6 +185,8 @@ CONFIGURATION
 
 include::includes/cmd-config-section-all.txt[]
 
+:git-init:
+
 include::config/init.txt[]
 
 GIT
-- 
gitgitgadget

