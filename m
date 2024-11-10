Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B306224FD
	for <git@vger.kernel.org>; Sun, 10 Nov 2024 21:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731275256; cv=none; b=QYg8OdshTg7e7KeMrtCjKumsOu20bHOcBK5wY9igZXeBBAXFjdWHvcmB+QBNSuQEdnDIRDyC2ijRv4spylh+arVUTTg4dil8+D5vVP1K2ajxR/7uo72yfyEaBW9mRIVfn1OzzX6xs+7SUbCli0dQjDgXTJ0ebUjttWsmYehSqIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731275256; c=relaxed/simple;
	bh=KEiq1PvWJxV1vcRM3ENeCvc7p4rW27iCNaynu78byLA=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=gEq/3Cz3bzNk6c6JgMKRkxFv69ha0dqs6v/dPx2I2DOOiha7D8A35cJpgGQ+BN72BMmM2HVZEwetDrBAHJTtK9eCOzL0oqa2uPHGwv095LcGo/iyBfsXgc5shuU/q02K4WR6z8kWteFQHqVzl3LdvBs4gmd4higAXUlnZXMvzmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DVw1TDYt; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DVw1TDYt"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-37d4fd00574so2125495f8f.0
        for <git@vger.kernel.org>; Sun, 10 Nov 2024 13:47:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731275253; x=1731880053; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id:from
         :to:cc:subject:date:message-id:reply-to;
        bh=TAZVrRtM224E6mv9ejk3x7Uj472YD4RkOOzU27maCqk=;
        b=DVw1TDYtSKeyj9i7lA50Xbrj83zPuYyJBIecUSeBFqG7qtuplzEPVN6kq7cZQuZa3q
         9EGn4bic3/rO+qzr6rj/Z3Dpbo6rfAkN3vUjdJ/9h2Wo9HXWwHVTJsuwxAkEBLMuTbFB
         uW6NuSc043uAC5bL7TjMDnKolGsXJgHfKruiqfVwZfwoJPVcZuiWv5OXhQoj9F4wDQJu
         ukENZTzHvehtfC6YYxIKnsBwi7PfYF8RWBLX/qVNb7706sMf/NtJNbUs4RbQNDmdojjg
         B6E6Fo2oSOotK74RywW96y0qYwZ88M3r4L6cFv1EZCG8G/U1/BP6bROK1I2gpNVV2tGX
         jwrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731275253; x=1731880053;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TAZVrRtM224E6mv9ejk3x7Uj472YD4RkOOzU27maCqk=;
        b=sAnnFctRlnJu90c6sz0uvLNio4cmSETm2LG9NQRYNeFxmXnQdkcIPGorF/raC4dL++
         wLlpQ3mGfFAKDnf9caZp/P+ojrxCHDYsmCSsx1nklQAjTPK9tHABpNMdknVFsfSmMUst
         IeRQzQqRGUhY8yeGZ6jqb9jWd6yOdIZx20eEJ1V1c80WZKiW3Yd7kgJVOCYPeFtl9/eJ
         He3W6AoXlmQi4wWFBsjVqHYpmP2/VQM4FNJnKgMDtMOl6n+3VTYF/iIYgj5nli1LhnKs
         YMB+iNejFIL+RgEY3IM9nx1xzAFRkb+Df356UQDIfJW5kPiICFIJrZnyYfjT1XZVGL8e
         0fwQ==
X-Forwarded-Encrypted: i=1; AJvYcCWKOuMTAmWoO+sFQ8/WJ+E+3ECF+1aOZI0qXkVNXf4OcwcYWqwJuvWBeKSMiJMyEd7O8NI=@vger.kernel.org
X-Gm-Message-State: AOJu0YyIEvEpO3yDyONPZI77YZEGTx3Dwe94Hf9QSExQD0RYYrk4QL5U
	JMZmKPIQhBr4cHwZYpSAzD3VvleqqSqigr/n6swLfnvedo2lwSqD
X-Google-Smtp-Source: AGHT+IG694v6tDC10X2aK31WhGxf5xpecVsdgL5sMOAjWxTsnxcSQ4bkiUHZaEOiiNLdzS4XarZj+w==
X-Received: by 2002:a05:6000:18af:b0:37e:d6b9:a398 with SMTP id ffacd0b85a97d-381f0f58473mr10065448f8f.9.1731275252842;
        Sun, 10 Nov 2024 13:47:32 -0800 (PST)
Received: from gmail.com ([178.237.229.35])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-432b05e6042sm153267965e9.44.2024.11.10.13.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Nov 2024 13:47:32 -0800 (PST)
Message-ID: <a8f782b6-9e5b-4df2-83b7-8000eaeca8d0@gmail.com>
Date: Sun, 10 Nov 2024 22:47:31 +0100
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 19/26] builtin/branch: fix leaking sorting options
To: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
References: <cover.1730901926.git.ps@pks.im>
 <e0aa2c5bb258589bb2cac19c54fddbb70614a487.1730901926.git.ps@pks.im>
Content-Language: en-US
From: =?UTF-8?Q?Rub=C3=A9n_Justo?= <rjusto@gmail.com>
In-Reply-To: <e0aa2c5bb258589bb2cac19c54fddbb70614a487.1730901926.git.ps@pks.im>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On Wed, Nov 06, 2024 at 04:11:16PM +0100, Patrick Steinhardt wrote:
> The sorting options are leaking, but given that they are marked with
> `UNLEAK()` the leak sanitizer doesn't complain.
> 
> Fix the leak by creating a common exit path and clearing the vector such
> that we can get rid of the `UNLEAK()` annotation entirely.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  builtin/branch.c | 33 ++++++++++++++++++++++-----------
>  1 file changed, 22 insertions(+), 11 deletions(-)
> 
> diff --git a/builtin/branch.c b/builtin/branch.c
> index fd1611ebf55..05ba4cd7a64 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -722,6 +722,7 @@ int cmd_branch(int argc,
>  	static struct ref_sorting *sorting;
>  	struct string_list sorting_options = STRING_LIST_INIT_DUP;
>  	struct ref_format format = REF_FORMAT_INIT;
> +	int ret;
>  
>  	struct option options[] = {
>  		OPT_GROUP(N_("Generic options")),
> @@ -851,15 +852,15 @@ int cmd_branch(int argc,
>  	if (list)
>  		setup_auto_pager("branch", 1);
>  
> -	UNLEAK(sorting_options);
> -
>  	if (delete) {
>  		if (!argc)
>  			die(_("branch name required"));
> -		return delete_branches(argc, argv, delete > 1, filter.kind, quiet);
> +		ret = delete_branches(argc, argv, delete > 1, filter.kind, quiet);
> +		goto out;
>  	} else if (show_current) {
>  		print_current_branch_name();
> -		return 0;
> +		ret = 0;
> +		goto out;
>  	} else if (list) {
>  		/*  git branch --list also shows HEAD when it is detached */
>  		if ((filter.kind & FILTER_REFS_BRANCHES) && filter.detached)
> @@ -882,12 +883,13 @@ int cmd_branch(int argc,
>  		ref_sorting_release(sorting);
>  		ref_filter_clear(&filter);
>  		ref_format_clear(&format);
> -		return 0;
> +
> +		ret = 0;
> +		goto out;
>  	} else if (edit_description) {
>  		const char *branch_name;
>  		struct strbuf branch_ref = STRBUF_INIT;
>  		struct strbuf buf = STRBUF_INIT;
> -		int ret = 1; /* assume failure */

Now we assume failure ...

>  
>  		if (!argc) {
>  			if (filter.detached)
> @@ -901,18 +903,22 @@ int cmd_branch(int argc,
>  		}
>  
>  		strbuf_addf(&branch_ref, "refs/heads/%s", branch_name);
> -		if (!refs_ref_exists(get_main_ref_store(the_repository), branch_ref.buf))
> +		if (!refs_ref_exists(get_main_ref_store(the_repository), branch_ref.buf)) {
>  			error((!argc || branch_checked_out(branch_ref.buf))
>  			      ? _("no commit on branch '%s' yet")
>  			      : _("no branch named '%s'"),
>  			      branch_name);
> -		else if (!edit_branch_description(branch_name))
> +			ret = 1;
> +		} else if (!edit_branch_description(branch_name)) {
>  			ret = 0; /* happy */
> +		} else {
> +			ret = 1;

... here.  OK.

> +		}
>  
>  		strbuf_release(&branch_ref);
>  		strbuf_release(&buf);
>  
> -		return ret;
> +		goto out;
>  	} else if (copy || rename) {
>  		if (!argc)
>  			die(_("branch name required"));
> @@ -1000,12 +1006,17 @@ int cmd_branch(int argc,
>  			create_branches_recursively(the_repository, branch_name,
>  						    start_name, NULL, force,
>  						    reflog, quiet, track, 0);
> -			return 0;
> +			ret = 0;
> +			goto out;
>  		}
>  		create_branch(the_repository, branch_name, start_name, force, 0,
>  			      reflog, quiet, track, 0);
>  	} else
>  		usage_with_options(builtin_branch_usage, options);
>  
> -	return 0;
> +	ret = 0;
> +
> +out:
> +	string_list_clear(&sorting_options, 0);
> +	return ret;
>  }
> -- 
> 2.47.0.229.g8f8d6eee53.dirty
> 
