Received: from sender4-pp-f112.zoho.com (sender4-pp-f112.zoho.com [136.143.188.112])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5FE63207
	for <git@vger.kernel.org>; Tue,  7 Oct 2025 09:44:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=136.143.188.112
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759830259; cv=pass; b=SK75f+AnWaPf8PbWh1DP5p4Qka2uLqesLHj4yLvO/VJ/JwVrhqPPwlwnHXL+3rpdrH9FfunxYGW6zmgjGBaCS/KkpxCsX3Kb4aJY/SNKAuJjkypd74SV8zFCz8VnwAgpMnwrgHUeLcnVDwxpAk80I3UTtr/CApkgoKFd9PlJmnM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759830259; c=relaxed/simple;
	bh=lPWj4D+ZtbVHotL3T4D6+pIVjd00HdaUNUDfHRLzSmw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=r2HI/b+LqLUuFAOKNNSfEAkfFt5NTdpGodDJu21ZdzBpPWmnkYa0Jk4ZEIomsXvEnPOELRIEpkr6CF1kxZ+dck6OsWMtKrHxpqyzeUu3OfIKo/p9Th82CokcbvdyO6WsozFxtbZipym89NooB7qAcam3+GWRUOemou6HxdEfp0o=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b=QhVQQXV9; arc=pass smtp.client-ip=136.143.188.112
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=collabora.com header.i=adrian.ratiu@collabora.com header.b="QhVQQXV9"
ARC-Seal: i=1; a=rsa-sha256; t=1759830236; cv=none; 
	d=zohomail.com; s=zohoarc; 
	b=LlahWQxNZCNFG4xrNIxN5TnVwMKW+ugaUjujWWWeLjAneKWcdk/72KLehAOP71iWPoV/EZd5pcoZJw2NLG0tqFa6yZQqui9DASRsIoyZQM8tcd2cpRVd17Lrw2V1jxbD6zdYdWWxuMQDAlBsCkSfB9JjsDhEY/Dimv+5po/B6uo=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
	t=1759830236; h=Content-Type:Cc:Cc:Date:Date:From:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:Subject:To:To:Message-Id:Reply-To; 
	bh=NfAVRDNZUk/woW+e+KmRvuFEFukOdbwFd/L8318SN+c=; 
	b=BabADZRjOoZuDDBkElW1LzLgPVFTR86AVqGZhDRidxrnSabSE9niFxoyWLrQWKWzLquUywJCHOcF1hktvrtbQftCv1d6DyujVwb5CUmBvX2owoG5lj2jiqBc5rg5cfW2fg6g/wU/gmg+ZQkbwHILfd5m4oKRfIMRZpjAdzsvtZw=
ARC-Authentication-Results: i=1; mx.zohomail.com;
	dkim=pass  header.i=collabora.com;
	spf=pass  smtp.mailfrom=adrian.ratiu@collabora.com;
	dmarc=pass header.from=<adrian.ratiu@collabora.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1759830236;
	s=zohomail; d=collabora.com; i=adrian.ratiu@collabora.com;
	h=From:From:To:To:Cc:Cc:Subject:Subject:In-Reply-To:References:Date:Date:Message-ID:MIME-Version:Content-Type:Message-Id:Reply-To;
	bh=NfAVRDNZUk/woW+e+KmRvuFEFukOdbwFd/L8318SN+c=;
	b=QhVQQXV9eUNnikjghb73SMr/2n41tVYCyRGAN9twlwwehQ3HYCYB5vLBN7xe3xPs
	HkKkysUHwKo3g8eUXQbR9EG8vHTd+84ZNQtTUKVdDclW/h39q6rLBYKQ+JRtORQo/Ri
	tQPxFCYWCReIGh/Q9Of7Orwq1wvhwBwgJ+V1Jeig=
Received: by mx.zohomail.com with SMTPS id 1759830234870603.7088288981083;
	Tue, 7 Oct 2025 02:43:54 -0700 (PDT)
From: Adrian Ratiu <adrian.ratiu@collabora.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>, Rodrigo
 Damazio Bovendorp <rdamazio@google.com>, Jeff King <peff@peff.net>, Aaron
 Schrab <aaron@schrab.com>, Jonathan Nieder <jrnieder@gmail.com>, Patrick
 Steinhardt <ps@pks.im>, Josh Steadmon <steadmon@google.com>, Ben Knoble
 <ben.knoble@gmail.com>, Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v3 3/5] strbuf: bring back is_rfc3986_unreserved
In-Reply-To: <xmqq8qhoq8hg.fsf@gitster.g>
References: <20250816213642.3517822-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-1-adrian.ratiu@collabora.com>
 <20251006112518.3764240-4-adrian.ratiu@collabora.com>
 <xmqq8qhoq8hg.fsf@gitster.g>
Date: Tue, 07 Oct 2025 12:43:47 +0300
Message-ID: <87ms633v3g.fsf@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-ZohoMailClient: External

On Mon, 06 Oct 2025, Junio C Hamano <gitster@pobox.com> wrote:
> Adrian Ratiu <adrian.ratiu@collabora.com> writes: 
> 
>> is_rfc3986_unreserved() was moved to credential-store.c and was 
>> made static by f89854362c (credential-store: move related 
>> functions to credential-store file, 2023-06-06) under a correct 
>> assumption, at the time, that it was the only place using it. 
>> 
>> However now we need it to apply URL-encoding to submodule names 
>> when constructing gitdir paths, to avoid conflicts, so bring it 
>> back. 
> 
> Why to strbuf, though? 
> 
> This does not have anything to do with what strbuf does.  I 
> could be possible that strbuf.c had some function that 
> encodes/decodes 3986 in a strbuf and this may have been a useful 
> helper for that feature, but it is apparent that this helper 
> function is needed by strbuf.[ch] in today's code, so moving it 
> to strbuf.[ch] makes no sense to me. 

Agreed. The only reason I moved it back to strbuf is because it 
was there in the past, however we can move it to anywhere else.

Perhaps url.[ch] is the best place. Would that be ok?

Other location suggestions are welcome btw. :)
