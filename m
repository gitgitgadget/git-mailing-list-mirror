Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F3B3219B3E2
	for <git@vger.kernel.org>; Tue, 16 Jul 2024 15:18:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721143122; cv=none; b=WVzS1cHXW+VFZExsG7N+Wj3vYgpAoYOFlWvsxdu7nERSTWBaIJToHQm9W1c5nrQxVpn9ynIwwlK0UGEm9sohPP/4/gRhUS7kQNYhejLLqu9DhZT0GiwkBv0muKAPU+8DzQCcmrD9jg5NS3syA2JyIXX/yKH+2F1CdH2XU8zKpu0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721143122; c=relaxed/simple;
	bh=HtW/9J4ilKxegISdsdXqHJevfEFshDPfIBhvTMoiLC0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mAoW7wMB17+PClnUXeWCRBRLynh/QjVQROj4hmfMyeTZKP9NF6aTDzWcAZifxwsxSchpwsNYkvFRSRCug+KTu46UGiTdnRo1RxpLWhhAQVOXqSEqW50iBaggHTItMb+JT039E4L8XsdoJ1krNGuSjTIBhr+QBv3r64ZfRPrGBjc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xcCgqivD; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xcCgqivD"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 22A5B3D13F;
	Tue, 16 Jul 2024 11:18:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=HtW/9J4ilKxegISdsdXqHJevfEFshDPfIBhvTM
	oiLC0=; b=xcCgqivDVxTk1EctOvEWlkPnKIbmB3xk9hi36sOyaxJe29I/K2pu7M
	zX8smYODY/x7IqeLD5/DCXFOQxXrntcE15BdVJDyWOKCU0jrBgO3al0QIreWMuv9
	PpB+SvINzgUe07OUwDAMdPvt5tjHibqJy0LWX/Ho7ryCZQGCBd+Ak=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 1996B3D13E;
	Tue, 16 Jul 2024 11:18:34 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 784813D13D;
	Tue, 16 Jul 2024 11:18:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Ghanshyam Thakkar" <shyamthakkar001@gmail.com>
Cc: <git@vger.kernel.org>
Subject: Re: What's cooking in git.git (Jul 2024, #04; Fri, 12)
In-Reply-To: <D2QZXA8Q36E0.1FAM9VRDCL2WW@gmail.com> (Ghanshyam Thakkar's
	message of "Tue, 16 Jul 2024 18:56:12 +0530")
References: <xmqqbk31b6le.fsf@gitster.g>
	<D2QZXA8Q36E0.1FAM9VRDCL2WW@gmail.com>
Date: Tue, 16 Jul 2024 08:18:32 -0700
Message-ID: <xmqqcyndcqlz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AA632076-4386-11EF-A384-5B6DE52EC81B-77302942!pb-smtp1.pobox.com

"Ghanshyam Thakkar" <shyamthakkar001@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> * gt/unit-test-hashmap (2024-07-12) 1 commit
>> - t: port helper/test-hashmap.c to unit-tests/t-hashmap.c
>>
>> An existing test of hashmap API has been rewritten with the
>> unit-test framework.
>>
>> What's the doneness of this one?
>> source: <20240711235159.5320-1-shyamthakkar001@gmail.com>
>
> I believe I've addressed all the concerns from the previous version,

Yes, let's.
