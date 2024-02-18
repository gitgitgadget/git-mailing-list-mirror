Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3D1C7FF
	for <git@vger.kernel.org>; Sun, 18 Feb 2024 03:16:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708226168; cv=none; b=sc0I1o2ghzhUdR/co2NBvhxiJsl1OwsBGtQy5dyKRu++3EUHu3XP1IBP37v6Z7MMc2oMAR7RMa70hebYjn5FChoEkOP178gP2KaNbty+joX7nmWmH7RPEnmTbOkx8TLDVpmNVEvJR3L2TiQcMxNOmfQKmyVCzHEx7z07/DyQajg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708226168; c=relaxed/simple;
	bh=D77ljmqPtTh2lI7NVZBJIO4zmUQvEDTE8/I29QRlgT8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=jaxa8E44dNkghAYuZ5Of1/ztGnuSQkn0fSqJbWT6ryE4xPv/SWNXWNtqTvGgMdSghm+blDVqSNsMP1vEwNwRAsT6isipLP2uq8OfSbL6MLI/TZiISvpdqy0trSs6//mnERh9EjvxFfJT/GWjYTZgNEd6/Adh5cao8C7N0TmPo9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fY6zVQQX; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fY6zVQQX"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-2d1094b5568so43817021fa.1
        for <git@vger.kernel.org>; Sat, 17 Feb 2024 19:16:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1708226165; x=1708830965; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=uB/6L98piTExMZhhCY1rZ25O1HrgtTEM6I6e50pdI3I=;
        b=fY6zVQQX74ETteibYX2ghFFBgSp8/8adV2CgK1+cy9lNan4w0KbJL78ViOwY+UrldN
         cFwBu4IWQ4gCKKi4ioAZDSTyddjDbw5UtTU3P95PqisciHayxvg6aGFhfJAfmE7fpGeN
         f9baijWCPjCGoXPP4FDUCODB3whrvXI2aWpyl2TuFXxeUplbGAZJvqZbvfw0r9CtQGyR
         OvwYoAERbxq7hiNcrPem/Vatkf+MEEeoY0875cVJLalrtDr052fpHEah/10JKgSTxR+y
         6gCgwTdGRI5N7xkqckQkZyLOmP53l4/yY7QLCgxUZ8xeOvMKB32hQWJolCh/WzXKej2H
         BoIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708226165; x=1708830965;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uB/6L98piTExMZhhCY1rZ25O1HrgtTEM6I6e50pdI3I=;
        b=sQv0uCW49OEZ3otZZ+H80lPKOjpPShoLTStk/OTCbUJAZEMjZlVXElX6/fHOU0hwsO
         IZh4skxMg5qQ6GXEoR47Yx6rAgfQXJTMa47P9JO00lJuoAV///Qfib3Gb724/5sHB/Sy
         P4Qo99hj0s6zJx/EA6l+7ylR5IFguAItM1T+9desIZaNW1uKcr1XQ7mNwymfamlZ7QYk
         1Ff85uR/+JNn56yXuTRfcMSjn5s0h+uq5CNcrmTH+ccUDRlvJ8TzoVZYWdTCkzZ9HD2j
         eFIbQuUgg61zySH2qHGpxqi5YOc6pb+KMc2eQlgREfKMFg1VVvIGCAki5gIyjNA51C/9
         4RnQ==
X-Gm-Message-State: AOJu0YwptJuD0mH6zuaq/qxdSFKn9s2qlffga1sJ1evH+TWyQlIWKwta
	yenSt7cgiDANe+IF6Ty8dIHRh8Pdn52g8R0wVwd+0KFhJFSkXbKJ
X-Google-Smtp-Source: AGHT+IEj6cnLJfPeW4vviCQOysreQkTKoNFkjXvKz6Jyp8a667foBdv0qAbpr6GbgQ6brjJJbeO0ZQ==
X-Received: by 2002:ac2:4c13:0:b0:511:19bf:fa0c with SMTP id t19-20020ac24c13000000b0051119bffa0cmr6055740lfq.56.1708226164737;
        Sat, 17 Feb 2024 19:16:04 -0800 (PST)
Received: from localhost ([138.199.7.162])
        by smtp.gmail.com with ESMTPSA id vi17-20020a170907d41100b00a3d47ee62c7sm1537360ejc.124.2024.02.17.19.16.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 17 Feb 2024 19:16:04 -0800 (PST)
Received: 
	by localhost (OpenSMTPD) with ESMTP id 23aa3223;
	Sun, 18 Feb 2024 03:03:30 +0000 (UTC)
From: Julio Bacellari <julio.bacel@gmail.com>
To: git@vger.kernel.org
Cc: Julio Bacellari <julio.bacel@gmail.com>
Subject: [PATCH] doc: remove outdated information about interactive.singleKey
Date: Sun, 18 Feb 2024 05:02:59 +0200
Message-ID: <20240218030327.40453-1-julio.bacel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The Perl implementation of add --interactive was removed in commit [1].

Additionally, the interactive.singleKey setting is no longer silently
ignored. The internal implementation of ReadKey [2] displays a warning
if the platform is unsupported.

[1] 20b813d7d (add: remove "add.interactive.useBuiltin" & Perl "git add--interactive", 2023-02-06)
[2] a5e46e6b0 (terminal: add a new function to read a single keystroke, 2020-01-14)

Signed-off-by: Julio Bacellari <julio.bacel@gmail.com>
---
 Documentation/config/interactive.txt | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/Documentation/config/interactive.txt b/Documentation/config/interactive.txt
index a2d3c7ec449e..5cc26555f19a 100644
--- a/Documentation/config/interactive.txt
+++ b/Documentation/config/interactive.txt
@@ -4,9 +4,7 @@ interactive.singleKey::
 	Currently this is used by the `--patch` mode of
 	linkgit:git-add[1], linkgit:git-checkout[1],
 	linkgit:git-restore[1], linkgit:git-commit[1],
-	linkgit:git-reset[1], and linkgit:git-stash[1]. Note that this
-	setting is silently ignored if portable keystroke input
-	is not available; requires the Perl module Term::ReadKey.
+	linkgit:git-reset[1], and linkgit:git-stash[1].
 
 interactive.diffFilter::
 	When an interactive command (such as `git add --patch`) shows
-- 
2.43.0

