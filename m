Received: from mail-pl1-f196.google.com (mail-pl1-f196.google.com [209.85.214.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCFEA38A73F
	for <git@vger.kernel.org>; Sat, 23 May 2026 11:47:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.196
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779536847; cv=none; b=ZSSuTXpoYzaUNkSD/YtWTwjN+IBNym2v3ax7cw1ciohVcYgo6Jpo59Kwn9hEmPJfbIZo3S5DAhNCjg6NxZm1CK5Bz3YecAKdvFwthL09VQ5E0tsY2OWGnnyRHkxwj7C42SHBnKWk5KQa9olAusiPyhZXYb9ji0+oOWvFHr0a8bI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779536847; c=relaxed/simple;
	bh=QXfD53VC56BrN3zrSh0qeVBL2JxKdVu6Rj9gL8jlcOg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LbjGEdWjNZaEDhTY+lHtsynLHRvbph3M2YrIE43lwIkDvVbK7VZLyJS7U0XCPcvuMOXSPAlQ4ZZ7uUYMlVLCZ353sCAgLBBdXCSJKQcOh2JImFCtRMC3K/6Paa9pjJ8bU0z3zPmsoZsam0MzpHKxu5qodudhyw3ubCbogypRS1w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EuAF485S; arc=none smtp.client-ip=209.85.214.196
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EuAF485S"
Received: by mail-pl1-f196.google.com with SMTP id d9443c01a7336-2b9fcf7c91bso92335145ad.0
        for <git@vger.kernel.org>; Sat, 23 May 2026 04:47:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779536845; x=1780141645; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qgNUQQX8csrL17wlLz4+4lXQzAH5tzKq8vFy0uxzuRc=;
        b=EuAF485S5G0J5kgJS9gix7rtD33kvn6IPeuwrwoqY1yd1DYLtD0bF3n5R49d9LEcFe
         rNfpvcUaWr3/ZGue+FJVjZVClNajetzCor+7yVGYEUQsQ/wWyZIF3mQHdhE+rrIoplSm
         sVwZjX9q45jz/du6ZtQ9B3L1rIOWKO8H6xt69i+ogmiW3vlUCvywdAHlE9e5y1tC5Ted
         ejcxHZCUpXGkScfpyeZXR4HVkaPGAXKdj8D/I+fV6LMa8VifJNG6p0N81fORyx+oxa77
         taJhxqRw6w/dsWTok4qs2/Z6kpHeMYtUKhndrcOn0phNIDIxqfhPvfKdFV383iQZkqbG
         lF5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779536845; x=1780141645;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=qgNUQQX8csrL17wlLz4+4lXQzAH5tzKq8vFy0uxzuRc=;
        b=ppofRJ/aXlry9hFurtx4e+/WkQKoYJm3GDIAweECHrNIzZvT1PWWZmTR1ctNDr2FXE
         lgFHxO89u/N6tUKVTJ5lDorql3k7aAkn6QcQ+orEUKe3qJhtu4vTa59zjihfGtWHLywX
         cbLpVBE/hDf7Ls2r4qAGrLSYRpkj0HT3UelcninHuVUA4JQAtU750buwk7Alx1jZtThA
         GfX9vFgiiBz1vKmZMrK8GTEp8vz8OfTrKJofr8haiVPjKa8W+gbUs3Hz9jma8zt103er
         r8oa5Wy4TEhVU55oPkW1koEtEWaRBICwIIprzgdUUYuNHa9sjG2/f258OhOSnK0pnrxq
         wPGg==
X-Forwarded-Encrypted: i=1; AFNElJ+LDpKXpjMK/uQWEcuHWGnODfTV0XUoBbKeX9NXLUnUGZA0KXdrhxDvJkzsuNRe7HkJxe0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz2rD5qjKmAiZmIYqhdHzPyJEEPHvw3B1uGhMAApxlrWc1nL29c
	SmdhGKmP2nxlo1ZUEtHJ6gAl6aw3dcwmJlRtpz0irSjUndFbEB9KOk3/
X-Gm-Gg: Acq92OGQQyzE2UWCbQ57LhD8cTdBgYwTxkO6yrdoJz84ftdldRXEwW6crE15y4HccK0
	yoDVhdhgRBtvZEfPLKaj5JPPm5gIWBE93Qa3XGWjqarK7YxE9siX7wgcaE2K5pwaFG8fGLuMVUv
	41Uoz8SktdmdQsgRWhZ0UdozO16ody6EkpyiY5Sx9HSJgE4moKdVEibYrIFMD4bP1K3mocoIO50
	17GRCL8fdYY3CEPsxaDlUUdOXuCczMFtU6MgRw1BH8na7o1GvuIj5KJK1jCiwOzvoFoVgWVimgo
	Sedn9DkjakROMmYUrUHI2lZolIN600TJoAtgpExGrlpWot5ORwJqjarqjryjudETKo13FPrBMIV
	hlUr6mo0hPsQnxncAi4JiFI2NSwNmkk+Xc7/ejcvfjbD+gievkJa+gQoFDZDSwk1J9TNp5R8i1d
	yt8mbEsKv+xZKbQc67+RnpjvVWkQ7FttDUL1koiKGM
X-Received: by 2002:a17:902:f650:b0:2bd:8db9:cc0c with SMTP id d9443c01a7336-2beb038e50cmr78049305ad.6.1779536844990;
        Sat, 23 May 2026 04:47:24 -0700 (PDT)
Received: from DESKTOP-IB4GOVS ([121.224.209.33])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2beb5695f54sm45102075ad.10.2026.05.23.04.47.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2026 04:47:24 -0700 (PDT)
From: Aina Boot <bootaina702@gmail.com>
To: Johannes Sixt <j6t@kdbg.org>,
	Mark Levedahl <mlevedahl@gmail.com>
Cc: Shroom Moo <egg_mushroomcow@foxmail.com>,
	git@vger.kernel.org
Subject: Re: [PATCH v2 01/11] git-gui: guard set/unset of GIT_DIR and GIT_WORK_TREE
Date: Sat, 23 May 2026 12:46:26 +0100
Message-ID: <20260523114629.1298-1-bootaina702@gmail.com>
X-Mailer: git-send-email 2.53.0.windows.3
In-Reply-To: <b332c7d9-c86b-4d4b-a873-1600d910a237@kdbg.org>
References: 
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On 5/23/26 8:19 AM, Johannes Sixt wrote:
> The other patch that removes cd $_gitworktree from do_gitk should still
> be good, I think.

Agree. It either succeededly set the directory or work without a 
worktree, cd is practically unnecessary. 

Aina
