Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com [209.85.221.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 798353DA7E9
	for <git@vger.kernel.org>; Fri, 10 Apr 2026 16:05:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775837137; cv=none; b=dhFY6VmVQL9tESfeWt0Xb9rwWhVlGmL81C95Tvcd6mn0MwpFvrcRQWCjUvhFhWuCZlf3NVwtj0iPVJ9MHNM2GmVQtF5DMa1ZOsEseaj4FGbCnYRdpC65zTcQdyDJHa9/iXFuOjECetTdRtVDFvTAQrIHYd5hVSCvCgcz/xaqxbA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775837137; c=relaxed/simple;
	bh=S1/ylimmdOOlorrfeqRJ3Jb4Dva3l/RvTSIo/v4npCg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NxV1lW++iEFNc68jS2IJSp0eoj7jviRVh5qPa4044s6+3YfC2tISU9Fsjf2V6tbwBSJoqcVDJ2x1zpjvBdOEItP1FHAd7gOD9BoEXye02azmLNFfgTV23+rXZQg+TQdXVp5ZGm2ePmlP0FmN97V3fz7rg+tScs5+oWQdfQ43AAc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LXxIBppU; arc=none smtp.client-ip=209.85.221.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LXxIBppU"
Received: by mail-wr1-f45.google.com with SMTP id ffacd0b85a97d-43d17bb1c65so1528057f8f.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2026 09:05:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775837133; x=1776441933; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=j9KfLARwW4CYP3Bl/ir+4KM2cF/zmOhdBFbJhYRL2Tk=;
        b=LXxIBppU1n0yNeJ5KwJ6P8UQTkZ0JB4T58+tqjqrhnUKcYtxFKhPICEu6/uXyHnYiI
         J4zD0rrd2JpnFukMu7pRCVXFsvmbtH7laST5r+/ep5yWEYL4n0HOuupqaTVeNeCDg+If
         HCRu5kkMMIXBsU68pGRhXaaNxJw0Nui+rnavRkTWJx3WognNksCCjd8L0RypS2yiwnHE
         dm30Dnx3V2BFvgvMeqQEvYy/41pOeNosR/zFzjDIxbgSyaLBxhPcsAzCM7sQ3y5W6DvL
         xSEfMbjA4eFczfCOP3abPcqIPD8M8g2JnrnN+ppoo/iK0KYWW8kYVQMg7C2y1+jhWlJo
         0lZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775837133; x=1776441933;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=j9KfLARwW4CYP3Bl/ir+4KM2cF/zmOhdBFbJhYRL2Tk=;
        b=gR66bgZEGW9wqNKsb8uip07yYUxWGE3hhH1BXtlFL0NqQeyTSdSqodrZpXJQAC9PWc
         UQQVUpUy8lP7V+/aKjoAKgMkJerwGYB3I0H2tHvaX/rmUbIr2lEavzk2WxbOJBaAoWCl
         qDB1bR8p0O+uACdWOgI/kMavDXSjVXVTXnH5Kp2PKvFXvCkYwjfzWQw3wAlA45PA6Rwq
         TupWrcX5LNpbyD4KmDY8KU08hIUyqDoiaeLMDuudQ9x2s5OlebF/P5YQonfSfyovn1Yj
         O84YKV4/cMINTE60RLkxbC+AwextXLz3Iau7BuK8ZGSiwcZc/TkkGkYldfKH6+nhb97S
         s4Aw==
X-Forwarded-Encrypted: i=1; AJvYcCVgWxZ4u9LFxSEBHymDft5YDXiSHXbfziTJvqUxTKTKv9HqjUBT3behcLKtEqW3oHX8cb0=@vger.kernel.org
X-Gm-Message-State: AOJu0YyKxPTxdZ1cf6RKeUL6ZyEmEQp3h8SXGRl9PCPVeDSrEChKHHLg
	XGb3boNshIN9+FMqAWFp0ReGI6iD4bamYq2dw21xDZRaDbBREChXlLIb
X-Gm-Gg: AeBDietCW2qVqJQUqYaB8A4mdE0gkBMYEH2MYhyZFh2dfuQifkYxH9yWpG2cFi7uMK9
	HfKWwBNcbC8hRSEX3VCWYAuo69V4S3YzhZFynhp2C1eSX03XLOGOW7YfHcVDoKYOaCvuv7lRlp4
	XxpnGP6PpDcBW9od7c4CnH+2zntfPC/GKeA6eRk32WkmkQXC6PoJNsRCAdzQYIhPe3Ewma42PZB
	2+1gJE10dAO4l+pgF6WDA4V7e/AtHQdjwmQnB9zPVY8sz7rkwbuwEbtdZ0RsaropPV+wUFid4Lw
	N/hT/OWmFc/pay9NM4z7K3FwFbu+OQXkYb5NCJW7O5n+NNrWsFQx1hiYkln5xlMToQciA+o4iCO
	dknR9gpufBoMbOh4xrrNatadoeUElXuAHTg34DeHqfBtb63E+YJbXTdQFnbJizNSoJJT/18hgMr
	tUNPtodXCLIqcnv3qR84mzjeVQ9OYPYOk2lA4Yv7DYmDM/s1TiVkLp
X-Received: by 2002:a05:6000:1847:b0:43c:f52b:7ff6 with SMTP id ffacd0b85a97d-43d642c09d8mr5633780f8f.37.1775837132557;
        Fri, 10 Apr 2026 09:05:32 -0700 (PDT)
Received: from localhost (62-165-238-49.pool.digikabel.hu. [62.165.238.49])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43d63dec07esm8771820f8f.13.2026.04.10.09.05.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Apr 2026 09:05:32 -0700 (PDT)
Date: Fri, 10 Apr 2026 18:05:31 +0200
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: phillip.wood@dunelm.org.uk
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org,
	Junio C Hamano <gitster@pobox.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Subject: Re: [PATCH v3 8/8] meson: precompile "git-compat-util.h"
Message-ID: <adkfy4OgGKlJnd5c@szeder.dev>
References: <20260319-b4-pks-build-infra-improvements-v3-0-82f5fb3edc3f@pks.im>
 <20260319-b4-pks-build-infra-improvements-v3-8-82f5fb3edc3f@pks.im>
 <adkZGavssyxWj27a@szeder.dev>
 <0b67d2fb-3041-4fed-9002-44b7b2e7ecd3@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <0b67d2fb-3041-4fed-9002-44b7b2e7ecd3@gmail.com>

On Fri, Apr 10, 2026 at 04:46:43PM +0100, Phillip Wood wrote:
> 
> 
> On 10/04/2026 16:36, SZEDER Gábor wrote:
> > On Thu, Mar 19, 2026 at 06:33:27AM +0100, Patrick Steinhardt wrote:
> > > Every compilation unit in Git is expected to include "git-compat-util.h"
> > > first, either directly or indirectly via "builtin.h". This header papers
> > > over differences between platforms so that we can expect the typical
> > > POSIX functions to exist. Furthermore, it provides functionality that we
> > > end up using everywhere.
> > > 
> > > This header is thus quite heavy as a consequence. Preprocessing it as a
> > > standalone unit via `clang -E git-compat-util.h` yields over 23,000
> > > lines of code overall. Naturally, it takes quite some time to compile
> > > all of this.
> > > 
> > > Luckily, this is exactly the kind of use case that precompiled headers
> > > aim to solve: instead of recompiling it every single time, we compile it
> > > once and then link the result into the executable. If include guards are
> > > set up properly it means that the file won't need to be reprocessed.
> > > 
> > > Set up such a precompiled header for "git-compat-util.h" and wire it up
> > > via Meson. This causes Meson to implicitly include the precompiled
> > > header in all compilation units. With GCC and Clang for example this is
> > > done via the "-include" statement [1].
> > > 
> > > This leads to a significant speedup when performing full builds:
> > > 
> > >    Benchmark 1: ninja (rev = HEAD~)
> > >    Time (mean ± σ):     14.467 s ±  0.126 s    [User: 248.133 s, System: 31.298 s]
> > >    Range (min … max):   14.195 s … 14.633 s    10 runs
> > > 
> > >    Benchmark 2: ninja (rev = HEAD)
> > >      Time (mean ± σ):     10.307 s ±  0.111 s    [User: 173.290 s, System: 23.998 s]
> > >      Range (min … max):   10.030 s … 10.433 s    10 runs
> > > 
> > >    Summary
> > >      ninja (rev = HEAD) ran
> > >        1.40 ± 0.02 times faster than ninja (rev = HEAD~)
> > > 
> > > [1]: https://gcc.gnu.org/onlinedocs/gcc/Precompiled-Headers.html
> > > 
> > > Signed-off-by: Patrick Steinhardt <ps@pks.im>
> > > ---
> > >   meson.build         | 2 ++
> > >   tools/precompiled.h | 1 +
> > >   2 files changed, 3 insertions(+)
> > > 
> > > diff --git a/meson.build b/meson.build
> > > index cd00be1c23..2002f4795e 100644
> > > --- a/meson.build
> > > +++ b/meson.build
> > > @@ -1760,6 +1760,7 @@ libgit = declare_dependency(
> > >         c_args: libgit_c_args + [
> > >           '-DGIT_VERSION_H="' + version_def_h.full_path() + '"',
> > >         ],
> > > +      c_pch: 'tools/precompiled.h',
> > >         dependencies: libgit_dependencies,
> > >         include_directories: libgit_include_directories,
> > >       ),
> > 
> > Well, I don't do meson, but...
> > 
> > If I understand this right, this section here compiles all the source
> > files listed in "libgit_sources" using our new precompiled header.
> > But "libgit_sources" contains all source files under "reftable/",
> > which, with the sole exception of "reftable/system.c", don't include
> > "git-compat-util.h".
> > 
> > Now, building the reftable sources with "git-compat-util.h" included
> > through the precompiled header apparently didn't cause any compilation
> > errors...
> > But I think that's just accidental, and if a source file doesn't
> > include "git-compat-util.h", then it shouldn't be compiled with the
> > precompiled header.
> 
> FWIW I agree it would be better to keep the same includes when building with
> precompiled headers. There is some discussion about this starting at
> https://lore.kernel.org/git/2fe87868-dff5-4b3a-95e3-d4b6376b59ed@gmail.com/

I'm not sure that "oh look, it didn't break, so it must be good" is
the right approach...

And why was this not mentioned in the commit message?!  Sigh...


