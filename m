Received: from mail-vk1-f170.google.com (mail-vk1-f170.google.com [209.85.221.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF57C2BCFB
	for <git@vger.kernel.org>; Mon, 13 Oct 2025 12:37:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760359032; cv=none; b=Dh2PneFLF+agncRUJBkc5MZwza/Tu1e5ZScnifionACSp6Tu1w1OTLufn6b3QMhJ7gBZoRicdIwmaKZ6q6QobbLmVt0UtxtkZNQjg01me6Y14QDFJIS9xTyJN8Es6bCaLJOpu1DL0bTlZGGTTAg+CzDX0wG3GszRt0SgGAQulzY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760359032; c=relaxed/simple;
	bh=bcIS7X381VA3PpJuxUBRCbNT1ZfQRazovugJvQn1nRo=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Rn6+yEyH+y46h3mUvCOlB1C9rPCJesRzlabqh+gwimajq8NgwuAsLcPnIsN58qDoMlniICKTNy8vGdAOXWoU4Ch+VYx6O0ZcouzxXidSZOuYyNca07Y4IJ/GcBROFYNh3kbKoHQbaahQkVCelMhP12OoNaDHFjfxruDavzGJBLQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dK8c/O6G; arc=none smtp.client-ip=209.85.221.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dK8c/O6G"
Received: by mail-vk1-f170.google.com with SMTP id 71dfb90a1353d-54a79cadd1fso2217025e0c.3
        for <git@vger.kernel.org>; Mon, 13 Oct 2025 05:37:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760359029; x=1760963829; darn=vger.kernel.org;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=pZdcSpi9GZt1hOivkRhsH6mSz0voB7RM8aVTB6KTZCc=;
        b=dK8c/O6GPCw5zFkvu1uDgFDwS8tr9Qjn3ci5Udc+E9uFd44YeQFe+ZpOXktEUAYSzR
         9ZpklpON7dmf3YE+CFt8YWsyj6Q2mshqYLNvIJsOWoajC4xC3s9QEfBBNomNx7yRYNlP
         bhXWtyhK0Uo1NwCDbHFbDVg2hPd03Of7o8WNYaelj4K37a+yXSRam3QSNO25uZct8zbi
         d6eRMIOE50v2aUa7V75AB2s6FfvXTD7M70KgHAsCdnhW8I08pCzBy+K/kzsllcm8CDWZ
         mI7BlhNkGvmsHVB4c5KfuWabFUNTzShN8FD3VjuHhixb9Rff3TNBmQArs4M0OXDKcTIa
         bnWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760359029; x=1760963829;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pZdcSpi9GZt1hOivkRhsH6mSz0voB7RM8aVTB6KTZCc=;
        b=DgDRbATitnhoyASm3jq66E+WGgHQmhNB/r/Ekcf3nRcUjVD+rA/hyq3ZJnzRKOVWE0
         ev8X6WcGd24Bl8OKPv0Tc7addad6OBdWc+nCEoON/mo8KsrcvREm53MawGAa2gXVZvbE
         3i5bh40b9oWIMlhRlSLoFR/JjR/3sBNQJD5/hkidL19ZxDIuBf0tbYEj9lbIv7O4kebf
         KZUeKHarSz0dgDUts43mgJHydYXbKbA3QzepZ+np5MUF3JTq0Mm+kGGKySPUv1XX5p7P
         DoOBgPopqt057t0w+QeDW8lf/HwFWFVuEI54MWgh+YY8h2NVM7CqbYVsosZvriUWF7c+
         Pcwg==
X-Gm-Message-State: AOJu0YwFLM858ZzqGk2L/qVMbbsUrSPsbNS6cA0Ox9XhKF1F+tkuXEth
	7Baw8mogpc38+29Tf18DRJniRw9KG9gJ4wELZzvb/vXzmImSQeEBx/ZweQkr5+2L3ArT0jF13IW
	bt6FuihCRn0IuKisYqllu3vcUUoItfAVlNn7b
X-Gm-Gg: ASbGncuVGcqReGOfxJpEUm/S9dqwZqAhGJtrmKsMLmBvfCT/PLlvWhWy7kXCFx1i5Hf
	D8BniOivJYNIDPAIA2dUg12vsJNaMADWbin2z6F2P6RQ08xAs36wUHu2ZOatXmZrTeUuhvCDbcz
	Kr02jPSgAA7+of8fXTDDPkfmWsTsijRaQx3NYZx3tJw0HdwLyWSdetXbt18LBeHG5qFzhsALeyd
	hXG+wl3jdmS9EJieHIgH2pMubCDKvpuZ0yQRe4EGnE2m9Ylbg+Icnyru0VV
X-Google-Smtp-Source: AGHT+IEHjvL+8D8vSbQK8BezvhreiZ2oTybAiBho9cqw1mWESuc6G9TmjceETcAi5CYTcS7h883QbyPGBS19ZlKRMt8=
X-Received: by 2002:a05:6122:1683:b0:54b:bf4d:558b with SMTP id
 71dfb90a1353d-554b8b8cf48mr8420617e0c.10.1760359029369; Mon, 13 Oct 2025
 05:37:09 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Oct 2025 05:37:08 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Mon, 13 Oct 2025 05:37:08 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <aOjsjpE1vuFUXXbh@pks.im>
References: <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-0-c7962be584fa@gmail.com>
 <20251010-562-add-option-to-check-if-reference-backend-needs-repacking-v1-9-c7962be584fa@gmail.com>
 <aOjsjpE1vuFUXXbh@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Mon, 13 Oct 2025 05:37:08 -0700
X-Gm-Features: AS18NWCKCCKPj3Yx0wRLgGyDfcEjG1h_6WRhIge-yA3S2CS0y9b7W25760DILJs
Message-ID: <CAOLa=ZQz3Fho2N1KBrbaj3OykXeCx1b5NTjBoPs0uL5uBm3z0g@mail.gmail.com>
Subject: Re: [PATCH 9/9] refs: add a '--required' flag to 'git refs optimize'
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: multipart/mixed; boundary="0000000000009f881a06410986aa"

--0000000000009f881a06410986aa
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> On Fri, Oct 10, 2025 at 12:27:13PM +0200, Karthik Nayak wrote:
>> The 'git pack-refs' and 'git refs optimize' commands allow users to
>> optimize their reference backends. However they provide no functionality
>> to check if optimization is required without performing it.
>>
>> Add a '--required' flag to these commands to do that. This is useful
>> on the server side where this information can be utilized to perform
>> more targetted maintenance runs of the repository.
>
> s/targetted/targeted/
>

My spell check says both are accepted. But the latter seems to be the
general spelling.

>> Add a corresponding test for the files backend. For the reftable
>> backend, this cannot be tested easily as it performs auto-compaction.
>> However, an earlier commit ensured the functionality was covered by
>> unit test.
>
> You can disable auto-compaction via the
> "GIT_TEST_REFTABLE_AUTOCOMPACTION" environment variable, so it should be
> rather easy to add a test.
>

Good point, let me add a test.

>> diff --git a/Documentation/git-pack-refs.adoc b/Documentation/git-pack-refs.adoc
>> index fde9f2f294..62bc01b29b 100644
>> --- a/Documentation/git-pack-refs.adoc
>> +++ b/Documentation/git-pack-refs.adoc
>> @@ -9,6 +9,7 @@ SYNOPSIS
>>  --------
>>  [verse]
>>  'git pack-refs' [--all] [--no-prune] [--auto] [--include <pattern>] [--exclude <pattern>]
>> +                [--required]
>
> Hm, I'm not a huge fan of that name. "--dry-run" might be a better name,
> but on the other hand one might expect that such a command also yields
> information about what happens or that the compaction should be
> successful. So I cannot come up with a better name, either.
>

Yea, I too had the same thought process. Something like `--dry-run`
would create the actual compacted files but not replace the existing
files.

We could perhaps use `--check` ? But I'm okay with either.

>> diff --git a/Documentation/pack-refs-options.adoc b/Documentation/pack-refs-options.adoc
>> index 0b11282941..66d69530b9 100644
>> --- a/Documentation/pack-refs-options.adoc
>> +++ b/Documentation/pack-refs-options.adoc
>> @@ -50,3 +50,8 @@ the provided `--exclude` patterns.
>>  +
>>  When used with `--include`, refs provided to `--include`, minus refs that are
>>  provided to `--exclude` will be packed.
>> +
>> +--required::
>> +
>> +Check if pack-refs is required to run, without actually performing the changes.
>
> Let's not say "pack-refs" here anymore, as we're migrating away from
> that name towards more generic terminology. Maybe:
>
>     Check whether the reference store needs to be optimized without
>     actually performing the changes.
>

This is better, will amend.

>> diff --git a/pack-refs.c b/pack-refs.c
>> index fee77fbf9f..5d4d4266de 100644
>> --- a/pack-refs.c
>> +++ b/pack-refs.c
>> @@ -21,6 +21,7 @@ int pack_refs_core(int argc,
>>  	};
>>  	struct string_list option_excluded_refs = STRING_LIST_INIT_NODUP;
>>  	struct string_list_item *item;
>> +	bool check_required = false;
>>  	int pack_all = 0;
>>  	int ret;
>>
>> @@ -28,6 +29,7 @@ int pack_refs_core(int argc,
>>  		OPT_BOOL(0, "all",   &pack_all, N_("pack everything")),
>>  		OPT_BIT(0, "prune", &pack_refs_opts.flags, N_("prune loose refs (default)"), OPTIMIZE_REFS_PRUNE),
>>  		OPT_BIT(0, "auto", &pack_refs_opts.flags, N_("auto-pack refs as needed"), OPTIMIZE_REFS_AUTO),
>> +		OPT_BOOL(0, "required", &check_required, N_("check if optimization is required")),
>>  		OPT_STRING_LIST(0, "include", pack_refs_opts.includes, N_("pattern"),
>>  			N_("references to include")),
>>  		OPT_STRING_LIST(0, "exclude", &option_excluded_refs, N_("pattern"),
>> @@ -47,7 +49,14 @@ int pack_refs_core(int argc,
>>  	if (!pack_refs_opts.includes->nr)
>>  		string_list_append(pack_refs_opts.includes, "refs/tags/*");
>>
>> -	ret = refs_optimize(get_main_ref_store(repo), &pack_refs_opts);
>> +	if (check_required) {
>> +		bool required = false;
>> +		ret = refs_optimize_required(get_main_ref_store(repo), &pack_refs_opts,
>> +					     &required);
>> +		ret |= !required;
>
> I think we shouldn't use `|=` here, and furthermore I think we need to
> define semantics more specifically. E.g.:
>
>     - Return 0 in case optimization is required.
>
>     - Return 2 in case no optimization is required. I mostly shy away
>       from `1` here because it might already be used? We'll have to
>       double check though.
>
>     - Return any other non-zero error code in case an error occurs.
>
> This also needs to be documented.
>

Fair. So I checked and the only backend which returns an error is the
reftable backend and this is explicitly only the
`REFTABLE_OUT_OF_MEMORY_ERROR` error, which is equal to -13.

So let's do 0 for optimization required, 1 for no optimization required
and other non-zero for error.

I'll modify accordingly.

>> diff --git a/refs.c b/refs.c
>> index 514fb85af2..59a48b36b7 100644
>> --- a/refs.c
>> +++ b/refs.c
>> @@ -2317,6 +2317,13 @@ int refs_optimize(struct ref_store *refs, struct optimize_refs_opts *opts)
>>  	return refs->be->optimize(refs, opts);
>>  }
>>
>> +int refs_optimize_required(struct ref_store *refs,
>> +			   struct optimize_refs_opts *opts,
>> +			   bool *required)
>> +{
>> +	return refs->be->optimize_required(refs, opts, required);
>> +}
>> +
>
> I feel like this should be introduced in a preceding commit.
>
> Patrick

Yeah, It would be better there, will move it.

--0000000000009f881a06410986aa
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: c9f63f2235fda28d_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1qczhuTVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mNk51Qy85MUYyR3BCUHpaNXRZMUVBd3N1a2FWNVczcQpaKzN2YXNNNHVJ
bmZHKzNLOXpJUGw0aitHY2QvK056Tjh3MzRZcmZFR1N4Tyt5U2plcEluZkRuQm9OMFJCU0g4Cksr
cG9EckpBOWFqeWdlSkxGNzdSdWFvRlJKNVVGQTYwdDI0RGdYVEdDa0wyak12b0M2aGFESnFDK1lj
ZUdFRXQKU2RLZkR4Q1BqWFNkOVNvNUlhbWtIczhOYVhpSUN4aVNhcEtkM2RRMXZmOUt5YWFBLzZE
R1V3TGlaclRFMWZIMgpkUXFZT045V0dXbFhUK3Voei9adVpTOHVIakliMkpyMGs3Z1Y1N3hOUTcw
WkxVNFdzbHQybDh1dXZxNm1hdklKCnBTcjZ6VjJ3STgrYzVGYjFTb1cxNUREbU9BUzdZN09kS05O
blBjL2FuMjlyRVhpZUhPbHRBOFI4dW8vcVRFY3AKTkVYYWowTlI4MUlEYWZVMklkVFNkMHQzMGYy
akZiUE9JcjBES2VSMmx3ODBpVWx1SGdORmx3c1ZMYnlkc0J2TApLVWM3dVBiN0wzY2VPSHF6TGFp
cjhBaGJqNmpaV3ZQV2hERE9DbjZUYm1IMXV5ZXBsYXJHMkJzeFFNTmtBVnorCnBDMzA3Ly90djh4
WTBnamd3QnRqeDVucFplTm5BTGM4dEUrbDdRdz0KPUI4QWsKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000009f881a06410986aa--
