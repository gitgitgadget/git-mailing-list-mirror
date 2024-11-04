Received: from mail-oi1-f171.google.com (mail-oi1-f171.google.com [209.85.167.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0941D319B
	for <git@vger.kernel.org>; Mon,  4 Nov 2024 22:27:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730759239; cv=none; b=e3EaUzlP5KNxZnoZHJ72exGKeERiBgNlqVqdWqGiUdCmAwM51G2h+SIh6YXDqA46cBETVanwXGNIwfpYcvYna+BES5/wviNjgjbkVHDkDm7mCm8674f3fdPngO4k6fW3YJrd3LUoxZTEVZlhAV5EaUbZyDfQ8tn9dUMOseDDpHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730759239; c=relaxed/simple;
	bh=RYPTpX4C9tqdQl1a1Nj+d4FYPgGqiear5DbQtWxcjU0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=qbgtuVG4SZtU6EqTkbzFTCuMuQCFiDqUzXhrUsHj8QKtyd+KjOPqh/clMQ1rjVWR+6vmxS7QcX4i5jOOj3ZiLByQVLiPmZ5Nt7OWetgGurLJyMrpG8H7Q7niW1193c9UsC3X31OrJOSzFLN8CCaMo1OHbFtN3ZRFYWF0zSMgDjM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nNbXsCIq; arc=none smtp.client-ip=209.85.167.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nNbXsCIq"
Received: by mail-oi1-f171.google.com with SMTP id 5614622812f47-3e5f835c024so2647257b6e.2
        for <git@vger.kernel.org>; Mon, 04 Nov 2024 14:27:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1730759237; x=1731364037; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=6Ut32S9XWJxx9y+K8mytnMZWrYplVEOILGEMMAxD2Kc=;
        b=nNbXsCIqEOM4LLf57CVOBzJ35x3V5E6OByXsUADqdl8IGb64JlE5vg4mFymBrLoSQm
         vEeUF4/fByk9ccsXRzpFYUgUkDXCKj1PzN9Mv/DKqGN48ZhBzPnh3pIl2j5DZzEYkQ3/
         cjviSdVy5THY5GX4qxVwNL4kkYXX5kTp8/b0V03WFHEckj53dsIpMN3KXHHFo5M1pU8h
         Go63YO579N06yssdXUYgRceIs1B3BATG1LJtDB1aGp89cCbC1X921G/NCGnu/6MB1HOw
         QVOXkaQ3pFGmz6NRDQz5crh0uZBQJEVztmmPzcr7aZn8k8zjzLKTcCo5CwXEetHta+YW
         JrNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730759237; x=1731364037;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6Ut32S9XWJxx9y+K8mytnMZWrYplVEOILGEMMAxD2Kc=;
        b=idRGuNAQZmyPnkuOscKCbMoz5d8vA2MwBctYvylmLtgJnHXZ6hHzd493eLwQThSEwZ
         WjTTUsaECi+mH9QhHJww4BdNQ6WIGBuS1MNl1pAz3RbVAraYbArxeWfsYyKu33Q2LD88
         51/jdCG/qPk0990aW+27TZpEnTPhsC2GnON9Vx8TcXCt0dyd2MASBrSa3GwqswzzDOeX
         OzzA7MtCg5CSJjblhw9+OBA4DLs6GIiJb93EFGqMBSaCzNRBgYCvC5Wje4m57NOJd4q/
         CloCdhp1aPZcmtwLCpR8I/twGDMnSEQvpseoZ25RvHQKev6EXnXRO9UQDZQHKnvUK0yU
         4JRQ==
X-Gm-Message-State: AOJu0YzV2ctCDmndumehkZUPpwb6YgZ3a1x0waxhyROM1ULf5tnmDxWO
	1W4udIslt4WDeZNyzI5b7wNZgRRXuppaoW3vh/r7zc3aJfGYPPq1
X-Google-Smtp-Source: AGHT+IEI33fcEGN01xJZgU9qOhlqMLxSmPvUyI4PJLXqIDuC+9+b5GDALITjBsk4e//ujbkU4sSJDQ==
X-Received: by 2002:a05:6808:23cd:b0:3e6:37f7:5a2c with SMTP id 5614622812f47-3e638460b98mr30317879b6e.12.1730759236695;
        Mon, 04 Nov 2024 14:27:16 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 586e51a60fabf-29487429433sm3247156fac.6.2024.11.04.14.27.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Nov 2024 14:27:16 -0800 (PST)
Date: Mon, 4 Nov 2024 16:25:38 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>, 
	Toon Claes <toon@iotcl.com>
Subject: Re: [PATCH v2 10/22] trailer: fix leaking trailer values
Message-ID: <wh227vmiokssq532pqfefzxlbt6ylonwza3sxumgohpwuojxbv@k2ujsz5upvop>
References: <cover.1728624670.git.ps@pks.im>
 <cover.1729502823.git.ps@pks.im>
 <e3ffd59123f23f53c0bee930ef7602acf2d800c2.1729502824.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e3ffd59123f23f53c0bee930ef7602acf2d800c2.1729502824.git.ps@pks.im>

On 24/10/21 11:28AM, Patrick Steinhardt wrote:
> Fix leaking trailer values when replacing the value with a command or
> when the token value is empty.
> 
> This leak is exposed by t7513, but plugging it does not make the whole
> test suite pass.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  trailer.c | 12 +++++++++---
>  1 file changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/trailer.c b/trailer.c
> index 682d74505bf..f1eca6d5d15 100644
> --- a/trailer.c
> +++ b/trailer.c
> @@ -249,17 +249,23 @@ static char *apply_command(struct conf_info *conf, const char *arg)
>  static void apply_item_command(struct trailer_item *in_tok, struct arg_item *arg_tok)
>  {
>  	if (arg_tok->conf.command || arg_tok->conf.cmd) {
> -		const char *arg;
> +		char *value_to_free = NULL;
> +		char *arg;
> +
>  		if (arg_tok->value && arg_tok->value[0]) {
> -			arg = arg_tok->value;
> +			arg = (char *)arg_tok->value;

Naive question, is this cast not redundant? From looking at `struct
arg_item`, `value` already looks to be this type.

>  		} else {
>  			if (in_tok && in_tok->value)
>  				arg = xstrdup(in_tok->value);
>  			else
>  				arg = xstrdup("");
> +			value_to_free = arg_tok->value;
>  		}
> +
>  		arg_tok->value = apply_command(&arg_tok->conf, arg);
> -		free((char *)arg);
> +
> +		free(value_to_free);
> +		free(arg);
>  	}
>  }
>  
> -- 
> 2.47.0.72.gef8ce8f3d4.dirty
> 
> 
