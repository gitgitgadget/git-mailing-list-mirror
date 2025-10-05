Received: from mail-wm1-f46.google.com (mail-wm1-f46.google.com [209.85.128.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DF8310942
	for <git@vger.kernel.org>; Sun,  5 Oct 2025 05:32:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759642363; cv=none; b=ZFSGk454gaZqlUYA3enZil4kWtbFxEjULva3WoDxBYkrux6DtMXAA6qrECzedqk4sGp7P4qYQ3l4AYUzzyH5NT0GkfKaKXii1svjLuuMvwLsiz1cmZwg3GJrxRL4m/yYbVZuB6ky5pv8sZUs2mWsSulbn+TxEXbm7qdLF1nyT0I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759642363; c=relaxed/simple;
	bh=48gojU8K52wfXgZCC8SoPPgM+rDBJOdQogh04ziJBD0=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=aJIf6ZGRYwyCxKdZpxzzVw3ywNbeAW3Jn+VIHkEg22Nt49Cjr5Wr0Xs3n2ZERfot8XTOH3jQCZMaCPywfCWlYDyh+migx4vTaMafisalFRfuMH4tEoq8TBf4gcyMAG8BjKFINpdANLvRHk/HIuBvM+w3sFdyzt2kQjrWSu9bq7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cl5Ogt1X; arc=none smtp.client-ip=209.85.128.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cl5Ogt1X"
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-46f53f88e0bso829555e9.1
        for <git@vger.kernel.org>; Sat, 04 Oct 2025 22:32:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759642360; x=1760247160; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qjKF8D9qYdYyOp9px98BTejrCNSiZ0GzfFIr9lDnGIY=;
        b=cl5Ogt1Xhl06VHog99Hp7ApjC/WaChOr2RC50R0D/akROlsgSLVHXlYRf09f7bQEGI
         LqVKGZTGz22LY5ySSceOgvEyvU91WHoL40hJ84C34lJM+EAyOIggWZJ2+2Rsc4CIkrI7
         26nTZt4GnihaujiJ6AZFOvnG8/Imo+4t3avsJIcG00yiX8dW0WzT1TwkR/uf5928c0jK
         7Hs7fmla0GsyZOoxfHbsgX9bp5nQw/lMHA54dJ27olLMGXU5K0FKKiJVe6nxF3y+2F7i
         R+wjpw6G/QJM7nd9zcdw9TPEJhzlJBW+03MEdb1eALMZaU6GPEKtTXt6TknxZuDznYEy
         GFRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759642360; x=1760247160;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qjKF8D9qYdYyOp9px98BTejrCNSiZ0GzfFIr9lDnGIY=;
        b=SJTNPvaRxsFPUtp2MXTQN90CC2O2+FGuU0ySK0RB2HIZ+CHYl8GfdzChAVxyHY6YRo
         hoxanzfWf8weRt6ISvKWf97YJKUzvjOZQWashcJIqg+ZfOcOwNQTQ9kBJQWf0GyvDC5y
         m7WjFhhiOLH/a3cnkO7sgrdieFR2KI6dc2KMd6NjOlAPM0jkiJwzVLMJ4lBOfK/ph0jH
         ushwGloKf1POvhWhsjWngTc+BJNlYxiFu2fgoFZUlodqzypF4pAE8or+xx6OueovSVf+
         OOBEbZ8EKSWsomdySs4UojD8PsHR4QEWNz0INblnwGKpd/iZl7QKsQf0/8V6H5ErTNb0
         1ZBQ==
X-Forwarded-Encrypted: i=1; AJvYcCU3JJxu+F0bBlsBaT2kNea5ifxkGdjTlyjeji+blhHx/FFtsXFUQOzmnxksbjIhM1EyJF8=@vger.kernel.org
X-Gm-Message-State: AOJu0Yw1qc5zi3vF0zP2lO4MI75b0sXIuN58rj4IRrxEH0CGnOc7GLaR
	kwwj3waeMMZuepqllVV4bhkNjqeGUGIe/RxMpsbZNAVd3csOkA49e36b0e6m6yH11HWPzI+11u9
	fX/HxRIeot6BpSgkCQTCG1qtIAZQREsg=
X-Gm-Gg: ASbGncvRlobvUa42AXFstXdwQRAueGrSrwvAvP2FK/0CwTnRa7MdzZe+RIfzKTkyFk+
	zLjAB7bsfCkrlD38GP9YlyNlwSgujPwwMIoJN39dD7b9qsgjW+9S++xb20mr9R76e2QOoftmq5l
	E4GLva0TnyKdibEAUZtdMx0h9OOI4+e6J97xaXypFPo217wyGYok823YEzbhXJpIh5VWYy6bqO7
	uhKNL3TGj6iOoJpT0oQqHyMc1Munf4=
X-Google-Smtp-Source: AGHT+IH52fQMuI3w9nJH/7kphw+wwo54I42t2ndBQryMgJ1VYReKw0kfJbN8fKm56kl/vLX913lUkCAbMKYulAgzfV8=
X-Received: by 2002:a05:6000:616:b0:3ce:bf23:3c32 with SMTP id
 ffacd0b85a97d-4256713627fmr5462078f8f.22.1759642360048; Sat, 04 Oct 2025
 22:32:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <5a959c9bdad79cf972b95dcf4324135dd7c94dac.1752784344.git.gitgitgadget@gmail.com>
 <5596e569-6632-c2b1-37af-a978de5408cd@gmx.de> <dd3a7ab0-947b-4592-a086-8c7028f02ffd@gmail.com>
In-Reply-To: <dd3a7ab0-947b-4592-a086-8c7028f02ffd@gmail.com>
From: Yee Cheng Chin <ychin.macvim@gmail.com>
Date: Sat, 4 Oct 2025 22:32:04 -0700
X-Gm-Features: AS18NWB7KCFL4YaMt3F4A0IsPxfTALHozEKC1dxjBuO0onD0dCZA9FYVKkcwmwA
Message-ID: <CAHTeOx84BaAS1tkGdvoj1c6z+We+NobsJsTpfshw-xHn-NXGLw@mail.gmail.com>
Subject: Re: [PATCH 6/7] xdiff: conditionally use Rust's implementation of xxhash
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>, 
	"brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi, I have a different but related question. Xdiff is currently
licensed under LGPL, not GPL. With the new Rust code not having any
license header in their files, what is the intention for the licensing
for them? Given that these are derived from the original Xdiff code, I
would have imagined they would use the existing LGPL license for
Xdiff, but the lack of licensing header makes it seem like they are
just going to inherit the GPL license from Git. Is this a conscious
relicensing effort? Or just something that hasn't come up yet?
Otherwise if xdiff stops being a standalone codebase (due to it
relying on the Rust components), it would essentially mean it ceases
to be a library that could be used by other parties.

This is critical for downstream projects that use Xdiff. For example,
libgit2 mtaintains an xdiff fork, and Vim (which I contribute to) /
Neovim currently use Xdiff as the internal diff engine, which per my
understanding is only possible due to the license being LGPL (Vim is
licensed under the Vim license and Neovim is under Vim / Apache).

On Sun, Jul 20, 2025 at 3:15=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> Hi Johannes
>
> On 19/07/2025 22:53, Johannes Schindelin wrote:
> > Hi Ezekiel,
> >
> > On Thu, 17 Jul 2025, Ezekiel Newren via GitGitGadget wrote:
> >
> >> diff --git a/rust/xdiff/src/lib.rs b/rust/xdiff/src/lib.rs
> >> index e69de29bb2d1..96975975a1ba 100644
> >> --- a/rust/xdiff/src/lib.rs
> >> +++ b/rust/xdiff/src/lib.rs
> >> @@ -0,0 +1,7 @@
> >> +
> >> +
> >> +#[no_mangle]
> >> +unsafe extern "C" fn xxh3_64(ptr: *const u8, size: usize) -> u64 {
> >> +    let slice =3D std::slice::from_raw_parts(ptr, size);
> >> +    xxhash_rust::xxh3::xxh3_64(slice)
> >> +}
> >
> > I know that this is a pretty small file, but I do notice that it does n=
ot
> > have a license header.
> >
> > This reminds me of the unfortunate oversight to be careful about making
> > (and keeping) libgit.a's source files compatible with libgit2's license=
 to
> > nurture a fruitful exchange between those two projects.
>
> I'm not sure I follow your reasoning here. libgit2 was started after git
> and chose to use an incompatible license. I wasn't around at the time
> but isn't there a list of git contributors who are happy to re-license
> their contributions with the linking exception used by libgit2?
>
> > With Rust, we still have a really good chance to learn from history and
> > avoid that mistake: Gitoxide is a very exciting project with clear over=
lap
> > in its mission to implement Git functionality in Rust. Gitoxide is
> > dual-licensed under the Apache License v2 and the MIT license (see
> > https://github.com/GitoxideLabs/gitoxide?tab=3Dreadme-ov-file#license).
> >
> > Would you mind adding a license header to that file that explicitly all=
ows
> > the contents of the file to be used in Gitoxide, to get the Rust effort
> > started on a good foot?
>
> I wary of that for two reasons. Firstly over time it is de-facto
> re-licensing git as the amount of rust code grows and the amount of C
> code shrinks which deserves a wider discussion. Secondly it makes it
> harder to convert our C code which is licensed under GPL2 (or in the
> case of xdiff LGPL) to rust if the rust code uses a different license.
>
> If someone wants to start a discussion about re-licensing git (and is
> prepared to do all of the associated admin in the event that it happens)
> then by all means do so but I don't think it we want to slip such a
> change into this series.
>
> Thanks
>
> Phillip
>
>
