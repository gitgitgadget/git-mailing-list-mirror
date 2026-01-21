Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95F7347AF73
	for <git@vger.kernel.org>; Wed, 21 Jan 2026 09:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768988001; cv=none; b=F5z5y7YaWa2kh0zMmyq4ih5MDl4+Giuf+gtJox2Zqe2qq4OkKOHRzJFUw3X38MQzJ4/DPzFKs7abDqjXIBTgpBBimSQ0JLgv3p0JFcqqYop3ZOmSBPyVCFt6SzHGdcRa+aE7fkwtxHB0IrQABmTX+xnePf5evDorPmVHjqZkJe8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768988001; c=relaxed/simple;
	bh=x1iNMNP4ixsZNegOgDPG6hT7zkcY+8Fv9pcfkr1FMJQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=pWBXzzT7KnIVE/LKbpZrw3LEQXfV52f9W/ym8DlnxAQMVloCaCIY+2HIXpH4M+z05FzZyztTCVPZtEFGhHCuLPmHYlK22l/BAYE5p2pbV3oAi6H2O0EYTtz1liXlecOqtOo3+/FVEB5hAkX7UYdgytQ1uAWvo/juQo9lU2sfFWU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=c0sptFEN; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iB/YZEqS; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="c0sptFEN";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iB/YZEqS"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id B05031D000D1;
	Wed, 21 Jan 2026 04:33:17 -0500 (EST)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-05.internal (MEProxy); Wed, 21 Jan 2026 04:33:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1768987997; x=1769074397; bh=ImYnaUeDUS
	OBmZUtW0n30cw4zs2kCaITTvzzuGH3GpI=; b=c0sptFENzvkLq574wJHxa3qAn2
	e1wJSZzt4zY8uU5ycuV6lD5vv/kfAVvcWLChjE8f3xevCOqUNRkU1n6HT/wi68Lc
	QPG7m+Ww1rjBTo4UN9WgEGOpuwM057qqFyrlowIvSX1zg6WTq5V43BzXKfFigCXr
	PZ/j9uZqCyA4qKzOh3mQaS4IHrcgxkadhG/cKSL9YnU2LPIjaxkI15sXokBmj3MW
	5abl1eHYOVHFAj+cVc/VnhM2juxVepKTwhAPTqAoKGKpfoyDtkXROiBe0x0GDYQi
	arUwrIbaD9C6lWONM3oPqZZ47DX2HmWirI66GHy+minvq+MJ1lKIqropxxEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768987997; x=1769074397; bh=ImYnaUeDUSOBmZUtW0n30cw4zs2kCaITTvz
	zuGH3GpI=; b=iB/YZEqSQ4OTAKOchyzDsntC0sryBBAuR6ggVhjVo1sHjKUDR6L
	EftwHc/ffc/1vfILJR7djr2f9pAb9W4KJx3wrgTsNjwtifWh0PTprB2DbgJI/ctZ
	AP34Z+iMEKM1/Y2Ci3fj29lf7px+d2kv9oNtz2K+Wjxqe1AUxnyny+sgKKeR+Apm
	1CUHKqKbw0UwXNGQZ8FsS8wBN4kiY9zyXwKWDtza/mVuAq9oJz7TRR7jup5xrcQW
	l1T6Or3r7O7ochoupCvxNJFPYp5U5k6M9LjQP556Y8fRka7VcPIzshc/p0KuME3q
	F5L0L66ousNEZMx7Ic6lJUD98WaNYdkwWgA==
X-ME-Sender: <xms:XZ1waVtTcc-sr_hzAu5C1YopILAWJkwk0ZWvNZJjrbNCRerlYlr8xg>
    <xme:XZ1waV432pcwZd1NFfrH1_EnxfpRwG-Bkf8IU41n_fBJfIut9zv2bsW7x48PfeV9c
    FAlIU81YBYIE5-5a8etgoAEHZ8Pxetv76p-FQMM-YCMl97V2V1l>
X-ME-Received: <xmr:XZ1waWIPzniTAMfK360K1N2SCgFLpquvY9I_GLg6XhVXtt9mHhXLAnZlDhj9caKI2Itk9cb20dJvAFjrLEIpZ4p7-jOHUIQ7TUp9CLlMjz0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddugedvleefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtoheprgefvddtheduheefgeduieesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
X-ME-Proxy: <xmx:XZ1waV4csaS5bCTKTfuMWXHASG3fH-y1cTfnOnYWrn9RYcfCFvZUeg>
    <xmx:XZ1waZwD71MW3KKUEr5hfMvMkVs0eoOzy-yDICJ78zX5tI9haMTWnQ>
    <xmx:XZ1waZYyZCDaB0eyC4GsdOwy8azKPLE8AySvS7BdMwSRtydSN_QG1w>
    <xmx:XZ1wabRXN_R38YCYpomooJcip0ZlotM8WXtsKOjV5x_fUZRMMH6QYw>
    <xmx:XZ1waR6DFR5HKWNv2v7au7uz0PJQne50PuBUbJfMpReEG4k5353UerCs>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 Jan 2026 04:33:16 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 37af63db (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 21 Jan 2026 09:33:14 +0000 (UTC)
Date: Wed, 21 Jan 2026 10:33:11 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Tian Yuchen <a3205153416@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v1][RFC] symlinks: use unsigned int for flags
Message-ID: <aXCdVyySI_biFPzS@pks.im>
References: <20260120152219.398999-1-a3205153416@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260120152219.398999-1-a3205153416@gmail.com>

On Tue, Jan 20, 2026 at 11:22:19PM +0800, Tian Yuchen wrote:
> The 'flags' and 'track_flags' fields in symlinks.c are used
> strictly as a collection of bits (using bitwise operators including
> &, |, ~).

That's one important data point. The other important data point is
whether or not we ever use any negative values here. But these flags are
defined like this:

    #define FL_DIR      (1 << 0)
    #define FL_NOENT    (1 << 1)
    #define FL_SYMLINK  (1 << 2)
    #define FL_LSTATERR (1 << 3)
    #define FL_ERR      (1 << 4)
    #define FL_FULLPATH (1 << 5)

So they indeed are only ever positive.

> Using a signed integer for bitmasks may lead to undefined
> behavior with shift operations and logic errors if the MSB is touched.

Mostly a theoretical issue, but we indeed prefer to use unsigned ints
for bitsets like this.

> diff --git a/symlinks.c b/symlinks.c
> index 9cc090d42c..ed63891149 100644
> --- a/symlinks.c
> +++ b/symlinks.c
> @@ -74,11 +74,11 @@ static inline void reset_lstat_cache(struct cache_def *cache)
>   */
>  static int lstat_cache_matchlen(struct cache_def *cache,
>  				const char *name, int len,
> -				int *ret_flags, int track_flags,
> +				unsigned int *ret_flags, unsigned int track_flags,

`ret_flags` is also a combination of `FL_*` flags, so it's never
expected to be negative, either.

>  				int prefix_len_stat_func)
>  {
>  	int match_len, last_slash, last_slash_dir, previous_slash;
> -	int save_flags, ret, saved_errno = 0;
> +	unsigned int save_flags, ret, saved_errno = 0;

Changing the type of `save_flags` makes sense, but you also change the
type of `ret` and `saved_errno` to become unsigned, which does not make
sense.

> @@ -192,10 +192,10 @@ static int lstat_cache_matchlen(struct cache_def *cache,
>  	return match_len;
>  }
>  
> -static int lstat_cache(struct cache_def *cache, const char *name, int len,
> -		       int track_flags, int prefix_len_stat_func)
> +static unsigned int lstat_cache(struct cache_def *cache, const char *name, int len,
> +		       unsigned int track_flags, int prefix_len_stat_func)
>  {
> -	int flags;
> +	unsigned int flags;
>  	(void)lstat_cache_matchlen(cache, name, len, &flags, track_flags,
>  			prefix_len_stat_func);
>  	return flags;

All callers already pass unsigned flags, so that's good. But there's two
callers that use the return value of this function:

  - `threaded_has_symlink_leading_path()` uses `lstat_cache() & FL_SYMLINK`.

  - `threaded_has_dirs_only_path()` uses `lstat_cache() & FL_DIR`.

Both of these functions really only care about whether or not the
statement evaluates to a truish value. Maybe it would make sense to have
a preparatory commit where convert the return values of those functions
to be booleans?

> @@ -234,7 +234,7 @@ int check_leading_path(const char *name, int len, int warn_on_lstat_err)
>  static int threaded_check_leading_path(struct cache_def *cache, const char *name,
>  				       int len, int warn_on_lstat_err)
>  {
> -	int flags;
> +	unsigned int flags;
>  	int match_len = lstat_cache_matchlen(cache, name, len, &flags,
>  			   FL_SYMLINK|FL_NOENT|FL_DIR, USE_ONLY_LSTAT);
>  	int saved_errno = errno;

Looks good.

> diff --git a/symlinks.h b/symlinks.h
> index 7ae3d5b856..25bf04f54f 100644
> --- a/symlinks.h
> +++ b/symlinks.h
> @@ -5,8 +5,8 @@
>  
>  struct cache_def {
>  	struct strbuf path;
> -	int flags;
> -	int track_flags;
> +	unsigned int flags;
> +	unsigned int track_flags;
>  	int prefix_len_stat_func;
>  };
>  #define CACHE_DEF_INIT { \

There is only one user of `struct cache_def` outside of "symlink.c",
which is "preload-index.c". That user doesn't care about the flag
definitions though, so this conversion looks good to me.

Thanks!

Patrick
