Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EFEEE823D0
	for <git@vger.kernel.org>; Wed, 15 May 2024 14:16:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715782605; cv=none; b=KKci0syV3IcsqRSbTeRFPbwpq5HFH9qiaCGkiS/YmF8kQQnm3L6WAJDWW5x4HzLJ0sh43Bjt9PW5c44Oknx3AwEqoQq/B0bOWJTCKDZln4Pfl9jWGMOLymuJUhXKl4XX3ceT+LcF5UIRoqie/BjJB2QlLx0FXV0sw2x1P5QwF9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715782605; c=relaxed/simple;
	bh=Ax6tWDN7G8LGXOmou3xt1urqKEThZD8nyuRGQphNNvU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JQ3AZlehSon3a3jYcyq8PCJcHNJbeO2VI00iGHxq1UbBFaPiCyu5ErNXDVWz3F8TA3QVVNMYtQObk0mW4bezanT7wlmQTX7D3h8O+ZGm/GO+gFw2K1RZEPK6kfSOiGKgsy3ij0xmqo+XDFiec4H1EqFRgzMeTpnJE52IhjkY+gY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=yfVDq3gA; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="yfVDq3gA"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 894F51D829;
	Wed, 15 May 2024 10:16:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=Ax6tWDN7G8LGXOmou3xt1urqKEThZD8nyuRGQp
	hNNvU=; b=yfVDq3gAtKf0pW4NpuWRHoz2ujCWdMFI4InptZ2arMbpoomKPt5wjo
	9UcVTm5OmDp1EJNe1rN5lVHVRgLiJVIF9ij+O6nzVEb8oNtm0JWI0cPFlL5ffzYk
	qjDqplh4+6BIGsKnl1QBmkSPkjNyQ9aOYfPumsJ/QmLhHXF0A8bZQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 824F91D828;
	Wed, 15 May 2024 10:16:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 18F0C1D827;
	Wed, 15 May 2024 10:16:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (May 2024, #06; Tue, 14)
In-Reply-To: <CAP8UFD0q1yBm4aG6pmByOxMAvYcbmwfAWkSK=nyCoAAY3qptig@mail.gmail.com>
	(Christian Couder's message of "Wed, 15 May 2024 13:57:01 +0200")
References: <xmqqcypo47p7.fsf@gitster.g>
	<CAP8UFD0q1yBm4aG6pmByOxMAvYcbmwfAWkSK=nyCoAAY3qptig@mail.gmail.com>
Date: Wed, 15 May 2024 07:16:38 -0700
Message-ID: <xmqqzfsr17p5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 BF6C0D1C-12C5-11EF-B06E-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Christian Couder <christian.couder@gmail.com> writes:

> Phillip then agreed with Linus that the improvements he suggested
> could be done later.
>
> I took a look at Linus' v4 and I am also fine with it. Thanks.

Let's merge it down to 'next', then.  Thanks.
