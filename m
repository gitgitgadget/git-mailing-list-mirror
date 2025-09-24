Received: from mail-lf1-f43.google.com (mail-lf1-f43.google.com [209.85.167.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D91DE7E105
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 22:39:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758753547; cv=none; b=PBiAM0h/pB/WFWjRG78EneCDMnjcq0nzOlnRe+uigAtyahyH2TxoirmY7TKKeqY4hADFC7/BIGPf1F0+fcKVGNy6wDzENScGIpaCoyZ3moAwJzUl2hKi5qrnv/wRt3HayblFfViaPhoW+wompqCCdO5BURO/SwYz+a4Ry3eA8r4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758753547; c=relaxed/simple;
	bh=4LjUN7VaM/2LoAdRFrK3Qg5TsSyD6d+QsdYsv8VAfTU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=isldoGPUXMX5KwN0x3RTV/bsHuWNQYEysy545NX6MFNxRq/lMaZEUBZY7WDkGpkittvXVNS4ZZbsc1A4E7wNrytRfKIc+xAKy725LHuyt6GRbiqZYbTz/qUa408rw3NAlsSZJsISS5wEyxz5MviY5waUn46mjA3iLW1OrgznCmE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZFiyEszU; arc=none smtp.client-ip=209.85.167.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZFiyEszU"
Received: by mail-lf1-f43.google.com with SMTP id 2adb3069b0e04-57d93a4b5e5so304310e87.3
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 15:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758753544; x=1759358344; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EwjF3cKsMfMZRa9bHERAPoHR1h+TVXOiZcWSD9v0xjc=;
        b=ZFiyEszUHp55zAGXiXajcgX+tfHhe862PvKLUh39F0ZSDn1IGw0oeh4cz6jKABAfrx
         aoH9o6Q+N41u7ZbXOR+R+iKeS+AtOiRQsFI6VGvWaV5gI2tWloN+a0BmfsMALWSlsBGy
         gDV2wPE9WX/m7k6U+VyLhg5APGPP6w1ouzQzQu7KUP6LdGmh+BoTDjDQIx25XuGlJ70X
         7Nbdt2GqYibQLLc+pOdj8YbJIAp5aIRkH+mWmrk9Od83Yk3Vy2CcHYN9I7QcLwiQXW+n
         xHHesqMDPpHl3YUkfTFICwn1UT7XKAyjySVCMFLn4nhyj+2/cLvatYXbHb/XF5j21F0U
         BDzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758753544; x=1759358344;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EwjF3cKsMfMZRa9bHERAPoHR1h+TVXOiZcWSD9v0xjc=;
        b=Keaytk8qkLdrZov7GQbeYE1ofYlciJUAARGeWUnr4IaJSanawUFCqZ7rZyv1FYcOYw
         6Jn9RHqSKz/wWL3Dn1IAoZ1zWW5ElJo8cVcuKNXZrPYFJL51kKN20HVDZGbR2lZPt1EF
         NWsGtRfCZh1cV00IijRUpR1mI85fqK1KBe698+2FsbtBCLBa59X+BJS2vsQLE2iiaOJA
         sceo71s4x4wb/5ZF7zKRMITHXkpqLHvKDksSEEbfgHHC8n3g8KuD7VYyeYqHH2DgNyxq
         oy5Cq7bb7SIu5oNH/8IQTBWwvaJ7klCbRxAc2YggI4FcCMxDpBbolxO3lmQjnB6uEfJQ
         SItQ==
X-Forwarded-Encrypted: i=1; AJvYcCVWJ+GDebynawZbvqQykfft2YuoJQgm/Jdu5XxWJz7vmSCHYH7eAW9xiawGgDuKGRKJmws=@vger.kernel.org
X-Gm-Message-State: AOJu0YzpIKkiTM8ms6MoCAi4hAKs7nMpAozU798ocoTyW1YgMVAGIBfp
	NTXZ14DhpVXrgLbxTccuOnLLy18erykBYMwr+eHlzTO21wB/pU2Wvu2V95RNgxJ43odqg1CqocH
	COwGjZfB6KaFLrdu7VvAQUnXwxip6Mps=
X-Gm-Gg: ASbGnctlg3+PfYhUA8NywAIc2QIgbS/9jEreRvYU0vnQ3oBieh7yso86DFIqKPPvaRQ
	OS+CmUBg2xbIKlPxV4Z9Vxs3JOvmt2Y4e6MF+41v/4JROAAS6u/PI4gIC9LGOwYp10/OPzkmvDJ
	OSvvwHFB/pz49149/NgcHPGh/XV40Pnix+rDa8+Eox7kfzez6eAl2TcTPeNflypiXo8hhooeQ9x
	PHBnjO7
X-Google-Smtp-Source: AGHT+IEoiel1flbixcutx6mUo+Cwy/WiOJEtWQaLZreNdh17ly6TUp5d0c9Dk2vBFFhxQeTGiLf6ulOtz6+sgCvMTf4=
X-Received: by 2002:a05:6512:31d4:b0:576:f133:9288 with SMTP id
 2adb3069b0e04-582d4a08717mr318474e87.54.1758753543849; Wed, 24 Sep 2025
 15:39:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1976.git.1758656702.gitgitgadget@gmail.com>
 <ffbb9d7c6aff77f9a1caed86a20bcc6b9afe66e7.1758656702.git.gitgitgadget@gmail.com>
 <CALnO6CCkWaxZKGseHR7dk20erFPAvGMqO+OYr3Np+y+=1Y34HA@mail.gmail.com>
In-Reply-To: <CALnO6CCkWaxZKGseHR7dk20erFPAvGMqO+OYr3Np+y+=1Y34HA@mail.gmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Wed, 24 Sep 2025 15:38:51 -0700
X-Gm-Features: AS18NWD2sXCAIfkITlAb_0xIpUfhpatQ66Lk5xd0hsklhC-Lv5prhpRj5xqE400
Message-ID: <CAPx1GvfK5ZKUG86n=DR8LeO_STwO5FAkDzzD9t6d9R22KdOySg@mail.gmail.com>
Subject: Re: [PATCH 2/4] doc: git-pull: clarify options for integrating remote branch
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 1:23=E2=80=AFPM D. Ben Knoble <ben.knoble@gmail.com=
> wrote:
> > +First, `git pull` runs `git fetch` with the same arguments to fetch
>
> Hm. Is it worth saying "similar" rather than "same" since we don't
> pass e.g. `--rebase` to `git fetch`? Or is that detail unimportant in
> this context?

I would suggest "equivalent" or (perhaps better) "appropriate".
Perhaps even:

    First, `git pull` runs the equivalent of `git fetch` with the
    arguments needed to fetch necessary branches from
    the remote ...

Definition of these arguments can be deferred (perhaps
even indefinitely); but:

> > +remote branch(es). Then it integrates the remote branch into the curre=
nt
> > +branch.
>
> Plural-singular here leaves me wondering how Git decides which of
> multiple fetched branches to integrate.

here we'd need something along the lines of:

    Then it integrates the appropriate remote branch ...

and here we *do* have to define "appropriate".

(Historically the merge step grabbed stuff from FETCH_HEAD,
excluding all the "not-for-merge" parts, and I have never dug into
what happens now...)

Chris
