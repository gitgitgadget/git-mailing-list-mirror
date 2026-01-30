Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91A5619A288
	for <git@vger.kernel.org>; Fri, 30 Jan 2026 21:45:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769809559; cv=none; b=h9PniDjo0zJFDKQUXQGmF2dJDpks8pyQnogbeGa2knCYkL6YP1pyIdUvSvtsOglblIjH2MPlfWGu7JkEtgWeQyvEh0SK4vEZyh65oJfzW2erDnBJaMDsFtoN/X0Ql4NGi8r3spLxIYTCxXvyy/WnuNvD9AL/0j2eP87lRsFA9dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769809559; c=relaxed/simple;
	bh=7oVrasRQ/z6XRV/BEuRzdQXhQ58nANvm+qGQTVWsU0Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fTTpvDxHQBoNhe28ICQlHo7Qoy9R9/9I5qz1PFJbBKfFMP2pJZT7xWgixEGXdzwQvRAZpUPALaAhTm6PUc4KOR0+Puk9G4VmDLMXdun2VXeCQ28XW8a6mwcNx3C7h+RMrZKazmkU6GtU7Y2pj7Gi9KSFTVt0KihQHJgSxVxd+eA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=JXB0/+oX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C3Wy1U8J; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="JXB0/+oX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C3Wy1U8J"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9ACAD7A00F4;
	Fri, 30 Jan 2026 16:45:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 30 Jan 2026 16:45:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1769809556; x=1769895956; bh=7oVrasRQ/z
	6XRV/BEuRzdQXhQ58nANvm+qGQTVWsU0Y=; b=JXB0/+oXo6Hue6xQXi9ZRhp0ha
	Ru9fdutkWjXfygDQh8q4kVy/VrymFFUi8Rt/eWBXWBFII0LpJH3p7zlIOoAmULm/
	GSgdR27OeoZ+ZNd/XO0uaAEsrHP5RUEKh5rh0Su/oUDp7TGUJspqu28luasDLQMV
	NjDSAEbLBa3GAMi3YoYzgHj7rhuI0j1HJKF0WZAyHulYwn/XobUombNV9MBJoG8X
	3V0M5rHi5lMI+eaNMt48BidyTxFKbZmw1No7Rfthst7y4xxyxgxWmo3IOIkaoQBH
	uB6ETO3TX6goOqiV9zSZ90pPIkfsNZdIUZs2kwAnO4qv20hfISaBkRfiNVQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1769809556; x=1769895956; bh=7oVrasRQ/z6XRV/BEuRzdQXhQ58nANvm+qG
	QTVWsU0Y=; b=C3Wy1U8Jj3aNt0u44JYTxKbXW7OfRg8FnRltj3vsQdMGNqQLKz5
	4eoQxJLl+c4fyIuOsL9j6/IhSLWPh3TLirLC6Wtijxr+AWa4OlmrwVMMMC51nqFy
	ZdFegRfponvYaFwwxcWgDzryE9LwOjchDPICzTtCFEggkh6IrjJ7uumQMFdKWyd7
	1ckcFIhoLLw7U8+CLu4m/DVLt2yFRlDBgG9xAgslQ+DOzG5BjeaOOwZok1HJjMDd
	IvXqYZrSsEBVFCFl091FJdy2C1TVYmjREVdpvS+nTR9t87a/78OLjNpkVOItVDT3
	KUZ9bV2pk5vqZyv+aA/w/KJigx21GRs6N+Q==
X-ME-Sender: <xms:lCZ9aYK1iUiZOtLF0sUjg0zyV25K4mvAEO72ovJo1lD4t2X11avHZA>
    <xme:lCZ9aaYYW6r913O0hYysD301pCk_OD575eVkymwHfaBZNGfdlVXY4jvFcVZjto6jr
    P4DjobofVcGZ3r-P1gScpVvviDCsQCoBW-jQszE5RAtF_3RyZLBSw>
X-ME-Received: <xmr:lCZ9aa9-OvmiTPbRV58o_UYsx2uoEzcm3_McLvdAQX-fGkqZ__kDhX-vxrLUNnRf5v-QNgl3GOCgSNXtZO2GzA3LlnF-SZXqNF4nh5U>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujedtudehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtoheprghmihhshhhhhhgrrggrrgesghhmrghi
    lhdrtghomhdprhgtphhtthhopehsthholhgvvgesghhmrghilhdrtghomhdprhgtphhtth
    hopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpvghffhesphgvfhhf
    rdhnvghtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lCZ9abaYvMUJ5MCXKUVLhrpKl5pYt0XDVWT04GLyI3urezSWKsyQdg>
    <xmx:lCZ9aeNd_YWNBIP2v9btT5CRcNqUNA9n4UqaMgoNrERK7z1BM1VF3Q>
    <xmx:lCZ9aXBLzGiHFMui8pU2Qmg7yO_WMs14aoAYlMkb01rsSA--VQm5Zw>
    <xmx:lCZ9aVIa3Ukq9m9s-9wLqe-YKdExQpeqzCA6qs4ICGdPVFL2mThzkA>
    <xmx:lCZ9aed3xWIy_tPgnWNS49jW4wobbYG2yQ9W7fQfQ-vQ9I7B42x_k1rz>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 30 Jan 2026 16:45:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Amisha Chhajed" <amishhhaaaa@gmail.com>,  "Derrick Stolee"
 <stolee@gmail.com>,  "Elijah Newren" <newren@gmail.com>,  "Jeff King"
 <peff@peff.net>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] string-list: add string_list_sort_u() that mimics
 "sort -u"
In-Reply-To: <e01f307c-3d7e-41b2-b62a-f61b1dd17640@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Fri, 30 Jan 2026 20:51:21 +0100")
References: <20260122171523.94234-1-amishhhaaaa@gmail.com>
	<20260125201500.63904-1-amishhhaaaa@gmail.com>
	<20260125201500.63904-2-amishhhaaaa@gmail.com>
	<e01f307c-3d7e-41b2-b62a-f61b1dd17640@app.fastmail.com>
Date: Fri, 30 Jan 2026 13:45:54 -0800
Message-ID: <xmqq1pj67p0t.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

> On Sun, Jan 25, 2026, at 21:15, Amisha Chhajed wrote:
>> Many callsites of string_list_remove_duplicates() call it
>> immdediately after calling string_list_sort(), understandably
>
> nit: s/immdediately/immediately

Thanks for good eyes, but I've merged this version already to
'next' X-<.
