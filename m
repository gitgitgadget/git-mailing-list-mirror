Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5171370AFD
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 13:53:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780926819; cv=none; b=kvNFHmeu7xu1uaxpORtHY+PUVkRrnABgPNqwREZrMBwfPbwvChnUCKzsHsYj4YeqXtMA8+B2ASdKGjRG0gJZmQ884/qD370WDd8ZV93ihgXljfNTTCFyfemGEBNauiwN1Ej0X+hLQL2wuVXvVDeLSNNt0GE7TjQcRb/FDffGN4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780926819; c=relaxed/simple;
	bh=p0Y3B5AjQCPp2bTdH8S1aWUdl2RbraMn6S5QL0I2lP8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=J1LMPW8TzdzJHANUsfZKpGEUIv6UHNX3xp6m8p9lhO4TLLLfvukdNgtz1yEdFPKiO6UbHhf7TyKv4wGkI04T+Ct5Rh5zCkhsWOtHAh78fpsCG5UWuCfqB1+PZDj0URrvo1x+zlO+02ZnldsKzLfLb85LeQtGTpvrU99Ae6W9SlI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=oLmas4/y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=af5LAe5x; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="oLmas4/y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="af5LAe5x"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F160514001C2;
	Mon,  8 Jun 2026 09:53:37 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-04.internal (MEProxy); Mon, 08 Jun 2026 09:53:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1780926817; x=1781013217; bh=EBC1YKVPZ4
	fPNpMEGTykG6hD9g0tZUfl7ahyCBvOhqE=; b=oLmas4/yNHcGJeeBo5ePDWU+k8
	x7frJpzSrbfhcgfcdAgzJ1b1Ch7VI7LNYUMqx3fi0O+6XNKrceACVS/nJdvMDGNk
	uxKSIscuRWzh1lU/kmlyeBO4IN/VZF6l+J5HFRkBYjTVROHKs5ZORLRK6oShemNc
	E2Sgq/FZnQZmTdj8qhAqarFguftq0CP7oyOEGl45c8rh8IOf0tKYJVzGQKoi4YSq
	jAXRxXUWFilRD2km9uqsAgECXUyqp7EIsNN6NcOkQH2lmBTB+81TBBPj0IKSC/RQ
	It/ahbv9WqNkqVK64aDTTyGg7LplLqDheJxwRiVxxO4phPZNvsvVZSlsClew==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780926817; x=1781013217; bh=EBC1YKVPZ4fPNpMEGTykG6hD9g0tZUfl7ah
	yCBvOhqE=; b=af5LAe5xTdk/zVpnkooZ/xuVCjSLU2xzjBAgCoOhkM3EcK2MB0T
	P7KQ7AeuHKtdk3LiKkqXhq/UWUN7x3iXDGDEiycRHq+Qg7Nr0ZYRMPg8QpV/iQ58
	u25FQRqcid+hhFwxICX4kh/AsBHQTykVHaIdUJwqJGfzYDiR9yW23FmhLxsaLV8G
	GVS6QKJYnecG3UpGULx1OZaH0NRTgpyA8Y2gSkfNn4TKHFCy0YHuLuUK2+pLCX/Q
	7SbTmAO+Gze46rjrvp0ACAH0dz+D2bYhT6NvUjshcvIg0W0FGUI5g2TfXWqRvVQH
	OMJfJAQQCjN3Nsi/6akePMxspwhTqwh9NBg==
X-ME-Sender: <xms:YckmatfL58icXeeoKPK9SFqs0-EvphwKd8MhvK6jrm1IYnkAEFTPDQ>
    <xme:YckmaiO1N4tWXThj1QAZ2rgDmXihzlGLU2BkH92gydKEYjMxTLfiVOWPKaAtIj8xS
    Kik9mM1-XmviMj6a1NRIZB5Y7m1xUbnVARGBxPcVyTJCzRH7eCsHgQ>
X-ME-Received: <xmr:Yckmarifoxclo1fLCDUiyIpA8YM3SksSI9j3u9eDDFZrsmU6wMscut8PXoSJmtnICcE3zA6n4a8E9xtpdSCCtSvFVn_1m67-hK_3UA-NrQ>
X-ME-Proxy-Cause: dmFkZTF61W8YYYM5DXrsUif1Rh0WHUkmXoR6PEdvmekQE5kgFkLNW8ieBBAQ54V45ST88A
    +/YrA0u8a+IqPQClJAYwkn6r2XNz+1twq0c+BaniCgsiXW9uEk4maTGHS4pPI2VqXp3uGi
    p5UTXiVWR74wgoW++R1kKlci8Gzhv8tVVORMydjjxe1gtb0mXX8QvNGzijCPEKTjDfW+Yi
    SYcvrtPBZsmU5AnRqYAhft7MjgIAHqKrFTvfjSS+YmlC6eaKfJBxqv7h55nIYJVq36Swrj
    Nh2ZReCiDzVVNfq2anW9gZC8vZ+6jaRnklXA/tjM8q71SKGlqSoOWrZ8QkNWkIFZOhCFkd
    58O1u5yOcs/gAsyh6AB8nXRYZ/iNLxa5Um04koVdXqscpEvsNGAnthj0d9gkrY1KzdXRVY
    UjHEcQB06PjLc8f8EEqwI5RK3W6a+jUxRIzUPl/sNORbNsB7paIJd1c/SV42cTeeVtao6v
    WFZ4tMjXy4pH0lHRY/SdXAW6gsm8RsIVhjnBYrYoge/UvNkMO6U98rZwpgmTFaKt2JEQ51
    niVmJ+82SbYWmGbx3dYaJ+xu9wTq30458ZQHAJT72GK3AuJ+iRDcJWL+8PuzsBRtAlMysB
    R0hB5NIrAqE8d9r223855rP6kaVUKWq0vq/a3S8MEKqTQb/0kl+qB8/xYSKQ
X-ME-Proxy: <xmx:Yckmal1f6rjbMuaJuTANIt-PHMrXYeOM2AN8nUjoMTZw8ucK0ZmRHA>
    <xmx:YckmalhedYoopTf0Wj3uv3xk2pOVQ8CE1W7xF1Maw8iRim78AHdLAg>
    <xmx:YckmaleJcv6em9AxR_0RxsHj70Ue6THnumj3Baa2p6bKT0pwOlKKsw>
    <xmx:Yckmaom3R9TsKkwgiWePHkpbknO4DgcTLOJKTiNxqpJaFhc-Aft2yQ>
    <xmx:YckmanQz9BigGy6mTYMA17L1HbWlvFWtaJg0UHfoBCJzGTpKMcIdtaee>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 09:53:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a27b7323 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 8 Jun 2026 13:53:34 +0000 (UTC)
Date: Mon, 8 Jun 2026 15:53:31 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Kristofer Karlsson <krka@spotify.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 4/7] packfile: widen unpack_entry()'s size out-parameter
 to size_t
Message-ID: <aibJW3h4PaYhOqFb@pks.im>
References: <pull.2137.git.1780570272.gitgitgadget@gmail.com>
 <bdebc36f21d1e2a13bc91d72a3ada1db3f7e184e.1780570273.git.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <bdebc36f21d1e2a13bc91d72a3ada1db3f7e184e.1780570273.git.gitgitgadget@gmail.com>

On Thu, Jun 04, 2026 at 10:51:09AM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index 82bc6dcc00..3dff898c43 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -1239,6 +1239,8 @@ static void *gfi_unpack_entry(
>  	unsigned long *sizep)
>  {
>  	enum object_type type;
> +	size_t size_st = 0;
> +	void *data;
>  	struct packed_git *p = all_packs[oe->pack_id];
>  	if (p == pack_data && p->pack_size < (pack_size + the_hash_algo->rawsz)) {
>  		/* The object is stored in the packfile we are writing to
> @@ -1260,7 +1262,10 @@ static void *gfi_unpack_entry(
>  		 */
>  		p->pack_size = pack_size + the_hash_algo->rawsz;
>  	}
> -	return unpack_entry(the_repository, p, oe->idx.offset, &type, sizep);
> +	data = unpack_entry(the_repository, p, oe->idx.offset, &type, &size_st);
> +	if (sizep)
> +		*sizep = cast_size_t_to_ulong(size_st);
> +	return data;
>  }

Nit, please feel free to ignore: do we want to add a NEEDSWORK comment
here?

Patrick
