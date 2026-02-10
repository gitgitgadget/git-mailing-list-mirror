Received: from mail-dl1-f68.google.com (mail-dl1-f68.google.com [74.125.82.68])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A143D17BB21
	for <git@vger.kernel.org>; Tue, 10 Feb 2026 19:50:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.82.68
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770753040; cv=none; b=WUtGrOsWEFRfeguYC9+WTpEGLa0F1w4p8mlME5C/9aMC01zBJgilH4qP4ZaUlbQsBuiBwGe4HdmIJRImSriqPm7JZLHbs1Fr/BuUtWQCwiH0y2S1I9YpiLP3SBnVE2hhn43sZ6A/1gYT/fytyYUPBSSzRKhLeU05w86zjB4CXsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770753040; c=relaxed/simple;
	bh=R+jfPC8NYTDMxq32V1Q+uHUVOpWMq2og0HyvkZOnejs=;
	h=Message-Id:From:Date:Subject:Content-Type:MIME-Version:To:Cc; b=dQqSS9uK5cta9Chh2qU1WTo1eUzWpZ0xl3c5YNmgofpNIVQQENSfnyJ4u7BbEAbhP0T1WGg0XF//BpE1UVQE8CaFyVSlrQyTDIL1rMzMRh4nQ9QFqr2GXHDZBwNmSG7wZjNlHVRsfyWC0p1VxNZ6LFVXeYc86LamN6QfSjLAlmI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=PG5Yw/Or; arc=none smtp.client-ip=74.125.82.68
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PG5Yw/Or"
Received: by mail-dl1-f68.google.com with SMTP id a92af1059eb24-1270adc5121so1525790c88.0
        for <git@vger.kernel.org>; Tue, 10 Feb 2026 11:50:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770753038; x=1771357838; darn=vger.kernel.org;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qwzDTx5tSdl+PwQ+XnoEE8FEvDmtRHJUIHHgUNTcLrE=;
        b=PG5Yw/OrTDaQrAjLdViME44qWRiJrOn3ji3/i7IC/p2sTNW8KTpHPs3teU8AQApRRM
         kZY3XVPLuRy6zgVsKDJg5JxmLxCr/BIG6wPfhut4g2OUEUyZzTOGqD45aETIRTuh8cdq
         ayGPJUqJArHth6h2ufBzBvi+Xi/d4mr29QWVd7mJS/lwLJykRAX+zM7IA5unbWhpUJBP
         PfcrwJJmih15W0pt9XsycIeGpV45POQP8QPfN/Qo/gwmUO87bZOOuvHDbTfIjuk4tZ3X
         U6yJ+H7R4dl/NDkYd9jV6OQQNMcUlQ1ubbAgsRpRgyRXvK8bBHrIygGfStBR0grpbMXk
         Zcag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770753038; x=1771357838;
        h=cc:to:mime-version:content-transfer-encoding:fcc:subject:date:from
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qwzDTx5tSdl+PwQ+XnoEE8FEvDmtRHJUIHHgUNTcLrE=;
        b=wfUJWkH2p1m9Xo37P5hN/TSiH5m/F8G8n2+OdU5M+ZkccDsWinF0HFsWuIqROHk76G
         S6KRIBanhbyPQzLFX/qu78f83sUedlJSEc8qiUQR1urzfYVZI1tZm6FO5GwQ12L1C8bP
         yQ886tVXp3j2qnEW/Hmn7+yJbZNs/EDHt0bOJeTk0LsFM59Ij5jiY4ChchGT60RPbJKl
         66NRLTb8CN9YoyYYyLNqkoUUpDapIefQYkX9U4u+wxWVQ7F8xliBSETahq/RLPRn1CqV
         D5HwQjsHlfmiANASUYnvLlnb9Y7P+2AlyJL5l6LTiTFHght238tqk+NF/BKeVuwiQgte
         RfGQ==
X-Gm-Message-State: AOJu0YxWJ6biTAAh47EN8PomM+OBy4Hr/m9e1uZwHdOmiHG3Jny9QL0t
	WuZr20Ky05W6xKB3b1/BxtDjpDGwKoQE75fsWM5FKxtEI/8Rc5KYRuFKUSpxM9OV
X-Gm-Gg: AZuq6aJEnLJkV72CbsmQDDmT8/s5xI3Z+E0B4EEKcsEh78CoRmeLJx8pW4Qoo/58l4Q
	ppC2V6ixJHWRuegw5tJHub4fv4rBsrz/7U+otZdxvUYKzftrhk6OwTXlH056sPGQyvAPXmg06at
	GmaUoYx25bd6SxQB0U7BX+jQH8HWgXC+uNL6R2ECkiI8CyD2fZ/sSQFgY8Akh5pjLMkvK2qi5N+
	XDCpaQVgYOeoZkuD3gAW7xhWbCg69stzWiRIOS9VHbpuccdzX51G9Dr7OORahBquXTTti6IjMwL
	bcPt/KUaV/keBq0GzC1Dbd/M2TmqHlQ/P9FbJkIkBzeO0UUG3YmXO/CKnuipJAJO+0JpfvuuaMo
	YFS2utCPm2MUonjcORPTJTrltD/xZQHqj4p6EQ+WZB0xyxO3U5SAhXHfcYVpn/Jh9CBNBuz/O6+
	wbzPuiTtokA5TaqRpVb28GrDdt+A==
X-Received: by 2002:a05:7022:6293:b0:11f:2c69:2d with SMTP id a92af1059eb24-127040740e6mr7040203c88.45.1770753038145;
        Tue, 10 Feb 2026 11:50:38 -0800 (PST)
Received: from [127.0.0.1] ([172.182.195.38])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-127041d94cesm11652312c88.3.2026.02.10.11.50.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Feb 2026 11:50:37 -0800 (PST)
Message-Id: <pull.2039.git.1770753036679.gitgitgadget@gmail.com>
From: "Ayush Sharma via GitGitGadget" <gitgitgadget@gmail.com>
Date: Tue, 10 Feb 2026 19:50:36 +0000
Subject: [PATCH] Documentation: fix duplicated word in 2.49.1 release notes
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
Cc: Ayush Sharma <connect@ayushhardeniya.site>,
    Ayush Sharma <ayushhardeniya.grid@gmail.com>

From: Ayush Sharma <ayushhardeniya.grid@gmail.com>

Remove a duplicated "to" in the 2.49.1 release notes that
was introduced during CI-related wording updates.

Signed-off-by: Ayush Sharma <ayushhardeniya.grid@gmail.com>
---
    Documentation: fix duplicated word in 2.49.1 release notes

Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-2039%2FayushHardeniya%2Fdoc-fix-duplicate-to-v1
Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-2039/ayushHardeniya/doc-fix-duplicate-to-v1
Pull-Request: https://github.com/gitgitgadget/git/pull/2039

 Documentation/RelNotes/2.49.1.adoc | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RelNotes/2.49.1.adoc b/Documentation/RelNotes/2.49.1.adoc
index c619e8b495..697f0f2220 100644
--- a/Documentation/RelNotes/2.49.1.adoc
+++ b/Documentation/RelNotes/2.49.1.adoc
@@ -9,4 +9,4 @@ notes for v2.43.7 for details.
 
 It also contains some updates to various CI bits to work around
 and/or to adjust to the deprecation of use of Ubuntu 20.04 GitHub
-Actions CI, updates to to Fedora base image.
+Actions CI, updates to Fedora base image.

base-commit: ea717645d199f6f1b66058886475db3e8c9330e9
-- 
gitgitgadget
