Received: from mail-il1-f172.google.com (mail-il1-f172.google.com [209.85.166.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4303B137C52
	for <git@vger.kernel.org>; Sat, 23 Aug 2025 18:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755973841; cv=none; b=LNbdaRGMy07VyOS9Q8Xf1uEnnaY90gQ59OUSBMfKBjnSsWJtDYdjx09I3abJkrlrzpSxGUJopS6CZfRg7ko4mA4E9oi0uejwsiQCTltyE245bHwWG1Q5Ss3vuU61xVWa5x3/69hCiaRlQAym52A6Wljr6JL6LA434Y9odW2tve0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755973841; c=relaxed/simple;
	bh=liE7fuQzTOOlpvOXVjqelN2HB8nmNJPIpLaefTCFzVY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gBICY0zCwR/AdjFuIZilKcTf/TA/puv89qlMTt1zQvw8IO+kq42C12EZIqxh41L+1j67HFJssYt3Dtllp2zjBP9Uk3VZT4KzatL8V47uS3R2P8EJIyU9QGOw1uUMviLeZQxzFaw4lMGV6+Nzi3U58mo8FXxzcdj+J0K2x4XgUJ0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=E1aZAhCk; arc=none smtp.client-ip=209.85.166.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="E1aZAhCk"
Received: by mail-il1-f172.google.com with SMTP id e9e14a558f8ab-3e668360ec7so20398445ab.1
        for <git@vger.kernel.org>; Sat, 23 Aug 2025 11:30:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1755973838; x=1756578638; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZjxgvfopAz+a/F/berx3mASZnWo5La07sZXWVx27uKY=;
        b=E1aZAhCkEOVPSRu+qiJ6Qej651631AbaRelAr97yUfLx2M6vK1HGre9LxhOkRhxxQG
         W1EHSYYMtYJbhdtwTam91+P7bQhxtJLDE/Y6VgKYNomvgI2gVG0/dEpQ91t+Ju6rinzt
         dVFcvjECWYQliFsgFZGSkLCTt1JKAPa0fKbb2TXy1kdyrD6chW+sSoJM6TPpJSxYx6W7
         IyFuGt1wmsog5XVZFAvbu2iEEvyw2iOHmoGB4Lo9AgLUitfOdnx7meKszqFFUAaYp1WR
         b3jB69Yex4HEE2/yXrwwfqHG3mYsVaINEC9nIrvIgqr/ig7TgJxIMTNHlh/yOL54RMMR
         cNaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755973838; x=1756578638;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZjxgvfopAz+a/F/berx3mASZnWo5La07sZXWVx27uKY=;
        b=FhLPq/33fXKxENpTwn9rlqKuy7VW2o6xzBqWKlulqVszD8PBJLWzOYe5zW7wrXjgUU
         yjuoGCo4KM+q+EPgzK2wVzRpdW2T2Z60Eqy6Nxv6U92xCDB3qtK6qJbJd9zBLVcrtiTo
         asAwHqKqk9FDxKB7O7sFSH2OlzaONg5i0vKcZVNZKqcnHMTul3foXAVpLQBhW1GTYTMk
         5j2hUY1pKG7kIn//3Du3BpOwFiwNc7C5WEyqDZvCGqcjjRJ5zueiU3+BsiuaAhWGCbjC
         zYqh1H/cIdmLTA4cHdmcEdD+VpExfMcia2CKDltgOdhqU7aRqm9lkJsW1+nmAtjdZR0Z
         N1Sw==
X-Forwarded-Encrypted: i=1; AJvYcCVmMre6rYKEIXvtb71N/MhWMhdjqLTJ8iVJAduodcKulsMKVfAH08LCBNVxl1yNqIfIaYw=@vger.kernel.org
X-Gm-Message-State: AOJu0Ywlwt9hmhlO/GJVBgoxGUayhTb5g9VO12hT4bcec+shik8/CK/i
	PZ3ZlQqGNqiA0oVnd7NhFKu8C3vGGekdwxLVTKjo0ciSsf+eaQrOrarEQ1qpTiQnMweDZ++J2hQ
	2JFXK1VnmX5mu4+A6C7RHDdSREBgFoYQ=
X-Gm-Gg: ASbGnctM9EumHWyH3QlVLfK4Qn1g1e02kKgC1f0QqPquyGPCTE/UYD6DHkbezrgLViT
	J6vlHusEQZ9OROCg44ghzNmHkCciCNE/zksnTzNM7wnf7i33LDwuADBSuBa5sLnZ8nvl860mEGb
	2tr/+yCJIeiavZlnl5d3NOxrTHpnfmIpsJ6QDvmmffMjGdXrmmMNNM1qCmUE8YDjlCSOGpdxWml
	9T4p6Jl7IPwWcuD3/DuptiJfgxQnqMCFyd/5Mhw
X-Google-Smtp-Source: AGHT+IFtWPKEpzOt5k3BCMN7txRfuE6GVj2hly2VTkE8OGbY398Dtg6ZZ6U+L8e3d/EfQwUGB9BF/jfSDpRFT2xC8g8=
X-Received: by 2002:a05:6e02:4801:b0:3e5:8113:35e1 with SMTP id
 e9e14a558f8ab-3e6d6db51ddmr157561915ab.4.1755973837975; Sat, 23 Aug 2025
 11:30:37 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.v2.git.git.1755220973.gitgitgadget@gmail.com>
 <pull.1980.v3.git.git.1755921356.gitgitgadget@gmail.com> <03939951256baaaec3fcc690cfa38ee12fb553ce.1755921357.git.gitgitgadget@gmail.com>
 <030a01dc1433$ee3e2510$caba6f30$@nexbridge.com> <4dffd698-9d3c-41c8-9d3f-0d3750e683d3@app.fastmail.com>
 <031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>
In-Reply-To: <031601dc143f$7a9a25d0$6fce7170$@nexbridge.com>
From: Elijah Newren <newren@gmail.com>
Date: Sat, 23 Aug 2025 11:30:26 -0700
X-Gm-Features: Ac12FXxPjtMGVa91v_brpeqyKFmrJWYhLMnY51tTJubsXoRc9WAXSNwX-0467c0
Message-ID: <CABPp-BHdHQFv74GDbe=pJBFBALAMZoGsJDhSGqPbT3Daadnd4A@mail.gmail.com>
Subject: Re: [PATCH v3 02/15] xdiff: introduce rust
To: rsbecker@nexbridge.com
Cc: Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Josh Soref <gitgitgadget@gmail.com>, 
	git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Taylor Blau <me@ttaylorr.com>, Christian Brabandt <cb@256bit.org>, 
	Phillip Wood <phillip.wood123@gmail.com>, Eli Schwartz <eschwartz@gentoo.org>, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	=?UTF-8?Q?Matthias_A=C3=9Fhauer?= <mha1993@live.de>, 
	Patrick Steinhardt <ps@pks.im>, Sam James <sam@gentoo.org>, Collin Funk <collin.funk1@gmail.com>, 
	Mike Hommey <mh@glandium.org>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Ramsay Jones <ramsay@ramsayjones.plus.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
	Josh Steadmon <steadmon@google.com>, Calvin Wan <calvinwan@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Randall,

On Sat, Aug 23, 2025 at 8:06=E2=80=AFAM <rsbecker@nexbridge.com> wrote:
>
> On August 23, 2025 10:26 AM, Kristoffer Haugsbakk wrote:
> >On Sat, Aug 23, 2025, at 15:43, rsbecker@nexbridge.com wrote:
[...]
> >> Does this introduce Rust as a mandatory dependency for git? If so, it
> >> cuts out numerous platforms.
> >
> >The proposed platform support policy is in patch 1.
> >
> >https://lore.kernel.org/git/6d065f550fe871cf010409f7bd2a63438cf52723.175=
5
> >921357.git.gitgitgadget@gmail.com/
>
> It is a very disappointing policy to be honest. It kicks me off git becau=
se Rust is
> not available on my platform, representing tens of thousands of users in =
North
> American alone. Rust is not available, but may be in a few years, but the=
re is no
> guarantee that the hardware vendor (HPE) will provide support. I previous=
ly
> commented about the problem with Rust and was not taken seriously. This i=
s
> disappointing and exclusionary.

I don't think that's fair.  A quick reminder on the history: There was
lots of excitement about potentially introducing Rust two years ago at
our virtual Git contributors conference.  Taylor formally proposed
adopting it on the mailing list a year and a half ago.  And at Git
Merge last year, among those in attendance, there was broad
significant interest in adopting Rust with unanimous support for
letting it move forward among those that were present (which, yes, we
know wasn't everyone).  And there's the three rounds so far of this
patch series.  At every discussion where you weren't present, someone
else would always bring up you and NonStop, and point out how you've
been a very positive long-term member of the Git community and how
Rust adoption would likely negatively affect you, which would be
regrettable.  We waited years to adopt Rust precisely (and I believe
solely) because of your objections.  Josh and Calvin even went the
route of making optional not-even-built-by-default Rust libraries
(libgit-rs and libgit-sys) when they wanted to add some Rust bindings.
If years of deference by other community members isn't considered
taking you seriously, I don't know what is.

I agree that it is disappointing that there isn't a clear way to both
gain the compelling advantages of Rust while also retaining the full
current extent of our widespread platform support.  It's doubly
unfortunate since you're such a positive contributing member of the
community.  But not allowing us to ever gain the advantages of Rust is
problematic too.  So, a decision has to be made, one way or the other.

If it helps, here's the statements I've seen from long term community
members on Ezekiel's proposal for a hard dependency so far, most of
which call out the reduced platform support (whether in favor of the
proposal or not):
  * Randall: https://lore.kernel.org/git/031601dc143f$7a9a25d0$6fce7170$@ne=
xbridge.com/
  * brian: https://lore.kernel.org/git/aHlwZPbiKnakMN75@fruit.crustytoothpa=
ste.net/
  * Taylor: https://lore.kernel.org/git/aHl4U98BBvpA5eKF@nand.local/
  * Patrick: https://lore.kernel.org/git/aH-CN0RYFmpm7fMt@pks.im/
  * Phillip: https://lore.kernel.org/git/f439958d-64ce-417f-8175-720f69387d=
48@gmail.com/

There's also been some emails that can be read as implicitly making a
position statement on the topic from long term community members:
  * Junio: https://lore.kernel.org/git/xmqqzfd12ujv.fsf@gitster.g/
  * Johannes: https://lore.kernel.org/git/ac871bc4-df93-31f4-55f2-d6fc538a4=
22d@gmx.de/
  * Elijah: https://lore.kernel.org/git/pull.1980.git.git.1752784344.gitgit=
gadget@gmail.com/
(I figured my noted assistance of this series meant I didn't need to
explicitly call out my support for it.)

> The assertion in the policy that Rust is easily interoperable is incorrec=
t.

Are you mixing up interoperability with portability?  Without further
context than your email provides, it appears so to me.  Rust code can
call C code and vice-versa within the same process without huge
amounts of serializing and deserializing of data structures, and
without what amounts to something close to an operating system context
switch in order to ensure call stacks are as expected for the language
in question.  To me, that means we can call the two languages easily
interoperable.  On the other hand, portability of those languages is
about whether those languages have compilers supported on various
hardware platforms.  The document explicitly calls out that fewer
systems have a Rust compiler than have a C compiler, and that Rust
adoption would thus reduce how portable Git is.  Are you referring to
this lower portability that the document itself also calls out, or are
you pointing out additional issues with interoperation between the
languages on a platform where compilers for both languages exist?  If
the latter, could you provide more details?


I know my email is probably disappointing to you, at a minimum.  I'm
sorry about that.  I hope it's helpful, at least in having links to
where various folks in the community stand if nothing else.
