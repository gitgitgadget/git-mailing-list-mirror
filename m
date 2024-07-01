Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com [209.85.208.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E61A212BF30
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 09:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719827481; cv=none; b=HeFghPRXgSsIjYF+cJXcKrxhrsvTU0lv6znbSd+/VKfxIRdn11Xg6sG4pxnszkIscfqN41v0O+/VUkOeqXI1DcMgP82HpFVkT0p8kqBTDdpG+meTDy0414p8hcCGKi/+JEJKli2soOi42XjNwKP0kquvWJKVnKmWUhy+4pNtpZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719827481; c=relaxed/simple;
	bh=apMaHRr1B0L8iNAvOOlkw4wGqUOGYsduMLLeSsSiwFg=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=qZH9OWZuaBO2MPhZPzfy2d9vb2U8Bm73vw47CWYzQtBKMmBz8Q+K6J3y55bDR9GfzFU2vlzTR30DKgcgXsRuTSZ69kxWEz86uti2jnfZtkfql4XuSgRxUjylIAEjOmXXCp0yeGfpxVjmhq9do+/MupklW5FA9l7TSmhRQoU8wZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GEN82KqC; arc=none smtp.client-ip=209.85.208.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GEN82KqC"
Received: by mail-lj1-f175.google.com with SMTP id 38308e7fff4ca-2ebec2f11b7so30928741fa.2
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 02:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719827478; x=1720432278; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=0TnznhEPqN/h3TQsqEAmubUsdHfCoku+ysXFlrRcWu0=;
        b=GEN82KqCOfYu06Sf5ifN9cD3hNDTAAenhMQZhe3tNPAJGw21hgvm+I1JCSUiTTKjpP
         3Uskb5RBt5xOoivZx/p8WpdXkmoxWVCyoqZzrva3F9AcmzD2SBPiuibcMJ3t4o3mfdsL
         pH1yAohP0w2mZ6NYgIGKTi6eeEOL0qnn412zK1EsUKC4vDcGypUcr2xz3b5b/kaesp/P
         rqJd7j4gLn66XQT8V12sR4Irrg32sD2dR6dwkPAd8s9p6YEDkN5WTalIG6dE4q1yHwth
         o3d015UOAYO2pU6Sfy3LmgAdzjhNuuf0uV5Qp79YuDs1Kt7muHaj/8uMYMAZ0RYOAuh5
         Fa9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719827478; x=1720432278;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0TnznhEPqN/h3TQsqEAmubUsdHfCoku+ysXFlrRcWu0=;
        b=O3VruBSAkNWpFEjjCAedao4QYE61ddO033DnkR/epati+US3K0OnRwut1EQmhO1vw/
         fYdmm4AwNccqHtvp1zQBF8Up3p9Pt9doB+tEyOk208Z4HIitm3o15eWHbYG3b6zNvBP+
         UpGnz9HBnNbfjpTm0MrQSxJ/nPRRPneQsPRDDzdyoMAcIixOm5rDLMbuMbXWMDjVYmnm
         lHqRr7kz+V1MXD51Y/4rDo4LuukKiA7yb7NMhnLFMmAENvk0CCajg0mJag3Ad4ZA7JH5
         cfWmdACmFemL8O4g+BIKNybZ5oZoxZNx9fuYTPCnD/S6L1cZq9Rx79ZkC9gFdWDedcGK
         K/jg==
X-Gm-Message-State: AOJu0YxUIXW4Zm3wvhjsmOF204dCbl42fJlNAP/Z5oJW/2z4jGG00tSZ
	63fuj+NSAVqPUWliR8hGJzUGOul3v8CKuCI2eMrQwKcU8WajezBHRi0HtAdL7J/NuxoVUaA71wP
	MZ5oR48/UPgKB3oo7MR5Nz0GoQPLHlcAH
X-Google-Smtp-Source: AGHT+IEHaW/E11l7oqph+I9o5XLgFNyFQxswSvIUIh72laAklCfPThj6IKF/BtaMEgU5WuTJj1Fl2NsccCmhmT7b3qg=
X-Received: by 2002:a2e:bc04:0:b0:2ec:6755:a0cf with SMTP id
 38308e7fff4ca-2ee5e4c7b53mr31103421fa.32.1719827477484; Mon, 01 Jul 2024
 02:51:17 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 1 Jul 2024 02:51:15 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <CA+J6zkSfGrfpgAMdm_zHX9C0vhpv_802O487WgbB5XXMw1Mc=g@mail.gmail.com>
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240628063625.4092-1-chandrapratap3519@gmail.com> <20240628063625.4092-11-chandrapratap3519@gmail.com>
 <CAOLa=ZRx6LQ26U-00UUttjo7sitLZ+gWA7FX0m3p1nQGhGF7Zw@mail.gmail.com> <CA+J6zkSfGrfpgAMdm_zHX9C0vhpv_802O487WgbB5XXMw1Mc=g@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 1 Jul 2024 02:51:15 -0700
Message-ID: <CAOLa=ZTsA624-T_Kqh3Nn9+_arCg93r-re3qHN9MGibgBP+LLQ@mail.gmail.com>
Subject: Re: [PATCH v3 10/11] t-reftable-record: add tests for reftable_ref_record_compare_name()
To: Chandra Pratap <chandrapratap3519@gmail.com>
Cc: git@vger.kernel.org, karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000df23b1061c2c894d"

--000000000000df23b1061c2c894d
Content-Type: text/plain; charset="UTF-8"

Chandra Pratap <chandrapratap3519@gmail.com> writes:

> On Mon, 1 Jul 2024 at 00:29, Karthik Nayak <karthik.188@gmail.com> wrote:
>>
>> Chandra Pratap <chandrapratap3519@gmail.com> writes:
>>
>> > reftable_ref_record_compare_name() is a function defined by
>> > reftable/record.{c, h} and is used to compare the refname of two
>> > ref records when sorting multiple ref records using 'qsort'.
>> > In the current testing setup, this function is left unexercised.
>> > Add a testing function for the same.
>> >
>> > Mentored-by: Patrick Steinhardt <ps@pks.im>
>> > Mentored-by: Christian Couder <chriscool@tuxfamily.org>
>> > Signed-off-by: Chandra Pratap <chandrapratap3519@gmail.com>
>> > ---
>> >  t/unit-tests/t-reftable-record.c | 23 +++++++++++++++++++++++
>> >  1 file changed, 23 insertions(+)
>> >
>> > diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
>> > index 55b8d03494..f45f2fdef2 100644
>> > --- a/t/unit-tests/t-reftable-record.c
>> > +++ b/t/unit-tests/t-reftable-record.c
>> > @@ -95,6 +95,28 @@ static void test_reftable_ref_record_comparison(void)
>> >       check(!reftable_record_cmp(&in[0], &in[1]));
>> >  }
>> >
>> > +static void test_reftable_ref_record_compare_name(void)
>> > +{
>> > +     struct reftable_ref_record recs[14] = { 0 };
>> > +     size_t N = ARRAY_SIZE(recs), i;
>> > +
>> > +     for (i = 0; i < N; i++)
>> > +             recs[i].refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
>>
>> This needs to be free'd too right?
>>
>> So we create an array of 14 records, with refnames "00", "01", "02" ...
>> "13", here.
>>
>> > +
>> > +     QSORT(recs, N, reftable_ref_record_compare_name);
>> > +
>>
>> We then use `reftable_ref_record_compare_name` as the comparison
>> function to sort them.
>>
>> > +     for (i = 1; i < N; i++) {
>> > +             check_int(strcmp(recs[i - 1].refname, recs[i].refname), <, 0);
>> > +             check_int(reftable_ref_record_compare_name(&recs[i], &recs[i]), ==, 0);
>> > +     }
>>
>> Here we use `strcmp` to ensure that the ordering done by
>> `reftable_ref_record_compare_name` is correct. This makes sense,
>> although I would have expected this to be done the other way around.
>> i.e. we should use `strcmp` as the function used in `QSORT` and in this
>> loop we validate that `reftable_ref_record_compare_name` also produces
>> the same result when comparing.
>
> The first parameter to QSORT is an array of 'struct reftable_record' so I don't
> think it's possible to use strcmp() as the comparison function. We do, however,
> use strcmp() internally to compare the ref records.
>

Well, yes, not directly, but you can create your own function and pass
it to QSORT. This will mostly replicate what
`reftable_ref_record_compare_name` is doing. But I think you're missing
what I'm trying to say however.

I'm not really talking about the semantics of it. I'm talking more about
the concept of it. See the next section...

>> > +
>> > +     for (i = 0; i < N - 1; i++)
>> > +             check_int(reftable_ref_record_compare_name(&recs[i + 1], &recs[i]), >, 0);
>> > +
>>
>> Also, with the current setup, we use `reftable_ref_record_compare_name`
>> to sort the first array and then use `reftable_ref_record_compare_name`
>> to check if it is correct? This doesn't work, we need to isolate the
>> data creation from the inference, if the same function can influence
>> both, then we are not really testing the function.
>
> The validity of `reftable_ref_record_compare_name()` is checked by the first
> loop. Since we're already sure of the order of 'recs' at this point (increasing
> order), this loop is supposed to test the function for ' > 0' case.
>

Yes, the first loop uses 'strcmp' to validate and that's perfectly
correct. But this operation here is kinda pointless in my opinion. My
point being that if there is a list x[] and you use a function f() to
sort that list, validating that x[] is sorted with f() again, doesn't
test f().

It might be much simpler to just test
`reftable_ref_record_compare_name()` as so:

    static void test_reftable_ref_record_compare_name(void)
    {
    	struct reftable_ref_record recs[3] = {
    		{
    			.refname = (char *) "refs/heads/a"
    		},
    		{
    			.refname = (char *) "refs/heads/b"
    		},
    		{
    			.refname = (char *) "refs/heads/a"
    		},
    	};

    	check_int(reftable_ref_record_compare_name(&recs[0], &recs[1]), ==, -1);
    	check_int(reftable_ref_record_compare_name(&recs[1], &recs[0]), ==, 1);
    	check_int(reftable_ref_record_compare_name(&recs[0], &recs[2]), ==, 0);
    }

>> > +     for (i = 0; i < N; i++)
>> > +             reftable_ref_record_release(&recs[i]);
>> > +}
>> > +
>>
>> Nit: The top three loops could possibly be combined.
>
> The limiting as well as initial value for the array indices are all
> different so I'm not sure how to go about this.
>
>> >  static void test_reftable_ref_record_roundtrip(void)
>> >  {
>> >       struct strbuf scratch = STRBUF_INIT;
>> > @@ -490,6 +512,7 @@ int cmd_main(int argc, const char *argv[])
>> >       TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
>> >       TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
>> >       TEST(test_reftable_obj_record_comparison(), "comparison operations work on obj record");
>> > +     TEST(test_reftable_ref_record_compare_name(), "reftable_ref_record_compare_name works");
>> >       TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
>> >       TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
>> >       TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
>> > --
>> > 2.45.2.404.g9eaef5822c

--000000000000df23b1061c2c894d
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: b71959499d41b9c7_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1hQ2ZCRVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNmVWQy8wY3o4NUR1ck52TStjRGdDVmNPMU05UGs4RgpsYlRFeGo1YWwr
TlRGMXFBdE4xTlhyNEtmK29vSjlEV3VVTVQ5MXJLcjI2VUp2Ym00N2JlMXhjd2QrcEM5TnBsCjd2
amljRDNBU2JaRWJFc0hLT1lhZm4wK1luOUFmcUtxcXdJdUVGYmU5UjBEbi9TTkNHWHJ5K0QzUGs2
ZWMvdXIKREtEVnIrVk9XSEhMeURocDVRVnI2cDJRUVV5M3ZQeTBReEd4MHRYWWJIVitMUktJSzg2
OVRMNC9NT1NRR0NPVQovVEc3Kytabi9XSkVGYU1XanBRTGJ1SVRjcHdvZDNJY2c3SWJiaVAwdzBy
ODhyTHFQZ1ZrcTY3S0FHNTdnL3prCkJPY2ZNZmpVTHlxbVpUVWVvMzM3NStNckRzdkhONjMyaXow
cFcvSnRBSkl5R21TVHJnZHdMVVBuSEFGRHpjMWQKMG1FcVVUci9kejRaZW5TQ09VakZWZ1F1SDRu
QjU4MHNzNXZxamxOdGk2VzhEektiSmpmdURnU3NzOHZSaC82ZQpQS29aVlJxaEtuamRFUkh5TFdN
MUIzejBUcTRZajVaRUlYbDdQOWdhV0hmVzBGTWJUaTNIUXJUaUMrUnVuOTNTCnUwTUpDU1dUbjFz
NVBXelhqdGVTZW5VZ294cXhhbmpJem1kcmRsRT0KPUlFM0kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000df23b1061c2c894d--
