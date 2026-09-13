Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B067A3101D0
	for <git@vger.kernel.org>; Sun, 13 Sep 2026 16:32:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789317162; cv=none; b=ZBgKDTXllzwX5Ocd+e++MuzRj9G3TrrF+lqjzb1tMtSD4fjW9LxHXHaNW4bLu8nj0jae88nNfctM6Ffkda9QFO3sCFfOwkOLYZ/L8G0xoKxbzbyuk0I1EZpy+UJjqS7tsKVgIvkzeQ+BKxrg7DJbE1qYprBHJvaoULGwrb+UUdA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789317162; c=relaxed/simple;
	bh=LNp110yQyh5ZHP8DQhTomDgMAa1k27UkgkuFr2oq2Rs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PcdZSSsg0iwGilxkfSZ7OU1vT1S2d7h5ruWiQ+HeK7TI2Ewl9bHvAeyMoWFzEkxiS88XOMAquthm3nK05ruJlMjrTY4bOo9IzloSo0Fb7zyArz53wjepaS+mF3fjNVhkTQ9L7BT3gIlxpMpmPhD23h/TpV6L2kY2bOvUELGZuvo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=U5tcqiev; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i8vbdktY; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="U5tcqiev";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i8vbdktY"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BBD0414000A4;
	Sun, 13 Sep 2026 12:32:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Sun, 13 Sep 2026 12:32:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789317159; x=1789403559; bh=oY3dL2nlOJ
	7yc4eB3CZ9LQdg+2c41ohqbNZdYcqwTY8=; b=U5tcqievS13KEM2UHFhIwXgBNm
	N8FaOfmi6dChXDrnw/ZRszxBJ71M9W4nBnN8DPdSpXFHIsQXNYUkML0AfCLdEvhI
	lqP5YCk8P0EhXq4Yzb2TXDgu1XhOAAxkSowaV9P6tQeel95xSUqVPwbkDF1vyX9t
	n/FqVMH9DjgVRXHYtnRaHEZR+D8a33K992cy4ahEOT/F3L+b8B3czEH7Ie/VQHpJ
	XjQvx9ljwqgRtNBkcWM1HoiLQGnJTR+IBLBxtFKgR6BSzJww27QHiN1Ij19OjAKk
	DxeiBUZrHqBDYKb4P5ZfMYQ2DZr95X7NwwCp6sB7NMy/da/tQ1egVQwytO6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789317159; x=1789403559; bh=oY3dL2nlOJ7yc4eB3CZ9LQdg+2c41ohqbNZ
	dYcqwTY8=; b=i8vbdktYJiQWJDP+LqxlfC7HjJdnpcvM4PqsMzbowTun98N+f80
	T1VK/2gK6xIi9NRqXQoeY8a8At5f503HiK4csepXhuPt2OQoOpll7xr3SpYk5N0f
	HRZFU21ocoRede7mVoP+U9N/NOu0nXu5gO9YdNchkBmnbRiF1Z4u8HR637KzZst7
	rjiDreMgZ5+zd2AqpchxsWpa4Okdm5k0lQQUPwjx52gPTj2kTIg6WaBjGDliUhxa
	MUileQFCffZI4iU9PsHSIXWjBNMma7cXF9zzDeB2cqPEGaRrXqWuggJ0Gtk5kQnZ
	btM6Oag9Xt/EJOskcqF/mTWOrbsfBBiQD7g==
X-ME-Sender: <xms:J9Cmajc-gH9XKb9d-qCSm6caa-UawjYNN0c9WwiMJTvT12-sCqixVA>
    <xme:J9Cmas4opYWcr4QGqCiasXqEejTmcUpAac8nCEegIDg1gab9NYTYwPIcNA3WN_nsY
    hKYMuU8hDLeZTj4Nr35D0OJnTmqF91BXhbGomV9vOlb6QNWAejJjzQ>
X-ME-Received: <xmr:J9CmamXOptTk9HjnrD3kLiBxrIYofyjvdZiXJ6KLgcrasKt2PhuERQHuKkFcEdfk1b57IRZL1Ds1eFFizlwNFUm9aFl53cVf52iv>
X-ME-Proxy-Cause: dmFkZTEKruG9s2L5vrgSp+CSVPlwzpfi1Hn5cWIt78DgagKGEPoa3JvMANK2tqqkz42ABS
    F7xf36oz0e3qS/5y3xXsiNwFtg2xG9zTaf6p2bov5lc1rZ5xUUT9VOVIygGDMGyKcKDyN/
    6jhuhB0V/+PIVTafjpEwQiV5a0JKhtp/VUKRB0eni7wVUgtY6IWnHqqtbgd2Tv+Y+J27TF
    kSHnvOuoDcv6OXgLTfNiM8lWMm6d0g26xIvZ8WnkyrbYvoI189ZNUwT58qQdt8+rXMGEdB
    7S5+ga107SDNGqvfv/nmPqmd014UMKG1+SXFy9p1wwts3EwZfb7tqOR8cImUdTFXzkw2Dg
    odg+TrjqoUDsWxkG8qenL+wq4XvjqB9Z9qikvVU/kXiMV49H5QbLDyfTWrJV8wniIsOx3m
    KxAXT868jgOeC8ZQUWd6PpaCdRPE/H0At+iVtft8CF2HJLD3qz1Y0fuTw73iUVy5xT8Ew8
    Zpah1u7p/lCjY8uZlS6AxVssuluYCCB1cBSXjVtICoXYtac5ufpwOUBf0KzXQwnewC2iav
    2RoP/zooDIYhayLPseVmb+av3g7A+XagKH7lCM2rF/jdaSlXkg9TEXj3UxA7zuYiR7W/Ea
    gqNxyguyldRwzMnmcg5W2sJ0qrRwlv0Qj7zb/P8JtfpMd/kvbK3XSGsBdmHw
X-ME-Proxy: <xmx:J9Cmar4Ofie-uU16yBvZmJNEy6oqzigPDrvVkFR1848w5jmGfXWFKw>
    <xmx:J9CmahrKiNMWXpSkzdRJxEriKcdMmSzzwoXzpT1TCzWNiEDvsq4aMQ>
    <xmx:J9CmaumH-WG_6bWUloRybKUc0Ja8MDdno73RbxtL7C4PE2RTyxLNug>
    <xmx:J9CmatOqLk5xUjRQtE9Iu0QdGqDIWzuh8a-Lb8yYi1oqyem325S4mw>
    <xmx:J9CmasYHwisjtacobveUS1XrDRz9EJJxmnqNztcOyWqdpFS0r6m-yd6n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 13 Sep 2026 12:32:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Vsevolod Myalitsin <ub4nal@mail.ru>
Cc: ben.knoble@gmail.com,  git@vger.kernel.org,  gitster@pobox.net,
  peff@peff.net
Subject: Re: [PATCH v4 2/3] advice: introduce advice scoping mechanism
In-Reply-To: <20260912081246.133514-1-ub4nal@mail.ru> (Vsevolod Myalitsin's
	message of "Sat, 12 Sep 2026 11:12:45 +0300")
References: <xmqqcxuketuz.fsf@gitster.g>
	<20260912081246.133514-1-ub4nal@mail.ru>
Date: Sun, 13 Sep 2026 09:32:37 -0700
Message-ID: <xmqq8q55863e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Vsevolod Myalitsin <ub4nal@mail.ru> writes:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> It is very much understandable if we didn't mean the "use 'git
>> config advice.foo false' to disable" as a cut-and-paste ready
>> instruction, and rather meant as a general instruction that any
>> intelligent users would tweak for their own situation.  And it is
>> not surprising, from such a stance, the 'git config' hint would not
>> come with any scope indicator.
>
> I think that since advice.* was originally assumed to be disabled
> globally (as Jeff mentions, he expected it to be set in the user
> config), adding "--global" to the hint is a good solution.  It makes
> the hint actually cut-and-paste ready while still matching the
> original intent.

The original intent was more like "the users are intelligent enough
to be able to decide which scope they want to use", I think.  I
agree that even with "--global" they can still cut-and-paste and
tweak if they wanted to, so I am OK with that move, but my point was
it probably is not even needed to mark each ones for which scope
they are suggested to be set (iow, we can just change the message to
always say "--global" without changing anything else).

Thanks.

