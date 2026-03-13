Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DD50343D91
	for <git@vger.kernel.org>; Fri, 13 Mar 2026 06:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773383524; cv=none; b=ikFCgdgs+JLDRShnXvRN9/mkxsd474kr1VpAGNa/tudBnjwyR/0AYBNbUF6sdJYhk8H8HIFS4WAR3dOCoDbG5XvVQDZyBlWrjAu2PfyhbsGAzOboWr/e7H2VBkXCplo+7b214AbhsecgtHyYbNMti1ykshUpl7G6pXXWJ1vByDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773383524; c=relaxed/simple;
	bh=S1qMVjZcuTu4gCIFtX5kj177ZL0mN//XhGSyigErV/o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=nVTUaWIA00nn+MUPuLvBMq2cpS6FK29rV76RswpXkJMSMP8WB927BleKHM5kZnffiiWZuZetAVbWJOJcxpdPRuc3QyS/v+x0aBBEJdawBQ0qZpw9ZTz+Sm4nn1e9cb7Eub5o/bJSAq5JxTaFjg1TNe/nppUFx6QLQO2eN4ljv00=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=Cjv6BChB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WAYpRGJZ; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="Cjv6BChB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WAYpRGJZ"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 60DFD7A002F;
	Fri, 13 Mar 2026 02:31:58 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-01.internal (MEProxy); Fri, 13 Mar 2026 02:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1773383518; x=1773469918; bh=lJi000340C
	NQP8qMe+oH1NLzlXxbensFf47W849q8iE=; b=Cjv6BChBFO0Gy9qU2BqeRe88rO
	JO5B899jFX3ESEgz5v/VAVcNmacXNJ8FKcpMzJBG7jPtuHKcwA8KuB0Z/bh3keCa
	p8fWECdlkvDVUmj68N5uAfrm5cesVsIwhp/IUkot45wi0axfMgf/R3tJK6Ue4eZD
	vI8GHuw51vGIK2i986+1gFY8Oh3HxSLzEpQwH/TuNZRl/iehlaScITLWnHv7XLPe
	OpYyhM/k2tgXsefMy20fmbE08Sborxm7MtznLEH37zhzlDaTov/bZWXTTeEgvMkh
	ZUUj0H/z+rS5xwvmUI9XGsCAKWghNBaGqDv4KAXX5jIPjDZNNpzminYUaW/Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773383518; x=1773469918; bh=lJi000340CNQP8qMe+oH1NLzlXxbensFf47
	W849q8iE=; b=WAYpRGJZhJOgMHf9FK9NBLHt3QDjGA6ZYnj2JKv1QEHJS/k9JQS
	HIP22fR5yhZFapkz+Y9jyvpM823/EKBkFbKKo1+SCY811skM6P4EKUGOvH8fM2Dy
	jbif7+f1yFlrgVYVm+mlSFI7GMtG2ek5b+0o805f0Ewsl9+XO659Yevn7FeLLrwH
	+trXx5Oyc1OEjyCgIAv3iKfeCtQWRIdITF/RX+h+rMxbtLTMvl2LVeGxpZr6auMm
	ce7V+kZQsbEiNUiNofobtrrgFZth2bMnWWHs6BQDkjNd83qTYPNAvsTzFriKK7PA
	9nZR87ICxEEwi0sxybtrujQ9EXVSbnG948Q==
X-ME-Sender: <xms:Xq-zabm47LSsARNJ5ZoMsLO-x2U_kkcTr_Z-SRjzg0_pVx9g3S1hkg>
    <xme:Xq-zaSgevmZo3T6eelOyUJ5m8USxR8Zpw5iFXNEXXEM5sRRkvbkSrMglSOOPrVYIR
    oE3pZL-oGIP2em1YW6uX4bRakqhQRJFSqEPJ1LcnkbrmphMz-A3>
X-ME-Received: <xmr:Xq-zabchrlOQM75U6wOQJY9npq0Ic2zdzwqJmXp9r5Elx-DgZvoXv5KrM7NwxYvWnK-U1t9fbmULU03ZIg_0xh3GuEgl9TyltbSb8bc2vg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeekleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepshgrnhgurghlshestghruhhsthihthhoohhthhhprghsthgvrdhnvghtpdhrtghpth
    htoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhmpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
X-ME-Proxy: <xmx:Xq-zaag0EL5x-p7PAEkAyJez_U_tgieVgt9n_d2oX9eFkToPdLKgIg>
    <xmx:Xq-zabwqix0lIhCKbY0VNnaRBhurRmK0zBTcHkjniqgUS6ju55Anbw>
    <xmx:Xq-zaeM4JpmoXHNZ-VxzjgLpvJlohurQjZTZeMA0ZSCtw0Fu2csKqQ>
    <xmx:Xq-zaUWhruVXH04UQEtZw1pecwxPu0O_opOqZmL21V7BrQ6KKXGwpw>
    <xmx:Xq-zaSUVx1VtrdZnLa1DOLHLta_Qs76y4R0kgARHDd60xW_5ip5VEP_3>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Mar 2026 02:31:56 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a629deee (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Fri, 13 Mar 2026 06:31:56 +0000 (UTC)
Date: Fri, 13 Mar 2026 07:31:53 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, sandals@crustytoothpaste.net,
	christian.couder@gmail.com, gitster@pobox.com, peff@peff.net
Subject: Re: [PATCH v6 3/3] fast-import: add mode to sign commits with
 invalid signatures
Message-ID: <abOvWQojOvkJh7QP@pks.im>
References: <20260312192228.481134-1-jltobler@gmail.com>
 <20260313013938.2742124-1-jltobler@gmail.com>
 <20260313013938.2742124-4-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260313013938.2742124-4-jltobler@gmail.com>

On Thu, Mar 12, 2026 at 08:39:38PM -0500, Justin Tobler wrote:
> diff --git a/builtin/fast-import.c b/builtin/fast-import.c
> index b8a7757cfd..935e688e33 100644
> --- a/builtin/fast-import.c
> +++ b/builtin/fast-import.c
> @@ -2865,6 +2855,67 @@ static void handle_strip_if_invalid(struct strbuf *new_data,
>  		else
>  			warning(_("stripping invalid signature for commit\n"
>  				  "  allegedly by %s"), signer);
> +		break;
> +	case SIGN_SIGN_IF_INVALID:
> +		if (subject_len > 100)
> +			warning(_("replacing invalid signature for commit '%.100s...'\n"
> +				  "  allegedly by %s"), subject, signer);
> +		else if (subject_len > 0)
> +			warning(_("replacing invalid signature for commit '%.*s'\n"
> +				  "  allegedly by %s"), subject_len, subject, signer);
> +		else
> +			warning(_("replacing invalid signature for commit\n"
> +				  "  allegedly by %s"), signer);
> +		break;
> +	default:
> +		BUG("unsupported signing mode");
> +	}
> +}

The wording of those warnings also reads better than before now.

Patrick
