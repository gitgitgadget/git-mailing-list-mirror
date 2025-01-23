Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 834AD2914
	for <git@vger.kernel.org>; Thu, 23 Jan 2025 01:53:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737597215; cv=none; b=kvPR/wX5G1JbPpfbQQsjyMx+VH0/4fljIAAcq2N6XTAMx5F9PQWQphgfOXwqoql8bARfgE+FPBzud4JzpgTf9HCHnNvfZCCJbNw57Ff4akI1/NwDw0aeSf3LtqE5LaexQ8qDtKXs75tOFHv+/Mcxci3Gw8Yjt96LhZkdlaQjOLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737597215; c=relaxed/simple;
	bh=YD3aBqV+dxPRr3jye8eWsScQGC8aIKQ8yFxFHaDpAgs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qWN8KNypskEDn3nl8FERIC/T5ztSvpEXgoHD99LRzLEis1l5WGi/YAluhbttWI+VV0Aj5vaLLpqcC8ywcsJEf3lDpJR1/0FU1lX60v/IYlY3ZMVMfk5SBi7fUTb5mI/JZ98HTBjBna6Kj9WpqF3dxWplrg2Nf1EALM7AfYclX9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=E4Ma3ZD8; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=uJ5i8Ha5; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="E4Ma3ZD8";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="uJ5i8Ha5"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 77ABA25401EE;
	Wed, 22 Jan 2025 20:53:32 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 22 Jan 2025 20:53:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1737597212;
	 x=1737683612; bh=dKDcUCj4Zo9EZv38+7YPxMrbiE2bkVVdv/Tt5N/2IOM=; b=
	E4Ma3ZD8PNQlbdEALQpBvaYgEYtrrryejqnlHutXbkeo78T7z6pEJLphTs/g7QYc
	BBlRpBD4RhW8We0dHYxTQfz+qLLcr3keb5cSvKAEZtaB/HyD3N74d9dsQ/79UFJO
	t5e/oB8MerLKIVk2tjduN12Mbf2EPAbYkDanMKjXiJ0l0RhyY94uAmvUBYtAHSc3
	savuZ7nJLzd13NEQe9k9kLRcvAAXkfiDCvupwu1FJvtya0rE1Nm03Da5tCZqDoIF
	3jQFPJyAFleewY3FNG5FS0VhyP11qj8aBRV7NcTl7rbEnJbvGA94jaVXiC94/iVl
	wYJpO1T1k4/1ECS2J7Ggug==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1737597212; x=
	1737683612; bh=dKDcUCj4Zo9EZv38+7YPxMrbiE2bkVVdv/Tt5N/2IOM=; b=u
	J5i8Ha57YBM7OAEufdapNbdNcAYIgk9Vr5QlIImqXlDl6R7nyB0yfS+WUtVNbPH9
	Xf/nDTV9H0eKK8hjlrWaYdbYYlriGkFeq+/AhA1MX39F0IjVoh7COAKiCDLXeBU7
	Gv93YmlqHdlSW3MRGovUHPy1oSpcaF9VwBZ01NaNh0zsF6yO1iRyobB35K14Z9cf
	sL13EF3NduZfZrM6XcBXgfzNSG/79c/J/piu3PQH6pj3lDYPDuFTzkT5ne2kHqLd
	d+9IvQKm3OsoslTI5NcGvOdF9KYj2o88W6R3QP2MyuMABiCcO5MkHYJ6yVYtreHo
	Ulpuz6YdQkZuvc68csGCQ==
X-ME-Sender: <xms:HKGRZ6DsBTXsUAL4DgK7TSsTQ1g5XtAWP1Y_ZyjReYxUd16tfO-AOw>
    <xme:HKGRZ0ickxEeiC0gEYmL31Qk5_ekTpWQKcgdLHdn6oX3mqpaIsU3EhdMKO8xPoCHW
    Nyydnt8w1gMoTPTiQ>
X-ME-Received: <xmr:HKGRZ9mSApSiO-VHwmSj_pXKD2LcMBd8CO38MGDwnYBfs2JK_pS6hT7ciTxG4Wrcap27AKq-xsA7A5jSczb6N66yXI1kI8_i1kzc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudejgedgfeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsuhhnshhhihhnvg
    esshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:HKGRZ4zo9idtGW6Q-FiV7efldw-H35wzydlLXsgcuqpU89O9eda6qw>
    <xmx:HKGRZ_SPYt6PP_rhGUGmPaWBKeC9mlHgC3E-Exyuj3rbPqOFSGiOvw>
    <xmx:HKGRZzYfIwuMJfwtGeFaTYN1TM8E5IJEy51tJdmT4Tsya9ErAxOSmQ>
    <xmx:HKGRZ4RfZFiWOIzrLBW44TovdS5Fl6smgUcQTqFtW2DpIJ2FiDmf7Q>
    <xmx:HKGRZ5f1XzLGWIWtGGAnsbgm13IYNH7yEPW3eEK7yB-lcJ4-Xn4fOOnZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Jan 2025 20:53:31 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2025, #06; Wed, 22)
In-Reply-To: <CAPig+cTBgHn8vjKDjy5JujFf-S4kQxPQ0iFMdh0HA37f76eqLA@mail.gmail.com>
	(Eric Sunshine's message of "Wed, 22 Jan 2025 19:38:02 -0500")
References: <xmqqbjvyv510.fsf@gitster.g>
	<CAPig+cTBgHn8vjKDjy5JujFf-S4kQxPQ0iFMdh0HA37f76eqLA@mail.gmail.com>
Date: Wed, 22 Jan 2025 17:53:30 -0800
Message-ID: <xmqq1pwuuwh1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Wed, Jan 22, 2025 at 5:49 PM Junio C Hamano <gitster@pobox.com> wrote:
>> * ps/reftable-sign-compare (2025-01-21) 10 commits
>>   (merged to 'next' on 2025-01-22 at a5ae1ce801)
>>  + reftable: address trivial -Wsign-compare warnings
>>  + reftable/blocksource: adjust `read_block()` to return `ssize_t`
>>  + reftable/blocksource: adjust type of the block length
>>  + reftable/block: adjust type of the restart length
>>  + reftable/block: adapt header and footer size to return a `size_t`
>>  + reftable/basics: adjust `hash_size()` to return `uint32_t`
>>  + reftable/basics: adjust `common_prefix_size()` to return `size_t`
>>  + reftable/record: handle overflows when decoding varints
>>  + reftable/record: drop unused `print` function pointer
>>  + meson: stop disabling -Wsign-compare
>>
>>  THe reftable/ library code has been made -Wsign-compare clean.
>
> s/THe/The/

Thanks.

>
>>  Will merge to 'master'.
>>  source: <20250120-b4-pks-reftable-sign-compare-v2-0-b4566d02e4a5@pks.im>
