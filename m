Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA5EE16A382
	for <git@vger.kernel.org>; Sun,  8 Sep 2024 21:33:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725831203; cv=none; b=YHDOI8XHPAXbvIqQSxybZDlrDSi6/Gl8bsYCDvpZHGievg9WNrGy0kLPPIPjTEiK4C+OL9MWQOq+f+DaIArb6xeU7GHUeC4op2P4cw80pGtWkwZ96rGGmf8fR4BVfr+UtGh28HzKAHgrru9dmi8Mu9AqWs4fu/+GEzmzvrwRzdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725831203; c=relaxed/simple;
	bh=pNiIfye85xunNEYNDT6uKOsGMKpxDjRvY3J9jLr4ZIk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lS/YI1+rzBGorbT6NVHWS0v4z3DcdMUUBDV4/Z9gJKYywDmVPWc5e4Xj6CSiM6NvwqAVxP0DoMz+HPQ4i+TLYvSQ+D7YUwXORLJKAF8RelbOd+GGIGhm8U4pzDutdEIf0Nvz/wz1DkNkWS55xKwzUpzCdLHE+W57crKurLMA/Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=xNh3P/pC; arc=none smtp.client-ip=64.147.108.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="xNh3P/pC"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D476B322AB;
	Sun,  8 Sep 2024 17:33:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=pNiIfye85xunNEYNDT6uKOsGMKpxDjRvY3J9jL
	r4ZIk=; b=xNh3P/pCvfytLHbD+UqonkAYXStwCX0BF+cYbVa1efwRS01t6i81oj
	zK/6vsNXyNmnnZgfxK5NbthIBE6ybQa9PxKBk7svXyzmShoJF0worMjWsWkyQGgX
	o4XTwctpPiI93PbKXPXSjbwmHqkj+UoFGKesp+8U1FqarJ5OLBBF0=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CB67B322AA;
	Sun,  8 Sep 2024 17:33:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 3D643322A9;
	Sun,  8 Sep 2024 17:33:21 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Sean Allred <allred.sean@gmail.com>
Cc: Calvin Wan <calvinwan@google.com>,  git@vger.kernel.org,
  steadmon@google.com,  spectral@google.com,  emilyshaffer@google.com,
  emrass@google.com,  rsbecker@nexbridge.com,  mh@glandium.org,
  sandals@crustytoothpaste.net,  Jason@zx2c4.com,  dsimic@manjaro.org
Subject: Re: [PATCH v3 6/6] Makefile: add option to build and test libgit-rs
 and libgit-rs-sys
In-Reply-To: <m0seubo5q7.fsf@epic96565.epic.com> (Sean Allred's message of
	"Sat, 07 Sep 2024 10:15:12 -0500")
References: <20240906221853.257984-1-calvinwan@google.com>
	<20240906222116.270196-6-calvinwan@google.com>
	<m0seubo5q7.fsf@epic96565.epic.com>
Date: Sun, 08 Sep 2024 14:33:20 -0700
Message-ID: <xmqq5xr5x23j.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 F8726556-6E29-11EF-9A54-2BAEEB2EC81B-77302942!pb-smtp1.pobox.com

Sean Allred <allred.sean@gmail.com> writes:

> Calvin Wan <calvinwan@google.com> writes:
>> Add libgitrs, libgitrs-sys, libgitrs-test, and libgitrs-sys-test targets
>> to their respective Makefiles so they can be built and tested without
>> having to run cargo build/test.
>
> I feel like clippy should be run as part of these somehow, but I'm not
> sure where.
>
>> +libgitrs-sys:
>> +	$(QUIET)(\
>> +		cd contrib/libgit-rs/libgit-sys && \
>> +		cargo build \
>> +	)
>> +.PHONY: libgitrs
>> +libgitrs:
>> +	$(QUIET)(\
>> +		cd contrib/libgit-rs && \
>> +		cargo build \
>> +	)
>
> We should definitely be setting `RUSTFLAGS=-Dwarnings` as an analog to
> `-Wall` in the C world, no? These crates should build without warnings.
>
> Very excited to see this work; thank you for putting the time into it
> :-)

Thanks for helping.
