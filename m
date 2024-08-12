Received: from mail-pf1-f169.google.com (mail-pf1-f169.google.com [209.85.210.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 37EB554759
	for <git@vger.kernel.org>; Mon, 12 Aug 2024 21:32:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723498340; cv=none; b=PExUYDlLpES4XAHlekdS3RwAIUpwmEibEWqLzH3809/oZEdUZqYu5Bt2qgjR+UhqYHbpXYueNZqP31ck1xIW5UeJvh/bFKTmNwA37DQdbzsCVB2rfFKrn/9drqH+vDDdFUnYoliZnbkL1n2Ug8tOf9ksw5KV9hVpN6YuaMhOHEU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723498340; c=relaxed/simple;
	bh=XedLlUNDuqH//OeBOHQiO1CnsgWX89dQPjyX6EowTl0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=IDpMIN0TfU5rF5uzCpqZNwOCK8n2rk+IaD3AVgOTDfiC6nbKP2mp+/iy07eEXOLOsb0s2dNYIBIfmb7ar5CBrnyfNAae2P/gVgQxd7q5mv0nyTOm+vmaq6B1YNMmKKHKsn3p7cb9FVnevAGwqEH3WMA7sGoAh2fy8IRln659MBA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=I2WqKZiM; arc=none smtp.client-ip=209.85.210.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="I2WqKZiM"
Received: by mail-pf1-f169.google.com with SMTP id d2e1a72fcca58-7106cf5771bso3704776b3a.2
        for <git@vger.kernel.org>; Mon, 12 Aug 2024 14:32:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1723498338; x=1724103138; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=j+YhCP4s4vW6XkKePs9FIkog8z3N7eHLQzQScLqHPVQ=;
        b=I2WqKZiMc7fOUt8Y2BfxEZml2Vzntd/xrLDYzTrmYAg/C4npSgRGVUKNWDLcVi7/F8
         BeMvp5i+LP9tbbuaPWgKzmX/c2kitpu4wwTw0c7sPirxEqWqMGVWr6qm4Ldhd7Q2e+LB
         Pg1ktGdygtNJG7lfx6/37trqblzjasNAq6L9jTHCvwM534/rRX7pe66uBgl3uaCsqAkU
         1evby6qA8XY0rNHP+JPEHaamrCfE64SZUxyySOsT1Xi6TniycgxXzyPC8l6ujVYFRcKE
         sfyanDJCPPSGnuW4gLCVcOKc3Vg9Q1VvqCRfytADqMASrNlGvhsXTx65sB9U9k98450+
         XkMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723498338; x=1724103138;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:mail-followup-to:message-id:subject:cc:to
         :from:date:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j+YhCP4s4vW6XkKePs9FIkog8z3N7eHLQzQScLqHPVQ=;
        b=rCIMCdisn0Gk7Vi3SyQx5fX5RUJfLVXfcA4Z+YukD4BJO8v7ciwIeq91vnKNeObLLw
         YrQtW77yKnZPe5Cm/6C/uaFROPFTRHVbsbWjwskEafTng6Lvv5wvh0NQKAU60szgijIh
         Fdabv0aAEpN+1k/tamoMYWw8MTPnhnFa8xTqkC1EJMloAGNxvopVQepDT2HIpKePJklV
         ukbWidyrG/3ei3/fV/uyeBlb2c7ruWhFASRO4fPZzori70V7KMs81/G0bi2kz8eI3ZBe
         8AeL5NjTNvcHYbtr9Bu+7/0PSXKDhxlcH78Na233XNUmRQeAxp5wU+3N+DtmhDJ+B+T1
         oY+A==
X-Forwarded-Encrypted: i=1; AJvYcCX4yUbmM9zMiAIjFPZHXfAYST9aFRBKiLlhbIT44QkX+4yrl/uW2sGmbv1D+NkpKtg7Hp2yX+VFguU9MEY1Mcp1nnid
X-Gm-Message-State: AOJu0YwcX1TO8kKXemAOz1k3VgSKE9Zf7Ar/iE+Uxk0bFe3Y4qBT4TlR
	i1xPhy4cEFAuoUFYCEHvDsIHaRvTrP0gBCUbov6J/ovrn5wUPtUSpKa90Yzfig==
X-Google-Smtp-Source: AGHT+IH8nxueJWhT+rUXqkMqa1V4H8vM+g3cHEnHng5tcsls83RgOIGDe2DCmoJWAV5Ijro77U3jVw==
X-Received: by 2002:a05:6a00:4f94:b0:70d:3938:f1a5 with SMTP id d2e1a72fcca58-7125520bd0dmr1585733b3a.22.1723498338072;
        Mon, 12 Aug 2024 14:32:18 -0700 (PDT)
Received: from google.com ([2620:15c:2d3:204:4c2b:85dd:6293:a02c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-710e5874ef7sm4460900b3a.38.2024.08.12.14.32.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Aug 2024 14:32:17 -0700 (PDT)
Date: Mon, 12 Aug 2024 14:32:12 -0700
From: Josh Steadmon <steadmon@google.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: Junio C Hamano <gitster@pobox.com>, Dragan Simic <dsimic@manjaro.org>, 
	"Jason A. Donenfeld" <Jason@zx2c4.com>, git@vger.kernel.org, calvinwan@google.com, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com, mh@glandium.org, 
	sandals@crustytoothpaste.net
Subject: Re: [PATCH v2 0/5] Introduce cgit-rs, a Rust wrapper around libgit.a
Message-ID: <k4cokm5xtwazlv44ys2uzmrfufubbq7tcmcwzasuccog3zcojf@4ftvda4nfqxj>
Mail-Followup-To: Josh Steadmon <steadmon@google.com>, 
	Eric Sunshine <sunshine@sunshineco.com>, Junio C Hamano <gitster@pobox.com>, 
	Dragan Simic <dsimic@manjaro.org>, "Jason A. Donenfeld" <Jason@zx2c4.com>, git@vger.kernel.org, 
	calvinwan@google.com, spectral@google.com, emilyshaffer@google.com, emrass@google.com, 
	rsbecker@nexbridge.com, mh@glandium.org, sandals@crustytoothpaste.net
References: <cover.1723054623.git.steadmon@google.com>
 <cover.1723242556.git.steadmon@google.com>
 <Zrdn6QcnfmZhyEqJ@zx2c4.com>
 <6398d60387a6607398e4b8731363572e@manjaro.org>
 <CAPig+cSotr8CNZLy4xnm4qyJsuQsxjzsYMVU5sf3eeoEiE8aXg@mail.gmail.com>
 <xmqq5xs688cz.fsf@gitster.g>
 <CAPig+cSVNqBPjV3_41f6Ag2X4+-q4HidEo0D=1UaMG-Kv7pa5Q@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cSVNqBPjV3_41f6Ag2X4+-q4HidEo0D=1UaMG-Kv7pa5Q@mail.gmail.com>

On 2024.08.12 05:03, Eric Sunshine wrote:
> On Mon, Aug 12, 2024 at 4:15 AM Junio C Hamano <gitster@pobox.com> wrote:
> > The original iteration had this:
> >
> >     * bikeshedding on the name (yes, really). There is an active, unrelated
> >       CGit project [4] that we only recently became aware of. We originally
> >       took the name "cgit" because at $DAYJOB we sometimes refer to git.git
> >       as "cgit" to distinguish it from jgit [5].
> 
> A tangent: Speaking of external/other projects, I don't think we've
> seen an explanation yet as to why this Rust wrapper is proposed as a
> `contrib/` item of Git itself, as opposed to being a separate project.
> 
> I can only think of two possible reasons why they might want it in the
> Git project itself...
> 
> (1) Easier access to the library portions of Git ("libgit") since that
> portion of the code is not otherwise published as a standalone
> library. However, a workable alternative would be for the Rust wrapper
> to carry its own "vendored"[1] copy of Git. This would also ensure
> more reliable builds since they wouldn't have to worry about the
> "libgit" API changing from under them, and can adjust for "libgit" API
> changes when they manually pull in a new vendored copy. Hence, I'm not
> convinced that this is a valid reason to carry the Rust wrapper in
> Git.
> 
> (2) Perhaps the intention is that this Rust wrapper work will allow
> Rust to be used within Git itself[3]? If that's the case, then
> `contrib/` seems the wrong resting place for this code.

Neither, actually. We hope that by keeping the crate definition in the
main Git repo and by allowing developers to optionally run them by
default as part of CI and `make test`, we can catch breaking bugs as
early as possible. We're also hoping that we'll get more attention from
interested developers by staying in the main repo rather than in a
separate project.

> On the other hand, as a standalone project, a big benefit is that the
> Rust wrapper could have its own release cadence distinct from Git,
> which would likely be very beneficial since it is such a young
> (indeed, nascent) library; it is likely that the maintainers will want
> to release early and often at this stage.

AFAIK, the crate releases don't have to be strictly tied to Git
releases. In theory we could choose to publish updates to the crate
whenever "master" or any other branch is updated; whether or not that is
a good idea is a separate discussion.


> [1]: Other Rust projects carry vendored copies of projects upon which
> they rely. For instance, the "native_tls" crate has a vendored copy of
> OpenSSL[2].
> 
> [2]: https://docs.rs/native-tls/latest/native_tls/#cargo-features
> 
> [3]: https://lore.kernel.org/git/CABPp-BFWsWCGogqQ=haMsS4OhOdSwc3frcAxa6soQR5ORTceOA@mail.gmail.com/
