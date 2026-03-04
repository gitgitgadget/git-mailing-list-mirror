Received: from mail-oa1-f45.google.com (mail-oa1-f45.google.com [209.85.160.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EF9D3612EE
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 20:54:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772657688; cv=none; b=XHd+ZSmEQLZu6W7J2DuLpNEwKCXtiTqa7ts2BqRXUagyhan2JYdqixrzHnKkMG+7haQPydNKfmbt/Q8pBxgVD40jmTvEvRdA2LW96prbI9czHFCxXsK/ihRYq362K4ClkQ8BVaHJwFKHfXbrHkL6TSmedX5acCggJ85eR475JRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772657688; c=relaxed/simple;
	bh=SausFkvCUFunYq/fbLQVz96ud3qIXxbXUueN8SnygQA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=W3TOs5/4qQQbRvAW+Nwa2FE+n8T//D49KUg1R1RE4+B1olzW/wo3hCnZ7vuuN7zJZ5Qd2hoEb0QWUktcK4T4ZYlazFS/xsEcrAAvS2Es/8+mxLX9Jjw5MCM1KSfluKKHrWM8TmXt70M1GT0Y9/yAeOeb/tMJsWtiHRcvovEa25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I/RvfTho; arc=none smtp.client-ip=209.85.160.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I/RvfTho"
Received: by mail-oa1-f45.google.com with SMTP id 586e51a60fabf-40f1a1f77a6so1601999fac.2
        for <git@vger.kernel.org>; Wed, 04 Mar 2026 12:54:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772657686; x=1773262486; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=D0oPwPaN27BWXdf9AwGiE3O89DirLMr8u8QmXzqdS6Q=;
        b=I/RvfThoa1cI6w29P6eK6T513Y9/WYQRx5aCgQqDMWxiCa1HUzAK7BQ/9DJeb8mzTa
         a20mC9VcboZ36u2oYEyJLzr4h99EJLxqlAfIV3KScOkVlZx8WTvedG2OhQVZ4hlbOR7k
         03nYBEaXefeSEyyu96cU+XWmb9eHeic/PRgOJpslR4eCqmvaHT2qmaqDafw5v460GeSy
         9N44Dwpd1mOIcmms0gCq1PCTYwj5iU+tW3yV6NddWnV1egra1v8DYlvnt3eOLgNpDzKD
         qunloXoLXOY5I4oSRn2GJUkhZjVvfWjfzCBwaVhMf88faFhTi7E/vdlEiD6IowLLQhwB
         h2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772657686; x=1773262486;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=D0oPwPaN27BWXdf9AwGiE3O89DirLMr8u8QmXzqdS6Q=;
        b=RYydk1D2RCCzB6VUMFLrIKefIxNCdrdP4+PsE+hmlOs380x66ouNgH0rJlenPUmuC2
         Kr96kbWeypVr+hpVAcrYIlZ6X24M7jOYfl/6jQ3xSxKGvYwviBDsH0muqio07FX3IFXk
         QC6cn7mAOw/kJgAqOj5hAZ0AHwCczYTPgTbdgVXNjdRaLvhk8ta9fRlLrEM0XjBvU0cg
         YfsfD+tM12uv2ccQRIIHyf9x1dyMyBzjEaijuPZcG5FLL0+ohEpic4Z43nQOasZCuWUQ
         n7lMoPqNNraLRX5I1Uf5QS1TUMF7En3ZOC8bj6/J3+h4LgtXl2FPB7nfIaD/A+9SzSdv
         aX4w==
X-Gm-Message-State: AOJu0Yy+79u2YQsylJqQvMcMt/cAwjjO8nUMqMTSitX5sFGCIf60aRmj
	Tr7FKZOYKhnoaACr00WG7L4km1I03qxcCH2fpC7VjcUKSR+CrQaWqYP9
X-Gm-Gg: ATEYQzyl5AO/R4IH0evrUkS0XuYufUfErp7M3OPGuCX8Nt9uYsZYDTa1kC2r4cxgOvE
	7pDqlkoHNz6a1cJJwnGYcYFrUjG9lhoKzQ8NZFYYkW3pdKQmKIpJ150ANL+Y57KMB61bYSlB9Ud
	FDDzu0BaEtIBTVKC+9e4DSOIt02qho600A8wi3oxX/orsApHJ8em5fQkQ6ehxvEtJaLiLvVdaGm
	TvpnzX1pwwj+Fesfa3Hm2qdNp5MHetWMl3wqqB3RKoBHaA5bEIaDihD95APf4wQRUWt/vWeTE3I
	Y/+Lt3jb6oWXyrOtBJq8UjjCqAumFVN5WAGbVZAFE0sX87AJ+J6biGZEYqCHPBQj7e6FeNohdSF
	nIJRyPAr1S66XWKC5G8Byjv/v124+tWRvpws4oXE/IqnyYu/9652KWdI+IBqIipFFLQ6V0cmtoE
	AtsdSyzDfKUe8a2Tvu
X-Received: by 2002:a05:6870:b3e7:b0:3f5:694f:9362 with SMTP id 586e51a60fabf-416aba7fe43mr2088261fac.29.1772657686117;
        Wed, 04 Mar 2026 12:54:46 -0800 (PST)
Received: from localhost ([136.51.44.64])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-4160d2cf00fsm18082589fac.20.2026.03.04.12.54.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2026 12:54:45 -0800 (PST)
Date: Wed, 4 Mar 2026 14:54:45 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 06/17] odb/source: make `free()` function pluggable
Message-ID: <aaiaNHaLPhYSK-oK@denethor>
References: <20260223-b4-pks-odb-source-pluggable-v1-0-253bac1db598@pks.im>
 <20260223-b4-pks-odb-source-pluggable-v1-6-253bac1db598@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260223-b4-pks-odb-source-pluggable-v1-6-253bac1db598@pks.im>

On 26/02/23 05:17PM, Patrick Steinhardt wrote:
> Introduce a new callback function in `struct odb_source` to make the
> function pluggable.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb/source-files.c | 7 ++++---
>  odb/source-files.h | 3 ---
>  odb/source.c       | 4 +---
>  odb/source.h       | 6 ++++++
>  4 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/odb/source-files.c b/odb/source-files.c
> index 7496e1d9f8..65d7805c5a 100644
> --- a/odb/source-files.c
> +++ b/odb/source-files.c
> @@ -18,10 +18,9 @@ static void odb_source_files_reparent(const char *name UNUSED,
>  	files->base.path = path;
>  }
>  
> -void odb_source_files_free(struct odb_source_files *files)
> +static void odb_source_files_free(struct odb_source *source)
>  {
> -	if (!files)
> -		return;
> +	struct odb_source_files *files = odb_source_files_downcast(source);

Now each callback will be responsible for downcasting to the concrete
type. Looks good.

>  	chdir_notify_unregister(NULL, odb_source_files_reparent, files);
>  	odb_source_loose_free(files->loose);
>  	packfile_store_free(files->packed);
> @@ -40,6 +39,8 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
>  	files->loose = odb_source_loose_new(&files->base);
>  	files->packed = packfile_store_new(&files->base);
>  
> +	files->base.free = odb_source_files_free;

Callback is registered.

> +
>  	/*
>  	 * Ideally, we would only ever store absolute paths in the source. This
>  	 * is not (yet) possible though because we access and assume relative
> diff --git a/odb/source-files.h b/odb/source-files.h
> index 803fa995fb..23a3b4e04b 100644
> --- a/odb/source-files.h
> +++ b/odb/source-files.h
> @@ -21,9 +21,6 @@ struct odb_source_files *odb_source_files_new(struct object_database *odb,
>  					      const char *path,
>  					      bool local);
>  
> -/* Free the object source and release all associated resources. */
> -void odb_source_files_free(struct odb_source_files *files);

The forward header is no longer needed as this function becomes an
internal detail of how the "files" source is impelmented.

> -
>  /*
>   * Cast the given object database source to the files backend. This will cause
>   * a BUG in case the source doesn't use this backend.
> diff --git a/odb/source.c b/odb/source.c
> index c7dcc528f6..7993dcbd65 100644
> --- a/odb/source.c
> +++ b/odb/source.c
> @@ -25,11 +25,9 @@ void odb_source_init(struct odb_source *source,
>  
>  void odb_source_free(struct odb_source *source)
>  {
> -	struct odb_source_files *files;
>  	if (!source)
>  		return;
> -	files = odb_source_files_downcast(source);
> -	odb_source_files_free(files);
> +	source->free(source);

Freeing the source can now be gone generically for different sources.
Nice. :)

>  }
>  
>  void odb_source_release(struct odb_source *source)
> diff --git a/odb/source.h b/odb/source.h
> index a1f2f8fdb1..f84da59ef0 100644
> --- a/odb/source.h
> +++ b/odb/source.h
> @@ -52,6 +52,12 @@ struct odb_source {
>  	 * the current working directory.
>  	 */
>  	char *path;
> +
> +	/*
> +	 * This callback is expected to free the underlying object database source and
> +	 * all associated resources. The function will never be called with a NULL pointer.
> +	 */
> +	void (*free)(struct odb_source *source);

Looks good.

-Justin
