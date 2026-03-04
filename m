Received: from mail-oi1-f182.google.com (mail-oi1-f182.google.com [209.85.167.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B85B133D6F9
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 16:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772643452; cv=none; b=dpoGxMm62cW0SXeJ0CNoqx6hKwrQqYvkHm5yzauhme+2ytD56UlcWE2GSIPO1dKwm+pB43lvKrVH0L4Gp0rekpn/df81rf4iQB6nJmumMuUHicF2MJgv+/LifOZpsWPN4Mv/eIgUOqPNbBab+8tJUJrsCDIWb3HNi6wrEOtFMcQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772643452; c=relaxed/simple;
	bh=vrnujjlEZ/6K9ceS1ghErwqVCfosDHml+W9fWcpCupE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=upuFIMNIdA6aDPyK8ywkzAtW8vQo8su8a+qWYdGiGUb2fcjifndpdfUm5YJwdxtXxNRPes4x0QpN4Vc5wKQOlvYOZP9xclQ5S1TTPNsDdXCg18S7QFNZNg8I4XvmbE2oDRAQxZWL4AlwZIe31fy4h5Z7xzCeY8tiIRH9vH/6UKw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AEVr/C4F; arc=none smtp.client-ip=209.85.167.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AEVr/C4F"
Received: by mail-oi1-f182.google.com with SMTP id 5614622812f47-463a0e14b4cso3011165b6e.1
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 08:57:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772643449; x=1773248249; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IZuYCo9V/sHZKw1lRDgPC6efsMehU0SqDheW+YgRQZI=;
        b=AEVr/C4F+qaHwP7zCRIYGMNKNC+jr8KLtJ4RQKcaYN1tKjmfQpefzXO1F8CQXsPrTt
         PFWBSKIYv9YCKfnM8TLDfOvAM+V2b2rNSeJq9YdXrFK1D4aBVWI3A5JsJsvvhgGQTnw7
         7pnxE5P5rvA21jeee8lWpQwMqMnt+1EUGE2u6p2++guJMl8rJISiWQnBIErG9zxcCl9I
         rkbGtiXSc8+yXGnUeUWusrvRZFDnH+vEJaPMEJFpRzvhnN1vrbVHvWNDqFB8IwH+3ZBU
         194djv7GZy+1TayUncIS50iBTzbJHnFyV2a4nmNS1fssSoawtSzofZpvbnieB6XFOLPY
         GLDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772643449; x=1773248249;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IZuYCo9V/sHZKw1lRDgPC6efsMehU0SqDheW+YgRQZI=;
        b=fR2dGccn4LIgEoxlR1EENnnWStk1S5kK9a0k99T+dDYqIHva57NkT0y4kk70qLqunH
         yr+6rjdJ5IbDfrLD0WsL/1qLnWEKZ/6fnAsAPnXSqmrdVQ0HTK7074E/Xpp0uhIEjaQr
         8u7waFDaghtE7EhggR34/g+NnoOmEjOJamKazuAz1XxLyrX2Hxa/RFL3qJdgyKaE0+FG
         LSF+QZiVhFLrBX+i/0bwO/Y+cwBwJQ4FgeR+K5e3zIuprm/jRL8vwcWsJUSkpjULp/KI
         poBivZ1hN5Zd5QD0EiZVn8zkX5jQuCj4q9XAjJ+wG+vqlzqJH6abRChLpd0zz2q9zAQK
         FbWw==
X-Gm-Message-State: AOJu0Ywqa8UHb6wDwLjIRLs41x+55f+ZH/NJarnTXm0k+Tl5fYqCOjO/
	T8GNd+rKrJIGjvjdQW27I13nXZOHuWOhVVqBFiMLcdYGzMnJp4rKOMJcaBly1w==
X-Gm-Gg: ATEYQzxFYNNtfFyRFIePRtupASJxfOuG+kspmQRFsHwCa8D3dzd6u2XBZJpBVPggWWw
	Yt8iugDcNtREIZGj1knSD0qkcgX/eeg8WSU2dLjk9NyYO5GC8PLrJOd7yK7Xt9VCsZC38lKoa8V
	TrTwGQQoAESYlUBBZcusiaaHMxJwe3QAwUmWELA0cQU4y0ulxV05IxYrIzFDikdKP5MCEgdKK9W
	zQMPG92Ondms1NyhoyZJxQ5jJGZKKWwGdvFh23NNs2cmW8pbZjHhZWVtjLmxfYEc2N7sHXe/upn
	7F5ZfeaOT2WChVvMmCBtQ+lp2DzhYYX5QdnZq6LiWT70PVcQVZwz7Go+z2Gq+GiDNh13xvC4xPv
	Xu5PSr+1bJjqG36wg0lznJ5vtwx7pRLh944tcm4iM8Wp0yEMgZ2TVtE5n1mR8gQC7kZP38MGl59
	04Lx4xSR2vpC6Gvhkg
X-Received: by 2002:a05:6808:4f6c:b0:463:f569:360b with SMTP id 5614622812f47-4651ad62a1cmr1306056b6e.56.1772643449616;
        Wed, 04 Mar 2026 08:57:29 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 5614622812f47-464bb3ab3e5sm11949575b6e.6.2026.03.04.08.57.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 08:57:29 -0800 (PST)
Date: Wed, 4 Mar 2026 10:57:26 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 02/17] odb: introduce "files" source
Message-ID: <aahbTN_lFx1Jhy7U@denethor>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-2-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-2-253bac1db598@pks.im>

On 26/02/23 05:17PM, Patrick Steinhardt wrote:
> Introduce a new "files" object database source. This source encapsulates
> access to both loose object files and the packfile store, similar to how
> the "files" backend for refs encapsulates access to loose refs and the
> packed-refs file.

Makes sense.

> Note that for now the "files" source is still a direct member of a
> `struct odb_source`. This architecture will be reversed in the next
> commit so that the files source contains a `struct odb_source`.

Ok so for now all ODB operations are going to reach directly into the
contained "files" source.

> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> diff --git a/odb/source-files.h b/odb/source-files.h
> new file mode 100644
> index 0000000000..0b8bf773ca
> --- /dev/null
> +++ b/odb/source-files.h
> @@ -0,0 +1,24 @@
> +#ifndef ODB_SOURCE_FILES_H
> +#define ODB_SOURCE_FILES_H
> +
> +struct odb_source_loose;
> +struct odb_source;
> +struct packfile_store;
> +
> +/*
> + * The files object database source uses a combination of loose objects and
> + * packfiles. It is the default backend used by Git to store objects.
> + */
> +struct odb_source_files {
> +	struct odb_source *source;

I don't think we use this anywhere yet, but I suspect this is the
placeholder for the "base" ODB source.

> +	struct odb_source_loose *loose;
> +	struct packfile_store *packed;

So with this patch we are really just moving odb_source_loose and
packfile_store into `struct odb_source_files`. Most of the other changes
are just fallout from this structural change.

> +};
> +
> +/* Allocate and initialize a new object source. */
> +struct odb_source_files *odb_source_files_new(struct odb_source *source);
> +
> +/* Free the object source and release all associated resources. */
> +void odb_source_files_free(struct odb_source_files *files);
> +
> +#endif
[snip]
> diff --git a/odb/source.h b/odb/source.h
> index 391d6d1e38..1c34265189 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -1,6 +1,8 @@
>  #ifndef ODB_SOURCE_H
>  #define ODB_SOURCE_H
>  
> +#include "odb/source-files.h"
> +
>  /*
>   * The source is the part of the object database that stores the actual
>   * objects. It thus encapsulates the logic to read and write the specific
> @@ -19,11 +21,8 @@ struct odb_source {
>  	/* Object database that owns this object source. */
>  	struct object_database *odb;
>  
> -	/* Private state for loose objects. */
> -	struct odb_source_loose *loose;
> -
> -	/* Should only be accessed directly by packfile.c and midx.c. */

Is there any value to keeping this comment around?

> -	struct packfile_store *packfiles;
> +	/* The backend used to store objects. */
> +	struct odb_source_files *files;

For now we store a direct reference to the "files" ODB source, but I
assume in the future this won't be the case and instead will cast the
"base" ODB source into its concrete type as needed.

-Justin
