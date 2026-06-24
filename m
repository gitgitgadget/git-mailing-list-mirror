Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA4772F5487
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 11:26:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782300416; cv=none; b=C9Cv51Ou0bPLrUyBgto2amdvmYcl8K0dA0pgiRFpijYdc7kVmtQurXO6xhn0Yup2nVSerAgNMlD9JMt7Ht3EgqUFpW7ZjfA2Gn1TUKbW9ghcABZ2ociThxCGxXgE/CuQ/c6NoIXru08Yx84fMPkSZmz01kMzxzOLsvt5bRd/KI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782300416; c=relaxed/simple;
	bh=cukv7ma+jV5r/JPqFKdFtKD6ysdbJssAm5BLvRWOxAM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=rM2m32XwefATOT86sJ0EQxHlCChWqFjkwwY/lpjQDT1Wqf4GxmQamZwsIBxfaIcv1IfD8JbjiwYXkdLzs+UxCOt4JHsJvxPREYRmJAbfbQjtODPCpdMutreqFA5Kr9duvVtODZJ9JqFv/lMNgWENG11IXj5axRaWZxxSnC2VD0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=GoLwzaou; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C8Z5miG1; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="GoLwzaou";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C8Z5miG1"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6122A7A0124;
	Wed, 24 Jun 2026 07:26:54 -0400 (EDT)
Received: from phl-frontend-04 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Wed, 24 Jun 2026 07:26:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1782300414; x=1782386814; bh=KLbRrQyu4F
	eSl1zLJAyuHnfsHmpxUqw+hq4f5SesRbk=; b=GoLwzaou2E3G4muJ49WcyWODv6
	bweIFkkZ65l0TJ1ef5wDEdn7gqrvXBJDAWi9OqYBNPvKMbxJk6fCHYTPAdddQLd6
	LZf209DGPfsPkvg504TnLIuO9PbkZxiRKpP9ygw9Q7KGKijBjXo1QRwzR/bD0yo8
	L8+w8bY2vDDJ1tf95KDB0ZmF1Cd1ZMgCkPjwrthpA9BjFrU7OVXWd/CMpLoIkE2B
	RiqNi17Q1GnbSNvphKk42OJsk5YGuTVK9UK5ND0tRekd4i6qOiIWpBU1EhQvNIsw
	/wuVrsFyU6StO7AmIhAwgSDowWMgXtQxe8FYnIxflvE6l3ymd9w03vh4Y+xw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782300414; x=1782386814; bh=KLbRrQyu4FeSl1zLJAyuHnfsHmpxUqw+hq4
	f5SesRbk=; b=C8Z5miG1o5W7Xu3citDUt9UdoVek7H2VcoWGzqBhkfXcy+q1JSx
	HlwKflh/SOZS5eGHN374ItfWo8c9qFgZ/wNDmXKqv+Az/IdLglX7KhGWonobym/g
	6k3T7RhJfvabA/Tm++yMs0Trc42KMdXgBU//v7XR8lAQq6S+MvHCA6dEATseDbbw
	udbvb26eX3u4Da35/KEcrvXBD4ahJ9aSS7vsNWoNhcBF4Oc4NXRgCflD8VwoXdT3
	nKrZKJU7NU4aQGp+BFYhuLtKpviATPsZnWSLwLO+7xsboNk2tfoowPSF54OUdMXe
	ogw6osflQ9BBXlUaWIFMx56aMLA1MCJ48iw==
X-ME-Sender: <xms:_r47ajsHpi05fdpZXVK46cZLkUnU-MU-cNwVLMUZJUE3Sp0V35yIyA>
    <xme:_r47aqe1J0dELoC9tyFX2cwR9zA1l1v8ue_sDMmviNajAdJ5A5KPg_FxTpKsdI6-c
    fZb_ZuzpvtC4vYoyM1jYHwkScsc7lGT4-NYLy6Yc7D41j_kQPPZIA>
X-ME-Received: <xmr:_r47akZYWXUSWMYg74lS9fMQBsnqr1QrViCP7iqmxt5vTa1-R2rskRnP9jH4uklpHQM_ynnooBYG8K0WMk-XQfSiy89gvECSR5RQ12OM>
X-ME-Proxy-Cause: dmFkZTE8nadoKE78MhcMgd+5yQWfYE0kD+bQfooTkEol/2jwh+xQsSE2EvTICLpAxVc6wf
    Mde+nLtwhCDFgylcTHk/OMcTocidOWfSjCfl1ep4tPfzxsNejPrls4ML+APBsOAX3uzheb
    JA5MEHFKwGvkD+b/6WuDd3yQyXQ427/ILRxgyd3XU1A7aAwGy/3gEHwr1+FN5NtTpHsvce
    YqPsamkWBANJ/ROUZROvLaY01t1XVO7syFfaNDCALE6hrnBXo62XNAv4kgX+djkM/VYmwI
    BDkK38geuCKVXOnLz1wAfv1L1r+mzoInrQDXRoyahUbur2UGZZXpoWwgZQ+JkM10xqHIha
    eh7SBI/OzuqMf8V+JKhfNSCfAjPmv4IDgmuHWJf4wSjyMAdiLOA8IfX8typ6EEDLChzh1r
    seic04ZIXUJAbY1TbMJFmRxDOPaK8PeF8wdrPl0UfDGrvlPRPlKqp5xzEKC+wXn2JMNdft
    DfXfknWiR2oFthTa+KdH2ZdBoW74hamER5WRpi8NR2OL/jviefWsQX+K2bNmzluy82IzOM
    c8qZI4gECbx/XbbZ9vEGuoGLEktB1FCXO1XQ2Eue0+R9SaXXWyIQtvsbkx+sKQCYPWATot
    2eECVSHyn1eIL1BPhhVzt05jRQvVrAe7eMDPLjjz+56AZgGRoDg1VcwbCOzQ
X-ME-Proxy: <xmx:_r47atXCu3hBeBg9T5RqO6B3oBhx6i4OA3xIoFGvVDc1qCVglMOUmA>
    <xmx:_r47amjQH1Vig8DtX7wsNo1eiiRfYyAyMU1KEhUxcDPmueVhuRSaDA>
    <xmx:_r47arUXQcFy4z6XwETXle1ZRTuA_A8PFSephUsbmSTCHlHpFp2TUw>
    <xmx:_r47atNodHAr_7AI1_A7O9yESnqIujoS6FfxcxpdJbBoWnuKFYB_Vw>
    <xmx:_r47aue98TwrGxMEOQkCnVshC63JHOBiQELof0hZGKAJqdtxZtLq9mrS>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 07:26:53 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8462607a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 24 Jun 2026 11:26:50 +0000 (UTC)
Date: Wed, 24 Jun 2026 13:26:47 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 4/6] odb/transaction: propagate commit errors
Message-ID: <aju-90Uayxwsevm7@pks.im>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260624041920.2601961-5-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260624041920.2601961-5-jltobler@gmail.com>

On Tue, Jun 23, 2026 at 11:19:18PM -0500, Justin Tobler wrote:
> diff --git a/odb/transaction.h b/odb/transaction.h
> index cd6d50f2e5..7898770071 100644
> --- a/odb/transaction.h
> +++ b/odb/transaction.h
> @@ -54,7 +54,7 @@ static inline void odb_transaction_begin_or_die(struct object_database *odb,
>   * Commits an ODB transaction making the written objects visible. If the
>   * specified transaction is NULL, the function is a no-op.
>   */
> -void odb_transaction_commit(struct odb_transaction *transaction);
> +int odb_transaction_commit(struct odb_transaction *transaction);

Should the function comment be amended, as well? We should definitely
point out that calling this with a NULL transaction also returns
success.

Patrick
