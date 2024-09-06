Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BB214B956
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 19:37:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725651454; cv=none; b=DH+QgHzDguNt1DT2tZwMyWBSmQDEG0NTy0agCH6SoQ7/gCS0az+2wmjNwkVnfIvMLHlb4ExFwOWRuIuTHb458eUd0OSu5EFQWuD/Rayp2/scIk5kjzsFI/uYprA1pIy7fGbo5YjsL0gB2RUEaekQLv5ZbkR1JCmSrRReGGqNBpE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725651454; c=relaxed/simple;
	bh=k4oHimeArXpIzYPFzYgtDYG1vn1H84pnNOZS8tWSN2A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=AXkQu7DAGlgOM9+9MgNHYaR1vzfecsHouPiyTITtpFvaeXtGq7ogIiVqf+JKqAOLqCvVZ5+n34yDPHpXxu+t6e1dCpbYu+c+gRVt44aEccEd3cpm14jIFpqAh3kxG2MLGVRNXUbPLhcBem54CERDFup2zx0zolQLsdNU9jSP5Ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=RYwad/AL; arc=none smtp.client-ip=209.85.208.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RYwad/AL"
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-5c247dd0899so168a12.1
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 12:37:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1725651451; x=1726256251; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k4oHimeArXpIzYPFzYgtDYG1vn1H84pnNOZS8tWSN2A=;
        b=RYwad/ALIAH56ievjdIsGG5RDi+P57dYnI8POnV/3S5ins4zVfQywsg8m528fAmrJB
         HtBWeEcPWLmjZWK6w35U2mP7bdVQaUEG7nakR75sUQqPaA9u7yvNRD8qieTKgWI3f5oy
         i+rOXeB8sV/oCbp0FxPO9gzDXnJEAIIdEJM2Ekk1BwvPEJsdPHSZBcMYa/gMcPjZxmyH
         +9ke/Pb/RF7piArZbCHHaqmlon/hzD3XbkGIehjo+3O+s2GhgQvZjnGpAbXECJ6i1PhK
         l+ukOUyPVcjoiERaC4D5o4I6dNHX+vTPm6SODcjJQfUG3uY07dbarQEY6bALOR4sgXNA
         jZ8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725651451; x=1726256251;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=k4oHimeArXpIzYPFzYgtDYG1vn1H84pnNOZS8tWSN2A=;
        b=pb04DeL/tO4bof/1YIKQ0PJRtNC2DvYDrs/TEjiR20OvD6bgQleTexYT7m6wUzF+z8
         OKRzpkWvm9ZvdhHBHMg6pKKI3TfM5HzXP1fyEQOnzAhNIeyqcCUsV1/b3/zzjGu7qrQZ
         VvqvX915zmmQq2afbbdk9ZnSjSvKmLIFYhEkqS0Qd2UpAjiGu6sUq+45Y4uZ6mkHgGV0
         c6xfpCLLZ4MRsAMt1ziLpYg7gRvQCH/sRmnntTWsvODqmXBXtqMnm3/Y8jhvpGOcu8D7
         G2XPwmNjxOZGIiG397zSQI6D2iSHG6AV8ayyk76CqE9ELKr/LkKihlDRVn9XnaF5RWX4
         e1LA==
X-Forwarded-Encrypted: i=1; AJvYcCVTMptmAjKqTHslPMf8Jpcji6UqFu4CKV1444zGYXLoj8v7ndJL0JNVfUz3YzvGAkYi1r4=@vger.kernel.org
X-Gm-Message-State: AOJu0YzCWpljclh3KG5Im3d1ya+OD7PKrqRmsfQpbbbQZb24JwSlIhPc
	FsS20CROjfQjeGCHBmFUbyvbXOsuZlcFZqrGbJVanJjziq2cZDNp63DF0s4w+DtppckGVwkinfa
	CevLZ2uZ3miGprnJYkKrDqzLXByc5duR5sHlD
X-Google-Smtp-Source: AGHT+IFBpvjE4yMg3St/HtMID6QvqmvEXwo9FLmrzkYUVeCtjRTYuoaapR347+2PD0Z4NqzCN1IA0/vQ/MwLiRgjfQY=
X-Received: by 2002:a05:6402:3491:b0:5c3:c2fc:8de6 with SMTP id
 4fb4d7f45d1cf-5c3e993a257mr23991a12.3.1725651450003; Fri, 06 Sep 2024
 12:37:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZrPpxE7OZtqsbD81@tapette.crustytoothpaste.net>
 <20240904173053.1220621-1-calvinwan@google.com> <ZtidjMThNwiI_QG8@tapette.crustytoothpaste.net>
In-Reply-To: <ZtidjMThNwiI_QG8@tapette.crustytoothpaste.net>
From: Calvin Wan <calvinwan@google.com>
Date: Fri, 6 Sep 2024 12:37:18 -0700
Message-ID: <CAFySSZB56V-h0zxcv+TtP0jmTYAV1gixanCf0toYqak7Mz-yGQ@mail.gmail.com>
Subject: Re: [RFC PATCH 6/6] contrib/cgit-rs: add a subset of configset wrappers
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Calvin Wan <calvinwan@google.com>, 
	Josh Steadmon <steadmon@google.com>, git@vger.kernel.org, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 4, 2024 at 10:49=E2=80=AFAM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2024-09-04 at 17:30:53, Calvin Wan wrote:
> > After getting rid of the `home` crate, the only other issue we ran into
> > downgrading the version to 1.63 was with `std::ffi{c_char, c_int}`.
> > Those were only made available in 1.64 and they are obviously quite
> > necessary for us to be able to call C functions. Do you know of any
> > alternatives we can use? I also don't think reinventing the wheel with
> > our own implementation makes sense in this case, and even if Debian wer=
e
> > to upgrade stable to a higher version today, we would still need to
> > support oldstable for another year.
>
> I think we can do this with libc, which you're importing at the moment.
> You can do something like this:
>
> src/types.rs:
> ----
> pub use libc::{c_char, c_int};
> ----
>
> and then do `use crate::types::{c_char, c_int}` wherever you want them.

While this gets rid of `std::ffi{c_char, c_int}` dependency,
`std::ffi{CStr, CString}` are also 1.64 unfortunately, and I don't see
the equivalent of it in libc. I'll reroll v3 without this change for
now. Hopefully Debian stable just upgrades to 1.64 or higher and we
don't have to worry about these ffi conversions :)
