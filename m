Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7E112575A
	for <git@vger.kernel.org>; Wed,  5 Jun 2024 16:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717603919; cv=none; b=ZIxDcjsbX6UcXvTeYLuZKueqeHqO9wveockAxsxqutwXHxoeSR09KU9f0/X6iPkcJuShkcSKxcsGDsJAHz/3w218KHU4GZm4FKZK9dPMaLqAvGDdo1dlQdxz4sQw6k3il1Iy4rD/tGNhsSC5Lr68tCxbkOUbtrTN479WEaq5z2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717603919; c=relaxed/simple;
	bh=2+qrJWworOsE9V7tWC/OYNANdwIGtqy2L6Z527ycup4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=rfSCY+H9eFZ3vq45NERFrYHsqnGxvFqRJ1XDVgrwbgxzlwn6+GuROHrRouUAGbRh+/GVAJVShSWmABDzBSU7C15UVFrl+i8yAeU1nrqy9iNNIfIiqr9O5V0dHS6X30ynaf/xiHgkJ8ibK0w0zptUf5uG3ErixbRzr+mPXxwmQXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=gXZmfHNP; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="gXZmfHNP"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 39CAE1ADB9;
	Wed,  5 Jun 2024 12:11:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=2+qrJWworOsE9V7tWC/OYNANdwIGtqy2L6Z527
	ycup4=; b=gXZmfHNP+Jf3UWlpgl9XasVKhRLw0q8G8PRnAVd5RABB1ifa6U5v73
	H8MJTevg8CSysTUM2xsSdnbYJa86tvzTbCpIqGShP6f1dnIqatzZ5QXaO9dJyUbS
	lYiF8myHyU2EjF9AcXbcmxR0uUGSETg2pu49BVgEq9arQxkKcWMlw=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 318631ADB8;
	Wed,  5 Jun 2024 12:11:57 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 4FCAC1ADB7;
	Wed,  5 Jun 2024 12:11:54 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: phillip.wood@dunelm.org.uk,  git@vger.kernel.org,  Jeff King
 <peff@peff.net>,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v4 24/27] builtin/rebase: do not assign default backend
 to non-constant field
In-Reply-To: <Zl_6anUl_C3W2j2Z@tanuki> (Patrick Steinhardt's message of "Wed,
	5 Jun 2024 07:40:58 +0200")
References: <cover.1716983704.git.ps@pks.im> <cover.1717504517.git.ps@pks.im>
	<e19457d20c80f9ce332f2d890a5089972e28f0cf.1717504517.git.ps@pks.im>
	<be8a315a-3fa7-40d3-80e1-6a5c01afee70@gmail.com>
	<Zl_6anUl_C3W2j2Z@tanuki>
Date: Wed, 05 Jun 2024 09:11:52 -0700
Message-ID: <xmqq8qzjwerb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 534BF1F0-2356-11EF-8E12-ACC938F0AE34-77302942!pb-smtp20.pobox.com

Patrick Steinhardt <ps@pks.im> writes:

>> Personally I'd be happy with
>> 
>> -		.default_backend = "merge",		\
>> +		.default_backend = xstrdup("merge"),	\
>> 
>> rather than adding an init function. I do agree that adding
>> rebase_options_release() is a good idea and the rest of the changes look
>> good to me
>
> Do we have any other cases where we allocate inside of a `_INIT` style
> macro? If so, I'd go with that precedence and just allocate inside of
> the macro. But if we don't, then I think I'm leaning more towards the
> way I did it in this patch.
>
> Happy to be convinced otherwise, I don't really feel all that strongly
> about this. I'm merely aiming for the interface wth least surprises.

FWIW, I am OK either way.

Having _init() and _release() may look symmetrical and there _might_
be cases where an initialization with a simple _INIT macro may not
suffice and we must have _init() function.

But otherwise, especially with .designated_initializers, the _INIT
macro makes it slightly easier to read (but not all much for this
particular case, whose initial values have too many non-zero values
and pretty much everything must be spelled out).

Thanks.
