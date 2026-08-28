Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18FA636E468
	for <git@vger.kernel.org>; Fri, 28 Aug 2026 19:13:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787944389; cv=none; b=crCrcXqGML3cOOwunP60s6WYt2oay1iElu1IyfKrDCQ+R3Qgksaaa/UqzVXGa2aDNrFBQwGl9cWU5oD0wvJ/aFpKZc+W/BGK7PhBPR/6eaPwacEPucsFCMC+F6MCXcxAyXUV2p4jM/4LLiQSitCQ4RtYbXKYaK0/KooOUUZp4qE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787944389; c=relaxed/simple;
	bh=FXO/wh/5OSv3x4KYSqEjB0j+C93MkTaR9rF30MfZsi8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QJ0NSa61jo/9NA+qyvUWRuhjSJ+yrPCr2lTlzwRcQs0E7EvGkPenCGQP7Wm9SEg0LHtevG8zJ0ZUq3Hn12K3puAdOmHkK1TTX31xDUjFLsZ4chmFaDPDgw5qdm94jYJQ/JDgVC0K4A8sGiSRon0eQ+qd9YxVbYqtGMv+/uF50jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=GZc+iaoX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Rse/vCHd; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="GZc+iaoX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Rse/vCHd"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.stl.internal (Postfix) with ESMTP id 3C28D1D00077;
	Fri, 28 Aug 2026 15:13:06 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Fri, 28 Aug 2026 15:13:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1787944386; x=1788030786; bh=ZT4yUeubxf
	5poDzI8dQdzoQzUbOaTweIosJA+dbodUw=; b=GZc+iaoX6LZSgjBIZpqoMX3x/0
	+OgqJZw9qp2jM7QRird0denbaJbIgJBJz+Un/OF7GYFtzoDE2swJslI6Ybtq/KkK
	b9mxDpeGvRgqBgv5dz0kWMc/F71sWHg5pILQCYgwN+HwyviWaiuE1jN5ez1IrH+B
	tlmDI9GcwOD7DSUOxdV+3vUzI4qrGr5jKhpX1bCgl/NP2Bw/MMnTBVf+7xHqteAD
	6pHYg3mysCRNjyQKsnqAlVlhfYnq6JULOZlQu2yJv5upUif0+zCvo8IhKApv1vYr
	2T7L5l06/iYs9jq+AsUnfBaEW0aSxjZRhq4npsotnzJ1MdYu/n+ZLO1JVcJA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1787944386; x=1788030786; bh=ZT4yUeubxf5poDzI8dQdzoQzUbOaTweIosJ
	A+dbodUw=; b=Rse/vCHdZ5lROXkytyYiIUOE+rzFXzbXEZZk1/RTStSyJtWsBaE
	PpiF0hZsjcrW8BiFtno8RjKEhyLgwPNn70LfAgmTB377v8at7oA80Mos9/4dXWyI
	SvvoPLDugo/2fAJBdT02kt2KcbuLX4Ul6NiV5V821ku0o06tlVzGydBki1ciz83g
	9YhIebDLbxzRkgBi0dyLxI2Rnq33FyvmJIt2cA7zTzA2az4e2ggl4ZptX+LDabeV
	Igzrq7x+MVc2Cvv6BHL39XgXPAxbtHz7RkP84y7Orgs8JaTv0AnMLJYlqgjmxdNn
	xQOosCYJ2EQjeCVN6YSwOkRCPyOpaiO06SA==
X-ME-Sender: <xms:wd2RauBodcmtvfVTAsTM0zIRnz1AqKMlGEfO1yOwuyq-EeFD05Dugg>
    <xme:wd2Rav_eiONnyMTEKOjboFclHIsPEbPv7sCj3aThGVZNbPriiD5R1uat6Y8AgSujc
    onqORqTdugWXk5GWEvHux-WpnNiEdXOPJ2GgC_uNA1h-ph2wTQ4Sis>
X-ME-Received: <xmr:wd2Rau8UMsPo3X35-yCzvRlLMyuag7mFyNNaxYj3z_h2acJlEN9JSGkiWApsk-Lf3dl9gBo8w728GaXL3i1IQBd-kYgZkRKUdA>
X-ME-Proxy-Cause: dmFkZTGkEgAqON5MqzzS4dd3bSIRvfi2KvUBaJ6QC2bzIAstbxJoAGzwVzJn0IAfnKfts4
    UEAts0GW/Cic8Fvl/2fb/9/LJakLQLJ47R8kIbQ6pyiJ0jRJ+7IMesDF+SeiGKeAl5ZgCF
    dfle3Ayo3gc1IMTvkssSOCMElmzdzP8admsACcqavLPYSVLXeTelNKryosWPLU4crAdpiy
    rBTR+wtgp31tI7yiurirzIY5sXZdxxFkMDQjJR6TpkynUQvzKI247vvd0bHckl4C1RT+Ll
    xJNy4BSugq9ytq6Hm39LaE/x+ssMKN+VS/bSwt930cicy5Nb9XjJPHUT0bAgYXfKGGlFTv
    59v7pB1rZHIifoOH9Y/viR15jErJCIAr9GWgPjuEd6sw8xitNzGSmyd2scTg2pv53isf/i
    qAAipFrpW92huzOBKSFeeXw7kcuD2ZUs+VDaAF7KIH3VTQxM7a1AqTOic6xQDue5T0GYgO
    G9ivgUvDmRuWBMm3x1jIcSGneJVx+b3XDCobiuBYqfITqYlSWQbb0xrQYZ8GNOqT7BYsSv
    OWfLGpEhcnfl23WjYxwvaGxMUUO6tz+YlEPoEaN72WDXC4VaKWCpu6ICWE7WSAzg0ZmvYe
    6FYj1tAZ9EKTa9gABM2w5W8cwVfVG87DZN79c5n9cv0MX+GWBxhkZhLlO60A
X-ME-Proxy: <xmx:wd2RamcnQJIY2paUQf7ERPk47UTo2b8NAFqmbd-IUb28N7SaMkRqPg>
    <xmx:wt2RanHMDPhS87IYvysmNgbodPre7PYKFsRH4Y7cTQF2RXW8qXnaUw>
    <xmx:wt2RakcT3p0UX92QS00QpsMdnec4NmlwE1C-fRI0THcrt8_CZRmHJQ>
    <xmx:wt2RahEJJ4KcubNj7JJ_X5fLyyhVO8LQpQVYnQaTd0PmkkZc3DGTuQ>
    <xmx:wt2RaoG4sqUjBc45lcNCSkQY3SSj5-gAAiOIKlVotyDF24qwVY76vhaA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 28 Aug 2026 15:13:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 6/8] odb/source: support writing alternates when
 creating the database
In-Reply-To: <20260825-pks-odb-write-alternates-at-creation-time-v1-6-911513ba95c3@pks.im>
	(Patrick Steinhardt's message of "Tue, 25 Aug 2026 16:11:55 +0200")
References: <20260825-pks-odb-write-alternates-at-creation-time-v1-0-911513ba95c3@pks.im>
	<20260825-pks-odb-write-alternates-at-creation-time-v1-6-911513ba95c3@pks.im>
Date: Fri, 28 Aug 2026 12:13:04 -0700
Message-ID: <xmqqbjam3vpb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Add the ability to write alternates when creating the object database.
> This change allows us to remove the `write_alternates()` callback in a
> subsequent patch.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---

> diff --git a/odb/source-files.c b/odb/source-files.c
> index b7b3a297bb..5e77b21d9f 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> ...
> @@ -64,8 +70,71 @@ static int odb_source_files_create_on_disk(struct odb_source *source)
> +	if (opts->alternates && opts->alternates->nr) {
> +		strbuf_reset(&path);
> +		strbuf_addf(&path, "%s/info/alternates", source->path);
> +
> +		/*
> +		 * The alternates file may already exist, e.g. when it has been
> +		 * seeded from a template directory. Read any preexisting
> +		 * entries so that we don't end up writing duplicates.
> +		 */
> +		f = fopen(path.buf, "r");
> +		if (f) {
> +			while (strbuf_getline(&line, f) != EOF)
> +				strset_add(&seen, line.buf);
> +
> +			if (ferror(f)) {
> +				ret = error_errno(_("unable to read alternates file"));
> +				goto out;
> +			}
> +
> +			fclose(f);
> +		} else if (errno != ENOENT) {
> +			ret = error_errno(_("unable to read alternates file"));
> +			goto out;
> +		}
> +
> +		f = fopen(path.buf, "a");
> +		if (!f) {
> +			ret = error_errno(_("unable to open alternates file for writing"));
> +			goto out;
> +		}

I understand that using 'a' instead of 'w' is an attempt to deal
with the potential TOCTOU problem, but shouldn't we be using the
standard lockfile API, which atomically adds (or fails to add) to
avoid leaving a partially written file?  Or does it not matter,
since this is done only once upon repository creation when nobody
should be looking at the files on the filesystem?

Thanks.
