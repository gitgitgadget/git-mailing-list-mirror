Received: from mail-pf1-f179.google.com (mail-pf1-f179.google.com [209.85.210.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FB95175D5D
	for <git@vger.kernel.org>; Tue, 17 Sep 2024 16:44:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726591488; cv=none; b=QFyBNr/Ofw1GyOLMxYonWKCK0Yqe1MYiOl+apxNEQq4OXQyPSsifUnRi938Mo+Im0lyaEvBkR6jrQN2BtwPL2qT2JBsE00HFWjhrnL88qqOhCO+QFnJ3ZREXk4i3Lm74dcaRhXbwm7wW+TafLfc2rsMVJaaycYtnJ9Sawp93jFc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726591488; c=relaxed/simple;
	bh=CPKHlcSJW8oz3H+f4Yltk2fBLM32QjSleWc25AlBUhU=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=H7Ta/sjahdMuvVgd1rjlU1jHLvZqDIpLy4dbnN8Lpq9JvBoiSsurvtL8S7VmXlveyHU2JE9JfaMU338Yd4s4kcEHbHooXPV/x15Peyi+/bwHkHTx1m1NynWCnwNtTWpv/W6dTFlh6cT5qkedEefqFdweITLNO6vU2PQ++CGeWT0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BUKTNRh0; arc=none smtp.client-ip=209.85.210.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BUKTNRh0"
Received: by mail-pf1-f179.google.com with SMTP id d2e1a72fcca58-718d704704aso5292695b3a.3
        for <git@vger.kernel.org>; Tue, 17 Sep 2024 09:44:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726591486; x=1727196286; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=/s8TDcZxaemkMQT4kC6reR8Suw4AW46Rqf8ss+uqm4U=;
        b=BUKTNRh0iLXPKnVdXYA+ExXhouFcn35T9YBOFasflUXMaieWCysEQDot6rWiHWThkj
         i9utao07G0HOADAy64p6XZbuqM1oOh9hZ31XD/VgDQkjyJYK8QeEG5QyIdamxe9efy/T
         nj9t+jSmyC7UwaD1b88NSixljgLJ30gqEt7hAaSWawIHApiuJDllDcRZA+0gAkoEhZQA
         Vq9a22TA4pwt5pkH4kgpnfvMWjCGv+fWx2IN0a8bR4B12wSEKFJ/IFImo8rb/qF+5SrS
         YD4CB94TxnkTn7nbNtEchXyuH5EI/di4iw1P69j/cj8vovCfjoyUeg0ZWVIhy/ba318I
         41tA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726591486; x=1727196286;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/s8TDcZxaemkMQT4kC6reR8Suw4AW46Rqf8ss+uqm4U=;
        b=PdoFff+vlwIvYw77sj/IyP39vGlBWpwvs5YacZRyFZTrhPe3+4ZnyX0FCiaEfuY1BW
         8ZfkSejFijbE+XK1/9Q5E/KV/p+tGZ5jho5kvtIUJHCgPTT7XUQm8A4YkNrFnfsPbuh5
         yUX4rbe+iJ3WW8zJW6aqovRuTNb4QyQmew5LjToL5AjnQBM2O++os3ww3SpArUH4ejjL
         TJcRSVy/Zhkff2CPvYnE/XPKfMyz98XRrGkGuZPZ/1xJvvsEqPaejdEUpz1PVKlnK/bc
         2ZSsURt1zfwJfm9iJcNrFRGEJAQDd+GgNcGPcgZiGGDoJOJr8XRFcIml/NXa0BuD1U57
         ndRw==
X-Gm-Message-State: AOJu0Yx64hGUz2vTonNiBq1+98zAc5ka6b04+8c5T3wOG7/VkhYx5oIu
	a4J8PTQ987zLt3UHr6MmjI7/pdX2AnhoxmF15jWNCohk/M+0ddLtjXyEqvgKYOsQQjd6jXdrzZF
	wCCzD8dTBypBY0afIofTXn95/20+XzSjiP2M=
X-Google-Smtp-Source: AGHT+IGXuhw5GyVHXmVlTEp2Nu5hZehznA/kF9MHzVexzrqSq/ea1KWNIKuW2d+uOLPNAQSGqsXt71b7G4GNYiQr3vA=
X-Received: by 2002:a05:6a00:4d01:b0:717:9191:8bfb with SMTP id
 d2e1a72fcca58-719261e77b8mr22879660b3a.17.1726591486404; Tue, 17 Sep 2024
 09:44:46 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 17 Sep 2024 12:44:44 -0400
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <ZufWjY053IKObF8T@pks.im>
References: <cover.1725881266.git.ps@pks.im> <a281f936a2b3a697b32f57652a2120afd54f7e4f.1725881266.git.ps@pks.im>
 <CAOLa=ZRA=vFjnWZC7PQBAxOxDfD9X6767ddgBqwaen5n6JLt0w@mail.gmail.com> <ZufWjY053IKObF8T@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 17 Sep 2024 12:44:44 -0400
Message-ID: <CAOLa=ZR2Q+8VKSink5FGJLhZVUZ6akZT565C1g2-fpczMkqwaw@mail.gmail.com>
Subject: Re: [PATCH 5/6] reftable/reader: make table iterator reseekable
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>
Content-Type: multipart/mixed; boundary="0000000000003856610622536868"

--0000000000003856610622536868
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Sep 13, 2024 at 07:11:54AM -0500, karthik nayak wrote:
>> Patrick Steinhardt <ps@pks.im> writes:
>> > diff --git a/t/unit-tests/t-reftable-reader.c b/t/unit-tests/t-reftable-reader.c
>> > new file mode 100644
>> > index 00000000000..7a46580b6f1
>> > --- /dev/null
>> > +++ b/t/unit-tests/t-reftable-reader.c
>> > @@ -0,0 +1,96 @@
>> > +#include "test-lib.h"
>> > +#include "lib-reftable.h"
>> > +#include "reftable/blocksource.h"
>> > +#include "reftable/reader.h"
>> > +
>> > +static int t_reader_seek_once(void)
>> > +{
>> > +	struct reftable_ref_record records[] = {
>> > +		{
>> > +			.refname = (char *) "refs/heads/main",
>> > +			.value_type = REFTABLE_REF_VAL1,
>> > +			.value.val1 = { 42 },
>> > +		},
>> > +	};
>> > +	struct reftable_block_source source = { 0 };
>> > +	struct reftable_ref_record ref = { 0 };
>> > +	struct reftable_iterator it = { 0 };
>> > +	struct reftable_reader *reader;
>> > +	struct strbuf buf = STRBUF_INIT;
>> > +	int ret;
>> > +
>> > +	t_reftable_write_to_buf(&buf, records, ARRAY_SIZE(records), NULL, 0, NULL);
>> > +	block_source_from_strbuf(&source, &buf);
>> > +
>> > +	ret = reftable_reader_new(&reader, &source, "name");
>> > +	check_int(ret, ==, 0);
>> > +
>> > +	reftable_reader_init_ref_iterator(reader, &it);
>> > +	ret = reftable_iterator_seek_ref(&it, "");
>> > +	check_int(ret, ==, 0);
>> > +	ret = reftable_iterator_next_ref(&it, &ref);
>> > +	check_int(ret, ==, 0);
>> > +
>> > +	ret = reftable_ref_record_equal(&ref, &records[0], 20);
>>
>> s/20/GIT_SHA1_RAWSZ
>
> Indeed.
>
>> Also here and elsewhere, shouldn't we just do
>> `check(reftable_ref_record_equal(...))` or even
>> `!check(reftable_iterator_seek_ref(...))` ?
>
> I guess you mean `check(!reftable_iteraror_seek_ref())`, right?
>

Yes.

> In the case where we just expect a zero error code I can certainly adapt
> the code to use `check(...)`. But the other cases shouldn't use
> `check(!...)` because it is important that the returnd error code is
> positive.
>

Perfect!

> Patrick

Karthik

--0000000000003856610622536868
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 859f6f2b0c64aae1_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1icHNmZ1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1meE1SQy80bWo0SHV3WUdVUU9wNEtnUWNZcWdtY1l3Zgpmd2pMWm1RUjIw
OGhQRk1QVi9INm9vaWRKYzdheW5qRzJOK0JBVml6WkFkVjVpNURiQ2R2ZHdGUmZHVHhkblZRCjhD
NGdSK1pOM1dhdjRMV2VpTzdPQ3JIL01vRWpCMTlLS1VVSVB4VFZPTndGQy80bStDazh0M2dzWWZU
Yjg5bFEKcDREZEhENzVoenlwVndYWXVrYlVzVFVud0dxd3hrN2t0aSt2MWlFTkxCbXZsRyt4dlR2
V3RyUHhHNkNSR0FvVAoxVmpxc2IxZzB0Yy9keHcyS29GcTVPT1JHWm9tZXV3cnFaZnZwVU9KTnVN
dnVibnB4UDdDdHZiMVdKakZzdk4zCk03dnVKMzBUOVBSNC9WS3pwS2g1aWlISUVGVTVqNlRuRnVp
ODRxdm5EazdLdit3Y000SHp2RWxEeGV5VTJ0bjgKZ2FXR0NyMjhjdE9kR3FCWlpPeVVaRGp4Lysr
bFpwSTRsMWxaay8rQzdPNTFYanhnemx6MFJjb1V5bUtoQUlmWgp0WTlDYWNQTjRHZ0RFeWxtdXYz
NGpTNUVuV1FYWUVLeklTSnp3QVAvRGpqQVF4TkxKMzZoMFkwTGxlc21nZHBQClRoTGhEYlJpN0ZP
RjhuWkFrRE9LYnlOUlRjNEs1UVdXNm1aVG9pZz0KPUI1N0IKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003856610622536868--
