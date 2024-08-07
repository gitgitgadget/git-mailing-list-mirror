Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88DBB5BAF0
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 16:20:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723047633; cv=none; b=Jq8mQZrpeTbEGgeAJ4uRuTzMNlC4I0fQmUUtROZVbs5GSGNQwuAav0H0omp0Z+WB7gaBTnsiK04w3F8H6AmClN29LTI7ajv4fMyIf4/FtbhVHDJLXRhMv09leCgABmg30ZxsL6puZEvBXoX6XbTmzgcmwhG3roWCs6yHeKv9QfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723047633; c=relaxed/simple;
	bh=LnyggBeWV5i4Nrj0j2SNP8D4F2S2PTlDnG5LJ58b1RE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=s9cCAyAPwFggBE/IuAP8T/CR7sOwcruLA8U3koDeN84BsMwD44vOzbvWXReU3gAtymxyxdaEJqam68nW1Lhx8cpAdLBUt8b7kLaFn23wP4M1QuGON6HT/uRMP1vkE1/QtoaUoiIJ6apCUjheUa2ZsuBu3bdBff7cDaPto8oNqbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=pSuxrT04; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="pSuxrT04"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 74E5518A94;
	Wed,  7 Aug 2024 12:20:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=LnyggBeWV5i4Nrj0j2SNP8D4F2S2PTlDnG5LJ5
	8b1RE=; b=pSuxrT04MM7c/WUPuNPgSal2tGjEPDceoyg2Ekd34Z/OD4qFrNaMRd
	CdxNmKnuPZ9Qm1wZJaFeKjuUQEmpnZmZHiBvHvXB00Bnsw0ojCM8JY903czmdtko
	Uf0GOGN8BP/0zvrmir/q7d+HixhgMdmcRRNofOI+We0xLqALpCcHY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 6CF7618A93;
	Wed,  7 Aug 2024 12:20:30 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id D3D3E18A92;
	Wed,  7 Aug 2024 12:20:29 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Ghanshyam Thakkar <shyamthakkar001@gmail.com>,  git@vger.kernel.org,
  Christian Couder <chriscool@tuxfamily.org>,  Kaartic Sivaraam
 <kaartic.sivaraam@gmail.com>,  Josh Steadmon <steadmon@google.com>,
  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [GSoC][PATCH v5] t: port helper/test-hashmap.c to
 unit-tests/t-hashmap.c
In-Reply-To: <CAP8UFD3VwiAbGvzgi14EcEQLX6Gs7pNy+dvZcXkPOueKpJS7HA@mail.gmail.com>
	(Christian Couder's message of "Wed, 7 Aug 2024 16:33:43 +0200")
References: <20240730115101.188100-1-author@example.com>
	<20240803133517.73308-2-shyamthakkar001@gmail.com>
	<CAP8UFD3VwiAbGvzgi14EcEQLX6Gs7pNy+dvZcXkPOueKpJS7HA@mail.gmail.com>
Date: Wed, 07 Aug 2024 09:20:28 -0700
Message-ID: <xmqq34ngpann.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F69B854C-54D8-11EF-BBF5-9B0F950A682E-77302942!pb-smtp2.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

>> Range-diff against v4:
>
> Nit (not worth a reroll): the range-diff usually goes before the
> actual patch in the section starting with a line containing only 3
> dashes

This comes from https://lore.kernel.org/git/Zk7UsJjhY_FV2z8C@tanuki/
that eventually became 2fa04ceb (format-patch: move range/inter diff
at the end of a single patch output, 2024-05-24).
