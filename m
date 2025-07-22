Received: from out-171.mta1.migadu.com (out-171.mta1.migadu.com [95.215.58.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1874D1DE2B5
	for <git@vger.kernel.org>; Tue, 22 Jul 2025 16:06:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753200417; cv=none; b=Dq3/7cqsqMkp9ZcnLEcfZimIo3IYNIFZsuZrQ301iIQs8nLRtKQtmdARxwXt81cibv5TsGe0i/9XP6SKxu7s47aLV2SA3PVJPjlIDoJpPBVOClbu5VZJhq8lOCix/+dkfh/YA89VQs2U42iyOUXtSNQZqp0O7hoBXrZDtTx7Ycw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753200417; c=relaxed/simple;
	bh=YG86y4ZjNguhNm23Luqfu2eral9L0OP3ZFVdbUsAYWo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ASHNqHUywvFOtHcGrO/af/bsS9+NvdeXMAXwg8Z4Qfq7NQDY7trJVCZ+Rn+c1/Hae0rnbI9LwOGKDVgmeu5UHrmAcgAOI9P20HwfyeinADuXT6k8hCoWNhtOM8XIOgZU3sCM/iEj418NEGpUIQ9WLfwj+/H0KcivuTbS2RkSIEo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com; spf=fail smtp.mailfrom=iotcl.com; dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b=ovE7CeTQ; arc=none smtp.client-ip=95.215.58.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=iotcl.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=iotcl.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=iotcl.com header.i=@iotcl.com header.b="ovE7CeTQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iotcl.com; s=key1;
	t=1753200412;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=xL1MzWeyA6VWHoZUVJhrX8pAt021YitLUqUwC7XkeNs=;
	b=ovE7CeTQ4ErTn/bF3YEBvZGmXBBmV6dUTO+BcInvyrnTXEbk9+sRnaX+zYfXMotP44PB3a
	u6Iz/b7IQCgnmlpQjlRCJWKoCnj9t7OIBzlgITugJ+kuNNz4UJo0zasRDfz4prX+nuM7k2
	N3jfWTa7nSkxpb5eKDlGjH22m3BlWmA=
From: Toon Claes <toon@iotcl.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>, Derrick Stolee <stolee@gmail.com>,
 Taylor Blau <me@ttaylorr.com>
Subject: Re: [PATCH v5 5/6] last-modified: support --extended format
In-Reply-To: <xmqq5xfp4d15.fsf@gitster.g>
References: <20250630-toon-new-blame-tree-v3-0-3516025dc3bc@iotcl.com>
 <20250716133518.1788126-5-toon@iotcl.com> <xmqqseiu4f6p.fsf@gitster.g>
 <xmqq5xfp4d15.fsf@gitster.g>
Date: Tue, 22 Jul 2025 18:06:29 +0200
Message-ID: <87y0sgjjlm.fsf@iotcl.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Migadu-Flow: FLOW_OUT

Junio C Hamano <gitster@pobox.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> Hmph.  This hardcoding of everything does not look easy to maintain.
>>
>> Besides, the test will fail rather miserably when run with SHA-256
>> hash (e.g., post Git 3.0 where the "git init" command by default
>> will give you a repository with new hash).
>>
>> It looks somewhat inconsistent that tree is shown with its object
>> name, but commit is not.
>
>
> I do not address neither the first point or the last point above,
> but at least something like the attached patch needs to be squashed
> into this step to make the SHA-256 tests pass.

Thank you for the suggestion. But I think we can expect this commit to
be excluded whenever I reroll this series. But I appreciate the effort.
I should have taken SHA256 into account in the first place.


-- 
Cheers,
Toon
