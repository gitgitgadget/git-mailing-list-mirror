Received: from mail-pf1-f174.google.com (mail-pf1-f174.google.com [209.85.210.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9B1818BC3D
	for <git@vger.kernel.org>; Thu, 12 Jun 2025 04:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749702360; cv=none; b=Rnp5Xp/u2l7y0VtKlv/LD18MdgB98A+Ux8/wFq6Tzlkqu2dZzhWd8EMz396PXJxbk29JWRZcK4uU4RQ96BEWwk5f4n6hVe7eoNlzqMpUw4a+fUjrwawP555wvmv40kBnr9QW6sYSvecaX9YaQZ/NUx+sitQ3ainXpLmF4qcb2Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749702360; c=relaxed/simple;
	bh=PMtcihMS57CixLx994nX9VZT0GT+MtRlAIJNDlnkDuk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JAgv5oELwLe0tCAR5bplLRCGqdiQ8BMPznNVvZjx0J09d4eOetB3+/mZpUqRoi+t0dqRMIGl193nOVz+yibK/ST3w0F7bwkj0jg2ujtI63e2tuYvvnyMMDSbPhD+QV5JDfJvJmD8aBQU3yJcdaqqrwaTgBLnITSu5fvfJwDw4Tg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LbGzBgXh; arc=none smtp.client-ip=209.85.210.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LbGzBgXh"
Received: by mail-pf1-f174.google.com with SMTP id d2e1a72fcca58-747fba9f962so468168b3a.0
        for <git@vger.kernel.org>; Wed, 11 Jun 2025 21:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1749702358; x=1750307158; darn=vger.kernel.org;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=PMtcihMS57CixLx994nX9VZT0GT+MtRlAIJNDlnkDuk=;
        b=LbGzBgXhtMATnH5XHyMgWtLmfUEiowZmz8ZIsTQF/KbTS9qOmg1uCHiG3yhMyqnzPx
         jSaGbVYGy32nSmAoZ3qjBLoglQ9V7Y+tu+Ss6Qg/BWtDNs3Ez6yJAzAhqjAR/0mE3i7Q
         YUYOb8ZE1HV8tmH1IjjHFkYLjNz5e/0zHdKcXkMLbGyuC1q2I2cX4cAPOFEr0WzMcz1e
         +Bh+bLqEMXKpTxP+pqEMtd8v3ehhc4hgV0YCenHQgIlnjC7H65sfGsjU2kfuY8RNXF1y
         btXCo1AMSuZtv1ghie79msMYRTpsq019/O+T7tEQd2rYVubkQDEclGQ2xPXO3ffoPnpR
         h8eA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1749702358; x=1750307158;
        h=mime-version:user-agent:message-id:date:references:in-reply-to
         :subject:cc:to:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PMtcihMS57CixLx994nX9VZT0GT+MtRlAIJNDlnkDuk=;
        b=xPPuaRuxsMQbavBuIFbAtqNwSIbuTCl0ttdbVyInKdu2Mbsb/7v/veWM0SAnRuQfJl
         2YtJoraD07Q4VgRBBiYuKARTJ3qLiDC1wI4wiuQv9+yTKD4Kywj3MLTB/5dbWM4Ohp86
         1d3wg9gVjp1+vgq6ngraZNOu4UMqrybWE2ssmQSFkajf3BDyeTtfXhZFRX21dx8Gx4tK
         zhldB/eIzInJS+BkZ62GWJoJy+wMLCzl3Iic8m7fDAFTp8aXtkRe+/jkt4ggzj9JHU3x
         6nGa5s11JPjFMUACLUfI4l+iUH3K898uIc+39uL0MHb5kyuAbPrZVzxOQgqkZZfYls2C
         9aVw==
X-Forwarded-Encrypted: i=1; AJvYcCUAVTGKh32lmVDWHyyYzAryrrEQkU0m+bh30scfCYHMg2HLHddzz25w60ltO46lrOPArtA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwUUhJbLESVA74D+ld8YzqwCyVT5h8XHapscUq10QgXgp6KgCwT
	TOpZOIOM6SNGY9Iv1yIm0IAB5MfXtJ4tWZuVPsQ07HaexW86ifn8N9v4TNXYiA==
X-Gm-Gg: ASbGncviyQacfxxBSHJIQFBWQJAha/Z1dx3CMK5Tp0puvKIeUMY7YlibBNIXSXWz1Tp
	aa2HRlubC7nztg1WZnzmskzdalj35ApAFW0nRA0fZpxH9deRRb/aGNMe1S2E/dpy3MyOpzXnAHh
	BldbaXoaEe4lJormsmrxe/0F1AgLSJVq+OyoosU0E/Q5azOPG13Jl8mzSJiwqcArGXHpSEtG3yG
	gmUK8qmPCCELwsjDtlKJQb9ZeRFcuoWtpn0gpm/7Kcg08gHZwx4pmMgrg+FwKhOBw1iFvGEkGqb
	ZpAeRaIdJQ0LUVVqFCrDAurQpmCAEhv+hRDfyAw/gB4=
X-Google-Smtp-Source: AGHT+IFyCUcYkbuNIxSY/3/5KQSb4rbloH2EPR5uFSwPRJxYP6Acw6s7ssNsdkiVZen4gKJ1++KKkw==
X-Received: by 2002:a05:6a00:9497:b0:746:195b:bf1c with SMTP id d2e1a72fcca58-7487cf174ebmr2402822b3a.10.1749702357867;
        Wed, 11 Jun 2025 21:25:57 -0700 (PDT)
Received: from fedora ([2601:646:8081:3770::53de])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-748809eb0easm435263b3a.113.2025.06.11.21.25.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jun 2025 21:25:57 -0700 (PDT)
From: Collin Funk <collin.funk1@gmail.com>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Brad Smith <brad@comstyle.com>,  git@vger.kernel.org
Subject: Re: Solaris sed
In-Reply-To: <ed3d9c32-5de8-4653-be75-d2b5c89340e0@gentoo.org>
References: <09f954b8-d9c3-418f-ad4b-9cb9b063f4ae@comstyle.com>
	<87bjqteicd.fsf@gmail.com>
	<f2082cde-7eb9-4927-a01c-e6fb3b355d13@comstyle.com>
	<ed3d9c32-5de8-4653-be75-d2b5c89340e0@gentoo.org>
Date: Wed, 11 Jun 2025 21:25:56 -0700
Message-ID: <87v7p1d1rf.fsf@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eli Schwartz <eschwartz@gentoo.org> writes:

>>> The second is more tricky. The '-E' option to use EREs was not added to
>>> the specification for 'sed' until POSIX.1-2024 [1]. Maybe the script
>>> could check for the 'gsed' command? All of the (few) Solaris machines I
>>> use will have many GNU programs installed like that.
>> I can't comment on that especially as the build bits support pretty old
>> releases and
>> I have no idea how long Sun / Oracle have been shipping GNU bits like
>> this. I do not
>> believe this has always been a thing.
>
>
> The Solaris box I have a shell on, has gsed installed as a purely
> optional third-party addon from a third-party package feed. As far as I
> know, Solaris never did nor plans to ship "GNU bits like this".

Yes, sorry for not being clear. It is not installed by default. On the
compile farm machines I have access to it is always installed by the
maintainer. Or on VMs I use, I always download it. I figured that is
pretty common.

> Of course, the Git project *could* declare users must first build GNU
> sed, then build Git. Or only build on boxes where the admin is a GNU
> enthusiast. But that option seems unlikely and unattractive...

Perhaps I am too mean to Solaris... Their 'date' command made me give a
similar recommendation before. Anyways, Junio wrote a patch that avoids
us forcing GNU tools on them.

Collin
