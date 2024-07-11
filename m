Received: from mail-qt1-f171.google.com (mail-qt1-f171.google.com [209.85.160.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 245ED16DC27
	for <git@vger.kernel.org>; Thu, 11 Jul 2024 18:14:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720721692; cv=none; b=bJlFphwdH7DvpQ8mtrtRXk+SvRULoazVow4HxWWVgs0LBsPIxiG2VOScQl54SxkyqDrbVlh82nR9WRxksCWMBqVSX9aJ+jbXD4r86F2EmkZ6tgUy1PoYEr8UR7/huBq9Log1ZP7fLd27PFVVWlHXlPV/+dywk1WBlfXmZTqaJww=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720721692; c=relaxed/simple;
	bh=gn6QCkNdz8XveiYMqDq7kshdPub05ixHgFGUiRAiBQE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=TJGg+Wmfpoe2VYvyPW5hzEe8BK0fWWcCu1zA52rMEYUaKmPjw3iCEeRJVAHinPgJjFqEQrwwrALsVUUyIwL/7bIs5Om+WXCdffim6mJW39Zw0BsJBRcNndlT6eMNBePurcHTZgI+wvpGkqHAuTHHty2jYlPP4LT8Ux0P43IaiL4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=OUNjVg5L; arc=none smtp.client-ip=209.85.160.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="OUNjVg5L"
Received: by mail-qt1-f171.google.com with SMTP id d75a77b69052e-447df43324fso33561cf.1
        for <git@vger.kernel.org>; Thu, 11 Jul 2024 11:14:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1720721690; x=1721326490; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q2V/6kbfTyUJL7++hCB+fm6Z8S56PShvLn6YYmkfZPM=;
        b=OUNjVg5Lv3jPx45UaHKwRhXLwOeuVth95gcr+GZQsqf3jZtTpZypSpO5QJqiZPXTKH
         h4XRjtO2ZL6I8qK/i6xo6yS6ucWPZTqerQC8gx5UtkovCzLUWlXYa6nyh3kFbAEjwymP
         NVvB9es63DRwU4c4KlL0I6qPRxpNLLu3aMRyaD7tCzlldv746OfQB6CzssubAhG7B8h8
         vWgTHlJ6icVjQdYzqcEoaUvUPlow3u4FUfO49CpKKzRHRbh+m9oCdMU9f7YOceRiwG/U
         WIK5H8L+pKdewFxCQaWHQDJWYBJK2A7jEVy1jVEXlzEVagn3wDta6lTxoBisQdT+98wL
         jmaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1720721690; x=1721326490;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q2V/6kbfTyUJL7++hCB+fm6Z8S56PShvLn6YYmkfZPM=;
        b=GG7J2OWnlMpdVAXrNXsqD+wMl++5MNpAiSHwyxLf/IkHFrnFCLQQgJLLn3gdfKv9j6
         wCr4F2eV2HmjkZwzbNsaUjXtg+bvn86Sidk9izBhKAM6p8P1y4Kk6HPsPsL5C7CmcXy4
         8ObOK1l8HFzV4U0T9/fn51FYXRUj40iTxpFcffPHJHaok3ZPsDH0gbm6civuQQruUxy9
         9PNYh6xfKyp/tdsu+99r+6vdND0dQf6U9GwqOxm5qkwhAO0DQ1VMewEEdH6j+KUadlD1
         fRbVCndVKMmkLcvtNxu0UwrtFAebeo5MAO4U1O0X+2lzo38ojVHCt9Poi9ooNwQ4kLvE
         qC7w==
X-Forwarded-Encrypted: i=1; AJvYcCU+oMkpjUn29sHYBlufzaDfj/9WUuoaLUZpzv5pCZ7+IARqaiG0C6ekz5g8YNNnXctgEbsbg6zshiIgMxpEEE3RE72f
X-Gm-Message-State: AOJu0YxU63BPjd9TDr4YwwXNbehUxTVaEKzQjY/QKyPz/GSJt74unp1Q
	w3pduU1Q+AuNruAx0C5AtVgEtcqxaW2bXCacnFpT2zUqXEVkLf8I5ha1ZQrRleg+MnmQRwgyT7B
	B7JZTdfeNx84sNz4mTpGhjU03OerUvK4aQh4L
X-Google-Smtp-Source: AGHT+IE8bnG72NUKQfDh8dqQ5Fd5Jprbfx/3uWUJpbOk8AFu77OKXdpuKmT6T/5Jme1BiCpYg1+hlz24cyn7uHPcupU=
X-Received: by 2002:ac8:5a93:0:b0:447:db2d:1f95 with SMTP id
 d75a77b69052e-44e7522bcfcmr123741cf.28.1720721689900; Thu, 11 Jul 2024
 11:14:49 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240709225042.2005233-1-emilyshaffer@google.com> <Zo3EvvSI999ngrLn@tapette.crustytoothpaste.net>
In-Reply-To: <Zo3EvvSI999ngrLn@tapette.crustytoothpaste.net>
From: Emily Shaffer <nasamuffin@google.com>
Date: Thu, 11 Jul 2024 11:14:36 -0700
Message-ID: <CAJoAoZmq=TyQxnVJvGxqKJj7XqvOxX4osa5Q5K4=w1NMWECBOQ@mail.gmail.com>
Subject: Re: [PATCH] Documentation: add platform support policy
To: "brian m. carlson" <sandals@crustytoothpaste.net>, Emily Shaffer <emilyshaffer@google.com>, 
	git@vger.kernel.org, "Randall S. Becker" <rsbecker@nexbridge.com>, Taylor Blau <me@ttaylorr.com>, 
	Junio C Hamano <gitster@pobox.com>, Emily Shaffer <nasamuffin@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jul 9, 2024 at 4:16=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2024-07-09 at 22:50:42, Emily Shaffer wrote:
> > Right now, this doc talks about "guarantees." I used that phrasing base=
d on
> > what I've observed to be an implicit expectation that we guarantee supp=
ort; it
> > could be this isn't actually a guarantee that the community is willing =
to make,
> > so I am hoping we can discuss it and come up with the right term.
>
> I think it might be helpful to look at what some other projects do. Rust
> has a concept of tiered support, and it requires platforms to have
> maintainers who will commit to support an OS.  I don't think we
> necessarily need to be so formal, but if nobody's stepping up to monitor
> an OS or architecture, it may break at any time and we won't be able to
> consider it when deciding on features we require from the platform (such
> as Rust, C versions, or POSIX versions).

It took me a little time to find it, so here's the link for others:
https://doc.rust-lang.org/nightly/rustc/platform-support.html

I do think it's interesting that while Rust splits their tiers based
on how much of it will definitely work (definitely builds+tests,
definitely builds, probably builds maybe), which is different from how
I sliced it by time (works on release, works on stable, works on
unstable). This kind of lines up with what you mentioned next about
the tests (or some subset) working, which I hadn't considered, either.

>
> I think it's also worth discussing what we require from a platform we're
> willing to support.  For example, we might require that the platform
> pass the entire testsuite (ignoring irrelevant tests or tests for things
> that platform doesn't use, such as Perl) or be actively pursuing an
> attempt to do so.  We may also want to require that an OS be actively
> receiving security support so that we don't have people asking us to
> carry patches for actively obsolete OSes, such as CentOS 6.  Finally,
> some sort of time limit may be helpful, since some Linux vendors are now
> offering 15 years of support, and we really may not want to target
> really ancient versions of things like libcurl.

I sort of wonder how much of this is taken care of by expressing
"fully supported" as "can run in GitHub Actions". Even if an LTS
distro is 12 years old and using ancient curl, will GitHub still be
able to run it in a VM/container? Maybe there's no such guarantee,
since you can hook up self-hosted runners (which sounds more appealing
if someone's got something weird enough it doesn't run well in a
container).

I'm not sure which of these requirements we'd want to enumerate - but
does it make sense to tack it onto the end of this doc? Something
like:

"""
Minimum Requirements
------

Even if tests or CI runners are added to guarantee support, supported
platforms must:

* Be compatible with C99
* Use curl vX.Y.Z or later
* Use zlib vA.B.C or later
...
"""

>
> At the same time, we do have people actively building Git on a variety
> of platforms and a huge number of architectures, including most Linux
> distros and the BSDs, and we will want to be cognizant that we should
> avoid breaking those environments when possible, even though, say, the
> porters for some of those OSes or architectures may not actively follow
> the list (due to limited porters and lots of porting work).  I imagine
> we might say that released architectures on certain distros (Debian
> comes to mind as a very portable option) might be implicitly supported.

Are they implicitly supported, or are they explicitly supported via
the GH runners? Or indirectly supported? For example, the Actions
suite tests on Ubuntu; at least once upon a time Ubuntu was derived
from Debian (is it still? I don't play with distros much anymore); so
would that mean that running tests in Ubuntu also implies they will
pass in Debian?

(By the way, I think we should probably just add a BSD test runner to
Actions config; we test on MacOS but that's not that closely related.
It seems like it might be a pretty easy lift to do that.)

>
> > +Compatible on `next`
> > +--------------------
> > +
> > +To guarantee that `next` will work for your platform, avoiding reactiv=
e
> > +debugging and fixing:
> > +
> > +* You should add a runner for your platform to the GitHub Actions CI s=
uite.
> > +This suite is run when any Git developer proposes a new patch, and hav=
ing a
> > +runner for your platform/configuration means every developer will know=
 if they
> > +break you, immediately.
>
> I think this is a particularly helpful approach.  I understand the Linux
> runners support nested virtualization, so it's possible to run tests in
> a VM on a Linux runner on OSes that Actions doesn't natively support.  I
> do this for several of my Rust projects[0] on FreeBSD and NetBSD, for
> example, and it should work on platforms that support Vagrant and run on
> x86-64.
>
> That won't catch things like alignment problems which don't affect
> x86-64, but it does catch a lot of general portability problems that are
> OS-related.
>
> I'm in agreement with all of your suggestions, by the way, and I
> appreciate you opening this discussion.
>
> [0] An example for the curious is muter: https://github.com/bk2204/muter.

Neat :)

> --
> brian m. carlson (they/them or he/him)
> Toronto, Ontario, CA
