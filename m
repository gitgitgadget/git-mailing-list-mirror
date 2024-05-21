Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 234C3148822
	for <git@vger.kernel.org>; Tue, 21 May 2024 23:35:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716334517; cv=none; b=CuF3wofY5YeU1tTd+WJWFFk8CLNqkUNwrB/mO1P+PX+miMJ+k8moCk2tlyeqz6kfQYGeM/48vw/TVz6kTq5FMc5OAi2VTAU5rbIUNGyNWLYwF1/lzBgfoSX3uH2d5BFNHfIoE3UvNdFcQPqje1Oy3hobzumN5/Lz8wk+9O0AvO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716334517; c=relaxed/simple;
	bh=e1YyNcmadFDNjVDPKquGP5bOOXOmwjvNOL1ZLlQGbfU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=E5gXfth+0FIeolhBg0yb1x7anG4dwfZ5EOz9IRb7Zim3F/CGFRYSMjbMr5jTA849CYwXQrQBLH2kgtUxcTYomAebQm6OdQ1dLlqpvlEFjTqN/hw1rceAwlzYmicb7c2qwqbwHNOPga5A2wauucaBtt/ySgb80B8dxq7Jgc+EL7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YsGWf2te; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YsGWf2te"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-5b2761611e8so2988227eaf.2
        for <git@vger.kernel.org>; Tue, 21 May 2024 16:35:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1716334515; x=1716939315; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VSBluRpcE0UgJcDKLuxJao5gZG8Kn/xwpWjufdMSWxo=;
        b=YsGWf2tezQhPxjZxmoGq5rLzMp9Tj1f1tZDa/BzsM+4F+dmZy7QM8HY7tFk+sLST4i
         cUKbI5MTpJn4D+zAspm07eEsYK4wcrfqRcdkRaTPXaf3zDsQBSFHwBLx3S+qP6fGhR8X
         HDI8LclN+rMtTn+mesaq/7+BabxRJt/dWoPmtilzh8K7AUP7Ma0TZ6Q4hgAPvkFHOsJ3
         yOCUIM0oCom2Kdgqx8l4lKwaDzqyxV0+EvaesYdZ9qznmCshrYNtTYgxtkCSLLGUgBmr
         +gBg4L4oWxzJKo/kIyXUd5aPKUvT+KKKVKFsSTO46bwu34mZ0vMMTOiN2rW7CcKpDjHC
         aUjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716334515; x=1716939315;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VSBluRpcE0UgJcDKLuxJao5gZG8Kn/xwpWjufdMSWxo=;
        b=HSIpkFEutHW4ZYMHj8MEiCmjnhlKKzKg7vHVBhZtEceOrFVieuVSH2AvMm5nlJ/O8I
         0xQjE9WWY6i4a2T9W4dfQaMsXheS1pq8+ivsms1ACAwtoIfyGxKQp3xySXt3fPZro2kf
         hdSw23lYh5r1pLyR8HMT/i5njXKU6YTZa40q0qAPPWMEVGiiK7eXfFtpmYDh1/0JFSiQ
         JXcXQSq+OwabOIYLiu5WJpGY59OmRxjA0ZxiERv2VrPwJaBnO5Zm6ixALSdh7dw063rw
         P87tx2nttHaiKQ4b/vzlVXqT9MLv2sqlkFRZzpalwNpCucgbBlnDmHKY+1Fz5uADKrq0
         H5eA==
X-Gm-Message-State: AOJu0Yw+wKWlT5pCTbFw8xeZFRRfnkvRBGv1BuoQUQ+Xn33QPTvtZsbw
	cWTkf3kW4vVndAmOpHX4rflgUArzJkLUU1y0wQ6epG3VZ/eaNpaY
X-Google-Smtp-Source: AGHT+IGpRx3Uuo5/KJ4L2tVVyhthJG1F5wQ3wueEtO5Skbkrrb6kdpCA0q5bvEvyneQ8Sg1ERUZzfg==
X-Received: by 2002:a05:6820:502:b0:5b5:3d56:287b with SMTP id 006d021491bc7-5b6a2ff20dcmr616056eaf.4.1716334515039;
        Tue, 21 May 2024 16:35:15 -0700 (PDT)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-5b27521351dsm5665258eaf.10.2024.05.21.16.35.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 May 2024 16:35:14 -0700 (PDT)
Date: Tue, 21 May 2024 18:35:13 -0500
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>, 
	Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 05/11] reftable/dump: support dumping a table's block
 structure
Message-ID: <t7vrnm4kgyu5kl6evrfm6pvhwffwi5tku45tjds7mz7rpip2hz@77zv3givo7pp>
References: <cover.1714630191.git.ps@pks.im>
 <cover.1715587849.git.ps@pks.im>
 <c4377180ef9c92a28fa71b1cde90d80d901c8710.1715587849.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c4377180ef9c92a28fa71b1cde90d80d901c8710.1715587849.git.ps@pks.im>

On 24/05/13 10:18AM, Patrick Steinhardt wrote:
> +int reftable_reader_print_blocks(const char *tablename)
> +{
> +	struct {
> +		const char *name;
> +		int type;
> +	} sections[] = {
> +		{
> +			.name = "ref",
> +			.type = BLOCK_TYPE_REF,
> +		},
> +		{
> +			.name = "obj",
> +			.type = BLOCK_TYPE_OBJ,
> +		},
> +		{
> +			.name = "log",
> +			.type = BLOCK_TYPE_LOG,
> +		},
> +	};

I noticed that we are not including all the block types. Would we ever
want to also be able to dump index blocks? Or would they not be useful
in this context?

-Justin
