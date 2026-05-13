Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37A5F346AD4
	for <git@vger.kernel.org>; Wed, 13 May 2026 18:57:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1778698642; cv=none; b=BMHiDxILs3YGhkGiZ7CPeXgTzGckZH85lzUWI/XFq9oXzu9f6R9sWDkfS8eRGJZms6f614VcTUr/vFa4tFjQ3I4UWjW0+zqUf1lzkDtCCwCI3QH/moBcuQI5tgfd3wPd80LNlREnmEA84Yl27JXCXQHP4sCOY0vTj2gC6E8HmlU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1778698642; c=relaxed/simple;
	bh=E/MtkR7CyAkGcHxVIZgF9G4xAXepJXCfHQU3dWhuoXo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=k1DooA/nVX+e24WVNbKHqb2eWy551IlySwn0cWobQ5xU8S317X2G9BvMZQuEw4eMJazo4KqBSd680qDYe652dStlqUtNLMIRqgfIcOfE/psKo4gCfceF+zIiVR8xS7bUiSsk/QzSfyDrZ6fzske56qvoMDrCS54snd/HrXN8en4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ha3KRmQZ; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ha3KRmQZ"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-5a884815606so7090443e87.0
        for <git@vger.kernel.org>; Wed, 13 May 2026 11:57:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1778698639; x=1779303439; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lsLJv7wcAXEBuh1qa6GdnyD2nmwufP/1C+yOksKIcJU=;
        b=ha3KRmQZdg3rLQ7G6RaV7AU36yD3By2oiRz0EAMbLCNwC+iUgIPk7n5X03H4+H8G5g
         3u9hR4+9D9321ET13FREwK0NXM10pIdrVK6FDT7o549LKA0BwbJslJVa3w6OqWuN22Qx
         vXF+tW1tEWyUOLkUHD1hqk3zBD+7wIITB7th+5NwD2hxL5H/vDdV/4/L72FA0Dp08IkF
         hlFo2VAi/HMm6lkzie5n5XZ4BA83a/7v5PQL2UC9A9Gyxwl1ZKNwSGgofYcYcQ4NY59j
         GUqiJ5+GaWjy9BbqRpVUEc/Y4u645U2xxVBj6qkw3xmBIq3b8zqriJT0VR2yMiljM+Tw
         L/xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1778698639; x=1779303439;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lsLJv7wcAXEBuh1qa6GdnyD2nmwufP/1C+yOksKIcJU=;
        b=Zo48EbSnZs2Z3QH7Lpus69Jbz1z+ZmVU/Tv1oNjyfUo83QjNYvg6qribq3e7I7PeLR
         nAfYS5F4uqLracFHuwId2xV3ZIhjbBvkYQ3Wp6zakH7MHqAp1fhLows4smzwZRbXUcwp
         byqXFCNGPLAej8gtW8TE0onj4f+XocM+Yk9AIjcFgazVnvo8Y9Axj9PTq6HqOvj7hd2D
         X/9xbI/oNO42atHD7+t4sKkj4RXBogsWeYmazrVGcqXA32JoTKjGCJT1+tV+6iO28e0w
         jSbmzUtJUtb9TrJ74ydHzUJAKvjiZo04NoykLvL67yr02pN0XGSEu7bBTIiF8LGlBf22
         0z5A==
X-Gm-Message-State: AOJu0Yz08AdSTG/n51KTWdvGcCEYRiEw0rZZw0fBYNcgC4E/AXnYPfrF
	JKgUAoodXOldSq5y5SbmWAJBfD+kBo5ZGXuUj+EiApWR+MhL6H1UvZnN
X-Gm-Gg: Acq92OHfSeOeHv6qv7QDd/+SQ+RmMqNvP0KoGeVGsfWwxrYPYnj7WE7H3gke0+6fQtM
	wT1wPceLOKalx6XgsVPMBpszi7lWO+2MThZy1rGhCzPMxv62dHiDP5V7HplN3skRWyBerxs3sQF
	IVNesb9sjhUohOJhDdDkRGmD+b2dkkpa12yExky1Zho0HLYZOaMagUygUdnIwP38PMSs5r5uz1M
	Cl8VURwtwfUpO+Ca5jajB7sFly5KbjR2KvlfqAiTXeyZK2re9T+SdbLcKoBXI0mLCtYuVVsGJ8b
	rrs3STjLkRx4WM34iOdYwjnV/hjCyFADWvE5e2DW8ozA1mxAdziTSAOEntFWA9yH9cuZNEYoFv1
	K7Cr7Pp+4aH/tB7yCgsaoJ7UEHU1jGY0EcuYKBWkRbPs3C8Iyi7PvpNzo4KsBxEbHmN1sGdXXiO
	1ACuBR33XOt5OYwPBDnOlxQ79LrQKzeCg5A4+g6HgDRWqeRGb927IMCiuR+P0btbx3oLcgVVHrl
	nhVI46NSoNKoQP0
X-Received: by 2002:a05:6512:3090:b0:5a8:9756:f6b8 with SMTP id 2adb3069b0e04-5a8f445a4cdmr1484969e87.35.1778698638689;
        Wed, 13 May 2026 11:57:18 -0700 (PDT)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5a8b6b2e8d9sm3391296e87.51.2026.05.13.11.57.17
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 13 May 2026 11:57:18 -0700 (PDT)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitster@pobox.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	haraldnordgren@gmail.com,
	j6t@kdbg.org,
	kristofferhaugsbakk@fastmail.com
Subject: [PATCH] fetch: add fetch.pruneLocalBranches config
Date: Wed, 13 May 2026 20:57:17 +0200
Message-ID: <20260513185717.51743-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.54.0.106.g1f06873f82
In-Reply-To: <xmqqqznfifrg.fsf@gitster.g>
References: <xmqqqznfifrg.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> I am not sure if this is a good idea at all.  The option is called
> prune-MERGED and with or without --force, mergedness should be what
> determines if a branch is deleted.

Well, when I started writing the feature it was "prune local branches",
and it evolved from there to prune merged.

But you're probably right. I did wipe up some branches with real work on my
side using this (I restored them), so it seems to be more of a foot-gun
than I first imagined.

Seems reasonable to remove the '--force' functionality.


Harald
