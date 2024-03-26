Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E57AA13D63A
	for <git@vger.kernel.org>; Tue, 26 Mar 2024 21:33:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711488809; cv=none; b=YH+YyIl8qPGYpAUo+TEvriWcHJ/oonA5EeHDYIlmz9T3iDL3RpKwdyJbqVzQgw+yX87sFx7h4BfLFevptz42/GlBd/JfVMxDYyou3lUBiV4DYgQ7YsVtIfY4QvGSbQBKkOxfl2PCHJYs/Qcu25MjQtIaNSfDU9L59GtcFcOMMHM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711488809; c=relaxed/simple;
	bh=yaSHvtE/Tduvv4ZMeSJwgeNy0tY7pJ/OkVdC4iUNqhs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=O4jTva9kom+k8mmBQcU6uCLRpd7fbXLSqoXABBzQydQd2aF/0FnNrnVmfhZkybtck2VlTHx0u468kwEvClwmor/54Tt7X0flAdkgNjh6pOWLH6PKeAD98KM8KnSoDQV1Yg6yy+U7Pz2d8oFUYHs9Q1RN+9Be1/48UVrN04d5FIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=j8htNnuv; arc=none smtp.client-ip=173.228.157.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="j8htNnuv"
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5993030218;
	Tue, 26 Mar 2024 17:33:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=yaSHvtE/Tduvv4ZMeSJwgeNy0tY7pJ/OkVdC4i
	UNqhs=; b=j8htNnuvCKfUAy25J/h+LDXzTR1jd/1heT+o8R7LHeJxLixHKdjd28
	JOR1BYMmIj9YxB3YWVfJWal5J2Y8VzYv6moi4DE7kL1uOsP4Fo5wJZ7po77XH2nm
	hkhFfE1HA0Whcq8MoOn3wTZa5gaiPv2g3LI1zaFvXqsRVvoqZg+jQ=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp21.pobox.com (Postfix) with ESMTP id 5282C30217;
	Tue, 26 Mar 2024 17:33:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.139.61])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D94F630216;
	Tue, 26 Mar 2024 17:33:17 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  johannes.schindelin@gmx.de,  peff@peff.net,
  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 0/7] test-tool: add unit test suite runner
In-Reply-To: <cover.1708728717.git.steadmon@google.com> (Josh Steadmon's
	message of "Fri, 23 Feb 2024 15:33:49 -0800")
References: <cover.1705443632.git.steadmon@google.com>
	<cover.1708728717.git.steadmon@google.com>
Date: Tue, 26 Mar 2024 14:33:16 -0700
Message-ID: <xmqqjzlo8yqr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 75DDD61E-EBB8-11EE-B35F-A19503B9AAD1-77302942!pb-smtp21.pobox.com

Josh Steadmon <steadmon@google.com> writes:

> Please note: this series has once again been rebased onto the latest
> jk/unit-tests-buildfix.
>
> For various reasons (see discussion at [1]) we would like an alternative
> to `prove` for running test suites (including the unit tests) on
> Windows.

Folks, what's the status of this one?  I just checked the RFC thread
and this last one (more than a month ago) and the issues seems to
have been addressed, but I prefer positive acks rather than "we've
seen it already, take our silence as the sign of endorsement".

Thanks.
