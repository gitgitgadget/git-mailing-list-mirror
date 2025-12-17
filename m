Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A662738C665
	for <git@vger.kernel.org>; Wed, 17 Dec 2025 14:44:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765982695; cv=none; b=BDIQfTUFs6XikUDxfyxF1x+qf4d3XyGYeoqson2UVfslEJRzqZQaSeYNLJZ7qkzID2xyVrJ/VBFOJ8zM+9Bw6XnPi+UjGo0Gce8ZaO7Q8KpTMTr8OjFyetv/74geE9W2jt4Vqb13yOogowQRQFLOls+ehLpTBjdAPB6uppj1jYM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765982695; c=relaxed/simple;
	bh=O/fLz6cyDKAQ8LvasCszxxoKuiR8Wik5ea/N/rXCvzw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ydyk3K0U875Qb1LsV0aRFzqb+ZncPQSRHcBGIr3TwWTHLGkEeRP2WSwvQ9Dao0q/oSRUHeN3PLLQKZLQSFPXtnkV0OEevVQfTyjFvKiSro3CaYYwtV3+QrpsFpTLtdCeqBzlv1sbLmgVS4Kfwhq7m9EF0FJNuJZftARGeIJvw78=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fxk27+zQ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iLojyjHc; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fxk27+zQ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iLojyjHc"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 942FF14000C1;
	Wed, 17 Dec 2025 09:44:51 -0500 (EST)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Wed, 17 Dec 2025 09:44:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765982691; x=1766069091; bh=9DBfeqzn5j
	qh7WRpUhmSwxVeWE9mx0xTAVhi2dWv8TA=; b=fxk27+zQUUVhidb0LF3GE44gl4
	Vv3YVwA/IRRwrncWRgXQeGcUK5S049u+v09njFZrjP5y2s1ZmmjmfhAv/pbXqn/D
	Xbz5upXFyBzfz7Q4+ZHMacyC9COrOvgbU+ENlx6kmpyA/dT8idY41X+Rffl7UJRt
	HB48YwUOAR6LdOKgQTdi8jXkU84d151ufQhWs5PYMLfV/IJfgzYGdg0hMzPwUhIp
	94ozPaJQIBmjP1zlAz+mMC4FTEVwDBAHVtXLianNGD9nybiexceg0O43xVt8xe6p
	/iTe0QspLEHbvv3gVb0XxmyLrM40q97dmbUr+t90a36oYhFFsLaweyyIJ+lA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765982691; x=1766069091; bh=9DBfeqzn5jqh7WRpUhmSwxVeWE9mx0xTAVh
	i2dWv8TA=; b=iLojyjHcwjyoLeYaXDEGJ7npP9/M/YqjFhjcTuRp4bovKOym+Kh
	WvTlBbSj/8e/aMm+LK0qbUA4mQ0TtltI298B2p1y8jqo591suwBJ/23J5GQAyr/6
	ZMGslvczxrukI7iIEMLKmcRcXiT9uXB2ucpTvKEXYAm81k4jiNIrLVk+FzqTZ10L
	CHQoX4dfJ7JfsGGQ9HBVaQ9xm8GVNNJ956PWauBOxOyiDZVUOMMzcwEkL/GdPg4V
	e6ZkDILYFEP3mNFmkmD9QRWM+IG8H98iV9SPceiAKY3YkGGTloA+aWIPpwKVnv+4
	oPfVJTn9kql1xLnVxlrEd5R70jtDhZikvdw==
X-ME-Sender: <xms:48FCacl2OXq3zsvYLiQuoQsMmWLq-k2hYQ5lTUKpFt6dLDBr7y-ffg>
    <xme:48FCaS3qqt1MUGDM0xyv4Cmg6APfqGQxOLPoNpKGIGaTfJ52Gs1YoAcs5QuAdbQNt
    tyzaeRaopsGW-K1_Yybt4nZwlmNq1hSmsvOh5o88UQVeF2vW7Vw79I>
X-ME-Received: <xmr:48FCafowkEWn0ZEGdSytRNm_8FFQsC4RCb-AX1tJaw2YzSR09q51PkILY8emQbaNhBiNMmQ8ZVCZ76qiEoUhLXa7lVD6Ak4rjouJhenlXjs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdegvdekgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthho
    pegslhgvvghssegutghonhdruggvpdhrtghpthhtohepghhithhgihhtghgrughgvghtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvg
X-ME-Proxy: <xmx:48FCaXeE_fWAGJt3SP9hKBx7DzPMhfF27yPP3OaNy5AFLF-TY_14tg>
    <xmx:48FCaWqG6X4UZTCf-tLsp4D1pTeqOSVJeXRKMuiJnJIlc636iNVOCw>
    <xmx:48FCaQHFf_zwWf_-D9eTmvLrkAgp5PQR03ubfg0eTIm4PqC_wnW9Pw>
    <xmx:48FCaevaPFDA8GbJKdQzILqd2V-iLZNgz_1JaRw0imatNFfjmGPeRQ>
    <xmx:48FCaVaayXDDq4PWgxXk9tQLfrPGMxE7NZouz_2fSZxQYz2byFaFHAH7>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Dec 2025 09:44:50 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 2401c3b8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 17 Dec 2025 14:44:49 +0000 (UTC)
Date: Wed, 17 Dec 2025 15:44:47 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Karsten Blees via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>,
	Karsten Blees <blees@dcon.de>
Subject: Re: [PATCH 4/5] strbuf_readlink(): support link targets that exceed
 PATH_MAX
Message-ID: <aULB3wCFGsbZbuSw@pks.im>
References: <pull.2017.git.1765899229.gitgitgadget@gmail.com>
 <db1feb2293d20532f9468ab63ede43d4fc620203.1765899229.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <db1feb2293d20532f9468ab63ede43d4fc620203.1765899229.git.gitgitgadget@gmail.com>

On Tue, Dec 16, 2025 at 03:33:48PM +0000, Karsten Blees via GitGitGadget wrote:
> diff --git a/strbuf.c b/strbuf.c
> index 44a8f6a554..fa4e30f112 100644
> --- a/strbuf.c
> +++ b/strbuf.c
> @@ -566,8 +566,6 @@ ssize_t strbuf_write(struct strbuf *sb, FILE *f)
>  	return sb->len ? fwrite(sb->buf, 1, sb->len, f) : 0;
>  }
>  
> -#define STRBUF_MAXLINK (2*PATH_MAX)
> -
>  int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
>  {
>  	size_t oldalloc = sb->alloc;
> @@ -575,7 +573,7 @@ int strbuf_readlink(struct strbuf *sb, const char *path, size_t hint)
>  	if (hint < 32)
>  		hint = 32;
>  
> -	while (hint < STRBUF_MAXLINK) {
> +	for (;;) {
>  		ssize_t len;
>  
>  		strbuf_grow(sb, hint + 1);

This makes me wonder whether we have a better way to figure out the
actual size of the buffer that we ultimately need to allocate. But
reading through readlink(3p) doesn't indicate anything, and I'm not sure
whether we can always rely on lstat(3p) to return the correct size for
symlink contents on all platforms.

One thing that _is_ noted though is that calling the function with a
buffer size larger than SSIZE_MAX is implementation-defined. It does
make me a bit uneasy in that light to grow indefinitely.

Which makes me wonder whether Windows has a limit for the symlink
contents that we could enforce in theory so that we can reasonably turn
this into a bounded loop again?

Patrick
