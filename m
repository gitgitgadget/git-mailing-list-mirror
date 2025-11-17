Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5274531618B
	for <git@vger.kernel.org>; Mon, 17 Nov 2025 06:56:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763362573; cv=none; b=sMrXB8J372A+BxYEvaI+TXMPMoWqCirx3CebtKlWqPGX4c5Uh1z7Pg+yb7zBUBa5QGj/+CpUm0SfoGDUm2vwy2fydZoxmG6sIUqgi+q4BPdOrzA4sAJBkZND9kUSdAEuI9ajVrJqDwoyN5lsWdGgcd6BF+cjhhJUsZKNpRcOh0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763362573; c=relaxed/simple;
	bh=PSPOUtJI6mh29gYPfJlrQYJHvIEECpQBDCbE1kucnO8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=fAa2PXcu38NvrWxnxWb6FHw4C8gvhZUbywQsj0fZYRbHlFd8+lmcHr/TN0K9G9yEzfDw4rd1UbkrS3HNOMD34adHQOC1FORx2m+xFZ/Up5+56f7f2mzR7RLLFpd/MUKEjpbIrs8tYS8i0AiMAZGfchurzcTdBi1dgfrjUW3rBM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YszEt66W; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vZ0bFjWl; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YszEt66W";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vZ0bFjWl"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.phl.internal (Postfix) with ESMTP id 5C476EC01D5;
	Mon, 17 Nov 2025 01:56:09 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-07.internal (MEProxy); Mon, 17 Nov 2025 01:56:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763362569; x=1763448969; bh=te3KQGSaJQ
	//cClum7cylEot/CTyeYYWRkj9ZSDxtRo=; b=YszEt66W1LINejZjX9NZL/WRCW
	FAe4RHkb1POI2Gn2OiRlzGNtAG3bbj+vSoJkW8i0pUQZlQ7ktU9lYZdiYbDq0tjG
	t+uS19oFj1z521MMg5TqE6fCODNl9C79ZlRg/Qu358t2TSrOmNEQsZS+shw3YC2u
	Lg1ojyj7OOnM30Sn2Q+fnwDSG+KXD/VdiwxCwNxrQ2WUUJJC1PYK1ZFujc2Ho4Uc
	Be/0VMQt0IkgS7e/sqT4dVRdkwNNXGGuCjPMJCcid0pp7qxBbO2UZECXDSflma/i
	VDyE0n6GauIEkfU27h6cJymtDmVZyapHw6eech5cBxZqczt8bJqU5aaaT1+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763362569; x=1763448969; bh=te3KQGSaJQ//cClum7cylEot/CTyeYYWRkj
	9ZSDxtRo=; b=vZ0bFjWl+MD3mQuecxItufnsA7RnjGL5Fn16CM3ymp1e6SiLWIa
	exLvuiuNTs3OkCZbQAiPoyPS+KqM8nQuoBFegi94z2upl8JO4Wgl6z4MnuTxB+kX
	4ebv5p3ALx53plo4xCvAiLFa2/IuUwYp3tW+NV0MVI9YAV6jj9jtBgx4dgJQtTyA
	HVBRcgdYdc4mFB/h3QLJK7xPEBJ7IiiLzFs+ZgdDRmstEc/XJUQks2JVtknCsyyn
	IFzA8/n8aS4flVbaj5bnTgYFUQCcDiycgSCmixN5mWWh4P+I7KV+j4y5wV3lWgP2
	+mgxRZYAG+dsZNNek8/ZRUs7h9gm8LTrACQ==
X-ME-Sender: <xms:CMcaaYosClBWnE1HqMK0SBvtFR4MsMJJHyiDYRKqQ05tD8jzUA4coA>
    <xme:CMcaaVjZvQ6K1kJEuQ2qUAMjBQF7q8uwe6nxF7UED-9Afc6gmfjH8Gs1-XS74LWzH
    WZTqd1NGVhjMXimcA3qvNjZlyE5yanwrumIA4z-f2woualPdgu26Q>
X-ME-Received: <xmr:CMcaaVgtTSieSHO-qO5G1zrVxtNnZlY44k3sV7pdaTCrIFDqIWfcLIzm6u_pJHblQq8KZWfkq8nvl88WthGTGvtVw6O9GW2Ifq0f>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvudejjeelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrg
    hnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:CMcaabiIWiLjJQnL-CVQibZIGawGWHgNL07idh7r_K9iMKikXfTNtA>
    <xmx:CccaaVJDF8bQKtMT029sUImWQ6x-yjvdXnt3E22VrlKvUezZRYNFtw>
    <xmx:CccaaaGv9219I0dEAdUpn5eNAxfsa1x1cTOvpYmWQwkqZJ9pyB00bw>
    <xmx:CccaaZS15TaZQua2MLJMeZHIdu2i3YG8LLD5AEU4DHeM-1nFK6L4Wg>
    <xmx:CccaaS3dpEZeAvER2l3L7lewrth6qLL0hWbHn2gPrMJmCrnnZxbc6DL0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 17 Nov 2025 01:56:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 00/14] SHA-1/SHA-256 interoperability, part 2
In-Reply-To: <xmqq7bvsjzlx.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	14 Nov 2025 09:25:14 -0800")
References: <20251027004404.2152927-1-sandals@crustytoothpaste.net>
	<xmqq7bvsjzlx.fsf@gitster.g>
Date: Sun, 16 Nov 2025 22:56:07 -0800
Message-ID: <xmqqpl9h9mgo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> The new Rust files have adopted an approach that is slightly different
>> from some of our other files and placed a license notice at the top.
>> This is required because of DCO part (a): "I have the right to submit it
>> under the open source license indicated in the file".  It also avoids
>> ambiguity if the file is copied into a separate location (such as an LLM
>> training corpus).
>
> You may be aware of them already, but just in case, I was looking at
> CI breakages ...

In addition to "cargo clippy" I reported earlier (and attempted to
fix) in a separate message, we have been seeing constant failure of
"win+Meson build" job at GitHub Actions CI.

  https://github.com/git/git/actions/runs/19414557042/job/55540901761#step:6:848

I attempted to build tonight's 'seen' without this topic and it
seemed to stop.

  https://github.com/git/git/actions/runs/19418361570/job/55551045554

This topic may need a bit of help from those who are clueful with
Rust and Windows.

Thanks.
