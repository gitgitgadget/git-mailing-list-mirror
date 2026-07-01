Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C70E93C108A
	for <git@vger.kernel.org>; Wed,  1 Jul 2026 07:56:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782892607; cv=none; b=f6vpfCmx7ZOcpoBn5tG5V9R72glO5bHvRqPnCOj2bBn2m2A21eXXtHTs/Wate83egvzxhDZ6njPkz0NtcgFySwMaWfmp0cHpw6TG37ii7hZ7QEUWfeqf+xBBjBSWt28SchTgpAIWOUtC9668FnPW0uHHgNCR2I7DGXrpBS+lUIo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782892607; c=relaxed/simple;
	bh=fYMUguGLi17gR7GULE67j8XKVu9B3NpKXunDZim06FM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KSQwOcafBP1jpuX7S/geHkJyXzgHdpqtqmaVOSjZQ5sQ9wexa+6SuF9ELl3Ou95iU8OvUc7SkXjFjq6OE/2MxtYZ9TU8WFciLkHoDBoIsaFAnUrFIGs43ogKutLZSiqCO3nI/DHNyKXc4OzgtE8SHUCqMz7bwlVfWoPaaMTF8eE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=iy8fKKkn; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MNGSxkv9; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="iy8fKKkn";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MNGSxkv9"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 06B58140006E;
	Wed,  1 Jul 2026 03:56:46 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-05.internal (MEProxy); Wed, 01 Jul 2026 03:56:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782892606; x=1782979006; bh=XKbPOhwPj2
	CePNISppTX8ZvLpQk3ngAQ3lAaGysB9xE=; b=iy8fKKkn9WvSPwvjpKwtI1w/G6
	5OjgNSH7913Y4Tl0n2Xtd2OuFuC+Oj89v6GYa9++KjRMf9mUabnh6wujCwegZC6p
	zkXOlEqhfnbsefbe70Q4r825if1wj4fPMxSfsUGLuc9DsQQxXMt5sed/MZyN6fCg
	Vg+R4WUBMggV7xoohCjgjCduqvQYs3z/D/J1BUL5Zq+UjlqP172lXafjWAARFwyz
	ehMqou8YhaQs9paTkoQ2opT7m6wyyoqwXE3XePOAzaDF88lxr3/kV9jT3VfrCbHm
	N7JPjRJdFxPF/mzTli2q0enLDrq+AkjSw/oCeMORU0ibSRzFSF83cbeeUlOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782892606; x=1782979006; bh=XKbPOhwPj2CePNISppTX8ZvLpQk3ngAQ3lA
	aGysB9xE=; b=MNGSxkv9EEhvb5MF+B+C+zKk9xLrWtEh0XU29+oZkqNtdJHwMXq
	cuyVOiUVgZRy5LCrNbB5Zq4T/sOEq9/R4wWfEcHDrelDwQW0+J1lDEXhPsAgoL2j
	saPrk0RuvRLw7NyuXS9/TIb4Xv1xTY6dOGsw5Lhk0t8DNOh6s5fYOMSBk219HLWR
	QllfQMs4oqH4Zn0AL3WJljPTFzWSwT5hulIlu20k5ovWMCCziw87LpoBWFabl7Ol
	lW6Q7+H1CvQ6t6EoYdyfvmziXZmkLWDhc8PCIIgwsDtY0NT0DLtIC7SP/X+i4aRU
	clVXoAXjJX2KPRiqu5nGPbk1O7MPXwObzYw==
X-ME-Sender: <xms:PchEavBGXZYjlhL0uMjSI1ghx6sQYLyv1BJBaz73LAjIwkjhko8BcQ>
    <xme:PchEas_LhAprgsVWt0OX4N5yStNSKfzxzXZhAOz89mz0PUddvzdtLyon-EN1eyP1w
    oyYfqMLuJGFpplSZ3sF9O3vaQQDwPyz4t61vb_wlARRcg49d5O8Ww>
X-ME-Received: <xmr:PchEan_J-GIDj8cLRmjsue2c-NIECL_NucbpV0Qb6L43V2kjftBG_fBnVsuLRavO27XRMn8hTLokhsxEUFOMr6q9H4mnsktnOeyD48C6Q5Y>
X-ME-Proxy-Cause: dmFkZTFlPFsgBwBaLKeciHlMQjRufptWj9P4KLyd1RX74QQYCkiOePmpU4Lo6TYmHk6LQd
    aTHd9/+AD9GrsX/ZstR6AF4a/4OMcJu2HFMzxZ0Gn2lfSok+GXDlQ02KoAPudmX0TTC/Cm
    C/7TrI5bX06cSm1+KpfSJiCQOc6frsEwBwHdeqUJH+zeFCnsO/5Bsz0amnpm4X7h6hHvy1
    4RfaDx585qthf6JbU8U4bhqSoauT0QzgOgt60TfgwDYxVTezJ+kOUd0dVqxXTVz7sGN2br
    fu2l1Ek1h2bveLVtuoK6RV4ghOt18Y8z6n2tToxW4Ul6Xl58kS53N3R+S5QOgAg5xHQUQD
    r1/1C5yGsm9uEHrJDObrv/Fq8CD/wb8yaV8t5eq90Ds7GVGpoYPhtDHDcQSbnEBkiR+Xsi
    lL7sld/3/5d/bM6X7XRG6DAV/TO8vAzg13R72Q/AuKoqTGzEtZsO6HiiseJGeb3kiz3shV
    7jqo1t6hC4h3Ns2dKy+/G3W6qRysWXruggdtkdMiArg5kjK7Xvr+tvCymU1drDo85Eix02
    OpvsKX9R48ssB9XHFAcFy3C11/unxmDMJ3+P10yeJroRp1Q/CYAmyPsHdhPQpYJNQAoQGi
    sfnuhzKtDBLPPY4l/S0/4fbU/A83VsZqhip7jp7eWvPdtb2yZnVzym9DHh8w
X-ME-Proxy: <xmx:PchEardo1HRBOaVDavb66o5Mbj_PMmeuUomF7kJLN2_uleih_TurrQ>
    <xmx:PchEaoF7mjmag-a6dtzbhZC0glSWXu4pIrXPPp5YuH2W80pvfSrIsQ>
    <xmx:PchEahf9ORU6BGaAkFVKPgSEjzGERL9Agcn7pb5u2sPYD6Hx2PIyTw>
    <xmx:PchEaqF2GtRgFbrT8B413uqPcUseBllmiY1unCihj3-Z7Joru_nKtQ>
    <xmx:PshEapca2IzKknKNfmTDPp91D2PeHS04zdCf1QWXODRnlJtoWXEC5NGu>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 1 Jul 2026 03:56:45 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 44f8daea (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 1 Jul 2026 07:56:44 +0000 (UTC)
Date: Wed, 1 Jul 2026 09:56:41 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 07/13] dir: free allocations on parse-error paths in
 read_one_dir()
Message-ID: <akTIOeXFhNjJ7V3i@pks.im>
References: <pull.2163.git.1782889472.gitgitgadget@gmail.com>
 <62ce03454aa1928edd8fa538e0600155629939cd.1782889472.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62ce03454aa1928edd8fa538e0600155629939cd.1782889472.git.gitgitgadget@gmail.com>

On Wed, Jul 01, 2026 at 07:04:25AM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/dir.c b/dir.c
> index 32430090dc..23335b9f7a 100644
> --- a/dir.c
> +++ b/dir.c
> @@ -3792,13 +3792,18 @@ static int read_one_dir(struct untracked_cache_dir **untracked_,
>  		ALLOC_ARRAY(ud.untracked, ud.untracked_nr);
>  
>  	ud.dirs_alloc = ud.dirs_nr = decode_varint(&data);
> -	if (data > end)
> +	if (data > end) {
> +		free(ud.untracked);
>  		return -1;
> +	}
>  	ALLOC_ARRAY(ud.dirs, ud.dirs_nr);
>  
>  	eos = memchr(data, '\0', end - data);
> -	if (!eos || eos == end)
> +	if (!eos || eos == end) {
> +		free(ud.untracked);
> +		free(ud.dirs);
>  		return -1;
> +	}
>  
>  	*untracked_ = untracked = xmalloc(st_add3(sizeof(*untracked), eos - data, 1));
>  	memcpy(untracked, &ud, sizeof(ud));

Hm. Here we assign ownership to the caller, but this still feels quite
off to me as we also have two more early returns after this point that
seem to leak memory. Do the callers make sure to always free the data?

Patrick
