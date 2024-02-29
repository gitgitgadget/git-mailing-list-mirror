Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E4F62A8D7
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 18:27:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709231227; cv=none; b=IXyx00Xgwf/J20ypz2dSb1tPkvwwSsQWRnemt/ltXbspAnrXa9jYNSdShcCs2Rk+kUt0NZa6vFuQU3qrNU+FiBT2KA6DMueauM2RaSaNfZUJ7YpTy0R5WA63oiGNzcBiY3z+Zh5o4gKTVD2MLPMAWiLt5xI1PPQ4qVH2Hr/alQ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709231227; c=relaxed/simple;
	bh=Zct1crJ8PWGchrPdA35SL+BHuYc+iT6SjD0wjvL7Fvw=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ROI1EJz0QUA0N+W94oR+sCrG22RWA0k5RdZAhJqs3yKHh0abxNEoMdMRKtdPvQxZRXVtSRJBBnIsqo6vx6wp+Ldg1+n8vEYC41jsgoLEQftav7B88rvXJf6Zx+Z+KAg1q200mma2bcLjrTCq3V50hk+y2J+BwxhSuZqR1ydGpZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s6GW0jCF; arc=none smtp.client-ip=209.85.128.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--linusa.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s6GW0jCF"
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-608d6ffc64eso17371257b3.0
        for <git@vger.kernel.org>; Thu, 29 Feb 2024 10:27:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1709231224; x=1709836024; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=BluYLDVNBlDqcCmUkRrqmAGfl/iVpChk42x+EeOB67k=;
        b=s6GW0jCFUbZJdcZx892V+f6yMG+U/XxxDasK0WvzqSjt+TysQEYnqFG6jRcuxzM1OR
         RMMS9crhbtDQ1d68+e5XkJegHU+Y/QY9kngGrd3gdaMa0M/p3WgNYAzjoxMYsxwbfrqv
         TKozW96LcCWA9HTD1FBxxs4WQ89Mee7Mls+jpL4ni+ubg5o88KhFoRWk10wqZvkILy3F
         x53Hgg4mKTQZJpPMODJYQa5RTT9v8RDRhLH7smQp2cop3i5nbE5GnO3ZPVOxcyEiXZqu
         I2GMO6qoWA+jRNhPyJzcV54wSbIpyjsCfpIqN6+6QZFP2FlXJVkXc8N3iPM9kS6qeLE0
         hpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709231224; x=1709836024;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BluYLDVNBlDqcCmUkRrqmAGfl/iVpChk42x+EeOB67k=;
        b=bipmObUuvnypijtsdEe0zooIikS0DrSNxfpzhsRygcvdNDgZ+zkykHmzAV1P94nQbW
         opOlJKvQiLuHYAMBcVsvxUwinMBFoWB2+bdZOPQtQUK0dcGkNcX8eFZe4EL0Rz0ta0xE
         YJhRKBS6SWfHAu2Mgwnj2RWe1S/1wr1TPHEQAN3roFXSEVVwp2Xd8HDrfx5REvn9YXLt
         s6JDgMvR5eIq3dosT0m8f8DRtCnmyYU1wTEMioPhP50+cGp1ZhxXUyIi8J5f+Yytg000
         Sy2aQ94+7JZxaV28ud+PYnlpDaiLN8OWNrO/zitzWvC8TWvKZc9n9JHk/+RZGZ+npL4E
         A9Lw==
X-Forwarded-Encrypted: i=1; AJvYcCUlO3/QGvzC4QhCW7v7R+2hGwO/cBh6hViFApOMXuBBCnSzPhAaMKVdbM5rT/h2vLtOygKvzB/9Y83u3v5Kz5t8NQk+
X-Gm-Message-State: AOJu0YyT7q6sQL4dkueGOinAbk1QXV+Rc4hKkfGCPzXKwmlHMD/m4gLW
	z/gBhG7fXDmxOTvHgXgaT5a/8v2ibGXwi+RkSxJ65ApskaMouryl/VyVDOc3i/H3+JvoonLN+ZR
	Zsg==
X-Google-Smtp-Source: AGHT+IGqd5i4to7Xcb1cu/WglL8OUVzoLX0OxN1SSaiZU/uM53Ow4v5QVd/Njxqjdq0GDH9uHFSjPnZiuEs=
X-Received: from fine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:2221])
 (user=linusa job=sendgmr) by 2002:a81:49c6:0:b0:609:5bd8:de84 with SMTP id
 w189-20020a8149c6000000b006095bd8de84mr454757ywa.0.1709231224587; Thu, 29 Feb
 2024 10:27:04 -0800 (PST)
Date: Thu, 29 Feb 2024 10:27:02 -0800
In-Reply-To: <xmqq1q8vi3pz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <cover.1696021277.git.jonathantanmy@google.com>
 <20240222175033.1489723-3-calvinwan@google.com> <db8b2398-c6d6-47a1-a4d4-7e4726d13312@gmail.com>
 <xmqq1q8vi3pz.fsf@gitster.g>
Message-ID: <owly34tb5dop.fsf@fine.c.googlers.com>
Subject: Re: [PATCH v5 2/3] git-std-lib: introduce Git Standard Library
From: Linus Arver <linusa@google.com>
To: Junio C Hamano <gitster@pobox.com>, Phillip Wood <phillip.wood123@gmail.com>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org, 
	Jonathan Tan <jonathantanmy@google.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Phillip Wood <phillip.wood123@gmail.com> writes:
>
>> On 22/02/2024 17:50, Calvin Wan wrote:
>
>>> +libgit.a, which is then linked against by common-main.o with other
>>> +external dependencies and turned into the Git executable.
>>
>> I found this description a bit confusing. As I understand it to build
>> git we link git.o against common-main.o, libgit.a, xdiff/lib.a,
>> reftable/libreftable.a and libpcre etc.
>
> In addition, there is no single "the Git executable", simply because
> not everything is builtin command.  The purpose of using libgit.a is
> because we are too lazy to list and maintain all the internal
> dependencies to link final executables like 'git' (which has all the
> built-in command implementations) and 'git-remote-curl' (which is a
> standalone program).  Instead of feeding exact list of object files
> to "$(CC) -o git" command line, we throw everything into libgit.a
> and let the linker pick what is needed.  To link "git", we may
> include all builtin/*.o, git.o, common-main.o, libgit.a and the
> external [*] library dependencies they have.  To link "git-daemon",
> we may not link builtin/*.o and git.o and link daemon.o instead.
>
> 	Side note: here I am counting xdiff/lib.a as an external
> 	library as it is mostly a borrowed code.
>
> In other words, libgit.a is not a true library in the sense that it
> was designed to be _used_ as a library.  It was merely a detail of
> how we implemented lazy dependency management in our build process,
> which happend with 0a02ce72 (Clean up the Makefile a bit.,
> 2005-04-18) whose commit log message uses air-quotes around the word
> "library".

Somehow I did not realize that this was going on. Thank you for pointing
this out!

It does make me wonder if we should stop being lazy and do the work that
the linker has been doing for us "for free" ourselves. IOW, stop linking
against a monolithic libgit.a. That way we would replace implicit
dependencies with explicit ones, which might help us understand which
things need what.

But maybe doing that is super painful, so, maybe it's not worth it. IDK.
