Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96015B135
	for <git@vger.kernel.org>; Mon, 27 Jan 2025 07:26:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737962782; cv=none; b=ktcECuh4q3SbLsTtkIPP/pfuYqgz3loIHUCSwDfcuuh1oSnkZ9et/dTb60Cl1RBi8GaACjAs7zbZlKEwR8EoiNshY5W5U44EFDQPHP3F/Zm14dnUi9/fIdZkSvqFZAi5Y36QkOsLA9heH8iAzVI5ZdtxxVhTDST7j0kKqlzxHSY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737962782; c=relaxed/simple;
	bh=RmSEn1rZwQZRv/9CIYFqDVBpqjHpOVuy6Qvseyz8WZQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=u+d7lP3ukte3HrJg23uY655fQrYfrlMN7D8I+fkLkHlWflVBDmeDvORGKrf6bZDv3UeZWL/EGTxr1a1tcFYIxe0XEhLbYXAtgbyHfOjvo2k2RKRUaZUQFQgGkn2cjZSSd+yZhgKdKJtmiCrqGOvkcbVejfKEsDk5MKISjhbsgqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=NmKDuL8k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AL5V+Kcv; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="NmKDuL8k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AL5V+Kcv"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 94C561140188;
	Mon, 27 Jan 2025 02:26:18 -0500 (EST)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Mon, 27 Jan 2025 02:26:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1737962778;
	 x=1738049178; bh=VXRvoRiRwRNfqcWWkv1urwEyiuhmgW2HLy5XCUOF02Y=; b=
	NmKDuL8kbSqV7w9PYlTUBg+tlNCZMI5LDFsKDeXXa6MBR1E3Rsdne94nkpsDVlpC
	E/uPj43a8bXQf2+qizffyNAUlwcfrywuHtmODoVYCvuOiYb0XV00+wpNVhV3vnCg
	yRBtcLm53ee69ljldbQwwywaxPifMjfuOtTapLQPIsBm37efR6cXeBuCnXb0Fz5W
	4tB1ofWZ6DMSQyhNZFqjJyPkve5CVpqcA3+cp8VBp7mAXp4Kyjj8TJ2G8cSiDEsR
	I+zuSEHn1iT/Q+L97vouk8JvnTnEjkg+xHFwfSbzICjYtGlwDq3MfEXsBiZEJYr6
	oMHxbbMScN0ghgxlbxeXyw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737962778; x=
	1738049178; bh=VXRvoRiRwRNfqcWWkv1urwEyiuhmgW2HLy5XCUOF02Y=; b=A
	L5V+Kcvt9lV4UB1zq0ZzChLLDJko3z1D7V2idQhFyqnq8TzqTzAkuSFDVaUJ/i41
	PVQ87KCQY2xbJqib6uJ2JB8z1O+dlxMB9K2m3LfofWzhdDgG9egfRlc2V/3h9GMS
	+Wwh3W126NWusWk5Z3Myx7OUVdHQ4oBvKdI9/OczoK55N/7qqH8HO0UWr2tzbQUI
	c88GbSa5I29HJ3LajbalHrmwzxjHSgDK8o4JrjfLsJmd0E1d/KPDzXPQdqM0iO+L
	u/FOTTYA7FLFFDVLXhe75gv9KCD8wXSZWsdLoIxmrFJNfUFJxKrlv/uVNu4oXBsx
	Hibneir77LC31VAuuZFag==
X-ME-Sender: <xms:GTWXZ7Fg9ASIhbX1NFFUjbheB_YtXjdERVHz7_H9gfd7YwtcYYwnlg>
    <xme:GTWXZ4VNDpRLxldrUsLCHI9Exjs2P0ydaJ53NB74xOQJgiJM0SI1648v2zGGSasWd
    QnahsY3BSJgVE3yGw>
X-ME-Received: <xmr:GTWXZ9LXuKenKjki-OidqbYgk-p5CRzD9g8y25MK2ow8SoHqNe7GB5NqQ9aT1M1OF2q5cfWwNm6qHvzc8LNnvf29b5uZyAgxi7SxKN3EulvF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedguddvheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpeffhf
    fvvefukfhfgggtugfgjgesthekredttddtjeenucfhrhhomheprfgrthhrihgtkhcuufht
    vghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnhepvdefje
    eitdetleehieetkeevfedtfedvheekvdevteffvdevveejjeelgeetvdfgnecuvehluhhs
    thgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkhhsrdhimh
    dpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheptggr
    phhighdotghqgeelhhgutggpkeepmhhrhhhhjhguthhnhigpkhhqoheifihgiehnrhelke
    hrshgsnhgphiigmhgsrhhqiehkrgesmhgrihhlrdhgmhgrihhlrdgtohhmpdhrtghpthht
    ohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomhdprhgtphhtthhopehsohgvkhhklhgvsehfrhgvvghnvg
    htrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:GTWXZ5H8FdKUovKRKpJBdjnMulRnWM5-wsy2CacwwYBzUlXGpG5R0Q>
    <xmx:GTWXZxWUNgRvxryi9oqq-SZmoVM4YPLjpHBuRC2bYI145ghcCTt-kg>
    <xmx:GTWXZ0OHig4j518_pENv6REkMIAmGhziNYpGFMkxZlVczyzhq4ZPwA>
    <xmx:GTWXZw1b4-SmyvE61yXXU6rgG2TlFSgHe69gt64D5eWypXI71do6_g>
    <xmx:GjWXZzJUbwbY2NbXi1nSDdIJWM_1ORZ-TeHEcmRSqMMAJl97Nw7YYGb1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 27 Jan 2025 02:26:16 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 8ebe8877 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 27 Jan 2025 07:26:13 +0000 (UTC)
Date: Mon, 27 Jan 2025 08:26:08 +0100
From: Patrick Steinhardt <ps@pks.im>
To: CAPig+cQ49Hdc_8=mRhhJDTny_Kqo6Wg6Nr98rsBN_YXmBrQ6kA@mail.gmail.com
Cc: git@vger.kernel.org, gitster@pobox.com, phillip.wood123@gmail.com,
	sunshine@sunshineco.com,
	=?utf-8?B?U8O2cmVu?= Krecker <soekkle@freenet.de>
Subject: Re: [PATCH v3 1/4] add-patch: Fix type conversion warnings from msvc
Message-ID: <Z5c1EIXi7nsB2kJe@pks.im>
References: <20250126125638.3089-1-soekkle@freenet.de>
 <20250126125638.3089-2-soekkle@freenet.de>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20250126125638.3089-2-soekkle@freenet.de>

Note: the word after the subject's subsystem should start with a
lower-case letter.

On Sun, Jan 26, 2025 at 01:56:35PM +0100, Sören Krecker wrote:
> Fix some compiler warnings from msvc in add-patch.c for value truncation
> form 64 bit to 32 bit integers. Change unsigned long to size_t for
> correct variable size on linux and windows.
> Add macro str_to_size_t for converting a string to size_t.

There shouldn't be a need for this macro, we already have `strtoumax()`.
And in case the platform doesn't provide it we know to provide our own
implementation.

> Test if convertion fails with over or underflow.

s/convertion/conversion/

> diff --git a/add-patch.c b/add-patch.c
> index 95c67d8c80..4fb6ae2c4b 100644
> --- a/add-patch.c
> +++ b/add-patch.c
> @@ -322,11 +322,12 @@ static void setup_child_process(struct add_p_state *s,
>  }
>  
>  static int parse_range(const char **p,
> -		       unsigned long *offset, unsigned long *count)
> +		       size_t *offset, size_t *count)
>  {
>  	char *pend;
> -
> -	*offset = strtoul(*p, &pend, 10);
> +	*offset = str_to_size_t(*p, &pend, 10);
> +	if (errno == ERANGE)
> +		return error(_("Number is too large for this field"));

Error messages should start with a lower-case letter.

>  	if (pend == *p)
>  		return -1;
>  	if (*pend != ',') {
> @@ -334,7 +335,9 @@ static int parse_range(const char **p,
>  		*p = pend;
>  		return 0;
>  	}
> -	*count = strtoul(pend + 1, (char **)p, 10);
> +	*count = str_to_size_t(pend + 1, (char **)p, 10);
> +	if (errno == ERANGE)
> +		return error(_("Number is too large for this field"));

Here, too.

> @@ -1066,11 +1071,13 @@ static int split_hunk(struct add_p_state *s, struct file_diff *file_diff,
>  
>  	/* last hunk simply gets the rest */
>  	if (header->old_offset != remaining.old_offset)
> -		BUG("miscounted old_offset: %lu != %lu",
> -		    header->old_offset, remaining.old_offset);
> +		BUG("miscounted old_offset: %"PRIuMAX" != %"PRIuMAX,
> +		    (uintmax_t)header->old_offset,
> +		    (uintmax_t)remaining.old_offset);
>  	if (header->new_offset != remaining.new_offset)
> -		BUG("miscounted new_offset: %lu != %lu",
> -		    header->new_offset, remaining.new_offset);
> +		BUG("miscounted new_offset: %"PRIuMAX" != %"PRIuMAX,
> +		    (uintmax_t)header->new_offset,
> +		    (uintmax_t)remaining.new_offset);
>  	header->old_count = remaining.old_count;
>  	header->new_count = remaining.new_count;
>  	hunk->end = end;

I feel like most of the changes are adapting formatting directives like
this. Might be worthwhile to separate into a standalone commit. That'd
also allow the commit message to read less like a list of bullet points
and provide more context, explaining the actual change.

> diff --git a/gettext.h b/gettext.h
> index 484cafa562..d36f5a7ade 100644
> --- a/gettext.h
> +++ b/gettext.h
> @@ -53,7 +53,7 @@ static inline FORMAT_PRESERVING(1) const char *_(const char *msgid)
>  }
>  
>  static inline FORMAT_PRESERVING(1) FORMAT_PRESERVING(2)
> -const char *Q_(const char *msgid, const char *plu, unsigned long n)
> +const char *Q_(const char *msgid, const char *plu, size_t n)
>  {
>  	if (!git_gettext_enabled)
>  		return n == 1 ? msgid : plu;

This change feels completely unrelated to all the other changes. It
would probably warrant a new commit.

> diff --git a/git-compat-util.h b/git-compat-util.h
> index e283c46c6f..bb9a6c2bc4 100644
> --- a/git-compat-util.h
> +++ b/git-compat-util.h
> @@ -292,6 +292,13 @@ static inline int _have_unix_sockets(void)
>  #include <sys/sysctl.h>
>  #endif
>  
> +#if SIZE_MAX == ULONG_MAX
> +#define str_to_size_t strtoul
> +#else
> +#define str_to_size_t strtoull
> +#endif

Hm. A couple of comments:

  - The function name doesn't match the schema of function names we
    already have. I would rather have expected it to be called something
    like `strtouz()` or something like that.

  - We tend to avoid using `strtoul()` and friends directly, as they are
    really hard to get right. See the implementation of `strtoul_ui()`
    for all the checks we do there.

  - The way the macro is implemented feels quite fragile.

So I'd propose to adapt the approach a bit and introduce a new function
`strtoumax_ui()`:

    static inline int strtoumax_ui(char *const *s, int base, unsigned
                                   uintmax_t max, int *result);

The implementation would mostly follow what we have in `strotul_ui()`.
The `max` parameter here could be used to control the maximum that the
caller expects -- if the parsed integer exceeds it, it would return an
error and set `ERANGE`. If we had such a helper, we can then also
reimplement `strtoul_ui()` on top of that function with a simple call to
`strtoumax_ui(s, base, UINT_MAX, result)`.

This would overall be a lot more flexible than what we currently have.

Patrick
