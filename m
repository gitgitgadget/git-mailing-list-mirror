Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 59EB11ACEDA
	for <git@vger.kernel.org>; Wed, 27 Aug 2025 21:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756330319; cv=none; b=dvk7Sr5NT6BLGKNHpMWHIdBXFJEd/KRYDN8o96XwxxNfa/kdJ5+LU7mM9f7mNMs84X2F3w0822reF5VXFbRKQ36AtYDDbCQrScxW3xNzXtdVNhIdKx4Gu2CM4PEmFoSGRtY5HyoYrSO0zrklGaZBfRhdEkqP+VL8xPc/8Cp6/UU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756330319; c=relaxed/simple;
	bh=6f9hpwsomQIq54Ck/bupaCDZ1Hym2Cn/z6HIFwalzfU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=nz+/4Byl/uW+N4leFpmCCybe9SPeweR0qNxN46PVqkOEwZJ+Ak4YEtuRfakWNL9FG28/KSY6CNHndAiVunswPWCnqAg694glidkrqg2edkYXDsA1tFqW0bVqBtljp1eSQ0oND12rpX3R9pef8oa5my3DA5IX2mhyY/RcxNnk9Dc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fQR0TvRn; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fQR0TvRn"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-76e2ea933b7so295577b3a.1
        for <git@vger.kernel.org>; Wed, 27 Aug 2025 14:31:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1756330318; x=1756935118; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dRNVQIWgYrCQWukTeA1rnDZU+Qc6xBSPlPDgPHdfzp4=;
        b=fQR0TvRnvnbjcQkXmGFYKQh+B9m+omo4NelqChUsAOwB98LVyAx6GRnvgylFgd8Hlj
         bqYcnEYicaMnGV+kh9Eh7kKP3bJ+QLxNLULATWPNtE7bR9+Ldbymha5etEmU1C52Pvek
         ViB8pbGM8YC01C6wrzHW6FiiHJLjR1n07NDp/UfV3+j/CRL5UMFvhhiB7ZmmgKfpyDmM
         CHcyNBr/IQZi68d0ovVNnn74acPwPeXN6sJGbJSQjZTA+9floa47nTkKsuePg6QtlC7s
         EY7GQNCbIrOY+K7JZinGBGrstlmL9wXctcXeqJ8l0e1eKdDkDGw0JboU2jv4Wb9NjXCv
         GQbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756330318; x=1756935118;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dRNVQIWgYrCQWukTeA1rnDZU+Qc6xBSPlPDgPHdfzp4=;
        b=SsxWcnz5SqSHhCEv2LE24W8S46Ut73wStFN/7VOgdtwRcqbRs93+1sT3ZTJNG8oYcT
         O+g+yBzCMD+7/3YIgkAqP9A3hEKl9/3/jj74cg8QxRA8Zq61UXDzR9kTX8387W+TGJgc
         Rn8Vmui5XamABZchMxfbf21X8KSx76Yg5zNptTQ1suMMnJWIONfQzbWkrO2Mf2hbiAJm
         nOS17xCNkLcTbc051C58V0awlSPs6hD9OtFQSPXcolozjM9TRy8bgcHUq8pBMawNY+Ym
         +z8vdYiDR+aUTnNXK6707G11JVT+EFTLSc6l8jA/jCTs5eVxbuEv0MUeppLnv5H2p7PA
         +62A==
X-Forwarded-Encrypted: i=1; AJvYcCVxvscAXfKvNkk8U0N5G7+BlWetX3DBd6SUewSm2SODMR2whh7HBdd8Cb3Uxwzr+WIgL3E=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw3NTHVxYkRhX4t99LOz9NM6Yj/+ikCMBX3P3x5HWZrpM4oxhEZ
	J+GhTE4kxwjysIkQwz4iWTz5/C0s/4oKonUndfuZqL9yUl6USo0MZdxlqwpvDr0Nz7tAlQ/aPTY
	1ZZnENSH0HhSMjtESJ6e4Oo4SV4uvIn45btX5BYM=
X-Gm-Gg: ASbGncseAAcpuVtBStsG3wThNx09SDdN/+9VixkVCK3Ub7aGG6Y7P1ivP5vYiLR7+gh
	4BbY2eX3FKhbwySNWRTrxGMgpS7C8Yt9fLSSnrc444vV7b7mfNiZhwI1g3WVzBYcFUAdQiVxbzl
	FRWTfFYzV2/f0fHeogIOnlZwJiZa4TVyHmk0TdxXi6rot40uhzKLSKPkI2tIT1fOtjcNU23Xjny
	J9vujFTlKNXt2otabc=
X-Google-Smtp-Source: AGHT+IHuAuV/ZP5rUIn42linZx3i3e9be2mGNDntW64ecxIvsSU9BwPjyAtGS++hEkRk9a2B9z+Fcv8V7lmMaCKsqyc=
X-Received: by 2002:a05:6a20:bb08:b0:243:9587:a774 with SMTP id
 adf61e73a8af0-2439587aa2fmr6368596637.28.1756330317464; Wed, 27 Aug 2025
 14:31:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250603131806.14915-1-ayu.chandekar@gmail.com>
 <cover.1752882401.git.ayu.chandekar@gmail.com> <CAE7as+b2QKcPVnyEupriK54bMSSxdRAmSrMZqTvfq_KabaU-Ug@mail.gmail.com>
 <47d09c43-6d27-40ff-8dbc-22cc4a5949ed@gmail.com>
In-Reply-To: <47d09c43-6d27-40ff-8dbc-22cc4a5949ed@gmail.com>
From: Ayush Chandekar <ayu.chandekar@gmail.com>
Date: Thu, 28 Aug 2025 03:01:45 +0530
X-Gm-Features: Ac12FXytz0C6fHr625XCwmNaCrK4QgfrjHJlvAEQ88VTuCdYPBnmqH1xti7Os_0
Message-ID: <CAE7as+ZpEwiNsDAozoZXqHRLOF3+hT++uo=mzZqEvTPovQN9uw@mail.gmail.com>
Subject: Re: [GSOC PATCH v6 0/3] environment: remove sparse-checkout related
 global variables
To: Derrick Stolee <stolee@gmail.com>
Cc: christian.couder@gmail.com, git@vger.kernel.org, shyamthakkar001@gmail.com, 
	phillip.wood123@gmail.com, ps@pks.im, gitster@pobox.com, ben.knoble@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Aug 26, 2025 at 5:50=E2=80=AFPM Derrick Stolee <stolee@gmail.com> w=
rote:
>
> On 8/10/25 11:36 AM, Ayush Chandekar wrote:
> > Just an update, I'm still working on this patch series.
>
> Hi Ayush. Do you have an update on your progress? Perhaps there
> is something you're stuck on and could use some help?
>

Hi Derrick, thanks for checking in!
I have made a few branches by trying out different ways: [1],[2] & [3]
I am quite close to sending the patch series now.

> A few weeks ago, I played around with the ideas around updating
> the location of these globals into the repository struct and
> made this critical observation:
>
>    It's "easy" to move the global into the_repository, but it
>    becomes harder (and changes behavior) if we start referring
>    to the data in each repository struct.
>
> It may be good to separate the two things into different steps:
>
>   1. Move the globals into the repository struct, but only set
>      or read from the_repository->sparse_checkout[_cone].
>
>   2. Replace the use of the_repository and instead refer to a
>      specific repo. This may change behavior of the feature in
>      the presence of submodules with different config than the
>      root repo (tests before and after will be necessary).
>      We'll also need to update the_repository during the very
>      early config parsing but then update other repos during
>      repo initialization.
>
> Does this make sense based on your progress in this space?
>

Yes, I was able to do the first step, the second step means that I
have to pass the repo struct to quite a few functions.

> Thanks,
> -Stolee
>

Thanks!
Ayush:)

[1]: https://github.com/ayu-ch/git/commits/sparse-checkout-6 (Stored
the variables in the 'struct repository' as int, and made a function
to read their values from the config)

[2]: https://github.com/ayu-ch/git/commits/sparse-checkout-7
(Christian suggested me that I can also store them as booleans so I
tried it.)

[3]: https://github.com/ayu-ch/git/commits/sparse-checkout-8 (Similar
to [1] but set their value as -1 when uninitialized. Tests seem to
fail though when I make this change.)
