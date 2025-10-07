Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EACE1662E7
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 18:03:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759860217; cv=none; b=ZgmPJ0lv1uDmIZvcKi7kVy7BHECK7MjWbEypFvp6qC0nlKW9TWfXCS/t3MIADG2yKawNUhXoa14rVtrJ4Rl+OEVmRyWPZNroXGDR8orlsArmZ22kvM7K6V6K5kkC1ge2MDOanDIjV4T1t6nrA++OLxFLhXBMm4PxET0tdug8hYQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759860217; c=relaxed/simple;
	bh=l4EOzJJA2MLZysUGYrMJtYx7wiT3ufbvZN36nstTLkQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=FKvWDcg1JA2nxjzkXexgzRV0vIddgf/Rx4f+T3D2AnPbhDW8gd0LbrV2a3WikAQ+NwUNrQlQc1jsqOEy29s38o7OvhK5/AN3At2M5mRmO8QJPwGtfDjW691aX3iB6rZ5VL5HHT0VYa+9EQw53N1LpQzcGMV9l2b9QPpfYIiy+VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YU34drd3; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YU34drd3"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-5521a6c6af1so525520137.2
        for <git@vger.kernel.org>; Tue, 07 Oct 2025 11:03:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759860214; x=1760465014; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Nz5k0NTZ4axG2nIBAIsXyeNI6i0WY4Kbqy7AaFmAB0I=;
        b=YU34drd3IoiUSauDGY/8OZYtsmH3dmvJtb33yR4bVGR5MOk+OSDN4l6J5NAghEuTYn
         30HlL0sMqyDpIvCLTiJqngZAlbRdiny9m/rbzZilPXN3XPERpg2xNEtTUG57IepH1owW
         AYD8EvJ121XIax+7FvVRd2TBAKJWinWjq4uXYVAp7MYOZs7vPe9T0vVr7Lowdo4NY4Jm
         V1M9wkrRg+6fohCSj+I9YXXTDitVqvyJgxbTr35pvVB2iLHmDGBiRr+wwX/hrapNoO3G
         nv1CzyQEMYoNbxVTcMnSxkzeGwLLtZVc75fugi9O6OTHHLbRiQ38lT4O6efCcLPQZEpp
         F6Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759860214; x=1760465014;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Nz5k0NTZ4axG2nIBAIsXyeNI6i0WY4Kbqy7AaFmAB0I=;
        b=gsQewLrNHQ4nVPwawmN6OVeYmjstsnzx9RlNpQj4dPMtZ1471/Low1lLosHZuOu4jD
         tUYvRIhYJrQJ4SKzRg4ODBPT76LZYx+B4FaUgCS4E6N66vfeuw4Is8PvxThbHYssjNvr
         L7xJ+wriYvGRg0Uek3DifZjmiX04BhhnQOHP4A1TqF0/oL3PbIKQMgqlR3kFMJtU6FA/
         UNijML8jLiqzEHAoW2v4AqtDzrRFHsEt6izCUhOFgo2g8AWikbInd4LxJ79tIhrgv5AD
         Sn2CdNzbqx7XWQvE0YELp/KIdZRycIli9dufD8m0BcczRYOe15k/k1xn7NcivICGcjkJ
         8rcQ==
X-Forwarded-Encrypted: i=1; AJvYcCVELrazv1BVH2QyIGKQv0Q4YC+MP3VHGG2eCKJipCPqHs8NaQO3wLgly4rri9Mmu0PhWh8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwOXmuMHu1W2qhLyQWr7Yijyn9KKx8Y4EgE+P6Lei+npPaXiJNa
	O/7h0ShfveXdgDuWJQPl/5TAY7bTPjtON151hT66olpUvcu10wOpbCof/T3RZqtbeh+evsTU/aV
	sXMCCGppx5K/3ccVJQ08t2Sximo7HKOk=
X-Gm-Gg: ASbGncvYzv+EO5g+adEbzR583QoKMPkfI6DaUCGCeDTorjRjMv5wH+lYh5Ey7hg0q9O
	kXnu7PRkP8aIgjMhgrJ3MUTbjgrJjZ0XFioXkZakhO2rZoia1psLrIOzKqC/Hl2QJJciYzh0HPy
	r2BzUD6W2VbYzUWTscW3RfJOYuiSYofMn2285+7paFH8VKSJNF1kCDkr9umyBf1/yolSrCO4KoF
	xJafMrWntDNLCDX3fGSKtycSg4S4ysHuLOrW6NyvXz7fqEz46uGlmY5q7zVgfq/hAT3OtlPPt4=
X-Google-Smtp-Source: AGHT+IFmV+BiepC3D4vVL1yTMdnHb9r4s/0W2lLgfdvmqwe8QmWgmAzfEXjEH3E4M770QKTbH7mcsIq3ZK0j6TbqdNE=
X-Received: by 2002:a05:6102:3a0c:b0:4e9:c913:2c9e with SMTP id
 ada2fe7eead31-5d5e22152edmr74932137.1.1759860214052; Tue, 07 Oct 2025
 11:03:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251007-b4-pks-ci-rust-v1-0-394502abe7ea@pks.im>
 <20251007-b4-pks-ci-rust-v1-2-394502abe7ea@pks.im> <CAPig+cQ7xJky+F=g=NMrN6BQfP+ZV2KF4RF2eLqtULKgMTR5_g@mail.gmail.com>
 <xmqqbjmik3y9.fsf@gitster.g>
In-Reply-To: <xmqqbjmik3y9.fsf@gitster.g>
From: Eric Sunshine <ericsunshine@gmail.com>
Date: Tue, 7 Oct 2025 14:03:21 -0400
X-Gm-Features: AS18NWB6hDU4yYiWeCBUUabaQayv2Ylq52cxAKVcLhxoxpKFGcM4nQzrz3Jd5sU
Message-ID: <CAPig+cRvugLP63CYUXw7pf-7obErQYenrVvNeSYhegQ57PQ8KA@mail.gmail.com>
Subject: Re: [PATCH 2/6] ci: check formatting of our Rust code
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	Ezekiel Newren <ezekielnewren@gmail.com>, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Oct 7, 2025 at 1:38=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> Eric Sunshine <ericsunshine@gmail.com> writes:
> > Later in the same thread, I wrote[2]:
> >
> >     Project guidelines have long suggested 80 columns as a desirable
> >     maximum not only for C code, but for pretty much all other
> >     resources, including shell code, Perl code, and documentation
> >     files. This suggested maximum works well for adherents of
> >     80-columns and (presumably) hasn't been too onerous for developers
> >     who use wider windows; at least we haven't heard people clamoring
> >     to increase the suggested maximum column limit. As such, it does
> >     not seem far-fetched to expect that the project guidelines
> >     should/could/would also apply to Rust code.
>
> I do not see a particular reason to lift the 80-column limit for a
> specific language, whether it is Rust or AsciiDoc. [...]
>
> Will it inconvenience wider Rust ecosystem when we get big (meaning,
> they have to work with our code) and we as the project norm use
> different line-length setting from others, perhaps by looking too
> different from everybody else, or something?

As a general answer, I would assume that third-party projects wanting
to use Rust code from the Git project would do so by importing one or
more "crates" that the Git project publishes rather than importing raw
code directly from the Git project. In this case they never deal
directly with Git's Rust code itself, but instead interact via the Git
crate's public API.

If a third-party project does want/need to import some raw Git Rust
code directly but has no plans to actually edit the code, then there
should be no problem. If the project does plan to edit the imported
code and periodically update it from upstream Git, then it's a bit
more onerous, though perhaps not so much so; running the Git upstream
code through `rustfmt` before import into the project is one simple
step which can easily be automated.
