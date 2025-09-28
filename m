Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 015311D88A4
	for <git@vger.kernel.org>; Sun, 28 Sep 2025 22:40:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759099224; cv=none; b=dAusxMgXnZYFRqLMDlrEm7knt/Sojv0mUSpo00Xxz8GSPcneYiJCg3JUibP6Q6dRH7aaprThkBfZs+UB0e5M+zK3I34eB1MoeJ9zqPt7uErjBEFAj+rADcpunhV3a7OnO0z/ir0pArKUYb2d3ka0AlDK6FQm4PA6wnIIhkGrRcc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759099224; c=relaxed/simple;
	bh=CdSpUXaCMNE0caOI2QgT2afAbDdoiuOwQ2IN3R5Uqo4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=f1sJRI530oelC1E2PO1gD6p/7m6IyW8y9X1DDjcm6C912AjQT/7t3IM+nxSos3GZykj1HORuM+WYWQvCDBnWlYRZisYGAGD2Yp4QsIWHVwVcDbAPSL1NgfJes+TnTcaicb5fauNPUzzpsbdCdR1FpAD89u1nfALKs/zQR7DOK0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Aog1/6D9; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Lloz/H78; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Aog1/6D9";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Lloz/H78"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 073071400113;
	Sun, 28 Sep 2025 18:40:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Sun, 28 Sep 2025 18:40:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1759099220;
	 x=1759185620; bh=ey/L6oi29dVkr5LavTlhr/HZgrOSs78HeNydMFvEIOE=; b=
	Aog1/6D9NC7c7Kn0Tm3RuTgcvtqLJ7CZK9QLjotkau8uyKwwj7dzT34doH+cZzFk
	bRGj2AjI0PmGUr07RpGSb2Vxvnratg3EsqzA1IMXTpAqEEcSP9tAeaz+1RdB9tNn
	heviFx9X7iq87iEbh3VoEaGy98ZhHsa1xcDxDQZ0QYoeRYfcXuQT+6dHJRvZIS0w
	Q76mJmAQd2Y+Whx5nbg40dC+T1iIIeTZSooNTt5ht81kRIwZF34J9YWaaps2Fvd9
	3eax3i9dsNflQo0ebE35bVCuNwqzG+g1d28OjqU1SbpYCJZ4N8n330YOQ/xf9sxy
	EtGkiFgnWA2KpK6Ha850Pw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1759099220; x=
	1759185620; bh=ey/L6oi29dVkr5LavTlhr/HZgrOSs78HeNydMFvEIOE=; b=L
	loz/H78EBQIyd8jL2SXsB2OfJEPaz5BKV9A58+jordZEdLTRciOevk9CvcBWWUgZ
	hTdiUI26E/TzjNOoawi5xjb0wLGbL96qLxMhYPu3p2c/143VWatMmRVvVoPtUfrL
	ms8LPNWR25QNNsQd85I6AxkMEAXzoHClLI0VOqAY7u3Y2qoD7GX0mS+v6c/i0FPk
	InrK+KFm6rPkYpw21QFjpKFTlrc5oJNauOFrDPfMK4RtQnraTKGjU8tWZJVUp0ec
	KzZZSUenrjkpjIlg5AsEAKHRpz1zmXXROAObLTn18Bu92l4U9cuBOWxdrvoewLtc
	+9MiXNznOuGsnhTC+1/4w==
X-ME-Sender: <xms:U7nZaAzRGMLMzmI5l0vvrwzd4dWza-aq--Q9n7CvBfLc2JoIxUMNgg>
    <xme:U7nZaG2qJUIyQBgkEcOiJkD2Y8rToy4j5tgCu2UAm8czYmQoLKeCWAHKSGMuM5u3f
    3SbsrEEm79_MV1-QkW7Vt_lTOQObiiojMNvebDwSiaxjSuZjK-Ckg>
X-ME-Received: <xmr:U7nZaF9TwSp7Y6tlzVCYZj2yTHwgTPQSx7a9gVyGCEHSA0rusjJuMcV-CEWDa47ccTfBHkFEX5pbgdmfpHqHRml1t70rO31ceWJe>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdejieefhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepsggvnhdrkhhnohgslhgvodhgihhthhhusgesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepnhhorghhrdhpvghnughlvghtohhnsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepphhssehpkhhsrdhimhdprhgtphhtthhopehphhhilhhlihhprdifohhougduvdef
    sehgmhgrihhlrdgtohhmpdhrtghpthhtohepthhhrhgrnhhurhesghhmrghilhdrtghomh
    dprhgtphhtthhopehgrhhoshhsvghrrdhmihgthhgrvghlsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepshhunhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:U7nZaOqOWDBs4bYj_BonXtoMn0bAtOAu_selWuE4vcRb96ajunzhiw>
    <xmx:U7nZaHRFU1NJsi6cICaATcpoy0CfXbslZ4vtb-bQFwHuXM9G3C2tuA>
    <xmx:U7nZaJOAbPtFarQyU-k_qheOhmsDMc-EOa_XYkzSqqFR8Fuf0WUUoA>
    <xmx:U7nZaNjMQVPGpprC_mzkpu5m6VsPcnuwCG-LyoiEJonnWbVw6OD1Sw>
    <xmx:U7nZaMMPNZ7Lt10wggBww285Z1okq4SOt8zrxa6S9Wy4K-sKcC9j4Kk0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 28 Sep 2025 18:40:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble+github@gmail.com>
Cc: git@vger.kernel.org,  Noah Pendleton <noah.pendleton@gmail.com>,
  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  Thranur Andul <thranur@gmail.com>,  Michael
 Grosser <grosser.michael@gmail.com>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v2 0/3] Support :(optional) filepaths
In-Reply-To: <cover.1759094936.git.ben.knoble+github@gmail.com> (D. Ben
	Knoble's message of "Sun, 28 Sep 2025 17:29:13 -0400")
References: <20250501214057.371711-1-gitster@pobox.com>
	<cover.1759094936.git.ben.knoble+github@gmail.com>
Date: Sun, 28 Sep 2025 15:40:17 -0700
Message-ID: <xmqqh5wm5hgu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble+github@gmail.com> writes:

Before "notes" you would want an overall description of what the
topic is for those who no longer remember the previous iteration,
or for those this iteration is the first one they see.

> Notes:
> - Based on commit 2da08f2c3d (parseopt: values of pathname type can be
>   prefixed with :(optional), 2024-10-14) (broken-out/wip/optional-path)
> - Rebased on v2.51.0

Thanks.

> - I'm least sure of the 3rd patch and am happy to drop it in support of
>   the first 2. I think it might be better to (a) integrate :(optional)
>   support as pathspec magic and (b) use pathspec magic in parse-options
>   when getting filenames. But I'm not sure, and this has other
>   ramifications I'm not prepared to deal with. (For example: `git grep
>   path <file>… :(optional)non-existent` could pretend like
>   `non-existent` was never given?)

While it might not hurt, I do not see a need for such a support.

Pathspec _is_ a pattern.  If an existing path does not match the
pattern, there is no ill effect.  In other words, in this command
invocation:

    $ git grep -e needle -- Makefile no-such-file.txt

neither Makefile or no-such-file.txt is required nor optional.  If
there are paths that match these two "patterns" among the paths in
the working tree that are known to the index, the contents of these
paths are inspected by the command.  If no paths match the patterns,
that is fine as well.

The command line parser helpfully offers to notice a pathspec
pattern that did not match any path when you do not give "--", but
that is up to the caller of match_pathspec() API to do so.  The
pathspec machinery only reports if each pathspec element matched a
path in its seen[] array, and the caller can use that information to
report which pathspec elements did not contribute to finding the set
of paths to work on.

> - The parsing is not exactly a "clean API," but I wasn't sure how to
>   make it cleaner :)

What you have in [2/3], the update to git_config_pathname(), seems
quite reasonable and something that cannot be made cleaner, to me.

> Changes in v2:
> - Only check for missing files, not empty files
> - Move a test change to the appropriate commit
> - Document optional magic in options in gitcli(1)

I agree that it is a better design not to special case an empty file
like the previous round did.  Looking better.

> This series adds support for optional filepaths in config and
> parse-options, which supports use-cases such as missing commit templates
> or blame.ignoreRevsFile values without erroring.

Yes, this is what you wanted to have at the very beginning, before
listing points you want to call attention to under "Notes" label.

Will queue.  Thanks for resurrecting the topic.
