Received: from mail-qv1-f42.google.com (mail-qv1-f42.google.com [209.85.219.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D8A84C91
	for <git@vger.kernel.org>; Sun,  6 Oct 2024 11:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728213140; cv=none; b=r/2Moqfm1z3JjKAnKoKkSoz+m+zizDIf697wuOiKXUulIKom5EPt+QK3swS1/F/bB+IVUm/J3Ejul8ysV6DkT9yTcyQCIVYvCfhuxTQyeV7HEu3Wm+ObIvcR7VjaVVjHeAWu4WeMgXDHfMyIYVjfYK8J5Kghp/wCzslJU+kD5u8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728213140; c=relaxed/simple;
	bh=76O+W6brrx8kndUxESOnOx+y1MT5+Jqim0A1QwYBjrA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VNlhxzc22ItxkaM1FU41fnYOO5n+Y9TxFOXffWnscYSe7eSLHXXDksLaE8CEeuV7OLnak8vdv08Pj3qRgMug/uNZlVss+lrnCPve/Qmt4XKsl9BFwji5Q0o5J8H1eBYnz33a4M+13uUXaGk11t3nFFQ58zKBCo2FG9TU0Z+gKlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-qv1-f42.google.com with SMTP id 6a1803df08f44-6cb33996b79so4637676d6.0
        for <git@vger.kernel.org>; Sun, 06 Oct 2024 04:12:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728213137; x=1728817937;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=76O+W6brrx8kndUxESOnOx+y1MT5+Jqim0A1QwYBjrA=;
        b=MieGdi2JcegU41+mW6fDADmPa6KhYHaOAJeiJU98pa0jMiimQ9Rl5uKcGS78/QxQv7
         E+jqeLTQSSoG0WIyf5g9yKU/CbgSMvX6Etw1qx3rpHS9CaQh+9TQVt1c6korDK5PrDXB
         GhVvmhrfYSmxq0e03SD40soJ8jZnSGv4TRq5O8scNn0WREI4cbnq80RWLpRloRo1Y3jy
         VaN3QWVL840DNi2J1Hn1F546PX0UFNFocZJ/2e3vigtLi4VlW1YAHPLeE0jl4Zv3fKwA
         EFMramucFjQ2jeB/PsMuO+zZkkfmt9WfZ5pS8ivHV9JrFdI/EsGSZT6iphOh+lSUC1i7
         ZQxA==
X-Gm-Message-State: AOJu0Yz6m0zpMBgp5T1QoszlbNwuviNPWM1J2dppiT1h2Y8cViayLHnZ
	EKsM4ebEM9VsMcg98ArwD5ToZ7Tw75cT+w/Yql5lAnsU2LM9U0Xp5cf5J2ZMbg99e+RlMjFHq6M
	aL8NUkHcywSFda15Yf9+ngwpM0dLL0Q==
X-Google-Smtp-Source: AGHT+IEe24HE438rWKE4ikmcS8lEpiIYdvgmwYi5Z33W9WvHCW2I96nCOuSoAkSUmgK4wh467K+PE3dmq0an1de2r20=
X-Received: by 2002:a05:6214:5007:b0:6cb:6006:c98b with SMTP id
 6a1803df08f44-6cb9a2f5ba2mr60028086d6.5.1728213136956; Sun, 06 Oct 2024
 04:12:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20241006060017.171788-1-cdwhite3@pm.me> <20241006060017.171788-4-cdwhite3@pm.me>
In-Reply-To: <20241006060017.171788-4-cdwhite3@pm.me>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Sun, 6 Oct 2024 07:12:04 -0400
Message-ID: <CAPig+cQApvzpuCBfViPD_hJjqe_poFO8uB1GapeVpCd2EWvEug@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] worktree: sync worktree paths after gitdir move
To: Caleb White <cdwhite3@pm.me>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Oct 6, 2024 at 2:01=E2=80=AFAM Caleb White <cdwhite3@pm.me> wrote:
> When re-initializing a repository with a separate gitdir (the original
> gitdir is moved to a new location), any linked worktrees become broken
> and must be repaired to reflect the new gitdir location. For absolute
> paths, this breakage is one-way, but is both ways for relative paths
> (the `<worktree>/.git` and the `<repo>/worktrees/<id>/gitdir`).
>
> Previously, `repair_worktrees` was being called which loops through all
> the worktrees in the repository and updates the `<worktree>/.git` files
> to point to the new gitdir. However, when both sides of the worktrees
> are broken, the previous gitdir location is required to reestablish the
> link.
>
> To fix this, the function `repair_worktrees_after_gitdir_move` is
> introduced. It takes the old gitdir path as an argument and repairs both
> sides of the worktree.
>
> This change fixes the following test cases in t0001-init.sh:
> - re-init to move gitdir with linked worktrees
> - re-init to move gitdir within linked worktree

If I understand correctly, this patch is fixing breakage resulting
from the preceding patch. Unfortunately, this approach is problematic
since it breaks bisectability of the project. In particular, it's not
sufficient for the full test suite to pass only at the end of the
patch series; rather, the entire test suite should continue to pass
after application of *each* patch in a series; we don't want one patch
to break the test suite and a subsequent patch to fix it again.

So, if my understanding is correct, please put some thought into how
to reorganize this patch series to ensure that the full test suite
passes for each patch.
