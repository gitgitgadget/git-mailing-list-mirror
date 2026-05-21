Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22BAB1D5CE0
	for <git@vger.kernel.org>; Thu, 21 May 2026 08:19:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779351596; cv=none; b=Azw7bSO0E9xUKEwUaWxVbA+6Lw+R1rMkFFzqZ1N6fGWMb9aBa9VWWRnmptRC5sWzRJ0GPX7GCCKHfHjX+MZiz4DWpRgxw7cmZxUoBguOvBRmXOvpXNl9OOSeLLxG7dBNtfj9Abr2hO4mIb8827g55HSsddKY5wfrj7tSwMf0i7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779351596; c=relaxed/simple;
	bh=z1WoIjcnYkT+CHOMi5a+6LlszLVJMel9Fg2o9RVxgiU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=r4Czra6jPdQceWOz3p3PPIPD28E19Jmd9VHJGrIvKtxxeRYuekPfeMqg6op3fZ0MmIrZHQfoNQmZuTyZsa0IrgIF4/RtSwTSwZ46Dz9gWTvywhBcFeRgt0dODRIOIOtPn5wg5PxLsfO88qI4PPn1nTNxhVznj+gpTZjeHWyYBPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=abYEURno; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J/S/pHrf; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="abYEURno";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J/S/pHrf"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 6472AEC0110;
	Thu, 21 May 2026 04:19:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-03.internal (MEProxy); Thu, 21 May 2026 04:19:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1779351594; x=1779437994; bh=6af7BCmn35
	NJ4S6jbk/Hjgvnu8nQiIAKCuQZNrZfYfk=; b=abYEURnoEtzzHD6dyk4j+TT0fj
	sTpDdQH5xOXx14uC5fyhQidgOwXUC20Ac1JxS+E8MzRA5RKZhSNzdrFhFgK3piWu
	ULiWa7B1EBnkMzlKkQhri/UOOAZItwLFv03qlvB8w+mD33r4if7Z0LOrnwbYiI3U
	GAurULQueKShbg1lXuzW2/iUe2HZEEKPEKx/wOS9qfS9lVk5IL3AKFDNMisAxLOW
	HybhE63KhKIegfyPXTb9endVGVgrik+VlQl7pUUzgYpjuOaLB3kE8YnT+yXKA1hI
	2SN0zZBZWiIkZrpwQ82wb2MA3Y0GpU0e+RN0Q3sWzFbyzI1qAMFR9G3ZKGuA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779351594; x=1779437994; bh=6af7BCmn35NJ4S6jbk/Hjgvnu8nQiIAKCuQ
	ZNrZfYfk=; b=J/S/pHrf4OYXWjhsGfq2rvYqTN+bycaEA6PgQUSTC7be2Qs+Oxs
	HydpVVVtjBE4DWfuDQYDYxGR/N6SiaO0ZIj303oNn7Vnb3m6zutQEGBOIe5TsePp
	/++UvgR4rBW5biEsCQeeteKYCLKDVGy+Tr0uY6d8SKmh0zuuix0zskByAhuK6ua2
	CEscj9OjOUe2OJrXhPYTzHGLX+OH1irx/qJExOvIwiTyVvajEgspzC9CzsMYuH29
	K+K5oktvnlVb/wn1g5S2GahtIFwOM1cp5YzkuBYE4OEAO0g9f+L+FFDTRJ0SAvv+
	f9lwPWCaz/tnBM+xNZA/++Zq/3rAa+EaPSg==
X-ME-Sender: <xms:KsAOaojuCZus_cwYxBshOLRjOqx8Q-XBAXquqGxoW2jkN2qOsl0p-g>
    <xme:KsAOanBffJ3eb435URWbX_I2HO9lW-3WSfxtmU5nnyZRJ0DTVn-BiMqlizqvGdTdk
    bLTHXRxd04ArTAcwwJsD6ZRchbdstLnbeU7HjgauaXm4m5iy3TL-g>
X-ME-Received: <xmr:KsAOats4PBui8K1d5b_3F1pDQ_GlSTqX86JCp3rgOenhdjsJiH8zR_zx7WV74HrybdPOsUrC3FZgG_lLWT5K-_HcWyRlHd01iy5mFRnmFPY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeejtdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpeffhffvvefukfhfgggtuggjsehttdertd
    dttddvnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhk
    shdrihhmqeenucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvud
    ehgfeugedugffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgr
    mhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopedvpdhmoh
    guvgepshhmthhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvth
X-ME-Proxy: <xmx:KsAOakZAdy9eDdkYhkTvhaoPEdDyPmhSiz8i9tiu7mxzvmMm_EsHeg>
    <xmx:KsAOaoW_0ze60SYGDtsCM8SapTBHh8vEe8hJHEVZ4dv-3HY1OMOq7g>
    <xmx:KsAOag71bYWyEDjvWYJylejrn1XYWLocLP-K6vAYMQRRf5w3WkMokg>
    <xmx:KsAOarideIL6CMMEkVTOAodCRGW5VSw9fq2G-cg_CIDnn3BeEwc9ZQ>
    <xmx:KsAOapAS4f_hrtnAWyHHPc_YYl27vSn52hx-i8_2TdtTIdwb63I1Vyd1>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 May 2026 04:19:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id c20eac21 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 21 May 2026 08:19:51 +0000 (UTC)
Date: Thu, 21 May 2026 10:19:48 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] connect: use "service" enum for "name" argument
Message-ID: <ag7AJMbav6KgSCjj@pks.im>
References: <20260519052219.GA1703179@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260519052219.GA1703179@coredump.intra.peff.net>

On Tue, May 19, 2026 at 01:22:19AM -0400, Jeff King wrote:
> diff --git a/connect.h b/connect.h
> index 1645126c17..c56ecddc0e 100644
> --- a/connect.h
> +++ b/connect.h
> @@ -7,7 +7,12 @@
>  #define CONNECT_DIAG_URL      (1u << 1)
>  #define CONNECT_IPV4          (1u << 2)
>  #define CONNECT_IPV6          (1u << 3)
> -struct child_process *git_connect(int fd[2], const char *url, const char *name, const char *prog, int flags);
> +enum git_connect_service {
> +    GIT_CONNECT_UPLOAD_PACK,
> +    GIT_CONNECT_RECEIVE_PACK,
> +    GIT_CONNECT_UPLOAD_ARCHIVE,
> +};
> +struct child_process *git_connect(int fd[2], const char *url, enum git_connect_service, const char *prog, int flags);
>  int finish_connect(struct child_process *conn);
>  int git_connection_is_socket(struct child_process *conn);
>  int server_supports(const char *feature);

This is all quite tightly-packed, and the patch would be a good
opportunity to maybe add some documentation. But that's certainly
moving the goalposts quite a bit.

> diff --git a/transport-helper.c b/transport-helper.c
> index 4614036c99..bf37c5280c 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -620,8 +620,22 @@ static int run_connect(struct transport *transport, struct strbuf *cmdbuf)
>  	return ret;
>  }
>  
> +static const char *connect_service_cmd(enum git_connect_service service)
> +{
> +	switch (service) {
> +	case GIT_CONNECT_UPLOAD_PACK:
> +		return "git-upload-pack";
> +	case GIT_CONNECT_RECEIVE_PACK:
> +		return "git-receive-pack";
> +	case GIT_CONNECT_UPLOAD_ARCHIVE:
> +		return "git-upload-archive";
> +	}
> +	BUG("unknown git_connect_type: %d", service);
> +}

Shouldn't this say "unknown git_connect_service" instead of "_type"?

Other than that this patch looks good to me, and I agree that this makes
the argument a bit easier to understand.

Patrick
