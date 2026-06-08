Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7FBFA3AEF59
	for <git@vger.kernel.org>; Mon,  8 Jun 2026 21:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780954597; cv=none; b=S2nso6uwNe7ZyVz6UBpiEV7rOPQXb8MllGh8LHJRNdBKEG5hTLXpOIU9ev46drIgK0G0JVinNR3pPBGAZ2W7j6t2z+ogfGhwfzACugwOA2CKf14F5DoBcgXJMxDKd5X6UOkni1zDc95/gGV1PMI9E+DiWFY553tOX1fE8bNzC/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780954597; c=relaxed/simple;
	bh=7Tfqjt/t/u8ND9BeHFfMenoTO5ZVZCGX20ljzjFnfiE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=KGrqByWikL32+60I69CNZgECnLEjUoh8GIXyFXWittHS1pDnmJYySfqT+iFCOanoo594rN7nVS6acEK2tRlrzENq434TWheu2yEWqaAX/TbOS6EA2+NhVsSRAXHrRWolx+Mdif32QRfAvF/C9EHHpc1ATitih6wgqzoBbClfibg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=agowSJy4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MM4Pheu2; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="agowSJy4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MM4Pheu2"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5CD0A7A015B;
	Mon,  8 Jun 2026 17:36:35 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 08 Jun 2026 17:36:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780954595; x=1781040995; bh=42SrW77VFG
	Lsxzo5E2KErXCfH7aDyQZFzPs4wTXiOa0=; b=agowSJy4q/OM1CC6b/a+RqYhNr
	suNQA1DZux4XieOoH8VTMYC/6pViUifXQPV+Xr28hGNp/XSy89roF+vPRSJACHzl
	R5DgxD03Yk19UH+TwLaXGMLeAvbMOFBjnMe0W7TRNtuH4hPENP3Lv88G+HPPJPKE
	QMVnKigMlE3heaRYrwKgbNVvEy2We/Qp2CmxlE0FBscTU2rWTia4Hb8oI5/PEQ0o
	fTEp+bfk5j/Tt5itr7qhjb8ODbx5ZqAJcdMAhdVCHT3gPkU0ct3opQiISlbF7rWb
	XXiVAeId5pyK5k3TFaPO4HHbVrZHDKeAD3zZQrWLoGsiu/jSPP4jjZx683LA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780954595; x=1781040995; bh=42SrW77VFGLsxzo5E2KErXCfH7aDyQZFzPs
	4wTXiOa0=; b=MM4Pheu28+NLYG7OTfBrc9YayOVKGjmjg5Cxpn930u0cNPYs7Ps
	zX+b/Bk4HKlnzToafYD1tLwOB28qMC2fTlZzIl1k/+RVCdRbFgOsfxvKMt6ykQbq
	Omg4oVj5fsuT01qutMllwCb4BAAuMSPPDgNIbT0fuJNgaNX3NjgBwFyJFxbGM3or
	bRkMWhTgYZzRPHVsF2fnFrlGuukYL7cafi/kSeqmoj0dYBt3p8wDAWOnMWvfEriH
	5UpadJKUfeIQuDhPlFoaEHUZ+7FQ9GJsRXRNZVcvyK38ucnYV9ZH6d5Nh/k7eAVy
	jFgHPodE1F6CihfxVKsscO6NwPQldP+XRsg==
X-ME-Sender: <xms:4zUnansfm8ihCUC8M4vQoEessDqWbruFf8FxlBt6MPtgoN6MZ4PJ7w>
    <xme:4zUnaqvthnZjh4pRxj9LGXkRpsPFNtkEV4A9jmfnJkZ2GiEbGHmO8eLXUfxT0iVrt
    r0drcR5R9SNPW1PsoofNFrZJFpmRxNz5fiZzO_letv1UzeBNq2sDg>
X-ME-Received: <xmr:4zUnatCv4v8byE6c92kOKpP1xGKCOqZGAeomD2vqgs3zGgQfQyQq2sQQ05rBb5dPwkLucKpSfyj3rB1MPnR4W6arB5A0aRU_CWHk>
X-ME-Proxy-Cause: dmFkZTEmgAOD1Wrn17fjdyCDsbbA6eS+cst8pKS573yjPGf4oHCLskWOdC8zgHoBizLIww
    DyJgwMyUFPDwCMsvdS8363p6680V0BN627UQ5y1i8bW457upjL36qENSrjb69lU+pZf/re
    zCnommDZSDIO4AM/cZ6rXRKTFNmwSfe73vJ7NK6twEdgXvJBAGfKrlVoyo3fvfc4G7gMCG
    PxkyZnsddyLv31N74UK+/ZrFiYesQrrVBAFZp65qbY2vFxB8pgjA/llSOlaIEaDPrdZvlp
    iUpylWZZnCnErDCOMAPpTExoQTOaNRlIUwa9f+TUlfhJc8+xXa19oRCdIfWjBXl2khq2Ms
    gdfZG7kTx+VG6Q7SIlmlSiu3Htn+HkT8Gfr9XwKNJqRsCUM9tapvDbzGfb0h32ZIKJhjye
    vfxl4Zh8FnXcs1slpYhAZBsGGuy82oFdpwZWNFBXOQrjXabb0GQdYOVtnJUoYtUrcslma6
    0H56P5oKeG4fUUUaTIsijTqLgiAg918Q4gCcObAUUuT/unmR7uS8TBl2GVF14mZVsuYlKI
    IB5nuQNzp0k8tRh4fv8GcB3ZyTu6pxr6eZ16FrBMReD9Ijkhd9B/0QclS/rHGV+aGt2BZb
    Zb7JyH8GQsQpkc5x7Hk2opOK02Sol0rzNVEbormLDAH7/vJpjBm9kO9W51Sw
X-ME-Proxy: <xmx:4zUnasMp6Z-e24mn278KqToUzuijkXawSqWM-_QfkqF0GenKYyGUxw>
    <xmx:4zUnamzORHP7tVovrF3fx-8LCkkVkhkxfQkGAjdNHDOakkv9gGL9qQ>
    <xmx:4zUnasVLniuMwzbjOfBKl0QAswHbzbw0gs0uOhhHtMCMXwy7qMqlZg>
    <xmx:4zUnaoOc7-0MB-ZYVtD-K5emqtNZklwJxisiko6ZsVDnhav9XPaz2g>
    <xmx:4zUnag540xOyIMOnjsPdtHlb7m2WOWGkY38uXoA29asdjEBL3rtcydew>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 8 Jun 2026 17:36:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tamir Duberstein <tamird@gmail.com>
Cc: git@vger.kernel.org,  Karthik Nayak <karthik.188@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  Victoria Dye <vdye@github.com>,  ZheNing Hu
 <adlternative@gmail.com>
Subject: Re: [PATCH] ref-filter: restore prefix-scoped iteration
In-Reply-To: <20260605-fix-git-branch-regression-v1-1-02f40ad40929@gmail.com>
	(Tamir Duberstein's message of "Fri, 05 Jun 2026 12:43:03 -0400")
References: <20260605-fix-git-branch-regression-v1-1-02f40ad40929@gmail.com>
Date: Mon, 08 Jun 2026 14:36:33 -0700
Message-ID: <xmqqpl20vhni.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tamir Duberstein <tamird@gmail.com> writes:

> diff --git a/ref-filter.c b/ref-filter.c
> index 1da4c0e60d..2388a57b39 100644
> --- a/ref-filter.c
> +++ b/ref-filter.c
> @@ -3315,19 +3315,31 @@ static int do_filter_refs(struct ref_filter *filter, unsigned int type, refs_for
>  		prefix = "refs/tags/";
>  
>  	if (prefix) {

Below, adding an extra call to get_main_ref_store(the_repository)
makes one line unnecessarily split and harder to read.  How about
doing

		struct ref_store *store = get_main_ref_store(the_repository);

upfront here, and then use that to replace these two calls of
get_main_ref_store(the_repository)?

> +		if (filter->start_after) {
> +			struct ref_iterator *iter;
>  
> +			iter = refs_ref_iterator_begin(
> +				get_main_ref_store(the_repository), "", NULL, 0,
> +				0);
>  
>  			ret = start_ref_iterator_after(iter, filter->start_after);
> +			if (!ret)
> +				ret = do_for_each_ref_iterator(iter, fn,
> +							       cb_data);
> +		} else {
> +			/*
> +			 * Pass the prefix during construction because the files
> +			 * backend primes loose refs before a later seek can
> +			 * narrow the iterator.
> +			 */
> +			struct refs_for_each_ref_options opts = {
> +				.prefix = prefix,
> +			};
>  
> +			ret = refs_for_each_ref_ext(
> +				get_main_ref_store(the_repository), fn, cb_data,
> +				&opts);
> +		}
>  	} else if (filter->kind & FILTER_REFS_REGULAR) {
