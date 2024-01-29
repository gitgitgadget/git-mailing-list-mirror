Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D74B2E834
	for <git@vger.kernel.org>; Mon, 29 Jan 2024 20:38:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706560686; cv=none; b=nRL+HAbCTWlf77jTlShn1742QTFIpEQPezDZE6yebQq7tK4Vra6+RK5dOwrih2RGD5N7Ej9D2+9N3wLlrkokly6rNKn5OsrbmDv+B+xF2ZMcWYwqTfsDF4dQy1AKH6IPea5n4YB0ji3PG+1za8g3V+qzb2mVLjhIJ+mf9dlwebs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706560686; c=relaxed/simple;
	bh=qjvM71SjlkFPNiad94Dj3ySgHqnC/54FmTQj6IvT3Xk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=WGqqZJXyRRIRV1BxV6NqUT9T2KMc4vd7TnqXY1zMrZ8AKhwc2LTMAl0VN/MvtdaBL8x5DXb9uroswWn/hh1/FWwQK3hNSiL9GE89kszSwdPc0fDB+jFZ8PQRqnsyxr8jPi/KeWDWaoHfsvqDveMULtVrGrKpb6vyLGwUbjR6dFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=O7U3jE2F; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="O7U3jE2F"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8F32E1D8638;
	Mon, 29 Jan 2024 15:38:03 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=qjvM71SjlkFP
	Niad94Dj3ySgHqnC/54FmTQj6IvT3Xk=; b=O7U3jE2FKTlJRgA3OXNGwve4ng1V
	HLBhf9CJI3SuQhQ/f1DK+zZh1P8CykbC2tsymLcUNj37GRYYxoIk2csert93V+2B
	TLRh7rWkLQm5LEqGPvXCtyJAGd6GDxqGvKL+IRP05qW9hqT8CuyMUNgjE8zRZLOk
	zrb/7TYfMFVIMUI=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 7BD6F1D8637;
	Mon, 29 Jan 2024 15:38:03 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.200.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B72001D8636;
	Mon, 29 Jan 2024 15:38:02 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Taylor Blau
 <me@ttaylorr.com>,  Eric Sunshine <sunshine@sunshineco.com>,  Toon Claes
 <toon@iotcl.com>,  Justin Tobler <jltobler@gmail.com>
Subject: Re: [PATCH v4 0/6] t: mark "files"-backend specific tests
In-Reply-To: <CAP8UFD3xWW-WvLPnHNVyJbbXDvs85TTq-wVVZ-qnJLSdqtR4bg@mail.gmail.com>
	(Christian Couder's message of "Mon, 29 Jan 2024 13:03:13 +0100")
References: <cover.1704802213.git.ps@pks.im> <cover.1706525813.git.ps@pks.im>
	<CAP8UFD3xWW-WvLPnHNVyJbbXDvs85TTq-wVVZ-qnJLSdqtR4bg@mail.gmail.com>
Date: Mon, 29 Jan 2024 12:38:01 -0800
Message-ID: <xmqqttmvho46.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
X-Pobox-Relay-ID:
 4C588A04-BEE6-11EE-B734-78DCEB2EC81B-77302942!pb-smtp1.pobox.com
Content-Transfer-Encoding: quoted-printable

Christian Couder <christian.couder@gmail.com> writes:

> On Mon, Jan 29, 2024 at 12:07=E2=80=AFPM Patrick Steinhardt <ps@pks.im>=
 wrote:
>>
>> Hi,
>>
>> this is the fourth version of my patch series that addresses tests whi=
ch
>> are specific to the "files" backend. There is only a single change
>> compared to v3, which is an improved commit message for the first patc=
h.
>
> I took another look at the patches in this and it looks good to me
> now. Feel free to add my "Reviewed-by:"

Thanks.
