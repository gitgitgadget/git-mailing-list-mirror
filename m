Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5F25125760
	for <git@vger.kernel.org>; Mon, 21 Jul 2025 14:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753106922; cv=none; b=tXWl4c49XETRZfqv3ILjPZ3H/Jgbdw7jZNe+h8PKrMIjWz0m876TiqrMP9BYXkLs+x6kMVBUQwuUgrEJuDmP5mqNKeXvSTazCrZ0UuKswSljy/KOP26fyGyfanZCBZ1DD4Yts7XpOwDm3qYx1620Es26LyCRCGh7y0S4+FM+fMM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753106922; c=relaxed/simple;
	bh=XmCkTDsvE8T+OLJiKlNAhCRDy3cfsCLovsIihHN6aMA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=L3DhtSIkdSebIi3V0E3EsZizUwAC77qbFBNbq2WCgO+ghYYxM0gkl4XB8UFKbq8KdiSmtheWJZ8jgSQKAp+IF9Opn0rNntkjqDQ/Z3Lg8SG36V35hPuxH5MpddR6Uh0/ICDnRUwG/WFlEPsX/t7tsQDkzUMICNtuZ5qm5ltTDqA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=XHfnSZb3; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XHfnSZb3"
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-ae3ec622d2fso727639866b.1
        for <git@vger.kernel.org>; Mon, 21 Jul 2025 07:08:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1753106919; x=1753711719; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7jt+ml7NNWBamMzxLlXYz3aGKR2qVcIoiqRePsZC1H0=;
        b=XHfnSZb3zl+mWojvroCL4tNFODfUm89eqoe+HPt42gJq3NgL/SLkc3oV4o972SitTu
         hEiQYZWWKQNP6tttW4JNxF3RPhmiNw7bu4lGUJ/MVHIadHFX01dNTYYwssas1BoFzVQT
         6n6pqLf+Z/JAFx8YukQxgZGSX15ahyVE7ar9Pmr3g6vOh5vhmLazm+bRIpEILPeb3Ixh
         4i0sbDsOQkkXW9QD8Kd6liPDDG8ydZhJxlv1+P+gHpUGD/DIvysr57EeAAwoABplZrRM
         /4pnqGcYzrCaNPkUb5CY31aO6e5jgdGk4MXLgB5UtluMHq/+qLkyTayc+tW6OjLNrWhL
         3idQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1753106919; x=1753711719;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7jt+ml7NNWBamMzxLlXYz3aGKR2qVcIoiqRePsZC1H0=;
        b=mT25w56jVu6pF/XsYAtlnNNSjDb+x3QnSYhMkijP6nZaHBNSmpKV1QyzIR+vlA6+J4
         gzrxEEHIkd5+518RkpPXJQANYKqm4/OzeCC8momEbkwbSRWMD9AP5yCMpmvUTRj4ZnyD
         MfMz9d8svoPOFFlRYY5Lr+BVecWkiNTq9Q43qOEes6pgW02IarlxjWeuf//UXlyYFrnB
         Tbc20zlo1gIfRKhmSFOWaO1l9wN+MZvhKP4axV7zbNf/9eu7YG1pe2LX8Tm1wvtGGLUU
         Gs5FYKSkFse80/L9rFNJqg8LBvYMFbjUnwu80rmPMWazdYLUw3wCx3RI7wVbpdYoPnXA
         WQ6w==
X-Gm-Message-State: AOJu0Yw/1rQ1cqqUIcRgAgTo2BtJsnnVt0xiDz6QAlLobRi+0OE3zkqm
	B4Ap+GJ5VGZrULn0bekAEwAx1hBbHhZamsYmwQM3Fhk1+bRhqeNReUqfwnfSEHyRPOXrCxKtsTm
	2DstLz8y3R/gPA+U/krvfKZsber2Iw0Q=
X-Gm-Gg: ASbGncvCR1/mPLlbnhxadDgOP+E4tuyXYdLzPQxrjVMBI1yc9k2jBIP+ErilOSrkSjX
	H1cCiJki7CRolixyFxutr5QbLGr8PxfcTEo4Cq3J89vSUbu2Z7JutYz3M2AHJqb3IPlP9sg+Pj9
	+0HDSqsi1bK0/CXGbu4CF7COxIKV79Z7NngSNRoOYJP52BkhJ5flIaWfQetcS5QkJuB29g9y4uI
	epS7bmEa5Bc6jRzbhFI
X-Google-Smtp-Source: AGHT+IHamSCi4xQDp+qS1jHH+5NHk3aUAQjZCWB/K/yrT7owmW/PfWz2+rTMYs9vPoVjyj+VfTxbn63G6ScwpRVoyZE=
X-Received: by 2002:a17:907:2d0b:b0:ae1:f1e3:ccea with SMTP id
 a640c23a62f3a-ae9cdda2b2emr2088532066b.7.1753106918230; Mon, 21 Jul 2025
 07:08:38 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250611134506.2975856-1-christian.couder@gmail.com>
 <20250625125055.1375596-1-christian.couder@gmail.com> <20250625125055.1375596-2-christian.couder@gmail.com>
 <xmqqv7ojvjjs.fsf@gitster.g>
In-Reply-To: <xmqqv7ojvjjs.fsf@gitster.g>
From: Christian Couder <christian.couder@gmail.com>
Date: Mon, 21 Jul 2025 16:08:24 +0200
X-Gm-Features: Ac12FXyF1zM4P-AdnBVYgkMYcbLcQawdf_Q0hGKRN5UapgaAQRs14iAYODtswBE
Message-ID: <CAP8UFD0tHnYKh5QeVq_YUYrnk4yZW04_cggbGG-NC_EksHXELA@mail.gmail.com>
Subject: Re: [PATCH v5 1/5] promisor-remote: refactor to get rid of 'struct strvec'
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Patrick Steinhardt <ps@pks.im>, Taylor Blau <me@ttaylorr.com>, 
	Karthik Nayak <karthik.188@gmail.com>, Justin Tobler <jltobler@gmail.com>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 25, 2025 at 7:05=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> Christian Couder <christian.couder@gmail.com> writes:
>
> > @@ -414,11 +439,15 @@ static int should_accept_remote(enum accept_promi=
sor accept,
> >               return 0;
> >       }
> >
> > -     if (!strcmp(urls->v[i], remote_url))
> > +     if (!p->url)
> > +             BUG("bad config_info (URL is NULL) for remote '%s'",
> > +                 remote_name);
> > +
> > +     if (!strcmp(p->url, remote_url))
> >               return 1;
>
> The code seems to trust string_list enough that once an earlier call
> to string_list_lookup() in this code path finds the entry for the
> remote_name, item->util is assumed to be non-NULL and points at a
> valid promisor_info instance.  But it does not seem to be defensive
> against p being NULL, but it does so for p->url being NULL, which
> smells fishy.  Once promisor_config_info_list() reads the data from
> the configuration, do we ever update the contents and the risk of us
> corrupting p->url while we are running is great enough to warrant
> being defensive?
>
> My inclination is to suggest removing the check and BUG() here, but
> I may be missing something obvious (like "p->url gets NULL'ed out in
> this function, but then such a remote is never checked with this
> function because such and such logic in that function").

Yeah, right, if we trust promisor_config_info_list() to properly
populate the `config_info` string list (which is not modified
anywhere), let's trust it fully. So I have removed the `if (!p->url)`
check and the associated `BUG(...)`, in the v6.

Thanks.
