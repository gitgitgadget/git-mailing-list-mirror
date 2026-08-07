Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 467F64028D9
	for <git@vger.kernel.org>; Fri,  7 Aug 2026 22:06:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140371; cv=none; b=IZW0M0OhMCb49VS3LaSb2AZHM3q+Gts4RtcS87MMyxMFLGlRl6P9pVlcciDWz0CNQApquXnLufPY44OozX+gL8Iul7Vg6ou+Fv6MkEI43BLgBKqsxntoKO9Ohrwc9ZrwLeT390QIl5Ll+B7R+myQ9egcTN4imVpKhL4Jn+hgIj8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140371; c=relaxed/simple;
	bh=PNSasQl1sQiKO8FT9Lv+13Ju7DY4gGUbG5u5UJo6WwA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OntWp7+iAlzzjgChWX3CITAbZSJcpRuvc+uShHnMe274O5yZIOpkpPDTtbacUVOfkg/DSZC8Wd+aSNOEA9nP5W2ocpYrw+tW+jpzrJgjT5MJDFGFh+n9xyi1puD4w/GjaWdK8EOea2DdGzzjxydsh2w8bHQdUvZF0Q60MbKxfYs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uZPQN/Kq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iFYxxuq3; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uZPQN/Kq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iFYxxuq3"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2E4AB7A0132;
	Fri,  7 Aug 2026 18:06:09 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-09.internal (MEProxy); Fri, 07 Aug 2026 18:06:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1786140369; x=1786226769; bh=q8uFqbYUZt
	87yX+JrxbTx88C61OyGFuyeWBzgg8s4TM=; b=uZPQN/Kq9fL0c9Fkm6aGbRzOav
	4RP49A9vo3TgsmdQW/0CQBE/bJ6pxMuTDAJR+i1kQg/3m7ObXyK9THcW4iPNaZih
	gx/SsJAz4zOXkIaIMpx1Q4AiLFhk4U2/UuPagwellSiiSNnDzW02fn9mN2LlRVYm
	oh08Z7ojO5ESfZe4EH2SSXbGNyEnBM5gjrf9mcMiUt1KlbyPIoIV1TY/Gr8bNUMe
	LT1dmxD2+xqkaw63qUa6M/DvY23A56ViACDtCi/su/y4tM5semHcI2Pb8qUv/790
	nJghtJOu80gaB2LAdQnpkhLi55cVg3/VIqvC4ShiT/4rL2y19+IjfX0cJgVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1786140369; x=1786226769; bh=q8uFqbYUZt87yX+JrxbTx88C61OyGFuyeWB
	zgg8s4TM=; b=iFYxxuq37Atbk/E5MvuYslk5xEVxCBWXQuXfKuR3Vgm5yEZt/CT
	buLdLaVZlywc99K2ET0vRwKK/VJtB+6fOoiYZ2hmF/tkKAZHKW9/a7WXBb11dHIK
	mo97hF9/bGBsKZre9cEYfu3LS/4uXgbjEUYFCnkwimj88noozgjLO8ihK0tafKyF
	fSLs9MIniOqZYVmmi4ZjVeV0+4aehRz4i2QSYpfqzBfHCgBGnrfvoXvShTwdySiY
	1Qsyfz9vgRk/UOKu7nZUZ3wVW6GUnouNVP+vi2Q+bhwOzu7ZTiNExkaoCpPLIwNG
	ni1iIDBoZesFlAYx6qRnpSQBpJKiPI3rjBg==
X-ME-Sender: <xms:0FZ2atmxHpqrjW1cKo8wq0RyD8MJOYyNhdDdFZYFEwK5CzaL086trg>
    <xme:0FZ2avuVE3CzptWx4FPVI2BZYK1PTZf6WKdBh5sVvYyD0h2tuqMu4UGDD26nS4mOg
    KBlAgye6ZtPBTK266GhDMCa1fS9F3WErDiwJ2f80mnA0kJpoNo>
X-ME-Received: <xmr:0FZ2ar_wjOEto2fmSEvGFkhoHF-mNGb_7LSzZ22FCrq6Q0lQ75r5jJIbqoycUXWgzvLLlhJWW_iYblbW9ITC7KPq1WOngqbpqA>
X-ME-Proxy-Cause: dmFkZTGm9Jn3/pg6ktlhelBumMwxIwJhuXfY78GBBm7kwQvMoLOiDrk7X+Eh2pZOjROiIy
    Z6EqxhxfFZ7/r8FMGExZa+6loT7koOcNjXFjBU6oVJiJUwhWpkRDm3gc3bRKQDvlbmu5lo
    9oOcNf9nJk43/j9WRptDescE5DgTDi+v2Mx2mNXDRzMsxRWostMD106DgLwaQWdcpUSTZj
    sEwAbhmLcdWYJ1o/Jg4ouCSPRFfFYjpkAmQk94YR0krj5ggxZGGkFUdFXXl3w1poe1iZSE
    me8y+bRljhp4JAIWb1gSimWJ8qJndYyi2FwnmfD3n+1auXfLCIp3ulU1bNxW7oa208f3cf
    xeE0YHSiJIhYi90LkQ+RXKDHLoRsAgDpxBrXQlJU3adwFiNOFsqlnl4gSOtR7zRlsIZAdX
    eKaPkOg0IxxxSoQmWV5fpP1m93Cu0VHuskqRYmeuxR3nCnSEwypnJiFdIt/dE9hizj2cAw
    8ktYE6A6iyKv96g9JkLqYvf61WlqzooegO2Bv446FAyWxXQCndZ5weXNHBwv29b+VMG7cX
    Gco+ubCNqYxoQ46srftcKyMGDCGfHV0xCcOqKOWoxBExkEqmqeu/hEa+TGpb7MFIc+7Dmy
    WZ//NNSzjWsCByr9QsVcREdYqK8dbidmTnzDiu/G9xvy3OpewqBkpR468R4g
X-ME-Proxy: <xmx:0FZ2apNFA8FqqkaWLzqChP8p6szW9nt2b0AuiPPGt0tKt9v-n6zVyg>
    <xmx:0FZ2apFugPGkHxoiGuv1eCV6Lk_yN8sFh3ihga02SBOwKz9dyreAtA>
    <xmx:0FZ2anSzrebKnsrUo0G6L2EAIn6MBbiIifIdzWYDXRCVAH8TQWlwFA>
    <xmx:0FZ2amvoWKSS6vdQevkKSQNVZ90J32xuvwsnb7lb9Va_AnIFPpj0WA>
    <xmx:0VZ2aojivCUBo42mR5FSuMxpy6Rm45i67J-1MsxtzvxhTwp7s-T0EtiZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Aug 2026 18:06:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Johannes
 Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v2 07/12] packfile, git-zlib: widen `use_pack()` and
 zstream avail fields to `size_t`
In-Reply-To: <ca928b457959ab8bfa643c65f83ca1ec4289fdd3.1785946479.git.gitgitgadget@gmail.com>
	(Johannes Schindelin via GitGitGadget's message of "Wed, 05 Aug 2026
	16:14:34 +0000")
References: <pull.2175.git.1783615780.gitgitgadget@gmail.com>
	<pull.2175.v2.git.1785946479.gitgitgadget@gmail.com>
	<ca928b457959ab8bfa643c65f83ca1ec4289fdd3.1785946479.git.gitgitgadget@gmail.com>
User-Agent: Gnus/5.13 (Gnus v5.13)
Date: Fri, 07 Aug 2026 15:06:07 -0700
Message-ID: <xmqqcxvtd1rk.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

[jc: Sorry, I hit <SEND> before I was ready]

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> diff --git a/git-zlib.h b/git-zlib.h
> index 44380e8ad3..0b24b15bd0 100644
> --- a/git-zlib.h
> +++ b/git-zlib.h
> @@ -5,8 +5,8 @@
>  
>  typedef struct git_zstream {
>  	struct z_stream_s z;
> -	unsigned long avail_in;
> -	unsigned long avail_out;
> +	size_t avail_in;
> +	size_t avail_out;
>  	size_t total_in;
>  	size_t total_out;
>  	unsigned char *next_in;

We use 'size_t', which means we can use a buffer larger than 4 GB
on systems where 'size_t' is wider than a 32-bit 'unsigned long'.
But these represent the size of a single contiguous buffer, so
I think that is why the log message mentioned that this is more
about type consistency than being able to handle larger data, as
I do not think anyone would reasonably feed a contiguous buffer
larger than 4 GB in one go in practice.  For that reason, two
details stood out to me:

 - zlib_buf_cap() still returns 'unsigned long', and
   zlib_pre_call() feeds these potentially wider values to it.
   Is it possible that we trigger truncation before 'avail_in'
   or 'avail_out' is compared with 'ZLIB_BUF_MAX' in
   zlib_buf_cap()?

 - unpack_object_header_buffer() still takes an 'unsigned long'
   length, while oe_get_size_slow() in 'builtin/pack-objects.c'
   passes a 'size_t' 'avail' to it.  This comes from use_pack(),
   so it is a relatively small value stored in a wider 'size_t',
   but I am unsure whether your static checker would flag this for
   potential truncation.

They are probably harmless in practice, but they are still a bit
concerning from the standpoint of type consistency.
