Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com [209.85.218.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3545C2E370C
	for <git@vger.kernel.org>; Sat, 26 Jul 2025 14:21:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753539684; cv=none; b=SeokD2xcOokWiS6knrNRYOhFjG1odTc6y93Eb9qQf1Hcb9xA9xI5mXy4UbEW5fCpqKho2vw3mw9U5IeYGoVylxM6w/QtwgOYngo1TE7LyrvAfjvanBLyxS8DumleC+C9vieryxexXGdcr9LIkfx0N0a8pvNXouw2ZwFLkD/3flA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753539684; c=relaxed/simple;
	bh=Anz1O+qrkO//BnfTM8vnTI8h160dAvzKWUJl3lBp4FQ=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=amJiWy4K4vsYMYoSkHDuhuZOZ+cXee2p1cEMvdAeH9JnhbNtvNWwmU4GbE7uG9cLsoFYLLv0ewAoKtl5m6DoM3JRb9rVTDmX5cXmd/K5QdNs6to5AhKsGWcsGOzJH48dGiHPrcU4LEEBtWnCzWpngNG7e24YhSTl8PoXEWkMnzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Rq1n4eii; arc=none smtp.client-ip=209.85.218.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Rq1n4eii"
Received: by mail-ej1-f48.google.com with SMTP id a640c23a62f3a-ae36dc91dc7so492160766b.2
        for <git@vger.kernel.org>; Sat, 26 Jul 2025 07:21:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753539681; x=1754144481; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EjBmc9WgYNf22Im2ieljCKPFXhMTz92OEsSFTy0+MOk=;
        b=Rq1n4eiiGL4zIyb/fbou48MZpkIfTjuX4iur1z6uhyHMMtJ6563usbjXHOHLr6KcQ0
         LvXuv6Pg9dps3q9TZ4ugz022UVAz+rbfS1vLbC3Ml+bxtBVX+jjplj2bpZsUSkoNoIlZ
         wHw8kknpPNWV1psLmprVixCsj8VmqwHTNy/ecjdrFiJGC63urTmhq0/bpBW5xzwGqPrb
         kI01Cpeligl7/HVzJD9JTfQMDFsMuGyUHSEcDaRorWsYjywbX5bHFWQTluyzUs9TQSaU
         KUasMSY0f1SXCwOi1E8HxtJ8hk1NqOuNPjzxO4hZ4hd8K7B0zFjaA29ExChGAruRADU5
         unDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753539681; x=1754144481;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EjBmc9WgYNf22Im2ieljCKPFXhMTz92OEsSFTy0+MOk=;
        b=gc+WkUXUKtnQgCoStnYBM3ktIlCvWMl5wL7fsf0u5cJRT5awFUozotZ1Il4a6OmjIg
         CNh6DoNN8fVyWGVn8PtRx7udYd0dPa/A8Vc2/nee0AToobu8K/nthvR89wCTXhIwRQS0
         Ghhj3UUs0pYLiJkClSz2hIJHRXBoazqWql8FpiAYhoSGLcgVvqhDF+gew1+s1PIyJGtj
         b90zMoIou1TonLMHge+VfSHIqW5sokJzBdEzjxySu4dHRTNR4+G28WXLTd3BgSF08aW5
         CuWU43AM06tNtCf7Urn4PAUcciGvZhPy4P6LBBB+eXR4O1an9BkKyM5qxMMznKzHa2zV
         cBAw==
X-Forwarded-Encrypted: i=1; AJvYcCUcWdrLMLXkS55fzQjWA9bcJ6YIHrnzwaX72CB1octTKdPm2kcBL/A8ZGmqvZjlD7sW0eo=@vger.kernel.org
X-Gm-Message-State: AOJu0YzUboTlfQtvBxGllVLi5HPn0wJdDKIbyJbGtYpEhaUIjgbkRg1J
	fNZrTTdlWr4hJv5VFb0/PpWf6wjKEqi8EVum+msFRxpYW91q+7dRMlbt3lf//b2/lrvTQCi8SAu
	YBkVMkC2UtOBboQUKCv1DQTj7Ceu6Bj+ZAHFe0zU=
X-Gm-Gg: ASbGncvwuj/oiPaqnMU43x2foK1FbpCYevcL4X6US2I8bmj9ATlkJLYWYU2SxzPjOyy
	UD09zLmu8V2DqAKXiGY+R0Qn9rQsUmClHwxpcKx8QR+QmuHCF2G/DQLEWwuNV7URyhH/aENmw21
	x7uFBTUfczX1+SapyqxhlhCCmIdj8KJT1nlVeeBr0Ut6UY3iSF5KoIGq+sktHm4uGX8QU+G0egZ
	3Ho3jNtwjrRshA/zRcfpb0m0kc19RbhBuu5p60fnw==
X-Google-Smtp-Source: AGHT+IFS+7JgFP40MLOIj9G7eli78UxDxy0W1kcpi7etoHDGMXUsHZZH02gORYVK2crFQVqqJZJk5c2EsOHKJmUEx8I=
X-Received: by 2002:a17:907:c0e:b0:ae3:4f99:a5aa with SMTP id
 a640c23a62f3a-af61c2aebabmr711272966b.4.1753539681450; Sat, 26 Jul 2025
 07:21:21 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <87y0slp23s.fsf@arch.mail-host-address-is-not-set> <xmqqecud145v.fsf@gitster.g>
In-Reply-To: <xmqqecud145v.fsf@gitster.g>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Sat, 26 Jul 2025 10:21:10 -0400
X-Gm-Features: Ac12FXz-indoUlTL2bmH6dVoJpUtrbORsvM2l8PWJu9UC_V3QRLJppkVOocBfR4
Message-ID: <CALnO6CC+Tn5xFYcHwH-M7kLNt2+gut7Okx7fCuWRdOsQHoDWFw@mail.gmail.com>
Subject: Re: A Question from a Hopeful Future Contributor
To: Junio C Hamano <gitster@pobox.com>
Cc: Eric Frederickson <ericfrederickson68@gmail.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Jul 18, 2025 at 7:16=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Eric Frederickson <ericfrederickson68@gmail.com> writes:
>
> > Looking through the repo for a place to find todo items, I naturally st=
umbled
> > upon the TODO file in the origin/todo branch,...
>
> Please disregard that file (I should remove it from the repository,
> too).  It is not curated at all, and the last update to it is more
> than 13 years ago.
>
> >> * "git status" on intent-to-add index entries (say "I" in the first
> >>   column instead of "A" for short status, add "(needs 'git add')" at t=
he
> >>   end of "new file: $path " in long status).
> >
> > I am interpreting this todo message as meaning that the following behav=
ior
> > should be implemented:
>
> I think that was done long time ago.  The entry may have been a wish-item
> in April 2011, but not anymore.

At least in 2.48.1 and in git version 2.50.0.rc0.48.g74dbe4346c, this
behavior isn't present. So I wouldn't call it "done"=E2=80=94maybe there wa=
s a
discussion that it shouldn't be done, though? I didn't search the
list.

>
> Sorry for wasting your time.  A better sources of inspiration might
> come from list archive searches for the past 3 year or so.
>
> https://lore.kernel.org/git/?q=3D%22%23leftoverbit%22+d%3A20220718..
>
> But even then, many itches have already been scratched.
>
> As is often said, in open source, the easiest is to start scratching
> your own itch ;-)
>
> Thanks.
>


--=20
D. Ben Knoble
