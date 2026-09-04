Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com [209.85.221.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CE30485CF2
	for <git@vger.kernel.org>; Fri,  4 Sep 2026 12:45:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788525910; cv=none; b=ts1acJrcnqoP1HUaAZ6YyB9MKRZQVyLp0ML/wtgyIhHsOBQAzM8ZUc3n6CmrA2RObSc/EnSOstiJLRYMj8/6/nieg60fdA7vuoiZQRLddIE4Rl7YbzbpZOEIk5NkX4XWhFIv69PREae2h7Bx3C5/hi79PxW2dSlTLgaVbhX7Zjg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788525910; c=relaxed/simple;
	bh=9c95OkPQNiDkv3RKiuHsYO1uwcRbP0U3b+q053dhJso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KX4rrEi0HKJ9FBuuJYPOh+rZWLwfnDeNt7iadM0aZPzuelpPM7zIiVPClwn3rgQPgNmBlF69MY+o7Lvis7ug7wACeWWRCy7fb3MQgDGH2NUYN2H2XHiJO3KS0qYJ1TyqSiyQmNBYHaYZgqWDohU4IyQS0Ai6FnmVGL6VRhGS1NI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la; spf=pass smtp.mailfrom=lex.la; dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b=O4KteW3N; arc=none smtp.client-ip=209.85.221.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=lex.la
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=lex.la
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=lex.la header.i=@lex.la header.b="O4KteW3N"
Received: by mail-wr1-f50.google.com with SMTP id ffacd0b85a97d-48444ec4fe2so602469f8f.0
        for <git@vger.kernel.org>; Fri, 04 Sep 2026 05:45:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lex.la; s=google; t=1788525907; x=1789130707; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9c95OkPQNiDkv3RKiuHsYO1uwcRbP0U3b+q053dhJso=;
        b=O4KteW3NdlReX5zItyCxTnjTvGY7x/Wm2fZrW2A0nqzsSgyn6iVLV2fcSVI5KiNxrf
         mR7qV+LswxeV/cSY7uT+q7QrO8SnGbW542CbXP2QHcP/c4TO3IQThg2kxPPGtga4isbn
         /sjXu+GbCKlkHAybia9SwjbbvAdDTnjTQgH9jhCs2tyudC5pdtLYukc81kWBFkKrqHfQ
         b4SbpxI/GmN1Eu15AuSW5UlEMCZD5tvaHiqiJ3+PXuFoDZCYGqB9PEmwRjxzZBugV0hf
         NWlSVUjhmWkWkrqt0nq7kSvHA0lhUM4p49hcarEoIdk2mgd3OSXRMlCguv7a2sytAM/b
         KlOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788525907; x=1789130707;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=9c95OkPQNiDkv3RKiuHsYO1uwcRbP0U3b+q053dhJso=;
        b=kgmLFVyGhwRL2jSvhggsyVvDTFr9jt94ka/XYQkgI6TnkMAj2fHDDtNPUBHB3Dbac8
         397cMGyi+J05IEKe6WEN+87aAxI639nVk1CofvRjqddineyDGxpv2R3DUw4CHJvQtZyD
         m1cegZR6nUS/P8WmeKvjCPa0t1tictWrkYyMuL+ZrbOAMpLAUyadJE5cBBjh7xXXTiaH
         eLxVnYDJWQHYPKJ5vqm9o1/7xwKUyxe++Nbep/QFCLhDYWaL+QTv5DqhhV/UE5RchvkG
         pBQT/aFxl7+j7QARxPYer3Rhtco8s5m4RKRUo6QS+xl5f9R/JUjuv2sg+Iaue05zRQis
         0sMw==
X-Gm-Message-State: AFuF++mdtxJvLZT3IKlQWVCjTQ0woLze2UGCKEpqfd7CByQ5mTYeHzW/
	/gCq52xKStnZId0MAZIkz9E2NS1ImNhDG5W/Uda42YPeHOQJlJECAN3WEF58xnrVxDtgHLP47Yq
	2ueRegrneKA==
X-Gm-Gg: AYBFou2sgmUYKTQqYk61Fs619bPZuuQDhqNOMiSwVh0iOguZKe7kpMwx8OATj61AOij
	5cD+bblzmODIOwx2OwKNv6Ap4TtnXsUCHV7dGvcqB13dp7JxT5Hml/8y/d/ynQPQEL/H+OWTeII
	jkumgTDD13NTUMfErrB2W4NhxWTH35wGC+/r50fLylw4gCxd5Ie1Os0vmVPknGV60je4uA2oyoo
	rBqjepxHAlgZ1ejLjd+8+i3ouLeckaRYHjQ82i5rjiYW1BircQAqL8uUvnc05bAdw00+3/lIksf
	2qWqemteCLlL/ik4UffdrLQaeD5uPM+IPzPqQ24C1sUWZyoBn7HJwrhCB+huPqIPdt4iWhRiWG8
	JHv31MUf31x7zqEUxK2e4l8D0eRLSkK7bTnhtVdrwAqlb7jfzsMdl4jMuZXz8Enj3gAABUfG8TV
	4HMFP7XhwX6nEkPMok+mbheWDZO4zBYC9wAVuitQ6m1wIU3OOxfCxUv/Rsw8g81hVh+p3dYKMwZ
	KWXYl0=
X-Received: by 2002:a05:6000:26c4:b0:485:847c:4c64 with SMTP id ffacd0b85a97d-4858729b6f7mr10485365f8f.28.1788525907496;
        Fri, 04 Sep 2026 05:45:07 -0700 (PDT)
Received: from ownbook.home.lex.la ([84.17.55.227])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4858d312ca0sm2476590f8f.4.2026.09.04.05.45.06
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 04 Sep 2026 05:45:07 -0700 (PDT)
From: Aleksei Sviridkin <f@lex.la>
To: git@vger.kernel.org
Cc: Aleksei Sviridkin <f@lex.la>,
	Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH 1/2] t3507: pin CHERRY_PICK_HEAD absence for a conflicting --no-commit
Date: Fri,  4 Sep 2026 15:45:05 +0300
Message-ID: <20260904124505.12952-1-f@lex.la>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <apqSXT4lT7v0ILjp@pks.im>
References: <20260903125524.67889-1-f@lex.la> <xmqq7bl29g2p.fsf@gitster.g> <20260903214553.53942-1-f@lex.la> <apqSXT4lT7v0ILjp@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Patrick Steinhardt <ps@pks.im> writes:
> That doesn't specifically mean that this one test you add here is not
> useful. But we need to have a better argument than "we didn't have it
> yet".

Dropped the test. I went looking for that better argument and did not
find one: t3507 already has 'cherry-pick --no-commit does not set
CHERRY_PICK_HEAD' for the clean pick, and the clean and the conflicting
path go through the same !opts->no_commit guard in do_pick_commit(), so
the regression I described is covered already.

v2 is the documentation change alone.
