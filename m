Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1902D1E412E
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 11:35:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728992122; cv=none; b=kcKcG/QdIJpEKERleMNCgZwhTWa95MjmlypwBt5iijdvQZhOjCEis7Um370YcToXZTvWYBLWskLEydb29TwDrXvV1aFlvUeeIw7B12ezdsxdYW14r9eHEDcE/8PcJYfOJrcQ7+Kup65G3e8bSHXbP/n/3M+AHQ0HH9nOcZWci1s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728992122; c=relaxed/simple;
	bh=ULTXF+Q5rrk81o9lsxNZl11fVj4OTuFe+rJM4Vx3rRo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=I4K1aY7MxGAkGuzNOlF6W/CT241kFP+6Mz6HGzQARS1kOmizVFE9QtoRVg37C7ohmD8p2fVdVIzgCgI/WfGExFTT8oM/jljiw1tU/AWoAAIeQuCaKVeztZK0lX9soqE8aWjpcfJPgqfWJoh1oUgAB8lsLxEc/2TUbaIXITBEKWE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kbQiZCAi; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kbQiZCAi"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-50d2d300718so798892e0c.1
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 04:35:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728992120; x=1729596920; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=DH47fXBxvna8H5CjT3pxSxk2HaZQ9OkXPPgo7v2e1HU=;
        b=kbQiZCAiPbQD48ieqGjr6Z3gksVf1KY6yaIaxK5GLlOAEeZeYgLPAonnQAk3DVzg6Q
         6WUdZFJg8kGP8WPEdsKt29/GcbRIZGqjd5C02aMDb8XMpW4yPIN43zVo6UaY0F88dzKY
         tOSxIpK9BOofaokiaxDqwWCJI26fJt8itwcVSqdbLNH3R2KMfbqxLWdfQ25aEPPdlOlX
         LvTYd2iN7KdT9Uo2q23llveOqxodKKVh03GEqPqUugcPovU/Ec7aVxHFfoJbbrNIyzvW
         /kJ5v9tWblRhHE1e8UmioLSQhly5VH3ACV7tNX2Oz7FpmARckHGYbkaCBJ8b7n2NSskq
         QgTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728992120; x=1729596920;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DH47fXBxvna8H5CjT3pxSxk2HaZQ9OkXPPgo7v2e1HU=;
        b=nQXeTYdBu6b0h5lXl+CGsfBqFYp7oO89ExNZC0O1xR65/V+ZgQzY90MRx7wMnSb+Ok
         Rp9U1fEejNy6UP0eCa1a/DuOjaDkbIkGZiE4aNTc3P4drxH2m4THUsRadn+qWax2vBSz
         abJ+x2svprpeQvEbK451orkdlJEXhI1O3ibQI1gC60CQIzmImSi7YsUjymOdHzRUg3eE
         +vlSAOLxrA3Yw66Ywk4PRt0/CE5z5hXBigsG/vllXFS/D2QJihQ9HqdZPHm9NHH2hWmj
         uP9RptpKnFK/Nbpv9QlwPQQKRgpf5ZWgVKlefphuO+Eo55nimcJQg0d33gxR74f4foj6
         xHVQ==
X-Gm-Message-State: AOJu0Yznbwpa2HLVizcmaLpPbWZlo04gmrI8k2/e3DsestxbKAzmO8gI
	LwLdVbF8nt5TIOqbOkd3Dwp4u9cnEq2saxncyJeLCwGSXNDYo3RNiYH6am10/ONM349xCjIy4Jp
	lgn2ZXzlIlkBWMJJKGKUj110dinUHu/x0
X-Google-Smtp-Source: AGHT+IHiQl/UvE9gS/8fTaTE5hiLZ5IcRaXh9krQ2sPrJxgMFnCx19am++8QcMiBME0EWhCVRwBvj+xcZp0KJ8WouZo=
X-Received: by 2002:a05:6122:378d:b0:50d:5ca8:77 with SMTP id
 71dfb90a1353d-50d5ca80fa7mr3935398e0c.0.1728992119839; Tue, 15 Oct 2024
 04:35:19 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 15 Oct 2024 04:35:19 -0700
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <Zw2Jq0cGPrRn6GAO@nand.local>
References: <cover.1728697428.git.karthik.188@gmail.com> <74bbd2f9db1ddfd5210be8fde2db84f67acff27d.1728697428.git.karthik.188@gmail.com>
 <871q0jrr02.fsf@iotcl.com> <Zw2Jq0cGPrRn6GAO@nand.local>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 15 Oct 2024 04:35:19 -0700
Message-ID: <CAOLa=ZRuEV1dyrn2N_O+W1DwSuHgHTghoauH4w6YX2HXi3UG4g@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] clang-format: re-adjust line break penalties
To: Taylor Blau <me@ttaylorr.com>, Toon Claes <toon@iotcl.com>
Cc: git@vger.kernel.org, gitster@pobox.com, jltobler@gmail.com, 
	johannes.schindelin@gmx.de, spectral@google.com
Content-Type: multipart/mixed; boundary="0000000000001f849f06248259e8"

--0000000000001f849f06248259e8
Content-Type: text/plain; charset="UTF-8"

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Oct 14, 2024 at 11:08:29AM +0200, Toon Claes wrote:
>> Karthik Nayak <karthik.188@gmail.com> writes:
>>
>> [snip]
>>
>> > This avoids weird formatting like:
>> >
>> >    static const struct strbuf *
>> >           a_really_really_large_function_name(struct strbuf resolved,
>> >           const char *path, int flags)
>> >
>> > or
>> >
>> >    static const struct strbuf *a_really_really_large_function_name(
>> >    	    struct strbuf resolved, const char *path, int flags)
>> >
>> > to instead have something more readable like:
>> >
>> >    static const struct strbuf *a_really_really_large_function_name(struct strbuf resolved,
>> >           const char *path, int flags)
>> >
>> > This is done by bumping the values of 'PenaltyReturnTypeOnItsOwnLine'
>> > and 'PenaltyBreakOpenParenthesis' to 300. This is so that we can allow a
>> > few characters above the 80 column limit to make code more readable.
>>
>> I'm really liking the idea of penalties, but I feel we're relying too
>> much on guestimation of these values. What do you think about adding
>> example files to our codebase? Having concrete examples at hand will
>> allow us to tweak the values in the future, while preserving behavior
>> for existing cases. Or when we decide to change them, we understand
>> what and when.
>
> I am not sure I see it the same way.
>
> I might just be ill-informed or not experienced with these clang-format
> rules, but having these penalties be defined as such makes it difficult
> to reason about what lines will and won't be re-wrapped as a result of
> running the formatter.
>
> What is the purpose of these penalties?
>

We have a column limit set in our clang-format 'ColumnLimit: 80', this
dictates when line breaks should occur in our code.

The penalties are options through which we can influence this decision
[1].

> Thanks,
> Taylor

[1]: https://stackoverflow.com/a/27608250

--0000000000001f849f06248259e8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 9f55bcac1f66b07f_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jT1UzTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md3JMQy80dkhUOXQ2SUo4eGxWS3ZRZzJVUy9oQWtJawptbTdjeEY3TVBQ
R2JkdzllOEI4R2NNM0VTYmpuSGxOQjhRbkxYam0vZnhtOHJiY2tiM2QxK05LTHBiUEcxYWlTCjQ1
V1VMaUJiV1NMclV3SWg3ZWZwNXJBN2VhVmVkYXBoNURCd2cxNit3NFdHNUVvQWY5NDNhWW1PL0x5
Q2RLTnEKeDhRVTJRUThBenI5S0JTUVoyaTFVdkRNWEpDUjZ5b2l2WDZTY01BN0xKdFRWdGhCa0xm
MHlsUGxyWVNkZnRPQQpzcnV1cGlKU3VudjJXbWhmZGpabWVGRXpBNVdTVzhiU1hsQWgyemNSajdS
RGJHMVFIa3NmR2NaaG5kcHB0NlFxCk9HNDYxYXdOSWk4ZHFuR0YxZFM1T3NLRTZEZ0NYbzk1Y3ls
eWZGV210bitmS2liNHYybjFVZG9OZE9Fb2lVMHgKZmk3dytrTlhsSVJkdE1sYzM1U0diWDhuTjRD
Vkw4dFhtdDc0K0RYdE1CNTVRL2t6cG9uWVJNc1FHenRJb1BELwowdFJCNVVzMysyZlFQYTE5N0Nv
eU5mV2d4a3pCUml0SDF0b3dLbmhyNkdEMlJWT1pZMDhIdFlhTFQ2R0RoWWx3CllncFpCOWhQdkpm
elNFZVRjRGY1ZmtkSkdYeHdCdHVJSmRDbXhjND0KPXEzcUUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000001f849f06248259e8--
