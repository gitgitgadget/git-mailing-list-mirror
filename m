Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0D621CC88A
	for <git@vger.kernel.org>; Tue,  1 Oct 2024 19:25:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727810707; cv=none; b=d095+XmWSjRvvfKiGOPjNmKDJpDZ6nt/R9Hf+AQlXZcabz1gqIPGsaKoP7WWDJltrMF8Qoj0q7xWFiRcqdzVVE/Jbq4RkqbAupy9WMT1UmbJElLiHgDNLJkCkFuUitvPIPGJuf4q56hb7C7tNB/Tk5v+MKabgrKfWbRo66E6hjA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727810707; c=relaxed/simple;
	bh=BQIKL9hfsFQRzqcYRnOF24eHuH+EyGyfvZedKjN+eMA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IXmzdMrwDqpDKQDqs4h8wEJ9PSr4jnUP4cPzOsgFN2guVJMwjLh2PMMwzVED7RHMEWMDk2QnBgHuuxAJ3NaFMCT3S8WmWUlyErKZN8Z6xuiGuUiYNH7FOZxwqiuPoA4dHX7JHqFFbhV5zJO4sgoZp/8DIxQe6LPKywG8iKlBOqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=uiVOFG4x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PGpF2Qbl; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="uiVOFG4x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PGpF2Qbl"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id B83D91140DC5;
	Tue,  1 Oct 2024 15:25:04 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 01 Oct 2024 15:25:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1727810704;
	 x=1727897104; bh=1EMs8EVs6gHG7lAbXGGYArbL5JuplIM3Nr6s/hPg0GU=; b=
	uiVOFG4xne3w/SELMRJnrwMGkuyfmdbKxJxKApA61U51C/U9/UH58k1AiuvQbP6i
	LInsJU9V/mmY70E1Yqr4PzCK2VUD0QxkTnGIsv8rLxn6+z1COq3cFSVQGV++KQ5g
	7YB8nhvFeNvQcAnLwUi5oNRhytYIr9XXqhm5YESFuxdX/I8rJ+ZApLcArP5MgbcD
	5EXMOYTsJCJMj3hyNGomTNA7yGOFdWcgFQi572HCxyGpcbet98ROnrWO6meWtSuj
	aUCsbU7lZ0WReew3KZlnH/UUIIB4aYVd2y7Hp56j2OOz84rrdEOtbbioOVSKc7wO
	VNqDBKLRK/zQbE9Vb3Ilnw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727810704; x=
	1727897104; bh=1EMs8EVs6gHG7lAbXGGYArbL5JuplIM3Nr6s/hPg0GU=; b=P
	GpF2QblvRtEKzha95OOl5fmz76SVbw19rb3eGRiFoa49an2RlOn/BVVbEbS9sKlw
	ZjX0xtBmFBZjudfaYOwTkhQKDGa9H0tI9x4npPm+gZBCWYZkYgENcJ6AlL/LV5n8
	j9oJJlcS8ZTMvAE4MSbAR9DLkYoZ0LujCC7WIwJsTgauTZE2FRivwcSdO0jZ+4us
	nMCRbZN82C67HPpRSgHuEX0JWqzK9bg5B7aW1tFA/2rlgrxKKMuGsESPS1uUBRsz
	w5EI5udBeBvHvs3Rs1ywAZOJRr++YxctIPunmLWclldwr3/T4vGIYC5ZXydAxw0+
	Zp+kdo21s2/RvKS8COqMw==
X-ME-Sender: <xms:kEz8ZvZP66SWtNZrq_Yb5Ttmr3uTCHkQVP-zMJsKnjJnGhK96kp1zQ>
    <xme:kEz8ZuYrxvRFh4U12UIK0kylDrK6JL4Vq5WUXHWCDVf6rZDOC_C9XkDyyLhoXG1kH
    1cmMdrQSmZhN80GSw>
X-ME-Received: <xmr:kEz8Zh-tOSeUPuX1ddL0V1aaNliTL_4tWWt8omhIEZIpbh6ZU3knAdxjIYjnh7QivIftFXUcop7qQk4LTsk6eRzoaQeqbUq0bb8BdC8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddujedgudefgecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtgfesthekredttder
    jeenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptdffvdetgedvtdekteefveeuveelgfek
    feehiefgheevhedvkeehleevveeftdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhdrshdrrhesfi
    gvsgdruggvpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghthhhomhhsohhnsegvugifrg
    hrughthhhomhhsohhnrdgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidr
    tghomh
X-ME-Proxy: <xmx:kEz8Zlr8j0T0TJ4QdegDfGKPqP-7MuKklRtpY78eY_bjB54CkT3MFw>
    <xmx:kEz8ZqoSQ3mU7OdPgBhd02L79XxsGEZNnWiuh6yquX5mD-YptQBmJA>
    <xmx:kEz8ZrRK8gXupx_RxYi57KxoVpV9y0hRa574w7ufato1lfeh6FiE2g>
    <xmx:kEz8ZioY1Z-TOfm7SLDliWRSSqRW8twr3nSv3odOaOBT_jTxjt32UQ>
    <xmx:kEz8ZnDe3_lHAu8pBDgB-IEBjZ6kPFDdfhAvNrQNERJGgL-K1kcu_0CA>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 1 Oct 2024 15:25:04 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org,  Edward Thomson
 <ethomson@edwardthomson.com>
Subject: Re: [PATCH v4 00/25] reftable: handle allocation errors
In-Reply-To: <7740463b-84b4-4a69-961c-278ce2901f0d@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 1 Oct 2024 20:30:23 +0200")
References: <cover.1726489647.git.ps@pks.im> <cover.1727774935.git.ps@pks.im>
	<xmqqzfnnyakq.fsf@gitster.g>
	<7740463b-84b4-4a69-961c-278ce2901f0d@web.de>
Date: Tue, 01 Oct 2024 12:25:02 -0700
Message-ID: <xmqqjzervd69.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> Am 01.10.24 um 19:52 schrieb Junio C Hamano:
>> Shouldn't we add FREE_AND_NULL() to the banned list as well in the
>> last step?
>
> And perhaps the wrapper.h functions like xmalloc()?  At least as long as
> git-compat-util.h is included by reftable/system.h.  Can be done later,
> of course, no need to reroll just for that.

Yeah, and I agree FREE_AND_NULL() falls into the same bucket as xmalloc()
and friends, so no need to reroll just for that, either.

Thanks.
