Received: from mail-vk1-f177.google.com (mail-vk1-f177.google.com [209.85.221.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EE2F330D29
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 16:07:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.221.177
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780934849; cv=pass; b=QyERr2NgfjPNahi1dXUkVGEbA559brwAyPC/Tzmzih+x7g6dKxLBiXCpPRxwik4SvfVBA1xdKbXn4gQLf6HThhgvLvoNu5AnqKWuMasUO8dWZqoBC8bDeyNGED5Lch2Iz2yElcsZr8M8undrFO1hYyLPQYCwtTxOA9i8R2VcUAg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780934849; c=relaxed/simple;
	bh=eVpbwC/dwUkY+6FMSwLnANwFjLXhmtELsL3X2B1vmps=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=uJ3s+1lRJKsjvab7ERq+yIq2gc/7HF6Xqna+JYfqeyI9W6IB6Mw/8jH5xEYfifLVoYs5warx7LxoWDQsexeD+t9wiShxC3EShgILSzuSAfDyF7p7/1PPeBVcRRYnfVlwJikM5MKh3PQigk8/pGOdwYJnVh8jXk762DzgY3PKH38=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=f5WR04IF; arc=pass smtp.client-ip=209.85.221.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="f5WR04IF"
Received: by mail-vk1-f177.google.com with SMTP id 71dfb90a1353d-5b22b023e1dso913058e0c.2
        for <git@vger.kernel.org>; Mon, 08 Jun 2026 09:07:28 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780934847; cv=none;
        d=google.com; s=arc-20240605;
        b=kC0CuS/zjzjDEurYBKULkbnV81CiZR09wu7573iXdlca5CEWZww3dpnpkqmpx8pzkW
         ZYhl9Tz4x3jkW9M1d2205YP6aqCxX7q0i4fMf8RMrrpFg/WjdmMrH9rTYsBHV3XsqXYy
         EcYGY3+7EBha5cHzBNCFxymbDdqTm7a2HWI84ZCA5mBFE2IUgy5ALk+Xj+UU6JOfUpXH
         RXiPgBpIcCvHtRCpc3Tin0TCq5xPh20a0kxHV0I5G2CdsxDnr/9XQ3BaZCDbXNJp+pKJ
         kWoh8I6Em6kDX+6LEAFVF0RoaL2ox/oAqwUdEnpDW/uYTi7udyV1x3k/32YqdTPlCXjK
         HY8Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :dkim-signature;
        bh=IA0tzTz46Pkf4R2VaK1c8NVYsk+5L+Y7yAo2x1AEAS8=;
        fh=BQmkZ+298sngkbG0tVdQ8osEu66bc0cgEv252sCpxsA=;
        b=K/g9vws4+izeywLOY9kX5Jex5gHqisCFtqz+zXOc8YTRZHbSCdET2LxcKHCeaJg27U
         lIbs8u3kTE8lpwUHHHWFjVr3PVn9JAYZHEFzfwXKeCQMKypAbFpjZqA9iy/nn8l7dl30
         4mPQ2cucq7OJxmyNQndWQ52XMYlbAergZiDtA1vGqAMi/XbdWFn6wyjfKH0LrsT4+fis
         lbpHWcclHNNsEcCXnquZFaSltWhYucEcy5BTjOa9FJ1084KEy+5z182KJPLVZCeheVWl
         Hw5fdiyavMyI7IeS7770soCcNXK8/ibbjbrYrUIPu8L787+aCzeeXvDKhg3YBvXu22xK
         ig+A==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780934847; x=1781539647; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IA0tzTz46Pkf4R2VaK1c8NVYsk+5L+Y7yAo2x1AEAS8=;
        b=f5WR04IFEGIRMeuALRfKUaq+nNezK7leZ5pv8fpQDI4uz8dkKfHXxqIZMSD6l4zBOl
         FkPc1mJ5GKKheio8lpVbRD87Yb7gu3hzPc4dJt+Tn0ALQ10u0XBZJ0uUT2Neb7GekOWK
         D1wACbjRf6pF/6D8ASBaz1sZMOnEmSpkK/FdcacVqIxlRJ2/rc615iccwvKxaFl6VN/j
         JcrnX3mEvJAfzTAbqW5MG1by3jSSup2S9ehDCtkwQL0/5iTqpARbCEzYBf+c4hMTVaim
         67JbioCrHyL2VV9+LC8XbN3JfrKw4gUAQirDvrRew8kVPMcjLqMR8GTZisaU99atTi/l
         127Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780934847; x=1781539647;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=IA0tzTz46Pkf4R2VaK1c8NVYsk+5L+Y7yAo2x1AEAS8=;
        b=mZLqzpVeHfeIT73+ePPGr+doGnuAu1dVVdjViI4tTWyDf9EbPA6RCjwelYAllfw19m
         W3pPRMaS2B8KXICFq32KG2R5aL9vrMTJPblj27k9y4HgORDXBCy9xbe5k5ND5/b4GG/S
         cjjwQ1ydlAbhRcu7+0l6FXwXY0DGz+S0iVsAaibJQIRLLfFb5ic5G0839mSh3Os/TAd9
         bv+sFY/iFziU42HJmDZtHVklP6YSzyNzQZiL9crhi5ndVCU+4HC8EpcWX58ZkYtqQ8TG
         RAtH8OxX1gqY7SV+fFjfYMEneSB6XuFZB3HJVeOQJJwiytYN+LAg0vX0KFgyHbqImBQ5
         Vq8A==
X-Forwarded-Encrypted: i=1; AFNElJ8bSvQTyeteXoGAMY1woLuhoHnUVRgOzlp2v5rX59L0Ttca7vNIzN0m8nnOKqBk5yynonU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwiZ3VK5fdg2iDTTFYL8ZOflJ9BoPqdFSXIqVvrfWDHEKrGlxCJ
	wj90Fj5ntJlbU93EPZBJUd2frfIlcEUVkMB0z8lNVzey02VZaB50YmkocEpkcAh7iKzkTg3EOI6
	wDdJ0exQspeWodRZYHkVnOrfZX5nxBac=
X-Gm-Gg: Acq92OEbfKkZwaARduqSevlxkVMDpOEoxWE3ot5B58BfSIovvY0RGsgZN9q8Rua+iBr
	8AG02+nRd0hGFMskuPtaybP7MbxyJ0juo3kAPsLR0HnTRNdRKPdpGimWJ6HeIFMBhhQMNMlgxU7
	3+vwA/HybnhinFZbt0JOboJbzhLFgv6N9nUK49fNcrXog0rWv+iaTH3YSEGB8RfAu8AZ7eZ7Ezn
	WIcuF0a/IyC0fM63AZ/LIXsts2rJRbXun6PYXfcg64c9ZpmBHc8ZHZmTgY2SCJz+T11E0Lvhvhm
	rzTjfN7zmYRo+blT7bFl+KrIl8yTqIIuLHXHee/7U9ysPxhAp20NW5bWQhMiqYFpU6TJbJIbup1
	VjpW7+OGC
X-Received: by 2002:a05:6122:2090:b0:56f:a329:6859 with SMTP id
 71dfb90a1353d-5ac50601612mr8039478e0c.7.1780934846786; Mon, 08 Jun 2026
 09:07:26 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 09:07:25 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 8 Jun 2026 09:07:25 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260604-pks-odb-source-packed-v1-7-2e7ab31b4b5c@pks.im>
References: <20260604-pks-odb-source-packed-v1-0-2e7ab31b4b5c@pks.im> <20260604-pks-odb-source-packed-v1-7-2e7ab31b4b5c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 8 Jun 2026 09:07:25 -0700
X-Gm-Features: AVVi8CfEcyCakHvPwNOeAVAGCHubm2V276cGRjOpbRF_8Zcl35vcMqH__wC6O6I
Message-ID: <CAOLa=ZR_nq64=HUPYdk9SXYi=Y6FpbTD8P7R+Bm5QmDCRgnF1w@mail.gmail.com>
Subject: Re: [PATCH 07/16] packfile: use higher-level interface to implement `has_object_pack()`
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="000000000000e98d040653c034a1"

--000000000000e98d040653c034a1
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> In `has_object_pack()` we're checking whether a specific object exists
> as part of a packfile. This is done by calling the low-level function
> `find_pack_entry()`, but this function will eventually be moved into
> "odb/source-packed.c" and made file-local.
>
> Refactor the code to use `packfile_store_read_object_info()` instead.
> This refactoring is functionally equivalent as that function will call
> `find_pack_entry()` itself and then return immediately when it ain't got
> no object info pointer as parameter.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  packfile.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
>
> diff --git a/packfile.c b/packfile.c
> index 902b7f70f2..3ee71d7f71 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -2132,14 +2132,12 @@ struct packed_git **packfile_store_get_kept_pack_cache(struct odb_source_packed
>  int has_object_pack(struct repository *r, const struct object_id *oid)
>  {
>  	struct odb_source *source;
> -	struct pack_entry e;
>
>  	odb_prepare_alternates(r->objects);
>  	for (source = r->objects->sources; source; source = source->next) {
>  		struct odb_source_files *files = odb_source_files_downcast(source);
> -		int ret = find_pack_entry(files->packed, oid, &e);
> -		if (ret)
> -			return ret;
> +		if (!packfile_store_read_object_info(files->packed, oid, NULL, 0))
> +			return 1;
>  	}
>

I was wondering if there would be an added cost of actually obtaining
the object-info. Seems like there isn't, because we pass `NULL` for the
`struct object_info *oi`, which means it will return before reading the
object info.

>  	return 0;
>
> --
> 2.54.0.1064.gd145956f57.dirty

--000000000000e98d040653c034a1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 4521610925501f7d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1vbTZMc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOUNoQy80cW81c3BkNHJDT2VBaDlNQWtHOTh6ZE5uegoyaDVwRkVYc2x5
YkNrdm9oNEF1NDA0Vkt2NXdPRG5HL1JqSWFMUFU1MWVycU9MUllCOTVKS1E5cmlHNzNYQmh1Cnd0
cjZEMU1OdXZKNnBHSVhobHF2alNqcnlyVithZmRxM0NoSklreEkzbVh5Q0x6YW54eG40MG5RVmZK
eTNxOTAKcE5pTkdERDgxcDVPMjNxWk9jeGdGRGdGUXZjd2gxbmZmV0ErZVNETXFjWks1YXVVaGZW
MlRJK2V3TVV6bEsxUQpIREtYSm96cjBSYXo0aXhJUTdZTzdFOGcwRlRPTDZJWkhLV3I3dDU0VXhH
S3hVTy9OTDBSci84c1lrQ21FZEs3Cm9iZmZiYnRpREc3VTgycXdyL3hBTEJtczVIbVdZbVNmaHpS
ZzFzc2RiMnFRK1JJVGllNmVQSWF4WXV3ZUNYcjYKb0IyTkMvMHpuQzFmalhSTGE5cWcwZ3paZFRF
c1Frc2xDQWJpTHBoYXp5aEYvRlZiVjAzQUhYa2FsdWprY3JDNQpFcGhmUktUbGwrMlN4U1NWckRn
SmdoNmdtanBsMlAvZmRjckJYbHV5SWZzUUEranZxTEIxSy9LZFZBcGlQUzVaCit6Y2Q0ZjZFQUFG
Wk1wU3pqWDRpMTY4YnpyVUVEMW9PUmdEdHdWRT0KPUx1bE0KLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000e98d040653c034a1--
