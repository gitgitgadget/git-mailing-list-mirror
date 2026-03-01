Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C49E8430B89
	for <git@vger.kernel.org>; Sun,  1 Mar 2026 04:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772339048; cv=none; b=LmWS/bx1vY2W7qTyXpVVsGiLmSTughyiY0f5FreiBxU4WswIjxI/iSoiQk6Mj9TVHRl48ek89nO2RlJMtooIyJH2bVztAGxlzlfiiMSvBby0qYhQ2/J12VPJVIuuHMa2ta26yHcG0mGJcBY3AHUM0HewvfBzkNDocxbgT2bYH4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772339048; c=relaxed/simple;
	bh=iecg1svGmARuh1jq8+nfxAj/3wFCiyoRN2ZPNvM0q2A=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=YdzdyeWKg8YkjedaZLZB+NQSlnpazqxxIhTbma1Sdn1PUdCkzP5b2pfIL/O0uPxmoPm1aCHiW2BG5yrwnuq1e49/vqYi2BzyajNzY8VBEI9nHX3vHl5ywmgzltz+iH/moFHwy41wIvN3//Mav2JhAgvYxyo5xqrtlRRLzt/U/Ak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=EV/SVpBi; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EV/SVpBi"
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-3598661fe57so54076a91.1
        for <git@vger.kernel.org>; Sat, 28 Feb 2026 20:24:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1772339046; x=1772943846; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=rM/ZCuEhdKlLsp00Ess8imr2dQGvrU4OKJLrwYlo1LE=;
        b=EV/SVpBiQ+NIRPkyswPoWkdoAwnuUMBJipOWpagUsi2E+k2gsJhqpHNeXdKAhgSF5a
         /eS+qM/X0u+svzvsUmHPPpscv/1xwL429TtLqgVbc8Bi7PnGj61EAXuj7EvAjn5sBLhs
         YvijD25Lp66U6TJ6pTP9VmgTfxZ5DG2cgvspUqpQvqKG4n5EhVfWMRlYXiIIFljt7p1/
         pSViBmEiW15R+Z0oSR3RPC6PPYnFoiSHkjcvyuoR92veeKa1e66R+rY4dJxfMkGYOy0J
         vBf6TpWnOWp4VqL2d1vGeH9XLJkA74a/kepK7htQigBl0KTlNzrKilFj2XhnNFoLczqI
         4Tcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1772339046; x=1772943846;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rM/ZCuEhdKlLsp00Ess8imr2dQGvrU4OKJLrwYlo1LE=;
        b=nAEsMSa05MdZuGGI64hv5LC024JKOSoE371nmwKjJh+MNLGWmhvZwuirVXrOMsX9TR
         +cpXbAxm4R357lo5VlDuQHsZsAUQONdFmCNRW3KzrUPEZ131qcr9ZJXm0WTJ52Z5tmqM
         Yc7z9ZQprILOXk7wkB/tLP2X87X3NMPTSEsHip+C/iBJ5Ixcs+20F814tzhCtLHqArkY
         iu3GVhiuO4hbQBM2P+lD1tVGRxwJ7JdzfK9JAX+/8WRHUjp+3S0ukwftBooHqp2Z6sim
         OYQhrDT8dphYvVZL8o3wIIfAh1NWClHBdh1Pjo4gAGjVwvuJd5MWCgD4l5NumVMuqaaK
         zXIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWavjsFkmhj5M/tFeNTOjQnPn6AnF65KNYT2jmBQt0pYqKhcI5+7qeYg3CDwGNpL6d/pOA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxLWQ2ByHfNAblutqPrpum5FdxVPcLvppJwte/DzmFNpqLQz5tR
	1LvuJi5TC19shZumHTVRCyqkLCvvdIG+f7RKfE+crnHL4KLkgpahKIyG
X-Gm-Gg: ATEYQzzJ+8sgQKAhpxbUuBVWAWV+uvAz7zzTLq7aIR/CRe8wd3fAVKZ+Abk6vlLS/DJ
	1kRWebTTLaTinfcP8shLg1ZE2uLv3LqkQPdBYSJc6+IKi5R+pUa2sfHomZ+UoDsncPCDqeQcSCn
	x2HBT+Dv+ppf1FFs/KIrD3DXKNPgpDazN1m+kLFH7XDCKyydrWU9dPDSoqT+rKXbLbikCkSs7YW
	ipVZVAJwx5BRVKBDYbR/axfUy6yjQNxJOoDdivl4FJxNpC0Y1DN8dKFlxbisG6Amojpe7U85gBS
	WSJtu7A0C6j2K7z+8Gnq9m1TLjHWKko9AsKpS2rSmeqvx6Fx0/9ilrenU9HMbtMM0yPq9p1XHej
	AwSc/fMMFLLllOLI54rvCjUxq7hmm1353aD4Ua3TdRD1DoTALp1xHcDv8620TdnhHsB655gbPnQ
	6HwbWdfObwRZ3fMgvxNu6ScPPmnzjhr55XNAMmlYKWpsCF7FHX56X8PjNrnVaJfNg8ZY37GNsoP
	KCFOIQsu8A=
X-Received: by 2002:a17:902:da92:b0:2a7:b447:338d with SMTP id d9443c01a7336-2ae2e50409amr61844615ad.8.1772339046018;
        Sat, 28 Feb 2026 20:24:06 -0800 (PST)
Received: from [192.168.0.109] ([155.69.180.3])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2adfb6a041asm102962985ad.57.2026.02.28.20.24.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 28 Feb 2026 20:24:05 -0800 (PST)
Message-ID: <71e42a01-6077-48fc-876e-555431d1288f@gmail.com>
Date: Sun, 1 Mar 2026 12:24:01 +0800
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 4/4] repo: add the field path.toplevel
To: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>, git@vger.kernel.org
Cc: sandals@crustytoothpaste.net, kumarayushjha123@gmail.com,
 jayatheerthkulkarni2005@gmail.com, valusoutrik@gmail.com,
 pushkarkumarsingh1970@gmail.com
References: <20260228224252.72788-1-lucasseikioshiro@gmail.com>
 <20260228224252.72788-5-lucasseikioshiro@gmail.com>
Content-Language: en-US
From: Tian Yuchen <a3205153416@gmail.com>
In-Reply-To: <20260228224252.72788-5-lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

Hi Lucas,

 > I'm CC'ing here:
 >
 > - brian, who was the original author of the `print_path` [1]
 > - Ayush, Tian, Jayatheerth, Soutrik and Pushkar, since they expressed 
 >   interested in contributing to git-repo-info in GSoC. (I hope that I
 >   didn't forget anyone)

Thank you for your thoughtful consideration!

 > 1. Add --path-format, just like we have in git-rev-parse
 > 2. Use what rev-parse uses by default
 > 3. Add keys for both relative and absolute formats

It makes me wonder if we can use Format Modifiers as in ref-filter.c...

	https://git-scm.com/docs/git-for-each-ref

...which allow us to control the output precisely. For example:

	%(path:relative)
	%(path:absolute)
	%(path:short)
	%(path:strip=2)...

Just a thought.

 > There are two enums used in rev-parse for deciding how paths will
 > be printed by the function `print_path`: `format_type` and
 > `default_type`. Even though there aren't any ambiguities yet, their
 > names aren't clear that those "types" are path types.

This one makes sense to me. Also reduce naming conflicts.

 > +void strbuf_add_path(struct strbuf *sb, const char *path, const char 
 > *prefix, enum path_format_type format, enum path_default_type def)

Isn't it a bit inappropriate for a generic character concatenation 
function to know about format and def? I don't think this should be the 
responsibility of a low-level function, at least not str_buf_add_path().

All functions starting with strbuf_add.. listed by git grep strbuf_add 
are mostly pure string concatenation operations. I believe this should 
be the case here as well.

 > +	if (!prefix && (format != PATH_FORMAT_DEFAULT || def != 
PATH_DEFAULT_RELATIVE_IF_SHARED))
 > +		prefix = cwd = xgetcwd();

I think the logic here shouldn't be tied to 
PATH_DEFAULT_RELATIVE_IF_SHARED, I believe the attribution here is the 
same as above.

 > +		prefix = cwd = xgetcwd()

Will there be a performance regression? Since xgetcwd() here is a system 
call, right? If prefix == NULL and the get repo info command is used to 
locate the top-level path among a large number of submodules, and this 
command will be executed multiple times.

In my opinion, upper-level commands should call xgetcwd() only once 
before entering the loop, then pass the obtained prefix as an argument 
to the underlying implementation.

> -typedef int get_value_fn(struct repository *repo, struct strbuf *buf);
> +typedef int get_value_fn(struct repository *repo, struct strbuf *buf,
> +			 const char *prefix, enum path_format_type format);
>  
>  enum output_format {
>  	FORMAT_TABLE,
> @@ -35,26 +36,46 @@ struct repo_info_field {
>  	get_value_fn *get_value;
>  };
>  
> -static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf)
> +static int get_layout_bare(struct repository *repo UNUSED, struct strbuf *buf,
> +			   const char *prefix UNUSED,
> +			   enum path_format_type format UNUSED)
>  {
>  	strbuf_addstr(buf, is_bare_repository() ? "true" : "false");
>  	return 0;
>  }
>  
> -static int get_layout_shallow(struct repository *repo, struct strbuf *buf)
> +static int get_layout_shallow(struct repository *repo, struct strbuf *buf,
> +			      const char *prefix UNUSED,
> +			      enum path_format_type format UNUSED)
>  {
>  	strbuf_addstr(buf,
>  		      is_repository_shallow(repo) ? "true" : "false");
>  	return 0;
>  }
>  
> -static int get_object_format(struct repository *repo, struct strbuf *buf)
> +static int get_object_format(struct repository *repo, struct strbuf *buf,
> +			     const char *prefix UNUSED,
> +			     enum path_format_type format UNUSED)
>  {
>  	strbuf_addstr(buf, repo->hash_algo->name);
>  	return 0;
>  }
>  
> -static int get_references_format(struct repository *repo, struct strbuf *buf)
> +static int get_path_toplevel(struct repository *repo, struct strbuf *buf,
> +			     const char *prefix, enum path_format_type format)
> +{
> +	const char *work_tree = repo_get_work_tree(repo);
> +	if (work_tree)
> +		strbuf_add_path(buf, work_tree, prefix, format,
> +				PATH_DEFAULT_UNMODIFIED);
> +	else
> +		return error(_("this operation must be run in a work tree"));
> +	return 0;
> +}
> +
> +static int get_references_format(struct repository *repo, struct strbuf *buf,
> +				 const char *prefix UNUSED,
> +

I don't think we should add the two new parameters to all get_ functions 
here. As changed in your patch, functions like get_object_format don't 
really, need to know about prefix or format, so the corresponding 
parameters are marked as UNUSED. Imagine if more and more data needs to 
be retrieved by these get_ series functions in the future — is it really 
advisable to add unnecessary parameters to all remaining functions just 
for the sake of a few?

I'm not entirely sure about the above content either; I'm just throwing 
out ideas to spark discussion. (´～`)

Thanks again for starting this discussion!

Regards,

Yuchen


