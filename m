Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF22970CB6
	for <git@vger.kernel.org>; Fri,  1 Mar 2024 16:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709310127; cv=none; b=iaM8kEJctDZxRvU/mHCT496vcNWR2+vwAtSxHtOTyh1bM2OVcNsMDfBr+alXXezMt6AkfGtm0F2tAJCePLe3OxYQ1Zf2aQBUm01tC1mrWOpC7HbqMWsSL6YRvl1Ecqv0eMuAOh+S10uRg8OftF3neEvbkZMibrt7+wWJ+Og5p1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709310127; c=relaxed/simple;
	bh=nFYskn4aFSLiqaF2PQhT/OQl14IWnevgTOEDNW4YCBA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mZsYphetFobn6S6h+CVzd9ajP869UrBqlReR58p2Q9tA4mmx00n4i2ciTmW0LI3pIpE+3/CJgyw3RfXWOi6ifrWBjIX9EhmZ2bzuphA6N8oRN37PgHIaDwIeBWhzZf5qnqKlwRdY2YNcBGjLDodNFf4ynVMusczjbv+8Ih/mSTA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=KtcwASu4; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="KtcwASu4"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 265521D63F;
	Fri,  1 Mar 2024 11:22:05 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=nFYskn4aFSLiqaF2PQhT/OQl14IWnevgTOEDNW
	4YCBA=; b=KtcwASu4jIJjqxypZiV+BNUgTiXL6TVsxx3NzirOTBXkRw+wVYHOr0
	dliBv0T47/9awiV2X4bKVTnBFCL2CT2E27VVxS9YVWF4VJtr93i5Srw/jhCN6kf9
	+c/Luo1CjGKeX2pxAgQ/6KmqURdURFrr1wcvgyNTGCFWLOH06GKZ0=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 1F6D31D63E;
	Fri,  1 Mar 2024 11:22:05 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 259D91D63B;
	Fri,  1 Mar 2024 11:22:01 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Feb 2024, #09; Tue, 27)
In-Reply-To: <CAOLa=ZQAxGFDrBmq0+Q77YcfT4hBivRu9oOGZF-r81F49P+00Q@mail.gmail.com>
	(Karthik Nayak's message of "Fri, 1 Mar 2024 02:54:37 -0800")
References: <xmqqjzmpm9b8.fsf@gitster.g>
	<CAOLa=ZQAxGFDrBmq0+Q77YcfT4hBivRu9oOGZF-r81F49P+00Q@mail.gmail.com>
Date: Fri, 01 Mar 2024 08:21:59 -0800
Message-ID: <xmqqjzml9b2w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 D5561D34-D7E7-11EE-8E24-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Karthik Nayak <karthik.188@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>> * kn/for-all-refs (2024-02-23) 6 commits
>>   (merged to 'next' on 2024-02-27 at aef2406cca)
>>  + for-each-ref: add new option to include root refs
>>  + ref-filter: rename 'FILTER_REFS_ALL' to 'FILTER_REFS_REGULAR'
>>  + refs: introduce `refs_for_each_include_root_refs()`
>>  + refs: extract out `loose_fill_ref_dir_regular_file()`
>>  + refs: introduce `is_pseudoref()` and `is_headref()`
>>  + Merge branch 'ps/reftable-backend' into kn/for-all-refs
>>
>>  "git for-each-ref" filters its output with prefixes given from the
>>  command line, but it did not honor an empty string to mean "pass
>>  everything", which has been corrected.
>>
>>  Will merge to 'master'.
>>  source: <20240223100112.44127-1-karthik.188@gmail.com>
>
> Thanks, the description here needs to be modified since we moved from
> the `an empty string to mean "pass everything"` to providing the
> `--include-root-refs` option.

Good point.  I just updated the draft for the next issue of
'whats-cooking.txt' to read like this:

 "git for-each-ref" learned "--include-root-refs" option to show
 even the stuff outside the 'refs/' hierarchy.

Thanks.
