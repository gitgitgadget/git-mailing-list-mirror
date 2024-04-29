Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B915584A2B
	for <git@vger.kernel.org>; Mon, 29 Apr 2024 16:25:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714407903; cv=none; b=DJ46TCCvwWyeEl4Zl5nAG/dOsXODx+CZ3pCkjMl11GGI2ykaLYRtZ6AXvYINT1oVilKyYd3fc3Uld5huktWScIUC+vVI1hx3kfCIWnwfccQ3TBLsLW6lo8Yt7Y2ImDFLgGsAQzznD+3kkALe9psS5ri/O2o2UuLThUgdhg8BHwA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714407903; c=relaxed/simple;
	bh=1iYXwmR3qpYuAfu8IzcDMoH8IpkROTiNtBcVaMKqqVQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=L9+duEHdAubqD3lGjc8pKrX72ISeT1hhRIVDNwhiV1/l3cPQ2lqpfBaqDLbhqPZ1uM7EUvG71ufrkgaLT50q/dg8Thcgg587ph4rjFpyd1S2etbuBO69JjM43UpnlbjDqMkcTc6AmgIuD4N5rcJdrN/PhGYCMLlNKDMaxEgycaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ySnRBn6W; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ySnRBn6W"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5523F30844;
	Mon, 29 Apr 2024 12:24:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=1iYXwmR3qpYuAfu8IzcDMoH8IpkROTiNtBcVaM
	KqqVQ=; b=ySnRBn6WcaBETVCaR7S7+Vvt6JYf6bfISSzyaAD6KDwvAP2+tnVGd0
	mCI6iyb5mS0aOl85/iWYaNGIUhyKpKJbqsNF6zyHqzrwTDnlkh3RqtZElWEeSjI/
	+6UHIMBP+aGSPLn8EnWEToKJTw9GS3rHspr6cXoiHwIINPOopJy14=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 4746230843;
	Mon, 29 Apr 2024 12:24:59 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.120.109])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B2FEC30842;
	Mon, 29 Apr 2024 12:24:58 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: [PATCH 2/3] refs: do not label special refs as pseudo refs
In-Reply-To: <b5e7ddb1e30acb7e3871a189beb2c828b18f9e73.1714398019.git.ps@pks.im>
	(Patrick Steinhardt's message of "Mon, 29 Apr 2024 15:41:28 +0200")
References: <cover.1714398019.git.ps@pks.im>
	<b5e7ddb1e30acb7e3871a189beb2c828b18f9e73.1714398019.git.ps@pks.im>
Date: Mon, 29 Apr 2024 09:24:57 -0700
Message-ID: <xmqqh6fkxhk6.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 058EDDD4-0645-11EF-8F6F-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

> +Due to historic reasons, Git has several irregular pseudo refs that do not
> +follow above rules. The following list of irregular pseudo refs is exhaustive
> +and shall not be extended in the future:

I like this part of the patch the most ;-).
