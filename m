Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A2532C11D1
	for <git@vger.kernel.org>; Sun,  8 Feb 2026 04:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770526636; cv=none; b=X1oCUdU05JR89VX4TH9x3uMi6ZlP1q65PaAelMJIIlsEYg1PVxdaw6SsFHDmorRH3ASwtu7SAkkoaexwFMLCAAtpcGjke1Wn0wE/rV/AvA/F1N6LzzX3oHtUxFdQEvbZW73lKBIenn51wHnXsmiR4LGZ9i6d1mwyO/Q29QixgmE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770526636; c=relaxed/simple;
	bh=gkjNaR7G8SyWilPYkBqufPjV3IX1Od7GWKOjx+OzB9I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Pjk8C7y0wlfBh2/3Su1Akq3taVyqRpKEw7oUayS1SQkOOIXjVudmcBxC1RHKiwzwcyDbIb7m3yCkU5acKc9foJFEtpse2T7yZcs7d4sR16sknvdVcz2sppG1lNLwygdQceTAqTtvtvnD5h/QpFnF+YXQ/ZTHnvnR0gvD2A2N07s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EFOM1+kN; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EFOM1+kN"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-81f4e136481so998780b3a.3
        for <git@vger.kernel.org>; Sat, 07 Feb 2026 20:57:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770526635; x=1771131435; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=u0hliwBb6UcH8nky2iD+NC9CUxK4GXqbkEakHjO2wc0=;
        b=EFOM1+kNEhuFf2fAvUfP1X06x/q5lppzi0/6zwpm37i023HaRuzk0U9viixxAeVFh8
         DEsu0U6h25LUxE1HcsGtkFOnW30ETsqiVQ1WmJKtdJXR8DH6Lfo7a0tKBYx6wjl1ujq1
         OpusbA3J0B5xIM0ce9dJ8f5DqkY1fKsY4OXoTR3sUnWcVT1MwtBEHy39fU2b9nPwws6N
         jcVvv1ifZOcTovqpeW+kJtya7RNI44oFglUg2k/8UUQMd6G24qOQVRJGLpg3VYNZZILA
         aXQm7qKyP1V9EDTP0GFpwEMMD7dSMp8guhlOQBqV4MplSuWpRoJrmxPj9fI7YUvj0d6T
         vVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770526635; x=1771131435;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=u0hliwBb6UcH8nky2iD+NC9CUxK4GXqbkEakHjO2wc0=;
        b=ZXCmoBQ4PG3twYqD5HVha/dRdTH7pBLvuKLyqDcb7StTgOr8g3+Nb7k9SGrH4+wSo6
         /p2TU9VtNiEZwsxU15HWn8Setsrj9lQjPbC8otOdVkwS63bpKZZY5vW/FPlYUJZQKDJy
         AnpCzD1yTtI4qBzd0si5R+mHlwP35Tx5qsUu6BdRyv/BGaB2UoCNi4d78SVXP8P9LpkZ
         SCYGWVYhw/JAvzh61WfFrbS/cyoKfv2X/PYOf1+wKHeksJg008DTFLvVAB0zt2K2nD6k
         j57tRWY2xPbu6xWBkZoGVEkKHYuW2rLlPFNY8cYN+1kuMgnpgi7EyqjwERuwgGfGkjh8
         TJPw==
X-Gm-Message-State: AOJu0YyPu1XVv81uRWECdoL3P4F8PKpnYgQX5jT58tXDAxOfF08m3r95
	XA7CImrL7N2Bb9jZk/YdtEOAk59pJ4BlmkUqfffefDcRAyU5+iflRbxCY5BC35bo
X-Gm-Gg: AZuq6aK48+Nm3NU/7MfBEVTuj5d5MVZSwNpoCnh78jmlzkG7u7opkjk3m2HLfVI9Oy3
	JH1MWy4MATeBRbK/O/P6AiNmp3FUrlgtHORYNbd1tivhx7j+vn4udGycqR/9+X5qOT+T2TUvQB+
	lT5EkwWyy/dXcbEjCKuQs0PztdDSncelSFMc4mkuz2Np8F/Mp3JYufjJHayGKcArFiDXQyl0rJ2
	2gIo96aVG/K8F5M7asp5u79uTOmce4vlohWGZEzXXR38424VKusDiLCadxhDBUUisMIIU0SREeH
	r01Pyhftx+r4mHJz8FkBw8EPw41ljzf/HRZzmD9UB5bor9XJx2OkzoWdH9U8SOGPP5umK5ZgCoH
	xQkDL0HMxrDahkz+sdu1/NjomfsbzcDmugjYahp1giOj2/9xcsXt6sCvGukxbQb/8wsaTXCdYgJ
	t6bElib8Y70LnjzC+Fl3rhK0MVTXcTxGyIV/7s1yFOggpP
X-Received: by 2002:a05:6a00:1904:b0:821:7d7e:41e0 with SMTP id d2e1a72fcca58-824416098e2mr6659729b3a.5.1770526635060;
        Sat, 07 Feb 2026 20:57:15 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:2650:b6c5:3b:d430])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824418b8438sm6350990b3a.57.2026.02.07.20.57.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 Feb 2026 20:57:14 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH V2 2/3] wt-status: pass struct repository and wt_status through function parameters
Date: Sun,  8 Feb 2026 10:25:26 +0530
Message-ID: <20260208045657.35689-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <xmqqzf5k9guh.fsf@gitster.g>
References: <xmqqzf5k9guh.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:
> 
> >  branch.c    |  4 ++--
> >  worktree.c  |  4 ++--
> >  wt-status.c | 48 +++++++++++++++++++++++++-----------------------
> >  wt-status.h |  6 ++++--
> >  4 files changed, 33 insertions(+), 29 deletions(-)
> >
> > diff --git a/branch.c b/branch.c
> > index 243db7d0fc..e3cf273339 100644
> > --- a/branch.c
> > +++ b/branch.c
> > @@ -412,7 +412,7 @@ static void prepare_checked_out_branches(void)
> >  			free(old);
> >  		}
> >  
> > -		if (wt_status_check_rebase(wt, &state) &&
> > +		if (wt_status_check_rebase(wt->repo, wt, &state) &&
> 
> I am not sure if this is an improvement for callers of the API.
> 
> Isn't wt_anything() that takes a worktree "wt" supposed to work with
> the wt->repo repository?  Or is the API designed to be used to take
> any repository object that is _different_ from wt->repo?  I am
> assuming it is the former, and if so, the only effect of adding a
> repository parameter to a function that already takes struct
> worktree is to invite a programming error to pass a repository that
> the wt is not designed to work with, isn't it?
> 
> > -		if (wt_status_check_bisect(wt, &state) &&
> > +		if (wt_status_check_bisect(wt->repo, wt, &state) &&
> 
> Ditto.

You are right that when a worktree is present, the repository
associated with should be wt->repo, and callers should not be expected
to provide something different.

The reason I introduced an explicit struct repository *r
parameter I have included in the previous reply.

So the intention is not to allow a repository different from
wt->repo, but to make it possible to operate in the absence of a
worktree. When wt is non-NULL, the expectation remains that callers
pass wt->repo, and in the case in which passed repo and wt->repo are
different worktree_git_path() would handle this case in a BUG().

Best,
Shreyansh
