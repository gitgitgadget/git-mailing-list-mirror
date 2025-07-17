Received: from mail-vk1-f174.google.com (mail-vk1-f174.google.com [209.85.221.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB98194A60
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 19:49:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752781776; cv=none; b=aqW5qm5JCUa3CDAd9QDP9cx27uOz5PXGuNPQ6qELsesqOJrHoiWepO1l99W1zmMPppFQ2NkB1VlkeQW7jd7HZgFehZ9D9AJdd9Q2WLMHqUp4VjI0yEPnSizEj1qedgPcwecRw16ecekoeggVT/pZ8YCfBqUulCMTjS0eT3G+BKE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752781776; c=relaxed/simple;
	bh=Myk1QhzAnhwtncqbdinGDjcFMdelnJp9AaA2c896W7Y=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=gS+3qBXb2el07IHhv6IxwJDitcwelthfKipKE1dg+e//+FHKL53hSODiY3z3p0ntGb04BfNYSvWf04qXFkCTiWucRq4w2bVMyspQckNUx62pyo1fddjyciY7pyGifB5Lv0VDz6atWpmvtNEznD2XtdSw/ACHm9lvuOHRJW7zV4o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LgQvQxjF; arc=none smtp.client-ip=209.85.221.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LgQvQxjF"
Received: by mail-vk1-f174.google.com with SMTP id 71dfb90a1353d-531426c7143so671576e0c.0
        for <git@vger.kernel.org>; Thu, 17 Jul 2025 12:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752781774; x=1753386574; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=8OG6Xvsj4MJLo368+QrvzZJ0VjJuRcgVbOJ0HiCv3/w=;
        b=LgQvQxjFd4eMP5FhTQZsJAAnY1bd5jgKJDlsctQ4I/qs51iOEOGXdj2qAgTvWwAhlM
         FEEtmT2FTm595G/7iWyU9KmzTB5qTwfldWCzoOYBQZDwqzjlCHtoaSakBJWr8pzoBSQe
         aIia4TT8vneyavyz/0ZGmF6iHDgwnbt/KOrOte5SZCQX2QC0YijVF6ypxaszzAtgw0QO
         g9L0vMgJADogeswXJ0avImWCI5n81ruf0sjyEyUIMWXuNaQChOqEZicvm3NT34bjHxAD
         fNhQXAPhcL6i7FoR/Kq0P1Gi27EHzVl72IyJsne75GHYlw8guOi9zlATWjGJGwKomcIh
         fn+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752781774; x=1753386574;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8OG6Xvsj4MJLo368+QrvzZJ0VjJuRcgVbOJ0HiCv3/w=;
        b=vAOWmnYCJ8dvFhEfqk1JhXoLTn92vD0svGjpnlBthTMcy8/HayVFcL47k9TEiC8mB8
         RMmaU+NVsghTRk4GvHnl5W3JrCHK1ZtwuDGhaA5ADYiJujymCNqs9ZdcOkbhFoHEomnD
         SgjoEyCl5ajnv/h5IaB14kunBmVKEEp5SBDb71hH7pbnzXlCfodYTAJBC5A6KAP5rAEy
         j6j/gNvByt8AXn7gni6Fm/E+wSrFwwFcOVKs3AfUSm0FKmE61DGSm+4OO/Zrh+35vcMR
         XGKsH5mS/rxKlR+AmqoATZaA4LqpA4q09KKueGDQVkKHqS9n/iJN9wY7GHsHSrZDiUX6
         jQag==
X-Gm-Message-State: AOJu0Yzs1lthhTj9c7kz2AH0R9mBrrhRGTGmeKMhzbxKt9QFCDVb2Zw9
	HhkpJpNNd/GY7tYdSiQFf6Ud9yKmyWjcAm6WtqTBICbiq44khyEBj4dhqwrurV5xfo9ag+MRcwg
	s5qEQ11AfbSp5OkCIISk3nLQORhYVAec=
X-Gm-Gg: ASbGncsRaEN1VV2vlDNVuSJrr9jDtK4BmQCmFDta+3o5wR3b3kWe7kE77aH7S3VzqEz
	XVT+jlULdfXYe1k+5TyAjwH4rPmQinBBb0XZBfBk2YUoUrngBi65ZQhNpVPfz1Ab0NQV4QYUoUN
	FXe4CDDMiHTrLFl33TSYK9USgUyIDUSTvYeRnNMfSVKe3S1yKunAYe7FsSvpIe0VvWNf3JZTPjZ
	y5NKFJ7QAo2JbH3/ryxCK4s38XFmTEyncRl+yzN
X-Google-Smtp-Source: AGHT+IEzpnL64elDT5E/cOU6S6d3+9iMtG6hlss0fXUJo0jIq+qiQfWPgvx+/yi5+mmcFFuQu1PXRoo8mUahNEUb9GA=
X-Received: by 2002:a05:6102:f82:b0:4e2:beb9:191 with SMTP id
 ada2fe7eead31-4f95f41795bmr4756979137.20.1752781774066; Thu, 17 Jul 2025
 12:49:34 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Jul 2025 12:49:33 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 17 Jul 2025 12:49:33 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20250717020905.GA2193264@coredump.intra.peff.net>
References: <20250715-306-git-for-each-ref-pagination-v5-0-852d5a2f56e1@gmail.com>
 <20250715-306-git-for-each-ref-pagination-v5-3-852d5a2f56e1@gmail.com> <20250717020905.GA2193264@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 17 Jul 2025 12:49:33 -0700
X-Gm-Features: Ac12FXx3TdV7jlHlXLqC_bIsq5R_xTm92tCvevKYRouaHZc5z0IAKjhgxcvhXP0
Message-ID: <CAOLa=ZTdUsv-6jVhPSwEW5dYr3vEh2bLT5ECRZZ1ot3MGAYhBg@mail.gmail.com>
Subject: Re: [PATCH v5 3/5] refs: selectively set prefix in the seek functions
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im, schwab@linux-m68k.org, 
	phillip.wood123@gmail.com, Christian Couder <chriscool@tuxfamily.org>
Content-Type: multipart/mixed; boundary="000000000000033403063a254fa7"

--000000000000033403063a254fa7
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Tue, Jul 15, 2025 at 01:28:28PM +0200, Karthik Nayak wrote:
>
>> +static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
>> +				   const char *refname, unsigned int flags)
>> [...]
>> +		do {
>> +			int len, idx;
>> +			int cmp = 0;
>> +
>> +			sort_ref_dir(dir);
>> +
>> +			slash = strchr(slash, '/');
>> +			len = slash ? slash - refname : (int)strlen(refname);
>
> I was looking at this code due to a nearby thread and noticed this funny
> cast to int. I guess you added it to silence -Wsign-compare, but Why are
> we not using a size_t in the first place?
>

That's an oversight from my side.

> This kind of conversion can sometimes have security implications because
> a very large "refname" would cause "len" to become negative (i.e., if
> it's between 2GB and 4GB).
>

Indeed, I didn't think of that.

> In this particular case it ends up cast back to a size_t via strncmp:
>
>> +			for (idx = 0; idx < dir->nr; idx++) {
>> +				cmp = strncmp(refname, dir->entries[idx]->name, len);
>> +				if (cmp <= 0)
>> +					break;
>> +			}
>
> so we get the original value back. We'd still get truncation for a
> refname value over 4GB, which would presumably give us a slightly wrong
> answer. But I don't think we'd ever look outside the array.
>
> Such sizes are probably unlikely if we are feeding filesystem paths. But
> we probably should not set a bad example, and just do;
>

Agreed.

> diff --git a/refs/ref-cache.c b/refs/ref-cache.c
> index 1d95b56d40..3949d145e8 100644
> --- a/refs/ref-cache.c
> +++ b/refs/ref-cache.c
> @@ -498,13 +498,14 @@ static int cache_ref_iterator_seek(struct ref_iterator *ref_iterator,
>  		 * indexing to each level as needed.
>  		 */
>  		do {
> -			int len, idx;
> +			size_t len;
> +			int idx;
>  			int cmp = 0;
>
>  			sort_ref_dir(dir);
>
>  			slash = strchr(slash, '/');
> -			len = slash ? slash - refname : (int)strlen(refname);
> +			len = slash ? slash - refname : strlen(refname);
>
>  			for (idx = 0; idx < dir->nr; idx++) {
>  				cmp = strncmp(refname, dir->entries[idx]->name, len);
>
> -Peff

Thanks, I think we have to typecast `slash - refname` to size_t, but
this is the right way to do it. Thanks for the review!

Karthik

--000000000000033403063a254fa7
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 95f5795029fb4b5_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1oNVU4c1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1md005Qy85ZFYwVXBKNVBMN3ZXd0M2aldCZ3dCdXJJLwo2M0hINllNejFN
OHZKWWE0Q0VobXBzOVpZZVdoaXlZRzY3OUwzazhyYk1WeDdGOENmZDRObXlRYU5SYlBVOU9HCnhs
R0JLSmgxNlFtTmJNWEQ5RTczNkMrdTBDNmZSRDdtWjU4NWZtVk5GV3Nzb2wxSmZqUDV0ZnZhRmZM
OStVRWUKaVJNUDBhdnhId1puWkYvdkRoRlVuWkRyaW9PczlTWHhZZk9yajVXSFNabUtTOXc2TEVZ
S01KOCtnVUxlYXArcgpPZHpKL0tQNGFXT1VQTmZJS0g3TTdMVTVCdEJxOW5ZQWNMVmV2TVkvSjVa
WFRzd3MwZXAxcjErZHpmU1pMTDBvCklYcTVJaE1DV2tFNFd1WmtFNGtJRENoU3ZBMkh0ZFBOUTl2
U1MrNjRQVWRpK281dG1HNk16eTRwZjY1cmNGVzgKNUZvNFRsYTl3SGdnTXdYTGNidzJ4SFFZL3Nm
WCtqOXpUcHh0blNraWh0bkNVRHo3Tk5hUlBlUnNKSFgzdHJILwoycHlCamMvT0FjMGk3aURKd1Zx
THlRNXNZdUxnSDQ5VW5zTWtZOGZvSU16Nk51YytLUUhtSGNrNnFtTnl0dFBXCmZ0U2NYR29vNFV4
WFlMaDh6QVV0Z3BsdFB5M2Q2eDY5aHFlQmtnbz0KPVR2U2kKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000033403063a254fa7--
