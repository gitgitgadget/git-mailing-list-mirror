Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83D243A544C
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 13:34:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780320866; cv=none; b=UEZvu0VpjVa/CoFN6Olv6qfNn1mZlGGTfo214T87xDob5aaAY0PhIiK0V+jdry0DXxJrc3W65hcp+CORL24MuYW7PcbSWlNcez9/DdcRC0Yl/Cfu+GMvEivfbKOArfYqRs1CzLn9J+jj2u82T8RyD/5tV3/slYPL3RnUi03BPn0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780320866; c=relaxed/simple;
	bh=XB+QT9ZIIZfEfVoydTtlkKjqUnTjEnkuDx/leFN5nx4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r66ulNYIPTlOwr3ggOE9bqmjcJHQZwAn2+pYLDD83psZ33qmpJBUdxTPlqncfHqYy/Xf1oA9vig9v/qKw7ri+8ePC9pJZKCjhVPIS5xTLP2ra7roT/uoLrBwby5TC55xAH/dGJLzioIa7M9UkOHix8HskL62qbhPWDZQPkjSlOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=lbK+r1RR; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="lbK+r1RR"
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-490a7627033so12040695e9.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2026 06:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780320863; x=1780925663; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=chLKBSZq5IbqCqbsOTowMd+KfryGPfP8OfTqZqyK9qg=;
        b=lbK+r1RRT9XZzjPY0qMoYKtS5S4tUPYcAZXqdzvG49E1zyI07DSup3h9k4SfHw23Mb
         7vGCnWmmiJID1xUmM5Ir6O4Z2yCLB7u7MZB0vSQMI+O11dSwg8w0wRpACK+dXVG2JUaH
         TvTl+DdACOEtNiineEm010eq9rAP5z8iPRZWqn5noWrsp2JFzUj4SGRGSx8GBumdE80O
         EU296E9waobFjRtUBCwS3roXVrnZMLKltqW9p+pWDhV4zpLzet7GQk4iuAoE49yrHqrt
         Zdb0nkw5n94uAXHJR8cuXuGGPIGRK7Jbb66Dl7eiRebSqJ1Ai1cKfFlEpNY2rNeG4uSN
         z4+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780320863; x=1780925663;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=chLKBSZq5IbqCqbsOTowMd+KfryGPfP8OfTqZqyK9qg=;
        b=Ur8VfkRZMUTjECmbP/187d8bds6wKRkmC+NG8YK9gwnjG83e4ymtodKBWs34Yj3uwJ
         WrczR7uu92IgOJFgzyxJ93Il19Cj3RIm6NW/NWqW4Km7Ly8koAFTU6WfuBMfJQHh+sR6
         bj0DwNVeLMdQlL2xRoeq7awC1EUf/Ge6cP6Bf/2kM+U7V6xv1eDvspWaodLh/TmDp2iz
         0Oj2q/rXhhimXgt97/ilzvpI2Oin6HHySKGqL2CAybG9FaNQeVQZ+ea3TTvsYuQQwbS0
         PmhNVTsRN/fObXhd26daim6H+r3cf4nZlkATlCDtg1XEB01u+ELKei332wla+6YRLrkK
         buzg==
X-Gm-Message-State: AOJu0YxoLIQ6/XLZisWxU8WsivJ3KZPBNbGtwoMSnBQQYAXmdeVdgJW6
	U8RyLaheKGfZAXQjzvnrI1uZW1cvAv1CtD698Bean7gC99p8/uM2ONoe
X-Gm-Gg: Acq92OGfGeXm57Vm7zIvUGmP+0n7l7yP9bfjlPITixS7OGsnOXtu07h4D3C4+fSHLDk
	eC5RlZkPRra/vXnf7T1Zi8jwpJnpYIy8QqyL/aCifQpRO2ajBvfQpAWjuX3UBleQcjmUIMc4A4f
	fmQ3vpG+m7nWy9kjpFdQ+gAb0usqJHl8JjE+WKr9cLnCquKA7XbI2P0Ul0NzUn1BnJZVg0gHxDX
	aicgxD7UzlqbPqZSwr3l1CQ/E5saXr8jKB+M4epNnz2Fk+23AiphXvE+4Oh/Mewhlkhi3/Uz/FS
	rt4WKrHLrJgTPMOm3vx6cv4bMII2ZxoFvAS8HfSDFndMf5BrowWFw0PIPV9Px09LOZe830qzQVy
	3aOq0Iwjt1Qh4ytm5RrkhVBZ3FAEfF6t0Aa/RzGbPZUm50+lAw27iYW+C9mjkGxkmCS3jm9PbkO
	GSa9uLflh5v2FuSBmrrx+ZojRFJiKMp5K2QfYtdZqf8rWaQcRVjrL999s8K3UJJRr+AjDHBIzPV
	KKc/IQxDrA0Ly42RnkZWVYa/cahXwr1yuozDOtEW8Qx
X-Received: by 2002:a05:600c:a009:b0:490:ad8e:11bc with SMTP id 5b1f17b1804b1-490ad8e1279mr43460635e9.31.1780320862796;
        Mon, 01 Jun 2026 06:34:22 -0700 (PDT)
Received: from lorenzo-VM ([84.33.159.46])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-490ae39c281sm30161565e9.14.2026.06.01.06.34.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2026 06:34:22 -0700 (PDT)
Date: Mon, 1 Jun 2026 15:34:20 +0200
From: Lorenzo Pegorari <lorenzo.pegorari2002@gmail.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
	Junio C Hamano <gitster@pobox.com>, Patrick Steinhardt <ps@pks.im>,
	fox <fox.gbr@townlong-yak.com>
Subject: Re: [PATCH v2] http: fix memory leak in fetch_and_setup_pack_index()
Message-ID: <ah2KXNnUB79KRmnr@lorenzo-VM>
References: <agx5tblaCZNsYEBq@lorenzo-VM>
 <ahjUmMCKxREamQE-@lorenzo-VM>
 <20260529053659.GC1099450@coredump.intra.peff.net>
 <20260529054024.GA1104383@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260529054024.GA1104383@coredump.intra.peff.net>

On Fri, May 29, 2026 at 01:40:24AM -0400, Jeff King wrote:
> On Fri, May 29, 2026 at 01:36:59AM -0400, Jeff King wrote:
> 
> > But it _could_ be done as a preparatory patch. And the rationale for
> > doing that on its own I think is roughly:
> > 
> >   1. It is mostly doing nothing, because 63aca3f7f1 registered it as a
> >      tempfile, so it will be cleaned up at process end anyway (whether
> >      we succeed in fetching it or not).
> > 
> >   2. It is maybe a little harmful, because we are going to unlink() it
> >      now, and then later the tempfile code will try to unlink() it again
> >      (so a simultaneous fetch could have created the same file).
> 
> BTW, for (2) I wondered about going in the opposite direction. If we
> actually passed the tempfile back up, like in the patch below, then we
> could use delete_tempfile() to do the unlink (and remove it from the
> tempfile list).
> 
> And then your patch would want to similarly delete_tempfile() in its
> error path.
> 
> But I don't think it really buys us much. _If_ we were going to keep
> passing the tempfile struct up the call stack on success, then we could
> store it and call delete_tempfile() as soon as we had ran index-pack on
> it. But that's even more surgery, for again little gain (we delete our
> tempfiles a little earlier, rather than at process end).
> 
> So I'm inclined to go in the direction that shortens the code. ;)
> 
> -Peff
> 
> ---
> diff --git a/http.c b/http.c
> index ea9b16861b..e83a3857b3 100644
> --- a/http.c
> +++ b/http.c
> @@ -2546,9 +2546,10 @@ int http_fetch_ref(const char *base, struct ref *ref)
>  }
>  
>  /* Helpers for fetching packs */
> -static char *fetch_pack_index(unsigned char *hash, const char *base_url)
> +static struct tempfile *fetch_pack_index(unsigned char *hash, const char *base_url)
>  {
>  	char *url, *tmp;
> +	struct tempfile *ret;
>  	struct strbuf buf = STRBUF_INIT;
>  
>  	if (http_is_verbose)
> @@ -2575,23 +2576,24 @@ static char *fetch_pack_index(unsigned char *hash, const char *base_url)
>  	tmp = xstrfmt("%s/tmp_pack_%s.idx",
>  		      repo_get_object_directory(the_repository),
>  		      hash_to_hex(hash));
> -	register_tempfile(tmp);
> +	ret = register_tempfile(tmp);
> +	free(tmp);
>  
> -	if (http_get_file(url, tmp, NULL) != HTTP_OK) {
> +	if (http_get_file(url, ret->filename.buf, NULL) != HTTP_OK) {
>  		error("Unable to get pack index %s", url);
> -		FREE_AND_NULL(tmp);
> +		delete_tempfile(&ret);
>  	}
>  
>  	free(url);
> -	return tmp;
> +	return ret;
>  }
>  
>  static int fetch_and_setup_pack_index(struct packfile_list *packs,
>  				      unsigned char *sha1,
>  				      const char *base_url)
>  {
>  	struct packed_git *new_pack, *p;
> -	char *tmp_idx = NULL;
> +	struct tempfile *tmp_idx;
>  	int ret;
>  
>  	/*
> @@ -2607,11 +2609,9 @@ static int fetch_and_setup_pack_index(struct packfile_list *packs,
>  	if (!tmp_idx)
>  		return -1;
>  
> -	new_pack = parse_pack_index(the_repository, sha1, tmp_idx);
> +	new_pack = parse_pack_index(the_repository, sha1, tmp_idx->filename.buf);
>  	if (!new_pack) {
> -		unlink(tmp_idx);
> -		free(tmp_idx);
> -
> +		delete_tempfile(&tmp_idx);
>  		return -1; /* parse_pack_index() already issued error message */
>  	}

Yeah, I also explored the possibility (as you suggested in your first
reply to v1) of manually deleting the tempfile. In my opinion, this
isn't worth the effort, and it's complicating the code for no reason, so
in the end I opted for keeping it as simple and minimal as possible.

Thanks,

Lorenzo

