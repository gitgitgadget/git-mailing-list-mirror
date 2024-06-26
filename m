Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 92887A944
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 00:04:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719360268; cv=none; b=cGYTp2nAFvdO5jsQFjsU7VL90j+2HlVcrh+y0GQS4HAXts+qU48W0yfQBbMTf3lhU77qKvkMB5X0w4ZGeAIW6guyR3/E60rblauRS50LTyK4u6yFPOZ06Y+BuQSyAKDj/Ouhn0M+iFj4MJu7TlBLLW8QdvSMsSA0XI4rjiSlZHU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719360268; c=relaxed/simple;
	bh=QFPAvtju2WyxLm9UXFNsNs729okFIjrhRpNZCB6cVc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GSKq8VzL7ABzYbL1fmB50SX0g9Rp8C4Z64q7kxsXHGXlcUHC2O2BQKmoJ4ZFjGT2bg1iRlsOep90jGZN/BvHskZ6KK5hMcD9w157hkp+nHtX6Mp615njnGtkAsMZpCW9rvQmwHDLflNv5WMRndVyhB7U9VqDXXZfPxz3HAB/uxc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=QDPv/y8j; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="QDPv/y8j"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 0C7521AC55;
	Tue, 25 Jun 2024 20:04:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=QFPAvtju2Wyx
	Lm9UXFNsNs729okFIjrhRpNZCB6cVc0=; b=QDPv/y8j/18Ho1qCjoqTNqiBWr3y
	PoKkICY5Uw+IwG8Na/5d3oKWuj9qIEpzA87aAR+oM3pNCj3VEYMhr7VsfxzpR6wq
	ppuKDMNdQq5vmQg7DiiKhkTcVOSh2B8+arH6yem8E/pOvbiBpoxhJIj8XztLEiAF
	UVbU1CUt/bH9K7E=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 04E921AC54;
	Tue, 25 Jun 2024 20:04:27 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 99BE61AC53;
	Tue, 25 Jun 2024 20:04:23 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v4 1/2] t0006: simplify prerequisites
In-Reply-To: <CAPig+cRaQbWTLnvbx-Yec3mGEJDOQQr8RX+bT=J1FzVDqjq2_g@mail.gmail.com>
	(Eric Sunshine's message of "Tue, 25 Jun 2024 19:30:12 -0400")
References: <pull.1726.v3.git.git.1717719428510.gitgitgadget@gmail.com>
	<xmqq1q58ejnw.fsf@gitster.g> <xmqqtthzrraw.fsf@gitster.g>
	<20240625231248.4070257-1-gitster@pobox.com>
	<20240625231248.4070257-2-gitster@pobox.com>
	<CAPig+cRaQbWTLnvbx-Yec3mGEJDOQQr8RX+bT=J1FzVDqjq2_g@mail.gmail.com>
Date: Tue, 25 Jun 2024 17:04:21 -0700
Message-ID: <xmqq5xtw603e.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 A50F8A34-334F-11EF-AAFF-DFF1FEA446E2-77302942!pb-smtp21.pobox.com
Content-Transfer-Encoding: quoted-printable

Eric Sunshine <sunshine@sunshineco.com> writes:

> On Tue, Jun 25, 2024 at 7:13=E2=80=AFPM Junio C Hamano <gitster@pobox.c=
om> wrote:
>> The system must support 64-bit time and its time_t must be 64-bit
>> wide to pass these tests.  Combine these two prerequisites together
>> to simplify the tests.  In theory, they could be fulfilled
>> independently and tests could require only one without the other,
>> but in practice, but in practice these must come hand-in-hand.
>
> s/but in practice, but in practice/but in practice/

Thanks, always, for your sharp eyes.
