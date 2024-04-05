Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 558AF1C6A8
	for <git@vger.kernel.org>; Fri,  5 Apr 2024 22:01:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712354511; cv=none; b=Oi+yuRrfFkRXBEevQXYyKXUY+IxA5PcoVCQuTsvPZHqo/kXt4v4NhFwy60E9ORSIGp2itXaZiX/269cEOu1J2qBgb6+YmwE1K9UsdEMhXiHq9rHwj2jlOTxcxJ/XNBN0fOowRQcosAIp1NRLAmPjemiQuW8n1Oi/2oMz4xnmw2s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712354511; c=relaxed/simple;
	bh=lSEXUCx6N2RV7Jm/tcsQQXWG8bYRzlv+AuylWeE26Kw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dDcFQwLnv3SHt4Cz/uzS/QhCoWvImoo9FCmIbqxhaqcyd0coz1czddm+DYzjBTpk0opyAMMnXOX53vUV/J7URX0juuowUp4KPstGJyjKAzR2vKhCGw5BK6YL7J9x8I8doSJWogcMhFw/nkMhRNAe+dQ6zHc1zQmTlISa1JH7WDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=OTEJt5Kp; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="OTEJt5Kp"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D7DC826FDB;
	Fri,  5 Apr 2024 18:01:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=lSEXUCx6N2RV7Jm/tcsQQXWG8bYRzlv+AuylWe
	E26Kw=; b=OTEJt5Kp5y+T4V7tt2UdqxQM4W+NXFVN9/ui2vOUIw0qiVzdIwVLP0
	UuWEUJtTBeuY0/7lhK6wmpVcIMncnTA8gxcfj6YrBO7Uv3X11DItSF548AcbYaFS
	gTo/81oHBdZJqJ07DnNPA8DwRl291Pa5/ad5ama96jEmOF7HG9NYc=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id D03BA26FDA;
	Fri,  5 Apr 2024 18:01:49 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.229.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 503E226FD9;
	Fri,  5 Apr 2024 18:01:46 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,  Git List
 <git@vger.kernel.org>,  Chandra
 Pratap <chandrapratap3519@gmail.com>
Subject: Re: [RFC][PATCH] t-prio-queue: simplify using compound literals
In-Reply-To: <20240405191714.GA2561807@coredump.intra.peff.net> (Jeff King's
	message of "Fri, 5 Apr 2024 15:17:14 -0400")
References: <520da361-1b80-4ba3-87b2-86d6fdfc18b5@web.de>
	<20240402204153.GE875182@coredump.intra.peff.net>
	<c6cb255a-72f0-4ac2-81a2-1d8e95570a81@web.de>
	<20240405191714.GA2561807@coredump.intra.peff.net>
Date: Fri, 05 Apr 2024 15:01:44 -0700
Message-ID: <xmqqedbjtqnr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 184E6BC0-F398-11EE-99A0-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Jeff King <peff@peff.net> writes:

> Yeah, this seems pretty reasonable. I think we've traditionally been
> hesitant to pass or return structs by value, but that's mostly
> superstition.

We should still be hesitant against the practice to the same degree
that we are hesitant against struct assignment, especially when the
struct is of nontrivial size, or the struct has a pointer member
whose memory ownership semantics goes against shallow copying of the
struct.

In this particular case, I do not know offhand if .strftime_fmt is
safe to be shallowly copied, but I trust you two know and/or have
already looked at the implications.

Thanks.
