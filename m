Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 283F112C460
	for <git@vger.kernel.org>; Wed,  7 Aug 2024 21:53:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723067630; cv=none; b=qzklq00mD48GgzPeOSF8is2FYxQMdlmxaFQrDEFQsGARh50H9ple6yLwYTB2hfcOMzCG25OQ0hMdKn5Na4zHAglJDQG+Zx7x6fbGUEM5uajboeGPyH8g6f2uT95ODm0U9EqRNaBiLzOnRQrV44E3t4FGz3pSOkHUtcqjhlZvXn4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723067630; c=relaxed/simple;
	bh=OivYkFIva7TjwwjypwfjQ61m69FqgSa6hpSL0CA8DC4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=SDym/4hQPQ3cONyi9fkcaLK8mPsVYVPlEu3OqQUZYKAu3Qhid1Uzq7vKnIpxB80AFe1eVnNi2OH7UStOtLS0oe62ja6cSQM+KdVSRvj/x+EoxkRq+NVUtJUDLtBbCKRH1miNPCf55VntPlMAchr84M4rJgrFlGts/raWJFTHTPc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ba2tdCzh; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ba2tdCzh"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id A085C1E709;
	Wed,  7 Aug 2024 17:53:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=OivYkFIva7TjwwjypwfjQ61m69FqgSa6hpSL0C
	A8DC4=; b=Ba2tdCzhtKr3cEXpmMGdEd0kj8yJt/MK/xlGrLVo8btvWOf8oGM1QR
	eZN5aCeOR3O1lVUklreMv9C/ysLom8cWzI9PCrzfZ7nqpiYJoKk3PEtAgli0HRll
	RXRL2C6+Br76mxrBIdkbTZeS1vXRKiHTBdSQzHwxmmFmHQUVyPAKA=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 92DCF1E708;
	Wed,  7 Aug 2024 17:53:42 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.108.217])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id AE3291E707;
	Wed,  7 Aug 2024 17:53:38 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: Josh Steadmon <steadmon@google.com>,  git@vger.kernel.org,
  calvinwan@google.com,  spectral@google.com,  emilyshaffer@google.com,
  emrass@google.com,  rsbecker@nexbridge.com
Subject: Re: [RFC PATCH 6/6] contrib/cgit-rs: add a subset of configset
 wrappers
In-Reply-To: <ZrPpxE7OZtqsbD81@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Wed, 7 Aug 2024 21:40:20 +0000")
References: <cover.1723054623.git.steadmon@google.com>
	<1e981a68802ac5aa7538381eb9469e524265ee40.1723054623.git.steadmon@google.com>
	<ZrPpxE7OZtqsbD81@tapette.crustytoothpaste.net>
Date: Wed, 07 Aug 2024 14:53:36 -0700
Message-ID: <xmqq4j7wngnz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 80E36502-5507-11EF-8832-BF444491E1BC-77302942!pb-smtp20.pobox.com

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

> My recommended approach here is to support the version in Debian stable,
> plus the version in Debian oldstable for a year after the new stable
> comes out, which is what I do.  That gives people a year to upgrade if
> they want to use our code.  We _don't_ want to follow the
> latest-stable-Rust approach because it isn't appropriate that software
> has a six-week lifespan of support and that isn't going to work for
> software like Git that people often compile locally on older versions.

This is sensible.  Conservative enough to avoid leaving folks on
other major distros behind, but still not too old to be a burden.

