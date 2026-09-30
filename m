Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28A9450C287
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 15:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790782404; cv=none; b=CFDamGr2qKU1uk81bqGx/RUME4YS1M4mL/m62C5XiL5mmZ/quKOVy3njJ4uGmBalWo26FXvhLHhJ8hooqzZXCiYyoCqrXKA78HO7NCXl+eIZ27c1o3+m78AterXnUIX6X09rJA8dnE5lsn8qDj2ZlD4BJeobgi7N4AUmkvkG9Wg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790782404; c=relaxed/simple;
	bh=VxOx+YfXuYRzOptokgh6fEC2FG8TIiJHCh22dw08Jyw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KN7BMX4Xb2fdQSkGAYjRhw2oh21Uya0y7CrpdLPyFF8z6lb14jd6cZr2yMSdHYZrLHtBXSuUKr+tuIruV+OP1s60jp4hj+qHRM7r4TctLCivpiuloAhGHsc6fW1Yg8lYu2MgRuyBF+VaYvI3MRrxfAvewFwz72+3ZzW3XYrVyZw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GZVxHMmj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FPhM9AQa; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GZVxHMmj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FPhM9AQa"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4FC38EC02DA;
	Wed, 30 Sep 2026 11:33:04 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-06.internal (MEProxy); Wed, 30 Sep 2026 11:33:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1790782384; x=1790868784; bh=fJrqg/hjNA
	R93+GJVTVODwrzxUY9YjAl43UhMOUzTzc=; b=GZVxHMmj/d1gMjEbjVuWmlkKKt
	isPn3jbD+By0+R+XVPipcFpdc13KObA/QOsn72qDLhtDVjCXOEsJeNJNLd3AuMLn
	ZT4b78ZNa00ZvxzgqdpcMK28mBPLhHHyDEkbogyezQt2ylKpTpbuUXMPGt+SF2lw
	uXAhrXZx3L4TwP+Vep8+4wy9JTUv3KqHpp8GmbgqJAOS7tPRvX7/EnSerpHo53Dq
	MOH92oFP2E34gVPb8vBswWmeHom92XpU7NWoZTbdmmzHSYfybhVQoKaNbR45mOsj
	SqlbL2kLyAtX/o0ltaPmVRgk0VMj9YBT1Kl7AOOMrEsTsGDGbo6pzQ3Xf9Fw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790782384; x=1790868784; bh=fJrqg/hjNAR93+GJVTVODwrzxUY9YjAl43U
	hMOUzTzc=; b=FPhM9AQaIplcZKCXgx+085yI02XW24ZInOixznljfW929dE8vJ2
	QZwDKWqoPXqnaEB1QVbFpsFgdB5DXdJOfSdlnomnZe7VUTHPwJa8u+XBvdhZMyQz
	q8ZsY9zet7AJY0GPScb/dRHPakZEciIKrhXm9Osg7IBH4Pkn12DWlpi4Cwleckx4
	LcJ7GAF9qxkzqHME7vPvo6BIgd9IgisqFte+i26Z6rw1q01u215h9vOjM1WLeRra
	Uthl3mB/AnR42fwyNPK2saU+APe/T11l/L3e916EI+xCjzz7xqxxHKRnj0oDWX6V
	f7pZW+EhbyQeu+el7Usu0GSCckukNjp1ovw==
X-ME-Sender: <xms:sCu9arPCLKH5sjSkexBQTQVX4Z0scJRgKppkNpIPN9RpqV8P98AqvA>
    <xme:sCu9atav0T8peQD-Wll5HchIDSAfr6P7aq3IU9Nh2FlynhqE1vspOuji9tJn5hvGr
    e4CuLAl6NvxV6E-SREESJnQcyb0Ig5L-nMs72HVNkwenTYlpv1tvXM>
X-ME-Received: <xmr:sCu9anoqCHKdU7UCNYHgvPRnQj8PIIe4wG9uA0hwU0gemjM87SWyYA>
X-ME-Proxy-Cause: dmFkZTGa8Y2Qcg/BV/xbMY2HiAErV9l9soJz6ZsrijsSNi+3ggOx2QCtQAXEL4JL8tpsvZ
    jqoyJ/2K6+4XijuLEeHkfLr5GrqiVReZaCkpcbT+W83O4eEEWM7LqKA9BTcH0nHB0luYih
    KK5Evl4id9bLYGidVoYO0+3Ip2nQQl7bg0sha32MViSQiIWluS/+81CChnnNpqsBM3hUqx
    Nalbk9W19myc2gpAvAtCvb7LcZdWgvuTN4ocOPswN2vX6b+BCsQ6wduT4YKr7ihysCMItH
    93yYIian88My0Neiv/H4g7ANZTHFJ6r2UcRkftXWmHK0h7QfRLU8Bo6biVe5ez6zah2dh2
    06YhG86ZRxhbpcDjy3kpjeqfaMNxInsQD/sj7XSQjCqZkQ4YMvMoM4oEcJtf4qVTI2lDsg
    oTm0Zup8/bQknJ91/Da5QBL3gpTGRbD7iaZuMkZUCHDFxv/89iaAQp0zNTKEdt/qHcVG7w
    SRz/iSCKhD0+W4O9uxYY3TAHtt5A8S5oqXvsxYSTw52+WvrBQCqvTw2ZSAy+T35M1n03CO
    PZSd98MrvvV16xXUgQLyZIhbJ0yrE2+fQvpRN2mrIuNLpGHL4jLNkAGx4bUn5hjd79H1L3
    QkaqWW+NvZjcn/qIyUdo9HfwfLa/WJMxWa93lxha709u1y8DDTqVpczRCcqw
X-ME-Proxy: <xmx:sCu9apY15sDAr4U6Ny7hdhWoUPYWZLkmU4_2Vo0YXZhrGbAwtBrzSg>
    <xmx:sCu9anQQ09qKjIgrIs4byGaaQY1btl0VcjesAzRk1HKYE8rv68h4-w>
    <xmx:sCu9ao66J5rrBe2ZcoqguMdTDEG4nMl0vhLgi9n9LruakO3P1XAYAw>
    <xmx:sCu9akwMQeF0EKX7McG5JJ4lmwUyXew2uK988NT8NyojDQ3tIozr4Q>
    <xmx:sCu9ahG3D-L1G8MkhyWheh_71FVm4-t5LleLlZup2h0CCp9cW8PhP5FU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 11:33:03 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id cf50edc7 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 30 Sep 2026 15:33:03 +0000 (UTC)
Date: Wed, 30 Sep 2026 17:33:01 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org, Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 4/5] merge-ll: use read_mmfile() to read external merge
 results
Message-ID: <ar0rrVE0ZxcU7uG-@pks.im>
References: <20260929064935.GA1276867@coredump.intra.peff.net>
 <20260929065442.GD1697497@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260929065442.GD1697497@coredump.intra.peff.net>

On Tue, Sep 29, 2026 at 02:54:42AM -0400, Jeff King wrote:
> diff --git a/merge-ll.c b/merge-ll.c
> index dfed6411a8..7fab7c5438 100644
> --- a/merge-ll.c
> +++ b/merge-ll.c
> @@ -241,20 +240,10 @@ static enum ll_merge_result ll_ext_merge(const struct ll_merge_driver *fn,
>  	child.use_shell = 1;
>  	strvec_push(&child.args, cmd.buf);
>  	status = run_command(&child);
> -	fd = open(temp[1], O_RDONLY);
> -	if (fd < 0)
> -		goto bad;
> -	if (fstat(fd, &st))
> -		goto close_bad;
> -	result->size = st.st_size;
> -	result->ptr = xmallocz(result->size);

So we do lose the NUL-termination that `xmallocz()` gave us, as
`read_mmfile()` doesn't do that. You reinstate that in the last patch
though, which makes me lean more into the direction of having that last
optional patch. If so though, we may want to reorder it to come first.

> -	if (read_in_full(fd, result->ptr, result->size) != result->size) {
> -		FREE_AND_NULL(result->ptr);
> -		result->size = 0;
> -	}
> - close_bad:
> -	close(fd);
> - bad:
> +
> +	/* We can ignore errors; result is left NULL/0 in that case. */
> +	read_mmfile(result, temp[1]);

One change in behaviour that wasn't called out is that this will now
make us write an error message in case we failed reading the file. That
could be a good change, but that's hard to say.

Patrick
