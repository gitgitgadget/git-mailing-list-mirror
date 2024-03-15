Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 861E53D575
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 15:45:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710517527; cv=none; b=WHG3QVRVfRSKb9I+5NtinXqAA1zfxATuf1WuZ2eAh1rGWObg8Q/Gqv2sQV4mXnfbsTQNYLItL01lmwHZ+t0xbygP3H1tvpQ1CTZ20/46tjYessBYYJSN3jfJOCbLyZyrp+FkEcMxcvFuCCW+ufaiyLsZkt8Ugk3hd3lQ5E7VKIs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710517527; c=relaxed/simple;
	bh=fLkBuni8roDQzGkk+7ZGY7Un+hk2n+c/esdkY5nQLKc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GdWf1ihqpiZGa3Ws6zMvNjPPPxuo8cJIAv21kZQ2dkmZxVObiKIZLSELoWWKMj8zPPq9aItpf+DsK1g4Bg818w+EHFFA4lU1BuQ+u9VwZYgecz+gK129g1b4bRoW1poiPgVRVPTksHFy7SMCX16e+Ao0JqhKVoyF+7J3hsfUtzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=wVCK2kyf; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="wVCK2kyf"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1EA9831EAF;
	Fri, 15 Mar 2024 11:42:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fLkBuni8roDQzGkk+7ZGY7Un+hk2n+c/esdkY5
	nQLKc=; b=wVCK2kyfB0n1AYjtm80UlBFaLbCEr6N9RBDDLvnpAsPSw9yHrwvD3T
	Rn1EC9auyr4syBJbdY/YOMTMS3NTUNVW29QN9YALVm0IAEJ4ED9BdwRezVpruY6G
	npwG5cOgPLTXIp6008Ypo9PNa0MuDJPIVFohzJfkP18BZ4ocz79Fs=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 1724C31EAE;
	Fri, 15 Mar 2024 11:42:56 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id AB17131EAD;
	Fri, 15 Mar 2024 11:42:52 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christopher Lindee <christopher.lindee@webpros.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH 0/2] Optionally support push options on up-to-date branches
In-Reply-To: <PH0PR14MB4702D85D5D40F910A97B49E98D282@PH0PR14MB4702.namprd14.prod.outlook.com>
	(Christopher Lindee's message of "Fri, 15 Mar 2024 00:19:57 +0000")
References: <SA1PR14MB4691B63C740F95D7D8A495628D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
	<xmqqa5n168nh.fsf@gitster.g>
	<ZfOAdVy9_UfTj3zE@tapette.crustytoothpaste.net>
	<xmqqv85otmsb.fsf@gitster.g>
	<PH0PR14MB4702D85D5D40F910A97B49E98D282@PH0PR14MB4702.namprd14.prod.outlook.com>
Date: Fri, 15 Mar 2024 08:42:51 -0700
Message-ID: <xmqqil1ntsas.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AF559C6C-E2E2-11EE-8FDB-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Christopher Lindee <christopher.lindee@webpros.com> writes:

> Junio C Hamano writes:
>
>> In any case, I am OK with the feature.  I just was wondering if the
>> end-user experience may become simpler and easier if we did not have
>> to have a command line option.
>
> I think we should have the command line option, if only for backwards 
> compatibility.  The question on my mind is: do we default to on or off?

It seems like the concensus is we want this as an opt-in feature.
Defaults off, with an explicit command line option.

Thanks.
