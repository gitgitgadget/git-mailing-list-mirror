Received: from mail-vs1-f44.google.com (mail-vs1-f44.google.com [209.85.217.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20E2227703E
	for <git@vger.kernel.org>; Mon, 12 Jan 2026 10:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768212064; cv=none; b=hryK95U2RK42IECQTSJTwZF75Op0PD9OoimuCAuwmhoI8QkIVJ72ds4rAvF9fmyC1CFBuzEP1jMxgJmBr8ri4BGKDUlhPdjfzi3JbV/n8u9/Uv513whhCbl24LN08zlHJiveO/T5rshRoy2U4gtY09BHR67Q5Hrm9yR6oV1/ACE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768212064; c=relaxed/simple;
	bh=dN97fiRqpetsi+vsFDRw6cFvx9Lq05NOBVERrbUMRpo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=iUpY8e7tn9DOIXJKI2SgZbftzYkhGRz0hpUMANtLXUl3PB+0t7MAcNCQ76pmHN1YiDUBuZC/AeHlW1TXeemvQHANugZxKknUlkz8IteIybroefIZ3ofJwDnp7k2B3TEGEpFwz9NmaAokDf4wBeDr197oMGh2XrSfWYVGkAFNLAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=b/aXw5gI; arc=none smtp.client-ip=209.85.217.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="b/aXw5gI"
Received: by mail-vs1-f44.google.com with SMTP id ada2fe7eead31-5eeaae0289bso2438368137.2
        for <git@vger.kernel.org>; Mon, 12 Jan 2026 02:01:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768212062; x=1768816862; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=Q6mXVAv3fpde1jb4cVv3f65awSuHHoE5YBp1CA+isr0=;
        b=b/aXw5gItD/cjHk14MMHQ9OHCKDwOZC6WQd1QleWSG4pUFdDW6yOCa3+CZMbaCM8JS
         WHmTuj+sElXk63jHysxG+Ug9YtCRtBCxw89D2Mah1qytcpWn59DN0UfJDZNHH97XMD71
         4tNi2WjP4ecOFNNLXVKfFaiNgWtqiGwvXkEQHFndDMjouLn7Coc17eM3IpuVzqMrDpOT
         8H5CQHlg8pbpSsT6jukJb/HxPZjk205X4c2rvWSS0jqmUXCUFYw1ksia18XuLKNcUPOQ
         77+MpfvBX3ETUELbeILq0FCv78flwrnprMyf5Y0V6UZmso7o/oDiU+Scb707b0dyMgDv
         TX2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768212062; x=1768816862;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q6mXVAv3fpde1jb4cVv3f65awSuHHoE5YBp1CA+isr0=;
        b=wpntWVsMOTJjAhrYDngVCIQ6pOXS7YGkUqD5zeavQ5hto4AAKdD+3CO0+tweagbz9b
         nyF0NGwWLtCc3cLPQfxxicxND8uh9GEb5wq0Q21iwzBqKB11MHgCs2FRW0bIpeB8RI1V
         x2fjKiL74+MrcP6j4Vz8qY7mwD3KeS4jo6FqrclUEqWixFiuE6m57OjdYPqZ3hOSrPY3
         h5E3bQxlgV//h0T+MqcHvyRObEIYgGCjmTaHQwuyxt4AO28IZvt6symEDqZsIZeta3IJ
         q1gOySNKotZ9BLdVUJacguj6zjeO4IuUn8H+4m7e5KGRFmsTGxYWt7ePPpp5MXsvFeTY
         bExQ==
X-Forwarded-Encrypted: i=1; AJvYcCX7zFmbOiOZ669hzwdy6rJXPsFPWYkVdgOkSNu+ZtAZXgCAjbsPQNPJ2VWS2XSzIZI4vAA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxMesTeS6RfECec6z+Ga7HSI1bhVnEw+dz41beDDDgjXQUWHCgl
	SS9KnNApwPKXbWjHiyb0XGtKapbjQ/2I7NVeh39ZvxA7Gcbe6NKih5UdP9i1/Y3Q3cTTLegs/HR
	Fkjo433vtoC5Ca8oDvpxIAIqchjZ0ImY=
X-Gm-Gg: AY/fxX59MqfE4OHv7UDavGaNRaG+YaTFPAUMRwOS9I2LVAuF0UlMXBej/tCDp/7+frJ
	Ed7KlJpjgLxJNgz0frgEBUP12M6DeVtTKDIESsGIAIruUYYYgbDR9HoatetUbb7ERCxXSklN0lq
	bSAxXt54Eg5g/4YLIHI448BE4U/Ed76QAwGmV8ZuZX57kkaYzEEfS1E1WIyA4A3taSewuPPUcnp
	9OkLUwq3FlMEn51rD1iaZf3atwipy0asYjMeh4XTWsbSDl6BpcTTPNgESnwdLVv041zRBdFcRi9
	FtYbglu4nb38pm9u+80DeeRQ3aL+J8l7SgSK4V20
X-Google-Smtp-Source: AGHT+IHsAn3hWHZ24ThsJ3tYYJMI/o3IEFjnWfE/Qr9SUhjkZD+VOx/fbYM6cAWJSlvlBFNwasuB01MffuiqrdlgWu8=
X-Received: by 2002:a05:6102:3a14:b0:5ef:a59e:617a with SMTP id
 ada2fe7eead31-5efa59e6280mr3580395137.21.1768212062009; Mon, 12 Jan 2026
 02:01:02 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 05:01:01 -0500
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 12 Jan 2026 05:01:01 -0500
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260112-pks-refs-verify-fixes-v2-4-2e9e453bd6c3@pks.im>
References: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im> <20260112-pks-refs-verify-fixes-v2-4-2e9e453bd6c3@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 12 Jan 2026 05:01:01 -0500
X-Gm-Features: AZwV_QgqCCmRc9HOM6FXPZ8z5rsyXUnpgIWDqwL6oIkfqNsRm_DTsqLXAxXoRbA
Message-ID: <CAOLa=ZSGd76M=Dj0E512w23rtGM2eEvYeMMCzFffh-oNJ4br-Q@mail.gmail.com>
Subject: Re: [PATCH v2 04/17] refs/files: remove useless indirection
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: shejialuo <shejialuo@gmail.com>
Content-Type: multipart/mixed; boundary="000000000000d81dad06482df34c"

--000000000000d81dad06482df34c
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> The function `files_fsck_refs()` only has a single callsite and forwards
> all of its arguments as-is, so it's basically a useless indirection.
> Inline the function call.
>
> While at it, also remove the bitwise or that we have for return values.
> We don't really want to or them at all, but rather just want to return
> an error in case either of the functions has failed.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  refs/files-backend.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 0a104c7bf6..4cbee23dad 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -3954,22 +3954,20 @@ static int files_fsck_refs_dir(struct ref_store *ref_store,
>  	return ret;
>  }
>
> -static int files_fsck_refs(struct ref_store *ref_store,
> -			   struct fsck_options *o,
> -			   struct worktree *wt)
> -{
> -	return files_fsck_refs_dir(ref_store, o, wt);
> -}
> -
>  static int files_fsck(struct ref_store *ref_store,
>  		      struct fsck_options *o,
>  		      struct worktree *wt)
>  {
>  	struct files_ref_store *refs =
>  		files_downcast(ref_store, REF_STORE_READ, "fsck");
> +	int ret = 0;
>
> -	return files_fsck_refs(ref_store, o, wt) |
> -	       refs->packed_ref_store->be->fsck(refs->packed_ref_store, o, wt);
> +	if (files_fsck_refs_dir(ref_store, o, wt) < 0)
> +		ret = -1;
> +	if (refs->packed_ref_store->be->fsck(refs->packed_ref_store, o, wt) < 0)
> +		ret = -1;
> +

I wonder if this should have been a logical or instead of the bitwise
or, but then we directly return so even that wouldn't work. This looks
good! Thanks

--000000000000d81dad06482df34c
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d3b87f6687d572b2_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1sa3hsc1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mMXdyQy80Z3lEWU85Qy9qUFd1VHlyLzZSK0RsUVJpbApwMGJ3clNCWk1n
RTAzdE5ZT2h5ejBjLytQSnVUSkR2ZkNiSldCSjE2VUg5cDdtdkhTbU16SU9aSXF4dVZ5VlVJClFW
ejNMY0VpanVpbEtOZ1BzdUJHMDVSTk9wbXFpejFFTXJDZVl2WHp1MFdMekYwdVJMR0tOTC9idE1W
QmJNZTkKVTdwTGdTci9qSjEwRzRpWW4zeE9JemFZOVM0L3p1ZFh3R2dPdElRN0diM2gzSzlFcThV
VCs1c2pTcS9OOG90NQpoYTNMb25IRU4yd1pHUjlJNEZKNTl3RmI4ek4rZFNpZVJpaEpkaVJQZHhC
Vk1ueTZpQTZKMGxhN1VJUnJldnlqCmVxRTdoWkZzSzlZLy94QkdUa0lBTkY3RTVZNEpZeXg4bEc2
Z0hEWGJvS1o0TjV0ZktLY0Z0SFUwTHZLSHFsTnMKZVNiTVM1OHh4WjZWK2JXNHVSWHROSTM2VjBV
eFNTdzZyWlNrYU8vclQ5QUZkdkNwT0RVeFVaNmlodm5PeThwegpmY2ZIRUZGakpQdEJnV0drcVNW
MWd4ZVFycWdLS3VzRWp6L2prOUdXanJHRHpwbXNiRlFsV0NlQ0RianlhRlE1CmdDVmMrM1Jvd0Zp
ZDVKVmY3eFk5Y0ZxUjg0OER0dlI3L1V6cTZBQT0KPXcvYWwKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--000000000000d81dad06482df34c--
