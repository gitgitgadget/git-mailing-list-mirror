Received: from mail-lj1-f174.google.com (mail-lj1-f174.google.com [209.85.208.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 673011F8F1C
	for <git@vger.kernel.org>; Fri,  3 Jan 2025 11:34:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1735904047; cv=none; b=aM2oXHkS2vT4Nyf6arj5kvnwlcuzpzc7LD6pDYmLq41x1g85Vrx0vv+qRuRY0+hhioetasUyTTIzdoBGH6IwJtoFRFqocyJxNqlEsYnk8V3pXTFqm/RSpPd9ry3XUa7rRGBkMg2vbf7p8Y+MT0+M1hL3T+kI74kpxcrH6IMMW6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1735904047; c=relaxed/simple;
	bh=FtcY8yjuxMaFKoe9MxxTIocpdkgia9cNM0uLzfGC5eA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gOVNlIe8Bj5E8+zFy4FJZ4V3DZCEnp+mk/SsPi7d3Ek+AVuBB53+nXff8HtNpUdCkVnP20hJbo0gvYrBDpCupFegHqBYnB2Me3VOpDvkEdbsXcm0unPq+g7HLOIUKxHjgZ3RsET2WC4BWU8uijrYPjkwUeJZMi+62OcPz6b0ykY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lNb9W3FP; arc=none smtp.client-ip=209.85.208.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lNb9W3FP"
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-30036310158so114774631fa.0
        for <git@vger.kernel.org>; Fri, 03 Jan 2025 03:34:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1735904043; x=1736508843; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=O86nYDXWNAe1LDLusCSfksEM6AgmWFsrisIhgOZI3ps=;
        b=lNb9W3FPVcqyrECSycABg0365fzetHsT2gNf2wpnwTZZAWjoelx9X3WRCk+19wwcbC
         9AlbuH5QY8104c/JPu/bylWSYLDAi6HEPMTAvLA4jaBfM3CE/Pmg8/fWf6NbJn6Yk3ah
         NGRc8KmzV6Le4B3YLTY0VCDc2il2FUo0FoclVh+wAN/No8BaidaCacAR5mDqeb1E1jiT
         cQI9at73KY3hLAb4+r3iM7H0pcgE4XsNqHXbkEHDsc/Lmc3QxoR2bWp85PnxmQCnDh6q
         GKRiWyATGt6dUx/rGUPiL0UqOBBEnP/P68BIzLJWEjRNn/T9ECIiESaGSCM5utLLiee2
         QO5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735904043; x=1736508843;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O86nYDXWNAe1LDLusCSfksEM6AgmWFsrisIhgOZI3ps=;
        b=ppq3PldU+UENVxc+RkmTkK6tSbSORheA+5l21YiK28n+U1zzvrwvtJgX/5NloOdJqR
         ugpVTUIhj2irRQXCRbcRhX8L73KbVRC24UGDjkPa4J0k+438rTzfI8WT1zl+nZ6K8CNV
         S+Hu9Ch4RGQYdrOLO+O7V8uJxGduik5ki69HYkSDOghjU81Mwyn+po6cuXT6xMl4pwBw
         wQCxXeMfhqDzbGli1gb393oN1fYC/olfJRznvg4Y9Vz/TfZA2ukGue53rlVZyzYZ3/dU
         f5E6kgaafwxveohCE0vgz7OhyaRAcPqFtUUCdo/5nH96V7/M0tZUNGr4sSTuUU1gPPSa
         t/3g==
X-Gm-Message-State: AOJu0YxyU5m03P3GNuxsrUZlYX4VFI9o2XLBxcouUfR9dzTjQxuIIB7r
	5T4SvDTXZGcRZla2FbqzI/f7W2H+bxYMCpFGNkyo3CE8zGJ3/cnxB0d8Lw==
X-Gm-Gg: ASbGncsK8HQW3+83zKMyKhE2TAxt/Y/zJ6mdLN4av8JsdP29jvv/2M6A4WNV7XY+Koj
	qrqJwwmB6Mj/nlH0M6KFRr6f89C9nG9dPXfrs65z8MC6TJ5d3VqweHJ9JM8m6mU+rhpC4ojcbUK
	u+dSdlsBY6hZoTOJ0Z4xriMJ0Lm+628DB9ZIs26R9rn9Z1qKg7OLR3p/UiPLT1Hc3oXR2pJW6NA
	uZbEbDiaFGzk016HheErKyyEWKJ/Dshjm3x1kA3HVOxCfwS/eVErG1KPqIHaCsN/Qr1yJ8KXM8W
	4j7o6oZgXDYkd6mxt8h58D1odCt9lGc=
X-Google-Smtp-Source: AGHT+IHKb8ZiD5DxD8at/UT8PHZ9H2FnJm5rD8liohLe964/Fr+/VDbCgkBfh2wdgFuK1IbKVgt+jg==
X-Received: by 2002:a2e:bc20:0:b0:302:2bd8:2687 with SMTP id 38308e7fff4ca-304685519e6mr134745601fa.12.1735904042895;
        Fri, 03 Jan 2025 03:34:02 -0800 (PST)
Received: from localhost.localdomain (78-67-21-133-no600.tbcn.telia.com. [78.67.21.133])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3045ad99d06sm49527951fa.34.2025.01.03.03.34.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Jan 2025 03:34:02 -0800 (PST)
From: =?UTF-8?q?Martin=20=C3=85gren?= <martin.agren@gmail.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,
	Alejandro Barreto <alejandro.barreto@ni.com>
Subject: [PATCH 1/2] git.txt: fix heading line of tildes
Date: Fri,  3 Jan 2025 12:33:30 +0100
Message-ID: <50e47d14a8a0a2ca0dd158f01b833a28c7b46887.1735903029.git.martin.agren@gmail.com>
X-Mailer: git-send-email 2.48.0.rc1.241.g6c04ab211c
In-Reply-To: <cover.1735903029.git.martin.agren@gmail.com>
References: <cover.1735903029.git.martin.agren@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The two-line heading added in 8525e92886 (Document HOME environment
variable, 2024-12-09) uses too many tilde characters, so the heading
isn't detected as such. Both AsciiDoc and Asciidoctor end up
misrendering this in different ways.

Use the correct number of tilde characters to fix this.

Signed-off-by: Martin Ågren <martin.agren@gmail.com>
---
 Documentation/git.txt | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/git.txt b/Documentation/git.txt
index 81498393af..e89a91dd0d 100644
--- a/Documentation/git.txt
+++ b/Documentation/git.txt
@@ -478,7 +478,7 @@ their values the same way as Boolean valued configuration variables, e.g.
 Here are the variables:
 
 System
-~~~~~~~~~~~~~~~~~~
+~~~~~~
 `HOME`::
 	Specifies the path to the user's home directory. On Windows, if
 	unset, Git will set a process environment variable equal to:
-- 
2.48.0.rc1.241.g6c04ab211c

