Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com [209.85.128.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C71D535
	for <git@vger.kernel.org>; Wed, 10 Jul 2024 08:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720599719; cv=none; b=leQzs4ZUKQSF37dcI1PSCN/gfkqOPY31nnbCE24f6C0VCrTVKpWE5WY9vi5A2BsZ4v4FXEwk4Dzg1mUm8KT6Rn2y/nQ87mAQjV9LPkxktzo+pv+VKrpEXh+1bA5HpAT8wpY/T36r1qIFW89mUay9eeolLptvGZfq0E8NXTtDcGI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720599719; c=relaxed/simple;
	bh=ZmeHxpLKOgM+/gey/kzQ8XFDHVfn72Blt0tRhBdu9B8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=TCjwpEwp8DXdpYEx0TrIGLXM70zqw6u5J40BRlkBRu1j0I5i1eTkCNQKc4mRyIhF017xxxlXzqbgHWUTYCZwskyt49hWNHT/GyLcA+BZu5jobCPQQ37SS55A7T/3i7lhmnp9slgVihXEAql33SDNeEnknPKgw7WSVMT5X4Dr5D8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=W6QL+Oe1; arc=none smtp.client-ip=209.85.128.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W6QL+Oe1"
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-65011d9bd75so51880427b3.2
        for <git@vger.kernel.org>; Wed, 10 Jul 2024 01:21:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1720599717; x=1721204517; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+xdAG5LB+N/97m3x6tPXbwXESBNzd6bFHAbUlaSrXWA=;
        b=W6QL+Oe19V0rf4luuiSk4rNOBTx424ChbuJV2YA3gO5wKCNqM8t/JESFtMf6Qcp7ZV
         2w49JbT3WLLKmbDF7dPS1Zduj3/6n7aIdiCVOZF58aK3KPmHHwiAyaIaNezyHR6J9xKd
         otQsyq6X41bs11Nyem+hrT0NHyz/SOj0GEhNuyPmvlcxn8Twav4A0bz8acfyGHVyRY8j
         NfqeCCtJDIYcLmtVqb2h+DhWtdGgRWXYonTHfp+MoG9C2tPsWAPDn+7HZoVr0MrOP8jv
         nh169/GH65dAqJfDl3Dwk1Qgj1kDPeSQPXyGwc4oH4SV57bYM0XWHzG3bCVMXNWb3pMu
         J/4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720599717; x=1721204517;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+xdAG5LB+N/97m3x6tPXbwXESBNzd6bFHAbUlaSrXWA=;
        b=sqpjXUa23ZBykCPzzp5ksDtGQzhzY9kzU2Uh0m0aLE1HE8b8gbf9n5L4nT67F6CaSs
         bZRkZZXd6jYdWpdE41KIraxvh6GE/o1FKODgBcXdIOWTpRtBGGELOmV3rlrFcqnr+xrO
         TjxiKd/kzOQfTmlaHnVmO+rTeyPWGRQapGA7JE90V2+tWSV5KqeKHFqricy9Gbd3Ln2M
         LvoVukItGSv+TIymdTcg1bMSuCnWyqkNIpM+sbei1qk2zG8MJvWBPKm6+fI5aCI5AMKb
         KjpnGXaow5XJ49t4JNRU1og9TEPXS0ngIZR7FQ+JokZbhLWRnc8fyon94Q6HNuJ4XiQB
         sY0w==
X-Forwarded-Encrypted: i=1; AJvYcCUQVOw5SlsOHSjea5yU5c3p2riWz8tWQUXJGuk0J4jZijmD/baISE0iK/2zim3MQ7rJRV3l+QHbzFIWtUbXrp7RxwUQ
X-Gm-Message-State: AOJu0YzF+2l4vMvXSiCehyRi7cx3HokmToYT+tUFkQ1k2lRmO/HKEeoB
	n61NjVEOPVU++0d+hNH0qUKpxYfy/p2BIjWgjwTCdwKuQAKr9QAGnomO/k9Yuzk/hmWKZTRnoN7
	of7hVKRjMebTuwW2zITmcV608VV4=
X-Google-Smtp-Source: AGHT+IGg3Rh+8wY1HCZzV+Wu1WnTmr4V3qxB1JgOVsDNfPWyl9ssg8RoXOfZGWftvtaMPMz6BomprwZ5ncVpEgmSWnI=
X-Received: by 2002:a05:690c:6ac1:b0:627:e963:2bcf with SMTP id
 00721157ae682-658f09d671bmr51878657b3.51.1720599716500; Wed, 10 Jul 2024
 01:21:56 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CALaQ_hoDqD6CXEDy0YT8no3SaoJSqV6toMtyRHdJr6h3RZUiLA@mail.gmail.com>
 <CAPig+cSB0d7aAwMpToLCa+6Be5JFqLAr+0pvBXQxg_=DEk7p2A@mail.gmail.com>
 <CALaQ_hr2Hzri6y4KwYOPmGzfvM8EjJpddvLL7CQ=d3H4QLCzJw@mail.gmail.com>
 <CAPig+cTaH+TiD9Ut5Q_BPinqdAirW51J56R_tUTSnL=XGzxvfg@mail.gmail.com>
 <xmqqjzhvejye.fsf@gitster.g> <Zo3-FVT5EFyKsdGc@danh.dev>
In-Reply-To: <Zo3-FVT5EFyKsdGc@danh.dev>
From: Nathan Royce <nroycea+kernel@gmail.com>
Date: Wed, 10 Jul 2024 03:21:20 -0500
Message-ID: <CALaQ_hrhZ7qr2D+2q5ygQYG+M8=feMiYJYyuN7C+7b7gdkCZ=g@mail.gmail.com>
Subject: Re: FR: Provide Out-Of-Tree Building; Provide Cross-Compile Parameters
To: =?UTF-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZyBEYW5o?= <congdanhqx@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Eric Sunshine <sunshine@sunshineco.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 10:20=E2=80=AFPM =C4=90o=C3=A0n Tr=E1=BA=A7n C=C3=B4=
ng Danh
<congdanhqx@gmail.com> wrote:
>
> I thought in Git project, Makefile is the official build system, and
> the autotools build system is only an after-thought, no?
>
> For cross-compilation, I think various project has been
> cross-compiling Git from forever.  They only need to provide a file
> named `config.mak' with proper information for that platform, e.g:
>
>         cat <<-EOF
>         prefix =3D /usr
>         CC =3D $CC
>         CFLAGS =3D $CFLAGS
>         LDFLAGS =3D $LDFLAGS
>         USE_LIBPCRE2 :=3D $(if true; then echo Yes; fi)
>         perllibdir=3D/usr/share/perl5/vendor_perl
>         HOST_CPU =3D $(config.guess | cut -d- -f1)
>         ICONV_OMITS_BOM =3D Yes
>         NO_REGEX =3D Yes
>         EOF
>
> Those last values need to be specified manually because they can't be
> detected by running a test program anyway.  Those keys are already
> listed in Makefile.
>
> --
> Danh

(noted the "top-most" comment earlier, I didn't realize that was a
thing. Even "ticket/issue" emails always say "Don't write *below* this
line")

Danh, I was referring to the "--' parameters that is common amongst
most of the configure/make-based projects.
While I believe I had already had a "config.auto.mak" file generated,
it didn't appear that I could do OOT builds with it.
If perhaps there was some var I could pass into "make" where I could
point to the file, that'd be good (though I'd still question whether
that would even be enough to get OOT builds).

Someone on the IRC channel pointed out to me that there IS a
CMakeLists.txt file and I found it is included in
"contrib/buildsystems".
Awesome, right? So I thought and hoped...
Before I get into it, it might be nice to have that mentioned in INSTALL/RE=
ADME.

While that gets me the OOT builds, it seems it forces the use of
pcre2, even when it isn't installed in sysroot.
If it's installed in the build system, it'll find it there and say
things are good to go even though the actual "make" will fail because
of it.
"configure" defaults pcre2 to "no", so it builds fine (apart from not
being OOT and other stuff I have to do).

Getting closer (after manually commenting that USE_PCRE2 stuff in the
file (which I also don't like since source is no longer pristine),
though I just now got:
*****
...
[ 76%] Built target scalar
make[2]: *** No rule to make target 'git-remote-http', needed by
'git-add'.  Stop.
*****
so I'll have to peek as to what that's about.
