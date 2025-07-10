Received: from mail-oa1-f53.google.com (mail-oa1-f53.google.com [209.85.160.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F19A2FE308
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 21:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752181989; cv=none; b=EXZdPG7ODtAR6t27ANRQ/lz5S/lWG+g2blojBjcztRHZ0ghb3OQeZG8KK44iLyrDdjq9enBxDYDN6AGzU6qyk2QCtdveoiOymJ07OnaMfBzO1kYRKPLBIs3WvLkUjVd/Vq5++dM3JJ9kPAkRvu4/uVwltH4kh+fqcjSQAipu9XY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752181989; c=relaxed/simple;
	bh=Zf4U0Hru3k9oncV04TVvwcHjHXWaLbsSGu/OUUslcig=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KtbKf9uikYIDRNGGRd+9sdxOuUI/TMdYODBvQSNHyg5vZS/IVMA97DjkjGTaTlZuaXeaI7xEua4YKOxBA4S5FnFonzBpNHhAqA027hYkxkvnhqt925eTgj5/d5zPGqDFgpgEigK485OVha1CjwmnjDNYQus8C4sJw7WYT//qJfQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DIpWxQy+; arc=none smtp.client-ip=209.85.160.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DIpWxQy+"
Received: by mail-oa1-f53.google.com with SMTP id 586e51a60fabf-2efb0b03e40so382978fac.0
        for <git@vger.kernel.org>; Thu, 10 Jul 2025 14:13:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1752181987; x=1752786787; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=iFIZvTh8JRO3mYrGKI6esxr4qal7iocncQQqbcyC3p0=;
        b=DIpWxQy+YOCRzgVKkvp91/JOSCDEz1WZxs0zegCFbxYEhyrcCu3mTCSrpKZ9ZK0lWi
         Ye8sCLyLga3h90XYRS3EqAGZ6YAB5zMYiiN3RKUX4MYYYvTgwXZQSLHd7Q7V7HJ580F5
         iCSQHxfj17rM+/2rpOqxowS+31XhuzSpsjH2JkR+LN9vgUZDeNdDz1JMEfQMDhMdoEjG
         zdYVCd9ll0dS+pQ+2p5Ch/RdectUqFr6oTx7mDSMjbaaepKpy9l6PggANT/gpps/WLPn
         WA7sG2D1VgWqQmklDES04PvzVDCeBqwYZgkX5hYeMha5e3kVDg5OW/w0yWyh+PbD8GRB
         qSNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1752181987; x=1752786787;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iFIZvTh8JRO3mYrGKI6esxr4qal7iocncQQqbcyC3p0=;
        b=NeoNKP6aijchuupjYKh+6K4Z1KFQ438wcypINgbV6JBwenwkOE73ny69RC66tFtR/6
         jxvJyZkILxSCp7PFlm03lejYbh12jjG6aWHgPyhtA9kt4GyqfrRzzLx8dyx8otN8TgvG
         jJ0TZjb+FslROIhnpnAWJHRPwFkm9cUOubYL8VHoMisJJnH6PulyqUCZdslRDObivlKi
         jQZJ3vNKWHkiE3MajKuU6gnbBBh17/Fk8pOGWRUOgtTfdP69JwB97Wu+YUlcd7381b01
         E+0i5OJUvUEkcmV5Yi186eNSPRZ1xIIrev8L4F1IrY2nDQZbeuxhBuBJ60Odx6o2Tf5p
         C1Ng==
X-Gm-Message-State: AOJu0Yyft28veCYkZQGUi3OqNjubHtcoVzCRF8RvouES05FonekULCOC
	jTu+c3i0QyP6bK4xF6GfjxLkCh8OLPHLuB3L7KK/ycg3k4faTVkSNhBQ
X-Gm-Gg: ASbGncvL487z00hkp4mv7V4ilQVYZzKpR/joRYNKpycMVjAMgO/imCZ7oNXcAWaD5i1
	qkoejVTqDSv7x/U0UFdWAG+JKeVCIS/xGC3KfVGIZ9TFwi0QrH+gmPlVEyUDEFkS4lg/HEz9Gfh
	j4pBF99IrcujzUwGR0hTqNbpaRhiSOFY4NUQrCAzU4vAtDev0xakLZIsmCCrmeMzuQQxC5Z7TW6
	W+BoTg7SHEy6Wb3U9sBF1jq4WpuL9oWEtS3rrdFrp/H5NtI+RLM7nP6STqzs5v4b8Tej0Lwa+ui
	5lOoWuATnTZG+Rldskkq0UFg7xoTSOdqOFj4d8NDHOY0oFrVgwyQk0FQDhkdOfdbk4chvLP3xRt
	okYmgG+toWcM7WKo=
X-Google-Smtp-Source: AGHT+IGLfM04dddNWYbk05H0ZMyYFb0Wegbtbhdtcb5PyugalETx69nA8L2jX7O33g/GCHPEZ/3zcQ==
X-Received: by 2002:a05:6870:3b87:b0:2c2:b9cc:afb8 with SMTP id 586e51a60fabf-2ff26713f5emr675134fac.7.1752181986949;
        Thu, 10 Jul 2025 14:13:06 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with UTF8SMTPSA id 586e51a60fabf-2ff116d60f1sm461011fac.39.2025.07.10.14.13.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Jul 2025 14:13:06 -0700 (PDT)
Date: Thu, 10 Jul 2025 16:07:29 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/8] packfile: refactor `prepare_packed_git_one()` to
 work on sources
Message-ID: <vr4sormcum4wso3tby4zuozjexms4skycfqio53rnud5jrrw7x@opk7ushh6jkt>
References: <20250709-b4-pks-midx-via-odb-alternate-v1-0-f31150d21331@pks.im>
 <20250709-b4-pks-midx-via-odb-alternate-v1-2-f31150d21331@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20250709-b4-pks-midx-via-odb-alternate-v1-2-f31150d21331@pks.im>

On 25/07/09 09:54AM, Patrick Steinhardt wrote:
> In the preceding commit we have refactored how we load multi-pack
> indices so that we take take the source as input for which we want to

s/take take/take/

> load the MIDX. As part of this refactoring we started to store a pointer
> to the MIDX in `struct odb_source` itself.
> 
> Refactor loading of packfiles in the same way: instead of passing in the
> object directory, we now pass in the source for which we want to load
> packfiles. This allows us to simplify the code because we don't have to
> search for a corresponding MIDX anymore, but we can instead directly use
> the MIDX that we have already prepared beforehand.

The `odb_source` now contains readily contains MIDX, objdir, and
repository which allows us to simplify. Nice

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

Much simpler now :)

> -
> -	data.r = r;
> -	data.garbage = &garbage;
> -	data.local = local;
> -
> -	for_each_file_in_pack_dir(objdir, prepare_pack, &data);
> +	for_each_file_in_pack_dir(source->path, prepare_pack, &data);
>  
>  	report_pack_garbage(data.garbage);
>  	string_list_clear(data.garbage, 0);
> @@ -1040,7 +1035,7 @@ static void prepare_packed_git(struct repository *r)
>  	for (source = r->objects->sources; source; source = source->next) {
>  		int local = (source == r->objects->sources);
>  		prepare_multi_pack_index_one(source, local);
> -		prepare_packed_git_one(r, source->path, local);
> +		prepare_packed_git_one(source, local);
>  	}
>  	rearrange_packed_git(r);
>  
> 
> -- 
> 2.50.1.327.g047016eb4a.dirty
> 
> 
