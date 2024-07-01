Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F47915DBD5
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 13:18:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719839895; cv=none; b=T+ImIYS/hIvPXxbhPejCCQuqRDxUEHWRlplnlUOBwV9oxlj1ROXbS2Cq7YgJ55DNk4KQu4MLg1svSqrKeBuNxC2hS95q0W+kfXVXxDkWW/u3GJUCLUAc7i+u3ni917ZOSsu+jnRon3+1LVWuIsvJZUMcvEL0CZCr0JvgIUndc50=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719839895; c=relaxed/simple;
	bh=SDbEV0FT3a3mGmgMX21/AoB/J2kYEHZpYBhO51zG1LM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=pgGsu2r8sRnXJXHoTmBXy1o+5NwmC6zirFLEGVsOGQTrQ2o0+ZOSfFcHANP6RppSmR81rxzi8bHmwAjXo2gyEJTk1GGu2KhjM4gQGQRgle9/s9Rxdc7vW8lKYJznaF2kDGM/kRd1grZEDDGKUnM6pJ5+JQR2itk4Ksdtdmr1cnk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dk0g0Oh4; arc=none smtp.client-ip=209.85.208.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dk0g0Oh4"
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-57d15b85a34so317187a12.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 06:18:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719839891; x=1720444691; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dvsUZKGXc0EKQp+4H7rQXE7Ssn14Wocp3tIfwWcUAQA=;
        b=dk0g0Oh4PSL8qCK44bd/aUsREi3Ge5iaLoRv120qsNVCqVgW7t6ruK/EYmHFcfjeVN
         98DTp0VFEmNmyE7fcdKvEj0QSfJtCTx1jxHbmyd9v/K4F3d5J6iAtoMW2aAwgR/0iCex
         56ShUiXJfMGK3Nw7y6O9cdXcBB9r4VJKZ2UqvDQ5268wrC1F3fZM+xokWR4fq5Hg4tMt
         eJpmeJ6tTEPQNIpreuuwrkSC3RQHYrmpHJ2Tub8Y2t7pKG9YB0mrqO4U4f0ZCyZbpQN3
         mrzPx/Um82DlnhCyMSgpWxhwNQ7gvOlYAJP4zku8pgkNOnHdc8E1cMvLYnT3coZDK+hz
         wV+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719839891; x=1720444691;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dvsUZKGXc0EKQp+4H7rQXE7Ssn14Wocp3tIfwWcUAQA=;
        b=dEjfKS+aN/tJU8MxalUnE3hgDn8MNVGwws8EVsHWhzS9s5JShlPvHaEqo58geUfixi
         r7T2wS7AGTwNWxvIaVbYV3ZMiUFexgJkmRTwFKs0iy1/Y7suaB29Ffw7NQ2iyEEBxWmo
         O9R225dK95VwDypLWXUnIcl+bj67J+RUhK6AWjfPmyAl+AjwyYvnjod1zp3SC6mQYjCQ
         4HMHwf5HtZD8MdMgRE94AXcIYNhp63raw4LguGQR2O/N1BcDaIO4gQ0Mf/zcZuF2A1p+
         B6CoK7+zdz/yYSQWMHKLk3p6ml+A6PGpfINCXkZQodRWN1BYJQghyqYxG79V0dQ/MQgM
         HguA==
X-Gm-Message-State: AOJu0YwlASsj6zPY20SPzOKu1DCmIteXs0wMs04yeKRSTciCumFnSGoH
	Odm/zb8bgMl0F/naSVr2/xrfSdyZ0AfVUrslZl1HcwS3QMp217wk4iczZyPbGBxAGwbVjUbIRGv
	+Q6uxMOv1S/knVrukUAFN4xxgSRY=
X-Google-Smtp-Source: AGHT+IEs45N6pkdTejEdbmoFI1xNO34lylBNDSGp5fYcE0g13mYOS75qc8zA3aCAX1yr+kNnFOdUTrzXGim+kwyNlmA=
X-Received: by 2002:a17:907:77d6:b0:a72:8323:4298 with SMTP id
 a640c23a62f3a-a75144a8a24mr283775366b.68.1719839891272; Mon, 01 Jul 2024
 06:18:11 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240628063625.4092-1-chandrapratap3519@gmail.com> <20240628063625.4092-11-chandrapratap3519@gmail.com>
 <CAOLa=ZRx6LQ26U-00UUttjo7sitLZ+gWA7FX0m3p1nQGhGF7Zw@mail.gmail.com>
 <CA+J6zkSfGrfpgAMdm_zHX9C0vhpv_802O487WgbB5XXMw1Mc=g@mail.gmail.com> <CAOLa=ZTsA624-T_Kqh3Nn9+_arCg93r-re3qHN9MGibgBP+LLQ@mail.gmail.com>
In-Reply-To: <CAOLa=ZTsA624-T_Kqh3Nn9+_arCg93r-re3qHN9MGibgBP+LLQ@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Mon, 1 Jul 2024 18:47:56 +0530
Message-ID: <CA+J6zkRxcZtuFkeXXtzEtLLd94TDbVzMRRbSUKaqbS+YuriQhQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] t-reftable-record: add tests for reftable_ref_record_compare_name()
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 15:21, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>
> > On Mon, 1 Jul 2024 at 00:29, Karthik Nayak <karthik.188@gmail.com> wrote:
> >>
> >> Chandra Pratap <chandrapratap3519@gmail.com> writes:
> >>
> >> > reftable_ref_record_compare_name() is a function defined by
> >> > reftable/record.{c, h} and is used to compare the refname of two
> >> > ref records when sorting multiple ref records using 'qsort'.
> >> > In the current testing setup, this function is left unexercised.
> >> > Add a testing function for the same.
> >> >
> >> > Mentored-by: Patrick Steinhardt <ps@pks.im>
> >> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> >> > Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> >> > ---
> >> >  t/unit-tests/t-reftable-record.c | 23 +++++++++++++++++++++++
> >> >  1 file changed, 23 insertions(+)
> >> >
> >> > diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
> >> > index 55b8d03494..f45f2fdef2 100644
> >> > --- a/t/unit-tests/t-reftable-record.c
> >> > +++ b/t/unit-tests/t-reftable-record.c
> >> > @@ -95,6 +95,28 @@ static void test_reftable_ref_record_comparison(void)
> >> >       check(!reftable_record_cmp(&in[0], &in[1]));
> >> >  }
> >> >
> >> > +static void test_reftable_ref_record_compare_name(void)
> >> > +{
> >> > +     struct reftable_ref_record recs[14] = { 0 };
> >> > +     size_t N = ARRAY_SIZE(recs), i;
> >> > +
> >> > +     for (i = 0; i < N; i++)
> >> > +             recs[i].refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
> >>
> >> This needs to be free'd too right?
> >>
> >> So we create an array of 14 records, with refnames "00", "01", "02" ...
> >> "13", here.
> >>
> >> > +
> >> > +     QSORT(recs, N, reftable_ref_record_compare_name);
> >> > +
> >>
> >> We then use `reftable_ref_record_compare_name` as the comparison
> >> function to sort them.
> >>
> >> > +     for (i = 1; i < N; i++) {
> >> > +             check_int(strcmp(recs[i - 1].refname, recs[i].refname), <, 0);
> >> > +             check_int(reftable_ref_record_compare_name(&recs[i], &recs[i]), ==, 0);
> >> > +     }
> >>
> >> Here we use `strcmp` to ensure that the ordering done by
> >> `reftable_ref_record_compare_name` is correct. This makes sense,
> >> although I would have expected this to be done the other way around.
> >> i.e. we should use `strcmp` as the function used in `QSORT` and in this
> >> loop we validate that `reftable_ref_record_compare_name` also produces
> >> the same result when comparing.
> >
> > The first parameter to QSORT is an array of 'struct reftable_record' so I don't
> > think it's possible to use strcmp() as the comparison function. We do, however,
> > use strcmp() internally to compare the ref records.
> >
>
> Well, yes, not directly, but you can create your own function and pass
> it to QSORT. This will mostly replicate what
> `reftable_ref_record_compare_name` is doing. But I think you're missing
> what I'm trying to say however.
>
> I'm not really talking about the semantics of it. I'm talking more about
> the concept of it. See the next section...
>
> >> > +
> >> > +     for (i = 0; i < N - 1; i++)
> >> > +             check_int(reftable_ref_record_compare_name(&recs[i + 1], &recs[i]), >, 0);
> >> > +
> >>
> >> Also, with the current setup, we use `reftable_ref_record_compare_name`
> >> to sort the first array and then use `reftable_ref_record_compare_name`
> >> to check if it is correct? This doesn't work, we need to isolate the
> >> data creation from the inference, if the same function can influence
> >> both, then we are not really testing the function.
> >
> > The validity of `reftable_ref_record_compare_name()` is checked by the first
> > loop. Since we're already sure of the order of 'recs' at this point (increasing
> > order), this loop is supposed to test the function for ' > 0' case.
> >
>
> Yes, the first loop uses 'strcmp' to validate and that's perfectly
> correct. But this operation here is kinda pointless in my opinion. My
> point being that if there is a list x[] and you use a function f() to
> sort that list, validating that x[] is sorted with f() again, doesn't
> test f().
>
> It might be much simpler to just test
> `reftable_ref_record_compare_name()` as so:
>
>     static void test_reftable_ref_record_compare_name(void)
>     {
>         struct reftable_ref_record recs[3] = {
>                 {
>                         .refname = (char *) "refs/heads/a"
>                 },
>                 {
>                         .refname = (char *) "refs/heads/b"
>                 },
>                 {
>                         .refname = (char *) "refs/heads/a"
>                 },
>         };
>
>         check_int(reftable_ref_record_compare_name(&recs[0], &recs[1]), ==, -1);
>         check_int(reftable_ref_record_compare_name(&recs[1], &recs[0]), ==, 1);
>         check_int(reftable_ref_record_compare_name(&recs[0], &recs[2]), ==, 0);
>     }

I agree, this seems much simpler than the dance we have to do when
using qsort. I'll reimplement this and the 'log_compare_key' test with
hard-coded input instead of qsort.

> >> > +     for (i = 0; i < N; i++)
> >> > +             reftable_ref_record_release(&recs[i]);
> >> > +}
> >> > +
> >>
> >> Nit: The top three loops could possibly be combined.
> >
> > The limiting as well as initial value for the array indices are all
> > different so I'm not sure how to go about this.
> >
> >> >  static void test_reftable_ref_record_roundtrip(void)
> >> >  {
> >> >       struct strbuf scratch = STRBUF_INIT;
> >> > @@ -490,6 +512,7 @@ int cmd_main(int argc, const char *argv[])
> >> >       TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
> >> >       TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
> >> >       TEST(test_reftable_obj_record_comparison(), "comparison operations work on obj record");
> >> > +     TEST(test_reftable_ref_record_compare_name(), "reftable_ref_record_compare_name works");
> >> >       TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
> >> >       TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
> >> >       TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
> >> > --
> >> > 2.45.2.404.g9eaef5822c
