Received: from mail-lf1-f48.google.com (mail-lf1-f48.google.com [209.85.167.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4555A7D098
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 23:01:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752879706; cv=none; b=V8ad0X9L12PvmQgG6RLYcmpfu46R4N8iwHbHUjGpB2Cn35oIsl/n3rfAaSejeO8Fr2/i5hAJOE0UZo1hxPsOh7KNKqrujtr3G68czljuNcnajwl/vR6dx6koj4BYBe0r+sVewY6UIqWl+UU2et7TfRvNXLrDX2ZPev81aBDxzpc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752879706; c=relaxed/simple;
	bh=sBmPNmW8zK4O8dcUUEX6KE9bKO8vo6TiPhoj347UMmQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Content-Type; b=QkFRwpsOuE+gBXnm7a13M3Ng7YEfcE22tDA4yC4Kl42gwMZdfWRNCNXSoDbtybOFgAlAXWu73jN7csHrTbKAaqzie67ssO3fiJRDwpNw6pJ0wraQJtlO0N5nV66wVXH52eDdA4zlzwa/eqypaYjuQjDYphDv4p4ZEakscAbhiIs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LZ3gVBo6; arc=none smtp.client-ip=209.85.167.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LZ3gVBo6"
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-553b3316160so2688047e87.2
        for <git@vger.kernel.org>; Fri, 18 Jul 2025 16:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752879702; x=1753484502; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cc10G/dWwpu8VtAnnWrLQxEra9/ve6JvtaeBxhXyPQk=;
        b=LZ3gVBo6G/jQoqCBDIb21fw59+cROynqne9kW4iTCcIPiYtKdfbghaG8cOdIx06DY2
         p6f+kHnfPZeYiBbw8v1fb3ynfjC8x+9rG1B/lPpxfgm3axVXDAynSU4N/DMpwH+6lACd
         X26W8Ty3xI7DBSi7XLZx7NuidH42UKadlPGEi8EFA8YhBcmBA3AhzGkv5qa3rKHTI4A+
         cmD9Ek0YGgutndMsFuUeLXfaXofkp2Zy37RinS3GxrQ/4s2vBSe9YxItt5YSNow7PIpF
         92Z/8Zulur1waf1AvFbYxb3uuHMIYsi9mdWLHTUGCnpWnvND+q2qIyCa0QwWxGHdQ5Ji
         f1tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752879702; x=1753484502;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cc10G/dWwpu8VtAnnWrLQxEra9/ve6JvtaeBxhXyPQk=;
        b=eWZlbh6KVVrGiq+VYh/1GACxHQCTIPTxTn5q1sPirWLe5ptyAqrSpm2zc267VDi3sb
         JUv/1IP41B1pk5PkVPYXDC+OwDTXRIWLl0AMnCHjYsYN/yFhoTqTGSXSzzVpkLT+KNgh
         LKDqnPlCWMKb+0g02WYWJ2dizH2k9IWMYNEM6SYxkih+tmsb+u22p2VLVsGU/jyQIIja
         PQEY7SX0FK8mIEY6ygSKZoOZ690MSdGV+t2CvHyaCRN0ZaogiQImwpyRmmGZv/yxLWw3
         CFC3NdKdlGoBGkI8pRemYEMQJddWC5KX53B6sLG6isTvf16G1nJXmLzP0F4M/nDEXyJW
         Bugw==
X-Forwarded-Encrypted: i=1; AJvYcCVRt81ZobihyAKbHyvuJtaWPYBdSdMSXR4DGqa2Oh+ZdrJPoSqWgjPyeGQ7DSwzC9jIKPg=@vger.kernel.org
X-Gm-Message-State: AOJu0YyjpHaat0KAJuhFk7UB/+mebybO4CNJ1+qonK2MGuREwgNUFnW3
	XJOG1TTHKqUxHpI9FJr7GFuTkinzBOM1vXtSyFYVa7ewOMWA+MNhn55nljvvKFSX3flI4cNnZ37
	Ge0WUkSWNWL1ACk5ZEHlyh314qGynaW1dnfdaM20=
X-Gm-Gg: ASbGncuScUaHRlVmrS++xrQhUa264r8rkDR/fXgS/Bx0KLLNke2vzmFtCcJIw4LOH8r
	/keja+cLpfwSgAakVbsAbfLWvMHw40em8txfBITtnxWBEJrW3TS1gGUzTfsh6bCPZGq52uZsotr
	fsXWQyYBbShsWJJ7UhJD0OgJlANxBu7zVTULSLMKoco6QV94F51e4OI/NvqzK6GgCn+cpWD0Uau
	64Y23oq
X-Google-Smtp-Source: AGHT+IHWIUcodfCjze21R0AsQlrsZThR8ZPB6ysLmxkraVNhS2Nr6urjB/Cv7pWFWMPf3acOSYMoFwrW4hDBqOSJW9w=
X-Received: by 2002:ac2:568b:0:b0:553:2dce:3aac with SMTP id
 2adb3069b0e04-55a23eff224mr4739467e87.16.1752879701939; Fri, 18 Jul 2025
 16:01:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
 <0de0867ab44f316911bd34b9ceddbc8606e938f2.1752784344.git.gitgitgadget@gmail.com>
 <aHlp1joMwexLZAAb@fruit.crustytoothpaste.net>
In-Reply-To: <aHlp1joMwexLZAAb@fruit.crustytoothpaste.net>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Fri, 18 Jul 2025 17:01:30 -0600
X-Gm-Features: Ac12FXw3gIV_hQkQrY9qaxCiHL76muKldFicnEokDSXS8a7wo_Q3JLwK6lUeZ8M
Message-ID: <CAH=ZcbAeMv7oO-X_o_WOvgS6_igO3XAUjmgLoEfDN0CqqTMH_g@mail.gmail.com>
Subject: Re: [PATCH 7/7] github_workflows: install rust
To: "brian m. carlson" <sandals@crustytoothpaste.net>, 
	Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Ezekiel Newren <ezekielnewren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jul 17, 2025 at 3:23=E2=80=AFPM brian m. carlson
<sandals@crustytoothpaste.net> wrote:
>
> On 2025-07-17 at 20:32:24, Ezekiel Newren via GitGitGadget wrote:
> > diff --git a/.github/workflows/main.yml b/.github/workflows/main.yml
> > index 7dbf9f7f123c..8aac18a6ba45 100644
> > --- a/.github/workflows/main.yml
> > +++ b/.github/workflows/main.yml
> > @@ -4,6 +4,7 @@ on: [push, pull_request]
> >
> >  env:
> >    DEVELOPER: 1
> > +  RUST_VERSION: 1.87.0
>
> Our discussed plan is to support the version in Debian stable, plus a
> year.  So we'd be supporting 1.63.0 for a year after trixie's release.
>
> The reason for that is that people build backports and security updates
> for Git for stable releases of distros and they will use the distro
> toolchain for doing so.  Forcing distros to constantly build with the
> latest toolchain is pretty hostile, especially since the lifespan of
> Rust release is six weeks.
>
> If the Rust project provides LTS releases in the future, then we can
> consider adopting those.

The RUST_VERSION variable in .github/workflows/main.yaml had to have a
specific version. 1.87.0 was selected since that's what I was using
locally. Elijah made me aware that an older version of rust might be
desired, but didn't know which one. I'll switch to 1.63.0 or whatever
the community decides.

> > +if [ "$rust_target" =3D "release" ]; then
> > +  rust_args=3D"--release"
> > +  export RUSTFLAGS=3D'-Aunused_imports -Adead_code'
> > +elif [ "$rust_target" =3D "debug" ]; then
> > +  rust_args=3D""
> > +  export RUSTFLAGS=3D'-Aunused_imports -Adead_code -C debuginfo=3D2 -C=
 opt-level=3D1 -C force-frame-pointers=3Dyes'
>
> Can you say a little about why these options are needed and the defaults
> are inadequate?  For instance, I build with the default options both in
> my personal projects and at work and don't see a problem.

What I found is that if I have a Rust function

#[no_mangle]
pub fn call_from_c(arg: u64) {}

which is only meant to be called from C and isn=E2=80=99t called from
elsewhere in Rust, then cargo will misidentify this function as dead
code.  This was the reason for adding =E2=80=98-Adead_code=E2=80=99.

The reason for adding =E2=80=98-Aunused_imports=E2=80=99 is somewhat IDE re=
lated; if I
paste code somewhere, RustRover will sometimes automatically add the
necessary imports.  However, if I delete a chunk of code, it=E2=80=99ll
highlight the imports that are no longer used if I scroll to the top
of the file, but it won=E2=80=99t automatically remove them.  Since they
aren=E2=80=99t automatically removed, it=E2=80=99s easier to build with
=E2=80=98-Aunused_imports=E2=80=99.

The remaining arguments, =E2=80=98-C debuginfo=3D2 -C opt-level=3D1 -C
force-frame-pointers=3Dyes=E2=80=99 is to make /usr/bin/perf output more
amenable to analysis.

> I don't know if you plan to do this in a future series, but we'd also
> want cargo's tests to be run as part of CI and we'd want a lint job that
> ran clippy with both 1.63.0 and the latest stable version of Rust to
> make sure things were tidy.

Yeah I'd like that too; we can add that in a future patch series.

> --
> brian m. carlson (they/them)
> Toronto, Ontario, CA
