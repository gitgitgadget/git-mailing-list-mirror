Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com [209.85.167.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9242798E5
	for <git@vger.kernel.org>; Mon, 27 Oct 2025 20:36:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761597375; cv=none; b=SCWbbaYWcbS+ZC0Lqt80sb4n0/L7gK54hLKK3IOPpxmuogb7/pydH8iHjTQhFL9c0QIInsvAaXYNSryn6c2aHH7XVU8xlyXpyb5Yig2LgHqclui0/eLbO8s7U16j+if8tl5FqPdAM1FJbiLk5H2zFQ1Lcho4BShgVu6x4xKCgX4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761597375; c=relaxed/simple;
	bh=6VAV77BxLGcFR+O9zVBI+8RRVnLNjklJL1Pj/WmU330=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=cvacaESOEFhsd6LzZjZggihS03IgR+Felj3PU+xMaJ8ILULVJcrAHIuLeKtktGf2+cG4W0j9SNYCGxSjo3DtBDhtn1eoctpO25gNQE48NsdSo2gpxEkDR8YToz50CfavvDQKm2GiwxtKeTvkuh/fksdXq8UihmzUYbcH9ZcLEmQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Uk7Ph/2S; arc=none smtp.client-ip=209.85.167.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uk7Ph/2S"
Received: by mail-lf1-f51.google.com with SMTP id 2adb3069b0e04-592f7e50da2so5735650e87.0
        for <git@vger.kernel.org>; Mon, 27 Oct 2025 13:36:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761597371; x=1762202171; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6VAV77BxLGcFR+O9zVBI+8RRVnLNjklJL1Pj/WmU330=;
        b=Uk7Ph/2SK085O1i97FMSBu0XmWJe+MonspvJDKQTqF92mwGTqJlaxh7XturJOZwiBl
         qnnmjoqrEPenaDixMwroSm/3WPEiPhS8GKvwwywVndCD957flN3Jzdzys2hQPHQ1I3gw
         vCnAZTBsUAMhhvh4+XEGd+MuErytFuAXaMGhTLFeLMT1MDugMd+Ij5lCLbwirFmrep7x
         VcShqVtB7mCxMixpYOxhMsU01/7V6hclPkRL2AVcHMzHP9QnBE/E41U3OOuOATiZRSCN
         L+hqOVUL9577Jaxmta2Tum27jk5ocZXYkUV4wu3auOaoPLc5y117NzSMmGDPpFZ8FiqK
         g5Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761597371; x=1762202171;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6VAV77BxLGcFR+O9zVBI+8RRVnLNjklJL1Pj/WmU330=;
        b=fgcXZTLKRsOLCw8my/Ts2190EZmfHH8uVD2XJNhCfTtJnnAYImwIZOOXSYChP2aG1p
         i1xBfXujuyUuIppidVZVQjavdVhoxdXnIlIsfWw/jLXWo4tMdtAsCiKYfv7k65PtYlWT
         MgLYrSIrlog5/K0ZjzvF//4KV59YxQf3OfK9JqDcPJ6UzFvdfZma9EqCywLSZbcKfeBO
         nfthT4os7m7xn09s012uJ8aPqdYMIJTZpALjkYvp9mUK0vg2oh2PTyH9mWC05qMUSrec
         LFeJ2jcwytjyrS0MO0C3ctQTUPhIwv61j0l0IGKuam7UKSulruNPMnV/efHyYJ8J6Ndc
         BY2Q==
X-Gm-Message-State: AOJu0Yzgtbj3yjbBsPbjfVwvadkZ4JLvFkCtBlfUm+dC+culSfoRyFBu
	iniJXHzD+OqYerYUGnbvCvNJPJUBe0IfrvO4Q0qH6hE9K7yIDV3kU7VaBAfQXEedCVxgdy9vZe5
	6ipogDtpvQy1pzGdys8EDLEPLG6G6j8k6pQ==
X-Gm-Gg: ASbGncvOIeC5ubnrXKWytIOsq0hc5i9H6b2wc7k5QJFaQYQq9JufMRbWD7Q5zWddKAR
	Z6/13lNvvp6mjpIhCr6AfAsyw+JlHiguMy829LDhrxz+TVaXfjMsOjNiyhf6IyBi4wF58lnDtRb
	fC19pPOgtBhaPDhwoSmFXMwl4efnGu7uqW7+TXnQeNScoSqXsGi/QqaYqcowptkdqHeRbkAiURQ
	8HHPe1ezmPn/D9RL9n/yerSdFMaBqDnjNtPx42EfRsTkCMIyeT40aOKPYscgg==
X-Google-Smtp-Source: AGHT+IG94ugVJShyr60kDDIbYRWvqzYzUYtaT31QjzzTU3KQVD16WKv21RBxORua8lSA+uYYRBamEe+bjNufMFQT8N8=
X-Received: by 2002:a05:6512:b20:b0:57f:492:324d with SMTP id
 2adb3069b0e04-5930edf802cmr252997e87.17.1761597370891; Mon, 27 Oct 2025
 13:36:10 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20251023-b4-pks-rust-cbindgen-v1-0-c19b61b03127@pks.im>
 <20251023-b4-pks-rust-cbindgen-v1-3-c19b61b03127@pks.im> <CAH=ZcbADTLvTioBf+LYQej1G0biZM8s3-iJG+BZjnpxj+8NjsA@mail.gmail.com>
 <aPsepOtUf92fqDL-@pks.im>
In-Reply-To: <aPsepOtUf92fqDL-@pks.im>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Mon, 27 Oct 2025 14:35:59 -0600
X-Gm-Features: AWmQ_bmgb1XtzfekE4RR4sh95iufIL4RMtou9eNnFXhgcgb08I1Eq_0S4ayh5Xs
Message-ID: <CAH=ZcbBWuS6QVQT4LsxSP-X4GupZwr+NwzXNH2+qZGoufUWDrQ@mail.gmail.com>
Subject: Re: [PATCH 3/3] rust: generate bindings via cbindgen
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "brian m. carlson" <sandals@crustytoothpaste.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Oct 24, 2025 at 12:37=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wro=
te:
> > cbindgen is a Rust crate and it should be specified in the Cargo.toml
> > under [build-dependencies] block.
>
> What is the benefit for us? The generated code is not a dependency of
> the Rust code, and neither do we use it via "build.rs". And if we use
> cbindgen via "Cargo.toml" we'd be forced to build it first, which slows
> down our CI jobs.
>
> Please let me know in case I miss any reasons to have it in our build
> dependencies instead.

You're targeting a very old version of Rust (1.49). I'm not even sure
that cbindgen will work with a version that old, but if it does then
we should use it in build.rs to make sure we're not using any features
of cbindgen that aren't available until later versions. If we use
cbindgen that is packaged with the platform then we can't precisely
control which version of cbindgen is being used. This is a matter of
reproducibility. There may be platforms that can compile Rust, but
can't generate C header files via cbindgen because cbindgen hard codes
that a certain minimum Rust version is required in its own Cargo.toml
file.

> > Also I think that we should convert from using a Cargo crate to using
> > a Cargo workspace, so that we can generate multiple header files (1
> > per crate) rather than a monolithic generated header. This is because
> > cbindgen operates at the granularity of a crate.
>
> I'm basically still punting this into the future. There is no good
> reason yet to have workspaces, so I'd rather introduce them once we have
> a better way to sell them and demonstrate their immediate benefits.

I'd like to avoid creating a gordian knot in Rust like how the
existing C code is a gordian knot. Creating multiple crates will
encourage better api design so that our code can be more modular and
easier to maintain. The reason why I don't want to put this off is
because the more we add to Rust the harder it'll be to refactor the
code to use Cargo workspaces. Let's do it now while it's still really
easy. As there is only 1 crate conceptually the code changes required
to convert it to a workspace will be very minimal.
