Received: from mail-ua1-f50.google.com (mail-ua1-f50.google.com [209.85.222.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0AF2F194AC7
	for <git@vger.kernel.org>; Mon, 24 Mar 2025 19:49:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742845743; cv=none; b=oCg7uFiniV/uKxO1LT59sMgtFbZ27/wNZtR/ltJe5WqmO79geUL+2vhelW+ACGgRECfIPY20aeIpjggeQk/o09fp9puL4NXwiAZtmpqydMR6aNA16Fbwf8Rc6enB2VEo+dL+e9EYtM6tURUUAr33RCcCU9W8rwSAk1mI9uVgD70=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742845743; c=relaxed/simple;
	bh=dJWBierSR2BHpcFkmMxL62yv/6geJkoY54GgnnuGOac=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=GOWSVi4VMEQwkcMhA9XQ/jUg9LOQRKAEVwkfh825bqDOR6wLY1fcVTZ5in47lIpDAd+lM0aI/vuucZdLWvbngd7yS46NOC5IhYshiKToMAhGPVXepOoBXvyZ2G8UhxaAidWQEXJWi92rHybSrYVwKrYVUiFp7+iZJfiwcvGB4Hc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Nymw/092; arc=none smtp.client-ip=209.85.222.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Nymw/092"
Received: by mail-ua1-f50.google.com with SMTP id a1e0cc1a2514c-86d6ac4d5a9so2102561241.1
        for <git@vger.kernel.org>; Mon, 24 Mar 2025 12:49:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1742845741; x=1743450541; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=irw18ltBmDdgJdO/LgYbPr4Nw0BELXAPIAC3vMOg6VQ=;
        b=Nymw/092zZ+HtaxOuqzu+r5V51AFlRs34aIjG53d4wKGrmDj1oOa4d0A1nnH1XO4MO
         OLRg5z+DdpgYG2E0ybB9mbjEnHmvFbqVdN5Thutiu6Wirlp6nn7t+G1g0gnQ7UuZOwgR
         gTHxW0J//ynZYdBeWEU584CCeYj29j+VMkV1MSaDvHCU9k5MfTLX/gNSNY9Gy1ykyis0
         xjAteQiFpWtvMqfW14zCbTrVzY5wocOvs5Lr3rUlT8gsscJtutN8V1aNnvt75jpkR+Vx
         udkRthOF1v6T0O1zT02xpYoYcP1U9zk6EHZa833Rr4hc6zX738ByGQCktVKrwU87odTw
         RGCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1742845741; x=1743450541;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=irw18ltBmDdgJdO/LgYbPr4Nw0BELXAPIAC3vMOg6VQ=;
        b=YEH7ifrCS+kEJ2fqd1g+3cGau+3lHs0WegWyWceB/YG3/N1meaTHHXxTFtJOmZDq/T
         rIzt9NCuy8/9BEf+2YbLHOV9gTWEUo/j6XWMCtVPjXMG1bUV/LltRHrEwQqrBxCw8CTN
         jiBMMgZG0B5khxLLoWpNSht04X96M0BoeydJ3liLJkKUfbGY2SUNFFC92Ln2k/8kl1TP
         UQe4IY+o8teBYtsBdoryjLcK5MWgjTq9Dk3EtjJazC1BLk8Vp1vWNBvKwLvfQ499+05A
         uN9yQKoMGtSRC6uUb4J/XWkQ6B5s9GZzrhAjRdVdzlqmMTDuz6J0s7KEPEnDgr8B0EjD
         0Zeg==
X-Forwarded-Encrypted: i=1; AJvYcCV8xOo7b7+Yqu/SayyQjNy3u8fJdfvPZsDgffPnGCFX6AG14vswNnnu/hoH/tdHOce9owg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxWOBSGinmIkwjPcLKi6hcV+hwJvCN/UIFS4YOln5BwSz6OphA9
	GO+UIAuFOyIoYC48LIb04guzAmGVp96tKrhYQZvc+VqmKAjvzUPhgLQjhVS67UuLzc3Q3J3YanV
	lQ5rmAQ+30zSlGB/d+msa1/1DuAg=
X-Gm-Gg: ASbGncu2Yqs3IT4tYI7IVY7UkXAyMI/FxMOyj4PefRY8P/sEwOEYhUlddJ6sYmvAY/1
	wszEMmxmvpNq/5K8sxTyFO2Bn9F0XqO+DE3/sAjeBJm+5AtS3+6CkUismUo46rMUmQv7DPagtSc
	S71XDBgW1G7QgeSMiHBZVbHyFYyevoRURHnz6v2ahDyR3HrV6ihAEJB2RcxXw=
X-Google-Smtp-Source: AGHT+IHDjDI1zpUDCQlcye0ntf0bKlKI6BkeShjnAXyUepsH+llOTA453EXPjh8loKNL63DnkM96dMRacGHK9hxHuFs=
X-Received: by 2002:a05:6102:3ed3:b0:4c4:e0e0:f7bd with SMTP id
 ada2fe7eead31-4c50d5f1661mr10272136137.19.1742845740450; Mon, 24 Mar 2025
 12:49:00 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 24 Mar 2025 19:48:59 +0000
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250324025300.GA690113@coredump.intra.peff.net>
References: <20250321200715.3338-1-taahol@utu.fi> <CAOLa=ZRN5m0bccMdabUYwNJLg4HX6jcOe3PN-aBTHXBOuM71hw@mail.gmail.com>
 <20250324025300.GA690113@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 24 Mar 2025 19:48:59 +0000
X-Gm-Features: AQ5f1Jq4aIR_gkkxkXshZ5cgiLvBdM6CxCFk95QcZ1pnd-cLQkIuCYKaD9k-Q90
Message-ID: <CAOLa=ZRkzp6A+S-bqbUMnkovazrczFi=B8tG06xqTzsNQB2enA@mail.gmail.com>
Subject: Re: [PATCH] bulk-checkin: fix sign compare warnings
To: Jeff King <peff@peff.net>
Cc: Tuomas Ahola <taahol@utu.fi>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000422b3f06311be5e3"

--000000000000422b3f06311be5e3
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Fri, Mar 21, 2025 at 05:08:06PM -0400, Karthik Nayak wrote:
>
>> > @@ -192,7 +188,7 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
>> >  			offset += rsize;
>> >  			if (*already_hashed_to < offset) {
>> >  				size_t hsize = offset - *already_hashed_to;
>> > -				if (rsize < hsize)
>> > +				if ((size_t)rsize < hsize)
>>
>> Something I found peculiar here is that `rsize` is of type ssize_t'.
>> But it only seems to store a positive value.
>
> I assumed it was ssize_t because it would hold the result of a read
> call. But it doesn't! We put that into the "read_result" variable.
>
> So it could just be a size_t in the first place. And indeed it is better
> as one, because we assign from "size", which is itself a size_t. We do
> not yet warn about type mismatches outside of comparisons, but really it
> is equally bad.

Nice, thanks for exploring this thought out more. I did look at the
code, but was more cursory.

> However, if you switch it, then we get a different -Wsign-compare
> problem: we compare "rsize" and "read_result". So you still have to
> cast, but at a different spot.
>

True. But this would be better in my regards, since this would directly
follow the

  if (read_result < 0)
     die_errno("failed to read from '%s'", path);

code, so a `if ((size_t)read_result != rsize)` here makes logical sense
since we can clearly see that this section is only reached when
`read_result` has a positive value.

> If we are doing this a lot (and really this conversion is necessary any
> time you look at the outcome of a read call), I do still wonder if we
> should have a helper like:
>
> static inline int safe_scast(ssize_t ret, size_t *out)
> {
> 	if (ret < 0)
> 		return 0;
> 	/* cast is safe because of check above */
> 	*out = (size_t)ret;
> 	return 1;
> }
>
> (yes, I know the name is lousy). That would allow something like this:
>
> diff --git a/bulk-checkin.c b/bulk-checkin.c
> index f6f79cb9e2..fbffc7c8d6 100644
> --- a/bulk-checkin.c
> +++ b/bulk-checkin.c
> @@ -178,9 +178,10 @@ static int stream_blob_to_pack(struct bulk_checkin_packfile *state,
>
>  	while (status != Z_STREAM_END) {
>  		if (size && !s.avail_in) {
> -			ssize_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
> -			ssize_t read_result = read_in_full(fd, ibuf, rsize);
> -			if (read_result < 0)
> +			size_t rsize = size < sizeof(ibuf) ? size : sizeof(ibuf);
> +			size_t read_result;
> +
> +			if (!safe_scast(read_in_full(fd, ibuf, rsize), &read_result))
>  				die_errno("failed to read from '%s'", path);
>  			if (read_result != rsize)
>  				die("failed to read %d bytes from '%s'",
>

This does look nice, but I'm worried something like `safe_scast` would
just not be used througout the codebase, causing inconsistencies. But I
think we can drive that through reviews.

> Though it does kind of obscure the call to read_in_full(). You can use
> two variables, like:
>
>   ssize_t read_result;
>   size_t bytes_read;
>
>   read_result = read_in_full(fd, ibuf, rsize);
>   if (!safe_scast(read_result, &bytes_read))
> 	die_errno(...);
>
> which is a bit more verbose but perhaps clearer.

Yeah this is much better too.

> This reminded me a bit of the issues we had with write_in_full() before,
> where:
>
>   if (write_in_full(fd, buf, len) < len)
>
> behaves unexpectedly because of integer conversions. There the solution
> was to never check against "len", because write_in_full() either writes
> everything or returns an error. So:
>
>   if (write_in_full(fd, buf, len) < 0)
>
> is correct and sufficient.
>
> But alas, we can't do the same here, because reading returns three
> cases: error, a full read, or a partial read (maybe even EOF!). So we
> really do need to record and compare the return value between what we
> asked for and what we got.
>

This is to some extent a flaw in the way errors are generally
structured where the error indication (-1 here) and a potential result
(bytes read) are combined into a single return.

It is unfortunate indeed.

> -Peff

--000000000000422b3f06311be5e3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: e2d66d0c096381a6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1maHR5b1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mK0FyQy80cEFHWWZma0pjaS8xRFdvZjZoSDFHOTllTQpwbG1oNGJxR2Q0
QmMzaHRtRkhsMENXYkZ5K05MblZNejdPWXMrZm5kVDRPZUtHcG81L3ZSMXZ6MjZEaXNzbWJ2Cm1n
VFgxSXRiaW1nQ0FoUExkb3FaTi9ZaFhYWEwvbmZZTmJadHJVRXRKa1o4ZU1IQjBzMkNPLzJSRGph
N2NiZGkKN0I2R2Nhdk94NWErRXd4QjA2dDk5MnQ5T1FJaVJmR1J0V1VzR2ZOeUNvT1ZoSkVFRDVJ
aGhCM1VRNC9RZjNWYQpoWFd2NElMRjEvQlYyOGlkM3JIZGEyajZPNkR3SERjUXM0dXNsRytzeSt2
SmFZaDR3TGExVWhGdWk5ZFN0S1gxClpnNEQ4Wll3OURqQjg4cTNmd25rMklaMVZVWkFaTXJnL0Z6
UkZjNEdEZFE4d0dpYmdRZ1hRWGNiRU9UdW5lVEYKb04zMnRKdTNVSFFVZmVwZnBoQVZPRTRsWU1B
a3ZVaVl4ZjUxQWRMNVVGOFQ4V0N0MmFVL3QwbzJVSXN3NW1XdwpuSVdaOWtaYzZvdEdHaHd6bC9p
NVg4WmcvZ0UxMGpJSVNWRXhwZ3pZT3RyNEo1Y0ZnakJ4M1Q1WHdHRm1TWEQ3CkMrRmNZckZSRGx1
MjVRbTV0RXNLVktmQjh5STJIQ1prZEJJREFBWT0KPUREYlYKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000422b3f06311be5e3--
