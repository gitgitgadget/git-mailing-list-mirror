Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E55528640B
	for <git@vger.kernel.org>; Thu, 21 Aug 2025 15:47:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755791247; cv=none; b=cpI1UqSVcNkqbZLpKxfDOPjH6002kQtJhd9orrIHsFo6xuvhlXs7KGbKTa37S+8/HmMqa32AUVTPrlZzkS1J5iSCTZyZrAXW0DrbLmH3giR5cmOovTIuFPH2R78yEVR1N8ufHlno5slDb8ZYlD/MzaL5Zc9XJeP+EZ6m0hQdyto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755791247; c=relaxed/simple;
	bh=sXjTTp47ylFTPgNulR1V+uBIEvOzHohac1a7g5EWciE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZLl5sfH2AP2PeUypte3uCbYivzxnMz5w9qbKGfnMb81DyWrj2Pv8ZAeAcbvAN3UhrQ5GioFqtoyXrxV2CHjJQJp9G1nNGTvOHSWlB9rNdlfz8rz6h6lBQ0OmheiR6hifBy6B5NTOQaebLMouPjvjtVzJRQ//hMujwwn9sZSQj/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mGWfVBdu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ALjJUrW6; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mGWfVBdu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ALjJUrW6"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 11BED1D00195;
	Thu, 21 Aug 2025 11:47:24 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Thu, 21 Aug 2025 11:47:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1755791243; x=1755877643; bh=sXjTTp47yl
	FTPgNulR1V+uBIEvOzHohac1a7g5EWciE=; b=mGWfVBduGQ+uaAx1XeYRU2Q7KI
	YmyW+kWl6LEblgtaubf5FoAP1vzxErbUKVZCB5THhOL0zminuJlrDEIllbxm/Xxn
	WbrE+Ky0LSJrHCoGCwgBr2/WWZqsCzitfjcF9za3pID9yhJpoRI0Uk3lWV5KU+kx
	dmmEV6fHRsEwT7zbbMuKipbLe643vrTzT1xWUi0fsR+84sq/jwgdP1bBBi5wJQ6D
	hxpKGwoZ0uMV47/+OQJ7NJMvVDLE0tDU2kURDx49Q9fKV8GaQZvoSyO9avz8GLjw
	+25LRkuW+pxRcifyBwgukSS6C75t6rVWM3f5Og6jpWNhMh9i+q+hlYsrd3XQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1755791243; x=1755877643; bh=sXjTTp47ylFTPgNulR1V+uBIEvOzHohac1a
	7g5EWciE=; b=ALjJUrW6ZfM1md159RTADkfR6QEDBLilGqm0fHua5mZ5S/GJDV9
	wT3rVxexulPhjiUbdfSnUB69NO3tprBUeVHSgQnzd+xiDsFMKg0TUtWq+6pT9Usf
	AtK5HZyovPopdHZbVuST+Uu/4Jl5rtdEHRcGdzQX+k1Qxllaw4iQfilnsYCN1Zm6
	8oKCXzZ0IxXzyiQQQY4QofQ4fnMUwz3Cy/ozy8+iAuTe1UVIh9e9op6kWFlBZMx5
	lEuyNCZeir11S98TZr3ENrpRIwAIE5pQenAV3DtSb/NjP8duybN09zadXpNnb1Pg
	b4RRFgw1cGyNGc8zqKIo21ovfCLEOVtS8OA==
X-ME-Sender: <xms:iz-naLsOBCRFRQZN1vPuSUObGl8IjQWmc2nB02xQOXEfvUK-6JVAKA>
    <xme:iz-naE6iHQLpVukux1Tt8vJb1vjmwqy6tvZALte-h8pzd8R6gx4cEjdEtQmI6rx8E
    TozAXtZY7Bh_009ZA>
X-ME-Received: <xmr:iz-naPOeRa414fvFGpQlcvx0WaUGyHaZUo9NkamtHQleH7lKmvNLJOw9weAt2rS9sWIoHumEKQ0k3n4RhBdvRwrLqX-YaIPpBeG5NXA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdduieduieefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhope
    hpshesphhkshdrihhmpdhrtghpthhtohepjhhovgdrughrvgifsehinhguvgigvgigtghh
    rghnghgvrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:iz-naKvO7Giz06PsegB3rZifBb7WgUgCbZw5mBwOSS-4XpxaRIGfnQ>
    <xmx:iz-naKa_Vc0DQkXfBzHcSGNWsdx3gl_woqVQaUO6Xz3XdGjPJZfyDw>
    <xmx:iz-naEw0wianXpliAcNP7doyUNcblRFccZWYmkGTk0Nr3yfcEiweVQ>
    <xmx:iz-naKiQihiRySZw1KS_nfdxW_oKxMKqrXHFLmJDIYyJAJO0ZnugZg>
    <xmx:iz-naIKXp9JUHM1e7TF-F0GgRq3gIGXPcVLOFza2WA_Q9kdP4m4l7aHG>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 21 Aug 2025 11:47:23 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: Patrick Steinhardt <ps@pks.im>,  Joe Drew <joe.drew@indexexchange.com>,
  "git@vger.kernel.org" <git@vger.kernel.org>,  Karthik Nayak
 <karthik.188@gmail.com>
Subject: Re: "lock file exists" when fetching in bare clone of repository
In-Reply-To: <20250821072706.GA2390046@coredump.intra.peff.net> (Jeff King's
	message of "Thu, 21 Aug 2025 03:27:06 -0400")
References: <YQXPR01MB3046197EF39296549EE6DD669A33A@YQXPR01MB3046.CANPRD01.PROD.OUTLOOK.COM>
	<20250820213323.GA1667633@coredump.intra.peff.net>
	<aKbHozlmDIqfgkg4@pks.im>
	<20250821072706.GA2390046@coredump.intra.peff.net>
Date: Thu, 21 Aug 2025 08:47:22 -0700
Message-ID: <xmqqcy8o4qyd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

>> But with batched transactions that's not possible anymore, as we would
>> indeed try to lock the same ref twice. Assuming that this really is the
>> case, I wonder whether we should detect this case, tell the user that
>> it's impossible to store all refs on their system, and then continue
>> regardless while ejecting that specific ref from the transaction.
>
> Maybe it is too optimistic to think that they will just start using
> reftable in Git 3.0, and we can avoid extra code to detect this?

Or we can just tell them to use reftable way before Git 3.0; it is
not like we feel that the reftable is way too unstable that we won't
tag Git 3.0 until it gets ready---it is ready now.
