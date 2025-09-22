Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A11F192B66
	for <git@vger.kernel.org>; Mon, 22 Sep 2025 16:47:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758559628; cv=none; b=Ifxkd9f/K0QzyNuclM01xEoDgTYDV3OWXTROraaafF8NDwb1kRkcNTe8NfCf/A662uwUCok/YKNsyps7cUuUarAE95mup1nnGU7xMSKB99na9yvIzDXzyX6EZmDpaufZ5oqMg+U8MaZIgWnGs2IjD9yyt8UmpYpqJJZlvgi6FLU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758559628; c=relaxed/simple;
	bh=4XMrbfNRRLAReZ9FL4LIwM6LiXzlJcHoFq63Gln2DDU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k3XHrwKeKtJ6gvAZLfh0TF7UjjqtpHF3BOayNFMvcpkSiPfiKIOA6qSD/WRcP6Tk1WFK8f6CmKjYIwTCCVgY63poo6k+GTlYZ9FyXnGF02sM1YvVd/JkAoW6dR7Im1ohk6XYmQ2S/qckb0Vhghm8Q9rbGaFUo9o9KGb1I6bwkCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=r+Qv7oVl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JA6DoJbc; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="r+Qv7oVl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JA6DoJbc"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 814FEEC0311;
	Mon, 22 Sep 2025 12:47:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Mon, 22 Sep 2025 12:47:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758559625; x=1758646025; bh=IHVy3UyUwI
	aqxI8bs376nRZGc1NXsQof9HZTAvIdYqg=; b=r+Qv7oVl0agBfBbpPwbXTQFC7N
	G9uRfRC9abaYywEogqiFIZiCrIn0lkEkDUDZrt+rsQW7pPFm3T/FbcY1SWROwGNc
	IhibNw1ltilRr8PSQr4+nsCoRK7qxOoa+6akzHw4Zu+ZefSBkWXZb1Pr6lauTCR1
	xWOdiJLtJzoQfU8lmoHjz497IvI0LAvvoofjRI7vbjs6z5MJtsw5RRLuRJbGek4W
	iahpzOy7W6C5D6gQ8J6jsmmovDsI+3SBWbKHhPhNlLNhkmc+9UjciYrwD6Ep4WWR
	fxSyofvrbI9KCyrNszYvWT/W5NEL2rBcVonjlloEmZhIMDYHN3r1NdvFLADA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758559625; x=1758646025; bh=IHVy3UyUwIaqxI8bs376nRZGc1NXsQof9HZ
	TAvIdYqg=; b=JA6DoJbcU5GWqsB5Qkgy+z/JwuR8M7lRXwsxmB5TnBW7LDp9Pfj
	yFTu7fFHOpNKlD5YKZpCoFgfwCy8gUISCypFHg+aQx6pxXiprGTwENUksvuRFeGy
	cT97ozu6cwV7QhT0I3UnYC2P9E4MPGLu7D+9XCJIAEJK5xFgvDAxe5BuNM0jMdd1
	+cSkKmGl2nzeSAk5QlqtRqOHr64rQOq/WlkmhMwhoFsmPtfdC4tRnrNzaLHhhwXh
	VowBl+Y+FydwIVfwe7vZ3pC7qbtTFt3+HO9sikHaQm3vRUW+OaU9yZmS7YcKw6qF
	H1ipDD7NG5LBOKh4NjegZxbgBYHfXwryDfQ==
X-ME-Sender: <xms:iX3RaD7edFff8J1CqWZ4ObLrjkRRgWKv-e9DyvKdZ-F0nQ7fpbT3jA>
    <xme:iX3RaPw6w_x95iLTIiXG-WraxYpnxUWmQiJXGz6BKojQbslXQxfYRFCPJ9bC-MdCS
    VqwBmfGK0x-B1cHvYis2AoD80VmVJIfP_O0QQgp162ASbyG2OJYdQ>
X-ME-Received: <xmr:iX3RaCwYgZHJ3HHpe_fjleYMBXEa-GHRmJVi0vSDUlTlaqp1jGwu3o5mVwYBd2ZOKnpSE4Rli2ehPriVOo2D8p-NCt-vvQiadGrt>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdehkeefiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtghhithhgrggu
    ghgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:iX3RaPz83-US3tLksewZtq0WYnsa7aMlRT70tUl90bUeov7H-nJz2A>
    <xmx:iX3RaEbcDhOKXCRRIOigEkKaVpU7cNM0gbTG4njij2UMZDQtDfu_Kw>
    <xmx:iX3RaIUHvz8_1o2_DtlzizRRt9MY3hm1T2Y_IXxkbBR52ViDFAbQEQ>
    <xmx:iX3RaKj57F-oJZMslH6KAgT6wrpwsw9WjfPNNPkNQdnIIkIxEac-QQ>
    <xmx:iX3RaDDygSf_crvIhdnZyTGq92dQc8vFWngWK8Wv99HlG0nBgwi8jR0G>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 22 Sep 2025 12:47:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Ezekiel Newren <ezekielnewren@gmail.com>
Cc: Patrick Steinhardt <ps@pks.im>,  Ezekiel Newren via GitGitGadget
 <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH v2 00/18] Introduce rust: In xdiff
In-Reply-To: <CAH=ZcbCZXavx52521cFHdXZn=BCWBiR1aG10ekZVg3PVVJb2VA@mail.gmail.com>
	(Ezekiel Newren's message of "Mon, 22 Sep 2025 09:31:10 -0600")
References: <pull.2043.git.git.1756496539.gitgitgadget@gmail.com>
	<pull.2043.v2.git.git.1758071798.gitgitgadget@gmail.com>
	<aMpODEpyaaVhFMO0@pks.im>
	<CAH=ZcbBNFSwU7E+P7hkQnt9UrMKiCRESgGvWPL7pRUa0i2U5-Q@mail.gmail.com>
	<aNFIozagGc0MoseL@pks.im>
	<CAH=ZcbCZXavx52521cFHdXZn=BCWBiR1aG10ekZVg3PVVJb2VA@mail.gmail.com>
Date: Mon, 22 Sep 2025 09:47:03 -0700
Message-ID: <xmqqikhav3i0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Ezekiel Newren <ezekielnewren@gmail.com> writes:

>> > I wanted feedback on:
>> >   * Cleaning up Rust type name collisions
>> >   * People don't like it, so I'll drop that
>>
>> I don't have a strong opinion on this. If it creates issues I personally
>> don't mind fixing it.
>
> Junio doesn't like it, so I'm not going to do it.

It was not "I do not line u16 as a typename when a perfectly well
established uint16_t is available", though.

It was more about asking to explain the reason behind insisting to
use u(8|16|32|64) types in C code.  Perhaps there is a compelling
reason to do so that I was missing.

I know that the kernel has used these types for a long time, but
that way predates their more recent flirt with Rust.  If your answer
was "the kernel uses them", then I'd want that answer to cover a few
additional questions, like 

 - Have they benefitted from their use of u(8|16|32|64) when they
   started working with Rust and if so how?  

 - Would we be expected to reap the same benefit if we used these
   types?

for example.

Thanks.
