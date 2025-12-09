Received: from mail-oo1-f48.google.com (mail-oo1-f48.google.com [209.85.161.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0D301DDC3F
	for <git@vger.kernel.org>; Tue,  9 Dec 2025 02:09:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765246176; cv=none; b=CQHnuhhKM57mk8qThEI8wQZs3PS2BmWD80ynvDTcibFcNTOTcIJO+IrYIXWTkukY8xM0883vcrNjLJ5vuIa3+zbmBN3GV+9q1c3rcQLWkmY89AhVVSDI7DzKN+z/Lntx0x7whgE+ygpr3W7E7BX+pbmAo99GetHSs50PaFvCkP4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765246176; c=relaxed/simple;
	bh=ieHF+SHakmISnqOIEBSnDAgs5VMfpjhHKceqAT8Yoh4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDYVL0Up+AdjZUZB4iU0Gt5+q/jv2pEh81juWPckS7memxa8qKftKWrxmoBRyB1Z7eISkKymAkUpF/W5gyDxsFhjmvCRDkM5AutfzkbnRCHcPySMiZHRb32SwwTnMo5YxmBYr0gQzzXTcEBDdVWfRAlWT/pzVyLDTKSSUc4TuJM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=mCR4Ig8H; arc=none smtp.client-ip=209.85.161.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mCR4Ig8H"
Received: by mail-oo1-f48.google.com with SMTP id 006d021491bc7-657509d761dso3041126eaf.0
        for <git@vger.kernel.org>; Mon, 08 Dec 2025 18:09:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765246174; x=1765850974; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EQYvWqCoAz4gom1mSehpHa+LgrhIYu+Z/atWUwyNpMs=;
        b=mCR4Ig8Hke2c+ushqE/riDJqyQtomjc/Dnwpm294F0aO5HfjVFYbeMIJQ1ybn/5g8K
         ZpIq9C7oAovZD3RyavXiqbkH1aWW6gIyKH5pSkfIw7ahSfRdo6W3iFRtQumheqU4rmZb
         v+cyvOJQ6M14YzKBUi93zeQpwJKT/xKB8jW1p8RP1Q/PcWXvgYEgVhYMGdISZjms8+Od
         IKqQCZGP+SpGsLyk78IaaWBSPr0B7iRwplcp6xhfTYzGNgeJ3LFt4yZlaTzFG29OOoN3
         Lw1r0Ez+Ozabx2U0Q5CIEUHsM+2VbvIEKov+v/2HmLcs+AuDV1o8yMAoXjFVMWSepSOc
         o9NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765246174; x=1765850974;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=EQYvWqCoAz4gom1mSehpHa+LgrhIYu+Z/atWUwyNpMs=;
        b=iCyv7goux5w+OdQJQemE6jih6nBkWk+HCugqKAgjcpz2gdfEz8U9pBXpqnZEy5fJTG
         zglRpa9YnNX4H/8wKbQtKEhonCvrALInkI+PcX9TGCjkisBRj0ePvJeoywaBZQ0jWT58
         tYdYypdmGOIto7LyClOGyJwqMr7CzNDD3kxLhLr0MGp+RSG76cxsbNclD0fH6i53nCKP
         bdUwXWO/hYiYaQQYPBhdrE7GnrFWCp1hKcOk6cx+IvCMNOxgOd56oDvREot9qwTwDn0q
         83uz9hxP+/XfTv3g8+zpPmjADwU4GMSWGj+PgAkRWdfg2cUyG2tpVPlhJdIQWQom9Msr
         dO/w==
X-Gm-Message-State: AOJu0YwFT/BUjwqnEJFbPw2tYrDEWuKPjcHArcqsgdbPsf4+8QU+aOsP
	Ge4zN+KJwII4tds/DmTScpbyhF+QmePZZPU7Yal5iW59dspDlb8UqULjhtX34g==
X-Gm-Gg: ASbGncvtI/qOJXfl1PrFg1ePPDMVwXo77bFV2tD8w/vY+OE6BfntLWtvZcKrmk+Dyl3
	IgC4hTcgSjhgS/BVEDwJWQ8jTNuJ9POB6FzeuhUB8DwxooVZHDwEfWW7fY8VouqDe1PI8YpDLNq
	ysJ2/z0NHssIeFs59AsCccQnK1dRK3yfvBM5tIA3VLEqIw+rycxFuK1fv5e1Z+l2yjn41/ZCu6s
	4ma/avfOUJvRni6JIco1mzdv+D7qTPE3QTJLfNdw9geCAfiAtyejZNb+jh0qO30OZnPCFn+tCR1
	fVeOiPblYnpDtzkQiSqlmZ0y3L0t1DXSePOzyW0Xbq/EQDoBtNv3HBV0JJYFvrQb5c5eUDUSQfe
	Vu98GKGYVrYqBJqxSZPIbDBm5DuSK1LFN2J3aI4puksGfxNConDkjStTg/ex6JCHp9EbcoFW+k5
	8HsA2j
X-Google-Smtp-Source: AGHT+IGUlgUzStjZITrNcYVIg3Xi1ggVUjHCqMfW4PGzij1nCspqfdz3MeeGSA+5Phm6/dMkUMAn/Q==
X-Received: by 2002:a4a:e914:0:b0:659:9a49:8fc4 with SMTP id 006d021491bc7-6599a973638mr4369614eaf.61.1765246173744;
        Mon, 08 Dec 2025 18:09:33 -0800 (PST)
Received: from localhost ([136.50.74.45])
        by smtp.gmail.com with ESMTPSA id 006d021491bc7-6597ec4bdc1sm7028300eaf.6.2025.12.08.18.09.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Dec 2025 18:09:33 -0800 (PST)
Date: Mon, 8 Dec 2025 20:09:30 -0600
From: Justin Tobler <jltobler@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/8] odb: resolve relative alternative paths when parsing
Message-ID: <kz2eftlrmaxpxjybhjwqlewy3dx44sdznimzs6reoqtev4qtox@hl3s2gxz3sk2>
References: <20251208-b4-pks-odb-alternates-via-source-v1-0-e7ebb8b18c03@pks.im>
 <20251208-b4-pks-odb-alternates-via-source-v1-2-e7ebb8b18c03@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251208-b4-pks-odb-alternates-via-source-v1-2-e7ebb8b18c03@pks.im>

On 25/12/08 09:04AM, Patrick Steinhardt wrote:
> Parsing alternates and resolving potential relative paths is currently
> handled in two separate steps. This has the effect that the logic to
> retrieve alternates is not entirely self-contained. We want it to be
> just that though so that we can eventually move the logic to list
> alternates into the `struct odb_source`.

Naive question: is the intent here to eventually move alternate ODB
sources under the primary ODB source? Or just to record the alternate
dir info in the ODB source?

> Move the logic to resolve relative alternative paths into
> `parse_alternates()`. Besides bringing us a step closer towards the
> above goal, it also neatly separates concerns of generating the list of
> alternatives and linking them into the object database.
> 
> Note that we ignore any errors when the relative path cannot be
> resolved. This isn't really a change in behaviour though: if the path
> cannot be resolved to a directory then `alt_odb_usable()` still knows to
> bail out.
> 
> While at it, rename the function to `odb_add_source()` to more clearly
> indicate what its intent is and to align it with modern terminology.

Alternates are indeed just additional ODB sources appended to the
sources list. IIUC though, doesn't this function only add alternate
sources? If so, maybe it would be better to use
`odb_add_alternate_source()`?

> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  odb.c | 64 ++++++++++++++++++++++++++++++++--------------------------------
>  1 file changed, 32 insertions(+), 32 deletions(-)
> 
> diff --git a/odb.c b/odb.c
> index 9785f62cb6..3ffeece567 100644
> --- a/odb.c
> +++ b/odb.c
> @@ -159,44 +159,21 @@ static struct odb_source *odb_source_new(struct object_database *odb,
>  	return source;
>  }
>  
> -static struct odb_source *link_alt_odb_entry(struct object_database *odb,
> -					     const char *dir,
> -					     const char *relative_base,
> -					     int depth)
> +static struct odb_source *odb_add_source(struct object_database *odb,
> +					 const char *source,
> +					 int depth)
>  {
>  	struct odb_source *alternate = NULL;
> -	struct strbuf pathbuf = STRBUF_INIT;
>  	struct strbuf tmp = STRBUF_INIT;
>  	khiter_t pos;
>  	int ret;
>  
> -	if (!is_absolute_path(dir) && relative_base) {
> -		strbuf_realpath(&pathbuf, relative_base, 1);
> -		strbuf_addch(&pathbuf, '/');
> -	}
> -	strbuf_addstr(&pathbuf, dir);
> -
> -	if (!strbuf_realpath(&tmp, pathbuf.buf, 0)) {
> -		error(_("unable to normalize alternate object path: %s"),
> -		      pathbuf.buf);
> -		goto error;
> -	}
> -	strbuf_swap(&pathbuf, &tmp);
> -
> -	/*
> -	 * The trailing slash after the directory name is given by
> -	 * this function at the end. Remove duplicates.
> -	 */
> -	while (pathbuf.len && pathbuf.buf[pathbuf.len - 1] == '/')
> -		strbuf_setlen(&pathbuf, pathbuf.len - 1);
> -
> -	strbuf_reset(&tmp);
>  	strbuf_realpath(&tmp, odb->sources->path, 1);
>  
> -	if (!alt_odb_usable(odb, pathbuf.buf, tmp.buf))
> +	if (!alt_odb_usable(odb, source, tmp.buf))
>  		goto error;
>  
> -	alternate = odb_source_new(odb, pathbuf.buf, false);
> +	alternate = odb_source_new(odb, source, false);
>  
>  	/* add the alternate entry */
>  	*odb->sources_tail = alternate;
> @@ -212,20 +189,22 @@ static struct odb_source *link_alt_odb_entry(struct object_database *odb,
>  
>   error:
>  	strbuf_release(&tmp);
> -	strbuf_release(&pathbuf);
>  	return alternate;
>  }
>  
>  static void parse_alternates(const char *string,
>  			     int sep,
> +			     const char *relative_base,
>  			     struct strvec *out)
>  {
> +	struct strbuf pathbuf = STRBUF_INIT;
>  	struct strbuf buf = STRBUF_INIT;
>  
>  	while (*string) {
>  		const char *end;
>  
>  		strbuf_reset(&buf);
> +		strbuf_reset(&pathbuf);
>  
>  		if (*string == '#') {
>  			/* comment; consume up to next separator */
> @@ -250,9 +229,30 @@ static void parse_alternates(const char *string,
>  		if (!buf.len)
>  			continue;
>  
> +		if (!is_absolute_path(buf.buf) && relative_base) {
> +			strbuf_realpath(&pathbuf, relative_base, 1);
> +			strbuf_addch(&pathbuf, '/');
> +		}
> +		strbuf_addbuf(&pathbuf, &buf);
> +
> +		strbuf_reset(&buf);
> +		if (!strbuf_realpath(&buf, pathbuf.buf, 0)) {
> +			error(_("unable to normalize alternate object path: %s"),
> +			      pathbuf.buf);
> +			continue;
> +		}
> +
> +		/*
> +		 * The trailing slash after the directory name is given by
> +		 * this function at the end. Remove duplicates.
> +		 */
> +		while (buf.len && buf.buf[buf.len - 1] == '/')
> +			strbuf_setlen(&buf, buf.len - 1);
> +

Here we move the logic to resolve relative paths into
parse_alternates(). This seems reasonable to me.

-Justin
