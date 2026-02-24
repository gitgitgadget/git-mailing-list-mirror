Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D466E33BBB1
	for <git@vger.kernel.org>; Tue, 24 Feb 2026 22:06:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771970770; cv=none; b=vFTQXLwnLB5BbTHTZdzqLDfptnpbAMGoJ2iD1jbJXoh0Eikl4RrMcCP93IE3FOno5Ro36rsZ/HRqM7I4XsIBoAnDneD3z42mYuv6+U71H5ULqt3xqDFr9fhRAilQZS7JARdIP9z/TnKch7wpgYefdCNoHgoKeL+LB3yGq+Joguw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771970770; c=relaxed/simple;
	bh=GZNxGyFwLUValIvtIeNozk9WZBY49eYUIIPqo2CHsRo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IBLep9hTdjhAw3qYSZmVXd/AKf/BESJ53UnMEIW+71p01QYt3pbpxwD/5ASoGvqKAet3H6dUQq2vNwPCW2Bgfg9qf7sE6GAfXtNlN3g8kwEUiN+nz6ACFgXrCI9bW4zQTkOh5A+HJS7jvIjOZ9u1zc2XAoTu7+W3RkxfZ99Auek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rdAWTbTJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Icob9Ei8; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rdAWTbTJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Icob9Ei8"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id C678B1D0020D;
	Tue, 24 Feb 2026 17:06:08 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 24 Feb 2026 17:06:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771970768; x=1772057168; bh=yUXjw4YRxa
	FqAF330G2CDNLI2S48u+ByLYIIJrPVSAA=; b=rdAWTbTJyWLRk+BGopzfhnL42k
	uHsPbs73gm5+G8N1HeUmqzYZqjTRFjLSNw1JV3gQ5IHrJUB6byxH74VZPmLov+2r
	GLAGXLLvrC+2RrTSW/t4rflWvTN6GJn0Ao61Zn9nEKLe0TBxgrBNwbY4iV+9u5zY
	eSKy6YfW20CVur+QUQmZhCEcTNlfOy2B3cuKljdZ7F3+7YLhFuel8VXY+89fT0iN
	gogS8h/TSQ6Bnh4WYyotovQvXPRq5KYgbM+ZPdWnmMICxYjPE6AGtrsE/NaSl1yJ
	3Hikp3MGwrVBzvut7DPnmDbntN2r1j6HLPluLT1wWDxkzlhxtLuTt0Fb5amA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771970768; x=1772057168; bh=yUXjw4YRxaFqAF330G2CDNLI2S48u+ByLYI
	IJrPVSAA=; b=Icob9Ei8fZlk9ibLpuaWJMHYHHJAVqn08DGDFYGneNIoXFWzXQG
	SNayqzDC1P4zPMFlWcDRbCAzr1kUhrhVkqtbf7a2ZnTs0mA1PDsl/JUwDIsVOHzy
	7uH9lTvItELdPyfgkXElFachpSU+/9mFlj5+D5twiwnx8RlvqwIbbo8ZdgvlGHqy
	ZPGaeil8LzE/QetewnpyLgQvT/s5DfivTrEiTF5u9hg5Z9RdKiHPbVcvS4Grdapr
	iLtashSJ9u/L0N9hJu7px5mhC8mS6Ay1AxmLQZ6kgAqFqQHnUIk2bg4pvGid2ag5
	QC3LF+7WVHlxM+W1+RpK0GMZCPCd8iHluBQ==
X-ME-Sender: <xms:0CCeaTp-xWKp0ZlJsAVewRbgCOkuu5u8nOSFNFmOn7HzteuLzpLqKQ>
    <xme:0CCeaUjBI0K3vdA-PTPshYIRTMALWghnk-zKgUJdfzaSx0XtrwBnZM8kNdpEWn0gK
    jOPpV2pScqWj79VrbxVvtspnmcdhvMnl8OW8WnNWW6amFghLbZ2iA>
X-ME-Received: <xmr:0CCeaYiOUoo_DA4mFoKGZRR1DlNWJE_wyrhvR0CUc23BdVC_pp26xtAwnYO0UbCIFWyoai1ZWmOpmDORdHef4DCwAxdxzmxv1g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgedufeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeffieetueejveefheduvdejudffie
    ejgeefhfdtvdekfeejjeehtdegfefgieejtdenucffohhmrghinhepghhithhhuhgsrdgt
    ohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhhrhgvhigrnhhshhhprghlihifrghltghmshhmnh
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepphhhihhlihhpohgrkhhlvgihsehivggvrdgvmhgrihhlpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:0CCeaSgKNuxrpmTvjYw2K1WczNUfi4k-y14dA31zCufeMxN5VmSbZA>
    <xmx:0CCeaQIAGGJG3hZPsL7Wo9GWwao-hsHmXyF5RsNUMKsqUuVP0kwhGw>
    <xmx:0CCeaZEmDhZKrC4F1Mau-EHEP9QoLFgo7MHjtgCsPLpyuHZb8yr1lw>
    <xmx:0CCeacT5kby6rcbDueqeXYVuiw5N0N-7E6Bd0Yc5NGlYZNE7NJ8nmQ>
    <xmx:0CCeaY6QPOqFiCzw0Xf3VVn433PUDKFrRDYF5kavCwyeV4Rgq9y-t5-x>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 17:06:08 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
Cc: git@vger.kernel.org,  ben.knoble@gmail.com,  philipoakley@iee.email
Subject: Re: [PATCH v2] send-email: validate charset name in 8bit encoding
 prompt
In-Reply-To: <20260224213932.92364-1-shreyanshpaliwalcmsmn@gmail.com>
	(Shreyansh Paliwal's message of "Wed, 25 Feb 2026 03:07:39 +0530")
References: <20260224143624.23678-1-shreyanshpaliwalcmsmn@gmail.com>
	<20260224213932.92364-1-shreyanshpaliwalcmsmn@gmail.com>
Date: Tue, 24 Feb 2026 14:06:06 -0800
Message-ID: <xmqqqzq9er01.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com> writes:

> When a non-ASCII character is detected in the body or subject of the email
> the user is prompted with,
>
>   Which 8bit encoding should I declare [UTF-8]? foo
>
> After this the input string is validated by the regex, based on the fact
> that the charset string will be minimum 4 characters [1]. If the string is
> more than 4 letters the email is sent, if not then a second prompt to
> confirm is asked to the user,
>
>   Are you sure you want to use <foo> [y/N]? y
>
> This relies on a length based regex heuristic check to validate the user
> input, and can allow clearly invalid charset names to pass if the input is
> greater than 4 characters.
>
> Add a semantic validation of the charset name using the
> Encode::find_encoding() module of perl. If the encoding is not recognized,
> warn the user and ask for confirmation before proceeding. After this
> validation the lenght based validation becomes redundant and also breaks
> flow, so change the regex of valid input to any non blank string.
>
> Additionally, the wording of the first prompt can confuse the user if not
> read properly or under any default assumptions for a yes/no prompt. Change
> the wording to make it explicitly clear to the user that the prompt needs a
> string input, UTF-8 being the default.
>
> The intended flow is,
>
>   Declare which 8bit encoding to use [default: UTF-8]? foobar
>   warning: 'foobar' does not appear to be a valid charset name.
>   Are you sure you want to use <foobar> [y/N]?
>
> [1]- https://github.com/git/git/commit/852a15d748034eec87adbee73a72689c8936fb8b
>
> Signed-off-by: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
> ---
> Changes in v2:
>  - Added braces in if-else block.
>
>  git-send-email.perl   | 17 ++++++++++++++---
>  t/t9001-send-email.sh |  2 +-
>  2 files changed, 15 insertions(+), 4 deletions(-)

Curious.  This change to t9001 was there even in the previous
iteration that did not even work.  How did you test it?

Will replace.
