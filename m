Received: from mail-yw1-f177.google.com (mail-yw1-f177.google.com [209.85.128.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CF4028B7DF
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 23:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752189273; cv=none; b=gfaBOao1VqimdwPtiUtZ1rOwaMXhYBjh9DsUKTNjtQ5RsQ49j3DCmGsEnPAe9Y3rWVmrekgLOqr34VL7dnB++1+w4EvW9ofaQYL1b5RNLnbxJddCT5Am1pAXL5/kq666fpMRJRWdvRNqvxZkhrrqYuBvDkeNZwbTM896HNju6/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752189273; c=relaxed/simple;
	bh=Km837+LKK+l693qbT6sAONgFJlLafZgfiph6Qc8Cw9M=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=m488f7tys7Ph+3p5+jLjS1+XoBYXe26ZqlKQ4zCyw25i6Z2RIWn0P5r6vbAar8WOl8hBTbCOhZc3hwa+5Kwwai2KFg+oXsvxJRXOaJ+0I1Y3sO3osXYiVtGI+UpP+URib2v0teXDAMn1NQ4D7OIJsd8Ai+5Pc/O9JnvsG5nEvXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=ND8XNYM/; arc=none smtp.client-ip=209.85.128.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="ND8XNYM/"
Received: by mail-yw1-f177.google.com with SMTP id 00721157ae682-710e344bbf9so15948287b3.2
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 16:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1752189270; x=1752794070; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=45ZBbL35eD7ZxxekwcaFyPLtZgjXw6rHkV8/0PjLpnA=;
        b=ND8XNYM/+4g+qVrxRdrulE4OsPD1vPOcFSf3JmCdWkHvw0EImd7BndAN7q3gNIVG7B
         PKz/AOa6b9cSsEu8ZwyMwS+qgsI1zsFtlqpXyMxTyNdE+yZ0T/JcTI9WDWyk7yVnEVSq
         RhWvoNfdgIXcU6DG+zh1LGEjiUdjMwv1AIW4Y2JU3QF6qvAfvhlGcl86bdJf52VIPmOU
         2A8AjJJAVuXKCBxpaOgLihBR5wdk8FaoZWX5VfFp7uQhGtkBbClDPCvjfq7HOGC2j88N
         4ix6vVUWykkzNSetvC/QLNhyhf37+9iRVVTmbL+IdL7MIXmNRluSOo9fGPv57ALaK2kD
         8ukQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752189270; x=1752794070;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=45ZBbL35eD7ZxxekwcaFyPLtZgjXw6rHkV8/0PjLpnA=;
        b=JezOdMfslX1I1g7wKyILa265dXKhJqE0DcVEJYiX2UXkMFCJ3G6vfroy9ltoBjCo/D
         HaiKkDxGB3edsS9tp4SfUKGNuEyTYZzT+kToVvrzFIkm7MFlzujeWCKNc0W4ooIJkyik
         RAfLFO37OFax0kkn+Yj899P1UJ+Xsldr6HvBjCNNcaQPu3Dj7bnc3By5x8nTplEsYjEd
         2+9J2ymWFUkE4boDVJ4d5XNTvv08ITGPYEci+CI7XRmQdV/cp/m7dyAr2n0Jcdr5Kpmu
         X2069983GZ+j/MisHoNYJ84K8RwHuZbTtNOzbV5LWJrWuYYdJLni0oYX9Q8ZBj1rVqAd
         VqOw==
X-Gm-Message-State: AOJu0YyqP5GMmNyJqXY5Qg8+d1+LioKwvMeHVlsq53PPDmwWEC2zsNA4
	T++IP+LFSUjZe670Wb21FdR3fNbZjyQmuYRKs5p9rjFHXl/k11yQA3bo99+a48uUV8IE0zfoYQw
	ciiGBRzA=
X-Gm-Gg: ASbGnctYFAY8V6tTTw5RP1NigiwF0YTAovMDagVqSFzATwisCgVKr3Xc23sWTUHXlQO
	eOuU2jRVXzindn6WGuAbhhdtkhLXOB2QFYt2XuW4wkG6LPJuJCEbPSDBd+zXkllb4/r4UfNc92T
	JtIcDkXHe1UVkMIZZLT13xXDUL775VeEUZvwa9E9sENFpqg/2JlKHysrJvjkR0Idlr2ZEu2v68X
	dac5ysHQlSG5NZr38xqOjrHs7vTyM8G+D/9SM7ThFL+c0jS+TTpDFEaN4iPGEJNKf6JcYBhK4AB
	fbHR5SPRBpW+oUnhm9IrhC0DDSmn5BhxgM9TJaRpufqGAt61Uz6Oj9t4aVfketHtV2tf3jwT7Io
	gXdmcWuel5thdACcd4xFeS8hZMhwSc/4gFiqMUzUe9IjA11hSeSEg3FAwlWrCobqKInmp+A==
X-Google-Smtp-Source: AGHT+IHj5yE68qz3grCELDAoTUPoGGFo593mwNAHoOliwxsov87NhB640E4k9mX7jVv6Rlyf6RybDg==
X-Received: by 2002:a05:690c:730a:b0:70e:7882:ea8e with SMTP id 00721157ae682-717d7a619b4mr16684587b3.31.1752189270470;
        Thu, 10 Jul 2025 16:14:30 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id 00721157ae682-717c5d5a71esm5117727b3.19.2025.07.10.16.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 16:14:30 -0700 (PDT)
Date: Thu, 10 Jul 2025 19:14:29 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/8] packfile: refactor `prepare_packed_git_one()` to
 work on sources
Message-ID: <aHBJVZsFRUUM+vXu@nand.local>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250709-b4-pks-midx-via-odb-alternate-v1-2-f31150d21331@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-2-f31150d21331@pks.im>

On Wed, Jul 09, 2025 at 09:54:50AM +0200, Patrick Steinhardt wrote:
> In the preceding commit we have refactored how we load multi-pack
> indices so that we take take the source as input for which we want to
> load the MIDX. As part of this refactoring we started to store a pointer
> to the MIDX in `struct odb_source` itself.

The first sentence here is a little confusing, but may read more clearly
if written as:

    In the preceding commit we refactored how we load multi-pack
    indices to take a corresponding "source" as input.

> Refactor loading of packfiles in the same way: instead of passing in the
> object directory, we now pass in the source for which we want to load

s/for/from

> packfiles. This allows us to simplify the code because we don't have to
> search for a corresponding MIDX anymore, but we can instead directly use
> the MIDX that we have already prepared beforehand.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  packfile.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
>
> diff --git a/packfile.c b/packfile.c
> index 16efc2fdca3..b43dd2fe6cb 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -935,22 +935,17 @@ static void prepare_pack(const char *full_name, size_t full_name_len,
>  		report_garbage(PACKDIR_FILE_GARBAGE, full_name);
>  }
>
> -static void prepare_packed_git_one(struct repository *r, char *objdir, int local)
> +static void prepare_packed_git_one(struct odb_source *source, int local)
>  {
> -	struct prepare_pack_data data;
>  	struct string_list garbage = STRING_LIST_INIT_DUP;
> +	struct prepare_pack_data data = {
> +		.m = source->multi_pack_index,
> +		.r = source->odb->repo,
> +		.garbage = &garbage,
> +		.local = local,
> +	};
>
> -	data.m = r->objects->multi_pack_index;
> -
> -	/* look for the multi-pack-index for this object directory */
> -	while (data.m && strcmp(data.m->object_dir, objdir))
> -		data.m = data.m->next;

Right, since we know that the MIDX corresponding to this source belongs
to the same "object_dir" path. Having an ASSERT() here may make that
more clear, but this change looks correct to me.

I am still a little unclear on how sources and ODBs correspond to one
another, but under my working assumption from the previous patch, I
think this is right.

Thanks,
Taylor
