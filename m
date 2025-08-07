Received: from mail-il1-f178.google.com (mail-il1-f178.google.com [209.85.166.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEFF24A07A
	for <git@vger.kernel.org>; Thu,  7 Aug 2025 22:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754605526; cv=none; b=NQHT87eCXTjm7jYHORHKjt8YghV6XioA1QpOKdxk/x8lTHuO2zgxC/vA+Sv2lT6P7ReE2LdeD+FhgD+Zn6x4ZHuYSGwqsQ8AjMp0jDde2Ql8eqWkRSoOrQrQTpQL9aFgZlHtMY+WxbiOIJ1NWSDyp0z61MWVCDRyZVM87e14K/c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754605526; c=relaxed/simple;
	bh=onXP4p7sG4Jd5k042relTDA9OMvQvlRv102lJeNeUCw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=dFVou8akKlB2qv2A2mErdGPPFzH6TmJ62cSbtsoODQ60v/0eR1VaVSpZZusFM2mqOpAxYlJYbmswhKNJ6DpE18a9klfZGImByAy+6uxkcgf8TN3Y1cowj8wZxQNV959nKTPAXS4F959yOZNMVfOCwAa7mIHGqm9YYLBq5xoGoqI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=Ln3xDkuZ; arc=none smtp.client-ip=209.85.166.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="Ln3xDkuZ"
Received: by mail-il1-f178.google.com with SMTP id e9e14a558f8ab-3e51f9e8b1fso5871965ab.0
        for <git@vger.kernel.org>; Thu, 07 Aug 2025 15:25:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1754605524; x=1755210324; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=AED9SspuNeUovax/cE3plSRVIvArhYncBmJJrXMgcFo=;
        b=Ln3xDkuZ7pfJtaRERPlgkF9YjoKYn9iEGoOFqfI1nM6w7qEAVCmBCx4BRLGE+bXwxW
         1qa8bf4izyFTB33jxmrVJiWz4MfVGx45xuGBm7a4dzz63sNurBlWcPUpgeU6RsybAcuB
         YsRtSnHm1mhKDyAqb0/R6j1VE7aSdRodmryd7Duei1J8LKrvH9An1R0b2P98l40Y1+R2
         71JUnAbsPb4cIDGNOJewd/XULR4m/8ebadX+HOuykbgwh0ZjutMPGl/denFKlzdwenHZ
         LN5eidKZPcD0ULM9yfXGlB5el6J1iuu0ciUT0XaxP6Xu2/JLsCi7w4XKZ1oP8UIWb8oY
         +jkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1754605524; x=1755210324;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AED9SspuNeUovax/cE3plSRVIvArhYncBmJJrXMgcFo=;
        b=k7f/hwaWPUeXG6SYMJHpxmS7z8DpzCNkAP5JwTLcxGjTiEsTD7M7PJYUWxE3+twXI7
         RFW/fKf9zB00PbV4ve2/vAEhaKhp9wkSQCibHGkidU36xS7BMnzGsW8declKEFv8FMCU
         /VStDXqftWNhLh+3yo94GAJ3njKhod4StvygDN72TPxDYU4zJLalP+TveRXYg+vuhnJW
         ccGvSheVXQvibF1v7vYVbXZ1f8bmcjSo27JUn48BaNwfMn7lC+4Fdkw/qMftIgXpJwhs
         6FBYzUKOVpggp8lal/qPPk+A2s//aw0zRgBxbz7tQoGdcZakD3EO+yLjBxmqQca6ctaU
         it3Q==
X-Gm-Message-State: AOJu0YxvZ4gPdPDdwhSfpqrgkWmpPP03j1axeDwER76wpMtUmtmi9PTg
	eJiRIKX9GSt+N5Or2fDrENyuo/2qBMvLmDZYtjlQqXbhqDXtS7U5UvlZLVOasNSK8+43OwIoL4Q
	Vp0Ty
X-Gm-Gg: ASbGncsjscKOrPglBJ8jlYwRKE0IjTgXwQKq2v88ACeN54VSa3KuIJTZJDHGCi/v8XL
	rO1Yt4rwJY1B8kwYRO8D3CZ44cvFQ92IoLLQ3sUaIEk5LWzRFkpFTFSPficKLJXU3tnkhrAuY6a
	rr2KY9zcAYmX9cKP8VTq+Y5WLW9/hVjUpAq/Ew43Il2lKr5eOQpPmNqGtzzmiJOqEUmekm4HUkK
	fPoFJC7VpkkCuJRLc0AfyZY6nQwbf3NA4S2uTpDfeihOVeD7BXMw7J0wUVmIaGEcJXWjPElLp3L
	jbDfxW/mEtYBOSX3LbqxuWzTHSps8izy6T7pfO3Ps5sqfF0rEHJGkfjuxW4/SSy0k28vrrdv1Wt
	K0Ajh2PkpnnMw7NC7/+fOG6gJ+kxRADAXnVTEeeq1no82HUg+j36tSkJr/B9uyogDumts0vdjk9
	pNBZbB
X-Google-Smtp-Source: AGHT+IElvTWt43EcLaQEBJvA93sgcOfw+1db1hUqgbj2qt3cP2ruzt6slZxbe1OCK8Ae2i7ODU6D8w==
X-Received: by 2002:a05:6e02:188f:b0:3e5:2646:df03 with SMTP id e9e14a558f8ab-3e53313e0e6mr16744165ab.12.1754605523908;
        Thu, 07 Aug 2025 15:25:23 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3e533cc1b7csm1131585ab.27.2025.08.07.15.25.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 07 Aug 2025 15:25:23 -0700 (PDT)
Date: Thu, 7 Aug 2025 18:25:22 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Toon Claes <toon@iotcl.com>,
	Derrick Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 6/9] midx: load multi-pack indices via their source
Message-ID: <aJUn0qeliNQ/nnWr@nand.local>
References: <20250807-b4-pks-midx-deduplicate-source-info-v2-0-bcffb8fc119c@pks.im>
 <20250807-b4-pks-midx-deduplicate-source-info-v2-6-bcffb8fc119c@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250807-b4-pks-midx-deduplicate-source-info-v2-6-bcffb8fc119c@pks.im>

On Thu, Aug 07, 2025 at 10:09:56AM +0200, Patrick Steinhardt wrote:
> To load a multi-pack index the caller is expected to pass both the
> repository and the object directory where the multi-pack index is
> located. While this works, this layout has a couple of downsides:
>
>   - We need to pass in information reduntant with the owning source,
>     namely its object directory and whether the source is local or not.
>
>   - We don't have access to the source when loading the multi-pack
>     index. If we had that access, we could store a pointer to the owning
>     source in the MIDX and thus deduplicate some information.
>
>   - Multi-pack indices are inherently specific to the object source and
>     its format. With the goal of pluggable object backends in mind we
>     will eventually want the backends to own the logic of reading and
>     writing multi-pack indices. Making the logic work on top of object
>     sources is a step into that direction.
>
> Refactor loading of multi-pack indices accordingly.
>
> This surfaces one small problem though: git-multi-pack-index(1) and our
> MIDX test helper both know to read and write multi-pack-indices located
> in a different object directory. This issue is addressed by adding the
> user-provided object directory as an in-memory alternate.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/multi-pack-index.c  | 18 ++++++++++++--
>  midx.c                      | 57 ++++++++++++++++++++-------------------------
>  midx.h                      |  6 ++---
>  t/helper/test-read-midx.c   | 25 ++++++++++++--------
>  t/t5319-multi-pack-index.sh |  8 +++----
>  5 files changed, 62 insertions(+), 52 deletions(-)
>
> diff --git a/builtin/multi-pack-index.c b/builtin/multi-pack-index.c
> index aa25b06f9d..e4a9305af3 100644
> --- a/builtin/multi-pack-index.c
> +++ b/builtin/multi-pack-index.c
> @@ -64,12 +64,20 @@ static int parse_object_dir(const struct option *opt, const char *arg,
>  	char **value = opt->value;
>  	free(*value);
>  	if (unset)
> -		*value = xstrdup(repo_get_object_directory(the_repository));
> +		*value = xstrdup(the_repository->objects->sources->path);
>  	else
>  		*value = real_pathdup(arg, 1);
>  	return 0;
>  }
>
> +static struct odb_source *handle_object_dir_option(struct repository *repo)
> +{
> +	struct odb_source *source = odb_find_source(repo->objects, opts.object_dir);
> +	if (!source)
> +		source = odb_add_to_alternates_memory(repo->objects, opts.object_dir);
> +	return source;
> +}
> +

Hmm... I admit that I am pretty unfamiliar with the --object-dir option
here and only have a vague recollection of why it was added in the first
place.

I am not sure one way or another if adding the user-provided directory
as an in-memory alternate is the right thing to do here.

Stolee (CC'd) would you mind sharing your thoughts on this?

Thanks,
Taylor
