Received: from mail-lf1-f46.google.com (mail-lf1-f46.google.com [209.85.167.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F5541FB1
	for <git@vger.kernel.org>; Wed, 24 Dec 2025 00:00:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766534445; cv=none; b=oQfmuN5a5VgSxTeyU3vfT/rSjV5vu3VzfQRVeb6GycN3VsUjkBbGJ9rH/qdy6V7fTa424lcoQyj9qFiGtdVCrlntx/DXrrp6Tf48S/6Oc+prSTo51GSBnOqR6f/EN1nDOQYWlJbQk+/csybIEsNcbs9h46Z8N561dv7mlDF8OaU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766534445; c=relaxed/simple;
	bh=BpxZwydhGQYNZkCaPdtj6q5gPBWA2G+c+D/Ps/Z3dxs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n2snWNgd8iPgCSkwMZnSwi9tIQhgu1F8Q6mRVBIRjJ56oMN3m7mdZMXnR690lurthKPsKIuq9DYSM0FA84F766P7i9MdwqXV/AP7E3z55kt7Ypd0hXbd8MyMGJzONvv3nM1BNrHbJ5cmjzzsf1SyLz3qq7PiJNa7Eze12bNqi5M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UUICENTt; arc=none smtp.client-ip=209.85.167.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UUICENTt"
Received: by mail-lf1-f46.google.com with SMTP id 2adb3069b0e04-594285c6509so6019248e87.0
        for <git@vger.kernel.org>; Tue, 23 Dec 2025 16:00:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1766534442; x=1767139242; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ob0aWG0o7bgZeOnFTJbhBmlQH2OvO4Nj1NOzSBcQQTU=;
        b=UUICENTtT2fou5pw0B/WlKqtNiyiVMp5Ho9FiTpjKFRaxn/mLUV4UVNS/2yvC/tnJA
         A/r8uOPgaTvRk5EgtvJEIyTRmIHv25WQlL/X/5Be7tKi5rQUXcSPMUf/fY/4l8SnRPtg
         ntqJdhndnpa5fM/Fnr1NU+tWGWUPY6SZ87F9SD6Fdnp2XXBdScBhaiQZ/NbNRYb7nbei
         YlmZmVv+fbLenFxwdy5aTkLYfI+pdtU2gqu3afRWDBm/AS6cpQaViRE7AnQhOt2dBET2
         UhOHauLjTM9HEtMTx41K0byHSDGffIGGbwB45y+O9n7o9BJNutykXGtc5vIFi+01LJzU
         tfpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1766534442; x=1767139242;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ob0aWG0o7bgZeOnFTJbhBmlQH2OvO4Nj1NOzSBcQQTU=;
        b=H59b4cnIahycwEUxZLi5bz9V7/ff8PzH+wnniRtd91bVZSOs3htVZUlzDi21mw441z
         2Irtm7qxfHby8Ed3qgPICCUsFfRe/SxnuWvzTZJUC/AvUUg+HIknXKlzbQmKnFWE6UvH
         +H/M8lG1bAXgfXTxJk3B0gX9/tcdCQF94MMuRJyBJMNUQZT+hM6S0wVZFLuwoHxAtwqq
         BWPvyjTY1hjCuevRLlxyxncjAZNkY8km2RXbMDbPxrez0OnhiY/LYw1jk0zHPTv5GKXd
         0shlpHC/JJhS70ajMyQlhBhfy4XnzovmFSAASyWAbxXun+yvWLWUp53MwK0ktLInXz7m
         3uvA==
X-Gm-Message-State: AOJu0YwAnTQyc/4w1GYso8H2xN/hnrDhsTpNyAhH6i60EMx9no3RWrDF
	f8IgTFyLyEa67Li0X5KpbgTMcvss6jW/aIVl09s2BMMGzBgrL2ND6A0T+BJeGQ==
X-Gm-Gg: AY/fxX6kaxvwhFgH/x9S2/KfcnkVtQA6GJtpCY5NnCSR08A5l89zzFup0xRqIw3FK8T
	ND4pVghkuDBXdZiVWA6PGB2UwfYu0hUxR8v40mvL19XoPzdgjtZZlLECs1+yHCljbhWNkGK8lPn
	SzSLN1OczDFCgCB7xRVL3lRuVx2GPQjLgydw6KmxGkLk3ulZhpNjSjG2wvCuwtOFrZMgDqLXgEJ
	EKwWJQ3rnvkIyRTKSPu8yBy+dKbYqCRCt9NiBxsDYhcIL/iP0FLl1uhmZA8BiHeVtlFf8Bn8opR
	eUYuxLk6fWb2I/8qgNEEe/m9g4f9z3QibZOl87eBp0O2eBSZiuN7yfyQv7nbILca4eTofftqiOk
	xSgEOLd60wITBcUMFcVHltBGRibOyelAwsqJEst8/zEFMuqq1UHyMfNfUPJJhIAbn/2u7jXivZA
	xdusd7Hy9Q2pU0HxRbuKgeL9kxezzvzgRG08bzGwh8b89ncBQdPAfInfBbLXWu4y09Cx+aEZLd6
	nQpLgrlwQ==
X-Google-Smtp-Source: AGHT+IF5fyZMFopY8rZoKEFSPDIqFxCK0NyWeh+WMf/XyrUObc55o+x4LlcNWN1BvHzrhzu6orKsVQ==
X-Received: by 2002:ac2:4e04:0:b0:599:1199:9df0 with SMTP id 2adb3069b0e04-59a17cbfe75mr5365353e87.0.1766534441539;
        Tue, 23 Dec 2025 16:00:41 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38122502ea9sm37497251fa.16.2025.12.23.16.00.40
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 23 Dec 2025 16:00:41 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: gitgitgadget@gmail.com
Cc: git@vger.kernel.org,
	haraldnordgren@gmail.com
Subject: Re: [PATCH] status: show default branch comparison when tracking non-default branch
Date: Wed, 24 Dec 2025 01:00:40 +0100
Message-Id: <20251224000040.45727-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <pull.2138.v2.git.git.1766530448.gitgitgadget@gmail.com>
References: <pull.2138.v2.git.git.1766530448.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

By the way, I'm using my own version of git while working on this, and I'm loving it 😅

	$ /Users/Harald/git-repos/github.com/git/git/git status
	On branch ahead_of_main_status
	Your branch and 'origin/ahead_of_main_status' have diverged,
	and have 1 and 1 different commits each, respectively.
	  (use "git pull" if you want to integrate the remote branch with yours)

	Ahead of 'upstream/master' by 2 commits.

	nothing to commit, working tree clean
