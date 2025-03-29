Received: from mail-ed1-f42.google.com (mail-ed1-f42.google.com [209.85.208.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D221D2F37
	for <git@vger.kernel.org>; Sat, 29 Mar 2025 08:58:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743238730; cv=none; b=nRvbQ1G1FdO3jVogXz3EcIvZaigvrI6a/UrH2oRIQNuGc3Ci39eSKcZmlXtq8doeAl1NrRVfec3mCZkxmpUqdlaecdN+CrE5SR76q6SZ0OMmWpyjnS9i/CwtsjI9KsQR37KwwCjiEqk7yJlBI+J27yLNKogbdcpfX19uTRnuXb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743238730; c=relaxed/simple;
	bh=8zai0VOI+urZt1629p8jshFYaxgaDpLWH782umQAr8A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOvF7bgLiWcpg0eBnxbtUR3iJpQMugHJAumygeg7hiBdp9tIvI0okqKsPL0vuFD98aIwpcCgC59w6pROLvckUGJZh3si3GSqHUT/K5dI0DWm1Y2HQIP3G+zZpCsK+4XgcgBu2ar2cLY4/sPpygTpJdZPjkn0jZicx97pEZUeCZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gVpZ4cEq; arc=none smtp.client-ip=209.85.208.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gVpZ4cEq"
Received: by mail-ed1-f42.google.com with SMTP id 4fb4d7f45d1cf-5ed43460d6bso4948981a12.0
        for <git@vger.kernel.org>; Sat, 29 Mar 2025 01:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1743238727; x=1743843527; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8zai0VOI+urZt1629p8jshFYaxgaDpLWH782umQAr8A=;
        b=gVpZ4cEqONyvO0/3bV76uTMt4rZPSh+IYojdWD23v8T2sGh8B5PQjYoiOQ/lF2QfDs
         PV6RrWjZtNxYB7YAyYjzDw6fPxu0wG2pDqyOc/+LH2UW1j84k2D7POTSKG/W0+DJOI/i
         4FahN27WQdBFX0lmQFdN05ZPRZZJV16x4DTWD1NTfyQ6OJwSHRY0ysx8oZpY7tvzpYKu
         aEPzI40alxhfFHBwjIWNw3bgqyroHEpD7JjKtG1LcvnywQKf7eSghQrba6dgtV25qu6G
         Uf28AaVSGxl4TNOU/2wfEbPiL+rnoAXzHKXYwSymMkGrIMsmYwHYq77/fkXKaNjbU1h2
         g3RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1743238727; x=1743843527;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8zai0VOI+urZt1629p8jshFYaxgaDpLWH782umQAr8A=;
        b=NPZJHQo5es82kZeqqlY4iEpFVn2vRLK2KGBGvwhHMATSQjMX6LlXtm6zQoKYRdcLib
         jKXq/otSKTlIQPtFln7M5gWdqGWGVP2lrunUOlcBf7uZ59Wh1VHH6zYyNaZ6Vm3Lp1MG
         JPwmhKDZBQKR9PMvWcKauCNoXPoCguuWOkboLpxGnhTTRWVGWcXgdgHqxYoR6Zcs+Uzm
         mUp/KHv+gZjJvAmvExyzE4qua0+NK4k5sBhRxxhHDKEtJLSkOU6DTy/oa2sQuPH0+nSv
         vH24EJoOmlcsC/87pP+WQSXoeqTR4Z01ReV7Pn5x0YQ58FlQ7ojlmAL7ZJ2ys5ncdr/i
         O9qg==
X-Gm-Message-State: AOJu0YxeX4lR3GYJ4ClCKFyZYXGofJsytOOkK7S0UM0bv92+YDc0ibep
	ObunB6SXgGXAZVE7BJcc/U7FWCWqhenMafYdbeGkBcDXHHX07LhABV1QsES82ntFqwZ5Bk2jaMk
	bPUsz9c7iy2CifKOnmJsVWYuWEBt+jgvZ
X-Gm-Gg: ASbGncsppLbRHP+QkkPPP8yLp3QKSxTGv7FRb7iOVI1LMtnS+tdXYhA1SwQPWmuu3Qx
	9gzIKD7ZcBxHHm4oJ6smSM5Y1sVFRDO+ds3yX/E6vnPBtgLnp7CzjcInRPQi42mjXcXRJgnJ35L
	/aLSKNWepkMQbrcROLIVVfNgOS+6YN
X-Google-Smtp-Source: AGHT+IEmKLQXaYiqzeUmK7b+sUf7D4LkwauKwvTZ8GNb0ZcVGI5gxTPhgVMEnErPlrL2J16iy7SU5oO/5qHGCT1wu10=
X-Received: by 2002:a05:6402:550c:b0:5e6:1996:7902 with SMTP id
 4fb4d7f45d1cf-5edfdf202acmr1675835a12.32.1743238726836; Sat, 29 Mar 2025
 01:58:46 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250328170121.157563-1-jltobler@gmail.com>
In-Reply-To: <20250328170121.157563-1-jltobler@gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Sat, 29 Mar 2025 09:58:34 +0100
X-Gm-Features: AQ5f1JqUdXqDEyrev9ezz07XHKvBv4nIGbOB6qcpXmkNwolWK-zkLkFu4dak9jU
Message-ID: <CAP8UFD1oYmr=2ZCOVVjk6NbSCtA1Zv+3jy26jSSwHuOfdS6BQA@mail.gmail.com>
Subject: Re: [PATCH 0/2] help: include SHA build options in version info
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Mar 28, 2025 at 6:05=E2=80=AFPM Justin Tobler <jltobler@gmail.com> =
wrote:
>
> Greetings,
>
> Additional information regarding how Git was build can be found via the

Maybe: s/build/built/

> `--build-options` flag for git-verison(1). This currectly does not

s/git-verison/git-version/
s/currectly/currently/

> include information about the SHA-1 and SHA-256 implementations Git is
> built with.
>
> This short series adds build option info for the SHA-1, SHA-256, and
> unsafe-SHA-1 (if any) implementations which may be useful for diagnostic
> purposes.
>
> Regarding "unsafe-SHA-1", I wonder if we should use a different name in
> the printed build options that sounds a little less scary. I was
> thinking maybe "fast-SHA-1" and document its meaning appropriately. I'm
> interested to know if anyone has thoughts on this.

Maybe we could use just "SHA-1" if a single algorithm is used for
everything, and both "SHA-1 for crypto" and "SHA-1 for non-crypto"
otherwise.

Related to this I wonder if we should warn in some ways if a non
collision detection algorithm is used for crypto. For example we could
print "SHA-1: OpenSSL (No collision detection!!!)" instead of just
"SHA-1: OpenSSL". And yeah that should be documented.

Thanks!
