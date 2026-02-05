Received: from mail-pj1-f65.google.com (mail-pj1-f65.google.com [209.85.216.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 742782FF158
	for <git@vger.kernel.org>; Thu,  5 Feb 2026 12:16:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.65
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770293775; cv=none; b=Fk4+VnrfTNWMuyXFZE7vgYS9WCcn7an4MkhP9PxkgFVOxcP7c71TuVXqgHMrZav0uj2ZvrTNSOxdAIkxhEZCaVWfGn1ABbuQdkIcn5YW3drmP4B6qqya634NURYQd/ArTk4rOnnxesNJ65GZKlIK3E3vlcPqP9Jn2Fi/oZ01d48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770293775; c=relaxed/simple;
	bh=rYpCVlZ97diciqPBp7bEHwoZc0D3m9IAa7KtxRykkyU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=OJO64S+x0eD6lmta1vjbLCU7J4kdqqL2VEuOrlkTPRC6HjVV39TvHdfhCZMuc+7029dUv2xjox6yBcTYTabWBGVemIsMyBVi10Er67rNNEImZdrv1ZoxiDxmRfzVKngdCKN8q5VwFtcUr4nITu9y3zWnVyiqWKP1D75PvNFwCgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SoufLqIq; arc=none smtp.client-ip=209.85.216.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SoufLqIq"
Received: by mail-pj1-f65.google.com with SMTP id 98e67ed59e1d1-352e2156450so384816a91.3
        for <git@vger.kernel.org>; Thu, 05 Feb 2026 04:16:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770293774; x=1770898574; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zQFj7+ql5hNZqYsoRKrM6fZ68QL3ML4TSpvRW0L90bE=;
        b=SoufLqIqXtVZbRn812XwpnK0NRUbdlQhnI/DtXTH3knAalUyT6pf7ELIIpr/37G5C9
         Eow1wbn/3Q/m+Wmfk0W8rOb4OmVooJUOzQjX/jOXBhvN2oVGA+RSFp9Bs5hdDQ5eNQf8
         NqS4gBzxHxe9zKtHZmbBzBFBvecD5UKkYysKcHvqHSuJm6QON+rYcDp3EoC+8YmKV0FZ
         FnJbEIyMAbzIGAbsRH5MAjyIUtmUs3zQ17lZ7pTzaObTCL7suY4Yajxvhudlka9XYye/
         HpqZEhxdhDWu5JWH5fquteB8MfoyTwbVS6092V3Oubtx7mhX1pxHFCHGA81V1Tl+r0Xs
         7adA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770293774; x=1770898574;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=zQFj7+ql5hNZqYsoRKrM6fZ68QL3ML4TSpvRW0L90bE=;
        b=PtuM41oYKIBD+4Ub15bJGTrIF7IcTEczvxUSGtuoAnWNRCqISBzYZEUmcD6AK/lHjd
         lLgkkUllOYH9x1nmzYdQc7maM/deNVhRSAH6/qFpn93n9PGQmQwU51oIaldpsYJPoB9A
         P0FKP3LsrYYPPnttZ9OnzNn5dNqpxgnuTyxb/4imTFB30UxDKotbGy7LYpz/VcIXnYcJ
         fJVmU4ZUDKU9QS6v8WIaNmAJQUbJF1FO0Z/wN4jDEb7SndqecSk9ay7qPeH66AdU20Au
         BHokLr5y7m+PRwluHVj3McoVvVGKBhf9Bqb0DHvShrYfDdu9jY/BrOC7hiS7mgvCl947
         k7uQ==
X-Gm-Message-State: AOJu0Yy9/94ZL1+FlzQRvmOnjUDFhrVXwM9xvu6RI2v1J5GBzbKxNGyB
	wSBkIjRU+OSFRBaGi04s6kQoKJZdS2s+WypHTMCH34P9/LVOLlg82sI8WOIoSGHl
X-Gm-Gg: AZuq6aJtw93eieBhTGyjtj2xP0Ou8FacEsc4g3R4d+hoyX7Zl8NnJ13m4XIT+Y+41RD
	hBZtEGR2Rp/rNPWF4AG0xvFA9jkvUohKgk4WfP3WWPOVoBvCGB29clRKw/3VkUqJqfErOHc67yM
	KhsA9Ql2m/uqJpiHJNqZMx9X/tVL4hlkg1VA9XpRELTnpf2YZexSoJ+peV+g6WGqOXKftlAH7Qu
	RABIe71TW2egojrOwwr3di1oBpGW/qLFnbP9C71ovHHUSc3cK1b0LHLBP78lSAU3GJRdwSsJBht
	4A+++8ILZfAToPHmGhX3UBU6LC/1MefTtiQtE5Sj8XFZzPFgt4BEUIuj7JcLcYwizQaUwYbiRe4
	8xi/i71A1FuV+oQ5JUuHmfcuyJC5+0ct8khuazmhvG6odpqz6FGrd6j1GEgg9CErVZV9V1IzTRM
	FOEQkDgH0PQFd+3ik0IjOcrNSUzudMfWa7gAg3CbWSEGiF3g==
X-Received: by 2002:a17:90b:534e:b0:340:be44:dd0b with SMTP id 98e67ed59e1d1-3548722b3cfmr5120967a91.34.1770293774565;
        Thu, 05 Feb 2026 04:16:14 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:955:7bd3:104b:5765])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8241d43513esm5620188b3a.43.2026.02.05.04.16.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Feb 2026 04:16:14 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH V2 2/3] wt-status: pass struct repository and wt_status through function parameters
Date: Thu,  5 Feb 2026 17:34:14 +0530
Message-ID: <20260205121545.36442-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAOLa=ZSkTH8KC04KubktP1EkU4EHYs0CtmUPkPVe74zi0wcTBA@mail.gmail.com>
References: <CAOLa=ZSkTH8KC04KubktP1EkU4EHYs0CtmUPkPVe74zi0wcTBA@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> > Some functions in wt-status.c relied on the_repository because no
> > repository instance was available in their local scope.
> > There is also a specific case in wt_status_check_rebase() where the
> > worktree can be NULL, so accessing wt->repo may lead to a segfault.
> >
> > Update these functions to accept a struct repository or struct
> > wt_status parameter, and adjust callers accordingly. Replace the
> > remaining uses of the_repository in these functions with the
> > passed-in repository instance.
> >
> > This removes the use of the_repository global variable from
> > wt-status.c completely.
> >
> 
> Okay, but this doesn't fix the issue I stated in the previous commit. I
> do wonder if we can re-order the commits and pass the repo struct to
> functions like 'get_branch()'.

Sorry, I didn’t fully think through what you were pointing out in the
previous version. I initially assumed you were only referring to the
specific call involving wt_status_check_rebase(NULL, state).

So struct worktree *wt is not guaranteed to be defined and can be
NULL. Because of that, relying on wt->repo is unsafe.
Instead, rather than depending on the worktree for repository access (wt->repo),
we can pass struct repository explicitly through the relevant call
stack, like in functions get_branch() and wt_status_check_bisect().
I hope I have understood it correctly.

Best,
Shreyansh
