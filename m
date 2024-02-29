Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5AD6160641
	for <git@vger.kernel.org>; Thu, 29 Feb 2024 19:22:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709234537; cv=none; b=NEbMmIWXzQCOdMVkfgwXbSr74Z8XP6Nbs4qtQqHeEFL7pst0ZgMNG81xVX8O9odYW3dYKkfIyTpEAqYIG6EBZkoNdXqfM/5k2ypkCb9HJO9Y1gi/GnagODyET/daektA6rj/hTF/Wr1OlrWU56FmelEI/EA3W8cP74wh/dVsqrE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709234537; c=relaxed/simple;
	bh=W4O4Yg9CJWr2Gmpi79+qIrsYIYeX3kf/fnVAKwoYfWs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AciYGgSj/mmdNfdLx5Gen2gjFYrdNm5cMNcuxuwh5eJfxzqkmftsB1oRJMKk+6eHfv869hVzlUK8Uk4pT+CEHAZzp8Son8uX/vW3YxXw2EG+J456bEEp3e0PSNGOtOcfzVBDQZp1s/1JK85gngb8cD1s9lqLrW1FMSkKS4A5UFA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=cOkE0m5p; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="cOkE0m5p"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id A90641D1971;
	Thu, 29 Feb 2024 14:22:14 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=W4O4Yg9CJWr2
	Gmpi79+qIrsYIYeX3kf/fnVAKwoYfWs=; b=cOkE0m5pJXPBKk+O026h8RXpmhDq
	vN5US/Z40coDr5Cqs4IBKUs/wSFgluesETUGFPz+pKcDsC+WVnhdmcH970iacEld
	v0mS42f65HkBN8oWls8BO2zlEpmQJ5JIe9m7/p5kbrtBfn6wB8pjWBWvbWwVOawr
	15Qyz6RKfwtLyuo=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 9FE6F1D1970;
	Thu, 29 Feb 2024 14:22:14 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.176.30])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 0A5F91D196E;
	Thu, 29 Feb 2024 14:22:13 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>
Cc: Git List <git@vger.kernel.org>
Subject: Re: [PATCH 3/4] completion: reflog with implicit "show"
In-Reply-To: <ff1c650b-5776-4881-ad0d-c39d311fa7e7@gmail.com>
 (=?utf-8?Q?=22Rub=C3=A9n?= Justo"'s
	message of "Thu, 29 Feb 2024 20:00:26 +0100")
References: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
	<5991b58c-770c-4aaa-bce5-f396d9f7f16f@gmail.com>
	<xmqq8r4cnfju.fsf@gitster.g>
	<dd106d87-3363-426a-90a2-16e1f2d04661@gmail.com>
	<xmqqwmqyr3mb.fsf@gitster.g>
	<abe1c96d-48f7-4355-8688-e1fb05c67448@gmail.com>
	<ff1c650b-5776-4881-ad0d-c39d311fa7e7@gmail.com>
Date: Thu, 29 Feb 2024 11:22:12 -0800
Message-ID: <xmqqo7bzf53v.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 D7E8A46E-D737-11EE-99AD-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Rub=C3=A9n Justo <rjusto@gmail.com> writes:

> I am happy with the current iteration and I still think that mixing
> branch names with options is a source of confusion.
>
> However, this topic in the latest 'What's cooking' is marked with:
>
>  Expecting a reroll.
>  cf. <dd106d87-3363-426a-90a2-16e1f2d04661@gmail.com>
>  source: <98daf977-dbad-4d3b-a293-6a769895088f@gmail.com>
>
> I am confused about what the expectation is.

Expectation is to show both possible commands and branch names
available so that users with enough typing can pick from either, as
I do see it even more confusing if only branch names (or only
command names) are visible sometimes (namely, if the prefix is
shared by both) but some other times command names (or branch names)
are completed just fine (namely, if the prefix is unique to only one
set of names between command names and branch names).

