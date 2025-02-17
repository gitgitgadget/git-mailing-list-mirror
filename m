Received: from mail-ua1-f43.google.com (mail-ua1-f43.google.com [209.85.222.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03D3F1547C3
	for <git@vger.kernel.org>; Mon, 17 Feb 2025 10:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739786720; cv=none; b=C1+C1Q19jP/bGpeGClxEsJpgpDBKtroiRKCDT1cb9g4VC9ZKqjGUIe3Apk7UWZOXk3/tvxQSx5Jc0YAt08OsMZ5xvzQbW1GT4xYaORxleh93RebHYgfCNi9A2VSrszItXRNigWVFK2mV1WqeghjVnyzJq1t/nBH+MiVDRyz/qZE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739786720; c=relaxed/simple;
	bh=yHGfcSiKOy+UZodVmvJqRq9BtVbIuFhUGdbqb80MVa8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Zkf98oBVRVDY9nPTUzC+4ERITS/KVytg0QF8nsbFn/hh/KuMd5gImdcC+VDMr5vrmPQrkUEH8SMAHIUbV3uWn1c3qxTFDlsLvwga9KwMKI0I/x9KKDxEZaAMl74owDoPOmKimRGA2xvRbiKYmjivmSAeEjuWDIG01DYexEoPfPE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cGwE77ss; arc=none smtp.client-ip=209.85.222.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cGwE77ss"
Received: by mail-ua1-f43.google.com with SMTP id a1e0cc1a2514c-868f19a9421so2252850241.2
        for <git@vger.kernel.org>; Mon, 17 Feb 2025 02:05:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739786718; x=1740391518; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fYVb68/pShaeCCxGxHn9viyXxLaMO5p7x4KYAShyV1M=;
        b=cGwE77ssFYk+EreSNomS1uxIg71RRcTDZiEtMRir4O9UlapkKopyd6yaMxbxr+azK1
         iyEDvuyGKMs1ufkCsBsuOA5YKrRK0aMiTDzOMzEMXLRLffdBdp6q3Hj15KFZSLEiqsXz
         nAUcbRGj302VZnZcGSEg5qlOdPPTDq+n8XDNy4bBc1R2NPyMkxh1Q4fj3MuBb/X0DC3x
         DaUDZVStL9j1wwu7MNk8Vw/00l7KpZVjsRoMvhkNZyXidLjr8jnECMxQdXQOowttcbDC
         CPiZM5D4mghw8xUbte3o1hzoSRB6rP1Yw9Q9evmt+Firs/x56u1dkvXaHxBrmVkI8j06
         QgUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739786718; x=1740391518;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fYVb68/pShaeCCxGxHn9viyXxLaMO5p7x4KYAShyV1M=;
        b=A7lUjgASVP5Upe8m2wAcvu2Hm5iFnVkSfNEf/exth8p6ogndiXu/moO/EqHpqprBwH
         vomoXlC08dmvxbDwXDHOVrWoSWG4nYyzb+VXfU5M7rL0SxH2LyXzptRT9IqHJyv8pdU6
         xX8rHhB4AZoRTU3sxR/Dg5Lpq10kwD7vv0qfL2X81dg9RVjxfJ5qJ1cRpl9OJmNDd9Yk
         sNvlFwI2dI8nYhH7UMXJyi4O4U1SUUUd0pzxi0AEGzNH5JwMT8J5z8PW8igVoDTvXU+r
         bIMhjWR/JJ7VDvtTwxvviYzd1Oy0yVLUrpyA/U6ztp3SrQlVaLExVHIwW882FwF1M4Mo
         UZnw==
X-Gm-Message-State: AOJu0YxwIt3QEOnVkND/UQzu64d7M7XdoobwtAcadsbxvmVo096dakbD
	BbSrtOORd4vRodJQ46fhOCb7qraDtugNnFuoA3ajI2KKRLgMUbLjKYL3V5xctoA6F65k4bSz8dl
	8ynlfTG/DuvnV3Pkh1/FjECZAG78=
X-Gm-Gg: ASbGncupskWvtQIBWUAZGM8dvjQbAx+EafruV3RVSwq5RQsjRkDJtiqFkB9sKJjC4af
	SKvb7wCq9lFrnhTCeHKCosk7cFuwQNI7FKmrF/3cNFX8y0LLzznNHBqWUnbNB0jvyRzUj/SFz
X-Google-Smtp-Source: AGHT+IG8AuMlmjrp9dDOhUFODp5YhNNOX+MWNvNSjJFvyyYZVpcuQLhskegaR6M7mJyMN029veauKQz9Pl30wbB1KyM=
X-Received: by 2002:a05:6102:5128:b0:4bb:e80b:473d with SMTP id
 ada2fe7eead31-4bd3fca4bf5mr3914880137.6.1739786717843; Mon, 17 Feb 2025
 02:05:17 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250214230210.1460111-1-usmanakinyemi202@gmail.com>
 <20250214230210.1460111-2-usmanakinyemi202@gmail.com> <Z7LdauBUSfqvyvXv@pks.im>
In-Reply-To: <Z7LdauBUSfqvyvXv@pks.im>
From: Usman Akinyemi <usmanakinyemi202@gmail.com>
Date: Mon, 17 Feb 2025 15:35:05 +0530
X-Gm-Features: AWEUYZn0asaWETGT4n-8rAtzic9j2V3IGT1lwn0io0jNvgHgwEdyUXcNILfSqWw
Message-ID: <CAPSxiM8vcH_csM21vtF11APtxfNy_QC91mfYkctaSP-8TyPmyA@mail.gmail.com>
Subject: Re: [PATCH 1/7] builtin/verify-tag: stop using `the_repository`
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, chriscool@tuxfamily.org, christian.couder@gmail.com, 
	johncai86@gmail.com, shejialuo@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 17, 2025 at 12:25=E2=80=AFPM Patrick Steinhardt <ps@pks.im> wro=
te:
>
> On Sat, Feb 15, 2025 at 04:27:17AM +0530, Usman Akinyemi wrote:
> > @@ -35,7 +34,8 @@ int cmd_verify_tag(int argc,
> >               OPT_END()
> >       };
> >
> > -     git_config(git_default_config, NULL);
> > +     if (repo)
> > +             repo_config(repo, git_default_config, NULL);
> >
>
> I recently noticed that we have `usage_with_options_if_asked()`. Should
> we use that function rather than making the call to `git_config()`
> conditional? Otherwise it's not obvious why we have the conditional in
> the first place.
Hi Patrick,

I think the function is `show_usage_with_options_if_asked()`. The function
is quite different from `git_config()` or the `repo_config()`.  The
config function
consults the configuration file for setting up config values and it
uses the `repo`
variable during this. While `show_usage_with_options_if_asked()`
is used when the "-h" option is passed to the builtin functions to display
the help string.

In a case when "-h" is passed to the builtin functions which use the
RUN_SETUP macro,
the `repo` config will be NULL.

There are some builtin commands functions that which has
the`git_config()` function
comes before `show_usage_with_options_if_asked()` or it's variant and
some, `git_config()`
comes after.

For those that have `git_config()` comes after
`show_usage_with_options_if_asked()` , no need for the check, since
the
 `show_usage_with_options_if_asked()`call will exit without reaching
`git_config()`. For scenario where the `git_config()`
comes earlier, we have to check the `repo` to see if it is NULL, if it
is NULL, we are sure this happens when the "-h" is
passed to the function and we do not need to setup and configuration
since `show_usage_with_options_if_asked()`
will exit.

So, the condition is necessary else, NULL value will be passed to the
`git_config()` which will lead to accessing NULL
value.

Thank you.
>
> The same comment also applies to subsequent commits.
>
> Patrick
