Received: from mail-oo1-f54.google.com (mail-oo1-f54.google.com [209.85.161.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A6373330B2F
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 21:34:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772660044; cv=none; b=cpD72jWxhAeaKqfMpvIVDonUL2XIGhXxVVbwhdqroNjsbGTvy7ULVXhr2zFPiNKDP2uX1c8/UsCH4TcDhe46RnMyUpUUzrmksJ/LNXjE1GfrXBJyoy4kwfcAPi7XUUnFsPrMhFaq0eES+nII0zxjldbhSR0V2/kUl8BBbrtwRxE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772660044; c=relaxed/simple;
	bh=PVTJAILondB45ObUIB7/+vk9m2cSoYTWIYab2nQxA6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=k9U6TLlKrVNckFf1zNEPQywrpYO3FhEMAvOnG/lSNOnEyNlt/FygRxjZcUNX5M6McvEULNW90TQ75QBzhOudUC0w6kP2dmdd8/50/DtkQBlkTMqG2XDe2EPO5iOp5KuJ7e3CVf8rmjYVTdm1+VA4nQpeoTg9XZKfy/kVIaR7890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=i2/kqMXL; arc=none smtp.client-ip=209.85.161.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="i2/kqMXL"
Received: by mail-oo1-f54.google.com with SMTP id 006d021491bc7-679f23befd6so3428331eaf.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 13:34:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772660041; x=1773264841; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=foNWWZZCr11z8jMB3/07djdRjBsNETN8aSTXEe/P9LE=;
        b=i2/kqMXL1py9yHeX1U4nO2JtVstUj4zbEywl9gmAQ003yg8SDM3R0m0XZ557X+W3ko
         tc5ZT+fkRiAfFde52UTPENvTDfqk8jZvSNXu7+ZknTQ5TK7p9sLwopwgOie3SM36XaTc
         vqqhhDMSEwsq8N0RlWZFPFIrxxfEqFWbBUxaPnShpd0NfUrp8CpYh3CfvNMxwljfQpQ6
         SvSWkFudCSviDdQfPG9F65jUvsD16oVAfOkXxAqN/oA17stPZG/zoiV7nZaqkr5hojIT
         cmHYMnzuEquuuqivbnUZ1BtFJ0XcpVhkEon8lYJU/NhMcMe0lvnt7GdgwOlMHfcAufi2
         GaLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772660041; x=1773264841;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=foNWWZZCr11z8jMB3/07djdRjBsNETN8aSTXEe/P9LE=;
        b=J8/oc+wmPjQBu+bOY+O6QlH3P7LmPeI9X4bOTyTCYXOanI7DC43X/UZ4FWnC8nTYzU
         gcoQjuQ2FpjgR1LOixqQSZ0Bk0TX9xA6zl58kddgx6MHzfZRkAn3Y3zEiFQSw2wRZNDy
         fhLrPQ/Xiy6mhRav5YMEJPHeFrcxItSvGPiLFaXYs9YgGL+B2ZobcXjDN/y7yMg9UTLr
         bQDmH5oEk6rO99Iju0Dt8qRgXXia/7GUxqqA+/GlfhgBDUvh4Dk2bOJuEiUfNmEp1ABZ
         UuPjpjN6HQTZhu3K7ylPZhvDNMaZ31sshu52q4Y/vs60KQuGx1lKqSVzq2ocNe+5bw3q
         nYMA==
X-Gm-Message-State: AOJu0Yy4s2e2BhHDNqxhg1GMnXAFRZ2BhVOtRmKo4yTr6HrDMSkevNgr
	Kmx/afKsc51XNnYsXMEnPylZoqcF2iKDP3oW8l/98ZutyJVhsIrvDZTq
X-Gm-Gg: ATEYQzyhQi9v6VNgHGELUsWA96fLPOpuft7b/nyrGVRosBwIQ16g2zxPvNdfbUMAr0V
	BYi6fY9p0qchvTFbN210uW3/8yixObGy0s20tyTANri4oXWZ2Xz/9HbaIeDEZU+3crlDokNT2QK
	qcqgxKgwmgvjMGtBUNjFblFObVlcAm21XLMhuMPhRR4ikKyfhUu3mop4uEOx7HWAvwHybn1/iW+
	fKewane2ew4Qk3TpksCEAWZa4eYZ/ebSXbZtcdxtCTVJ0I9pQTH7Kjx2hugsPQYCMD6MAFpTMyW
	moN2umyCry+avPhUzMayTtRizleVk0DaolN/LiqE3dUaz8CW427NGXoVz5VcEZkppnd4EuaGJZ7
	CfSNpxJ0r0i5JdFmzub0yg24LhvWinjV1coZtHYFJnAzrotn/Nxo+zemNDFGES5n+3P86TM2V4l
	BpDmN+XGB8/awldE1c
X-Received: by 2002:a4a:e84b:0:b0:67a:405:7ffc with SMTP id 006d021491bc7-67b176e7238mr2136062eaf.5.1772660041641;
        Wed, 04 Mar 2026 13:34:01 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-679f2d856d2sm13250661eaf.10.2026.03.04.13.34.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 13:34:01 -0800 (PST)
Date: Wed, 4 Mar 2026 15:33:58 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 09/17] odb/source: make `read_object_info()` function
 pluggable
Message-ID: <aaifSxpeDb2oqPhD@denethor>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-9-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-9-253bac1db598@pks.im>

On 26/02/23 05:18PM, Patrick Steinhardt wrote:
> Introduce a new callback function in `struct odb_source` to make the
> function pluggable.
> 
> Note that this function is a bit less straight-forward to convert
> compared to the other functions. The reason here is that the logic to
> read an object is:
> 
>   1. We try to read the object. If it exists we return it.
> 
>   2. If the object does not exist we reprepare the object database
>      source.
> 
>   3. We then try reading the object info a second time in case the
>      reprepare caused it to appear.
> 
> The second read is only supposed to happen for the packfile store
> though, as reading loose objects is not impacted by repreparing the
> object database.
> 
> Ideally, we'd just move this whole logic into the ODB source. But that's
> not easily possible because we try to avoid the reprepare unless really
> required, which is after we have found out that no other ODB source
> contains the object, either. So the logic spans across multiple ODB
> sources, and consequently we cannot move it into an individual source.

Ok, I think gives a bit more context around one of my question in a
previous patch. So IIUC, when reading objects, that the object could
have been repacked and thus no longer discoverable from the current Git
process. We could just reprepare the ODB source immediately, but it
could be that the object exists in another ODB source so we should check
other sources first. Only if the object can't be found in other sources,
then we should attempt to reprepare the ODB sources in search of the
object.

> Instead, introduce a new flag `OBJECT_INFO_SECOND_READ` that tells the
> backend that we already tried to look up the object once, and that this
> time around the ODB source should try to find any new objects that may
> have surfaced due to an on-disk change.

Ok, now that the "files" ODB source combines the loose and packed
sources, we need a way to differentiate between first and second time
reads to void reading loose objects again. Makes sense.

-Justin
