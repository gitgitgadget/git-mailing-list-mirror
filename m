Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE3C07D08D
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 07:27:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719818833; cv=none; b=HsDYJvEX+qWlcuoE9OzCOFfC9TYe5vHql/FsJ2NdA3u1nBUX009DiI/njKA0wFDoyW6sBdQ2BP/k2IB8kaqsVBkdjEFp5Erna/lJZCppTadESTOJ9bAABevyP8/SSz68wBqGOv0cIb63XSqmKgtuPBXEcOe9Bj5aguart3+Dk5Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719818833; c=relaxed/simple;
	bh=nz74jNjEyEWFUO7t5t+iBsaV3CkHWePeDl2+og/GGtA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=euJfVf0V3VuBWjIATAZXgfKXVuVPbOqKys9IV7S4ZhWcajDYOBjhOJYnf+978oksWMfkjNjWqVHy0T0urd8ASDJHAmKb2J8gFLH/7+BAnPrOutGF8jPyxVReT5wCQGxG7EJlF9stg/JH22ZH68QNzzKg8irHC70So/Y2AD1fFRg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=B/VAJjDF; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B/VAJjDF"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a6fe7a0cb58so124788366b.1
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 00:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719818830; x=1720423630; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=C9H+LtfjMiAMCgMa4i6YwTuHYadqKpvXXIns0beOBE8=;
        b=B/VAJjDFzHf3MfXyQINTMZ5I+v0PfBwO9zaG84CdO/rHETqsbaG/yD6Oa/O+Z8oiIr
         NPEdO8O6KqfWjy2hAUHkx6Riddqg4jyE2/XPhFq6rKSyzLY3GAWkE8zFzRlWG5UKMSL+
         ckp/CfQqYYuj3/VrQSXB5Esbs4FVxumq+ka7//X7PBv98zZPrV0k9hgD6BcSxPkGxeF+
         GdT01UIWEgCr0ZSHd8yF3yydqyHa7R0YIj4/2qqlUOciI2/WsftQkxKWYJGomDmb5Jym
         zBZOUApBG4607stlmsJe91LvN658Dhg+TR7WbMW8/B3XJo04mqeNLPnNjIXyuvcLZ5YC
         P8Hw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719818830; x=1720423630;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=C9H+LtfjMiAMCgMa4i6YwTuHYadqKpvXXIns0beOBE8=;
        b=nFoGeGPumweTdQtxZMD4gLGwgSZmmnxwXNDXM6aNOOA6YChwOuBMl5M/BHhuDVD7h5
         9KXVFQuwHSnkDtO5NDAI/c1NjdcgSDyOQQAx2LhKOObDpj1AIsRM0dTjRaRYQXuIDUVf
         7fuYxf+Fuqe8JfeYd+DcgLJJ6yCspMYAqKhWO/szwOjv7MB5Uv76hLvLN1PjdAeJTR9c
         XDAyoyGIlYGIHdP3IykufmGUs3OBrUlXObFrWWh3OQIkxmRt+RddMcblZjwvcdG4qMeR
         fWs3HOIfNDpZ4juJnKPipEmtdrHXCG1TKRcWCBuahSoJdJbYZxjAy6XgEVmqcytyXoJY
         iINA==
X-Gm-Message-State: AOJu0Yw7rmVILyM494dENRW1Zoq5W5K40TaE8+tsNN5t1hYxGdC716wx
	cjGGoiGW8P4f9kI8gsGCQEHVzSRzPCU9h8YwSiUnAkBZLFBgX/uZDH7iyE8o3oympDpC1dQ0GKD
	IGG/18hubs/gxJkiE512nbQXQhWA=
X-Google-Smtp-Source: AGHT+IFcJiHBFcft0CJelh9G0vC/G8AwPovkOEaEmBTS234PHUb3cXFqRxJYDE08ppP7oyXuTJOgY3MAWv7CBTNPyfM=
X-Received: by 2002:a05:6402:13c2:b0:57d:4f47:d9f7 with SMTP id
 4fb4d7f45d1cf-5879c08e17emr4411745a12.0.1719818829887; Mon, 01 Jul 2024
 00:27:09 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240628063625.4092-1-chandrapratap3519@gmail.com> <20240628063625.4092-11-chandrapratap3519@gmail.com>
 <CAOLa=ZRx6LQ26U-00UUttjo7sitLZ+gWA7FX0m3p1nQGhGF7Zw@mail.gmail.com>
In-Reply-To: <CAOLa=ZRx6LQ26U-00UUttjo7sitLZ+gWA7FX0m3p1nQGhGF7Zw@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Mon, 1 Jul 2024 12:56:58 +0530
Message-ID: <CA+J6zkSfGrfpgAMdm_zHX9C0vhpv_802O487WgbB5XXMw1Mc=g@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] t-reftable-record: add tests for reftable_ref_record_compare_name()
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

On Mon, 1 Jul 2024 at 00:29, Karthik Nayak <karthik.188@gmail.com> wrote:
>
> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>
> > reftable_ref_record_compare_name() is a function defined by
> > reftable/record.{c, h} and is used to compare the refname of two
> > ref records when sorting multiple ref records using 'qsort'.
> > In the current testing setup, this function is left unexercised.
> > Add a testing function for the same.
> >
> > Mentored-by: Patrick Steinhardt <ps@pks.im>
> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
> > Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
> > ---
> >  t/unit-tests/t-reftable-record.c | 23 +++++++++++++++++++++++
> >  1 file changed, 23 insertions(+)
> >
> > diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
> > index 55b8d03494..f45f2fdef2 100644
> > --- a/t/unit-tests/t-reftable-record.c
> > +++ b/t/unit-tests/t-reftable-record.c
> > @@ -95,6 +95,28 @@ static void test_reftable_ref_record_comparison(void)
> >       check(!reftable_record_cmp(&in[0], &in[1]));
> >  }
> >
> > +static void test_reftable_ref_record_compare_name(void)
> > +{
> > +     struct reftable_ref_record recs[14] = { 0 };
> > +     size_t N = ARRAY_SIZE(recs), i;
> > +
> > +     for (i = 0; i < N; i++)
> > +             recs[i].refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
>
> This needs to be free'd too right?
>
> So we create an array of 14 records, with refnames "00", "01", "02" ...
> "13", here.
>
> > +
> > +     QSORT(recs, N, reftable_ref_record_compare_name);
> > +
>
> We then use `reftable_ref_record_compare_name` as the comparison
> function to sort them.
>
> > +     for (i = 1; i < N; i++) {
> > +             check_int(strcmp(recs[i - 1].refname, recs[i].refname), <, 0);
> > +             check_int(reftable_ref_record_compare_name(&recs[i], &recs[i]), ==, 0);
> > +     }
>
> Here we use `strcmp` to ensure that the ordering done by
> `reftable_ref_record_compare_name` is correct. This makes sense,
> although I would have expected this to be done the other way around.
> i.e. we should use `strcmp` as the function used in `QSORT` and in this
> loop we validate that `reftable_ref_record_compare_name` also produces
> the same result when comparing.

The first parameter to QSORT is an array of 'struct reftable_record' so I don't
think it's possible to use strcmp() as the comparison function. We do, however,
use strcmp() internally to compare the ref records.

> > +
> > +     for (i = 0; i < N - 1; i++)
> > +             check_int(reftable_ref_record_compare_name(&recs[i + 1], &recs[i]), >, 0);
> > +
>
> Also, with the current setup, we use `reftable_ref_record_compare_name`
> to sort the first array and then use `reftable_ref_record_compare_name`
> to check if it is correct? This doesn't work, we need to isolate the
> data creation from the inference, if the same function can influence
> both, then we are not really testing the function.

The validity of `reftable_ref_record_compare_name()` is checked by the first
loop. Since we're already sure of the order of 'recs' at this point (increasing
order), this loop is supposed to test the function for ' > 0' case.

> > +     for (i = 0; i < N; i++)
> > +             reftable_ref_record_release(&recs[i]);
> > +}
> > +
>
> Nit: The top three loops could possibly be combined.

The limiting as well as initial value for the array indices are all
different so I'm not sure how to go about this.

> >  static void test_reftable_ref_record_roundtrip(void)
> >  {
> >       struct strbuf scratch = STRBUF_INIT;
> > @@ -490,6 +512,7 @@ int cmd_main(int argc, const char *argv[])
> >       TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
> >       TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
> >       TEST(test_reftable_obj_record_comparison(), "comparison operations work on obj record");
> > +     TEST(test_reftable_ref_record_compare_name(), "reftable_ref_record_compare_name works");
> >       TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
> >       TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
> >       TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
> > --
> > 2.45.2.404.g9eaef5822c
