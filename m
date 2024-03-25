Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E0596CDC2
	for <git@vger.kernel.org>; Mon, 25 Mar 2024 21:03:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711400620; cv=none; b=fUr0YN1mLQgyoVBHwHbAA1dgygFJenm/HodNvA7OssOC2X3GDjG2ED0wf635Fl66d6ezVBTSrXKUq2nTrv5zfxYdGtdQbJpvkI3AaSkQJCTEG3R4BDZrzCPG0LzI8TYkCbqPVYFK+XEwpkkEjHHiTwLxq492ZFS+nMeKVFIXS/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711400620; c=relaxed/simple;
	bh=aZUNVGk1D3KReUCySqO6EG399prOy2r40w+4g/M0IZw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=S6pefvGkFWRaBfU9zUmYW6mdoI1d92jlpKZ/IZEs27+bq7IStH23tIQhtBaP2JcHkLahTZAqSqDk4QqK7u8m6y6XpKA/bfoztUmjaHUWmauAJugTXUwpjynuaJJG0ABIyH0QcqRcR/1uZyWFJ31IBxzCjDVK3GAAshIGRJrLPao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=ttWCaBIi; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="ttWCaBIi"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id CC4B130F3D;
	Mon, 25 Mar 2024 17:03:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=aZUNVGk1D3KReUCySqO6EG399prOy2r40w+4g/
	M0IZw=; b=ttWCaBIixjg1S2fBVh5Ai39bvy/1cw4yHfS6nPUL1gK697+sNMUcO0
	vIQAnJcl+3GQ1swp1PTt/UYl0n6R88bRumaF0vQnDGpTxG35pLLoctzFI6w4Tdzs
	RqZ85+EefFV8aMNxZkjJPRVpf7XOf33rensTwuS5xE34IlRJL/Eig=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id C5FFA30F3C;
	Mon, 25 Mar 2024 17:03:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 295FF30F3B;
	Mon, 25 Mar 2024 17:03:35 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org,  sunshine@sunshineco.com,  jn.avila@free.fr
Subject: Re: [PATCH v2 1/3] grep: perform some minor code and comment cleanups
In-Reply-To: <55867253d2925892f5192dbc3145f7bc9221b791.1711302588.git.dsimic@manjaro.org>
	(Dragan Simic's message of "Sun, 24 Mar 2024 18:51:11 +0100")
References: <cover.1711302588.git.dsimic@manjaro.org>
	<55867253d2925892f5192dbc3145f7bc9221b791.1711302588.git.dsimic@manjaro.org>
Date: Mon, 25 Mar 2024 14:03:33 -0700
Message-ID: <xmqq5xxahvmi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 24DEE802-EAEB-11EE-A4DD-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Move some variable definitions around, and reflow one comment block, to
> make the code a bit neater after spotting those slightly unpolished areas.
> There are no functional changes to the source code.

It cannot be objectively better than the original as "neater" and
'unpolished" are fairly subjective.  Let's leave this out and take
the two "obviously good" documentation improvements for now.

Thanks.
