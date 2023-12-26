Received: from pb-smtp1.pobox.com (pb-smtp1.pobox.com [64.147.108.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87A1D4F88B
	for <git@vger.kernel.org>; Tue, 26 Dec 2023 17:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="hVBJKguR"
Received: from pb-smtp1.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 856531DBE9D;
	Tue, 26 Dec 2023 12:18:16 -0500 (EST)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=WgeHrKv6zev2YIAUlYZ7UDaFYzC66wwGw6Z4tF
	wTsyQ=; b=hVBJKguRBBBZsm4uU6G0qoWhdRIuampLAyVb5f6Y8bFlYdz9aDc2bb
	AbOHhoOTfPnox72Fpq7ra7DWIcWLP+Ojpmf11bOsECddj3jPdDKzlwTDR737dxFa
	T3pst4wpf3hAMqih3UC/PrJ1IaPrH78K7pMFz5m0qCSs3Dk1eS4MU=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 79B421DBE9C;
	Tue, 26 Dec 2023 12:18:16 -0500 (EST)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.193.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id DF4111DBE9B;
	Tue, 26 Dec 2023 12:18:15 -0500 (EST)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  "Randall S. Becker" <randall.becker@nexbridge.ca>,
  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH] sparse-checkout: be consistent with end of options markers
In-Reply-To: <20231224083206.GA2053380@coredump.intra.peff.net> (Jeff King's
	message of "Sun, 24 Dec 2023 03:32:06 -0500")
References: <pull.1625.git.git.1703379611749.gitgitgadget@gmail.com>
	<20231224083206.GA2053380@coredump.intra.peff.net>
Date: Tue, 26 Dec 2023 09:18:14 -0800
Message-ID: <xmqqfrzoj31l.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 C19677F2-A412-11EE-BDBB-78DCEB2EC81B-77302942!pb-smtp1.pobox.com

Jeff King <peff@peff.net> writes:

> On Sun, Dec 24, 2023 at 01:00:11AM +0000, Elijah Newren via GitGitGadget wrote:
>
>> Remove the erroneous PARSE_OPT_KEEP_UNKNOWN_OPT flag now to fix this
>> bug.  Note that this does mean that anyone who might have been using
>> [...]
>
> Thanks for wrapping this up in patch form. It looks good to me,
> including the reasoning. You didn't add any tests, but I find it rather
> unlikely that we'd later regress here.

Surely.  I am certainly OK with just dropping KEEP_UNKNOWN but I
would strongly prefer to document what we "fixed" (your "misspelt
option name" example) and what (mis|ab)use the people may have been
relying on we have "broken" (the same "misspelt" behaviour that can
be intentional is now forbidden, and we document that this change in
behaviour is intentional) with a new test.

Thanks.
