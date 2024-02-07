Received: from mail-oa1-f54.google.com (mail-oa1-f54.google.com [209.85.160.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7BE520DCC
	for <git@vger.kernel.org>; Wed,  7 Feb 2024 09:27:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707298061; cv=none; b=OAXMmMx5Gms3VmvtpQUKnbpf/mHYHhvJ8HzyaxnvkihblJ2IrnLX4C2dl1spodV4kpYxh/yaAFB54RA7pvfbedO5vQCoIZ3amNgU23Fxfv09GlOCMtC/O1nAhfi/Yyg5K+jI85vFN/e4SOOf0NsY8suxlP2zdOZajFKFWILpe7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707298061; c=relaxed/simple;
	bh=UFq1mY6BJ/2qfxJpAH3LzZWcJybbGqtTi4k66ybPNk8=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=XdSX75NSt0b6LQGDSYRDPE3KAMga3j7fmt0A2s3TwFC8dYp1RSpCPvrz8KNFzy0VfccLScz9zMEq7c/+K8kxB3ddoilopTAMGtLkHphJ3iCs5/BMLOJsPPAzsZj8rneEMC+4nnBdIlMt9Ur1YHVtmCS4goi/yo+O//nux54U4Qo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=A5rA4Wv3; arc=none smtp.client-ip=209.85.160.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="A5rA4Wv3"
Received: by mail-oa1-f54.google.com with SMTP id 586e51a60fabf-2046b2cd2d3so379343fac.0
        for <git@vger.kernel.org>; Wed, 07 Feb 2024 01:27:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1707298058; x=1707902858; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=9PNWgqYNVGdC0kjODb9Rg6inil5qhNoQ+l3UHD6/04I=;
        b=A5rA4Wv3HFL20IFBHTMz5n+qK8cjbA4bsoOdhanuPTEP9h+4Ae0R79QySR1QCLovyd
         b+SUCa6Lb+RjMSN1VeaLPv9k2itBsyPvhxypZr51p5MLedwJ53+UJphSgRh0T6iQiXEI
         Tnc1pVnBDcHSG+4pVtQN/i/o2opoeYh0pgrdxhlohPXSxrLp9UdUZchXd0B8akWDsu6V
         F+qI2RoQCs4Um0pKStqWa8igDaDraNQtJZNnY4MDuxdoPTjGiMHY/5vOEYFHiMvFQPC2
         y6cHk59XDkBEvTv3laifkmLF05FdZV/owgZHL751eAB1mZzSxG0IvF+iDBWrgKwYz6zz
         aO/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707298058; x=1707902858;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9PNWgqYNVGdC0kjODb9Rg6inil5qhNoQ+l3UHD6/04I=;
        b=oHzuENqr/9N+2ZdiGYdNrqG0yu3/wFSRPUK9nLoFxeVPJn63jtrXGyNb6gPG++9YG4
         2Z/b732qKb9b9zT3hjt7FapqfC9aMdogJ4CEqacwe6QNSIOOOkyIbMFenktSLHoyCKU5
         CYP3GB5THwVkhcC6qCabeG36PbKlLkymf/DGZxg8eMvMhzjfEFNqEOZcAQy6SHXU915x
         vImkBVWFI0CE3lj0VwaCTU0imS3FvHG/PYP1qPY+lpJfXZRXX6XUDqOl/+VoMM7wLaGA
         uj8lkQzzf7AGvHOucgDKIC77b0s44Dv+I7zggrHKLGVaNgt0TwBC3aSdrCBI3MiDiBeY
         H+9w==
X-Gm-Message-State: AOJu0Ywf6HyqnbF2wCTPWenx+H+gNxfD9M41aIDn1EbJn0QeWdjSLb04
	eBziL9kmJLmveWCr0pT1Ikwf1EkcOt7YyaIMJ+S8TarcA0tMNAm/hkeoiUm6gXbraveK7kZJr29
	/XGNy+/YTZZgoWGf8nlPqKlgz+RE=
X-Google-Smtp-Source: AGHT+IHxACVLhvgTrgDiKZjg7wxR1efp3ZKgahv/L/KO9Xe+YGKK1y2uX9c3QKOTHTZ076cVRYFGWZPJhVPRWlrScvA=
X-Received: by 2002:a05:6870:498f:b0:219:5ce:3a2a with SMTP id
 ho15-20020a056870498f00b0021905ce3a2amr6338216oab.50.1707298058484; Wed, 07
 Feb 2024 01:27:38 -0800 (PST)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Wed, 7 Feb 2024 01:27:37 -0800
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20240207014819.GA1399428@coredump.intra.peff.net>
References: <20240119142705.139374-1-karthik.188@gmail.com>
 <20240129113527.607022-1-karthik.188@gmail.com> <20240129113527.607022-2-karthik.188@gmail.com>
 <20240207014819.GA1399428@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Wed, 7 Feb 2024 01:27:37 -0800
Message-ID: <CAOLa=ZRSmbadZ5uhk1PVOV=bjRadNakOwZP2HmmVwbc3VKGkyg@mail.gmail.com>
Subject: Re: [PATCH v3 1/4] refs: introduce `is_pseudoref()` and `is_headref()`
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, gitster@pobox.com, ps@pks.im, 
	phillip.wood123@gmail.com
Content-Type: multipart/mixed; boundary="0000000000004d532c0610c74eb9"

--0000000000004d532c0610c74eb9
Content-Type: text/plain; charset="UTF-8"

Jeff King <peff@peff.net> writes:

> On Mon, Jan 29, 2024 at 12:35:24PM +0100, Karthik Nayak wrote:
>
>> +int is_pseudoref(struct ref_store *refs, const char *refname)
>> [...]
>> +	if (ends_with(refname, "_HEAD")) {
>> +		 read_ref_full(refname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
>> +		      &oid, NULL);
>> +		 return !is_null_oid(&oid);
>> +	}
>
> I was going to prepare a patch on top, but since it looks like this was
> reverted out of 'next' to be revamped, I thought I'd mention it now:
> -Wunused-parameter notices that we never use the "refs" parameter to the
> function. And indeed it looks like a (possible) bug, since
> read_ref_full() is going to use the_repository to find the ref store.
>
> I think you'd want something like this squashed in (note that it also
> fixes a slight indent problem in the first block):
>
> diff --git a/refs.c b/refs.c
> index 3190df8d81..0d65c31117 100644
> --- a/refs.c
> +++ b/refs.c
> @@ -875,15 +875,17 @@ int is_pseudoref(struct ref_store *refs, const char *refname)
>  		return 0;
>
>  	if (ends_with(refname, "_HEAD")) {
> -		 read_ref_full(refname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> -		      &oid, NULL);
> -		 return !is_null_oid(&oid);
> +		refs_resolve_ref_unsafe(refs, refname,
> +					RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> +					&oid, NULL);
> +		return !is_null_oid(&oid);
>  	}
>
>  	for (i = 0; i < ARRAY_SIZE(irregular_pseudorefs); i++)
>  		if (!strcmp(refname, irregular_pseudorefs[i])) {
> -			read_ref_full(refname, RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> -						  &oid, NULL);
> +			refs_resolve_ref_unsafe(refs, refname,
> +						RESOLVE_REF_READING | RESOLVE_REF_NO_RECURSE,
> +						&oid, NULL);
>  			return !is_null_oid(&oid);
>  		}
>
>
> -Peff

Thanks Jeff, makes sense, will squash this in.

--0000000000004d532c0610c74eb9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: 731f2ec79b40173d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1YRFRRY1dIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mOERmQy85OFJOdWNNVHozOFQ3MEFXR3BpdUxYby9nSwp1VGxud3F1cEpZ
U3RrVU9XQStCelEyS0FDc29WZTlDK21VemVOdTUycjFldE96Z1I1dERoZjFMVXZDNWhmbW5SCklS
THdWNVVjYVFVM3R3ZkdaeGl1TWVCNDl6ZFczdjNiRDRxSjRIa01rNGlRM0ZzaEN1Y0FxcjE0WlZP
Q0QwUVAKYnYvaHYxVExBa3g0dGx1eFJtbXFzTWVqV1BLcTYrWjhoQmUvWVFPdnJxcU9qb3pUSnIw
bUdRNlIzK2luWlpCcgpMY2JCcTJyOElRMmhlTFU5UXRTQlNTYmlRL25qZ1JqQnVDSGNLSXVUYXF3
K2h6K0NBcjV4d1JLMFl0Q1RYd0JpCnFQY1dsYXFvSmhXL0c0eDhGWVZnczlNV1FsTE9XWkxhQy96
cTVWZ3JRcmx6bGdMQXkwUEVBd3hodlVNckY2WXUKWmFSMHgwMEFKbDJ0amtmOElMOURVSTF3bnpG
UmpmVXloMjVtdkhXUCtIMHhCRFY4dlVFenhMUUNWQmxUbWlMOApkOFBqbHQ2NGM4dWE0YTZlbzRL
MUh2TkNqSkhwQSthcXVsOGYxNUdhajc4UUZQWHIwWHh4cHNJWHVOSGQvUkxOClZ0NWtWckdIUUJU
SG1oSDdYSzRPR1lTZ25ZM21Da2ZTR216eG1pYz0KPVpPRFkKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000004d532c0610c74eb9--
