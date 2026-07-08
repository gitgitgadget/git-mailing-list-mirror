Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CEE63DD519
	for <git@vger.kernel.org>; Wed,  8 Jul 2026 06:41:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783492910; cv=none; b=l/+ZsrYN22K1YgrjENC91kurGGdW6lqyj/IYrgomcounU2EefWrT4m5AhT9GaaDBjxD+ytE+RvFq+n1nNOxWFjuHB9OPmcdG+64weUrn9hPeDUMYLalrYH56llwTZyxxo1PKf9ykpfsjKmXFz4l3MwoY8D7rDH3GtlPqCp2vzeA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783492910; c=relaxed/simple;
	bh=8ZCT88IYKgBopwgl9/D2fjOvYnSFZV4RwQPxCZNeerk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=OxFIK1GcaUP7srZ0XVllwrc3GzF5D7yrLWF6T76AwCqBSD32h9enCTPv6nEbiOAZq9wvFAD9qpGrQvi7vkpzlvS4oG6SqKLTKbifdPhBMHjCN3vV3vLN2jVwhj6f/UZlQQUTbdcaRtclMcwzVCvNnWHpau9Ul6jDjoty9KfC+OE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=RWc4tKtl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ggYCWoau; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="RWc4tKtl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ggYCWoau"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 4EE4FEC0128;
	Wed,  8 Jul 2026 02:41:38 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Wed, 08 Jul 2026 02:41:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1783492898; x=1783579298; bh=Wer5oQEM+n
	y8jpgb97whw9GCy+Wb7Qp25yaLPzCD5oc=; b=RWc4tKtl6QpRC3+5zxCpffwimc
	sGTDMUI2PuaFWjUqsRSKdHW+Q1I4PBs7W7chvEg311UDsxtoHVSxyNXa2fBK1Uev
	A8f0DKpOZutHfy8/aXf01gLhm6NDU93k68qRM0PBcOTxFJHX0enz4ePTTmUKzcmj
	d0cdaxD2N27zRHF9W99xjyZn8NHjMKuCvej6bwD6FEe0rY97h5iOrtXr7BkroAYs
	7SoZAI66/jcqEhnT1+w+VIBZMJL0mOElFP/lmCcajqAgOis/91CroAbJr9TpbMZO
	7ZQxajxonfGl/a9Sc2kqTcyQgFR8MbowAdemur8iw9ncEfrdhBMTWXttjEsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783492898; x=1783579298; bh=Wer5oQEM+ny8jpgb97whw9GCy+Wb7Qp25ya
	LPzCD5oc=; b=ggYCWoau9wltVHA0plgudo5SNGydmSYht6eYcTlRwfWCXrhq7pA
	pHfvfv8DJLLr3fu4bMQrz6cpDR4xWDmsQDyZ7cDpRNENkCjsWcT8MEacFedcfaQa
	vghs4qM7nphSrP7L8F2ALJNNck06368NM5V+DgmJdnpjo1Lxw9vr6ZJILGhj4tuY
	l+KelVX29RetgnUT8ojcQVyCnyWmj3XTOnfMXLtHXzcJsHaFCAWVQhZRDlIcWKCU
	e44WOaoyv93tdiETOEMxqPwEZ779J0V2ZRzGj+LoWsKcV8QCUBY14/sH8H5eurcN
	v05bW1PHp3WGr9w2tLDbnq9OcnKm90SZo/w==
X-ME-Sender: <xms:IvFNaj51MNLMWY83yApl9kYaCGbJlXnEpXcT8xcS2BVt6gWSVOXaIA>
    <xme:IvFNagWX8ZJusl3dSA7nMxZoygRg4V1OVYuQoBHP2f4VZ_9vGe79gevqhOy7fH3eo
    YMsIap_JbAqS_y9JT3iOadB6sq9p9m3Th-j9t_NJJjaJF9pFFw>
X-ME-Received: <xmr:IvFNan3TpWF_4fugHiKvsd3lO6GEjI7UmVHioKYYIpvF7LfHsRIWWykq6P7gkkVC26c0cGtK0-dVbqabivNjTGtKRInPQcZIwGAjNg4C>
X-ME-Proxy-Cause: dmFkZTGZXL/xVJBZRT0XjNqQmj0NiEBsL4QM8RtI8yDGZADKrRfylrcgFrWZI9uiDIKpJG
    NjKjs02P0Mm6RVE/7hDfUtc9cztgn2Cw1NuVWkTQj+sAuE+2j63eSJoWyolt/Iiji6uwfB
    AwsPpkAgDLBwGtskl6J4DfVEmE3a8CrgO0CsSJrcgOSpTlkDb4uBEU2zo8XcOuoumIzvPq
    jcg3C9N3hj/0A3Ui37jFkht3TKzzhYoJNu6TlM4CtvieEBaYn4bcsRChYX5mEXYpyukiBZ
    qNG2o1iENbIAOWxM/sLhn2X9ptN7rf4lBdIWSM0XtBgVFCdgfwbiDeFlBqFipjcVgu8+WQ
    lO2xaZ51DRUk4dC/XpZM+sXxnwu2VJqNPq62gy7aLa6PZPSP91oGpYj2p3lOAP50w+zQOo
    FWX0V/PbBv2HOoWeHDZL7S8btZh9NcTGJKOc7PudipoU3lqiRYq38tnYgHeTetVioX0r4O
    yBFmD6r0pw5FIIR8zi8RJnBaRUxDkcWm/TppknbHJVgCaV6bup9C1f8E67CCeddR80c7z5
    tx3uaWTNpx4u/TzrWCo7GkxcBXnc6ssSIZWXra3VKaf/QBFov/0JNre8VskevPKEuE8LZR
    V72sfxhAJMH7bJRJ3INcB9rH1lxYK23I8H+EmkNd0smEVKvgv0mdbIkdVdsQ
X-ME-Proxy: <xmx:IvFNat3do9VQSxELk2vwG5Est802CBZq3AmEBEtugyqtLx5aO7seCw>
    <xmx:IvFNaq-AN8i6Pc8PdCUy-lVwbtRwBMwo51bXClFZGqkGgTQEpNfiLQ>
    <xmx:IvFNaq2FJIu2TlmfFGWRyLZaLfKZKJSSr-k5MbXRVrcmj38RraXQ6w>
    <xmx:IvFNan9i9b0KDD1sSHnuKtkY5hgkFcACeFzqYxTdclwYJK-Dkg-AgA>
    <xmx:IvFNaoVZOwZ662s9dXERMlc6cr2BaqgvgyMaXsow_PtPA5GonQyPcI5m>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jul 2026 02:41:37 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 8164c0bd (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 8 Jul 2026 06:41:36 +0000 (UTC)
Date: Wed, 8 Jul 2026 08:41:34 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com
Subject: Re: [PATCH v2 05/11] object-file: propagate files transaction errors
Message-ID: <ak3xHiOQfNxqFR58@pks.im>
References: <20260624041920.2601961-1-jltobler@gmail.com>
 <20260708041412.1157499-1-jltobler@gmail.com>
 <20260708041412.1157499-6-jltobler@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260708041412.1157499-6-jltobler@gmail.com>

On Tue, Jul 07, 2026 at 11:14:06PM -0500, Justin Tobler wrote:
> diff --git a/object-file.c b/object-file.c
> index e51389833a..64cb874fe7 100644
> --- a/object-file.c
> +++ b/object-file.c
> @@ -511,11 +511,15 @@ static void odb_transaction_files_prepare(struct odb_transaction *base)
>  	 * added at the time they call odb_transaction_files_begin.
>  	 */
>  	if (!transaction || transaction->objdir)
> -		return;
> +		return 0;
>  
>  	transaction->objdir = tmp_objdir_create(base->source->odb->repo, "bulk-fsync");
> -	if (transaction->objdir)
> -		tmp_objdir_replace_primary_odb(transaction->objdir, 0);
> +	if (!transaction->objdir)
> +		return -1;

As far as I can see we don't report any errors as part of
`tmp_objdir_create()`, so we should probably print an error here.

> @@ -1668,14 +1672,19 @@ static void odb_transaction_files_commit(struct odb_transaction *base)
>  		 * Make the object files visible in the primary ODB after their data is
>  		 * fully durable.
>  		 */
> -		tmp_objdir_migrate(transaction->objdir);
> +		if (tmp_objdir_migrate(transaction->objdir))
> +			return -1;
> +

Likewise.

Patrick
