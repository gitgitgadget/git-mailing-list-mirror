Received: from mail-io1-f54.google.com (mail-io1-f54.google.com [209.85.166.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48D18946C
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 01:59:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758592799; cv=none; b=ukNcxr6cQJRuHIv4dHyFMeGmSGhLWDJhIEHUHjLibGJa7JF9kIC2H69FEtPuxY/ped/QEN8/rV8HmAcgSI0Fe6WYW8R7EocOFZKty9dnKKwUG1HghKnSZPytfgjtzAsR0jvsTakJR61Zj+kM1V3YpTMHWs1P49P1uhNWuD+vrb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758592799; c=relaxed/simple;
	bh=PqAlTO+/crEsJJAS6jentCZoZwNP85CgWITtWboYhR4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=HRCckfWXFEq20vWbPPHD+xGvNhFLF0xXrbrSoXNdGCz3SEiV0Ai+B39Vkl2banFrgm9ESO0Hgk7OWw1P6f2vsb6G0A8ebO/zgFTb9gynbMA9fph3V5sfrOi0tGYuqjmfYwyOii6SuxAjJ8Bhvfqm1X0vvfURm9QO7KAbaY9HzxM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=e+f/fJdL; arc=none smtp.client-ip=209.85.166.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e+f/fJdL"
Received: by mail-io1-f54.google.com with SMTP id ca18e2360f4ac-8ca2e53c0d3so62381039f.1
        for <git@vger.kernel.org>; Mon, 22 Sep 2025 18:59:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758592797; x=1759197597; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gzjhJS+7kd7OtAKNHIGT/EC9rB9t1g3LqnEY83nKAUY=;
        b=e+f/fJdL5p7KVR+01heXS1AXAo53ntH4BDT3Htcpn31bTmA5Hwq2oIJWeWyTahedpR
         BA2Ep6McodoBvBzI5RXsgHEGJmoodxny5SxBYDo+mc4YtFNg+aYibGS2KN3Ic32eqyjy
         1fbYN50LMoERXOiJ+ZuZeDl76LmoihVgcLqTgKXPnuHsRAsayel+PQdwpC5SV046/LkL
         aXXQYbrB9pgIZnAJeebTPonZJbXbo7qsulcOyF2L8YB0uFh9P7SS/6QFYARbO/4pAsf5
         9I+UmJpD+IE/Kc3lAkfvkPWPuteCgMTQV7l8MlpYzO9HgVBRWgpiXCsvcZjJ75lS3wB2
         FmdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758592797; x=1759197597;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gzjhJS+7kd7OtAKNHIGT/EC9rB9t1g3LqnEY83nKAUY=;
        b=SWXgBjZnqKIXZ36z1xi02RL5NpliDT/T6oLQEQv+btYFya5jV3MO+bbji+LOb7TItX
         CIwqobMzZkyQpIAj7BTUeQUH+i7HeH/jagiomNvJ1Dz9RH+Pc7qfyRFgi9Vl4ZxAkv/k
         84nCZ+4bVpaCiYDO5Qa0q4oBo6/clfbMTt23khcxEhnfOG9L7EpsNtCeNzcbd4/4V+jk
         wR2qXDMM0ORouPePDzng2APeqJx5YlAVE+s6WMlRXE5xun1rC1zeab2WT4mEAX6T/YBe
         Jo3me8a+chcGOoMUq1/PXUxmVV/z8JAoxdJEr8CCc0leM+RvnQo0EsnbuRX5bYZQHUcn
         5p4w==
X-Forwarded-Encrypted: i=1; AJvYcCVsLssXghZJ47M70n06ANV5+o+Reg4vkNCcliSuONMKJLkzvONjLCaEENqWJdSBWvrFJUY=@vger.kernel.org
X-Gm-Message-State: AOJu0YzMtoMi8GOtylqzgrtWzLoWOWVbvILsncEroXvDeDn+Skg8hhg5
	jM2AgetBY8hmJkS7LzArLf5QOrYsUVxNQfB7i8Upfv9L98cxJQOvCN98DP+BHC4wq1P38s/b/En
	5IkoQYGbzsZoOyYmyX2je4nXep9ATVLo=
X-Gm-Gg: ASbGncu8nkndEoJ9RqzvNeyTXIJVzFBAzWeAcdlWTBzhjjobEJeaqPewnLym7nVs0ua
	530W/Xikaa54uBo15LlH3WlYRqyEFveWixzBpLInYQMUzlkirAzR9SneYAVyxjfOx4GjkAjIW8Q
	6LTukahfDaI8A9WNZv7bhQ66KaMzfRQ6I8PGXwQC0PcKEHQgVAm5La7dWM8rNSqQa2cQhTI2EJU
	oBdbkOeiV9VrfodJ8Tk9n5cykVDzRUJ0vaq6Q0=
X-Google-Smtp-Source: AGHT+IHHeRlpv3hn6CpR+D4SCshM63c+jbMi+o4JAQKc6/x25Sb/B1+Ns++eb8HAEbm7hbA6AcRcoMbi4v6ci3y/G4g=
X-Received: by 2002:a5e:d70f:0:b0:887:55f8:5dea with SMTP id
 ca18e2360f4ac-8e202079815mr141095339f.14.1758592797217; Mon, 22 Sep 2025
 18:59:57 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250915-b4-pks-rust-breaking-change-v5-0-dc3a32fbb216@pks.im>
 <20250915-b4-pks-rust-breaking-change-v5-7-dc3a32fbb216@pks.im>
 <aMsxhp6ZO2Cdz7+k@szeder.dev> <aMteF4VTq2C5sAhK@fruit.crustytoothpaste.net>
 <aNGkt/DdnbjNu3s8@szeder.dev> <xmqq348etd9n.fsf@gitster.g>
 <aNHKdFkiGLPcLEjP@fruit.crustytoothpaste.net> <xmqqplbiqeol.fsf@gitster.g>
In-Reply-To: <xmqqplbiqeol.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 22 Sep 2025 18:59:46 -0700
X-Gm-Features: AS18NWBbJFbFhXIAVE4lsIxDLJ6nS8QOJODn-dLqwww_0826HaFG3hM_a2KQ5z4
Message-ID: <CABPp-BFd4T4sJV=3uB_vfvSddQWeAdr=2x4T8i61VQHWJMW=tA@mail.gmail.com>
Subject: Re: [PATCH v5 7/9] BreakingChanges: announce Rust becoming mandatory
To: Junio C Hamano <gitster@pobox.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>, =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>, 
	Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org, 
	"Haelwenn (lanodan) Monnier" <contact@hacktivis.me>, Ben Knoble <ben.knoble@gmail.com>, 
	Christian Brabandt <cb@256bit.org>, Collin Funk <collin.funk1@gmail.com>, 
	Eli Schwartz <eschwartz@gentoo.org>, Ezekiel Newren <ezekielnewren@gmail.com>, 
	Johannes Schindelin <Johannes.Schindelin@gmx.de>, Phillip Wood <phillip.wood123@gmail.com>, 
	Pierre-Emmanuel Patry <pierre-emmanuel.patry@embecosm.com>, Sam James <sam@gentoo.org>, 
	Taylor Blau <me@ttaylorr.com>, Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Sep 22, 2025 at 3:56=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
> >> [Footnote]
> >>
> >> * By the way, I _think_ I never saw that policy document until
> >>   Ezekiel started his topic and sent it out as one of the component
> >>   patches; how did it get there from brian to Ezekiel's topic?
> >
> > I had it in a branch of mine that I was going to submit at some point
> > and I mentioned it to Ezekiel, who modified it and incorporated it.  Th=
e
> > original branch should be `rust` on my remote for those who are
> > interested.
>
> I figured that something like that happened.  I was mostly
> interested in how firm those original authors supported the version
> with Ezekiel's changes, as outsides would not be able to telll how
> extensive the change were.
>
> Thanks.

Footnote 1 of https://lore.kernel.org/git/aHlwZPbiKnakMN75@fruit.crustytoot=
hpaste.net/
