Received: from mail-pf1-f182.google.com (mail-pf1-f182.google.com [209.85.210.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FCF2623
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 13:20:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731763217; cv=none; b=PM+hETzUlVxxRgUkK38oyBrdMDCPKhT0ZVF8khuIya/1vdUO5OPq3xBXxYLqhYXLjrJlCGwlMAoD8mgz7JJlJPfIXcwv3TVZU6he/uYZbK8dhTR4hW3m/0tU/p8wZ30SQJtKK7QtaBBSxmvA2FIxpNadPWqrWE9j8ra2mb7G53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731763217; c=relaxed/simple;
	bh=H4qL7HUxQJ8d8PbTgAv/CCV9+WjtdpGzFM/A8kfD+r0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FU8BwzANZmGNLnA8qBOjTdJFe5KMy/eqbPLGTsc6ioDDUa0uSbi4cZuESM/2AQJ637/+2USs9Es0rfwcXP1T8S9X54kdIdYOukeFTGxEGZOmt2qIfJCyus53gxto9T8MQre/1YctTkYqpd6+yDubP03Fjk9g6G2CKqXmJodQegM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U6eQjQUs; arc=none smtp.client-ip=209.85.210.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U6eQjQUs"
Received: by mail-pf1-f182.google.com with SMTP id d2e1a72fcca58-723f37dd76cso1460077b3a.0
        for <git@vger.kernel.org>; Sat, 16 Nov 2024 05:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731763215; x=1732368015; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=G+qkZvXS/zAdKHqzQqrVh8+hptitRr32tnj5CUKSNjs=;
        b=U6eQjQUseWTBCtj3jrb0ifBl66xWjAgJj4z23a/JgVEcLOLWIt5951IutPpr2fJ7kc
         6hqBrqozBvGZoXgNf3TffW8OPjGhocmASiQWvGlGquQncak56/3HVv1+C4WTcgFkpJPf
         Bebi64i97N5EMoNrMAlLkB0+pnKS73mYkTbwS8Nz8D5DWuxbvoXpu7+zTlMOyvs0vf32
         CJpH/wjhwsv768YJj7X29EJEtYZmQpCCWnQ57BTr2hX19QVqKh5+2XOBho5vRMKDtV1u
         ypNFS7T6vuunhcIoblAd2Q422Xk5ViSGDtlGlnp1ddrx3PQa6dBTGoQ+6ahCRFw5CQCr
         2NAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731763215; x=1732368015;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=G+qkZvXS/zAdKHqzQqrVh8+hptitRr32tnj5CUKSNjs=;
        b=ir3zrelRlfineLMMUv7Jn6Crr2H2vrTVlt+3ZcatnCeotXXq5Fkwg7ox8ZK/eZfHdi
         qPncszxKxvBW/rtKG3F3Zto035AUot27fT8BvijM7yNE67jd1cyDlnAfuzEnEp2b4VY0
         2Wt5/fbX7CXGa2W0t4RvvuoWWS8hA27Mvm68huM1SLDaw2KLIMka9uzxtZLY/mU0mkhY
         yi9hDbSSfxqBNrPvL+xzMhV1S4dKyqxiKIjyOSWY50m18n6eePxPr7AzMDWV4cQL0L7T
         GbLeh0hiyFjSpC7lOXQDOQ26iMg29b9DgECZ1IK76RJnK9YJLB9RFjRwNk6dDlYVmbnV
         jiWA==
X-Gm-Message-State: AOJu0Yx1lZZLO2YVde1Y8o2jxAjPVJTe2DevJfWMmAxVBi5gjAZhA67x
	HIEiRF5TKSohdxj1r4F1Q81nJRC/rjpPJjw7KQ4n3CYcqLCir6kl
X-Google-Smtp-Source: AGHT+IEjIOypjBzo4zo89AD27KhUDx6DTDXvDPfgXpKlqMf1pG/AmGerBlSof1x/yy8opWiQjISU5A==
X-Received: by 2002:a05:6a00:3d0a:b0:71e:59d2:9c99 with SMTP id d2e1a72fcca58-72476b672d4mr8360658b3a.4.1731763215483;
        Sat, 16 Nov 2024 05:20:15 -0800 (PST)
Received: from localhost ([2605:52c0:1:4cf:6c5a:92ff:fe25:ceff])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-724771e2009sm3012252b3a.163.2024.11.16.05.20.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 16 Nov 2024 05:20:14 -0800 (PST)
Date: Sat, 16 Nov 2024 21:20:19 +0800
From: shejialuo <shejialuo@gmail.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org, me@ttaylorr.com, peff@peff.net
Subject: Re: [PATCH 7/8] midx: pass down `hash_algo` to
 `get_split_midx_filename_ext`
Message-ID: <ZzicEz_WFWcExhDa@ArchLinux>
References: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-0-761f8a2c7775@gmail.com>
 <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-7-761f8a2c7775@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241115-374-refactor-midx-c-and-midx-write-c-to-not-depend-on-global-state-v1-7-761f8a2c7775@gmail.com>

On Fri, Nov 15, 2024 at 02:42:20PM +0100, Karthik Nayak wrote:

[snip]

> diff --git a/midx.h b/midx.h
> index 7620820d4d0272926af9e4eeb68bfb73404c7ec2..9d1374cbd58d016bb82338337b2a4e5ba7234092 100644
> --- a/midx.h
> +++ b/midx.h
> @@ -97,7 +97,8 @@ void get_midx_filename_ext(const struct git_hash_algo *hash_algo,
>  			   const unsigned char *hash, const char *ext);
>  void get_midx_chain_dirname(struct strbuf *buf, const char *object_dir);
>  void get_midx_chain_filename(struct strbuf *buf, const char *object_dir);
> -void get_split_midx_filename_ext(struct strbuf *buf, const char *object_dir,
> +void get_split_midx_filename_ext(const struct git_hash_algo *hash_algo,
> +				 struct strbuf *buf, const char *object_dir,

Similar to comment for the previous patch, we should not put "hash_algo"
at the first.

>  				 const unsigned char *hash, const char *ext);
>  
>  struct multi_pack_index *load_multi_pack_index(struct repository *r,
> 
> -- 
> 2.47.0
> 
