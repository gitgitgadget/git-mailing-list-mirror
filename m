Received: from mail-vs1-f54.google.com (mail-vs1-f54.google.com [209.85.217.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35AC2227E95
	for <git@vger.kernel.org>; Sun, 11 Jan 2026 11:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768129452; cv=none; b=auZ1JBjkNNn1wSAJX2Ldqf1Z1QVM+WcI3RBWzumpZktqUTcd8JJN8mTnbNBd5UWpXGweV+2IqbCc24yBTEipkfnhLihGLLsZwaxTsSH0EVDhrFN3XZxfPGPFgfs5/E3yzFebofkYBemUpciLxAQ7/kHAfHuCuGURC6tvm9eZ08A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768129452; c=relaxed/simple;
	bh=0Ocdzmq30WMrSLdc0KWqX9Zny3JeW8EF0Hf+A4AUjTQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=atC/1uCBjo0EPUEmKi6zctaiMV2wk+lNbc4oD7/Nn1SkoPfvRXi/hDljNfWuKQTPjaELB6skZzLJLzgPqA8mK2lk9gv5JZMUb4OQ2kf6grag6LjqdyTwNsz2ouVZcl7oZGQ0Pm/46rAMRkiasxcV7audtsdG69dFU1Eehfv5sZ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DXEe07wS; arc=none smtp.client-ip=209.85.217.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DXEe07wS"
Received: by mail-vs1-f54.google.com with SMTP id ada2fe7eead31-5ec87b1f525so2069955137.0
        for <git@vger.kernel.org>; Sun, 11 Jan 2026 03:04:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768129450; x=1768734250; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4Q19Ii4GAZRepGlYAjbTBrmlysMk5C0LvVUz2JHWIDk=;
        b=DXEe07wSYzSzgzDxepLEkVgwHIDCwHTX9Q7gKkkWT4gZeDQXJ0PWgBaXqstLU/d/AG
         AEkpO3xZF2NApUgcLFQa2cS358KLV/hzRtWE/D1bFcYjpR77+lfzwBljh1GBaZZozFpw
         mjIErnVPYWzVJ8Afx2KJ1vFpSwlIVLpjiPoBjP6tlngu0TKRnRINUNJG5hoWfpZRW0mI
         SDv/mkz4zHd57zKquj+YyY5DZjgjf17YhpBQZvr8bCtcFp3GowM/n1SKZw+bo/wXtYTZ
         zH3l75p0feCi3YYyje0cIbRYQfe/etyBW1bp7+zK365YAdJCuTFOVIfWPtI0sHd/rXQH
         v+Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768129450; x=1768734250;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=4Q19Ii4GAZRepGlYAjbTBrmlysMk5C0LvVUz2JHWIDk=;
        b=BmnqVAnTIofuCqn2TNIJ/dbePihissxla4AMZeweK2g/Z7LRR04Y8IXyueygtO6Ltj
         4UxCfqqnzvo2842B5c3lME8pbJyd6kMQtEGvKLtDzGwxbWKMHW1Kg7k/Vc0TC4VuP62b
         Ru0gM1JIkkgXB2Go3TYHKrjPjgFQkuE3HTAZBOdytFnVHymbEP1X4822k4qbL5FROhKz
         GL+7V2/eTpffuinJaYqhekcbJGsT9yACrq9a2bikBqaElwFOdpWWFHZ79NYNhW1ZF+21
         tsjL+qkUFrEg7xyWEmhxC2zmnrx1zNTWF2oPyVtNZQ+NzgBYcx8kr8GHRldPftAL20pA
         hUxQ==
X-Gm-Message-State: AOJu0YwTV6ArK17goO74axkZBG5PSxRdhTefkoZiWtj4NQrwxfDLcEf5
	/YIahIA/rBZRKzVx1fLsB/+q7ligz4FEvPwdvXvG4zb2r0OnAkA+IcklgpPyzhToj/VVsfq3cgJ
	jkGrhSm7HkcXA1em1c1HjpRiYSj/snDM=
X-Gm-Gg: AY/fxX7SBKyJK+dCNpaUBBkiYxHBIgFKq1aNHTZGFGKZFV8iKpzYLAc6awwabGHVKkg
	eBV6m0WQgQk11rtpPF4M6bKgW9LgTl4FjSqtMcViSFLBW938MAyfhSykF1s1Tj8GmeVkZWQkLSf
	UDDoCNrap4SewqgSX4KPdon0H7qpgvx/TYt6NAJeF1tM5lShNaVeM5+Ebc9DakOd4096Q/wUcCV
	Nd6LfswfK3LpB17QSHMQS0l8qIw9BjSN4VF8V+eoa/+uQea5XQu6/hzlz+4Foj3kW+gcIcCoNYX
X-Google-Smtp-Source: AGHT+IHWoGfHLsuU4LQ4SK7xtLULaOmwNLkpe6insPDVjLIixj8yd/QNRP+VgkHSEYBOdkU7bvjbnD5rHZtSIlzbeVE=
X-Received: by 2002:a05:6102:3e82:b0:534:cfe0:f861 with SMTP id
 ada2fe7eead31-5ecb687b49amr6983256137.18.1768129450191; Sun, 11 Jan 2026
 03:04:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <aV_IGCld5T_dBxTs@Adekunles-MacBook-Air.local> <xmqqpl7grebf.fsf@gitster.g>
In-Reply-To: <xmqqpl7grebf.fsf@gitster.g>
From: Samuel Abraham <abrahamadekunle50@gmail.com>
Date: Sun, 11 Jan 2026 12:04:12 +0100
X-Gm-Features: AZwV_Qju9i187t_0barRWSQLuVlM9xRYXylvIJGMVayT9UMtGUGY28BSRV8b0ek
Message-ID: <CADYq+faxjsY4cpz9JpyV4G2ufxjdkoHBrmkAhs6uFrp79_Fc3A@mail.gmail.com>
Subject: Re: [GSoC PATCH v7] add -p: show user's hunk decision when selecting hunks
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, 
	Phillip Wood <phillip.wood123@gmail.com>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Ben Knoble <ben.knoble@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Jan 11, 2026 at 4:57=E2=80=AFAM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:
>
> > When a user is interactively deciding which hunks to use or skip for
> > staging, unstaging, stashing etc, there is no way to know the
> > decision previously chosen for a hunk when navigating through the
> > previous and next hunks using K/J respectively.
> >
> > Improve the UI to explicitly show if a user has previously decided to
> > use a hunk (by pressing 'y') or skip the hunk (by pressing 'n').
> > This will improve clarity when and aid the navigation process for the
> > user.
> >
> > Reported-by: Junio C Hamano <gitster@pobox.com>
> > Signed-off-by: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
> > ---
> > Changes in v7:
> > =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
> > - changed hunk selection state message to reduce prompt width
> > - Removed redundant `file_diff->hunk_nr` in hunk->use check
> > - Made the prompt mode more readable by retaining the space before choi=
ces
> > - set `hunk_use_decision` to empty string if `hunk->use =3D=3D UNDECIDE=
D` to match
> >   the prompt mode.
>
> The latest "was: X" does look short and sweet.
>
> Let's wait for a few days to see if others have more input and then
> mark the topic for 'next'.
>
> Thanks.

This sounds good.
Thanks

Abraham.
