Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CABA2475CE
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 19:31:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770406281; cv=none; b=sIrRb1XFUSbpFhP1VaTCXkKdpS3BoLcKpvyCQiTL3mgC43mKaOsCO1pLkM3+OJemqs0h7tihakj+wEGGwfYqixsZG+3wTy0cdxx5wYerNmsM4rCj1YYxG1uvxgXtMNPlY7tzsJgeGw/4FVbbUfy+N0tFngg/BhcvPXsdYNBLfhI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770406281; c=relaxed/simple;
	bh=atPl9hJ1/zd7tEO6dnvnXDZlrJQrkkdZ3vNZuH9VPA8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IjLh81owMPQytNrrKY/eakbGHR1hPC7HKiUe+aQg9uMK8BLsIWx5QBQi2+KMzTNs+uXwun4TUfjEY0htFz9Nn3VjUAnbr5PGxXp52o+t5g9OAdZhbkfaip6fDK6s7R5uqZoXopiAWUCndrl8agOulo+uZ2Lm+Qe58NPZUMS/WzI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cLzsTpbl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MPZoyWbD; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cLzsTpbl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MPZoyWbD"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C0C6514000ED;
	Fri,  6 Feb 2026 14:31:20 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Fri, 06 Feb 2026 14:31:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770406280; x=1770492680; bh=Kfn9F4N3H7
	02iqb+FSLllLHy3aBfHee99ihy2wgnnyY=; b=cLzsTpblKkQem9vq8V/vmzOC7C
	ernjRHqNJj8iy3qpYahjlVhOFRPY/UxS1xtZCp7aXQwlbH3BBPUvBqTAaOZQnKOr
	oWbirbgkXKrssUmgeh08Q8saKVAJlN7U5SU1LraqFK5zy+OoLp9kf6UMTsIWF5Uf
	zOU3NAVV1ZEiwz/nasVVIUI1bCD11Zu1IBpusTupHEKnkQyunYBi3TGxCbsJm7dE
	LzKq4Hp+B5vPTHLfAINkc2kdG0dT9RBj0jACpWB/YT8aqtsv1hyctFUMXUXg/3U0
	cNLXx5IN0gWD3q5nl0qQdbCk8zGpy0jZfP4By8WGd/ZjOelg5RDNmsnGGkhA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770406280; x=1770492680; bh=Kfn9F4N3H702iqb+FSLllLHy3aBfHee99ih
	y2wgnnyY=; b=MPZoyWbDenouyZtxzETWC+pK4rIQtgENtxGsEayHuuMwGTMNym1
	ZcLsYbTcs2Ns3wUMAIehrgmYuv1HhqSr/CElFeX5uiYthXZu3Onw1Y1dr1Tvsy5k
	M6qEurqQACROj/8UGtFhNT/e6vkGyqrW+r951TQKw8od3NizT6nsp/HOPHRIQpyP
	dePs2AwZfjgywTUcOpSpd5cdkLRpvylmc/7xu9u0rWW2AbPDuDFAWO+8U674K6mD
	IHKYCs2mXleF6iJOb1Lm7BbwpGDA7GKHIMWpqL+q63UrDKWyix65lKAN0uB/vVYU
	CsQJtwdamwPBHgvp+8TH1ybMyJAyJDb3p7Q==
X-ME-Sender: <xms:iEGGaTLwUm9sx6FBTZJCrz6jMpBY13NT4cDgfmUknoogigcLHDDyCg>
    <xme:iEGGaS-cZnFn0AFxR6ESNUquYPFHKdmRumflPW5PYZSHGxAzzu9DeLBQYwNB_eAft
    _AED_KZG8RKVIPLBZBsaPolbCtq-ls9WKCk485audTav3FYckIn4w>
X-ME-Received: <xmr:iEGGaXHzp_7N9LOypxhaMi0so30uMqIMIULFEzhUuJre29cPn4wsmjlkv9qpLO0w91iHaD8IBikNrvEPh0qIaqwDsQQBCOWdyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeeltdduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtofdttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeeivddugeffgfffffevvedvieel
    ffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddvpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhith
    hgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpd
    hrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    thgsohgvghhiseifvggsrdguvgdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpd
    hrtghpthhtohepphgruhhlohdrtggrshgrrhgvthhtohesshhhohhpihhfhidrtghomhdp
    rhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:iEGGaV5qFO9wPiVNTvsqs3PK6BB3X56MnhXIyf03IA5InQc1CoV9IA>
    <xmx:iEGGaYZUdPyIwBto1fjmV7CUEdwEX3kZiBTLQxruD0mp_6pjBJgphw>
    <xmx:iEGGabgy_0t5BQLxdJUHNrFegvb8NYHRpn6Evx0-If4hEaF1nLDsjg>
    <xmx:iEGGaSf2cr67iJP1WmSPjYJfeY4tKR5dZhwOo8O9zffq95M50RZzzg>
    <xmx:iEGGab60cMHkLGldDqisb6QGkZ8129lzKh_pY7RB8mneIEWLNTfNW6sr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 14:31:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Paulo Casaretto via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Taylor Blau <me@ttaylorr.com>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  Torsten =?utf-8?Q?B=C3=B6gershausen?=
 <tboegi@web.de>,  Jeff King
 <peff@peff.net>,  "Paulo Casaretto (Shopify)"
 <paulo.casaretto@shopify.com>,  Eric Sunshine <sunshine@sunshineco.com>,
  Johannes Sixt <j6t@kdbg.org>,  Paulo Casaretto <pcasaretto@gmail.com>
Subject: Re: [PATCH v6] lockfile: add PID file for debugging stale locks
In-Reply-To: <aYYWfb1E6EHxEyQQ@pks.im> (Patrick Steinhardt's message of "Fri,
	6 Feb 2026 17:27:41 +0100")
References: <pull.2011.v5.git.1768933954845.gitgitgadget@gmail.com>
	<pull.2011.v6.git.1769109815197.gitgitgadget@gmail.com>
	<aYYWfb1E6EHxEyQQ@pks.im>
Date: Fri, 06 Feb 2026 11:31:18 -0800
Message-ID: <xmqqecmxekjd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Thu, Jan 22, 2026 at 07:23:35PM +0000, Paulo Casaretto via GitGitGadget wrote:
>> diff --git a/t/t0031-lockfile-pid.sh b/t/t0031-lockfile-pid.sh
>> new file mode 100755
>> index 0000000000..8ef87addf5
>> --- /dev/null
>> +++ b/t/t0031-lockfile-pid.sh
>> @@ -0,0 +1,105 @@
>> +#!/bin/sh
>> +
>> +test_description='lock file PID info tests
>> +
>> +Tests for PID info file alongside lock files.
>> +The feature is opt-in via core.lockfilePid config setting (boolean).
>> +'
>> +
>> +. ./test-lib.sh
>> +
>> +test_expect_success 'stale lock detected when PID is not running' '
>> +	git init repo &&
>> +	(
>> +		cd repo &&
>> +		touch .git/index.lock &&
>> +		printf "pid 99999" >.git/index~pid.lock &&
>> +		test_must_fail git -c core.lockfilePid=true add . 2>err &&
>> +		test_grep "process 99999, which is no longer running" err &&
>> +		test_grep "appears to be stale" err
>> +	)
>> +'
>> +
>> +test_expect_success 'PID info not shown by default' '
>> +	git init repo2 &&
>
> Nit, not really worth addressing on its own: you could avoid the
> numbering if you used `test_when_finished rm -rf repo`.
>
> Other than that I don't have any complaints from the ref side anymore,
> and the code seems sensible to me. Thanks!

Thanks, both.
