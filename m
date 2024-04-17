Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2819D171E5E
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 16:58:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713373110; cv=none; b=o0MBzTe/f7jpfl1q0e9hBLmVV5xl8ZUuW0fOeCaiu41aKgxDg4mzU37VUQZaNimyNUmUYslak1tFkGt4vEltKbTN85zLxJzr7WtCcuQJIUcpho8imZwyg5oEvAMyph0DBr2Tgw4OFl10O3Z+V337TYzI7f4DEBvop6xr3lKMgCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713373110; c=relaxed/simple;
	bh=iiAcGKvKfFxQgXPesibR4T+lIxriElHmgOIt+wIUOvo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ta/s9JzcVaggTrPTJ5E5eDrot3msHlo6E3v+kdPrwM8D7hiQ8dmZ7ahVkUgnj6mh/A2ETwhDCYCkRsv6V9Rg282UIB3ThCfm+9uLsaPo/03+GiA/zi09rDJB7RqzmXMKu6WjH8cpHSu6Vp8jTsdpeGbgzslXMU0ttLcfgkXCd9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=v0DuDdkl; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="v0DuDdkl"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EEA641DB427;
	Wed, 17 Apr 2024 12:58:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=iiAcGKvKfFxQgXPesibR4T+lIxriElHmgOIt+w
	IUOvo=; b=v0DuDdkl/siLdfCsi+KcdRfIRB1rJwMtRBd/W0BfW9hpYfazRHwyPs
	BFSPH7AWlwqfm6jwUrUeHTUuKlmHthXELODG27IPA+pXyVo7gVUmKW3U7nzgq/RW
	VvS2mEIXnikFn5tN0IfKiKJ21xFY1jW5kXA26G7hwVb3s6Tt0D8Hc=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id E6EBA1DB426;
	Wed, 17 Apr 2024 12:58:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 5BEA11DB424;
	Wed, 17 Apr 2024 12:58:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Enrico Mrass <emrass@google.com>
Cc: steadmon@google.com,  avarab@gmail.com,  christian.couder@gmail.com,
  git@vger.kernel.org,  me@ttaylorr.com
Subject: Re: [RFC PATCH] doc: describe the project's decision-making process
In-Reply-To: <20240417163244.651791-1-emrass@google.com> (Enrico Mrass's
	message of "Wed, 17 Apr 2024 16:32:44 +0000")
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
	<20240417163244.651791-1-emrass@google.com>
Date: Wed, 17 Apr 2024 09:58:26 -0700
Message-ID: <xmqqr0f47wp9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B5D7D57E-FCDB-11EE-B485-25B3960A682E-77302942!pb-smtp2.pobox.com

Enrico Mrass <emrass@google.com> writes:

> I'd be curious to learn about norms or practices applied when no consensus
> could be reached. It seems worth elaborating on that as part of documenting the
> decision-making process.

I may be forgetting things, but I do not know if there is a concrete
"here is a norm that we have been using to reach a consensus, not
just written down but it has been there" in the first place, let
alone "here is what we do to resolve an irreconcilable differences".

"We discuss and try to reach a consensus in an amicable way,
sticking to CoC, etc." has mostly been good enough for our happy
family, perhaps?

> ... However, nothing
> in the current description strikes me as specific to these larger-scale
> decisions.

I agree with that.
