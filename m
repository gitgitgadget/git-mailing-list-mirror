Received: from mail-vk1-f172.google.com (mail-vk1-f172.google.com [209.85.221.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 500871CB53F
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 11:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730805258; cv=none; b=ffsdu8yOuF4EjYdjgxdWP3KeP4xmf5FRmAiOQwSOF+8zWul3IBodUXhCVNqFvFnSD0UrKGRyR4ZzfRInVG6BC6kQ2oh6W3UnyffGz4dWTem1S9SyDctKmuN2KS1fK/UaH1BLAFzBJLGLrlFMf1B1EVJyGWP2k3LYJpjne/B6H7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730805258; c=relaxed/simple;
	bh=WfTvv7sghTgwE0pmS3Cv4N9BWuZk8u/zD3hpAiHHCl0=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Content-Type; b=XbZ8wBCajpcNBRYAPxtjt+eZzUkygKOzFiAkzCzL1/1+PgDEYyIJeKny8v/jnk7DD2mnMZFsPH4VSRlieS2RMDSPcttUKz57p86U2Qh545oKUf+aOnob2AxFBC4BLMt/FAg5irGPTAsvyW1ZnZx2bRYviBbsQj/xKLwxa/qnyr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=LismWTzO; arc=none smtp.client-ip=209.85.221.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="LismWTzO"
Received: by mail-vk1-f172.google.com with SMTP id 71dfb90a1353d-5101c527611so1930689e0c.3
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 03:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730805256; x=1731410056; darn=vger.kernel.org;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bT8MS0GbTvKfyCtTi9gIho480E7ZjDmp3AdwNQGTEJ4=;
        b=LismWTzONZBTylOx6rSEQDpo0Y2LGhzp5LfRs07SixBVZM4ZGNJp5d+nuAvmlnMilu
         FqGh3IQUr5dCHlACbl4nKfFsq548wvY71U3Y0Vr7TTDWiccmVs1hMHwFumY3WZ7d20rq
         8+UJxLEueWlmstu4LpdRfu3Tsh5rgYHWTYHgcqf2tNFff1cLq6amcskMh5VdQNHV99p6
         NquKJwUFo8sGFNfR/7ALtE8TNPyUrfdwdZkn1ln+AwpX/6h8C9NUVPLhe7k90CTno9T9
         Q8k0YTGO0Qw+X5m1KKfPPa85jsSKSux89WWnn4QoSfU3yg8Nu5HJ/eM4NpJOtwf4Y6im
         PUCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730805256; x=1731410056;
        h=to:subject:message-id:date:mime-version:references:in-reply-to:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bT8MS0GbTvKfyCtTi9gIho480E7ZjDmp3AdwNQGTEJ4=;
        b=ixcmKzJ9Vj8afgLcNqvjak3uCypvEE9luD/kZ+SJDg5RJfO55mtHtl540ktfW9s+O1
         zVJ73CAyfenTjdN23SOczZC7S9GyNx5TOJayCbmwJ3NlvHMixdpO+pyqsjzq/4jYv8fv
         y/kClcLaTAfcV5PfPJ+YX+H6nlpNLSmlGPASC+zoScVXY4Q8VqqEXNDWAcdyhkuO2/b2
         spC9heTr5Y0UvPRKHh5GWue30OQazrg0Puebn7ULSTBU0IDwyuW9MEoaF2Cksml/g3rA
         3Mu6uWrm0pN1rqg/AEfupiIOSs/LsnS5g6tCYO0Ala019jaR9ITqnMdMtOpC6xbibac0
         z6NQ==
X-Forwarded-Encrypted: i=1; AJvYcCWR+QI0NHWdFyJJ6bfLi5fd9JOcu40tpdhnhDp8WA/2TIDlmf70k60x2ro3f/eYr2usoPM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRpNCvGzEwOFZAorHl4WiRH2BjIresoFSBdeZ8U4A4XlJn6fy3
	k1nz3dUiUu8FJKK+c9ZBnQHj+yKKs62mm2m4d9R/8SdvQNoDcnM/6EsIKWQXYPGGdc6RTyNi6Xm
	Rv/Kc50xJf/95M4v/bCaDy2552EjE8Huc
X-Google-Smtp-Source: AGHT+IE0j1usY1t5prAvH01tIMKahb9spJigFyKuvGrZeHrlx573ORvrlN8QP+fzywMiU4xzVx0/zosQRwxJ5RFMPU4=
X-Received: by 2002:a05:6102:508e:b0:4a3:d7ef:40c8 with SMTP id
 ada2fe7eead31-4a962d72fecmr14272885137.1.1730805256072; Tue, 05 Nov 2024
 03:14:16 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Tue, 5 Nov 2024 05:14:15 -0600
From: karthik nayak <karthik.188@gmail.com>
In-Reply-To: <b81ce63589e0380baf2b977a6abd706a66b08bee.1730732881.git.ps@pks.im>
References: <cover.1730732881.git.ps@pks.im> <b81ce63589e0380baf2b977a6abd706a66b08bee.1730732881.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Tue, 5 Nov 2024 05:14:15 -0600
Message-ID: <CAOLa=ZQwUGzjmvCv8TKuwbeePTG6+HNjU3ngO6hD8=xSOQ5kaQ@mail.gmail.com>
Subject: Re: [PATCH 2/8] refs/reftable: handle reloading stacks in the
 reftable backend
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Content-Type: multipart/mixed; boundary="00000000000076caa50626288022"

--00000000000076caa50626288022
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

[snip]

> @@ -898,27 +915,31 @@ static int prepare_transaction_update(struct write_transaction_table_arg **out,
>  				      struct ref_update *update,
>  				      struct strbuf *err)
>  {
> -	struct reftable_stack *stack = backend_for(refs, update->refname, NULL)->stack;
>  	struct write_transaction_table_arg *arg = NULL;
> +	struct reftable_backend *be;
>  	size_t i;
>  	int ret;
>
> +	ret = backend_for(&be, refs, update->refname, NULL, 0);

So here, we don't reload the stack, it would be nice to add a comment
why, in the places we don't. Here, it seems to be because we possibly
already have an update which would have pushed us to reload the stack.

> +	if (ret)
> +		return ret;
> +

[snip]

> @@ -1995,15 +2022,19 @@ static int reftable_be_for_each_reflog_ent_reverse(struct ref_store *ref_store,
>  {
>  	struct reftable_ref_store *refs =
>  		reftable_be_downcast(ref_store, REF_STORE_READ, "for_each_reflog_ent_reverse");
> -	struct reftable_stack *stack = backend_for(refs, refname, &refname)->stack;
>  	struct reftable_log_record log = {0};
>  	struct reftable_iterator it = {0};
> +	struct reftable_backend *be;
>  	int ret;
>
>  	if (refs->err < 0)
>  		return refs->err;
>
> -	ret = reftable_stack_init_log_iterator(stack, &it);
> +	ret = backend_for(&be, refs, refname, &refname, 0);

Like here, I'm not entirely sure why we don't reload the stack.

> +	if (ret)
> +		goto done;
> +
> +	ret = reftable_stack_init_log_iterator(be->stack, &it);
>  	if (ret < 0)
>  		goto done;
>

[snip]

> @@ -2462,7 +2498,7 @@ static int reftable_be_reflog_expire(struct ref_store *ref_store,
>  	arg.refs = refs;
>  	arg.records = rewritten;
>  	arg.len = logs_nr;
> -	arg.stack = stack,
> +	arg.stack = be->stack,
>  	arg.refname = refname,
>

Shouldn't these lines end with ';'?

>  	ret = reftable_addition_add(add, &write_reflog_expiry_table, &arg);
> --
> 2.47.0.229.g8f8d6eee53.dirty

--00000000000076caa50626288022
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 38b7a8d98b64df4b_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ0FBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1jcC9nQVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNGk4Qy85Q1h5MlYrVlphTnVHaFRkN25wUGpQS1BqWQoyV2djZGlsUUFM
Unc0WlZMYy9LdmpsbFpjaHFhUWk5K2xzY2pUYnBMNWplSWlYNWZSVkJMY2Jqcll0RHRjNlN4CklK
UTRTcy9uMEVsNnNsMTFPUGcyUVJheDlJN0V0amUyaGF6QklvTjdWUHpZSmxtRG9icWpDQzdYREsr
dGxORHIKeDNmd3VwRkgzR2lDRUhra0pqRTNZTnZaaERrSmtnR2JKR0xhZktrL1VRejFncnNFRkFz
MkllQ2FrSGN3RTlZNwpQWDB0UFRtNGR5RHFRdnNTbEMveWJLSTRNVzVtSkNUbG9BamIva29xMGFt
M0Z1dmQ0YksyN2htamVIR29hRnB2CndrTGI3Z3BDcFdueU5tMml4ZTRaWDcyeWZlaHBTdXBpRGJI
WDEyUysxQVVPZ0xoTU5ZY002cGt4c2xZcU1wTGcKUER1bkVKYjJ4WVFISTd3UEVnM0l2Z0RTdWJN
eThLcEgzV25jdUtQaTZ4ZldYMGZYbFc0QXFMbm1sRzRjVU1lMApwcFM5b1prbmtJN0xzaWYzUnBv
YURGOVdUa0FLSWFhMS9rS281SWMzQnVSMjRhNHpLMDludmdYRjJ4OTQ1NTZVCjFYOHNsNjBDSDQ0
UWlTd1R1ODdBeThRa21LY1RaRlNsUWFkRklkND0KPUE2aHEKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--00000000000076caa50626288022--
