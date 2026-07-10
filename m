Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84287423A67
	for <git@vger.kernel.org>; Fri, 10 Jul 2026 22:28:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783722494; cv=none; b=AG4wxueAoVqBSZtGUqisWqsNYU3VzB3qeHSrqPHWcSW5EiNnaHB5oo3Tv+jq5sGwcnQr8xp2/AYw/BSqx0IsKb2AqyJPbO8jxsjEF10eB5oiRvAzNlrJf4gEiVkZ2+1c1hJD9K1s/dcEjHaUteFFBL1S/pghcU2rDsNE7WP9bZU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783722494; c=relaxed/simple;
	bh=H9yJS5XnOpOZ4sUyztGkdUbVl8ZuzoeT5NfLchxNn7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FC6ZnEz31DtuTPw6r89ciefFb2oIqnOGEzpNulGUrtRWZGdZ8hG4XuS0IxXgzXJmfTu82Hui+27c6CTZxIrfYKLznMraUJ1FO/8VNvTLAWYLF4gz0FyTUN2pE8zwAFpUh2hchB910sgJSe2e/bwvddj7bajyxpsfBcAmL6KuQPM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O3cj4izf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m1TW8LQC; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O3cj4izf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m1TW8LQC"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id BEE2E140006C;
	Fri, 10 Jul 2026 18:28:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 10 Jul 2026 18:28:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783722492; x=1783808892; bh=Cta0rxU3bI
	weGUBMzhLiMsT6TCnsJ7Wz9P6BM5k6o0s=; b=O3cj4izfds+amOfb2tsQRi3v6d
	L2sntPS6gdUDuPPiD9mpaJOB1rE5QaApXkL7moFbgDZLhD36E5IEebRP6aT20gq6
	FqISEAwRjDMG8UsILr8C6UGVR21KNbBqyh9dSepxrcklv/S0GYTeVK6QVKtazTQ1
	k9e1bOWBoNFRppI7ZJh8GKMwcG/CqwEbOePDm4ifa0U50/DirgYtoNhzKeMaDXiF
	BcIP4FdkfZ++Z/dm155pYPU2TVNBdrXk/Q2DA6DEDAomv3ByLbgOJu3Yp3BoziPK
	nZ1TdfeVoenbXb4XqvG6PU8q6+Q9UqwlVL+IJTa9SbQ/6J66INe2aTqqbFrQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783722492; x=1783808892; bh=Cta0rxU3bIweGUBMzhLiMsT6TCnsJ7Wz9P6
	BM5k6o0s=; b=m1TW8LQCx5FML7OvRcjvEwl4+f+ifApfnGcTQec+YuqQNo7ElTw
	jn1JuNc/mAbcxAxgbUNePl04PW0wmc08FM/op2BcEQXAxyli2dGzzTnOlv/Tzs8y
	MwdxsXXcS2KRYf5aH55iT5S4OPdTB6FZxdPwr0nb2ftVkss3PtR4RhxrkM5WQ53k
	TbYZXgi7N0DXhlwgN7K2Q+PJeW9cmv6eB1fc/b9+P8sGSnBgUV7aSlnJMe+uyi3I
	vowCUWylI7FgImS+uBkDlHihp7OKF/7xQXVdkg82S3fS1TyOMwUEPtnSuNCzkq4p
	FibwzjZ+vpJfRAkOt3Q0IDck9hLEDX4rlBw==
X-ME-Sender: <xms:_HFRajQhsgydMtI841TQv5xoeRpmaX0JL2Q92thp6f9_yg8kIxcJSQ>
    <xme:_HFRaoccDh0fMRyi5qjUnIKJBtay_SDAbKflua0iuFmN6BSE2jXxyMp-tVI19SLX3
    S0MvQuCGBDYF3eEZcbOSbNAAo9var2RpCueuKk0b03xJDHSXxDZnnY>
X-ME-Received: <xmr:_HFRairK2rO7U6Jp18Fk7unRJAn9v1dhOwZlM2AkLQZCBNM_eS8YB7wAkPek3C6S_e1AFVkSdcTsG9ECmw03Uumyd4WCDHysMYlehhY>
X-ME-Proxy-Cause: dmFkZTGZr6CvpcRnmsSXUNxDfZDwfCPmTVtYncoR7M2gr/toQQgdJbDgBNY+m0cf3AyEF5
    r8Gw65rRBLrpusOhpPWw54hZncp+yxsrknvw4HoQVeQNSbQSYEdPJMPa7uLHrOrS1I0740
    smuyQACAeRzrCWBD9BF0tBAkbJGBtd3H19VKdLdyDQzEXIa4ps09w+oXATgF+rz77CPuti
    PLfPBsv/DXOQyFjkqYNR5wiarc2xx9DMmSvoyc/TekPlqrN8tdf+07KowwDssTarURVDig
    3Sx9WursIliLZNIJZbQp3S4mu7ue3fMVOsgUyQPMSbaCU3JKT3fdGSVwDezfeKomFR7Ndj
    xu8GhjijlNDSBkqdWAY8YlZhIREk1gKtZ1UeTAVR/o4Duqf8FTUWipeRR7k8yNhA8bNQac
    2pjiCEVY4xubtOneuUSnnqzIcUZUYK7OcxyO3Gq2hC2M/rwQy+5BC4wYlk7wVW6juN99i6
    4tHfubv8eB3EIXM56HQ+sDV/k56RJWFMMl8pKqQFIYwXeNhXaJ+xKeha0lzfl0rKMl57zX
    KwjY1Swtvu2URV23kQiZFjCzYBqaIHpzOuU5eXU5ULydppw6kjUltjZ8fOiI81MzEJNDyu
    2fb5837EwOX/aMvdx0ijabY4tnsWn50q/IuCXb1X+nY9SdAdajp8trzVfYQw
X-ME-Proxy: <xmx:_HFRap8_b9TMkqGEjQKLXJyN5OKWczJqLAM3zAur2-DBAsFUuFIIPw>
    <xmx:_HFRaue_kFWciO9ZCWHCt-iENYEvVd5lDclP7iYDD0JAPP3Hqw1sOQ>
    <xmx:_HFRajJeL0WYv5I3Sabqtntasre39iP6UTnbAEh3No1O_5UsmkKj9g>
    <xmx:_HFRauh97EOEPEUxyFoMy89hI_QpTUwTD8mBAFKy16kIyLMWtGBRgA>
    <xmx:_HFRaon6PAHXP_dsCE_naQrkFQnUBldAAQLr4_5R4evi7x79XclhIO6P>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jul 2026 18:28:12 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <ttaylorr@openai.com>
Cc: Kristofer Karlsson <krka@spotify.com>,  Taylor Blau <me@ttaylorr.com>,
  Kristofer Karlsson via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org
Subject: Re: [PATCH 1/2] commit-graph: add trace2 instrumentation for
 generation DFS
In-Reply-To: <alFthqGQjsowvpEz@com-79390> (Taylor Blau's message of "Fri, 10
	Jul 2026 15:09:10 -0700")
References: <pull.2170.git.1783418384.gitgitgadget@gmail.com>
	<b865c2bcff53a32637aac426dd2c6ef4a4c27077.1783418384.git.gitgitgadget@gmail.com>
	<ak0DUx5Y/5y1OINz@nand.local>
	<CAL71e4PuD9D8LRbP3mfxxeMrM+1q--3sCp6oJs=hezdasZUPMw@mail.gmail.com>
	<alFthqGQjsowvpEz@com-79390>
Date: Fri, 10 Jul 2026 15:28:11 -0700
Message-ID: <xmqqik6mbhtw.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <ttaylorr@openai.com> writes:

> On Tue, Jul 07, 2026 at 04:08:36PM +0200, Kristofer Karlsson wrote:
>> > Instead of writing "# BUG ..." and then an incorrect assertion, I
>> > would suggest that you write the assertion you expect:
>> >
>> >     test_trace2_data commit-graph generation-dfs-steps 1 <trace.txt
>> >
>> > , but mark the test as "test_expect_failure".
>>
>> I started with this actually and then changed my mind in order
>> to demonstrate exactly how the counter changed, not just that it
>> changed from failure to success. But I'd be happy to change this
>> too if needed - it would effectively reduce the second commit to
>> just the bugfix line and switching from test_expect_failure
>> to test_expect_success.
>
> Yeah, I think this would be ideal.

If the test involved is longer than 3 lines, I would recommend
against it, as "git show" of such a patch will show the full code
change to implement a different behaviour plus "_failure" changing
to "_success" in the test, with the body of the test hidden outside
the context, which makes it hard to guess what the behaviour change
is really about.

