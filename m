Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 071B3188CB1
	for <git@vger.kernel.org>; Sat, 17 May 2025 03:36:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747452999; cv=none; b=HyosaDTEPmwtXox0cSde7D+0vPQdUgH7u2mkrntAcWVCpF4zZ5TL6R/EipWJ1TINDw5GKsTd6an+9gY9j2YnkorLbzyeqwzpujtnJqczNVhKq+fgTzn9n7Dg+xvSW/rWRDoMdgCrQ4PFrB2qd6m6kvw5+/qN06x8/vJfIs6ODtw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747452999; c=relaxed/simple;
	bh=t4C8UZCXzQrl39Upnt6WXyFnblokG3Jfz6nVDLXNKWo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bDSyGWVkNc54RpKSGO/CSOhThxfjjnp+8PbpHccibFNYfyxw9uIxZ8AFiYhHqxdgXEblXGB9TxrVIBZJ+1Dz+rYlYge5HtTJUAz3bRSYLUk9N50z6+CaePnlTDw/ve+lpYyvxNLnJA/lu7iACntb66iNoi+NNatJ2++/+tFHSok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gibgh/MJ; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gibgh/MJ"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-73bf5aa95e7so2690472b3a.1
        for <git@vger.kernel.org>; Fri, 16 May 2025 20:36:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1747452997; x=1748057797; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ve1ONaELIa+aUxOtv/3k5clCHqBch/1A9hF1yYiuqgY=;
        b=gibgh/MJaMKlwIh2/IsAIF+WVyE+WI2GgmNBYisPttZmOUhoohtSITWT5w9MAsiM1Z
         G+8XxbuzxTm9N9ti1ZWcrrlI0VkXsdAkSBfAO4rU1bKb5YP2YLZMMbujHTWH1YxIInQA
         X2k0ZthCiqeMfc8bMW0M4FAFqc+70xlvUlkTJsnQDvUfB1HV8AGWKxFkVOY/4hmHDxxw
         WA3Xa1y0UchU3HQwc+63WMUUyLNIpyNFEjrKCHF9lT90bZ63ILs2QtVtPoPewrhQPJBm
         TbgyCXz0FI1QitfAucFs8wAXCUm9BFSvOSwmJ1e93mlEOBGM0mcll3d3IGs/QVnuDSAb
         UVWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747452997; x=1748057797;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ve1ONaELIa+aUxOtv/3k5clCHqBch/1A9hF1yYiuqgY=;
        b=kNXogIlAWpB2TcjPskzoK0xqGzPn3aqfZgWU102IZzoth8uMIJpmf+hYATYV87ICux
         /s8qLq5dC5Z7jtw4iphus+5IYBQOtKjFs4DERD+/eKR50z8oO309uqDL46pCyV6eMaZV
         lqSCs3KBo8tQFMb/ZBazUzfdcwFVLc45T9P97pUulgiBfQIQuBlU9EZtnO0r9NE78s4m
         941QLhTXzYH6rjnLkIJ4CWCh+iN1ihoT4rgdydKD608IiHoBfuoh4VY81xcZGKx58xWs
         z4hipBZbcnvPCW8+tFMlidHVKx9+cYBmFTGata1Kox6S9vDJ5VmgC8ufwZcKyzYae/o9
         p/2w==
X-Gm-Message-State: AOJu0Yw83b2RsINsJQXkZoqW3CcCRCQzuJZzAhGqk9rCFxKn8dWsPuYB
	0F8gk1Spa9FaB9P8tMN8GCjR9tNt7+LF1dx7E+Y5eDJnpzab9m8pYtcc
X-Gm-Gg: ASbGnct+U3uFAwkKHbMRzM5Y9Vq3s/Q29bHtn4kJvwA31aG296igr2vGccKNuunx9f2
	msodZqXyxbOqEU19l/Qjzip0WDKdpxbFh+V4/MWdDVz7O2sME3JTKGJ8Zh8CsUwoBhLxC8xxGow
	Gr6bWAtl/S9lZd+yLlkPOxd0Yu4+ShUWCZUkXI8kLiqrJs0FlSQMB+RupQCvOrKqImpTF7+HdvI
	Ab6SeEXP4jJMvmRxIgxQdkVbXMWi7hyT2AR1BhYTlRIXzPoha6a1nho56I2G/yM2v7bQNGLD8Lv
	/s4ZJsBruRH0/JaoKJMfYF+VUrWy8xTUMy1NX/I0dgK+C8Tx/pF1+Z2rw6XjUQSvYcE=
X-Google-Smtp-Source: AGHT+IHayj1kv3ftJnhoEqwabQE/kWoLYmtsLaDKjSqkr7AiBKZnJ+CahdTeHXN4Fy9nHtDDw9EEhQ==
X-Received: by 2002:a05:6a00:10c6:b0:742:a5f2:9c51 with SMTP id d2e1a72fcca58-742a9893acdmr7976452b3a.16.1747452997296;
        Fri, 16 May 2025 20:36:37 -0700 (PDT)
Received: from fedora.. ([2405:201:c005:b018:6a51:b86d:8d8d:758])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-742a9829ba8sm2285500b3a.110.2025.05.16.20.36.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 May 2025 20:36:36 -0700 (PDT)
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	jayatheerthkulkarni2005@gmail.com,
	nasamuffin@google.com
Subject: [PATCH v3 1/3] docs: remove unused mentoring mailing list reference
Date: Sat, 17 May 2025 09:06:24 +0530
Message-ID: <20250517033626.8052-2-jayatheerthkulkarni2005@gmail.com>
X-Mailer: git-send-email 2.49.GIT
In-Reply-To: <20250517033626.8052-1-jayatheerthkulkarni2005@gmail.com>
References: <xmqqecworq39.fsf@gitster.g>
 <20250517033626.8052-1-jayatheerthkulkarni2005@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The git-mentoring group is being removed because new contributors
now approach the main mailing list directly and
almost always receive responses.
To reflect current practices and avoid confusion,
remove the reference to the unused mentoring group.

Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index ca1d688c9b..ef190d8748 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -40,14 +40,6 @@ the list by sending an email to <git+subscribe@vger.kernel.org>
 The https://lore.kernel.org/git[archive] of this mailing list is
 available to view in a browser.
 
-==== https://groups.google.com/forum/#!forum/git-mentoring[git-mentoring@googlegroups.com]
-
-This mailing list is targeted to new contributors and was created as a place to
-post questions and receive answers outside of the public eye of the main list.
-Veteran contributors who are especially interested in helping mentor newcomers
-are present on the list. In order to avoid search indexers, group membership is
-required to view messages; anyone can join and no approval is required.
-
 ==== https://web.libera.chat/#git-devel[#git-devel] on Libera Chat
 
 This IRC channel is for conversations between Git contributors. If someone is
-- 
2.49.GIT

