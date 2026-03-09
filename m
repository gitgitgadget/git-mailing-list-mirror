Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A52A5349AF5
	for <git@vger.kernel.org>; Mon,  9 Mar 2026 21:14:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773090853; cv=none; b=RGbDv5Ghicg6FM2DP9BDIee64RaOrLPWDynuLrMFX5HTnvUjGNbDHYHf81QfisI5+2t6KapAcffrQbJ3wYAP1ODe72kapYvsoyMRvYQyfTeDgXiQ2s9hciUiHlU5juldavP99jVN5lQc38hSf2yEDqYgD4DjWh69tEho6OCywj0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773090853; c=relaxed/simple;
	bh=jZ9EWQdE1uhdmL+8WYlpIe4GsxBp1qiqQk9BLO+c9fQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k604vqThY7ROhHf8s2Km1tY3PWUQ+W1vQuIQEk+Q0QwZp1U4IX0O+CuWCOxUZhJ4/+RN8gTLopS0jUDkt+uh983Acf9TlEKDlFazZ/cITZXBCbyyxbP+40cIh/Fh78gO1BTdZUtJbXR84PFSbYkIpOu/4+rD1g3jKFz+CHZMSxo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=egPdXJO4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vLmD2y1H; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="egPdXJO4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vLmD2y1H"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id E18B1EC0166;
	Mon,  9 Mar 2026 17:14:11 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Mon, 09 Mar 2026 17:14:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773090851; x=1773177251; bh=ACuq8UH95Y
	Mw+8Ib0DmOjFLfXvMyBerDYtnCz5z1dGY=; b=egPdXJO4RZlBaqGyVc3sIbEQfy
	hbPNvjzNCzepNFeU/xdFQ2g7uT229uTAmig04Rh8ELkkpfKZjAF20NDfujxjViCL
	AlL3fmiyNSa5RGA711AlYNzMcn3i898euWbhLHIMVBo0eW/Bgr2d7+0gT1KQSv7A
	zB6Qfuw2gJ1R8IH9BN+lEZiu2iZEAgmBdlh7D8r6JnDdvzz824EmIiyeqfsyofbP
	raFQ12FW8ax7SEy2op6FrqJPgJwfbdn0o4DMu/fVXaGYtlSQs3WcpWGeX1tHpUmg
	mhCU463FfgugPsVgTAiSconRsbbIM+ZEMXlsxIMC62Js9Xx1UzqnwqgXdF/w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773090851; x=1773177251; bh=ACuq8UH95YMw+8Ib0DmOjFLfXvMyBerDYtn
	Cz5z1dGY=; b=vLmD2y1HKDb2yFCHgnN1RAuxUU++XxFPH0uBOe2tYhe0cELatoa
	2iMRFatIrlRUYWb577fGbtVRr2yi6r0gwjEfvx/kocC841i3KWtyiWsrCu1j2KxC
	yMb+cx5hwQqECTzzzqlCZl0ygPw0YVKVMbpxKgFOxwcs0vSfmvXJmVZhcGJwEICs
	yO34DIn6uJUy9m79veI/oPf1Z7d3QlbOv+mJ9sIPqE7uN6Xfey6U0VW4jdX1PRME
	ZwB4ZZ/R9D0M7PGXKeQDUVJ4+KKrsm5JD1NbbxHhM4cMyEajkNC8y7/2prpzZHK1
	OGbAmAWflV9/RzgoglOsp4Og22AsWWGZ68Q==
X-ME-Sender: <xms:IzivaZ6mwd7Juf8UhrojcWH4zEWYB_Ul891IpBXKK9SvI3OunSHNtQ>
    <xme:IzivaeXcnyM6mGd9rGxVz-elEcXyNWH7PBQ4Gi231ctB_mTY70_P9vhi_s2rM_meO
    V29iztURh3y6ffnbGQ5ZludjQeJIYRFlgr51nktjcT0dEdW0MNT>
X-ME-Received: <xmr:Izivad3TIDmDJ336RQ1_3fDiJo0DFydjKBjmgYz1pTXJJFxMGlyrzTzC-P5ecGKHxFQ4xKzSvcS4nLtFLQRNsh5wzGTdsKoH5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvjeeludekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehprhgrshhh
    rghnthhjvggvvddtvdehsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvg
    hrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:Izivab1G2a_aNLqDhxWpBh3F4EC0Ek1K69D7BNL2-4YX7hB3ozHtxw>
    <xmx:IzivaQ9orptUqHx10xzo6UaitBDIf4OpLMBRO2GcqH4laDxdqbmTnQ>
    <xmx:IzivaY1JJfV8pGhABYBNdWV9vL2R7m1T8BGU3n1Z5T2EXJnmqdi5ug>
    <xmx:Izivad8IxGJp0X6V7QFIE71KrWxSyHWJ7Cm0PlPuy5kj8HJILSKjTQ>
    <xmx:IzivaWW3ZzNrfARWmvcQz24sn8ZzLadwilgebDSPOO4nd6_95a_iSis->
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 9 Mar 2026 17:14:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: PRASHANT S BISHT <prashantjee2025@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] t0004: replace test -e with test_path_exists
In-Reply-To: <20260309173635.29683-1-prashantjee2025@gmail.com> (PRASHANT
	S. BISHT's message of "Mon, 9 Mar 2026 23:06:35 +0530")
References: <20260309173635.29683-1-prashantjee2025@gmail.com>
Date: Mon, 09 Mar 2026 14:14:10 -0700
Message-ID: <xmqq4imo4sf1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

PRASHANT S BISHT <prashantjee2025@gmail.com> writes:

> -test_lazy_prereq WRITE_TREE_OUT 'test -e "$TRASH_DIRECTORY"/out.write-tree'
> +test_lazy_prereq WRITE_TREE_OUT 'test_path_exists "$TRASH_DIRECTORY/out.write-tree"'

I suspect this is utterly wrong.  As you wrote in the proposed log
message, test_path_exists is *NOT* about checking if the path
exists.  It rather is about *expecting* for the path to exist, and
fail *LOUDLY* if it does not.

You need to _think_ if we want a LOUD failure when somebody checks
if a path exists and conditionally skip setting a test prerequisite
when the path does not exist.  The original code is trying to be
quiet, as the check is done not because existence of the checked
path is good and lack of it is a test failure.  Lack of the path is
expected on places where the prerequisite is not set, and that by
itself is not a test failure that you want a LOUD report about.

