Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com [209.85.128.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A0181DB15B
	for <git@vger.kernel.org>; Sat, 15 Mar 2025 08:21:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742026871; cv=none; b=Tmi/yFFbTf9V0b0wm1O6z74IkDN442WEwBVYRF/eupqE2bvNC0uSdJ9+0yPt9RPK6qa6IcTMV9iInl7V3SgQwUEneLKbX1ZHZ2nY35+12k1agQifzG6S/hP636jZlnAVcAVbSiycLH6Vv4JqttQWPQAjKq94xrSlqjvNAfUxY3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742026871; c=relaxed/simple;
	bh=w0UECCxG2HVReaCVefsomVboygeCnL2RvXUQK5nOBg4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=awvXMeYrK3jjzLcm/8NNkhYXYx0vxXAGMFUACpxY4B3V1EbJpOh8PSwHDeD6Q8pwV4vWAZs/JIMRrgZl6D2pU2P/EK7wNmfVm63NGfTppR76j7yoip3OZO5eoNwR4MklDMjw0k8k1gcaAfDGY1mDLmO2bnxJEjPYonExLBBwqOQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iBX2vbMb; arc=none smtp.client-ip=209.85.128.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iBX2vbMb"
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-6feaa0319d8so22756837b3.2
        for <git@vger.kernel.org>; Sat, 15 Mar 2025 01:21:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742026869; x=1742631669; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8w2V/ZdbyfQ07R/hI/vW4acT3Ovf31xnpuaOqnDroEE=;
        b=iBX2vbMbLo0L/aZ9z5OVHJEgsPRCgkF4CYdJg9y0gYuceAUMLB22fl/AgGQ2Qs5XA8
         9Ds857nSSweZL7TTfSf3b+Z4OQYjRQzE0x2vpBk7JavXQ9GyBd/6yUoRasA22XjsFQJ3
         4A1NZbM0qWz9QNunV1SLe9+915lG5LGobCgQ98tBcsBhAlQg+Si6lE6x5HreoFRj8T5p
         61U/rqEvsUXMss3zAjAKN/EQNcDVWUEBbHu+eVrYZ6yKWCtAmEGEa9/tXZl2gLrqe7MF
         zrzfyKn9GdG5B3m4MbWuLjMINk5rbwnv/Eqtm1zfLKGK/OFp/ZFhuZimJiCTjpgsOAgU
         /JXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742026869; x=1742631669;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8w2V/ZdbyfQ07R/hI/vW4acT3Ovf31xnpuaOqnDroEE=;
        b=Z+WLxPoDv1a35TxE5UFQ+UiPIWEmsdv1Dz0ZXaSq4NBlqhPSF30Io6MDC3uqAsWu04
         2LR1ZvoSbsxRzNJYAzf2bcSGq0gLppAH8W2xzgO97DYo6QwmSgWGNzI/1BcvkuT4hKL8
         TEskD1WygGaJ/O8zLizkPQobXzgnTZ9f/UBRfMidk5DFXLr9bmjKQkkEbZpGVZjCT4+s
         txzyEo52Y2Xo1l5ReRLlOxhGBktCB1l3tMKS2CvC2juTGnB4Uttq+7kGRu94VpG6nWvX
         +gusnD38FX2eGxWIre9SQGU8/j8vS8AAwlZH3QFCzKBWA+phuNjldSdMzA22sGBg62vM
         4Hbw==
X-Gm-Message-State: AOJu0Yydqfh3qhcJYKROjd92OxrozU7tVK8sfVFnLGsz0+rdcLhNWHQW
	GgZGvtVOly1zWTVFF6B57DPkrKgxDWP7Wdek+Efnd2BnxYEeV0dIGilNS/fvuWyGMaastluag2D
	m8Homk3hPSNsNUgVv1O+QoN98GG4=
X-Gm-Gg: ASbGncsAHhnkUJ9Wf42fyO8AQ82HluKQWAwRUdrEBelNUBl2QUFW30c/ueevxs38ihf
	ge8PNUwHX8E+Q/kdNX/41ac7Kpm9l/rA+2ZM70hswrG6NBS3MkcUoALjZfhyWbe5sTqYJde0mqD
	9uHnEh/3RLh/CVhyBrmuhDzs1PEL4NAb1gYCxrQFJ/5WneNene/NVIe3gIYOQ=
X-Google-Smtp-Source: AGHT+IFlq4BbrOlj7e1Pckdixh3FPrQlLqgmeWoNYomLMnUPwsRJsaAALxy7koVVyDnJMVfiF1hKNEVEkTLBvIoRsyI=
X-Received: by 2002:a05:690c:700d:b0:6f9:af1f:53a4 with SMTP id
 00721157ae682-6ff460fa017mr66739867b3.32.1742026869419; Sat, 15 Mar 2025
 01:21:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CANrWfmRq=7Q=vCPgmcLcek=fRsw83BPqTX7gTpcLb=JpQpYZEw@mail.gmail.com>
 <CABPp-BHPAEcJibTaiMVE1K7AvYE+TYmOt7=6XUtcZbm7wsWhDQ@mail.gmail.com>
In-Reply-To: <CABPp-BHPAEcJibTaiMVE1K7AvYE+TYmOt7=6XUtcZbm7wsWhDQ@mail.gmail.com>
From: Han Jiang <jhcarl0814@gmail.com>
Date: Sat, 15 Mar 2025 21:20:58 +1300
X-Gm-Features: AQ5f1JoVaWCAW21eFR2jAbPSgYk8aZcM15NQeaVYeEj4exCpoh3wJC2qZSSHrYw
Message-ID: <CANrWfmRpDFuqv+fkCf_p_ggHTrRjD3Vgviqrai_rA7Lu-YFEMA@mail.gmail.com>
Subject: Re: `--ancestry-path` documentation has wrong graph
To: Elijah Newren <newren@gmail.com>
Cc: Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 15, 2025 at 6:16=E2=80=AFAM Elijah Newren <newren@gmail.com> wr=
ote:
>
> On Thu, Mar 13, 2025 at 2:04=E2=80=AFPM Han Jiang <jhcarl0814@gmail.com> =
wrote:
> >
> > Git - git-log Documentation --ancestry-path[=3D<commit>]
> > https://git-scm.com/docs/git-log#Documentation/git-log.txt---ancestry-p=
athltcommitgt-1
> >
> > The graph for `--ancestry-path=3DH D..M` should contain commit C.
>
> Indeed; D..H contains C, and C is an ancestor of H.  I apparently
> overlooked C in that example when writing that documentation.  Would
> you like to submit a patch, or would you like me to do so and record
> you as the reporter?  I'm fine with either, but if you want to give it
> a try, the relevant file is Documentation/rev-list-options.adoc in the
> repository.

Thank you for the clarification! I'd like to try sending a patch.
After doing some research on how to make contributions today, I
decided to try GitGitGadget way first. But I got some questions that
the doc doesn't clearly explain:

[Git - CodingGuidelines
Documentation](https://git-scm.com/docs/CodingGuidelines) says:
For C programs: We use tabs to indent, and interpret tabs as taking up
to 8 spaces.
1. It seems adoc files treats tabs as 8 spaces too, is that true?
(The prepared commit in forked repository is at
https://github.com/jhcarl0814/git/commit/ce568e4a87dff14df4e7104af89be3f126=
16f5de
. The source diff shows tabs as 4 spaces. The rich diff shows tabs as
8 spaces. When I was editting the number defaults to 8 and is
adjustable in editor options.)

[Git - MyFirstContribution
Documentation](https://git-scm.com/docs/MyFirstContribution) says:
For single-patch contributions, your commit message should already be
meaningful and explain at a high level the purpose (what is happening
and why) of your patch, so you usually do not need any additional
context. In that case, remove the PR description that GitHub
automatically generates from your commit message (your PR description
should be empty).
2. For single-patch contributions, is the pull request title or the
first line of commit message that will become Subject of the email?

[Git - SubmittingPatches
Documentation](https://git-scm.com/docs/SubmittingPatches) says:
It is a common convention to prefix your subject line with [PATCH].
3. Which one of GitGitGadget or the pull request creator is the one
who add "[PATCH]" at the beginning of the title?

[Git - MyFirstContribution
Documentation](https://git-scm.com/docs/MyFirstContribution) says:
Now that your CI is passing and someone has granted you permission to
use GitGitGadget with the `/allow` command, sending out for review is
as simple as commenting on your PR with `/submit`.
4. Who is able to use `/submit` to trigger email sending action? Is it
the pull request creator (when `/allow`ed) or anyone (`/allow`ed)?
5. If `/submit` sends email, then how to cc all relevant people
(including myself) at the moment of `/submit`? Is there a place to
fill in this parameter?
6. Where does `/submit` send the email to, as a brand new post or as a
reply under this post? How to configure?

----

7. How to make Gmail web client default to bottom-posting?
