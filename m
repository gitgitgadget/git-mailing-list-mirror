Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E854E3032A
	for <git@vger.kernel.org>; Fri, 26 Jul 2024 18:50:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722019844; cv=none; b=rScihYdfk94tHvCrV/R6LhtGjD0tXu7fB4haeRQNL3fL1jTGHmlkcc94fDKwHg2CupUExK0jZ8mfGyQAMDiSvTeMXnCbR7iMAaJalEYoVUOQITy5Y3ZCPloLztb5xCGHPfVd/7OzIxgxfjer8EW7uKvo2Ynhh8msBRllK8a85eg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722019844; c=relaxed/simple;
	bh=AH0bmntrQz0uOHXyG+w6SxiJRafn1V/Okd32ZOf0Eho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oJ/xN+reePmhqjzRGA3h3a06DNRkCioA1IdhAaYOJHLgv0gxyMuNokj1cg1fXEqyFffCWM0tMfQvbHgNTQsASNsIVI9/RkaGApWbg4Ce7nFVADOvmLjcnDfBzrMb8ija/C55AiIvDQ5ilkgum7y9WuSTqINp/3ad7O4D1Iljhr0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=AyGDVfFi; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="AyGDVfFi"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5722C36249;
	Fri, 26 Jul 2024 14:50:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=AH0bmntrQz0uOHXyG+w6SxiJRafn1V/Okd32ZO
	f0Eho=; b=AyGDVfFijMFLhmCAztY7wBy7qsej5otiompArNKGRH/T6n+l37LXHV
	h9ESEakkYumrJC8HHQzzEFWVPqTz/dJz5L/QpUwe2ZlbbtD9ih5G208uW4jdKl/c
	sT6eLBzRDoGvNm85B/fHytlHWGf1rw5XAMTMgZMrUnhuQgT4icEMc=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4FC5D36248;
	Fri, 26 Jul 2024 14:50:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id 1E23936245;
	Fri, 26 Jul 2024 14:50:37 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Eric Sunshine <ericsunshine@charter.net>
Cc: git@vger.kernel.org,  =?utf-8?Q?Rub=C3=A9n?= Justo <rjusto@gmail.com>,
  Phillip Wood
 <phillip.wood123@gmail.com>,  Kyle Lippincott <spectral@google.com>,  Eric
 Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 1/5] t3430: drop unnecessary one-shot "VAR=val
 shell-func" invocation
In-Reply-To: <20240726081522.28015-2-ericsunshine@charter.net> (Eric
	Sunshine's message of "Fri, 26 Jul 2024 04:15:18 -0400")
References: <20240722065915.80760-1-ericsunshine@charter.net>
	<20240726081522.28015-1-ericsunshine@charter.net>
	<20240726081522.28015-2-ericsunshine@charter.net>
Date: Fri, 26 Jul 2024 11:50:35 -0700
Message-ID: <xmqqplr0t2bo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F2648954-4B7F-11EF-A171-9625FCCAB05B-77302942!pb-smtp21.pobox.com

Eric Sunshine <ericsunshine@charter.net> writes:

> From: Eric Sunshine <sunshine@sunshineco.com>
>
> The behavior of a one-shot environment variable assignment of the form
> "VAR=val cmd" is undefined according to POSIX when "cmd" is a shell

Please use the right word to describe what the standard says.

Throughout the topic's discussion, you seem to be repeating
"undefined", but the word POSIX uses for this particular unportable
behaviour is "unspecified".  The differences are subtle, and for
programs that want to be conformant, there is no practical
difference (in other words, we should not rely on the existence or
validity of the value or behaviour if we wanted to be portable).

The former is what results from use of an invalid construct or
feeding an invalid data input.  The implementation can do whatever
it wants to do once you trigger an undefined behaviour.  The latter
is what results from use of a valid construct or valid data input,
but outcome may differ across implementations.  An "unspecified"
behaviour often are still consistent and sensible within a single
conformant implementation.

