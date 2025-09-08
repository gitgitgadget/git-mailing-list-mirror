Received: from mail-lj1-f173.google.com (mail-lj1-f173.google.com [209.85.208.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EC51F9F47
	for <git@vger.kernel.org>; Mon,  8 Sep 2025 15:10:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757344223; cv=none; b=aBnUVur/HNllmuWhb6Wn+Iw6SIYdyHFyGSROPna56+WKP+q7YHOyB7YTg5x4c1Y/VRN30v7DSxcM0boJQ5sVX/U7lRhFtUmb4Ho8IUnfDQVJw9E5fsqboi6PLOQUUkC8Oxh5XVMflP8K0pZ4lQ96yIf4Vf9XNKAauWajdl7lBww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757344223; c=relaxed/simple;
	bh=UJa85ybnH07EBIaEkjsoJQAmSeSRkFr6BgWGotz9PDw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=S0L9/Q+W+2PHg5GexzFiLSUDNAZncCRzOvzyLujhd+USnC3A66Ty44Q3k4HgtJyHwEz+DUj1wmd9Xxc3NckfjRZINPeV6W7WVBxdbN5tdUggqs89agKed7bTZSR+rHQGhqNmh5AmLM1kj5OnHReQszbg48+2mA7leSvF1rnc8Yw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WV5xqOxQ; arc=none smtp.client-ip=209.85.208.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WV5xqOxQ"
Received: by mail-lj1-f173.google.com with SMTP id 38308e7fff4ca-33c9efd65eeso14248531fa.3
        for <git@vger.kernel.org>; Mon, 08 Sep 2025 08:10:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1757344220; x=1757949020; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c3143fEOpJVeqBj9fiWfmqCv0Yh2893Md/YudUOgcvI=;
        b=WV5xqOxQYUoSriBX0KacKKEIsOiXZlF/FwLq1Fqrci1QW2L1VbiakdQmm1EDq1z/Er
         41hleCBWODYE9oLk1vZc77SfzrB1g1Jk19rqqDwNV4Y0xma7TJ73x/p0A8D7/hrPE79E
         pd/7gWdc4W3YOKlLP2cxOgoAXqdCGOcJne7Kv+9BgUUZaze/qylsWWUGoc7zC8y1foyt
         OoD9x8Za6zK48DjSxkyA59vlFoy/BWFLAS1rbGXpGnIyGweL1C+MlEi3l7y0qnYqwHBU
         lIu5lUURMaXh8CUAPTJgZbfv1X1LLgF/+p99X1+8/a6EW6fiylFveLhraNJT+E88o+Uq
         mUPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1757344220; x=1757949020;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c3143fEOpJVeqBj9fiWfmqCv0Yh2893Md/YudUOgcvI=;
        b=hodL58QTR0as/xcTnfmMApxMWkgsmTEwgmhmQK/ixTAos96XfaCBe36xa8FVFoU3ZP
         oKCN7eWGFUJvvuB5NdYpI3AadbYxqcH4KQparEk2HzaTH1WnZrQREdD3B/1NIwSiEspK
         FJwZYbZ/vQQ0QAEUuzi+ZUF10Sgz4sTSA2pKni6zJu8omfIK53txqeY4wliiutHlZSmH
         7HxUMAJesvoW7cTdlobKqTh7j2v9DWDiWo/b/nm/40OEDNk9tSM07V/b50k1cFZcJYTb
         sLLappqvzUVKapVr5BPezghSk24VVGuck8McvQp8UIzmCviCcTYszW1ar6zWm+EtIP31
         GhVg==
X-Forwarded-Encrypted: i=1; AJvYcCXbZsKqNGUvM7iot8l0jFLNhtF4/HmzDJsZkhpv4Urw7e8chigwfb29wI1On9YZM/vSpaI=@vger.kernel.org
X-Gm-Message-State: AOJu0YwghbNvcmuUOM2tp4sY0z/CGEdtuuMACjNxeuSpG5RCAQqkL3pg
	ha5l+xzw8N07OL/X0YKnvoWx3+OuSiBayK83YyXF51ZIX62kzL6rHVPvc184sfYyE++RgEscj3w
	/kaERnWVnlYTW5ei79MgtyG4C60iSFGM=
X-Gm-Gg: ASbGnctvOgvpK430u3pmRDgPX+Vv2UEU3u2rB5eDD7yV9gP5FEGF6EPfOBTOCi+c+Hq
	INSGBTglrlGp+PuaNC++NbAEoTXaXbM8X+L7YCNG7w+/d5QdI0Rp2PDrp+BINTbh29AFddTHm5t
	agQ/7DiydOX+KOopNvFAFFlJdCYAsc/SEc8/QSwf5Xyb/7ZE4k1BevYgsf+oql7Fm4xrVVwzGJW
	x4f47M2wEK8azcgmPg=
X-Google-Smtp-Source: AGHT+IFKfcuRwgRg/5eh9SYAb9kJF18yw7qF+5wgd0yW7klvDjLpK0XH5UVugZ1go7vijbjAilgmGJU1/oDmzyvjI1o=
X-Received: by 2002:a2e:be9b:0:b0:336:e4fe:914b with SMTP id
 38308e7fff4ca-33b5786268dmr22300661fa.11.1757344219282; Mon, 08 Sep 2025
 08:10:19 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <01f101dc1760$5eef42b0$1ccdc810$@nexbridge.com>
 <xmqqsehc1ypi.fsf@gitster.g> <aK9mx2XemppIaKVI@nand.local>
 <xmqqh5xszf91.fsf@gitster.g> <aLbSA5KsBdD4wW_B@pks.im> <aLco7uHFZaHnfxBa@fruit.crustytoothpaste.net>
 <aLfU5sEa-RE3X4G2@pks.im> <aLjj9cG9_K6YLfeA@fruit.crustytoothpaste.net>
 <aLl6iFXeAvL_hvqR@pks.im> <CABPp-BFNoLC+TdtuEq5Nx+VcFJ-WFga2r0E+eq=fFaaCN_sRGg@mail.gmail.com>
 <aLqIHCdlbwF5X6Cm@pks.im> <CABPp-BG3Zcw63vNziy86MvYNubefn1SmPvXefpqpA=a+42KT8A@mail.gmail.com>
 <042f01dc2011$da9dcda0$8fd968e0$@nexbridge.com>
In-Reply-To: <042f01dc2011$da9dcda0$8fd968e0$@nexbridge.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 8 Sep 2025 09:10:07 -0600
X-Gm-Features: Ac12FXy2yc-A_lVn1u_y3w-dv1sWGSzadGizRV_2vA9cE-ORmOIDqrUsnZo3NHA
Message-ID: <CAH=ZcbAjpgAVjVK6iYEr2150a+WgFfxrWuJUoR1pa08JqM4BDw@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
To: rsbecker@nexbridge.com
Cc: Elijah Newren <newren@gmail.com>, Patrick Steinhardt <ps@pks.im>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>, Junio C Hamano <gitster@pobox.com>, 
	Taylor Blau <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, 
	Josh Soref <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Christian Brabandt <cb@256bit.org>, Phillip Wood <phillip.wood123@gmail.com>, 
	Eli Schwartz <eschwartz@gentoo.org>, "Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, =?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
	Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>, Mike Hommey <mh@glandium.org>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Josh Steadmon <steadmon@google.com>, 
	Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Sep 7, 2025 at 10:10=E2=80=AFAM <rsbecker@nexbridge.com> wrote:
>
> On September 7, 2025 12:10 AM, Elijah Newren wrote:
> >Sorry for the delay; life outside of work is challenging at the moment..=
.
> >
>
> I am going to address the critical point mentioned below and snip the res=
t for brevity.
>
> >I still don't see why distributors _must_ ship the latest version of Git=
 and why folks
> >on some platforms are considered broken if they are using a slightly old=
er version.
> >Let me ask again: has anyone answered why this is considered mandatory? =
 If they
> >have, I've missed it, but I've asked multiple times.  Even if you want t=
o lump
> >"distributors cannot build a newer version" under the umbrella of "break=
ing
> >changes", I argue it's a much different kind of break and one which meri=
ts different
> >timelines for handling than e.g. lumping it in with 3.0.
>
> I do not see that distributors _must_ ship the latest version. Suppose we=
 are on
> 2.51.0 and a CVE comes out that prohibits its use in an organization that=
 does
> not allow any medium-high to high CVEs. This represents hundreds of thous=
ands
> of impacted users in my community alone. How does the CVE get applied if =
the
> latest cannot be built and the git team does not apply the CVE fixes to o=
ld
> versions. Personally, I do not care if git versions are different between=
 work
> and home, or even between CI/CD and other platforms. I don't even care
> ...

Ok, that answers the question for NonStop, but that doesn't answer the
question for the plethora of other distributions. Most distributions
don't ship the latest version of Git in their package manager, and if
an organization deems it critical to have the latest they can build it
themselves and ignore the Git version in the package manager. So why
does Windows, Mac, Linux, etc... _need_ the latest version of Git in
the package manager?

If security updates are backported to NonStop, until that platform
supports Rust, then I don't see why using an older version of Git in
Windows, Mac, Linux, etc... is a catastrophe. Most existing
distributions _can_ package the latest version of Git, but they
_don't_.

I reiterate Elijah's question "Why _must_ distributors ship the latest
version of Git?".
