Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9137C266B68
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 12:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741868806; cv=none; b=qg+tUY0dvVQbolSUCCkNyKspgPyAo0ehz5GD0Pz0qTylDl9HuowzP5TT1FeZBLcC3cRexsTnKIvUhfqTSmLcXPKlWxy2fwzmrh+I+Xe+uob6Vl7sJRB05Tgw6fLpn+1utwVRiWoWjZSuT1YFovBqwi3O9M9ygEATmK/XCEMiJ9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741868806; c=relaxed/simple;
	bh=xN764sPpctwAIJUDCUj/NW55yPBLLwwIj416YdP+45E=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ZO1u1OCk8woD0b0mX9h143mOEkfT3NBMzABhiRBVnACF7t0JT5pgn1OJmkgAu9z+TiCG/EhAB0ymIbbt3xv+TPmsv0T6/NZZL0s0DWBdB/UB7JkO2Jmygm5y7BvKj5/iVjx9VOQiy+o2mzE6/7gHk7Jt7qNc0dFmgUouYckl6OY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=enHaxiZq; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n3uWv9v4; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="enHaxiZq";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n3uWv9v4"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id BD5FB1382D25;
	Thu, 13 Mar 2025 08:26:41 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Thu, 13 Mar 2025 08:26:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741868801; x=1741955201; bh=vjLxNe/nkO
	uHTzNcBb+YST0kE674pSi5HCS4ymLs530=; b=enHaxiZqyJ3s+q5zdcufKznLWq
	T0epN/jp1ojG2uDqw6/ojKEfTx3S5w+EnbPSDVE5LQqkvq8y2Vl+ArP4kA38uVpn
	+7p9CAxrAs19mjDI4usfIlkY7E1s7xkHDHslIlisEs3DtSfqBRy/32GSTTcSxI26
	QtXQY9BgpEa9WrWCLmIcydX+aqZPqACIaN8kFJqg18hcTbfbeD/8rK6aBDuIrInc
	ccgfd/1C2zWWjq2ZgOdkxeVrk142BQmupylAonLC6RdH0ZfI+K/QK0LOza4Pp+Yx
	fYg3V4LfSDzGwTknokPosMZnDKkYEmZOdMCScvGLqr6WY9qvWEoSYcNZx1bA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741868801; x=1741955201; bh=vjLxNe/nkOuHTzNcBb+YST0kE674pSi5HCS
	4ymLs530=; b=n3uWv9v4W4jeKOkTkXKNcGcXHSp+L0ELIixbKPPMpI1Qhwp1CmP
	ulz9dRz6B1WLlfygawdY2wk0f8FlGQrN3TIALF55Ir2XL/qNmVhaADss6Srb7RV4
	OeOG2jXHbWbOTBt3ItWjJjmgZiA9PMAuvH9mM0DmiBEZvVYrREG4D8GvDk7Xrk85
	9lbU+hV0CuQB8bJqcZWoNaEJPXedcpP1zdiSygyWyzLhgFtPM3SljUWXXnNp4K/Z
	CsvoIg5Ttl0qBpGTjLs+GwkWvcw9HiZObrLyUPqLt00ANt0wANtkwWqyHQBKCAfq
	iaNDbJjJmu09svmVIC0vf7Jxq8Y6FhRpgig==
X-ME-Sender: <xms:Ac_SZyht0Y1EousN2ndtiJvsTewA_vjmOoGWf5ZqZ0uYbSBBaPuFdQ>
    <xme:Ac_SZzCGEyPvnuE-gv3hlX8Ckq12LqoFRrM8pYdt9DT56H64DfJPNVYHyNqAMntFT
    aitbi7WM4NkAU8Cwg>
X-ME-Received: <xmr:Ac_SZ6Gaf8WaUZpzgmKezhPAj4h7kYWujAvkwcneBCfjThax1eQeDkB5Ymzals9sQohmYb6fXBxbQzgsfReosi85btMBKehqHCZauvY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdejleegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvf
    evufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghm
    rghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpe
    efveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieegieenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvg
    hrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhu
    thdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtohepghhith
    esvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehinhhtvghlfhigsehinhht
    vghlfhigrdhnrghmvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Ac_SZ7TokCvrGmNZIp1UgqDH3HwVwOOPDljvAgFrqo96MrY8Pow-iA>
    <xmx:Ac_SZ_yQ-JeJQCGjId5pxv_x5KVnQJ9Y5uoPNaPtLe8JTok1C-8Sxw>
    <xmx:Ac_SZ56_Trgo0f3ustzXfzAgIFyeQhgp0QPwirZ9zAeSmBjLsd_b6g>
    <xmx:Ac_SZ8wb9VXXg88Et1qRbZJf4HGKpyfbv1PD9B5s-5Lik7T-veRMLQ>
    <xmx:Ac_SZxvYSV5YtP5hWzw4jJMduM2mTCTwe5kkdIOwJwI3zwxuD2diZtW7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 08:26:41 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org,  Ivan Shapovalov <intelfx@intelfx.name>
Subject: Re: [PATCH] doc: centrally document various ways spell `true` and
 `false`
In-Reply-To: <Z9IH6G7BnM0blOmH@nand.local> (Taylor Blau's message of "Wed, 12
	Mar 2025 18:17:12 -0400")
References: <xmqqy0ycz9dk.fsf@gitster.g> <Z9IH6G7BnM0blOmH@nand.local>
Date: Thu, 13 Mar 2025 05:26:39 -0700
Message-ID: <xmqqh63xru9s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

>> +- 'bool': canonicalize values `true`, `yes`,`on`, and positive
>> +  numbers as "true", and values `false`, `no`, `off` and `0` as
>> +  "false".
> ...
> I agree with the rest of the patch, but is this true (no pun intended
> ;-))? I thought that we might canonicalize "yes" to "yes" if the value
> we are asking about is already something other than a literal "true" or
> "false", but I don't think we do:
>
>     $ git.compile -c foo.bar=yes config --type=bool foo.bar
>     true

Sorry, but you lost me.  Isn't the above demonstration of 'yes' you
gave getting canonicalized to 'true'?

	$ for v in yes 1 2 on
	> do
	>    git -c foo.bar=$v config --type=bool foo.bar
	> done
	true
	true
	true
	true

Or are you saying that the above documents what happens, but you
think the code is wrong to do so?


> So I do think that it is worth saying "you can spell 'true' as 'yes',
> '1', ..." in the documentation, but I don't think that it is correct
> that we'll canonicalize "yes" to "true" in the case described here.
