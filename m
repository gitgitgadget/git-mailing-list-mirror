Received: from mail-vs2-f28.google.com (mail-vs2-f28.google.com [74.125.227.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71AFC31F98E
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 10:56:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.28
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790765812; cv=pass; b=jGDTcPHEgdZ2684BHLbEKUUuq1vjyb2oGvoLutkQnkui1Eo53f+//ICkot1BLBts4dIYBlUQwnRSNXQE0wZkmwZ915LEVKsCm7LxxasKYYCwHgZQlUVXzTo6aQJGZZHFj0r3djdUxGPxWWTBnqc1o4o6A/SX+Npa6MawZQe+o28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790765812; c=relaxed/simple;
	bh=Ufr+OJddAuI6PNrNd3ZbLxx6ypDN+KdEAaCt3aIib8E=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=VGPXF99r9SrZt27XM1GZhBKxhjAbfhJdCTQyaC/7MbDVYYku8lvvSue6VYG3Fx5Euo74FlvXz8BzQQq/AdI8F3gEdr26hnKOSoyQwamwP1doBFdX815/TljtQxPzToWY/eE/KXI5/6DM6RRqUQ+HNHVzjo/+fXepgf0QK10bSsw=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=guHX+kxB; arc=pass smtp.client-ip=74.125.227.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="guHX+kxB"
Received: by mail-vs2-f28.google.com with SMTP id 71dfb90a1353d-5c9031e714dso1913845e0c.3
        for <git@vger.kernel.org>; Wed, 30 Sep 2026 03:56:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790765803; cv=none;
        d=google.com; s=arc-20260327;
        b=YGpDWAT/sUx+yP9ZpMbIvHwZhdMpq4aUVx/oI6YbqWgNCUNabMISp2Xti2YyR6MwPP
         T6XPmuy3nzSFSjCD/FzuWLS9GwzNd/YnPfqIC3qXqieeFMCNzD1MpsE10p7KfJ5Lyhhy
         HdHGBc+xlmJnuoSkfSyxzKk7htrUiB+clvP+d3+U7TPDwfix6Ee1PLaft7E2sUX14W4l
         MQXNJfsng8OaW2FQo8WZMxuYWfpA91RW6hHJULtNDpahfWofRACYh+LM1huRmkHD1pB/
         4dSRq1c1o6ry7AlK/V1lfJymdrFVSo5ecqCTukGPuioErfAh8B7blF1hRAfMqiAnYheE
         SlMA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=dzbG25RhUIwEttpotPz4EgeE4i7PX5mrp1UkvRnAXBU=;
        fh=27eA4UhLMCoSJjmUdOInZOIMGaOzKdSlmUJhXoJkhj4=;
        b=o2nXc7wPfmz/63FWs8LahD3rVozTrOg2h7mnga/3G0OjdAA2jc6VG7iz1AbFcAbyIo
         bWEm88OVepgNRGR7Edq+aPxOsaEZDl5Ap7HwqM3chnscjwgafbrbd6FnCgSEn+d2U1VB
         N0/6S6cfwhdTEjlXnF+Y7fqu+IrJrRxyCHcr1PqabfHkbMJsvnjIZgfOEhA+PbCkh3Z4
         4Yc4DgknsLcwtJd9aZGQznmOnyhROKwwyxkv8khgtDhjYxm23Unh17DNptli9lT2DXpA
         2eEy5N5n6p3uOhAcpknBISBKmMJAxQIa8Ghe/fUDIem1Pb+Wbl6toXXt8Sg/GK/sUsGz
         btFw==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790765803; x=1791370603; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=dzbG25RhUIwEttpotPz4EgeE4i7PX5mrp1UkvRnAXBU=;
        b=guHX+kxBen+t2x7NIMrSiAByw/7zVOxhrUGVn8HGMK7dUJW8UWxEuukJehvdNcKDDJ
         VpF6UX62CRZ1cHC7KAcyLYO8ow9BNC9dp55igqeZRwKX1qylwaXcdS0EGBOXVBu2FniK
         CI3ZOeRu+y1POgIB1PW7vdRbUBaWfrqG1wG03GrsClbYmDDLeb1wNKsv1KKuXA4Rca6b
         FgrCU7JAjITKjWkFIekGWH0rJjazMO4mEoHGWdDTJzltfJxnZv/J/9YcwVtjwJcyBLvs
         yfZkq1Xv4UdJfIbQPv2j2OoYB6+13bgnZOs415kw1bmwgI8ATUiaJwH5tZfw9RS2Rc9i
         SyxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790765803; x=1791370603;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dzbG25RhUIwEttpotPz4EgeE4i7PX5mrp1UkvRnAXBU=;
        b=hKIBTUAgg5KIqBYF2xpu9E7jnXTjTShwPjL2QN/+Mlq1MOIN9xD7KG8IbKrQ1ywjod
         AxPyDxCUFBcJmc6bSwkXGbWJlbFR7zyjk9LCiW92CPa2HqRzikKQ4tdHelxWSuNbawYa
         zYza2SC3TmlxGuSeti8WnMGro+covldek+DmRpE1xfB1M44NGHIHDMKT2dBSMzTjeCzB
         9S/IZhzgLn1t0Pfizz5V1wPJg7hYf42cgDtS9VQsRQmQDhuFnsByWkaKOCJgCfz4Fktw
         9aIkkkJVEz8vuw7dbTB9DKsoKLZPnrPRYCg06o+Kr+2IUKKBLuTC14NU/vTRchyXlbO1
         i/PA==
X-Forwarded-Encrypted: i=1; AKwUvByn2DWd3ZgMMzPPVMkzUbOGPcW/aAp3fipwdvMJVoGPgzPkFUKwWmzzwga1QvNtZ0+1SBg=@vger.kernel.org
X-Gm-Message-State: AFq9FYI+0h4UKs0GON2n1sorjuDBGd1eRWsSxB+RRDZZsEX/AMZAQ8H6
	3pDayeVPZp0mQhRN0qasJ26O0B3qDtMuSwwBJJpRhSgxYO2M9SQZZuBXhLhlb/rb7jELHVYlPRc
	RAPdX7IeWSgMZcHBJ7I39YRZeeC/cRZ0=
X-Gm-Gg: AYBFou3jsL0SXZkxaAoCfyDBamXinTSSpjS2wLsye+U02H7HNuurrZQs1bzwsG9Tqq6
	sRmXAQdByawWxhiBTENlWXe6ifS2HuMsSzvZPldJV/+rJISkfBU387HrKFo4+3fvQKzTML1q5I5
	/2O/3DDFBBxChPxj6ElYVx1dFq6Zx14XLYe+o9cTDtblxjX+GkO9NtOWzvs0D7djyLkSIC7BiNK
	BkfiZFpIFytUAfokE0V9BUwAP5diwgycAekK2a4wZZVzi+zFi34PVpccp0OZg9NT6sFhwSWfyWi
	XBMDCwQkdq1brXD/6eDBoRwd40ZyLjok6o9YB9p2gpd6F3OCZ9lmgrCUkOGc3h1Jot6EwOhBU6o
	ejrInKsT0VvxybujvjJGsgSAi7SpxHq0LIU7xdeY2r7NTHQ==
X-Received: by 2002:a05:6122:46a8:b0:5c8:4831:1539 with SMTP id
 71dfb90a1353d-5d67abadbfcmr184338e0c.5.1790765803304; Wed, 30 Sep 2026
 03:56:43 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 03:56:40 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 30 Sep 2026 03:56:40 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260930-backfill-dryrun-v1-2-1128f247ee01@gmail.com>
References: <20260930-backfill-dryrun-v1-0-1128f247ee01@gmail.com> <20260930-backfill-dryrun-v1-2-1128f247ee01@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 30 Sep 2026 03:56:40 -0700
X-Gm-Features: AclHuK8JCYdANxbgw8V2fS7wJP4H1TNjx9Q59X6Afyqf-5euwsiDMacGSgJQo3Y
Message-ID: <CAOLa=ZQ8hvAxpU6SQ-KvN4eK5xMtJh4PoLXfDiNPmG89GQkMYQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/5] fetch-object-info: add enum for
 fetch_object_info() statuses
To: Pablo Sabater <pabloosabaterr@gmail.com>, git@vger.kernel.org
Cc: Derrick Stolee <stolee@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000951680065cb127a2"

--000000000000951680065cb127a2
Content-Type: text/plain; charset="UTF-8"

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> fetch_object_info() dies when the server does not advertise the
> object-info capability. That is fine for git cat-file
> remote-object-info command, which cannot work without it. However
> a subsequent commit needs fetch_object_info() to not die, to be
> able to fallback.
>

Nit: The last sentence reads a little weird, perhaps:

  However a subsequent commit uses fetch_object_info() optionally and
  requires it to not die.

Or something?

But I think we should just squash this into the next commit. It doesn't
really need to standout on its own.

> Add "enum fetch_object_info_status" so that fetch_object_info() can
> report this case to its callers. It is used in a subsequent commit.
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
>  fetch-object-info.h | 6 ++++++
>  1 file changed, 6 insertions(+)
>
> diff --git a/fetch-object-info.h b/fetch-object-info.h
> index 2fba96c6f7..663a7f3ae7 100644
> --- a/fetch-object-info.h
> +++ b/fetch-object-info.h
> @@ -16,6 +16,12 @@ struct fetch_object_info_results {
>
>  #define FETCH_OBJECT_INFO_RESULTS_INIT { 0 }
>
> +enum fetch_object_info_status {
> +	FETCH_OBJECT_INFO_OK = 0,
> +	FETCH_OBJECT_INFO_ERR = -1,
> +	FETCH_OBJECT_INFO_NOT_ENABLED = -2,
> +};
> +
>  struct oid_array;
>  /*
>   * Sends git-cat-file object-info command into the request buf and reads the
>
> --
> 2.54.0

--000000000000951680065cb127a2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: dcc1c0c32679d4b4_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xODZ1Y1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mL08zQy85R05vdWNxTzRZLzQ0NmNUZzY3VmJIbGI3TwpDaEFHc2FSaFJz
WmVqbFJHZ3NrUDNocVh1SGhmREVnV2dzNXFzaUhIaFphMmxOaTZTSGl1ZFJ2UzF2N3A4VWRWCklH
UGJPSDV1ZDFyQkFPZ0VVRUhnMFdweXkwckJ1RUhpL0tiS2VFOVlZYlNxZC95VHZyYy9pSnk4SVpT
ZExDRysKUkE4cWVPbkpvenMrZ3BxRHBDU0ZSdFhaODg1OHJNcGkyWUJEMFNESWJ4NjdLM21KZzYz
M2I1cnJkQkJtN28zbApMVGxaZ1pnS285RDhWUzYyZE9BS1V3OEZaSjV2Y1EzYXB3VS93ZzQ2MnJl
TGZqbU1Jc2p1YjM5TE8xRy9ya1pwCkUwd242R0NTMFZBWDRlUWZ0THdaYVJqK2JGZWVibzJsbWJS
eHpQa3l1Tk1YTG5ITVRHWXYwWlkxOWxxbjhxVTMKVEF4MXJ5c2dZUkttenFsS2Irc2lSRXlrZ201
a2xIbWlDVUhhSTRIN3RmbG5hb0FZUHB0UjhvbWNnTk80VDVwZQoyNHp1Z24raVFJTDR0QUtFZldq
R2lNaVp5VXpLTHo4RkFHT0RrK1kvWkRRcG95aHBHN2ZEaGUrOVB6Wmg0RWt3CnZaQUxTYTVCdVVn
OUE1cEZnNEhCSXNwaW1HVFpuUTEwZUlzOForbz0KPVhQaDgKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000951680065cb127a2--
