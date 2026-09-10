Received: from mail-vs2-f12.google.com (mail-vs2-f12.google.com [74.125.227.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12F88466B44
	for <git@vger.kernel.org>; Thu, 10 Sep 2026 10:52:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.12
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789037562; cv=pass; b=EWoGFb2uVHGR5vk3ha+Xf9BqHdC2XKgUfkBfppAXC9XxJ5MAImIOrqeJP50JoNwauGPB+5LtB/eLWQv+P+IWj9urkajhQ1wuangI/koKIFeK2sOnM9P0Gtb4sEGPgo3qSQSKDAN2kyEMGZBj4HvbrEY0ve/n8r+O4ro4wZM4hT0=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789037562; c=relaxed/simple;
	bh=TeuWlzwJqySULAb/BWIY+SKnzMB/lNhq7V0rotu2Ilc=;
	h=From:In-Reply-To:References:MIME-Version:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=LjyZWQ7QiE5gPIIXo5nHgMBmpl+pgQUqfPOR5aSjVG/8KMJoul7McGh4AND2H0o4tpo/8aMy/7EjQM8tWeUwk75h6InD9A5kmDRTaEmhvDcTawIhOTUlYzhZQ6LaxMVPff5AnzIUNK37pQZ9dxgoQUmr0lT8lvdA/blPDJiZNMs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SBYt8LvT; arc=pass smtp.client-ip=74.125.227.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SBYt8LvT"
Received: by mail-vs2-f12.google.com with SMTP id ada2fe7eead31-78a4c5c582eso845849137.3
        for <git@vger.kernel.org>; Thu, 10 Sep 2026 03:52:40 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789037560; cv=none;
        d=google.com; s=arc-20260327;
        b=luTAHN9P/EVVbGtUwI65you6MDYmQ/CAtv9Kk9V3/hkhceS7RN3CV9YZbMtEMHsyqj
         ztc4ezGIi0tKT6rOcE6g1zM1nMVDnOrbvy1x1v6xkV/fFc8BC6ns8BFQm8ELbUeNrWi8
         vATyaimWxir/FXmop+L5bS04PMglWW5oNWKrIayAHjxKMmRHtX7Sa6ciiJggpWQ1v18+
         dtEs8TxaGJ9Vg9sOe9aPVnxnhJjaXKAycpE8Q7ifMjQABFFkkTUWIfCRvhmK+wI1SSXl
         CKbLEHZaQwjY9rBbaQnf4HMNdYbPLW2aBHqBYlRjEzplI5YI0NVF/1XTPoVnZ6r2d1tT
         vrYg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:mime-version:references:in-reply-to
         :from:dkim-signature;
        bh=cbKLnesIH8cIlUNqBgGRpmo1QBSNtJMlLHG+7FTYEEo=;
        fh=N8n90vjuCkaIEo3eKQgGLwreKID4kKbjsHpHcdZPbaM=;
        b=Oobl6gcQpxpopIktZWaf4HuZV7NcAfOvpJbuJM2nASvrQMzOPDcLspxR1ZppJ3YD09
         GS5DRT2rWqOIFQ113/bZC/t/bA4TO64yLWkEN1Y6aaaSCGpkM6rhDNON6bd0jsdtU+HQ
         pYHujg8Ec/kpWRUYYInw9LB9RjJLnNKKjYETrPr8Nzne9t+TS+p9y+Ae0ZJWhZv6AVGD
         dGcsfNqEuUyr4428K6AQrtd+pm7kQnhrr+KAAZ7CJQ9omst85aQ3NOYm/xkCKXgKPRUW
         XiCQwHpCTmt0RcC6vXEpmpbRcBYF36Mfa2kMj9D17ou6op4QWh/5CB1rZNDDCKwfERji
         9FvQ==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789037560; x=1789642360; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=cbKLnesIH8cIlUNqBgGRpmo1QBSNtJMlLHG+7FTYEEo=;
        b=SBYt8LvTotaWDAuZ13sFg3Bg21sEO3p3X0WtFnIuQfonxDnkhxToEp5N5Dn+ffPcEt
         kCQ62qmPDKfaZcnDNDp85vhAOfpV5vgOPTitdslYkmDHLcxr/2qNL/R7nHWk/FjO8VTM
         Ac1+zQIT9J8sEM7YYG30AjJGq3zfRCffzJeldjjbEzZGaMxp/piwEqa23O/PJMJdxvUy
         +QEOofT9/BlRNRfARiE42w0kcMNVdrjWZ65/p/YdDYK5fqD/yFpB6PedS62C0Vzq9IbK
         tpIYJox+SJ/YJYaNksAQ5iPD4jfpfJc88HEDR3IeEa7hNRL6yBxdKMbbaGfytbo4DXMb
         5TDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789037560; x=1789642360;
        h=content-type:cc:to:subject:message-id:date:mime-version:references
         :in-reply-to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=cbKLnesIH8cIlUNqBgGRpmo1QBSNtJMlLHG+7FTYEEo=;
        b=BZwsLSkH+5EZqGGYJG6kYnh6dUzN/8ljJ08yjqPB4SDMCTW0r7zCzJ9Uf0VRxMNDq1
         ZB3oyQGE88QOBXBZt1hn5NdIRC2JOYboGLQAJt6DXEVVqDaUrZ/hSLbgabTOCvPZLB80
         ukt4P3GgqwV2RsEtP09BNnn/SSiIfwqZ8KvnFg2LVwwB3XVeSo/6upEAm+4h3CNBur7j
         sRjFlvvxGKe7nnUWpMOVitIEBHQNOz9d+XZjYbpLqlYBY5qiCqzohFhcDxCDzRw67kwl
         /M65+gfQKlRM6KnZEgCootguc78jCfxhDO39uuee2jzvoW8Rrpkaz3H8d5RMDmgqNgL1
         yU4w==
X-Forwarded-Encrypted: i=1; AKwUvByTaVO/w8phyn+vtZbuUZqTPbh7JgTyr2R06DVu2XPGhD5GzqtakG1GtZxI9IE4xpoTc/Q=@vger.kernel.org
X-Gm-Message-State: AFuF++lI8KnfdvisEC6woK176I6wJgCQGKXuOaSYUyrMqhEgP2kGIyKZ
	n4JeHeIz/N6ZrfPN4Mhz6JX2oP857gL7erLMxJqJW395tv0GaFZkcTJSdvelF88z0yL9lFaDVAA
	wpwUUaH1H4FF+hVMva07HACSRPjFFzwI=
X-Gm-Gg: AYBFou1LBazjhEfg68eg1U05YZyUwKVLJRFQ8ZZ6ZRVHWsJk4HFn1VPnMuztlv22+Xx
	mWfCGU2fPgmfKDVp+OMy1G93V8xfgXLeUj9Lf4m9OKnxCEUdQei3TsEYcAD2dEnNmbdzaN56vVv
	2CIH0wz7fil4z/6LFiW9pBF/huLfmt+2YSFG5OTAVyHnLdiNXNgLOkxZzEyni/W89G2/UooqQpf
	GMvXydsPuZr8C2MlQBPErwMTu+4HmoVUvK5hXolgRNBw1L/8g+Ii2tzCsVKg18zFpbcKaLsRFD8
	jFkWC7Jv0ms9HHLtJFp6Q18S6GkzsaGMZ2ZZwFfACCBNbGugmL18S3EQAOWqBDxpxSGrLswB6Qv
	PaRtPgPSvDM8CLsO2e6ZGOssvyDx2wLzVBqXG2bEyCsVK
X-Received: by 2002:a05:6102:8697:10b0:784:5883:9cc4 with SMTP id
 ada2fe7eead31-78f75e026b4mr3073049137.11.1789037559797; Thu, 10 Sep 2026
 03:52:39 -0700 (PDT)
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 03:52:38 -0700
Received: from 753933720722 named unknown by gmailapi.google.com with
 HTTPREST; Thu, 10 Sep 2026 03:52:38 -0700
From: Karthik Nayak <karthik.188@gmail.com>
In-Reply-To: <20260909-pks-odb-write-alternates-at-creation-time-v4-5-d8a78ffc32e4@pks.im>
References: <20260909-pks-odb-write-alternates-at-creation-time-v4-0-d8a78ffc32e4@pks.im>
 <20260909-pks-odb-write-alternates-at-creation-time-v4-5-d8a78ffc32e4@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Date: Thu, 10 Sep 2026 03:52:38 -0700
X-Gm-Features: AcwNN1UI4u5oNf72Cq-54vrlsN0_-AlfpBUztgCKRy4ZF4vp7C1_9wrw6Pua45I
Message-ID: <CAOLa=ZRu6D16En7hSmT19geC6OvptRXQg98ZAaDgoh4X5Yc6qw@mail.gmail.com>
Subject: Re: [PATCH v4 5/9] builtin/clone: move setup of alternates for shared
 local clones
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Cc: Toon Claes <toon@iotcl.com>, Junio C Hamano <gitster@pobox.com>, 
	Justin Tobler <jltobler@gmail.com>
Content-Type: multipart/mixed; boundary="0000000000003dfb10065b1ec4ac"

--0000000000003dfb10065b1ec4ac
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:

> When cloning a local repository with "--shared" we add that repository
> to the new repository's alternates. This is done in `clone_local()`,
> which is responsible for performing local clones.
>
> Move the logic into `collect_alternates()` to unify our setup of
> alternates. Furthermore, this will allow us to set up alternates right
> at creation time of the object database.
>
> Note that the logic for cloning a local repository with "--no-shared" is
> not yet part of `collect_alternates()`. This will be handled in the next
> commit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/clone.c | 23 ++++++++++++++---------
>  1 file changed, 14 insertions(+), 9 deletions(-)
>
> diff --git a/builtin/clone.c b/builtin/clone.c
> index 8786a49332..011fc867c8 100644
> --- a/builtin/clone.c
> +++ b/builtin/clone.c
> @@ -220,7 +220,8 @@ static void copy_alternates(struct strbuf *src, const char *src_repo)
>  	fclose(in);
>  }
>
> -static void collect_alternates(struct strvec *alternates)
> +static void collect_alternates(struct strvec *alternates,
> +			       const char *src_repo, bool is_local)
>  {
>  	if (option_required_reference.nr || option_optional_reference.nr) {
>  		struct add_one_alternate_data data = {
> @@ -234,6 +235,16 @@ static void collect_alternates(struct strvec *alternates)
>  		for_each_string_list(&option_optional_reference,
>  				     add_one_alternate, &data);
>  	}
> +
> +	if (is_local) {
>

Shouldn't we also check for `option_shared` here?

> +		struct strbuf commondir = STRBUF_INIT;
> +
> +		get_common_dir(&commondir, src_repo);
> +		if (option_shared)
> +			strvec_pushf(alternates, "%s/objects", commondir.buf);
> +
> +		strbuf_release(&commondir);
> +	}
>  }
>
>  static void mkdir_if_missing(const char *pathname, mode_t mode)
> @@ -357,13 +368,7 @@ static void copy_or_link_directory(struct strbuf *src, struct strbuf *dest,
>
>  static void clone_local(const char *src_repo, const char *dest_repo)
>  {
> -	if (option_shared) {
> -		struct strbuf alt = STRBUF_INIT;
> -		get_common_dir(&alt, src_repo);
> -		strbuf_addstr(&alt, "/objects");
> -		odb_add_to_alternates_file(the_repository->objects, alt.buf);
> -		strbuf_release(&alt);
> -	} else {
> +	if (!option_shared) {
>  		struct strbuf src = STRBUF_INIT;
>  		struct strbuf dest = STRBUF_INIT;
>  		get_common_dir(&src, src_repo);
> @@ -1348,7 +1353,7 @@ int cmd_clone(int argc,
>  		warning(_("--local is ignored"));
>
>  	create_object_database(the_repository);
> -	collect_alternates(&alternates);
> +	collect_alternates(&alternates, path, is_local);
>
>  	for (size_t i = 0; i < alternates.nr; i++)
>  		odb_add_to_alternates_file(the_repository->objects, alternates.v[i]);
>
> --
> 2.55.0.1074.ge7621b4bad.dirty

--0000000000003dfb10065b1ec4ac
Content-Type: application/pgp-signature; name="signature.asc"
Content-Disposition: attachment; filename="signature.asc"
Content-Transfer-Encoding: base64
X-Attachment-Id: d2e8a0a48228bc6_0.1

LS0tLS1CRUdJTiBQR1AgU0lHTkFUVVJFLS0tLS0KCmlRSEtCQUVCQ2dBMEZpRUVWODVNZjJOMWNR
L0xaY1lHUHRXZkpJNUdqSDhGQW1xaWkvVVdIR3RoY25Sb2FXc3UKTVRnNFFHZHRZV2xzTG1OdmJR
QUtDUkErMVo4a2prYU1mN2IrQy85dW5yK1U5QTdaUFZ0bEFiczFKc2FWZU1vbQp3TG01RnBMaVVR
NlBhOVZaenR6NXp2M3dlaGhVanY1eVZMY3lBWWgzY0FicnhQU2lRai9xd1pjbTVKNU1hMlZNCmFR
T1NUVjZZVmt6VUtRUVdnQnIwMmJVSzl2cnM4c1NBZHI5cEozWEdreGE2a21TL2hCWlE0Nm1kc1Vy
T3FqbEsKK0c1WkIzL0JZNDQyTjUzMmNoRDJzdlNBN05weFNKNmRCbWl1RHJYdlhuRk1DRzBXUTRI
NnEzS2lUVEJJYTR2dQpQUExNdTZnNmE5ejZMaCtXSjNKZVVYYlpRdllvY25ScmVLQ0poSzRycWpT
UUxEQUlqL1cwMzN4NzNBai9scVZLCkFZY0ZyN25pelNNSFNxTDdsL0o4d3pxV0V4WXFETWxycERB
RjNFQU9SdWwwdkRDTVRPSzRnZ1B2emFmek85WlIKcWw1TEM5ZGhKblhEV0VDbU1TWDlTbW9lWXRj
N2FNakRsWHBxa096Y0Y2Y2hEdXNna0Z1KzRRbFhhMGpxbHE1UApzWnNrN28zTkZuSk4wWWFvdUI2
NjR6Q0h0SGo5V3I1RHhyTzdlUjN0N1Q0RHFpTU5EeUlTUlNVcEZtcXhON2hLCldHU3pUMUtZVEFl
Z215US9pQjhNeC96UEVLd2RxanVTa09tMmRRWT0KPUNQWUUKLS0tLS1FTkQgUEdQIFNJR05BVFVS
RS0tLS0t
--0000000000003dfb10065b1ec4ac--
