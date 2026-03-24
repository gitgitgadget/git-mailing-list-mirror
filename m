Received: from mail-wm1-f65.google.com (mail-wm1-f65.google.com [209.85.128.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4C1237CD55
	for <git@vger.kernel.org>; Tue, 24 Mar 2026 19:07:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774379247; cv=none; b=UPwJgsa1g117gaZ/QOZX1fi2jRD8IwRPFpZmQXmn1xncjvnspOzSfvb+d8iukS3FzGJ4dKcNgdmL8vxlrISm5XjqWJ5YtNiiGX4yUJZzryvliZZyT/TRpHG272J76arbMm+blmKgawqJv8lb0oL1DS3v4yk9aTyXAnYedIdLvM8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774379247; c=relaxed/simple;
	bh=f6zt4siLa7GsmSIXN5Q8U6/1+UKL3U1SmVV4FztjEPA=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=lWkNiHkqYLvoHIogkUwwA+GNotetk9jcwrSwIuNOmW7TDHi0nzG3XS/mwQOjCeMyyhyDPtUbU1V73Xz2Z+Is48NWCQN9TH2+j6kNFDS1TCz017TQkJw/R2wq3LL4IH8tQyewu69romBBZP3lQeCo8aJWtahxgg+ybLOUaTuD0XM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k0ukW7xk; arc=none smtp.client-ip=209.85.128.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k0ukW7xk"
Received: by mail-wm1-f65.google.com with SMTP id 5b1f17b1804b1-48541edecf9so14563805e9.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2026 12:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774379244; x=1774984044; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=XtV4eBks6EQjrmnaizPUJw3ZJ37bPVSuSwXpa75maZs=;
        b=k0ukW7xknF7pWeTnlPXFvO6XdX/8Jv8eT2DqvQty52GLHN6Xrv+UWo8N/eV48Fzla9
         y8H+wwDqDsHkZFUZjQm7S51+IcU5eA2LAq6AAMj4+XeVG2ZlqPrrCu2+QaEGKDrHYmvn
         Q29KPgFNZX2n+90HPyiz6VSFkpwBT92zUqoFJLIE9LN5QfAIIP2JzNvUG/AIEnvPdPH/
         kMBvdw3oeQIoCVWgxxwmviPkKts39kj/FsyG5/+e20izbATKSUvE0ur14GdxbIWN630d
         CYZz1DWX1R3QuTrXWTYmE5+7pb8pQ6mTMXpSg2/ukjb2sqFqeHUq5OxUhDWrIFdAzK0H
         Bbiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774379244; x=1774984044;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=XtV4eBks6EQjrmnaizPUJw3ZJ37bPVSuSwXpa75maZs=;
        b=FUHMygIuChSXC1OTRrFrYvcwECH6cFykcOpboDW7hsuU2TgVUQZaDp5ERmvPeqR56V
         AcvAjwHS88ugWerQoNPLi1iMaxlai8WhUk1pku8Yz9pS6zZxrEESb0+WKK0R2F7HZO6C
         jzfsyy3YINoE4jpVtzW+N++O41pTHEu37k9hn9SkwC1XEvjh5irfZuCCyUuWO97vPol+
         pr+doqg0afBnBZFFN6zUB18KuxXsVlHeGofSbQyovf/22mc/aNVyEA06uKyqXtv/Zjbm
         zTXp5sjZ7oH9g6bBVI4kNXMob4citAGdbSEPl544bFvT88UuagbYAi6gpFWtO5YuVWRh
         s7GQ==
X-Gm-Message-State: AOJu0YyOJcTz4sFxGjn3vQ7KXjpAxYFSEcDJ4qC/LRgq1QzMSLAbUghP
	aXewjR8v3OJvPQHocA0v4Y1vGc9NWLYGfgcGKsVpkBgOvaAWOHJZ7TcOoU15R1LMR3c=
X-Gm-Gg: ATEYQzwhDIe66oRu4RYLVzRHW1Ts/8VmJ+JEpsRCsUo+J7/v9Qr2f+9hW3De+Zpt/Px
	wIDs7a9qBezijEL2vXeLeXIjPyqpd5/FXfPVQjCn7Sa397pEfW6tG1QPjOgJ17xl1XltNr9pzvo
	1Y9gy4yPzMeRINo7UUppS92+sg11Em1vRg4YAiso4/aHqDn9hrryNyGDkQhN6tIZ3xYJG1+pd/L
	ZiZ2JEMlpKNYbgyhAVdCJMuYUKu3yrQYfoQ+jU7pgHDUs8JIsJRi74znvJ2caQiBqD6pyI+MGW3
	E2fBQ9sZBC/WsxhOVp/BtpOQrn3ExAYa/9v4qoZ8IUmHkrTHmsdUbdjIfft6wOAzLij15b79amQ
	OM0h7b7pll2yX2Gos8M5MOvLmf2j+sWZXK86rbScmkmgYbhr+1c+PzU4LTijumPrCQZ2nQIDBwO
	tmUBkRjxQdweylX5tqEMMSaqE8gMBKD8FzXrQhgwtu+lZx4Zec3WrXm1h79OPHhbGs8rAIAIFan
	KUZDAOB1lpZkabFBL7eWDqBdQ7I
X-Received: by 2002:a05:600c:8283:b0:485:3a22:69b9 with SMTP id 5b1f17b1804b1-48716099758mr12945235e9.29.1774379243859;
        Tue, 24 Mar 2026 12:07:23 -0700 (PDT)
Received: from macbook.fritz.box ([2001:9e8:16e2:d600:4d27:7cf0:2953:93d0])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48711702191sm66497335e9.5.2026.03.24.12.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 Mar 2026 12:07:23 -0700 (PDT)
From: Mahi Kassa <mahlet.takassa@gmail.com>
To: git@vger.kernel.org
Cc: karthik.188@gmail.com,
	jltobler@gmail.com
Subject: [GSoC] Proposal direction for improving the new git repo command
Date: Tue, 24 Mar 2026 20:06:22 +0100
Message-Id: <20260324190622.309591-1-mahlet.takassa@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hello,

I am preparing a GSoC 2026 application for Git and would like to ask for feedback on the project direction I am currently exploring.

The idea I am focusing on is "Improve the new git repo command". My current plan is to work on incremental improvements to "git repo info" and "git repo structure", with an emphasis on changes that are useful, reviewable and consistent with existing Git command behavior.

In particular, I am currently considering:
  - adding useful repository information to "git repo info" that users currently need other commands to look up
  - improving "git repo structure" with additional or better-organized repository statistics
  - keeping the work split into small patches, with tests and documentation updates as needed

I have been reading through "builtin/repo.c" and the related tests while working on my microproject, and I recently sent a small patch related to "git repo" help behavior as part of my application preparation.

I would appreciate feedback on whether this seems like a reasonable direction, and especially on:
  - which "git repo info" improvements would be most valuable
  - how far "git repo structure" should go before becoming too broad
  - what scope would be realistic for a GSoC project here

Thanks,
Mahi Kassa
mahlet.takassa@gmail.com
