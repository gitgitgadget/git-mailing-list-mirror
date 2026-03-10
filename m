Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AB4A33D6477
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 17:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773165097; cv=none; b=sdveDo+kD6Ri0YMcCAH3lsryM4CWD2MFCBVgC7nR13pgN/pyKYwrj0/eXolcCLrP+d62GdsmUca/WujlfWalsXl+VXal5cOXGr2ua5Lxvszq5bhcRChauZl4zJsoW3m/mz5+2//xqkUPiilnC5/5SpQGD5OOL75+AascgGZSdB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773165097; c=relaxed/simple;
	bh=5H2S/veUaTV/uxwzUSVVqq/90W1p8xX3ueS77I2lvok=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f6hV5siZd9hCctVgE7wPvtgGvd0w0laN2cjiialDSGxoFWGkEYvxLlCsxoPJUUecBwH6csu5rQefOe8wksxoUE7vLkye27BQHa0nANPLsl6kYETxD4R01+YryH7bu4k/iNlIwNxkWa2+ADWSZJgSPEENsM6QCuTwTB59IiPTPEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fH2hkre3; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=j9JZKwdM; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fH2hkre3";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="j9JZKwdM"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B4C5A140016A;
	Tue, 10 Mar 2026 13:51:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 10 Mar 2026 13:51:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773165094; x=1773251494; bh=p2IcLx9Ra8
	WgqtalRjcX05ycWDja9xHNH7l00mcbVvc=; b=fH2hkre3xCQ1J/GPUSj01oz27Q
	EEbvUaNIyu8nQnWfGysBWznuPlxTJxB8nld8tnjtndJ7FGaWPkTNONZioOBHdjWK
	bEo/LMM2Ik0YxqDbDkA+EXl9TB5nf4ugJvnzRCrEFLf/refggRFePdDfypgSWC8K
	yF4Usf5mxDcUuf4eNoh5GXvr/9PyoJYXALrYWdPpECHWFXGP0fB83G9xSInE4J8s
	FR4EVHhrSBBZapJBS373KiOOupdgyoPzNkf4QI1fvTxITPs6gT3ngQ8re2B+nl03
	bHGqW1AfZx0H9vLjKD09mUTm06P8D2/CdqeBrWBHL4X0UpTYuWIFf+mHYSLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773165094; x=1773251494; bh=p2IcLx9Ra8WgqtalRjcX05ycWDja9xHNH7l
	00mcbVvc=; b=j9JZKwdMvZvom3FLbQUbRw64CPB1SDf9afe52YLz42sOTKm2ZH+
	tRz5xKbJPUaxZvWGGnicCeO/fwKYAC3/Y8tjTwJUZVMHc+5ynJdwszMK3IFoN25f
	5NDN1vd0ZubnEeXwHxaiZgfrP1bwCKPfHKPZe1VE+PQp1catnIEMmuVSqpVT4pMX
	RtzVywtUkPxUeOwgmsUeAgnLuRywQSrIFrpmexO/+26N0BVoIIsIPtQ7E16PMfnZ
	AqzxEJhyQ/EQEVQvt7t2kAa+txuYlmlsDJ+NLTU/eMjKZplcxMhAZ+TtOsJxGVtD
	50lKnBhJF6KbPNl1HZzpL/uit4b/qKCBCeA==
X-ME-Sender: <xms:JlqwaSJdI06ptmAQckyRY7di835vdE61FOuyZCpZZw4bkgWKAzWX6g>
    <xme:JlqwaRkr5RM6Gq_KHvpqgNEcRj3Nn6F6GeEfAEh7PoQe8caP757VyUwFGmbJYMtNw
    QdK0Qw8KSfkYvc990fCVQ0DxMHbdkc7uaXnCl5GAFW64KprY3JUDvA>
X-ME-Received: <xmr:JlqwaQHY1frjRj7uhn0GLhmQY-_nJ_DBJkD2wB4nukjRVoxtfYCRgA1jp5MBEoeTMpBrgHe2JmQTEB0tO7tmrqjnocxp5I77Pw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeduieeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:JlqwaRFi1NTYI7wq44hJPFieh-pCvxSG0CXSJh4fcoI8lFtlkJ79hA>
    <xmx:JlqwadOClv4w0opxiw_4a6BlPw98D85jPFTO58Ci642OqG23cLqz6w>
    <xmx:JlqwaQHHtD5_Cgrj58LBRo2-fr-waahhfaVJ0q-8d6zU_XWFRPMAwg>
    <xmx:JlqwaUOrgt7FwLY3TC6WYkQhtYPkG3updB4EXs3TyGQOV-C2RCReEA>
    <xmx:JlqwaZsZOTJMb3cuIYMKZuiRQzVyBmdQTPnIChCrXDfsv70b-k5jyYDK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 13:51:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 5/6] odb/source: introduce generic object counting
In-Reply-To: <20260310-b4-pks-odb-source-count-objects-v1-5-109e07d425f4@pks.im>
	(Patrick Steinhardt's message of "Tue, 10 Mar 2026 16:18:25 +0100")
References: <20260310-b4-pks-odb-source-count-objects-v1-0-109e07d425f4@pks.im>
	<20260310-b4-pks-odb-source-count-objects-v1-5-109e07d425f4@pks.im>
Date: Tue, 10 Mar 2026 10:51:33 -0700
Message-ID: <xmqqfr67vahm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> +static int odb_source_files_count_objects(struct odb_source *source,
> +					  enum odb_count_objects_flags flags,
> +					  unsigned long *out)
> +{
> +	struct odb_source_files *files = odb_source_files_downcast(source);
> +	unsigned long count;
> +	int ret;
> +
> +	ret = packfile_store_count_objects(files->packed, flags, &count);
> +	if (ret < 0)
> +		goto out;
> +
> +	if (!(flags & ODB_COUNT_OBJECTS_APPROXIMATE)) {
> +		unsigned long loose_count;
> +
> +		ret = odb_source_loose_count_objects(source, flags, &loose_count);
> +		if (ret < 0)
> +			goto out;
> +
> +		count += loose_count;
> +	}
> +
> +	*out = count;
> +	ret = 0;
> +
> +out:
> +	return ret;
> +}

The design to assume that the majority of objects should be in the
packfiles and the number of loose objects can be ignored when we are
getting approximation is inherited from the world before this
series, I think, which is a valid choice for this series to make.

As your "get an approximate count of loose objects" counts a single
shared fully, instead of punting as soon as the limit is hit, we
could ask that function and add it in when the APPROXIMATE flag is
passed, and get a bit more accurate number cheaply even when we are
approximating.  I am not sure what the pros and cons of doing so
myself, but you may already have thought about it and rejected it,
perhaps?

Thanks for a pleasant read.
Queued.

