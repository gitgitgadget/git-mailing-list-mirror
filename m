Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 96C512580F2
	for <git@vger.kernel.org>; Sun, 21 Jun 2026 21:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782075744; cv=none; b=hatC74nopESZG/RPE55uAUup4DlsQ0qkJpz0xTPY5sJ3l3HpfkBsHvHtWEOYb0zrHLnRJAJt4WszmG4CB0UyTkd4Qa2EJRzXwc6ecwBTgWKU4XUOonuWnjjZOg1CyaqZwqHHJDgr+2WaYTGn91sMRD9nI82WdyFu3H8n/rFMBkg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782075744; c=relaxed/simple;
	bh=jDXPkRwAPXpTu3sLZmwX+CpcmG///e0aSXeTarCetV4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=acWoM33TceciriEDwssbB8Jn2d+ReWYdDjA0qlEX7PTBG+iGs+ElNeetj0Z8WTeMPCovGsHXmLUYeRemqjYf9lOIVzTeByTE88ve5j35cnEksH8srmgjmt3g5Q7w4Y9rqJRHil0xcl6OfRCxS6V+QEmJw0X5tGT+KFISO0Oq6Ks=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Gbgnw4N3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PSUM5Qaf; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Gbgnw4N3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PSUM5Qaf"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D27BB14001E9;
	Sun, 21 Jun 2026 17:02:21 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Sun, 21 Jun 2026 17:02:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782075741; x=1782162141; bh=aaevqjxtPm
	q+6Q8a6bPq68EpdRmr3AOPgiyvKyuMA5M=; b=Gbgnw4N3/8qT5hV9UdokP4y8j/
	lrWTEAfa6FAbEcNMTQE0yMoGC5YUYQiIw3hjl53WKMPBVXMwZ3wwVBb4uSs7Cyv7
	TeWMWN4NDOPAljlFPcgdDRnNXXrn6ik7BnBXcTOUerbrUbRanFCM1B+jUukNfs75
	++EjGOAjh+An1dOBROSq5xCxNFw3dp0cL0UxiJLFgjQmgmZ1VJYbaUh3a1lP6d+E
	5EuWOnY6Z8eGg+csuW9J12iE4LR2SHJof7HgXF687NrgI2SZEO6jRpmWbbsJFj57
	O2+fzIom1iKKJ+s6Twq4O0B9q2Q6iDh073cOrU7zHDfRrliZ0rConHb1EHbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782075741; x=1782162141; bh=aaevqjxtPmq+6Q8a6bPq68EpdRmr3AOPgiy
	vKyuMA5M=; b=PSUM5QafJCmbGkU3PsSmLASwJttMNAVhLx8hpRS7xN91fwycqG1
	47kZdrF+ISwBHbt1of8AwrMVnu0tPmqGNmWNQwt7PMOwPfRni7A64lbwKdYtmoJ/
	V4VeJ5f2f5H3Cu5Nxoh1KmhnzzM5Qs/oCKEUO7jhFfE4MjkuzYXr0Ah/j/w1zKJR
	BVVRKyvurtOIwNHA1iNAX+uXw2Lt1ifaWQjCPzY8n0Qlbq2qqnFf/1/EFG1CNtl2
	mn7XjRdbC9kcbBNCzBwoUf4X68Cq9YrKuZtwZsbx9hRYSdd5AqeFWiLM14yc7lt3
	/OukF2Rk20NlPSyjaNMfbnh/VSQDoKJbr9Q==
X-ME-Sender: <xms:XFE4atQnkYsbdSzad0s7gtqmt8hGbcNclqDApUjcl1yy95EL6bfYYQ>
    <xme:XFE4arsik3NFvUOyOkM7c1XCAX-86Auyq0RRCiUhs4Xg6kUOjwPMvJrkV07Cf9zFO
    -B4a-xZPARLuO73EIAgP6MLUF3zi3sLGwPD_Cw1ffbNkmmwzVKRFzE>
X-ME-Received: <xmr:XFE4anH7vRbc6XX7-CAw_rVMNOaEMhLM3HV2yJNBDoZCWFx91IPZPW6PvD5uFVkvDjV1-p3L95vmxQypdRV9JIj9I8nXggw_T_MpWlw>
X-ME-Proxy-Cause: dmFkZTGjRpalZRmje67YyoYq966D2vNDIkkwkZtAVza/uE2wTtaDSTtMXk5jCCdMK8+WUl
    tRDLq3jF5O/GCnCLTHM1/DYH+tPyrbFSTafhKKRp1AYLZLQrjV2iR5kpw6JZyQ1Y8O1TYK
    ME1NNSKPGx9ZaZJ7VRZLT3cGSaoQiebLA2NOZQLaXX/bySctEIXQgFkHtDg1m+FdQP5E0t
    Z3mkogsV4VvlycbXBF/Xg/AzTuuT8CayKCC8t8mCNpqt03RP5nwTXJNPaXJW/xc+tOwEvb
    vHlhEcPQenfonYTVNc5qoX3VQ4C6iGWdQd6VwUdr5oy+4qanqI/88IP+Zh0iddDBcPbicK
    VskKA68iNCGSHX+OHcSRMbRkNkDLJUs4XQpq/tFsLclri6HwRpdD7AdU2il1FkNp8XS5hZ
    kj5GgMjk/Z/PmkmEzzNPOkNADG3ESwUr9qr/jqsyCb3PuSejtyJhkLoUdlyp6H1S4mVj8Q
    5qe33anQ1MPxX5fubkuh4H71F7Dq0RjQ6ZaUV7erf+Wqu3VVqCWujGingQqgsBkavtISQt
    Qve4/KMc18xWqxp5HWvRxTHRZ4wWlaRLAXPljlvn96bV/yhlv6yDszXo7WaP1ZS53a/o3J
    RFoYXLWNvfmBLhLIFtSiHZfrofounUqNT7L2rikDA/8Pgje3w184XuEbT8Rw
X-ME-Proxy: <xmx:XFE4akxLmTquVAJCwrRo_kE4HEolBF4PHvSqh7hxuDpW5NSsPIW25A>
    <xmx:XFE4ap1TAshD-sd4wzYsj922WUqH0fQIjYpsp4_PGxSmH4WnLeO_nA>
    <xmx:XFE4asqOpPKkYA0Y9ki7utoTMj_hVZzDAWwJvkg0DXsv2B_rWa7FHw>
    <xmx:XFE4auWAOGp9ZY9hO40qvDRo8mslnqxcZz0jsyd4lgtoGnyvXocaEQ>
    <xmx:XVE4ahPWAPqoyQ_0RhusF6JQh2DRH0UOLxBzerhv5RnwqGZxnos0qd_y>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 21 Jun 2026 17:02:20 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: a3205153416@gmail.com,  git@vger.kernel.org,  jltobler@gmail.com,
  kumarayushjha123@gmail.com,  lucasseikioshiro@gmail.com,
  phillip.wood@dunelm.org.uk,  sandals@crustytoothpaste.net
Subject: Re: [GSoC Patch v7 1/3] path: extract append_formatted_path() and
 use in rev-parse
In-Reply-To: <20260621055534.46798-2-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Sun, 21 Jun 2026 11:25:32 +0530")
References: <20260601151950.30686-1-jayatheerthkulkarni2005@gmail.com>
	<20260621055534.46798-1-jayatheerthkulkarni2005@gmail.com>
	<20260621055534.46798-2-jayatheerthkulkarni2005@gmail.com>
Date: Sun, 21 Jun 2026 14:02:19 -0700
Message-ID: <xmqqtsqv6204.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

So, for the existing user of this logic, the preimage ...

> -static void print_path(const char *path, const char *prefix, enum format_type format, enum default_type def)
>  {
> -	char *cwd = NULL;
> -	/*
> -	 * We don't ever produce a relative path if prefix is NULL, so set the
> -	 * prefix to the current directory so that we can produce a relative
> -	 * path whenever possible.  If we're using RELATIVE_IF_SHARED mode, then
> -	 * we want an absolute path unless the two share a common prefix, so don't
> -	 * set it in that case, since doing so causes a relative path to always
> -	 * be produced if possible.
> -	 */
> -	if (!prefix && (format != FORMAT_DEFAULT || def != DEFAULT_RELATIVE_IF_SHARED))
> -		prefix = cwd = xgetcwd();
> -	if (format == FORMAT_DEFAULT && def == DEFAULT_UNMODIFIED) {
> -		puts(path);
> -	} else if (format == FORMAT_RELATIVE ||
> -		  (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE)) {
> -		/*
> -		 * In order for relative_path to work as expected, we need to
> -		 * make sure that both paths are absolute paths.  If we don't,
> -		 * we can end up with an unexpected absolute path that the user
> -		 * didn't want.
> -		 */
> -		struct strbuf buf = STRBUF_INIT, realbuf = STRBUF_INIT, prefixbuf = STRBUF_INIT;
> -		if (!is_absolute_path(path)) {
> -			strbuf_realpath_forgiving(&realbuf, path,  1);
> -			path = realbuf.buf;
> -		}
> -		if (!is_absolute_path(prefix)) {
> -			strbuf_realpath_forgiving(&prefixbuf, prefix, 1);
> -			prefix = prefixbuf.buf;
>  		}
> -		puts(relative_path(path, prefix, &buf));
> -		strbuf_release(&buf);
> -		strbuf_release(&realbuf);
> -		strbuf_release(&prefixbuf);
> -	} else if (format == FORMAT_DEFAULT && def == DEFAULT_RELATIVE_IF_SHARED) {
> -		struct strbuf buf = STRBUF_INIT;
> -		puts(relative_path(path, prefix, &buf));
> -		strbuf_release(&buf);
> -	} else {
> -		struct strbuf buf = STRBUF_INIT;
> -		strbuf_realpath_forgiving(&buf, path, 1);
> -		puts(buf.buf);
> -		strbuf_release(&buf);
>  	}
> -	free(cwd);
>  }

... now becomes this postimage.

> +static void print_path(const char *path, const char *prefix,
> +		       enum format_type format, enum default_type def)
>  {
> +	struct strbuf sb = STRBUF_INIT;
> +	enum path_format fmt;
> +
> +	if (format == FORMAT_RELATIVE) {
> +		fmt = PATH_FORMAT_RELATIVE;
> +	} else if (format == FORMAT_CANONICAL) {
> +		fmt = PATH_FORMAT_CANONICAL;
> +	} else /* FORMAT_DEFAULT */ {
> +		switch (def) {
> +		case DEFAULT_RELATIVE:
> +			fmt = PATH_FORMAT_RELATIVE;
> +			break;
> +		case DEFAULT_RELATIVE_IF_SHARED:
> +			fmt = PATH_FORMAT_RELATIVE_IF_SHARED;
> +			break;
> +		case DEFAULT_CANONICAL:
> +			fmt = PATH_FORMAT_CANONICAL;
> +			break;
> +		case DEFAULT_UNMODIFIED:
> +		default:
> +			fmt = PATH_FORMAT_UNMODIFIED;
> +			break;
>  		}
>  	}
> +
> +	append_formatted_path(&sb, path, prefix, fmt);
> +	puts(sb.buf);
> +
> +	strbuf_release(&sb);
>  }

Mostly, the code translates FORMAT_FOO constants into the new
PATH_FORMAT_FOO constants, and lets append_formatted_path() do the
heavy lifting.

It is a minor point, but wouldn't it make it simpler to handle
format_default first?  I.e.,

	if (format == FORMAT_DEFAULT)
		switch (def) {
		case DEFAULT_RELATIVE:
			format = DEFAULT_RELATIVE;
			break;
		...
		case DEFAULT_UNMODIFIED:
		default:
			format = DEFAULT_UNMODIFIED; 
			break;
	}
	switch (format) {
        case FORMAT_RELATIVE: fmt = PATH_FORMAT_RELATIVE; break;
	case FORMAT_CANONICAL: fmt = PATH_FORMAT_CANONICAL; break;
	...
	}

Perhaps yes, perhaps not.  I dunno.

> diff --git a/path.c b/path.c
> index d7e17bf174..6d8e892ada 100644
> --- a/path.c
> +++ b/path.c
> @@ -1579,6 +1579,75 @@ char *xdg_cache_home(const char *filename)
>  	return NULL;
>  }
>  
> +void append_formatted_path(struct strbuf *dest, const char *path,
> +			   const char *prefix, enum path_format format)
> +{
> +	switch (format) {
> +	case PATH_FORMAT_UNMODIFIED:
> +		strbuf_addstr(dest, path);
> +		break;

In the orignal "print_path()", DEFAULT/UNMODIFIED did this "show
unmodified".  OK.

> +	case PATH_FORMAT_RELATIVE: {
> +		struct strbuf relative_buf = STRBUF_INIT;
> +		struct strbuf real_path = STRBUF_INIT;
> +		struct strbuf real_prefix = STRBUF_INIT;
> +		char *cwd = NULL;
> +
> +		/*
> +		 * We don't ever produce a relative path if prefix is NULL,
> +		 * so set the prefix to the current directory so that we can
> +		 * produce a relative path whenever possible.
> +		 */
> +		if (!prefix)
> +			prefix = cwd = xgetcwd();

This is what was done in the original "print_path()" upfront, with
a similar comment to explay why this happens.  Looking good.  Also
we no longer call xgetcwd() when we do not need to, which is goodd.

> +		if (!is_absolute_path(path)) {
> +			strbuf_realpath_forgiving(&real_path, path, 1);
> +			path = real_path.buf;
> +		}
> +		if (!is_absolute_path(prefix)) {
> +			strbuf_realpath_forgiving(&real_prefix, prefix, 1);
> +			prefix = real_prefix.buf;
> +		}

There used to be a comment explaining why we make realpath calls,
which is now lost.  Perhaps what the comment said was so obvious
that we are better off without it?  I offhand do not know.

What is done to make the paths real is the same as before, which is
good.

> +		strbuf_addstr(dest, relative_path(path, prefix, &relative_buf));
> +
> +		strbuf_release(&relative_buf);
> +		strbuf_release(&real_path);
> +		strbuf_release(&real_prefix);
> +		free(cwd);
> +		break;
> +	}

OK.

> +	case PATH_FORMAT_RELATIVE_IF_SHARED: {
> +		struct strbuf relative_buf = STRBUF_INIT;
> +
> +		/*
> +		 * If we're using RELATIVE_IF_SHARED mode, then we want an
> +		 * absolute path unless the two share a common prefix, so don't
> +		 * default the prefix to the current working directory. Doing so
> +		 * would cause a relative path to always be produced if possible.
> +		 */
> +		strbuf_addstr(dest, relative_path(path, prefix, &relative_buf));
> +		strbuf_release(&relative_buf);
> +		break;
> +	}

Identical to the original, which is good.

> +
> +	case PATH_FORMAT_CANONICAL: {
> +		struct strbuf canonical_buf = STRBUF_INIT;
> +
> +		strbuf_realpath_forgiving(&canonical_buf, path, 1);
> +		strbuf_addbuf(dest, &canonical_buf);
> +
> +		strbuf_release(&canonical_buf);
> +		break;
> +	}
> +
> +	default:
> +		BUG("unknown path_format value %d", format);
> +	}
> +}

OK.

> +/**
> + * The formatting strategy to apply when writing a path into a buffer.
> + */
> +enum path_format {
> +	/* Output the path exactly as-is without any modifications. */
> +	PATH_FORMAT_UNMODIFIED,
> +
> +	/* Output a path relative to the provided directory prefix. */
> +	PATH_FORMAT_RELATIVE,
> +
> +	/* Output a relative path only if the path shares a root with the prefix. */
> +	PATH_FORMAT_RELATIVE_IF_SHARED,
> +
> +	/* Output a fully resolved, absolute canonical path. */
> +	PATH_FORMAT_CANONICAL
> +};
> +
> +/**
> + * Format a path according to the specified formatting strategy and append
> + * the result to the given strbuf.
> + *
> + * `dest`   : The string buffer to append the formatted path to.
> + * `path`   : The path string that needs to be formatted.
> + * `prefix` : The directory prefix to calculate relative offsets against.
> + * Pass NULL to default to the current working directory where applicable.
> + * `format` : The formatting behavior rule to execute.
> + */
> +void append_formatted_path(struct strbuf *dest, const char *path,
> +			   const char *prefix, enum path_format format);
> +

It is slightly unsatisfying that this function is defined to
"append" to any existing value in the dest strbuf, rather than
storing the result in the dest strbuf.  The original caller
print_path() passes an empty strbuf to this helper, so it can let
strbuf_realpath_*() functions to strbuf_reset() it (e.g.,
abspath.c:get_root_part() called by strbuf_realpath_1(), wihch in
turn is called by strbuf_realpath() and strbuf_realpath_forgiving())
it freely, which means that use of temporary strbuf like
canonical_buf only to copy it out to dest is wasteful and unneeded.
But other callers we will have for this helper later may want to
append to what they already have, so perhaps it is OK (on the other
hand, we could say that preserving and appending is what these
callers can do themselves).

Otherwise, looking good as a no-op bug-to-bug compatible rewrite,
with a slight optimization (to skip xgetcwd()).

Thanks.
