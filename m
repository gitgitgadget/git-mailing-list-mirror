Received: from mail-ot1-f42.google.com (mail-ot1-f42.google.com [209.85.210.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4047224CC
	for <git@vger.kernel.org>; Wed, 11 Sep 2024 16:22:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726071769; cv=none; b=ctdDTSLARXu0Xp3J/jComg7zzgHbvLWfvEHpUTk32QLg/RaFjiimh1xq2R1e+l9wMz063ESW5McUJdLgEuVwh1WrUg8NZq3RMIXrSc8DAj8ObHppJdKR1Jb1T4jAfX9ws+MiGjXz7eGYWgQoNdA05WyvrCYE2V68XaFbTBfjx/0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726071769; c=relaxed/simple;
	bh=4F33lt0svyt2Ej26T7kNvvUy6OTUk3uVfQP8CTvwwPQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=L4hw8+seAIF1WQBnd4qHOPTnZB/P3psgVuCoY9WqKxL4pjh6GFxqI8preXsFPaffH7lJDgVLZiEAolK/kE3w5hrnDeRz77uNgmlVdm6f51gsU6gycKj7dZdSqNal4wXD4fvzmzIvSXgmrUkU5T0/Y8sdlLpXkpc70HCw5q0sbHo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=afGT3Uvr; arc=none smtp.client-ip=209.85.210.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="afGT3Uvr"
Received: by mail-ot1-f42.google.com with SMTP id 46e09a7af769-7094641d4e6so3116689a34.3
        for <git@vger.kernel.org>; Wed, 11 Sep 2024 09:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1726071767; x=1726676567; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=R4HY3sTulYqr4lie+hdNLvPRlAvNhR8G4GEE0xMblAc=;
        b=afGT3UvrOiCPUQR1gFIM2uDgYBgFDTcbpHtnWS/bCwcglUmnxSMy4+J3nFWm4mC9Ma
         M3WkN1gzpHj8hOk7dIJ3CGSeve3METuUZNoyg4YzltbNo5eltogQwLxn4Hmk6jEikPcB
         +ov+oEXcS/WFA16/BXLSEQCNAdxQoRroEi9RkTXqc7/tq/hX3GZfm3z6IrJ5paWzu/Vs
         vPiM/KIdWIkbb0aqqsIhStrE46Gef3z9UIVHLundQ2JUVfVnlP4lEPK4dR7afzedK6KM
         JV8pOEzWtZRftQgUH59rsFHas7+CV3IzbTpvYZDhXsmMyaIoOREFpWePKNPUJn5X69/k
         6cNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1726071767; x=1726676567;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=R4HY3sTulYqr4lie+hdNLvPRlAvNhR8G4GEE0xMblAc=;
        b=N5Z7mPIlkHuSkvNSnRp+70W0PBqauEjAWqVyI1HR14hVDSYP+9qZIoarR82CuYiqEc
         Pv+HLcbPztEKbjziZ+4KGlDgwB/WRFw1rDYiGUEKdHfDpNiwwilv+k5fVHwNRL7XTEfz
         s8RxJECRejEf41G54nDSon+97gbfEpCfJK+ZSCagr2dP1UoYaRXJNcbUp9XELC4JUgWg
         ldcMylmJzJrKdC3kgZM5f0f+t2CbLCCSlYr3pbjj/5pVVewn9+RDgu/wk5h2yXi6Hlo8
         e777XVXqWi15ik15kBILP0BKq7s0X8JRyJ4O6gXtOfdNZv7fQwVmgWFMI1p0gE6FA9Ap
         24bQ==
X-Gm-Message-State: AOJu0YysxPXvm4jdp0B1mGcwt8TWSbkcQHw97/j02BdkRc0VohT3lZgW
	INldQP/pe7o0WCFyhFHph8uSvg3a9UZ8kBENrDOcYJuw21UnUjyG
X-Google-Smtp-Source: AGHT+IFC+QQH4hj/WcL0DVaAXh1ZFM2KEnlnJ5dkESm4ywdLIFQ5aAEnaENYkBWubBVAgBZ17w6Emg==
X-Received: by 2002:a05:6830:7199:b0:710:f1cd:b237 with SMTP id 46e09a7af769-7110956c589mr85485a34.20.1726071766851;
        Wed, 11 Sep 2024 09:22:46 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 46e09a7af769-710d9dd6ffbsm2368495a34.72.2024.09.11.09.22.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Sep 2024 09:22:46 -0700 (PDT)
Date: Wed, 11 Sep 2024 11:21:32 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Calvin Wan <calvinwan@google.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 10/21] environment: make `get_git_namespace()`
 self-contained
Message-ID: <otvkxgywps6smoib32x4gqiwc4klbjl6qbh66bh6wwwfvb2b2p@22gqczmx3p3e>
References: <cover.1724923648.git.ps@pks.im>
 <cover.1725008897.git.ps@pks.im>
 <f0d3794dfc44cd4393fd79fab9f60b73cf33db89.1725008898.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f0d3794dfc44cd4393fd79fab9f60b73cf33db89.1725008898.git.ps@pks.im>

On 24/08/30 11:09AM, Patrick Steinhardt wrote:
> The logic to set up and retrieve `git_namespace` is distributed across
> different functions which communicate with each other via a global
> environment variable. This is rather pointless though, as the value is
> always derived from an environment variable, and this environment
> variable does not change after we have parsed global options.
> 
> Convert the function to be fully self-contained such that it lazily
> populates once called.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
[snip]
> @@ -229,9 +204,35 @@ int have_git_dir(void)
>  
>  const char *get_git_namespace(void)
>  {
> -	if (!git_namespace)
> -		BUG("git environment hasn't been setup");
> -	return git_namespace;
> +	static const char *namespace;
> +
> +	struct strbuf buf = STRBUF_INIT;
> +	struct strbuf **components, **c;
> +	const char *raw_namespace;
> +
> +	if (namespace)
> +		return namespace;

We only initialize `namespace` once and do it lazily when
`get_git_namespace()` is invoked for the first time. This is nice
because we can simplify and remove the `git_namespace` global.

Makes sense to me.

> +
> +	raw_namespace = getenv(GIT_NAMESPACE_ENVIRONMENT);
> +	if (!raw_namespace || !*raw_namespace) {
> +		namespace = "";
> +		return namespace;
> +	}
> +
> +	strbuf_addstr(&buf, raw_namespace);
> +	components = strbuf_split(&buf, '/');
> +	strbuf_reset(&buf);
> +	for (c = components; *c; c++)
> +		if (strcmp((*c)->buf, "/") != 0)
> +			strbuf_addf(&buf, "refs/namespaces/%s", (*c)->buf);
> +	strbuf_list_free(components);
> +	if (check_refname_format(buf.buf, 0))
> +		die(_("bad git namespace path \"%s\""), raw_namespace);
> +	strbuf_addch(&buf, '/');
> +
> +	namespace = strbuf_detach(&buf, NULL);
> +
> +	return namespace;
>  }
>  
>  const char *strip_namespace(const char *namespaced_ref)
> -- 
> 2.46.0.421.g159f2d50e7.dirty
> 
