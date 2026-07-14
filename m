Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 192BC1E1C11
	for <git@vger.kernel.org>; Tue, 14 Jul 2026 16:40:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784047217; cv=none; b=tczyNWXX76Q0d2VnE7RDWvdvD8+/CCXRGtD0U7mNH1d05XBuAYJMufNkh0Xo7kmVifrFQmPjG9RpN1idFlJCJaoGHFwqvgLPcaoITr7iKcHOf1uuVZxX1mj1M0EfiT1bS99j6PsA8bHOi5AzVJkeu3Sa9jVwaTQ8DPBiolIlrSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784047217; c=relaxed/simple;
	bh=LM2s7j3nM1MkPtnScNkWD5ZHSjBy6izqWJynxZUrFCo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QCWhThLi6MP10paFElRGvMN+8PHv4Hoz/evGZFfrVdUdntJqItfdE3QTXUbYx6q8qWhghg3aph7Uyb9fqaxq+WCT8Pw/Eyc4hDNC5L6eNQ5CJCeUxBNtcnyf2oSPE5S4FTmG0Zh2xqOFCkWaokQNs+gstKmAExZkaHytH51HwbE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=l7A1Y7OT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Asqhqlej; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="l7A1Y7OT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Asqhqlej"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 3806E1400155;
	Tue, 14 Jul 2026 12:40:14 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 14 Jul 2026 12:40:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784047214;
	 x=1784133614; bh=LOT0TNd2tQ4AJkWVNX6DJlVd/jEL14nQjfKt6DXA+PQ=; b=
	l7A1Y7OTasgcj0vZc+5rvsbsQkoCOsAtoxXxw0jHIicqD12qoFg64ZIcpaKvznyR
	Xn3vcBsCvzrH0cXrGgvdmvyIR+9G9DCRnDu7MROgHVArVl750v08Pii2CP5hc2yf
	WzYn9FDKpT4h9vgHJASuMGLEPfK8N74JPG9zCnSWqiqpVq3wbA8ayikpubFvXPN+
	EHKxhTBAUQrBzrm3AtiThpZKMiAi6xRWm061TZ6W/d5kR9hjT+7RCM/5QHaPxsAz
	FefJSga1YSOL2mitD2ngkIrKR+SZ34/39d/YFqR3adeRldNzAu6IywRewzpAgk4M
	JjTTisG/7DyyYeip2dnpYQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784047214; x=
	1784133614; bh=LOT0TNd2tQ4AJkWVNX6DJlVd/jEL14nQjfKt6DXA+PQ=; b=A
	sqhqlejpIwHbiioL2lV/zEfYZqYJPr1Y/mrMpGElLhaEKaIRuvCwNI10jS7df2LN
	umPteI0ZXzRjmT6B2OSLAu+tisWsDXzlKFkpvsFNm4n2Lwd62I4WnsI8nZ0vouJG
	X2+nI40G8OIC+rCHVPw47q0qqsngvFDSsVHmYBMlST4/pklePaXb0MrAJl1RmRU6
	6dI4trh/svVx/Tq0Vc0sOWlS5mXoDCKp4R9faGQY9cgNCRfAjBd+9TaeuFQ+8bq1
	A7XnG1LNz9W4Z4pL5tCxppGDRH1J8yKtOUlGQj5j/qN3QcJN5NYYwC8iuvEtB8hF
	2BUuf6Tn23MeCXAig40bw==
X-ME-Sender: <xms:bmZWaniZF0vDbYTFGH39pJUgrrf_OcmPfhA_2gOLJX14ShV_cb-qBg>
    <xme:bmZWarcfYGkDnhQUloVDyUl1GrRP6P7N1IT5XsghpvBMXIzxsGvRHLACFg0GG-NhR
    f_FwpGWAuGs1SDH5fqnDSn94qU-VnPJYksTmkvJFx2-MnmkvXVYVVY>
X-ME-Received: <xmr:bmZWakfznV2iTF11tlMZsXvv8AOap_a2LW_VnFNVlM5RiZDC9IjVRxoSzhVpN33d-D5oU2PkJygGK-CZLoLTsSZ5wZdeUISs9K7gMYw>
X-ME-Proxy-Cause: dmFkZTGB/RMgzkzWsPR/8kxuBhRn9aoUrgVjqB1CG9mAahKsw0Kz2gPTOxANQj7f3GsOKG
    ZOKDBrKZNuFD+MA6kqqDNIeFwFjumXrOE6z3JXbCzYYzkooNOBN7ErEVhJtm6WhItunVkY
    6I4ibfSfZV4oH1TFGaZvF7AKKoko/imMB8j2mtDqCUUiqAiB6wXu5N1KvXDHdJHAKuiEuP
    J5Khnz5nQIlxP4MPHoiHK6voVWcmd5AlBSee/1wgc3nQyAD6pvJ8suKNFnkRMBjgiQK86p
    TAflPhXmj5HO+cGgbm8E8aKTSC5f5NrkLUALwDT3N+CCUO769IY8YYvCGL3R5P5o5I+Dnj
    DjRs45TDR+6u3JuALILurgtheiwgzKiuQ2Wk5Mdtt8bb9uzZPfw+t42kZlwFbpkGzQkIWl
    Jn2oej624PfNwXaF3nm8Ag5gbQ8dkRb9POlVat50aqTd2n5Ldl+llA8h9YIVZWljB1oA1q
    wdTSrA8OvHHzavnqSfUca4jH+iVTSHP6VKhKIBNyleohO7D2FDhTQE/MhZ6tpaGiLaQrq2
    rfoVYaNbOIJM0vOf4WkfFdQJc8ONr3MUTkosH1E0v2OBwVKBtowbz45BVDbL7i24zRVP7Q
    P6VQEZhbGqC5dm8XYxedJjYAilLL133HwR6EH6lZ7kmFlZl4u55stCHli2fg
X-ME-Proxy: <xmx:bmZWat_iEIXG5xwPser-xrMZ61eaSoLaMY5KJCzynzAZ3MOp0NvuMQ>
    <xmx:bmZWaolu-sW-CpNN-lMKuE0PyUiSd_Dd_nijPt7tt8oM0_jkngVIiw>
    <xmx:bmZWan-nzQntYShRmIg6XEmhBcdXxC89OjOnLITEZ5qYKtcwz04Wlw>
    <xmx:bmZWaul08-lCjC0ZXOfBmBeM0_BDWJDGbMvUgDmOWuYyU581xh4W2w>
    <xmx:bmZWamG3RNEvYgRPYKLjqoa-dK9cCDncWCxrKvk9j3dsgIb-HLJ17MaH>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Jul 2026 12:40:13 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH] strbuf: avoid redundant reset in strbuf_getwholeline()
In-Reply-To: <d4ffe7fb-f782-4f06-9e3b-f72729d1e225@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 14 Jul 2026 10:45:59 +0200")
References: <d4ffe7fb-f782-4f06-9e3b-f72729d1e225@web.de>
Date: Tue, 14 Jul 2026 09:40:12 -0700
Message-ID: <xmqq8q7dv82b.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> The HAVE_GETDELIM variant of strbuf_getwholeline() calls strbuf_reset()
> on the strbuf before handing it over to getdelim(3).  This is
> unnecessary:
>
>   - getdelim(3) doesn't care whether the old buffer contents is
>     NUL-terminated and has no access to ->len,
>   - on success getdelim(3) NUL-terminates the buffer and we set ->len,
>   - on error we either call strbuf_init() or strbuf_reset().
>
> Remove the superfluous preparatory call.
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
>  strbuf.c | 2 --
>  1 file changed, 2 deletions(-)
>
> diff --git a/strbuf.c b/strbuf.c
> index 764b629927..44955669e8 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -646,8 +646,6 @@ int strbuf_getwholeline(struct strbuf *sb, FILE *fp, int term)
>  	if (feof(fp))
>  		return EOF;
>  
> -	strbuf_reset(sb);
> -

This is well explained and makes perfect sense.

Thanks.  Will apply and mark for 'next'.

>  	/* Translate slopbuf to NULL, as we cannot call realloc on it */
>  	if (!sb->alloc)
>  		sb->buf = NULL;
