Received: from pb-smtp2.pobox.com (pb-smtp2.pobox.com [64.147.108.71])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C760D7F9
	for <git@vger.kernel.org>; Wed,  4 Sep 2024 18:33:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=64.147.108.71
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725474802; cv=none; b=FJiFXHDQX76aQRmTmA6XYJMVVvybjViKIvUGBXAjAWx7/p5jyCmHWu5uliU28PGqyalGAgK0f+D8/xH7fEE34BCXNHR1WO2mwls/8WboZqaqsltfTGG87UxO1rbPDXJgXpyjyGLSxS3Otp1dwGGmJ6HjpUXSxz3enBvnqru6MpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725474802; c=relaxed/simple;
	bh=WapTQe9xDPk4w/A8NCahZUOQ5j08uhsGMuJxWrf1FZU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=naHCH1+FYK0eqEm3Q1XlO9Cw41Yzxp4S5qA88aPDfYYWqmLVCeUBEHEs0wPUNXLfvt2Rj/hJ3+segwrX7TqgGRja0ntU0cIFskRY94H5ler5oMCpF0iS+6SLpltGYRw4/xUSN+tyi6EuqJintfNdV22LMYf/hCQ1W2NiI6T0Tm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=MKFtwh1T; arc=none smtp.client-ip=64.147.108.71
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="MKFtwh1T"
Received: from pb-smtp2.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id AD9C51EBF6;
	Wed,  4 Sep 2024 14:33:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WapTQe9xDPk4w/A8NCahZUOQ5j08uhsGMuJxWr
	f1FZU=; b=MKFtwh1TTS73rJBmDV2wRXHuBjsa09pm8GP0It0n7/MZPvyyVjYaxC
	6Ls8GvDpsrtHjJIbg+IEidfHhbi1wpLNeXK6VsQvTjxkJgSZZsE4C31IZromY/+B
	b7n+iLhX8zLhKj1USpegzYdf235YyoyKAG2axQwyiy1R/oDZnG4OY=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id A2D961EBF5;
	Wed,  4 Sep 2024 14:33:19 -0400 (EDT)
	(envelope-from gitster@pobox.com)
Received: from pobox.com (unknown [34.125.94.240])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id 0D7AC1EBF3;
	Wed,  4 Sep 2024 14:33:18 -0400 (EDT)
	(envelope-from gitster@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Calvin Wan <calvinwan@google.com>
Cc: "brian m. carlson" <sandals@crustytoothpaste.net>,  Josh Steadmon
 <steadmon@google.com>,  git@vger.kernel.org,  spectral@google.com,
  emilyshaffer@google.com,  emrass@google.com,  rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 6/6] contrib/cgit-rs: add a subset of configset
 wrappers
In-Reply-To: <20240904173053.1220621-1-calvinwan@google.com> (Calvin Wan's
	message of "Wed, 4 Sep 2024 17:30:53 +0000")
References: <20240904173053.1220621-1-calvinwan@google.com>
Date: Wed, 04 Sep 2024 11:33:17 -0700
Message-ID: <xmqq8qw79slu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 282F04A2-6AEC-11EF-A17C-9B0F950A682E-77302942!pb-smtp2.pobox.com

Calvin Wan <calvinwan@google.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>> ...
>> Debian stable is the version that most projects who have defined
>> lifespans track, so it's also what we should track.  According to my
>> recommended approach, that would be 1.63.
>
> ... I also don't think reinventing the wheel with
> our own implementation makes sense in this case,

I do agree that we would want to avoid that.

> and even if Debian were
> to upgrade stable to a higher version today, we would still need to
> support oldstable for another year.

I doubt that part, though.  As long as the rust binding stays an
optional code, as long as we are supported by the "current" system,
we would still have enough audience to matter.

What's the primary objective of this effort, by the way?  

Is it "we need to access the guts of Git implementation from Rust"?
Or does it merely serve as an example application to have Rust
bindings, a good goal to have to give us an incentive to clean up
the subsystem interactions in our code?  

If it is the former, we cannot reasonably achieve that goal until
some form of standardized foreign function interface becomes
available to wide audience.  If it is the latter, on the other hand,
it does not have to be Rust---if the version of Rust that is
distirbuted to the mainstream users is not yet ready to be used in
such a way, we could pick another goal (like, "Can we clean-up the
interface cgit uses to call into us, so that the parts used by them
look more like a proper library?").

Thanks.
