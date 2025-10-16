Received: from mail-oi1-f177.google.com (mail-oi1-f177.google.com [209.85.167.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5FB24A00
	for <git@vger.kernel.org>; Thu, 16 Oct 2025 01:28:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760578120; cv=none; b=ZB4giepY1ApUeo72dP1ouh1M4kuq9V+Hq6hcRs44gZpXM9Dz6BDwGdRKBxGtDW/jFoI9znKFNQBeJfTBF/TtjV1UQVL3l0shi1QXuvCnW+ZsKy1/J0ZGQUYqIQvg+3nudHJtUCjB2pKtqerpZgPHGOwpKMKia3Vk/c5i8ycOGh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760578120; c=relaxed/simple;
	bh=++zWOK/ndcywcgMDD5iMruJUWCT5nbRjr5OBBQf/IIk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=T8rbip47zg0ZF7DoMl+MTbkWvrv+77JnAA7gVnBvbyqctpZLtPnrX9TTeIalIueKaOuVrb++DszB/LEzePtiRMkHTZplcIoZk/tuotxWGyRLVXVpRY16w3aLuz1mW9fES2bDydXU9LBEcydBhIUMY6IqXgKJNVLI2DG7iOPU9BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=jMtaX6uL; arc=none smtp.client-ip=209.85.167.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="jMtaX6uL"
Received: by mail-oi1-f177.google.com with SMTP id 5614622812f47-44181f9e5b4so135123b6e.0
        for <git@vger.kernel.org>; Wed, 15 Oct 2025 18:28:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760578118; x=1761182918; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=V7PYv4RZ1qgxbP85bG6eB7jhsDoICNtYgoGAT9V/ZZM=;
        b=jMtaX6uLXwVxzpt9FkCK3JQC2XMQTicUJzXiTcVx2MaYGRcSUBemThPm2lRDomEFUe
         r8OKmRgittumn5RQY1QyRW4mcXNCK7a5wKuJffo0bZzNHaRnKH1abqYbmcKLdrQ7kdOa
         Big6ZWneotr67Jke8xyxlVjGTblbIbwsC7l39mT6f7DBJZm2TZW2PymV6LsK9CYE4VVb
         r8WcOHH8MdHBgK72/5m5kaxAhdZhAhSHO77SWiYl/O42s4zDjgiQI+NTLp+40eNxK6PN
         /zdKAsAoGRSINZV2wFycWFQvqdVjcfxrOc3xV8uD9IU6RKEJD4MLx+CipmI0iYIMpvSF
         WX7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760578118; x=1761182918;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=V7PYv4RZ1qgxbP85bG6eB7jhsDoICNtYgoGAT9V/ZZM=;
        b=Oyc4m69LSV0hneYv/R0b9FS2zA5vwMXlMnMJ1Fhc/DCkmG5wEWOLd6CLYxkxWHVvLU
         aoSjOaYmlvBOCZK6H2bgPTvCS7UvZUkytjwr4zFZT0XexVwU2JmtfnCAmEa8N5wTiQzz
         iTvrPJxy3VZ7M2LKc61RoFHzIaPf8ipRaxAYwbkXM3oVIe18fJqtkuXdrZrlc+04Dq58
         C4FQ2u6HbH9qbbmrabe6JYR4GHYwlrdGeeHUXoOvqRr1LcLEFTn92fdfUwHAIagfvxUG
         JZnkNp3I7OtE6PFRQ43Y2/cHopSMy17qZU8xePNW6LYP4OHOOfKT8YgNNhPTs9kC5/jR
         3o5A==
X-Gm-Message-State: AOJu0Ywj6krk90ODi13KSelx38mTNQtPnIjua77tTqXDvs2XgN94YFnp
	m/TQAsYxlEbDppzqy/hsLW1kNk7BKZ+lBqdRwW7aEuIIdFsweYR7C6O4
X-Gm-Gg: ASbGncs/SHrx0p+Kod9xz2HGzk7GhdEKVkrukDCr7aWa2f4aWCMrAGa7KsOuFpsbmD7
	+EIKQKSovO1qURyxZ8KzO598+oyCjcdPyomxHfobuxV3XzLLQVcvjbyYm+juH72I7FQHimeN9oS
	WJp4SYtFEx9LqToJ6ghSLa9KNCt2CtcUoOVStdqOAQYNi4KNxK+quLu27OljAFYagNSo4P1VnO9
	Ri1Jo7FriBo9FrZcxmzUCoe1EB7LKyUzCtOwacVxsk5UQTjIkh735VGQJRz4EpFS2jRBw9ooASy
	j4NjwjpdOSDtzt8fb+NpKWAgezz5sTIpCvXiqrUj4acrozVD7zgdknmazUWSZJ89ZWRii2Env7q
	GN0Li9TvDaVZ1Im4yPVj2TcxuseJgyBn3SLsIFcj9tVdiief4tUYR50IhQEcrvQD5D+cepmdk7j
	nU/rwm
X-Google-Smtp-Source: AGHT+IGpV11BlbfMBw4KMkRASs6kZPRoj8lQZqYKPW7Z5o4sfsb2Dym15MzNbU++KyIfHPKkgO1A1A==
X-Received: by 2002:a05:6808:1903:b0:43f:5fc5:e04a with SMTP id 5614622812f47-4417b3b2af1mr11802026b6e.31.1760578117816;
        Wed, 15 Oct 2025 18:28:37 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 5614622812f47-4419893b4dcsm4383558b6e.16.2025.10.15.18.28.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Oct 2025 18:28:37 -0700 (PDT)
Date: Wed, 15 Oct 2025 20:28:36 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Martin von Zweigbergk via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Martin von Zweigbergk <martinvonz@gmail.com>, 
	Martin von Zweigbergk <martinvonz@google.com>
Subject: Re: [PATCH] BreakingChanges: say that `git diff X..Y` syntax will be
 removed in 3.0
Message-ID: <i5lgq7cunzqn2k3puuudzb53efqz6cxev64l6ukwy2kf24dab3@ndymfd2ocit3>
References: <pull.1989.git.1760566054455.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1989.git.1760566054455.gitgitgadget@gmail.com>

On 25/10/15 10:07PM, Martin von Zweigbergk via GitGitGadget wrote:
> From: Martin von Zweigbergk <martinvonz@google.com>
> 
> The `git diff X..Y` syntax is quite misleading because it looks like
> it shows the diff of the commits in the X..Y range but it actually
> shows the diff from X to Y. 

Personally, I would like to see both the double-dot and triple-dot
notations removed from the diff commands because they are often confused
with the revision range notations. In my opinion, the double-dot
notation doesn't even have much value as it can be replaced with:

  A..B => A B
  A..  => A @
   ..B => @ B

These alternatives are just as concise. 

> IMO, if that syntax is supported, it
> should show a diff from the merge base of X and Y to Y. I hope Git 3.0
> is a good time to remove support for the current syntax and
> semantics. Then we can perhaps add the syntax back later with less
> surprising semantics.

With the existing triple-dot notation, `git diff A...B` is equivalent to
`git diff $(git merge-base A B) B`. I think this is what you are
suggesting about that the double-dot notation should do. As mentioned
earlier, I think both these notations are too easily confused with
revision range notations so I think we should avoid using the dot syntax
for such a shortcut altogether.

The triple-dot notation is a somewhat convienient shortcut though. If we
wanted to remove it, we would maybe want to replace it some other
functionally equivalent shortcut.

All this being said, I've sure there are folks in the wild using these
notations in scripts and changing would cause disruption. Maybe the Git
3.0 release would indeed be a good time to remove them though.

-Justin
