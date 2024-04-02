Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84EE014AD1D
	for <git@vger.kernel.org>; Tue,  2 Apr 2024 16:27:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712075281; cv=none; b=sYMqfYIh10Wk5aCHMVULzz85LbiLk9ILcWx+MoE3gi6mokBpeBhChnnyO8zDxA1Rc8qlL3lns9AKidmCCkMbPb5obOUHn3U94ILuz9eJHgYSsHeDZHq2uwPDJVT4SjCJYgZVqlFJEZz9zVa2v/65V/CysyjlW7h/iyEEpl7D2zM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712075281; c=relaxed/simple;
	bh=t9O6lhjGv7Ko36Q47n9k5qNv853auGIkeaAMVfdknNI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=MDtJKj11CHd+vLhMVU5MumsBG3d5N/aQ2R5Rwj3Wt/vGEG/5tzSOZ0PSJnrTioU6hSfb7SngHk7UlqtxtNblvIGbq9JpMlWAG6dxswfROn/gzzpFPy2BS1n2qxI1Nb9e+4QPOkTcn+6k9G0LZ7qRw8P9XzSd/bA63ibRkS5DN6U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X5CE8mR+; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X5CE8mR+"
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-5a7c3dd2556so1003999eaf.1
        for <git@vger.kernel.org>; Tue, 02 Apr 2024 09:27:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1712075278; x=1712680078; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=aO+TnTxITWRrbEPK5eNMgNmoddtF+nLKY3HxU9XLVI8=;
        b=X5CE8mR+uqHiuGaBRPgcyG4zyhOomCmww1/WpZl4UrcTW0B9ERC/AKqoF9rbrPKa0p
         GMLhBST2z19FtZbCuDtypFMFkWdMAWrbm/prWXS9sthcYYAl44jdi02xz60wvVKbFWVm
         1ws4AmD2USI8SGkIMY8fqAj/45nMhKsmfmxFY8Pijpz/+v3LxvRHUX8Fr0eIQ8nnj+cR
         P1ovS27jyHruBPsb5rW+8GemiAxamzpR0voNNyJzIM9kfkYbLO7T3ndfCNCXJk9uqYdC
         h0ENckV//RkzQdANeGSR8BDrmtiGQ3lxTg8JxrldR2m7lA0ysh6DVRh07jM8ROU31w1u
         Gksw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1712075278; x=1712680078;
        h=in-reply-to:content-disposition:mime-version:references
         :mail-followup-to:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aO+TnTxITWRrbEPK5eNMgNmoddtF+nLKY3HxU9XLVI8=;
        b=DSM3z/eX6Vt77z5DTLdsCzPud4mJddaYiC5cXa8R5x2vSfmE5GJHXj+nc+6CcfzEER
         mT8nP9P7Llel9rpeP1crBbUW4ovhbTELwEZBtGzWCgD3M5J03PjOmthLLP0rtbQmvIxp
         ZgXmZC/8i2/YVJyzh8BtEf0WddEP0lNI3PmdJH8Sc/dZhgk7t2tOEK9zVzamk/YPz2F3
         NsTXkkzr41FbwKy7JuFNCIasPVLfFEXOHOP/vv946DF06gvmak+YYVL+riDDfhb9W6Eq
         1f7Rebtz/fTV8aJrfvGZ5eqgWfxyZAEMwpxBJtsqltV2sYJoOxIo14m+/MgTvaYSriYR
         5NzQ==
X-Gm-Message-State: AOJu0YxSSexeesFNxzJQ2DFbvU9Nxxxoz93PNqrnp8TOvetDA9T8kkOV
	Jpr8DiZJPu6BZiv1A5yNDbCo9kLA1/oLvasPHrVp2y2y5xw42BM053XbG6Xz
X-Google-Smtp-Source: AGHT+IFM7MvZ8bszLw03FrTjMhSW5Osm7Z2JtmGHfhk19m9gl7CuBpDZq9havpkOEebp4mR1JJQXoA==
X-Received: by 2002:a05:6820:c87:b0:5a5:2714:7df5 with SMTP id ei7-20020a0568200c8700b005a527147df5mr462215oob.5.1712075278437;
        Tue, 02 Apr 2024 09:27:58 -0700 (PDT)
Received: from localhost ([136.50.225.32])
        by smtp.gmail.com with ESMTPSA id dh17-20020a0568201e1100b005a48e64c699sm2803855oob.40.2024.04.02.09.27.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 02 Apr 2024 09:27:58 -0700 (PDT)
Date: Tue, 2 Apr 2024 11:27:01 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 3/7] reftable/refname: refactor binary search over
 refnames
Message-ID: <zvw6ezlchqyl5tq4zuia7az5b3i4swwvtm42muwe4i7gngswgz@ztujhb4ruewm>
Mail-Followup-To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1711109214.git.ps@pks.im>
 <cover.1711361340.git.ps@pks.im>
 <9ffcf45c32f22245c9978436affcefa914fc6927.1711361340.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9ffcf45c32f22245c9978436affcefa914fc6927.1711361340.git.ps@pks.im>

On 24/03/25 11:10AM, Patrick Steinhardt wrote:
> It is comparatively hard to understand how exactly the binary search
> over refnames works given that the function and variable names are not
> exactly easy to grasp. Rename them to make this more obvious. This
> should not result in any change in behaviour.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  reftable/refname.c | 44 ++++++++++++++++++++++----------------------
>  1 file changed, 22 insertions(+), 22 deletions(-)
> 
> diff --git a/reftable/refname.c b/reftable/refname.c
> index 64eba1b886..9ec488d727 100644
> --- a/reftable/refname.c
> +++ b/reftable/refname.c
> @@ -12,15 +12,15 @@
>  #include "refname.h"
>  #include "reftable-iterator.h"
>  
> -struct find_arg {
> -	char **names;
> -	const char *want;
> +struct refname_needle_lesseq_args {
> +	char **haystack;
> +	const char *needle;
>  };
>  
> -static int find_name(size_t k, void *arg)
> +static int refname_needle_lesseq(size_t k, void *arg)
>  {
> -	struct find_arg *f_arg = arg;
> -	return strcmp(f_arg->names[k], f_arg->want) >= 0;
> +	struct refname_needle_lesseq_args *f_arg = arg;

nit: Looks like the `f_arg` variable name is a remnant from when the
type was called `find_arg`. Do we want to rename this to `args`? We 
could also rename `void *arg` to `void *_args`.

> +	return strcmp(f_arg->needle, f_arg->haystack[k]) <= 0;
>  }
>  
>  static int modification_has_ref(struct modification *mod, const char *name)
> @@ -29,21 +29,21 @@ static int modification_has_ref(struct modification *mod, const char *name)
>  	int err = 0;
>  
>  	if (mod->add_len > 0) {
> -		struct find_arg arg = {
> -			.names = mod->add,
> -			.want = name,
> +		struct refname_needle_lesseq_args arg = {
> +			.haystack = mod->add,
> +			.needle = name,
>  		};
> -		size_t idx = binsearch(mod->add_len, find_name, &arg);
> +		size_t idx = binsearch(mod->add_len, refname_needle_lesseq, &arg);
>  		if (idx < mod->add_len && !strcmp(mod->add[idx], name))
>  			return 0;
>  	}
>  
>  	if (mod->del_len > 0) {
> -		struct find_arg arg = {
> -			.names = mod->del,
> -			.want = name,
> +		struct refname_needle_lesseq_args arg = {

nit: In the other commits we use `args`. Do we want to be consistent?

-Justin

> +			.haystack = mod->del,
> +			.needle = name,
>  		};
> -		size_t idx = binsearch(mod->del_len, find_name, &arg);
> +		size_t idx = binsearch(mod->del_len, refname_needle_lesseq, &arg);
>  		if (idx < mod->del_len && !strcmp(mod->del[idx], name))
>  			return 1;
>  	}
> @@ -71,11 +71,11 @@ static int modification_has_ref_with_prefix(struct modification *mod,
>  	int err = 0;
>  
>  	if (mod->add_len > 0) {
> -		struct find_arg arg = {
> -			.names = mod->add,
> -			.want = prefix,
> +		struct refname_needle_lesseq_args arg = {
> +			.haystack = mod->add,
> +			.needle = prefix,
>  		};
> -		size_t idx = binsearch(mod->add_len, find_name, &arg);
> +		size_t idx = binsearch(mod->add_len, refname_needle_lesseq, &arg);
>  		if (idx < mod->add_len &&
>  		    !strncmp(prefix, mod->add[idx], strlen(prefix)))
>  			goto done;
> @@ -90,11 +90,11 @@ static int modification_has_ref_with_prefix(struct modification *mod,
>  			goto done;
>  
>  		if (mod->del_len > 0) {
> -			struct find_arg arg = {
> -				.names = mod->del,
> -				.want = ref.refname,
> +			struct refname_needle_lesseq_args arg = {
> +				.haystack = mod->del,
> +				.needle = ref.refname,
>  			};
> -			size_t idx = binsearch(mod->del_len, find_name, &arg);
> +			size_t idx = binsearch(mod->del_len, refname_needle_lesseq, &arg);
>  			if (idx < mod->del_len &&
>  			    !strcmp(ref.refname, mod->del[idx]))
>  				continue;
> -- 
> 2.44.GIT
> 


