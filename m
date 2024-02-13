Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B9E558124
	for <git@vger.kernel.org>; Tue, 13 Feb 2024 17:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707844239; cv=none; b=bv0uRHKfLVKKL1AsYBC1qpn0V4Ot+T/FFLcUjEFAXk5l7E6jYCW6p61VKGhGjw+O5xbmgOk4CRdSnGvE9KduHsk+39gzkYi03v7+lvo3BFWTUYVVdh//qiUmUPh/Epnt2fD9vT5ilKn7zLJ7RrRa2bwfDRokcPjS6rXBWOGTSY4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707844239; c=relaxed/simple;
	bh=60vFP5Rvji+ce4gMq6u9MwazE83J7Gd1HliIejl2gd0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qCFe/icb4vHrGjfvOC3qPm0AxgEhSw4mp8OxkUcUgwIZzgT4J22g9qH7elG/2d5wO40pmbevTuIdaS6kRHPyqhaxvvO/V81Ps0TITvH6hNMcQ6aHFkqHJlzhAat4jPfByqS9iPk0Xlhux1jQSpohwiYgHx+ykrfpptJZJBIYcnQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=a66K0gXM; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="a66K0gXM"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 5A20F188D4;
	Tue, 13 Feb 2024 12:10:32 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=60vFP5Rvji+ce4gMq6u9MwazE83J7Gd1HliIej
	l2gd0=; b=a66K0gXMQn+tYR7H7xHvCrlKJXFYMuzf2z/wm4CuAX4oSYH2qFZkzs
	j/WIX8PtK7pXjS/Co4n1EQUj6e49YeL9okjaAYoqnDw2jC1e9WETpCVP2QD48k0F
	KSe8EzuuxzyjMRtBCt9W2fuOCgLuUHQljJt0T+jd1mYTmj1DJuo/w=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 539DF188D3;
	Tue, 13 Feb 2024 12:10:32 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id F115B188D2;
	Tue, 13 Feb 2024 12:10:28 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>,
  "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: Re: [PATCH v2] unit-tests: do show relative file paths on
 non-Windows, too
In-Reply-To: <fd8874bb-8e45-4b39-986c-5a96ccf0747f@gmail.com> (Phillip Wood's
	message of "Tue, 13 Feb 2024 10:55:25 +0000")
References: <xmqqttmf9y46.fsf@gitster.g>
	<6872b42d-8763-44dc-9502-2362d1ed80a7@gmail.com>
	<xmqqle7r9enn.fsf_-_@gitster.g>
	<c625239a-a847-475a-a228-9deb622c67bf@gmail.com>
	<xmqqsf1x486b.fsf@gitster.g>
	<fd8874bb-8e45-4b39-986c-5a96ccf0747f@gmail.com>
Date: Tue, 13 Feb 2024 09:10:27 -0800
Message-ID: <xmqq4jec8f3w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C985347A-CA92-11EE-8449-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Phillip Wood <phillip.wood123@gmail.com> writes:

> I think it was only the MSVC that needed the paths munging which we
> don't test by default.

Ah, my sillies.

> I have tweaked our github actions to run those
> tests and they pass
> https://github.com/phillipwood/git/actions/runs/7885144920/job/21515922057#step:5:146

Thanks.
