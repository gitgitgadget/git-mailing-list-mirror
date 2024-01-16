Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F761CD26
	for <git@vger.kernel.org>; Tue, 16 Jan 2024 17:58:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1705427891; cv=none; b=gV8zrtkB6l79YcHqoMiGKsnYAfyFkGxtMl63Q6ElaZXRHw61lUwD06T8+IIdgC4YY2PaV5xW4JLlDdRhMfz11c3Xp8NOlIN8fggK70L/dVWny/Ls8zHqZbQOyKpS3bcEZnCj4aRmy0yicy3qRMiXRoBjmb1ZQyeLiOhZdHsHMI4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1705427891; c=relaxed/simple;
	bh=X93tE9xC9aIRxtwV/fVo/zaQG5dDK2IIS1CrKzx8foE=;
	h=Received:DKIM-Signature:Received:Received:From:To:Cc:Subject:
	 In-Reply-To:References:Date:Message-ID:User-Agent:MIME-Version:
	 Content-Type:X-Pobox-Relay-ID; b=Whl43XIYGv2Cu3Ui+tNkCDLRU2bSd1Kp+ETjg5gct+OQMZEOT+cC1+5pNEvTxpiP9cZ1/BZ+g6+jZRDM4Dd+F1PB5RKWMEBF6segHE2kfKTruTXPOBvXl8Wq1INGpEj0w8hprsy94FE4eI4BLFSM9c1bDk88rGK36KdakscEDFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=IMvphY0Z; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="IMvphY0Z"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id F40EA1D8607;
	Tue, 16 Jan 2024 12:58:02 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=X93tE9xC9aIRxtwV/fVo/zaQG5dDK2IIS1CrKz
	x8foE=; b=IMvphY0ZjPE2gkKwed70x399PF8ZQaiLP8i04HJiapebSKCvbwLHu1
	BIilxcKr40Xfe/tgFZnXeD6V6vuxDtRDifjMa2riYom1099yB+6kbCpGogVpZ9a1
	ebXIFAFrOb8QbDL8CXMoHpNUJJldNiutTjdPf2P57qAk4gXZSP1c0=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id EA0891D8606;
	Tue, 16 Jan 2024 12:58:02 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 3D51A1D8605;
	Tue, 16 Jan 2024 12:58:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Nikolay Borisov <nik.borisov@suse.com>,  git@vger.kernel.org
Subject: Re: [PATCH] rebase: Fix documentation about used shell in -x
In-Reply-To: <20240116143757.GA2119690@coredump.intra.peff.net> (Jeff King's
	message of "Tue, 16 Jan 2024 09:37:57 -0500")
References: <20240116141842.193151-1-nik.borisov@suse.com>
	<20240116143757.GA2119690@coredump.intra.peff.net>
Date: Tue, 16 Jan 2024 09:58:01 -0800
Message-ID: <xmqq5xzt17py.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 CAA235A2-B498-11EE-AAB7-25B3960A682E-77302942!pb-smtp2.pobox.com

Jeff King <peff@peff.net> writes:

> Maybe it makes sense to just say:
>
>   ...in a shell (the default one, usually /bin/sh), ...
>
> It might even make sense to just drop the parenthetical phrase entirely.
> Git executes lots of things using a shell, and it is always "the default
> one", but we don't bother saying so in most places.

Thanks for your archaeological skill, as always.  I like the
deliberate "vagueness" of the above.

