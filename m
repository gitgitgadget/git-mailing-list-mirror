Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A2F5148827
	for <git@vger.kernel.org>; Thu, 22 May 2025 07:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747899098; cv=none; b=rUXRXScT6npr3McP6fKPTRqE5rng0RE2O6WtX5F5k5FiLC6NSrJf3k3KwRzUonx74MYlwrRKSuy4xrFJL/aigQfVNwJARKhp14wFuzHhD4+SVYHkzsavUTLce5qYnyvvQkvLFjiF/ktKeWCnHSioE2DbveA3omf43YGkOV/Nygo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747899098; c=relaxed/simple;
	bh=HoFOPu+jQr9Spt2hUz8nUb9bj8Iy44OxdpzAkoYUeZ8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=aS4rBDV7NurJ/RUXxTz1POvt4p3C07wgdhLwIxGVjtnISRLwoZ8/N9NfGPCBQUqiPuLUr8MnKdezf8d/GUvkgYh/K6kRkCrEnRbywzHqEGkZe4Hgue+n8ORpUr7T9tikpC1ZHhk0k+E8A8/BHaQ404kxy6sHgj9bGAnDhBrsHYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=T/ZDV0S8; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="T/ZDV0S8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1747899096;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=btC0zmcb2UNNIgD++RrdoDXMlQInr6tRDuyONtI3MZE=;
	b=T/ZDV0S8ceytPm7XzyVVRrPYD+lRz2E//+AnWu1HLaqIEd8KWKz7RLFqHwvDezHgZ8v9xM
	sF+UVasAkLke53FkyZf8BpaYDe/F8BtXxklj9pA8+NXk/q+Vw2kWZ5teawyD8XfcJJG1Gu
	7c7QJ8C8x/DAzpQ5zIHyQNhvYtb6af8=
Received: from mail-ed1-f70.google.com (mail-ed1-f70.google.com
 [209.85.208.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-44-4tjdmjuCNsqqjJZietznxA-1; Thu, 22 May 2025 03:31:34 -0400
X-MC-Unique: 4tjdmjuCNsqqjJZietznxA-1
X-Mimecast-MFC-AGG-ID: 4tjdmjuCNsqqjJZietznxA_1747899093
Received: by mail-ed1-f70.google.com with SMTP id 4fb4d7f45d1cf-601f918c628so4637252a12.3
        for <git@vger.kernel.org>; Thu, 22 May 2025 00:31:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1747899093; x=1748503893;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=btC0zmcb2UNNIgD++RrdoDXMlQInr6tRDuyONtI3MZE=;
        b=ibLU873c+jX6DQAFSUxIpn0yfIdWhR8LuKHdAGsj/7p50Gt30PH1C+vovScaOzFJKC
         BPgXnAOHfPXmdE1/H2iGPuSoF7r+/OGxW5gLsqBLyuymgs/7wchi/4fXmapmllEqCs9R
         tz6ECDbouAuWDQHAeWlTCZLSFRYAcoXFnpBESFqNvzLBJ9UQAdrsZts6wBcFyhu7C8TI
         qRlORwCe0PyzeyvaP7bzfC2fZklEA6JyLeYrLcwbn+cvtFJnsXx8kwVr/txieDud6dAp
         zNVlilM3uTnZ5aMG51TJn2PLbocots4IA9DjFZuQHXXYJ15+7eNxPIqhcH6nNPYQgISV
         mJ/w==
X-Forwarded-Encrypted: i=1; AJvYcCXy146cz7IHnjZe9o16aNXQunQN4m7icu1nomJs3LobE1oSx4ccQBjtWPRVCr9yWAbnqfE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv4t4/hO/FuXyLx1iid/hMpcdZyvhbchyZYwbtVZs5qSrntkx7
	JRFtOUod4ajHBVqzdAyna6bhO3b+vnUY4C8FnH/GpKpg5HabnQDKX7LuAjvkxebiaMaMnsvM+N2
	CUIIMi4YEPZZGgX5sepytOckKJohX5b22Uw4MDoKatGpE/Vd4lZCdroKuTqVnufGuGv7AO7jdRJ
	l+RGwrQAEOtjb4qUYmNSu9S6UlVY/3
X-Gm-Gg: ASbGnctifs250H3a7mXu8Ri5Py0mG8wjTrLji5R9z2kGw/PTNQIAjLtyFPJGfY+ZW3a
	AKgX37/pNoxw/ucuAolKn7ct23oMJ5UY1WeU1RuP+eWWfknuwOhmBnH4cpgnlXC4LBrMv
X-Received: by 2002:a17:907:7f8e:b0:ad2:2a2f:7064 with SMTP id a640c23a62f3a-ad536bdfe79mr2124311566b.25.1747899093317;
        Thu, 22 May 2025 00:31:33 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFywoj7jr5K3h4klkOfXA204klHi2lilQU2M/C4L5b+CiXJYSVll4qPvXV0iJqfA58A8oeKi1sohKvg8d38YwI=
X-Received: by 2002:a17:907:7f8e:b0:ad2:2a2f:7064 with SMTP id
 a640c23a62f3a-ad536bdfe79mr2124309966b.25.1747899092976; Thu, 22 May 2025
 00:31:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1925.git.1747813502225.gitgitgadget@gmail.com>
 <xmqqplg2c8ow.fsf@gitster.g> <aC5KRBop9m3K5JtE@tapette.crustytoothpaste.net>
In-Reply-To: <aC5KRBop9m3K5JtE@tapette.crustytoothpaste.net>
From: Ondrej Pohorelsky <opohorel@redhat.com>
Date: Thu, 22 May 2025 09:31:20 +0200
X-Gm-Features: AX0GCFuy0POJFRM6b_xXs3EpfDObeN_KU7DCa7L7hAbOaG1_Na_tWGcPRm171ZE
Message-ID: <CA+B51BEqMPPmbaiXCFKXoPvufS7NnT-wxJCW5VgmtP05xUbrcw@mail.gmail.com>
Subject: Re: [PATCH] cvsserver: avoid precedence problem between ! and %s
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Junio C Hamano <gitster@pobox.com>, 
	=?UTF-8?Q?Ond=C5=99ej_Poho=C5=99elsk=C3=BD_via_GitGitGadget?= <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, =?UTF-8?B?T25kxZllaiBQb2hvxZllbHNrw70=?= <opohorel@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Looking at the code, we were not exactly sure how the code should
work, so we picked the solution with the least impact that suppresses
the warning and doesn't break anything.
I'll change the commit to use `!~` instead.


On Wed, May 21, 2025 at 11:49=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-05-21 at 14:58:07, Junio C Hamano wrote:
> > "Ond=C5=99ej Poho=C5=99elsk=C3=BD via GitGitGadget" <gitgitgadget@gmail=
.com>
> > writes:
> >
> > > diff --git a/git-cvsserver.perl b/git-cvsserver.perl
> > > index a4e1bad33ca..076c10cb2c2 100755
> > > --- a/git-cvsserver.perl
> > > +++ b/git-cvsserver.perl
> > > @@ -5009,7 +5009,7 @@ sub escapeRefName
> > >      #   =3D "_-xx-" Where "xx" is the hexadecimal representation of =
the
> > >      #     desired ASCII character byte. (for anything else)
> > >
> > > -    if(! $refName=3D~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/)
> > > +    if(! ($refName=3D~/^[1-9][0-9]*(\.[1-9][0-9]*)*$/))
> >
> > Interesting.  Shouldn't it be using !~ instead if it wants to assert
> > that the refname does not match the pattern?
>
> Yes, it should.  It's likely the reason this is getting a warning is
> that `!` is higher precedence than `=3D~` and `!~` (see `man perlop`) and
> switching to `!~` is the customary way of writing this.
> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA



--=20

Ond=C5=99ej Poho=C5=99elsk=C3=BD

Software Engineer

Red Hat

opohorel@redhat.com

