Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47D1E79E1
	for <git@vger.kernel.org>; Thu, 10 Jul 2025 00:01:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752105675; cv=none; b=p2fLKn//NDyU7jLido0OSd9JjihYCUZr/Fl14pNJlja4vrei6F9jSSI+sGKpWsU5SKgv5eVWT54wwXSPCLyXpF/QKEZZECsua4ZgeQ0inPDprG12235Omgvg4HU/IULM0czmLC1A5fiKz8gxOS4r+u82oJBwnL+4wA0Z6xNRlws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752105675; c=relaxed/simple;
	bh=wN5fXdSUZ+8rvAscqMubqqyq43fjbpHyyNnqGA6Xw/o=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eOuBh0Ok6e2DtKCx8fonsXRVW6Pu7mQu2NFqhkGllqdfUF+D1Di+ADeyYoh8NETKd3Jpr3Oa4xk2n0S2lgI7KXwn+MUGd0qMqk2tZNL6GXnfe+7bw8poB4XMJAY9crKYwHrKXHM8dqPgPDSOCnY8dqRjb78EJkZ92tPE/Hl/VP4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AoKFPFTB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=JTbwwnmW; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AoKFPFTB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="JTbwwnmW"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2404A7A0071;
	Wed,  9 Jul 2025 20:01:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Wed, 09 Jul 2025 20:01:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752105671; x=1752192071; bh=uK+o/gCBHM
	4ffPP5k3Vms9wC9LsM4vlMUkCzQ2/7KcM=; b=AoKFPFTBSxoi0IbwV8F9XdTkk0
	Lke2x7iO2tBxHx/+KQfuH38i8VgLGTXaQCn6shLw0ZS15lSDOOkj3HGKLvgLqpS0
	Gf0f+5J1b5g0B6FMwgxfQb3oJocp54KL/okzUL2JbtuRZrrTKYJ7s4hSFHdKwD+I
	dJs8HPNJdoB4SzGbU9QoDpoTEcupVtppPyKHAyS2dqtjeoqYxUVn4nT8Gfn+I78l
	zLbqwUUii5DMYSijEdHEW3piHXzhHaHCohVqYweUYz6TzsRVM1ncKgaYJcS71/m+
	5yiqrBaHpdwkRuAIOJVHrZ30Ba2jNc6H/PtlOBxUkA5Wc8YweCubt9VU/zMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752105671; x=1752192071; bh=uK+o/gCBHM4ffPP5k3Vms9wC9LsM4vlMUkC
	zQ2/7KcM=; b=JTbwwnmW+bcTNwHOq9ZxAm5Il8Z5UK6etWiPYQs1Ff0aMqhYQyN
	yAFlpj04NBRYkpWDugbjoG2ykBYYysy28g+MHWRWe2BM9CBii5SnmkgXlh11sW7G
	mlkYzjigcUi72Ts3Tkt5sJLXViOHtL7eqsLDo9TrXsIsrT0RzfHxpDHKyiYQ12sP
	dvQoLin/6Hcf3v+TJkBunooIkyKlOUw6CAmIgGqxgiKuAynUnpB4W66aVs6a4gvz
	elMgasRWEenJW8Kr4M7MzyqE68/rgg9ZxZv7cEhzZsVrkyO66og+0Ss3kaXv2BHg
	SmSRBNFfIvPzFgP9J5p4GOzPTVQxc3MtBhQ==
X-ME-Sender: <xms:xwJvaI-oYhOwiTfxl6durIV1tw_mQVwgQPdDYJrfl9W1-SRqDdsAJw>
    <xme:xwJvaMPRWO0D7WTXN7VaOk-pYnYsWoqiofOm-kyLIZNiU1kWuaDA7gY--lbKHF8K1
    Ni2eEPIvo2nBkOmZA>
X-ME-Received: <xmr:xwJvaEesq9qfO1Rk4CAmCMW8dmH40danq3Lop3_1G3MQ8FpPfJpdTk0RFjbrZBlmMhXgWduyuEsZF5xtyRhqdgKRlgzRLMR_Z_3f_Gs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdefkeelgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehmvgesthhtrgihlhhorhhrrdgtohhmpdhrtghpthhtoh
    epphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdr
    tghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:xwJvaDXhafD2sLbMaAmyOtxbYrxpP0PEw8wf7rkGx-bcvKzICGnWSg>
    <xmx:xwJvaEjbQhRPQD08aIxOyS9GBYmI1SvXqaPP0TTMZpAac_4hzzpRJw>
    <xmx:xwJvaK9VE570szlgI7yt2EisxrylNphESpBqnQba65exg-u3rChGjw>
    <xmx:xwJvaOb2-2MvYNH1_Pjf-IUDiyuWdXLandV6aw8Alz9L_Hnfl0I8vQ>
    <xmx:xwJvaGgdRkaNYvhXyF3j65XlwFUUJxSW-n2Pdcf8XuCNxLi14QJeoCMR>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 9 Jul 2025 20:01:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Taylor Blau <me@ttaylorr.com>
Cc: Jeff King <peff@peff.net>,  Elijah Newren <newren@gmail.com>,
  git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jul 2025, #02; Mon, 7)
In-Reply-To: <aG6A19ZgxwpdJuow@nand.local> (Taylor Blau's message of "Wed, 9
	Jul 2025 10:46:47 -0400")
References: <xmqqplebzgm7.fsf@gitster.g> <aG6A19ZgxwpdJuow@nand.local>
Date: Wed, 09 Jul 2025 17:01:10 -0700
Message-ID: <xmqqecuoap89.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Taylor Blau <me@ttaylorr.com> writes:

>> * tb/midx-avoid-cruft-packs (2025-06-23) 9 commits
>>  - repack: exclude cruft pack(s) from the MIDX where possible
>>  - pack-objects: introduce '--stdin-packs=follow'
>>  - pack-objects: swap 'show_{object,commit}_pack_hint'
>>  - pack-objects: fix typo in 'show_object_pack_hint()'
>>  - pack-objects: perform name-hash traversal for unpacked objects
>>  - pack-objects: declare 'rev_info' for '--stdin-packs' earlier
>>  - pack-objects: factor out handling '--stdin-packs'
>>  - pack-objects: limit scope in 'add_object_entry_from_pack()'
>>  - pack-objects: use standard option incompatibility functions
>>
>>  "pack-objects" has been taught to avoid pointing into objects in
>>  cruft packs from midx.
>>
>>  Will merge to 'next'?
>>  source: <cover.1750717921.git.me@ttaylorr.com>
>
> I think that this one is ready to go. Since Elijah and Peff last
> reviewed it, it hasn't changed substantially (other than a few
> bugfix-related changes that were discovered while rolling this out at
> GitHub).
>
> The series has been running on GitHub's production infrastructure for
> the last month or two without issue, so I think this is good from a
> stability perspective.
>
> I've CC'd Elijah and Peff here, since they were the last two to review
> the series, but I don't think that they have any objections to this
> moving along.

OK.  As they both seem to be active, let me wait for a bit and then
mark it for 'next' unless we hear anything unexpected.

Thanks.
