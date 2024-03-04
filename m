Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C89BD19477
	for <git@vger.kernel.org>; Mon,  4 Mar 2024 08:37:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709541449; cv=none; b=ojGP+oq3svMOi4fuJdeNI+e9oBVYKNRUH9B773iAyS+1/PZpx+AU2+B/s0oYzKloyMF5BTQgEN7UgW+Bt1W6Bbxr9DPRD1xSdvFgZ5z/JhHNCObCQs+dT41xmDK8woR+/zhGZnJluBCm7oJVUxfWJoYUXoLnF1nBIlgpmSbw9e4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709541449; c=relaxed/simple;
	bh=pnaql7JxkoD1EoOk6jWs6oIBw8Nlx85smmMFSA34c0I=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ujtauM4cFmLctOuDL/9q7zsn6iTTxypT82ykxtEYi1wyxOgc59YV7nAyxCji94PACBFRlsf0t2a80gEqL2iPHc3zaRWBYNotTjmI1CSjY50plizSJ0CwgCxbXKnaFHx2KnZE2o/CGnCZH2rZDKiO9x6DLg0Gg92Y3mDSBflx04o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a4Qfyqo4; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a4Qfyqo4"
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a4515f8e13cso106859466b.3
        for <git@vger.kernel.org>; Mon, 04 Mar 2024 00:37:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709541446; x=1710146246; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1ouNXlAqBTKgPK6LhZYiCMbY1tYXHzBkoT/cTZ0MyJA=;
        b=a4Qfyqo42eEtR7JN3VWpcJlCu308o7TzHZbhE/FZNlJlrTdHI+bsdZZL5qZAc4tyth
         WFtAaCrZx/03w+vqixyjpbYuPZdG3PhWOuTdRBtXb2sdgJHOXKfGF6/blcV8oNlnpxuM
         ZoC2wHbI4+zQ7OMParfCfRSFm1SmlM3WI7Q1Xy9GraSr/s/PYWBMFg7cK4Owz6IB0ITH
         EIXGFvtvts11sGnYUlnYlNaex8VwdAvDpNOU2urro17ftrh2OORPjHfqrU+hDVEcggsP
         ++RhqD7p1ohUhqHOokCKBZ16hgN+uMPBjMjpAwYQJOleAvt1kOLUyAJx/ocNJkUaNxLE
         h6hQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709541446; x=1710146246;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1ouNXlAqBTKgPK6LhZYiCMbY1tYXHzBkoT/cTZ0MyJA=;
        b=nvyQt/6+z2jE31OPN7XaP7EOFI/2nGen255fOZD+13DpPeS0hE0u8FxVgEOPnyEzOT
         ksaj5+y+E5Z/oCo/GJH9StfzGEHvB7e9D2HzQjYGPt+9RGtf8mTbxuKIK/RfU50+aZv5
         VnA4yt8M81K+n4630itPfWZZNCXDJgVxUqexV7hdJoEn98/+rPA1/Ecl/cR7/g+vUqXu
         ugZB7x8dFGQ2T064XZcIu2fTOguhIyLg71WZztyGPoZ73+NRTVervU6db68vkFXEi5mP
         O2sLfXSuMouqfQFJn4zghivdP2Jq68QUWBdDypYiEN5BBEpuydBUopJNZh0rluNgpIhe
         L0NA==
X-Gm-Message-State: AOJu0YyHqw932sK/JsFONUwBnpQzRYy9DvjcV8jyLcOTArOoRXL0Naek
	dqE/ugh6FHLDHvYM+BMXue9uMk6Hjpr8tgm2UVvoAJf8JZthbLNiCTHBtl2fUoHJ1IA//ezSnsc
	3TJ0PcOjtXPnMWuXbVUwF/DhMwo6LYtzD/0I=
X-Google-Smtp-Source: AGHT+IEfNUNAsOPaepftkICh6IwVFal8/WB2QUSwl7EhQIoDCRbzNjcPYtSskQfC6Iw2MehInr/FQUW2jaoGF+Bo1gc=
X-Received: by 2002:a17:906:f8d6:b0:a45:2e21:c78c with SMTP id
 lh22-20020a170906f8d600b00a452e21c78cmr1876691ejb.13.1709541445882; Mon, 04
 Mar 2024 00:37:25 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAHCXyj3agZKxgseGwS-1WD3NR1nD7ni80Q5UEhf2EVpMiaSV4A@mail.gmail.com>
In-Reply-To: <CAHCXyj3agZKxgseGwS-1WD3NR1nD7ni80Q5UEhf2EVpMiaSV4A@mail.gmail.com>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 4 Mar 2024 09:37:13 +0100
Message-ID: <CAP8UFD17MC-BS+wQZpOePEcngxvWaTSckppF+f24y6rZAn0nEw@mail.gmail.com>
Subject: Re: GSoC 2024
To: Aishwarya Narayanan <aishnana.03@gmail.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Mar 4, 2024 at 7:02=E2=80=AFAM Aishwarya Narayanan
<aishnana.03@gmail.com> wrote:
>
> Dear Git Organization,
>
> I am writing to express my strong interest in participating in Google
> Summer of Code (GSoC) 2024 with the Git Organization. As a highly
> motivated Final-year Electrical and Electronics Engineer, I am eager
> to contribute to the open-source community and learn from experienced
> developers like yourselves.

Thanks for your interest in contributing to Git!

> While this is my first foray into open-source development and GSoC, I
> am excited by the prospect of contributing to the ongoing success of
> Git. I have been actively learning and gaining a strong foundation in
> Git commands, programming languages, and version control concepts. I
> am particularly interested in the following project ideas:
> 1) Implement consistency checks for refs
> 2) Move existing tests to a unit testing framework
>
> However, I understand the importance of starting with smaller
> contributions before taking on a larger project like GSoC. I am eager
> to begin by contributing to micro-projects and familiarizing myself
> with the Git codebase and development workflow.
>
> In this regard, I would greatly appreciate any guidance you can offer
> on where to find existing micro-projects and how to get involved in
> the Git community. Additionally, I would be grateful for any resources
> or suggestions that can help me prepare for GSoC and submit a strong
> proposal.

Please take a look at the following web pages:

  - https://git.github.io/General-Microproject-Information/
  - https://git.github.io/SoC-2024-Microprojects/

Thanks!
