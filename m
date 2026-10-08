Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A91504F0520
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 18:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791483498; cv=none; b=VoC2+BnmAi94whmfrI5OdOgzKdUcbhHJBnoC2tf5AUTqXb8FboubLcnI7ljgeeGxRb2jrSf1hmSsECCalvCNqFKYY9Z/PKJlfNuzPIucKm4nYitGaccruYj2L8VEQ+5kEtlagl02xhRNXJV27xtpyTqzcVJLMku5nqoIOFkx04Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791483498; c=relaxed/simple;
	bh=It8f6zGGJpKA9s0d8fi9izl7/PBCbRnaOBkhdgGvw+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qPO2gM7MgHu/P7CE3ncEx+LwjH/cTCVyclc0PX1Xv8IrvQUtJzyC4e8R5yfRQxscWz4UNXz5f4crHij7RJAecGR/COhP1HDIvWil4eRqtdStxsFkH7aNd/hHWl/V7meYJ9ShDqNR7McaRwZLGbS3+JSlKdF0TfKb8du6NmGP2GE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LDyAu1qm; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=lwDVFv6n; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LDyAu1qm";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="lwDVFv6n"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 00CCB1D0007A
	for <git@vger.kernel.org>; Thu,  8 Oct 2026 14:18:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 08 Oct 2026 14:18:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791483495; x=1791569895; bh=4k0LIMtEoG
	HVtcrsHU/q4LQncNiyDuYqzto88/PXC/U=; b=LDyAu1qm4aXel3R3unJMNj4A9p
	LJN9JaNXvIAcMgjAP/cWyAAUXaGDBPms7VlnKTRirYP8v5VDVHwr1mHlOCaOp1sC
	o/EmvAYRf8p81tbDtf4JN9OEIYwtgEwCcKEIwhEcbR1tONCRct1NjKReKmNy33Ku
	DTnHoEnadLKat/cUiebP3ouRhSZsVFAWZIMYe/KL5Wfp+tidCIviVKBsYkia8itk
	Vb5gWQyNSLdMssAP1TXnbFOVVXspKq1Nt2lw/+mN9eM2uP6WhWvD5U09VQ4Gbdyr
	178ebd1kP/Y3oQZp19a+zF4GoypH3ORONY1xuioP07ba8gd/S6fVN5n6Q+mg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791483495; x=1791569895; bh=4k0LIMtEoGHVtcrsHU/q4LQncNiyDuYqzto
	88/PXC/U=; b=lwDVFv6nJYPECcB2HRhtEy7lP91edAScBZA2WhAStzPembxawoN
	5KYPT2t0JWnU+UmcjvlTMif7CMM729uqNz+WJ9zSc91ywntuSxLU41Gb1aKsjgQy
	ef6VJOlAA3GPbnG3Mz5qU+Jypo+QeS6bLndhDot8cbyr1YZUMacHT4r68DRGhbJe
	EmVSje48CIpg8hGunLNyZ66wq3c9BiQRiOpwnDxt/x3AmNyMj/MW93ZAl/2qHJqW
	4ktuazUJydJZWvi2v2kJ8pAitzklrp6OWYtMs1Qi38MnkRBIma7byoKaMn+7EYqM
	5r26cFTNN41K8qW2neg9UOnVirrOG6gXsog==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791483495; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:Or/t+aqQE9Wkpw00d87Zt1QIudCOdha4nT8qbLV34QmbkmQ
	X6Tj8iTKbmHxdS3n1+ggAcSEShK3WHHzN2MOLU7BqE6gGu417+i0cQI1Hd6/cli1
	zjj8AdYiGc/ef03+OB/zKXfjC8wowIZHKtZlys7tI5onk1jiTK+KUeU6+sN6/83Q
	gZIcxxj8igJwW0Ow3PFj+c8TKyvP2vmSe0j/yHaVVJWI9XZKk0NiWDHXKfn0BMw0
	5+Cb63v1XEYg9vzcQm33CH5MWJjTGqtArY8w2D9c+so5nrZDFu629OQrdup5Q5F3
	LrX1E/POjgy2zJWVJYn7SYGc08zmM2F4jTVYppg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:hemteXwV0wMYxd61YOIKPcVmsJAlOec/yFqqMzHkeqs=:It8f6zGGJpKA9s0d8fi9izl7/PBCbRnaOBkhdgGvw+M=;
X-ME-Sender: <xms:Z97HanVbkbJ73HmBoYmBXAhFyScxN14rOIohlejfnoToyEUM2PrM-w>
    <xme:Z97HamnPGcmdzi0Qa2Kdb37xnCtnA9annUkeruzhkGGzuOj6UCkaHabO1-Zj7yDtz
    -yfZJ3qA6b_uDXcMMr3i-V3AevbU_XgcZ10yzyu5vqqkqDSwCcCSv8>
X-ME-Received: <xmr:Z97HaoazC4Hmm2uv_ZHttI1PLfzPqZIAb-CzvHvmberjNln4O6VYZQs-_1H_YzePFLFrWcFvCOmTtjwRR1F_nj6KygfdZSAV8UQ7>
X-ME-Proxy-Cause: dmFkZTFhQoxQxpnjzuJYBMr/Rmu5higXoAVuKq9OBzQMJqM9urAAYHDS3NIz6e5s2ZaA0G
    6wRVs0UCwCwQ6YevQ0bAa0TAVvSy+bGkVo4YSLnfh290JMMRotaAVOHinceGJsHxaehH2X
    ns9YCKZOTAi94YZ+gObnwqUPJBRCUWHmNRda2GUs4IYLv+GgKxSACfusUXhNgxr9uqmidB
    YdglnwTM3AzWjcAe9EemUgFW78B9njwRdcJ2DGqPx4Phceef5/hsUDB2E+U/iaPxuoWFsB
    QWF9TN6RjTNoq/w0BTIQXBD8IZnpb95MDMwsQoPdzB+bvhpqguOY4AMNEndv1o7D9aLLRy
    M8tKfxFVkFTyQ+oX9idkab3uO6BbXRJCzY5F/xQoTkTycnuvlghzCUlyFJB6PBSquOW1bL
    /PofOHUgTxHb3EqAHCqEB/O+qxbmVLnZicbx278H6g/mGTC0hfIVJWMQZSvtLeM8wGzYHn
    D47UG4nII+Cc4ZAjqSIDFTVD8sw8/zVituW+NpnNqfFNwEQCzSyj4/mtugodBqEMPCEEUd
    AuZlMoGUM+z3cXuAPQRuJO/zcng+fBN9nqbtepepw1J1r5ZaIelCaGUdDtBDYwogPmA+ZU
    8MKJpKhgtOmiuejS8TRZ0lNe1/aOnAvyfH4BGt5sxVqNxQOFXbc72Zsx4hsA
X-ME-Proxy: <xmx:Z97HahPi7QE908J6DWdsTx-GJj0liJJ59SfYM8DuMHzq04RK8d2zRA>
    <xmx:Z97HataJKxwvm8P-KOhIv2gg6KW4PhLwX-rI5xfqShqwT3YZP-onYA>
    <xmx:Z97Hav1BPhC-cRwVHSDaad6kXppzasG0XZ_Sus9ULG8W-MIpyycwag>
    <xmx:Z97Hajd68pzNNgdQQbzSdXFlN3jZlDGBbyt9UpaltSaWV-rcrb3AVA>
    <xmx:Z97HapXblf5FhIMjrtlORa732g9eaUdL3lA4ucD5vT2OGHUR38JKaV7n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 Oct 2026 14:18:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>
Subject: Re: [PATCH 8/8] ci: drop redundant linux-reftable job
In-Reply-To: <20261008-pks-ci-housekeeping-v1-8-baf015c589c0@pks.im> (Patrick
	Steinhardt's message of "Thu, 08 Oct 2026 12:01:26 +0200")
References: <20261008-pks-ci-housekeeping-v1-0-baf015c589c0@pks.im>
	<20261008-pks-ci-housekeeping-v1-8-baf015c589c0@pks.im>
Date: Thu, 08 Oct 2026 11:18:14 -0700
Message-ID: <xmqqzewoys2h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> The "linux-reftable" job exercises Git with reftables as its default
> backend. But this job is arguably redundant because we already have the
> "linux-reftable-leaks" job that exercises reftables with the leak
> sanitizer enabled, and it is unlikely that we will catch any extra bugs
> with the leak sanitizer disabled.
>
> Drop the job.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  .github/workflows/main.yml | 3 ---
>  .gitlab-ci.yml             | 3 ---
>  ci/run-build-and-tests.sh  | 2 +-
>  3 files changed, 1 insertion(+), 7 deletions(-)

As linux-reftable-leaks job uses NO_{CVS,SVN,PR}_TESTS in ci/lib.sh
to disable tests on these foreign-scm interoperability tests, this
change means reftable is no longer tested with them at all, no?

Not that I personally see specific value in testing git-p4 with both
reftable and reffiles backend, the loss of coverage needs to be
noted, if not justified, in the proposed commit log message.

Other than that, nice thinking.

Thanks.
