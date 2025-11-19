Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F9672F6918
	for <git@vger.kernel.org>; Wed, 19 Nov 2025 20:04:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763582702; cv=none; b=dWpJ3wXZOsSUsL1Kjlz+BmlMCxVWhTzgKbycTIAStDs/a9+b57UA+jSyCmIgi967XdotbvUAMy0UNSdbDNFXRbS4yE9284j4+lc1Vjinnf4RaoHVVx9H4tUwm4Q33KCnYjRF2srLWMamq6g71CD7ghgfzexE0Vw8+xVDpnPQnA8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763582702; c=relaxed/simple;
	bh=6z5DvTwd6uYvm+MEos6aOc23YaxPJJ5PIgXTrcMMerI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cW+cmzpOc6zyrtFZpmpmRpR2zg3dh+XEnmonT4yDRt31yXUnudC971GW083nm5ptfSZgVf3WI5FcTCs91g4puDRWDcQdDFyWT+mKOj64LQZvXbgt/Pv/gmcmdaZxca3KkoSHCJwdg0KlHgc73RfnLqs3YLQNlyvtMQvPcFZur0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cJ86iM1D; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=fncYm6/2; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cJ86iM1D";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="fncYm6/2"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D1B50140001A;
	Wed, 19 Nov 2025 15:04:57 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Wed, 19 Nov 2025 15:04:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763582697; x=1763669097; bh=rdpT2sXP5v
	mJwbRxFtTWRuiZdQBkC25FbYMuKKatp1s=; b=cJ86iM1D6oMGIj5nJENUGg7eZ7
	d7BRKOvvfZzZi54E/lZgEgsjYB5z75JvsVcTWj+HAWkoNYQYn62qokvXOi6EBZWh
	cerVDT+d6jVHjxsYZAwgS/2xFpcyY8ZtH1k+uahOn+n5cR90iz3LL4j/NqguTj+J
	q/x4d+Lmts8jJpYwbPrHGMdICxBqmUDTRFPy5YfSqDYdUNH6uwKDOQj/7wH7KsVn
	BDZsP3NgMfzqYyCul0TnjgA23ntDtbL1yWMxbHh6cWVqMxZCMGdXFJAeVKhHG9W+
	hNM5HhGyKyuCl0u2U74c19s78JxKPEmn2MTf4ViIjfkarcUh9XrJ5TOnlVUg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763582697; x=1763669097; bh=rdpT2sXP5vmJwbRxFtTWRuiZdQBkC25FbYM
	uKKatp1s=; b=fncYm6/2QPdEOp8UEZfhWaBxN6QNwa1lHdKtiBje2vJqFt37o/y
	QT/xcWGRg2sbD25OR6rN9nCLqBduxB74R9WiUffdHHJBCDSdk89Wv/Qxgeo/T2xk
	s8B5Z+BdlbYmmoCc0LQayYzmSEjR6EHsoufI6ToDCEZS4QP6OWVojUFTdZmP1sVl
	gYK32kK4wgDtos669PXFudekeT/QapRJzXZF8bYDi1pafpmu4R2wXInsj8ZtUnmJ
	57Df39ZHQXj0G0HwcQVwFH7pDrTHylP49B0+woIBNVs0vWRP0rdT32WGqV79N7b8
	L72rKVc2G2wGs9iscrUstf7YgYY03KQWfIg==
X-ME-Sender: <xms:6SIeaQKIfDzfb_IGRiUKuwIWI1VaPaueVncBvarMqqidqVIL6fnYyA>
    <xme:6SIeaXJ1PiSR_D12n0jjLkkF7QHq0EZmXqSinhbQuSWPZGyqO27IGPnDvV0Ioxd1t
    -bZDoeMoO-g3m5y5KaHHMtQQFl91c8vHUGmqwzJUuaYtNx9NR5oyRs>
X-ME-Received: <xmr:6SIeaVt7HhsQJ5xYzgdrsMULyR0ndPhIAeJPI67yvf9iN-WUWrLvgteWX7pD6dra38jPkXcI5gK8czytKiXHpHyqOEEwbsQYxuSO>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdehudduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrihhlrdgtohhmpdhrtg
    hpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:6SIeacRV0mnqgJoS9ftDRwUWYN_vtkauiksAlo4DnzI-VPYfPV_0WA>
    <xmx:6SIeaTPSjb04cp-VfnFlvZnBkhxVgn_e1t4FfiIx4heWeeWfVxdvqQ>
    <xmx:6SIeaZaf1m9fFR30LOBOVpDQ4aqHpSECgCHgomAynxkfIyadaSjjAw>
    <xmx:6SIeaVzK9StQudL1AnmlEs7qGGN7nyrL189uJ1wUujoj8VJc_6bh7g>
    <xmx:6SIeaVNBMLQVoemZpem21FkTtnrFr_j0WST8OJfxtMt9eD3pcMxNeokT>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 19 Nov 2025 15:04:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH 01/18] streaming: rename `git_istream` into
 `odb_read_stream`
In-Reply-To: <2nd7qcj7jrrwc4fyhfsovs3ptrwmrdxxcap4sqadujtwwua5ha@bpbjlbnbcpiw>
	(Justin Tobler's message of "Wed, 19 Nov 2025 12:49:22 -0600")
References: <20251119-b4-pks-odb-read-stream-v1-0-adacf03c2ccf@pks.im>
	<20251119-b4-pks-odb-read-stream-v1-1-adacf03c2ccf@pks.im>
	<2nd7qcj7jrrwc4fyhfsovs3ptrwmrdxxcap4sqadujtwwua5ha@bpbjlbnbcpiw>
Date: Wed, 19 Nov 2025 12:04:55 -0800
Message-ID: <xmqqikf5bxg8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> On 25/11/19 08:47AM, Patrick Steinhardt wrote:
>> In the following patches we are about to make the `git_istream` more
>> generic so that it becomes fully controlled by the specific object
>> source that wants to create it. As part of these refactorings we'll
>> fully move the structure into the object database subsystem.
>
> Ok, so looking at the current implementation of `git_istream`, it does
> appear to be already defined in a somewhat generic manner as it supports
> reading loose/packed objects. What sources are supported are all
> centrally defined in "streaming.c" though. It sounds like we eventually
> want each source to fully control this interface without having to go
> through "streaming.c" to setup each source stream type which makes
> sense.

As the original inventor of git_istream abstraction, I fully agree
with this direction.

Thanks for cleaning up, and thanks for reviewing.

>
>> Prepare for this change by renaming the structure from `git_istream`
>> to `odb_read_stream`. This mirrors the `odb_write_stream` structure that
>> we already have.
>> 
>> Signed-off-by: Patrick Steinhardt <ps@pks.im>
>> ---
>> diff --git a/streaming.h b/streaming.h
>> index bd27f59e57..acf4c84338 100644
>> --- a/streaming.h
>> +++ b/streaming.h
>> @@ -7,14 +7,14 @@
>>  #include "object.h"
>>  
>>  /* opaque */
>> -struct git_istream;
>> +struct odb_read_stream;
>
> The name change here makes sense. While we are here, it might be nice to
> leave a comment annotating it's purpose in a bit more detail.
>
> -Justin
