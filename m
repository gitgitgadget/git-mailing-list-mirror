Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C413E605D2
	for <git@vger.kernel.org>; Fri, 15 Mar 2024 16:54:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710521686; cv=none; b=JVVXnEjZ7Q08MKwJ5q0BKswJJz96NfQ2QQaWLHXTiGEvP1xvhpiMb6xbxmEkeqHh6iXWy7l76Kwjs84rFaB8BQ3S/qUdszhbXKj8c6/VqW3XPrXyOZkB8XEZwnEyeBAtFnY9eHs4w+EDXfdBSSCNy0yAE3/HH4F/qM6Ht5P89T0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710521686; c=relaxed/simple;
	bh=ea2BcrACgvddcvA03NHl7Z6T6zbeoXqe1JEij9PU/IU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=dOyHJ82cll1lK/bf8bECUNDZj7bPRgs3YHGtKCf0cgb7Lw5nVwjCC0YbcQBNe/4RiqhNFTc/Iae3pe7NeYo1DqaIHsdGW1Bp1YWJDMoP9/mWAAQ0NOEGvT67kqHilPO8yNTnqEoOmuu12w8nYxVI3WnpGV6BxggqbE/ulyIKVek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=I9CZFxuP; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="I9CZFxuP"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 4CF5E3273A;
	Fri, 15 Mar 2024 12:54:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=ea2BcrACgvddcvA03NHl7Z6T6zbeoXqe1JEij9
	PU/IU=; b=I9CZFxuPvQFRFtGF2VQdoxIhLiekpDzbk9D0YVpZNjpsRx0qxjLe60
	SchNMl/m7ez8ZHF5s0wEGlPxIoYB1GgTu5BnNugXMWAaRH+Cpvr4DuJYUehPGtQo
	EmRxihZUN2xRGL/VfURv1+Da2GAGkUrj0nc0TPO5snTPKrhNoie2M=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 455CB32739;
	Fri, 15 Mar 2024 12:54:43 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.185.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id E187D32738;
	Fri, 15 Mar 2024 12:54:39 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Christopher Lindee <christopher.lindee@webpros.com>
Cc: Martin =?utf-8?Q?=C3=85gren?= <martin.agren@gmail.com>,
  "git@vger.kernel.org"
 <git@vger.kernel.org>
Subject: Re: [PATCH 2/2] Add transport message for up-to-date references
In-Reply-To: <SA1PR14MB469168B6AAB246344190D9038D282@SA1PR14MB4691.namprd14.prod.outlook.com>
	(Christopher Lindee's message of "Fri, 15 Mar 2024 03:09:53 +0000")
References: <SA1PR14MB4691A8AC86E290A3539BE1398D2B2@SA1PR14MB4691.namprd14.prod.outlook.com>
	<CAN0heSp2A-sx_WA__90WGhP1yD3EBBtR7_N7s5ZPWqe559xpKA@mail.gmail.com>
	<SA1PR14MB469168B6AAB246344190D9038D282@SA1PR14MB4691.namprd14.prod.outlook.com>
Date: Fri, 15 Mar 2024 09:54:38 -0700
Message-ID: <xmqq7ci3saep.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 B6A3881C-E2EC-11EE-BA84-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Christopher Lindee <christopher.lindee@webpros.com> writes:

> This raises a good point: if we default to the old behavior and only
> send up-to-date refs when the new option is present (as is currently 
> the case with this patchset), then existing scripts will continue to
> work.  Moreover, scripts using the new option will consistently have
> "up to date", so they can change the grep to use that (since it will 
> never show "Everything up-to-date!").

Scripts should never be parsing the output meant for humans.  You
should worry about "git push --porcelain" output first.

I think we report "= srcref:dstref [up to date]" there and that is
what the scripts are expecting for an up-to-date case.  If you want
to allow the scripts to react to a forced no-op update differently
from the normal "we didn't even tell them about this ref" case, then
we'd need a different type letter or "[up to date]" string (or
both).


