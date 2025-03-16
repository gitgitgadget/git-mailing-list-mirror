Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C78F28E8
	for <git@vger.kernel.org>; Sun, 16 Mar 2025 05:09:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742101778; cv=none; b=V5Dck8Ba/IBDNjhVQnLkJbup3J4z0NveEYItvVSIiEWhQ7kM/PT9I9QrecXJ0Yc2gQmpxLnhJ5YUFG6hmAufBmKMXafzY/2EGLMEe7DL9D/A+pKJNbz8Z6JBHDfjh5pLCrqDerDHE4oiJJ0wgnm83VjfT5L2cFXsOayldevyjnM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742101778; c=relaxed/simple;
	bh=MHcAI0CCeBoy+b20pakT9FxDzREOgsB7an/JbdNiWbY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=V/vlfzmecc40OBh5HdHrrV48zb5LKPuTjMscV2+JluIAzZPpJmbdlSZm9tIcYIDznOHb7WmchIFNqoxCvtmwGdyG1cV8zBVgyTkN/TEkmxLpEvTKgw3N+KPJhz1IWqx/x/46DE/3ygR9Js3s/hOWxkdFT68EKo60DYZFLW7+4PY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KcI2ldFc; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KcI2ldFc"
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-22113560c57so5724385ad.2
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 22:09:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742101776; x=1742706576; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k7qOsXNHC4MNppPE3aQ5lvi9+kf/K/m9D5jNsSTTRsE=;
        b=KcI2ldFclebzOCA6sHfa09tYlAiisfB+9NSQF8YjOSSAdLdXe5BIsdry/e8RtQHOkB
         OV7peWHrrIjcaDdZogKtE7pM7yDLYf/NqSn683K+3f8ax4rsQteDmlm6imd7NlmGP0rj
         32PuKKcmDwXx2vBGBS5edEhifn9dBKk06xL90oKdYyQKtWb3e0WKKE6o1nws3vV55Zrj
         0amLI/GLrZpxD8VhEy8jbLtLIjiKbwEtWdO2BvWHzC34CAVupIulFO2hcLywJNAaXE4k
         y1b1ZyPVgX5yC7Famq7rT96xta6Br0h9K1vRK7UVPUy1PJ5vp8pva3DGPwEX9NZuARmJ
         I/9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742101776; x=1742706576;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k7qOsXNHC4MNppPE3aQ5lvi9+kf/K/m9D5jNsSTTRsE=;
        b=XvbqSXT6YIQ+wxhfU0wn4IBK9UWsbtSPPPOXVMXfGXZvz7eBESw0NyWTz1cLvff58d
         edCCThRvLaMVY727+fE8Cp6/n8Qxek5fZLn+wRVSsWDhXn4gkLPZnUjM+AKl84GLEdbc
         gmYByW1hyrtEKFXgius8DIOzFAm/mnuhptsL2bnqZtwfapAdmyHDX4bMQeWXdTuOu5qB
         wHoTLf512pcmc6qzuaph94yctocrxharqn1nu9+vNSWy+6gwwuadBSwdLj9WoyRJ42zJ
         tvCjUX7ZoCalz0a4IoFEwzA9IklbKQv6fg6b3N3txrWA/lFc130NCnbhXd2p5gsJ6iJG
         2MRw==
X-Forwarded-Encrypted: i=1; AJvYcCWiLEOg1ldD/3Sgh4WgN1sFwME9ZHYHJDwXb/30My6sPKhC47cNQKRLIS8bhv2jb6ZCMoU=@vger.kernel.org
X-Gm-Message-State: AOJu0YynyCAoYLD4pmF9tZJQbd5Ln1eJrOEFQYntpkfAb3NnIzejC/uu
	lu11+4Cu4xhaciZ/u4Q0mUIIYkhjMPfImn9GxZ9rWCXzfB9yTf8pS/70uvFe
X-Gm-Gg: ASbGncvWOD3gnYDuaVPGU3eOWySi/RHKNvSAirwDiX1sY0KAPUw1PX2cWoJEQxUszri
	HmYtQt4YRWKniw2t7Xp7qkJSP6NxP0I8wGmN570wBw2/zqasVrg54KEHwtX+INpw6OmxTf75A9i
	JGJIJ661RR0+QNl8H7EZn+rgNHRbxFyXvwFk2qEl1B7HIaUXayeP5T4+ckdCOGm5ZA94DgbQK7C
	iofH6pPw6QCcNMLCIjJd3UQWTUKP4/gigs9VVK7DShaEeYQcNpIH0Ww+EEvhnl7wyGXOIcp3064
	Q1WLxo9WDXjPt+MTsqv6qf3+fy+gEsGocnZw/B24rw32qKs+UlZ/A7SnYVjpAUg=
X-Google-Smtp-Source: AGHT+IHj1oM0qDTk4ziYfn0htuy/lxtSQuF4RHSUfSUNp/x4F0FraVZEnQbxyUwnenezizJt/kexwg==
X-Received: by 2002:a05:6a00:2382:b0:736:4e02:c543 with SMTP id d2e1a72fcca58-7372233ae33mr8770871b3a.9.1742101776203;
        Sat, 15 Mar 2025 22:09:36 -0700 (PDT)
Received: from localhost.localdomain ([39.184.61.74])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-737115511cfsm5216002b3a.45.2025.03.15.22.09.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 15 Mar 2025 22:09:35 -0700 (PDT)
From: Zheng Yuting <05zyt30@gmail.com>
X-Google-Original-From: Zheng Yuting <05ZYT30@gmail.com>
To: gitster@pobox.com
Cc: 05zyt30@gmail.com,
	git@vger.kernel.org,
	Zheng Yuting <05ZYT30@gmail.com>
Subject: [GSoC PATCH v4 0/2] smtp_auth_maybe: unified error capture and status code processing optimization
Date: Sun, 16 Mar 2025 13:09:18 +0800
Message-ID: <20250316050920.3264895-1-05ZYT30@gmail.com>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <xmqqsengn1ms.fsf@gitster.g>
References: <xmqqsengn1ms.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

This v4 patch series includes two improvements:

1. Unified error capture:
Consolidate exception handling within a single eval block by introducing
local variables to store results and error states, thereby streamlining
code structure and enabling future extensibility.

2. Status code processing optimization:
After catching the authentication exception, parse the three-digit status
code in the error message, For temporary errors (4yz), only print warnings
and return success, while for permanent errors (5xx), return failure,
Unrecognized status codes are treated as permanent errors by default.

Zheng Yuting (2):
  Unify capture of SMTP errors
  Error handling for SMTP status codes

 git-send-email.perl | 62 ++++++++++++++++++++++++++++++++-------------
 1 file changed, 45 insertions(+), 17 deletions(-)

--
2.48.1
