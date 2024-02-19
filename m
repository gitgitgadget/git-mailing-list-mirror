Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404AA56B95
	for <git@vger.kernel.org>; Mon, 19 Feb 2024 19:49:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708372155; cv=none; b=aeQsrw+Zvh4jOY1/9+EfwmHZLS89uHimoqzySR9hZp0TFcgaoetCeASgOQQjOlIBYysE6PPG7iXBI4WAuBN1Zd8ckhXhvSsvSdc5C8GjOVKFnHlYr/5kIWJelfQ2j4StCajqHO54OUt/k87J8Nvg76V7fN4KgowYlII+gwAAkNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708372155; c=relaxed/simple;
	bh=u4LG+A9cJo7LY60uow6nU2QBkaOCw2iXwzOoMTCVLx8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=t5NYqaE4oGvCpGMfH+vSBDFEWiR0Ak50V2ewPozUjxqzs4KhkBl5yf+mhf7lLp8vngSS5uJRXjomlkliwsf7KCNYntnP+C8LoK3XU/EMPlTtsQDZPBN8QzKBobjeklFQgbTzQ5eQDO+U6tSfYNEenQUhVl/+L/JD3tABokpQXJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=V/4Na83m; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="V/4Na83m"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id AA0D324F80;
	Mon, 19 Feb 2024 14:49:13 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=u4LG+A9cJo7LY60uow6nU2QBkaOCw2iXwzOoMT
	CVLx8=; b=V/4Na83mtiNnXcqrnkXUYMky2+mMe73xmIOjtc6rGeofvBM8WwtHZC
	F1yNr9im5yRuYg6Z0c13fscs9NdUn0RpQP+WhD2cS+O32c07MGRC+7MsguNDlhbs
	B1rner7vih0wIKbev1Dhelzbm2KM2V45tI08mayGjNexgO6w9jvWQ=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A1FF724F7F;
	Mon, 19 Feb 2024 14:49:13 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.165.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4C9E724F7C;
	Mon, 19 Feb 2024 14:49:10 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Dragan Simic <dsimic@manjaro.org>
Cc: =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] branch: rework the descriptions of rename and copy
 operations
In-Reply-To: <be91f3ad9305366c1385c2da4881537e@manjaro.org> (Dragan Simic's
	message of "Sun, 18 Feb 2024 21:38:54 +0100")
References: <3cbc78bb5729f304b30bf37a18d1762af553aa00.1708022441.git.dsimic@manjaro.org>
	<e8fdd057-2670-4c93-b362-202a339d5f49@gmail.com>
	<xmqq8r3lnzp0.fsf@gitster.g>
	<2a4de8c4-4955-4891-859c-58730a41e5af@gmail.com>
	<ea15a49aed7b5a74cd9b1bf8a5351df9@manjaro.org>
	<c00f6efe-d1f4-4f2c-99cc-ac7a6d93c9ff@gmail.com>
	<be91f3ad9305366c1385c2da4881537e@manjaro.org>
Date: Mon, 19 Feb 2024 11:49:08 -0800
Message-ID: <xmqq8r3g8caz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F3268D52-CF5F-11EE-BD38-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Dragan Simic <dsimic@manjaro.org> writes:

> Regarding the branch copy and rename operations and their argument
> names, perhaps the following would be a good choice:
>
>     --copy [<branch>] <destination>
>     --move [<branch>] <destination>
>
> It would clearly reflect the nature of the performed operations, while
> still using "<branch>" consistently, this time to refer to the source
> branch.  Using "<destination>" to select the destination name should
> be pretty much self-descriptive, if you agree.

Awful.  While I was skimming the messages without reading the
Subject line (hence without realizing that this is about improving
the existing documentation and not adding new features), I thought
that these two are about moving branch to a remote repository that
is named with <destination>.

My advice would be to stick to <old> vs <new> that contrasts well.

Thanks.

