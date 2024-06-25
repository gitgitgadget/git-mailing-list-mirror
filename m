Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C90F317C98
	for <git@vger.kernel.org>; Tue, 25 Jun 2024 13:45:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719323140; cv=none; b=te2MEjYfDssnZmmoOh3CYJpjaTKD/0OARkiYbZC+ULNJhVFGaI5vIuP+an69AIhPs+x3CxlsoUmSqyQFb9aGlnwtZIJmOUvHjt7mdohP8BQNaU9mXiUfZm2Aj/+QNV4ogBmPQFvpxXH9BNuvXsczoLIGgxo6xHd11yNUU/MuNws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719323140; c=relaxed/simple;
	bh=5HqkoFWzlzvMtB6JpUIXJlnw5ATfdylZQjZDVVpiiJw=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=eWveLVnUhJxAPdiQovq95DpQC2j2NPNOJQczHTZkuMYFzS9DTpJaznAZ50D4uHm5gUQruVv4ZazNp19lk0XxweB46K0/BnaEnrxmjkdfueGiiucXgTtUBdnVnHKK8Xp9Ulmz8zxbDNY3msyf+n21YeEZwT4Ubae08dKcXPVTJts=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JHXzVmEz; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JHXzVmEz"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a725ea1a385so221957566b.3
        for <git@vger.kernel.org>; Tue, 25 Jun 2024 06:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719323137; x=1719927937; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=96xH++W7/pXH1V/YLWcEENFtgt/3oAKjtTPcFgjRxyQ=;
        b=JHXzVmEzAUGlnwbQSIl1OTax4p+jm17JRWzJ0hIycqIJv/Gq2FUeDwRB49JHYhN03u
         9K4KbGIApC8fc3r+wGgHxsy17fmZ4cCZR8sMaS8BC2cnu8g1zsjPa018bEFNz/cBD674
         wL/hjaLb1MAcJK96hBAj6KxwQxSNsPLCvciKRuXeJfHH0r/wbjHTw4FQTF7ZjNuR+ewE
         eP3Od8NJyBIPMXViGam8o8YZHOaG+kXOz8i5K5KmodaypLUft5rR5W3Hu/YpvhkcjnML
         z9Mc1IenBJD8vtdTogqGt+ciwUbpW67M6AmqhseDnZu8TUJKJKc8zT191bkONqzKrFCK
         By0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719323137; x=1719927937;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=96xH++W7/pXH1V/YLWcEENFtgt/3oAKjtTPcFgjRxyQ=;
        b=hkuzA7KH1E8sARj6qwHMW7eci0P4GMNeoeEuoPuGl4OEraXRuro8ax9Kz4Jc6r0CZt
         63bNM3Y0bKl9hPktZscu9Z6s9umKDco1r7F0BI24RQrjxwk80A+7rC1M5utSOUqtsZHN
         G/9+AHfLijo4z7KXZAZKTvQ3vNOJGEj8xjV6qQkGunFHwiAElESH99zHZguFH9tX0QBh
         XkSU6Rv6jnCLJ93G80HxXCwzVb8aL7IYL5jZYV4wjxtpg31D3ybkbwWEHETCmz+NpCtw
         k6WfAG0YkgU+C+SPnP1E9P4SRxMgIvzX7TD5QFmNjKnAx46fPW+yDnuEQG+rlcqQ7eX/
         k8Cw==
X-Gm-Message-State: AOJu0YyzxteE/daLa0CiAOrVmGOOSa6DRSklqtqTpaWIUxz0hCYdPlEg
	CS5gYflkuu6GrJ1EyLIZFMdRbs3XFvK9uKMp5x+Gi5sik2UATBt6ckq90g9d/puT62LmzTrL8yg
	a+cVaR0V5Ic2wWbE86NoBujlxxME47Q==
X-Google-Smtp-Source: AGHT+IGPLyVyJxEwZhHikMHufsoQsiWF5DTXFE2iYf3Mr55bhELaEWUPA2VGk/yP52cAGEQAlg9HD8LtxSmo7mw4obU=
X-Received: by 2002:a17:907:a605:b0:a72:4bf2:e1a with SMTP id
 a640c23a62f3a-a724bf20e88mr439354466b.20.1719323136845; Tue, 25 Jun 2024
 06:45:36 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240621060018.12795-1-chandrapratap3519@gmail.com>
 <20240621115708.3626-1-chandrapratap3519@gmail.com> <20240621115708.3626-11-chandrapratap3519@gmail.com>
 <CAOLa=ZTnwA0gYeDo3m9ZZD-jJJN=+FdVKTLDKTG4x-vn6wC2jg@mail.gmail.com>
In-Reply-To: <CAOLa=ZTnwA0gYeDo3m9ZZD-jJJN=+FdVKTLDKTG4x-vn6wC2jg@mail.gmail.com>
From: Chandra Pratap <chandrapratap3519@gmail.com>
Date: Tue, 25 Jun 2024 19:15:25 +0530
Message-ID: <CA+J6zkQJk+2WNaK5qP690bqwTPNCiXTBYCbaOgcxgtue3LZ_xQ@mail.gmail.com>
Subject: Re: [PATCH 10/11] t-reftable-record: add tests for reftable_ref_record_compare_name()
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, karthik188@gmail.com, Patrick Steinhardt <ps@pks.im>, 
	Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset="UTF-8"

On Tue, 25 Jun 2024 at 14:56, Karthik Nayak <karthik.188@gmail.com> wrote:
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
> >  t/unit-tests/t-reftable-record.c | 18 ++++++++++++++++++
> >  1 file changed, 18 insertions(+)
> >
> > diff --git a/t/unit-tests/t-reftable-record.c b/t/unit-tests/t-reftable-record.c
> > index 99ebfafe0b..b949617c88 100644
> > --- a/t/unit-tests/t-reftable-record.c
> > +++ b/t/unit-tests/t-reftable-record.c
> > @@ -101,6 +101,23 @@ static void test_reftable_ref_record_comparison(void)
> >               reftable_record_release(&in[i]);
> >  }
> >
> > +static void test_reftable_ref_record_compare_name(void)
> > +{
> > +     struct reftable_ref_record recs[14] = { 0 };
> > +     size_t N = ARRAY_SIZE(recs), i;
> > +
> > +     for (i = 0; i < N; i++)
> > +             recs[i].refname = xstrfmt("%02"PRIuMAX, (uintmax_t)i);
> > +
> > +     QSORT(recs, N, reftable_ref_record_compare_name);
> > +
> > +     for (i = 1; i < N; i++)
> > +             check(reftable_ref_record_compare_name(&recs[i - 1], &recs[i]) < 0);
> > +
>
> I understand the intention, but using a function to help sort strings
> and then using validating the same function with those strings doesn't
> validate the functionality of the function.

True. I'll modify this to use strcmp() instead.

> I would have preferred to see some hardcoded strings and simply
> comparison between them. Also comparison's where
> `reftable_ref_record_compare_name` returns '0' and '> 0' values.

The only use case for this function is as the comparison function
for QSORT(), so I wanted to design a test close to that use case.
Nevertheless, I'll add tests for '== 0' and '> 0' cases.

> > +     for (i = 0; i < N; i++)
> > +             reftable_ref_record_release(&recs[i]);
> > +}
> > +
> >  static void test_reftable_ref_record_roundtrip(void)
> >  {
> >       struct strbuf scratch = STRBUF_INIT;
> > @@ -501,6 +518,7 @@ int cmd_main(int argc, const char *argv[])
> >       TEST(test_reftable_log_record_comparison(), "comparison operations work on log record");
> >       TEST(test_reftable_index_record_comparison(), "comparison operations work on index record");
> >       TEST(test_reftable_obj_record_comparison(), "comparison operations work on obj record");
> > +     TEST(test_reftable_ref_record_compare_name(), "reftable_ref_record_compare_name works");
> >       TEST(test_reftable_log_record_roundtrip(), "record operations work on log record");
> >       TEST(test_reftable_ref_record_roundtrip(), "record operations work on ref record");
> >       TEST(test_varint_roundtrip(), "put_var_int and get_var_int work");
> > --
> > 2.45.2.404.g9eaef5822c
