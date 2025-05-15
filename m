Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 335121361
	for <git@vger.kernel.org>; Thu, 15 May 2025 18:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747332591; cv=none; b=B8yzVojx7c/McjThSKpCfuXPdhyh0dW7kHaodbnSH3g4TfSKgKNKgb8zNLGsVb+Zmxhjuv8mMOm9Mk/Lpl+gHkRe35s/kaQ7wAKEIble5EtR3/rJQloKdD5i9rx7FQYbTcKpWstLXdG7Cp2GS5VaBgEEcinZT6uxXsA1/VPGPgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747332591; c=relaxed/simple;
	bh=YoHft+tMPLWfkv4kTXP/p7VI7EcQOBd5kp6YEQygS54=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=d0TiPR+L68QAurQZFzCiky7SmKnjcLJ8iDI/9TKMaaI8UCkQvbTqH2cKe/N7RQ51UeM9R4K4OmWpXcuwEHQ0UPNLJ4K8pZC7iE9I2QVGVARFzEqBkDh2ufIfz0k+GS9ALNuTUZhW4gAm8r6WVAUF/tGBOf/2Cb9TYoSPy4qnrG0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=M0gL/axo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=qdl3eGTh; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="M0gL/axo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="qdl3eGTh"
Received: from phl-compute-07.internal (phl-compute-07.phl.internal [10.202.2.47])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 436A71140108;
	Thu, 15 May 2025 14:09:48 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Thu, 15 May 2025 14:09:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747332588; x=1747418988; bh=YoHft+tMPL
	Wfkv4kTXP/p7VI7EcQOBd5kp6YEQygS54=; b=M0gL/axoNJo0w5BxNXMK2XUo9K
	6pKTJq7mY6tjTXQuglJaZYaK1Awe6chKjGFs0hmxmYf+dLAmLtyysyJMiqwOV0Qk
	Hy6tQfrYn1vq5vR8gRYZDUJJg696176Tu5URwoR80wQf/o8vchY91mu7oO5AEg63
	gOA+VplfLEPx7GncNfM80fboSR41cy2b5P6ruUkQe9X3hao3MW/Yo/LsBDTvkxE+
	CU1LcD6VAvGoEKqye3Gyq2aqwYXJ/HhQ+r3RU4NUgSDSbhU+e2CbepaXS0m9aCKi
	Pi99rfmApC7ws8pwahuMKknECueLt3Dh+Obo0EjkLRJF1i3pk00k2fI3h5Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747332588; x=1747418988; bh=YoHft+tMPLWfkv4kTXP/p7VI7EcQOBd5kp6
	YEQygS54=; b=qdl3eGThmF/HhrZs8G+0JUHZpqrkuDEcbyhniXgbAm3UY9ZJ0mL
	DT4s7WvdUR5EYCAS+9VK4QeFHH8U2GWWKclltOn4RhXbieD3aj7rAoQmKgPnPzRw
	on2h0oyKSBkIBcLlYK59ADFSlGo7Kh7N16mmdfvwq2rueGqv8iba5i2VtJiLxFXF
	sXYkaMInX+7hSK4E06wtJ5XB0eOCIgLbiOeR9J9z840xC02rBl6xa6OeZEYhEATQ
	Amd7jQ45dijE0JK2+FsZlrWCONO3xKjse6vJin2+wPE6mmj9tR2H5l8FXL5vpnBd
	Ku8q7Lo/W/4A9AS8IUALZkPoJP5sML8j4Sw==
X-ME-Sender: <xms:7C0maKwv6ftSkdSYKjK01lc_0elaDf5xa3vaE-bWS-GLwKo1kUklcA>
    <xme:7C0maGTwoyU5xXd4zzKGFmbNL-SVTpBYcA4Z6pHOoSNQm41BSmWYtm721PAhI1o8q
    nInzNqQFlo83u-CEA>
X-ME-Received: <xmr:7C0maMWKV5x5AxQyicEiVUB_sOFGbp07BoLvvhzspT7vP_BMi6t5ClFxrKw5h6Fr77BLhJlSmPAhPefH1FSDfxZjkuDu_Hivt0M_uGg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefuddtheehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjhgrtghosgdrkh
    gvlhhlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepjhgrtghosgdrvgdrkhgvlhhl
    vghrsehinhhtvghlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:7C0maAiAckCIPiRgoyusWkqkMF5Q7hokA-zVzlvgHc5SwuAhHWx8pQ>
    <xmx:7C0maMB3a4PFPxrgOakxcOtQl6BRtQgbjXwCc6AdHG5mql4zYEqFLw>
    <xmx:7C0maBIZP-iNmlsFdoAhklfaQ7H0jeeGHiZQyrBrp0FqcbED0Di3eQ>
    <xmx:7C0maDBqmb5iYUjf7wZbKjSDq64pIVjbeVir_RYqMMl5hq6VG9ycKA>
    <xmx:7C0maK6wy1A_EoGxVwAZpTuvk4KbGbhSz_RrPRIo9CvR_eTPCyjKpHyw>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 May 2025 14:09:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
Cc: Jacob Keller <jacob.e.keller@intel.com>,  git@vger.kernel.org
Subject: Re: [PATCH RFC] diff --no-index: teach option to exclude files by
 pattern
In-Reply-To: <CA+P7+xqg3S0q=n3nrTUJJuYicooDm83Q32AkpzRt1u7rH3n3Pw@mail.gmail.com>
	(Jacob Keller's message of "Thu, 15 May 2025 09:27:45 -0700")
References: <20250514204014.3106177-1-jacob.e.keller@intel.com>
	<xmqqzffe7vbh.fsf@gitster.g>
	<CA+P7+xqg3S0q=n3nrTUJJuYicooDm83Q32AkpzRt1u7rH3n3Pw@mail.gmail.com>
Date: Thu, 15 May 2025 11:09:46 -0700
Message-ID: <xmqqtt5lzqxh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.keller@gmail.com> writes:

> I guess the one weirdness is that pathspecs must come after the first
> 2 arguments, since we need to find 2 paths first. But this matches the
> way that treeish must come first in git diff-tree -r takes treeish and
> then pathspecs, and you can't re-order them arbitrarily either.
>
> Does this sound like a reasonable extension to the existing 2 argument
> form of git diff --no-index?

Absolutely.

Or you could even use "--" convention in the examples you would
write in the documentation, even though you may not absolutely need
it for the purpose of parsing the command line, to highlight the
fact that two things to be compared is given and then with an
optional pathspec after the two things, e.g.,

 $ git diff --no-index git-1.6.0 git-2.43.0 -- Documentation/

or something silly like that.

