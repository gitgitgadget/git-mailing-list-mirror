Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92BB13BBD7
	for <git@vger.kernel.org>; Tue, 19 Mar 2024 21:44:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710884678; cv=none; b=aPABzfMeqII3EKk0ANJ7VM5o7O7x/2GwW1nUXkQ/3Ao7r6OBLJ+juSPOPCf4oh8zpxncji9qnFFKNjlTn2Mko/MMdvClAXkiP2f9mSu1+iYDDyN435gZGIt111Kpif+1PfgOBMsQy1MhsFkYGj4Yy2mFIbN1Esqz7AITmQ+sRHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710884678; c=relaxed/simple;
	bh=fuKT5z/CIHEAE3zBsHi9cOPHbhJfW/u/qYNBrNyB2Zw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Y3HNh3N6se8zxl8HiDMyn3KB69QYjnt71V7FiddyPpiv4Ic8FEV+dHL0B3gvVq+2wHpAnZ0nWv6L0HL2Npc+LHKMU6lM/bWLmqhof0X0LXXKxDuiqYVP+R793BcMC6yBjv4HLemXH4l+697hN9xvlNBUHGlk7elwA0xdPkyIp3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WBJi08VX; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WBJi08VX"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 19C7229CDF;
	Tue, 19 Mar 2024 17:44:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=fuKT5z/CIHEAE3zBsHi9cOPHbhJfW/u/qYNBrN
	yB2Zw=; b=WBJi08VXUPrK/KOExISNvJWlnMtLUAaP0ilSFh6FDMpIxyapS0EzyO
	UJOvSwjgu5cWLQT0TpF/UyZahvJzoin/4SAYb+3aRl+Wl4VSlphKK34mM9blp9A9
	w5YLvfDt5F8l5E3pMCa9TH0HUG+DdsLTuL6i0FVyczYLwSHrU+yw4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 12D8E29CDE;
	Tue, 19 Mar 2024 17:44:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 8CB3F29CDD;
	Tue, 19 Mar 2024 17:44:33 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Ignacio Encinas <ignacio@iencinas.com>,  git@vger.kernel.org
Subject: Re: [PATCH v3 1/2] t: add a test helper for getting hostname
In-Reply-To: <20240319211112.GD1159535@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 19 Mar 2024 17:11:12 -0400")
References: <20240309181828.45496-1-ignacio@iencinas.com>
	<20240319183722.211300-1-ignacio@iencinas.com>
	<20240319183722.211300-2-ignacio@iencinas.com>
	<xmqq8r2eneut.fsf@gitster.g>
	<20240319205753.GB1159535@coredump.intra.peff.net>
	<xmqqo7balyx9.fsf@gitster.g>
	<20240319211112.GD1159535@coredump.intra.peff.net>
Date: Tue, 19 Mar 2024 14:44:31 -0700
Message-ID: <xmqq5xxhnbgg.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DFB741DA-E639-11EE-96F5-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> But we are not testing "includeIf" in this patch; we are testing git-gc,
> which falls back to the string "unknown".

Ah, I wasn't aware of such a hardcoded default.  Then replacing the
existing "hostname" with "test-tool xgethostname" and doing nothing
else is of course the right thing to do here.

Thanks.
