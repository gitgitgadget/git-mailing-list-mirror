Received: from mail-lj1-f177.google.com (mail-lj1-f177.google.com [209.85.208.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3CDC26FDAC
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 21:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770067164; cv=none; b=Jnf9QS7tYFcGx6VPAyOzQkNZO4eX+Md6tsLfD8sMnpOsMINC+3IeXyavXKmL8wkoWCLV45eMYIS0lBc/YaTJJrq2GaM/nkVauJNwMvYOgz/6a53FoZKgQcN1zxO6/DeoX9IwiQcdF3znmTtZhNZLwq5RPPyAXwpf8BBWfdHOFkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770067164; c=relaxed/simple;
	bh=Z3KM5acezdgIxyratQNRjzk2BqpTFAURkbh/NJjoZFs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Lcjn4F4yJUxr5noSsbDqaqR31j6drzpJSEH7a9nQTzwRGgwVadfLhKtKQdv/x/ZV4FH+M3SljWdsnn1fDe1bWurdPBSuRX30EGfXYF/QEdE2qqWQhOR/p7R541qDNhdZZBilY6oPGVp0Qvx45XOxQiQFF7WjzRTkaAIYwF3aztw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iHdh6rTG; arc=none smtp.client-ip=209.85.208.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iHdh6rTG"
Received: by mail-lj1-f177.google.com with SMTP id 38308e7fff4ca-385b5174f54so41657371fa.3
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 13:19:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770067161; x=1770671961; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Z3KM5acezdgIxyratQNRjzk2BqpTFAURkbh/NJjoZFs=;
        b=iHdh6rTGygp4AWqtH+EXuCwj+QrqivseK/lI4yoGgB3R2QPibG3WmIUqIVRYijQzHA
         pZQvSFHtgMFM9hWhHKIyMRWS5WaYACIWT7ZuisVfALKrIkNDCT67mg+X1dJ1wKl/xYmy
         zycl+WVzmnKZ0a5HKFjotY7xWRm/IH9FGNzJFot3vf8CTBhboSJ3IIo9CcuHtwl1Lar6
         KR9kvnTRiJX2jUnV+7eYT2ISF4p26SmGXaq5yFhcP+aEBNZw1csMfs8I1+tB6UfPQFvj
         8KaH/TBsZaeVVP/dSQugVr9+EhISOk2DmVH39b7hfIZl49pTNbWS00DUA+OLjhPNb62R
         5DmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770067161; x=1770671961;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Z3KM5acezdgIxyratQNRjzk2BqpTFAURkbh/NJjoZFs=;
        b=O9UoZugtuU0CSQegQsqgqmHJAx27+SvS5TayCZt+AGTB1S3eDvhcJCPeBiT5iIdpTN
         SHRx0ffEUJDti8qrjK47QHUHYVuQ1xkvce7cLpAI+8ha5K2RTuwAGTAv9cf5gu38vnxU
         jOj1ru40ttKjPSE4wOmyEr96UBtm+yNP7ihfthZIVoFyDD1YZ6dDHp1cSU55/q4IY5Rz
         WIYEoNSEtCkuD3ka3+gL08LRqLiYdcYrgx326RNBTZV55ZaZj+HAbVRqTh8devaAkm41
         PtYNK8pclJ2+ED6sA6hYQaSvoUuj44362NVRwPOI74b2pjNkdp61JTB5fP+7//BG9xiU
         XoGw==
X-Gm-Message-State: AOJu0YwTNzupbyK0E7Qun2A30cwd0VvivW9S2EDOMVy2Lpno9FXrKa4o
	fII3u3KbjSMjO9p0nZAPwDrxZq6hflCd3JQWuYvOo24YfFco5N+Dl+tC
X-Gm-Gg: AZuq6aKg3Fd4IyqfD/nCrrzKaETl40O91t9RTskIFqVAMV0GMPQfbJJnGFjWUcsS5oj
	fKpEuu2IdTCCGYbqYxo0V9hXPv9lVOozrsH4EAg3EAWGPSpiL2hxxhFXYrCAzhoZ7cvgEAzfJdD
	5ZLQy8kyjU2aE7jJ5/DzZSFtD/z9Ea8LCQ2SfNt2K2/ac9xG9UBH/21521reT9EGzwxuu7+WjrJ
	1wEAa5/NDkygy9p67Ub1Wh0ThAgrkai6pCJG7L+gLm92kO8IoxjtEfQDupK13WQz1+/ykbbZVDm
	dQ6FNMBNuDsgzykZ6VCbM2qMDDAv5wXz9qIOhWUCIinM962xIm+3W9VsiVl3/AHaSNiyTqhfnzF
	cZiRrBS/818K/Ji9gdnGUwwly9zEe7GtKP5vMnz2d/r1g4FkWyibZVIRnHlRQn//qFydz9C37Cu
	bs+g5+m+MN3NIW2c5vsRJP1lpQQMKDE0dwhpIGLJAUXkBTkwbGTDoaylji5YGmcBNfgz60aIg=
X-Received: by 2002:a2e:b8cd:0:b0:382:6067:a230 with SMTP id 38308e7fff4ca-386466ecc51mr49677061fa.40.1770067160606;
        Mon, 02 Feb 2026 13:19:20 -0800 (PST)
Received: from Mac.localdomain (h-85-24-230-197.A753.priv.bahnhof.se. [85.24.230.197])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-38627876ab6sm31192771fa.49.2026.02.02.13.19.19
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 02 Feb 2026 13:19:20 -0800 (PST)
From: Harald Nordgren <haraldnordgren@gmail.com>
To: ben.knoble@gmail.com
Cc: git@vger.kernel.org,
	gitgitgadget@gmail.com,
	gitster@pobox.com,
	haraldnordgren@gmail.com,
	phillip.wood123@gmail.com,
	phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
Date: Mon,  2 Feb 2026 22:19:19 +0100
Message-ID: <20260202211919.4968-1-haraldnordgren@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CALnO6CDrdfSFuY8xjvno3+2MVB2JHUYdNsYTYqqRsfcDiWa1uQ@mail.gmail.com>
References: <CALnO6CDrdfSFuY8xjvno3+2MVB2JHUYdNsYTYqqRsfcDiWa1uQ@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> If you don't need to be on a branch, then "git switch -d origin" (or
> upstream, or whatever your remote is) should work just fine.

Thanks, but it needs to be a branch, do you use detached heads for
anything? 🤗 For me, the only ever happen by accident.


Harald
