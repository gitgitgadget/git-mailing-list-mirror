Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F1984A53
	for <git@vger.kernel.org>; Mon, 13 May 2024 21:00:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1715634046; cv=none; b=d9qvgFi72Xg43BBe7PGVEfRrE20/nLxjKJj/O4LlYrVFG6pFHRbklSApzGi9xINPaubxbddZWrfeHPd/cdQa8mHg8r4gPG7yPxiY82/LXslg4cbg8J17tAUKuC9yxneAs4A5+CRp/zYRqgR6bJ1Vs04v6ah6psv4CuxgaE3pUDc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1715634046; c=relaxed/simple;
	bh=DwrZhG1XI7mkJEp0QlC2ygBztV1fEnXKt1Rm5pZmcZo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=QWCJN+tfroim1PR9vQqIpn0XsPiWnEweRsiXmqYcgvv2uFDZl68tNggDS5Ag+RwX7vCtI3gkuTtnsgwxrHWG2SvQTMEJYXs6IJrlMpHBZvfQdA4dp3nOKBfgHXYDJvN6hAgPMUiPzH28r7jZTrpkQzL9Q9hLz+mmj3mpjyq0eDY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=WU3f0MVM; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="WU3f0MVM"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 96C3D37176;
	Mon, 13 May 2024 17:00:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=DwrZhG1XI7mkJEp0QlC2ygBztV1fEnXKt1Rm5p
	ZmcZo=; b=WU3f0MVM2lcTL6jXkGYdExkYtCepwCmwsw+WO2ATiv+T98zPWnCcmE
	BOlbVD57sBwvxORzGY5PHdPZbV03bYk8H1lBhfTFcT5Zlbl2H58/QahtC8S5pg4Y
	WQMUl9lHVtnT4vCbPamXWKKT3t37tOMxm7SnMUTIfuot0HkTzZlY4=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 7978037175;
	Mon, 13 May 2024 17:00:44 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.153.120])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id E700937173;
	Mon, 13 May 2024 17:00:40 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: Kyle Lippincott <spectral@google.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH v2 2/4] t1517: test commands that are designed to be run
 outside repository
In-Reply-To: <xmqqy18de9kq.fsf@gitster.g> (Junio C. Hamano's message of "Mon,
	13 May 2024 13:33:09 -0700")
References: <cover.1715582857.git.ps@pks.im>
	<20240513192112.866021-1-gitster@pobox.com>
	<20240513192112.866021-3-gitster@pobox.com>
	<CAO_smVg7mdQHp+sg4-vVUEOVRBEoZjqXZu=Kk8PuYc9mtYeMXg@mail.gmail.com>
	<xmqqy18de9kq.fsf@gitster.g>
Date: Mon, 13 May 2024 14:00:39 -0700
Message-ID: <xmqqseyle8aw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 DB440126-116B-11EF-BAA6-F515D2CDFF5E-77302942!pb-smtp20.pobox.com

Junio C Hamano <gitster@pobox.com> writes:

> Kyle Lippincott <spectral@google.com> writes:
>
>> Do we only expect failure because of a temporary condition (the bug
>> that is mentioned in the commit message)? If so, we should probably
>> add a TODO, FIXME, or some other similar style of comment that
>> describes that this should be fixed.
>
> test_expect_failure is description enough for that purpose.

We say this in t/README:

 - test_expect_failure [<prereq>] <message> <script>

   This is NOT the opposite of test_expect_success, but is used
   to mark a test that demonstrates a known breakage.  Unlike
   the usual test_expect_success tests, which say "ok" on
   success and "FAIL" on failure, this will say "FIXED" on
   success and "still broken" on failure.  Failures from these
   tests won't cause -i (immediate) to stop.

Which means that when somebody rans out of things to do, grepping
for test_expect_failure may give them a good place to start ;-).

Note that there were a few very rare occasions that what was marked
as "known breakage" with test_expect_failure turned out to be what
was working as intended.

Thanks.
