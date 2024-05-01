Received: from mail-pf1-f171.google.com (mail-pf1-f171.google.com [209.85.210.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF2251C68D
	for <git@vger.kernel.org>; Wed,  1 May 2024 22:18:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714601918; cv=none; b=nRaaMCor4CkXao2CBv2aGSmvmStaP6hNoIcLZnfhQPXJdTxcTeGLHTFKEr+ZWLXWECyRmtX26OxOkxSkhnvatc8AXU2UtCOaNl2MwJ2ZOIp7JZnB/B1uEjl+Bh0t8npy7ahrTSornBEbYZCJlB7g4loLXRMEwVYWlPUnMaEqEnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714601918; c=relaxed/simple;
	bh=NLyD9597isqEgZO7mr2AMcfy3iC8gUmmApqKV+wh2LE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HD4HZebDpm6rZWpXbOirT+rLxf+5/7jgkWIZNIwsFdBtVcf5cxbOzm+/a5/mC3AfKqutkVtMejtDNMXKi3vzSeER3sMr/gsBQitoiQh047L4VIbfeLnPUr/GGcdwY+U1e3IhABsZ609Rdg5X5ExRXBHrucj2f/f10ixMyPJG3ww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ltOayHTR; arc=none smtp.client-ip=209.85.210.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ltOayHTR"
Received: by mail-pf1-f171.google.com with SMTP id d2e1a72fcca58-6ed5109d924so6204292b3a.0
        for <git@vger.kernel.org>; Wed, 01 May 2024 15:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1714601916; x=1715206716; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=KEaX4Zo8PgVbXL7iWBJfHTdOjYaRdRPiIbbpyYAbCDU=;
        b=ltOayHTRUvGMgA5IbEiqQbFt6iqp0/YRB06q4AFLSH/0PIg29eVF9AwDQXHz0D2sHU
         dDv/pB2+IAGD4CTrmGX0V/xomy+EsUh6mSS9GOeLtMfZCrE5fstWQ24VYPJkNTu4JeMC
         HoV0awMznI4EIBEegDEb0vYYS/NlbuXRfBL3hEGAx3E774XsEL2bLU0iv9h0rYwK/532
         SKy7OSwBK/6zlUxjQ8gIwGeSGqWL6kmrGUGNp0AW0nsR+QpYwgzhdT/OEa+trAfK2ZeH
         GFKptSd3DY9fym8sF15K/PkLhnvFRDRLx3xQwm47agYJuSkqtomq63n+hbcYehH4oUO8
         DVTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714601916; x=1715206716;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=KEaX4Zo8PgVbXL7iWBJfHTdOjYaRdRPiIbbpyYAbCDU=;
        b=mX6qQ859CdEcUkyxJ+4XzlceHDysIRxmO/XqA6SCAJ9A+iGMhlobHGahb2lJ5t0+i1
         YfnYq7NW367p9eYFWH7t5aAxRfyEvafCc/lYibdvikpNIPx4Tt6CRjs1EGba4/ULrPs8
         ZkYGHWQcLkOmrngbLDsGKNqV5PQ4eGfzAAXLbQCc+Jo3Jmf2G7eS5fkZ7m6ZMnHLiGdc
         DLbO5PatgY+9J651g2z1JytqdjxruWNmhqAZ33zQMVGWIx6paHzPY1Xr54WeQD6uboIu
         IsvtBM64aFKJTHJl+05secqbBKf1/k0XddjTkqTkFzLDTke9FElWEKFJYSMvA6vK5bUa
         HCmg==
X-Gm-Message-State: AOJu0YxCGpMrSnzwaOcwrthokDi7siA9TaKcf3Y/XjXZ21kg5MIQ2sjm
	6QlDST9LKMN90RW2yaGNBxtNIXdwe8SxDODnyBSDFOrCnoAH8cSt
X-Google-Smtp-Source: AGHT+IF1g667XrPKoI2ToFWN04+EEPIYlebsUgv8PG7lt+gmbdJcqye/zgjmGIxBEsolXSsziQBTpg==
X-Received: by 2002:a05:6a00:4b05:b0:6ed:9493:bc6d with SMTP id kq5-20020a056a004b0500b006ed9493bc6dmr5114053pfb.12.1714601915951;
        Wed, 01 May 2024 15:18:35 -0700 (PDT)
Received: from localhost ([2402:a00:401:a99b:f188:2dd3:d960:a8ab])
        by smtp.gmail.com with ESMTPSA id ka1-20020a056a00938100b006ecfb733248sm23784096pfb.13.2024.05.01.15.18.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 May 2024 15:18:35 -0700 (PDT)
Date: Thu, 2 May 2024 03:48:33 +0530
From: Ghanshyam Thakkar <shyamthakkar001@gmail.com>
To: Matheus Afonso Martins Moreira via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Matheus Moreira <matheus.a.m.moreira@gmail.com>, 
	Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
Subject: Re: [PATCH 02/13] urlmatch: define url_parse function
Message-ID: <rt77kwzaia3w52o3hoeodjilk5gkh6dz5dip6wmn5hia55gp2r@5fznbu2ljdqy>
References: <pull.1715.git.git.1714343461.gitgitgadget@gmail.com>
 <13b81b8aa06cfd63a5fd9d1acbaf21a8b388ff47.1714343461.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <13b81b8aa06cfd63a5fd9d1acbaf21a8b388ff47.1714343461.git.gitgitgadget@gmail.com>

On Sun, 28 Apr 2024, Matheus Afonso Martins Moreira via GitGitGadget <gitgitgadget@gmail.com> wrote:
> From: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
> 
> Define general parsing function that supports all Git URLs
> including scp style URLs such as hostname:~user/repo.
> Has the same interface as the URL normalization function
> and uses the same data structures, facilitating its use.
> It's adapted from the algorithm used to process URLs in connect.c,
> so it should support the same inputs.
> 
> Signed-off-by: Matheus Afonso Martins Moreira <matheus@matheusmoreira.com>
> ---
>  urlmatch.c | 90 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  urlmatch.h |  1 +
>  2 files changed, 91 insertions(+)
> 
> diff --git a/urlmatch.c b/urlmatch.c
> index 1d0254abacb..5a442e31fa2 100644
> --- a/urlmatch.c
> +++ b/urlmatch.c
> @@ -3,6 +3,7 @@
>  #include "hex-ll.h"
>  #include "strbuf.h"
>  #include "urlmatch.h"
> +#include "url.h"
>  
>  #define URL_ALPHA "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
>  #define URL_DIGIT "0123456789"
> @@ -438,6 +439,95 @@ char *url_normalize(const char *url, struct url_info *out_info)
>  	return url_normalize_1(url, out_info, 0);
>  }
>  
> +enum protocol {
> +	PROTO_UNKNOWN = 0,
> +	PROTO_LOCAL,
> +	PROTO_FILE,
> +	PROTO_SSH,
> +	PROTO_GIT,
> +};
> +
> +static enum protocol url_get_protocol(const char *name, size_t n)
> +{
> +	if (!strncmp(name, "ssh", n))
> +		return PROTO_SSH;
> +	if (!strncmp(name, "git", n))
> +		return PROTO_GIT;
> +	if (!strncmp(name, "git+ssh", n)) /* deprecated - do not use */
> +		return PROTO_SSH;
> +	if (!strncmp(name, "ssh+git", n)) /* deprecated - do not use */
> +		return PROTO_SSH;
> +	if (!strncmp(name, "file", n))
> +		return PROTO_FILE;
> +	return PROTO_UNKNOWN;
> +}
> +
> +char *url_parse(const char *url_orig, struct url_info *out_info)
> +{
> +	struct strbuf url;
> +	char *host, *separator;
> +	char *detached, *normalized;
> +	enum protocol protocol = PROTO_LOCAL;
> +	struct url_info local_info;
> +	struct url_info *info = out_info? out_info : &local_info;
> +	bool scp_syntax = false;
> +
> +	if (is_url(url_orig)) {
> +		url_orig = url_decode(url_orig);
> +	} else {
> +		url_orig = xstrdup(url_orig);
> +	}
> +
> +	strbuf_init(&url, strlen(url_orig) + sizeof("ssh://"));
> +	strbuf_addstr(&url, url_orig);
> +
> +	host = strstr(url.buf, "://");
> +	if (host) {
> +		protocol = url_get_protocol(url.buf, host - url.buf);
> +		host += 3;
> +	} else {
> +		if (!url_is_local_not_ssh(url.buf)) {
> +			scp_syntax = true;
> +			protocol = PROTO_SSH;
> +			strbuf_insertstr(&url, 0, "ssh://");
> +			host = url.buf + 6;
> +		}
> +	}
Interesting. 

    `
    $ ./git url-parse -c protocol file:/test/test
    ssh
    `

seems like only having a single slash after the 'protocol:' prints
'ssh' always (I think this may not even be a valid url). After this 'else'
block, the url turns into 'ssh://file/test/test'. Will examine the details
later. Not that it's your code's doing, and rather the result of
url_is_local_not_ssh(). But just wanted to point this out and ask if this
should error out or is this an intended behavior that I can't figure out. 

Thanks.
