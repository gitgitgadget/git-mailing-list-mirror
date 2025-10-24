Received: from mail-ed1-f49.google.com (mail-ed1-f49.google.com [209.85.208.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9FEA25D546
	for <git@vger.kernel.org>; Fri, 24 Oct 2025 20:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761339231; cv=none; b=F9DEodEzDQObsN89tg/xTHg83Sa8sDDbrELpodWdQZNVhIL2+39FSPBka+F/cvv9mlzUvaBohOWeXfje676EpUB8G6xboLK9oRlRpvwaIBncBt5UdgtuwX7T6cNJxjvfZoH0RPm7LyHrWslztoz3N7y3Zh5DNXyQ1x7l3Yk6gyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761339231; c=relaxed/simple;
	bh=pTirsInLc3KSzRE0Cg6mr3nlClCAXN9s4L9C4r7kMbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=krXHuL6kgKITLvkgg8tG3eG/lQPTm55OuovpalJY7vnUhYvchgsNm0A2lR0HE0rgVWAR8r4xt4sS0q96EaCsqg2t1SVYkPyuP3/5kar2h1DIFJ2g2Xmf7TobGsYDUBioNYud57fv8E0kTnaIwZd/QDYtRM/r4BMzbIOKra3L8mc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ddOTZ58U; arc=none smtp.client-ip=209.85.208.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ddOTZ58U"
Received: by mail-ed1-f49.google.com with SMTP id 4fb4d7f45d1cf-62fc0b7bf62so3831287a12.2
        for <git@vger.kernel.org>; Fri, 24 Oct 2025 13:53:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761339228; x=1761944028; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=g8Jt6opp0mgjkzjDkDriJXte8kDqYNSIZrl+RMSreSY=;
        b=ddOTZ58UEKlyq3Dj3ON+dT4rEO5csSdVIj07bP0983VgV3hWlkyYgwQDgeuD6dXoVj
         EPFyJVd4v0955r63lwH8kNRQzfSr5cAZjwx/2WiiP59JBm0yTIi9su7U2+awQXxoKsfC
         dulWuPtIp8vU0PrDCyzIg/je++qnzdJxi2NCH3BllqakpSIwiDFUUWJRy5rL+reeMO7l
         L416y4h/j4HCCLSVHa/zT4sxXNXzp97bQ72PsgAmVz4ih2FdCM3cpOWn7RHzdV7nxuv1
         Po9J9GCCy4UIpkd2YBTCL8A5FDsnvIpWFaDeZIJ4j+iP6QOYREZqWdNix0afl21orioB
         f3OQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761339228; x=1761944028;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g8Jt6opp0mgjkzjDkDriJXte8kDqYNSIZrl+RMSreSY=;
        b=fq9IT4qh0hTghR6fPwMxcYjxMay3ZK8S+GQG1goM6Bcleryj6Ydpi9iCN+rIeMxWNX
         LnbUfxwxo17B5YqsCppvmPaIv0zcR2D5unf5+MXB5xfQuh9C1btYccdYFIs79gFUbdbB
         B9fL8gbZ5vWicNacS57p7EGZBzi1PEPYhO4MJHjxzO+zG3djT3oYHGGvE4rKSTs7VwUV
         TRODLvHsrPW0hem4akYr8mNuiOdxljWwMrz5AUNNhlgDLS77fnBtgmF3WsGtBmRENKyl
         c5nu78W242DIz6kDkGYRx4uYMn53d7zEQ3faZJL7wpV+4rXY3fpKgMNJ7t+4iwSsq2R6
         qhzw==
X-Gm-Message-State: AOJu0YzxZusBQfWjAGv4q3ltq/oVzx0IrUrG1kf5kAIyVz2fgY5kjcHQ
	wGlr6cLnTghqo+ae56aRnvEOWgKjMtRtPeYea2nQwHhc4h3cXI+Dp9bRJsckrwNS
X-Gm-Gg: ASbGncuWV15gaJUBmZ8JlhhQ5Y3ObX6TYl5aUMj3T7WVNIjFwmY22rnnmE8NXvnx8Kj
	SX1swDs2YHNREonhidXXEGsHaorCGgB1YifEdzfz17ARt33JjMkgR/J7/oaIxlzNWPQeJHSC/al
	SG8IHYy6nCi9bSDsPXCykpxkB3ElQEBxaE0isaNqBs0j5rvYrphIsThGcLPxir2HiHeX83K6rxI
	2+xfUutZ0SrvnAXYWnmgNZqIy8t/fo4gvEO6xpa1OJcbnVaNA9RdW+1XuPtlXkGRcIcuK3z02W1
	AOt3xwNvoD/7lgqGe53Jf4K6wBWx2DL1CLC1mZ3CXkO+2Lucpqel+HwAn1VKNpIibKCK2xYu+4m
	JyeLax+Jsgtpama1a+jNuStXwySChfZg4mZ8JJGh7AQNxnTVEINq5gFCySMKzeokPBth1alZZZu
	rkxNkuNT+AEMRma1o=
X-Google-Smtp-Source: AGHT+IEuSs8s/yA//1J1sVvTR+UHSSAQ3JU5fLK55iXEw7B6fdnYRSvQx4d98LbVufPA6MIGUsFYfA==
X-Received: by 2002:a05:6402:2106:b0:63e:14c2:2809 with SMTP id 4fb4d7f45d1cf-63e14c22ed8mr11589485a12.5.1761339227807;
        Fri, 24 Oct 2025 13:53:47 -0700 (PDT)
Received: from QueenJ-PC ([105.113.70.134])
        by smtp.gmail.com with ESMTPSA id 4fb4d7f45d1cf-63e7efd116asm117769a12.33.2025.10.24.13.53.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 13:53:47 -0700 (PDT)
From: QueenJcloud <qjessa662@gmail.com>
To: git@vger.kernel.org
Cc: usmanakinyemi202@gmail.com,
	Christian.Couder@gmail.com,
	qjessa662@gmail.com
Subject: [PATCH v2] MyFirstContribution: add note on confirming patches
Date: Fri, 24 Oct 2025 21:53:39 +0100
Message-ID: <20251024205339.2012-1-qjessa662@gmail.com>
X-Mailer: git-send-email 2.51.0.573.gb660e2dcb9
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Add a note after the `git send-email` section explaining how
contributors can confirm that their patches reached the mailing
list by checking https://lore.kernel.org/git/.

Signed-off-by: QueenJcloud <qjessa662@gmail.com>
---
 Documentation/MyFirstContribution.adoc | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/Documentation/MyFirstContribution.adoc b/Documentation/MyFirstContribution.adoc
index 02ba8ba5f6..6e7f3036bb 100644
--- a/Documentation/MyFirstContribution.adoc
+++ b/Documentation/MyFirstContribution.adoc
@@ -1153,11 +1153,17 @@ NOTE: When you are sending a real patch, it will go to git@vger.kernel.org - but
 please don't send your patchset from the tutorial to the real mailing list! For
 now, you can send it to yourself, to make sure you understand how it will look.
 
+NOTE: After sending your patches, you can confirm that they reached the mailing
+list by visiting https://lore.kernel.org/git/. Use the search bar to find your
+name or the subject of your patch. If it appears, your email was successfully
+delivered.
+
 After you run the command above, you will be presented with an interactive
 prompt for each patch that's about to go out. This gives you one last chance to
 edit or quit sending something (but again, don't edit code this way). Once you
 press `y` or `a` at these prompts your emails will be sent! Congratulations!
 
+
 Awesome, now the community will drop everything and review your changes. (Just
 kidding - be patient!)
 
-- 
2.51.0.573.gb660e2dcb9

