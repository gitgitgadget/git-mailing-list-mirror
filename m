Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E490209663
	for <git@vger.kernel.org>; Wed, 12 Feb 2025 18:05:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739383503; cv=none; b=pC8GJ0rfooEHx3NXJtK52k9dD4sg+HeZ/kurBbZS2zdiSCFe9z05n2Xf40ZSCprSU7F/7d6So2nrGoe+JAUso/q4Gl2GoiWEjMCjNwsYRktNJeRWQ6yQFkBVneSrMs2DPzLkkec+TDUDTNK4Tn7dh9BTdm5rEJYcgNf7Lr1kPFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739383503; c=relaxed/simple;
	bh=oM+d/53l7k3+c9tmLxeeuZ4ZufkFAy2axx8SX6OvGYA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ot8q4WjuKv8v3cgwAoU/NLpLUjnZnVTLn8dCXldUKNyX224oOrS/uMlitWnM8+ku99Gymygdn0gia6uD1fbSc8dpledLCeVvNTAQqW0QVu/el5abOmUHbLhivusaxhHKrm/qsSwr+VVQg7+zjHiy8XtoVJ1JsTC3fx48oENn+gE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hGCfDQqB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QkMK5zL5; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hGCfDQqB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QkMK5zL5"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 1007725401BF;
	Wed, 12 Feb 2025 13:05:00 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 12 Feb 2025 13:05:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1739383499; x=1739469899; bh=oM+d/53l7k
	3+c9tmLxeeuZ4ZufkFAy2axx8SX6OvGYA=; b=hGCfDQqBNGyWyTDfQvQO4knaW5
	b1RrSWWdC87W6PmfdjBJSd7+uffFClEiElWr4noH6BC/HOzK8QbIY1Q4fJVwWYMO
	ks/mKbXSHHmWO/+I8Jfc8ZSBNxLXbZA2w7Zi56qsL37cUYJ6lNBpmOaD4Gy6YX0Z
	J+qiIYHeCPalyvg8LbX+41FwHVVWtfb9S1k7Xx9tHY6Oirgq/4jTccludKLIn1W+
	WxgnvlT7Vkovm4hGoeSM3rH7c/8RH0gCfhE8KbJ/+Gd7B6ZopfUW0QhsEKDMno2A
	6JpKl3YXdSIJRT+XB15MHpr8cZXVhab3cH3bp2huq736aYBtcJ6Z0CnSvOAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1739383499; x=1739469899; bh=oM+d/53l7k3+c9tmLxeeuZ4ZufkFAy2axx8
	SX6OvGYA=; b=QkMK5zL5KSp3UaM/JMIjUAkBU+Nij2lwqD1T/iJBysdnXXOcQoN
	FcsXJ5797mLrat/pxZikVOmlF/rPU6anbYmNjpkyBXuelSvkBq/zZDEypXzw/Qrd
	s3DeD+Qyghz5i5lqu0NRUb74OzqSZZPTj++Z15SF936DuGw3Y2hGcZJL2cYz5TgN
	1h9NtbQe012Hmn/9lsHoyD9q4lNCvVvAm81qofVNu8bshRw3q9xiba5KVA6BWtr5
	hj33TXDVFDYxE6RLBtyyf2tRvGkY544xox2/w1yhH3WcTDx26MjQgvfSnPi558JM
	gFZ2ullIoyAXlmT5tKZj6185l2QfpNhM73g==
X-ME-Sender: <xms:y-KsZ6VupMEbfheFHW8-Wfa5lYFCWziIr_RsdbqbVGHqP7xlwfNVOQ>
    <xme:y-KsZ2l2fYyu7iCgtRE1GoplR3v6Y42SCcy6UrkRl3indpNuVjU7G5wsj7qBpmFM-
    rFoEumm2dDTT0nAvg>
X-ME-Received: <xmr:y-KsZ-YY-rf4J-CBj4sGManENrWADbAt8rKihNbSII5BCdJpt-t4PKxRlQg2mLCW5kQ_9f6_zOk-XX-5WIND5DW3hy2yBVxu1qwQdAc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdeggeehhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigfefkeev
    teevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdhorhhgne
    cuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhs
    thgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhhtph
    houhhtpdhrtghpthhtoheplhhutggrshhsvghikhhiohhshhhirhhosehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:y-KsZxWqxrRbmyl8aE-GX5d-Kf_j0QjyD0vm5wptxymrgDU5j9RGag>
    <xmx:y-KsZ0kNBbPjgFU7UDPxAfVYQzPYBVmBtq5u77TRdtVYgEBfUdBVzQ>
    <xmx:y-KsZ2faSNH3j4oeYk9yUHZWDgHrnGpqdFCqJaYr7YvnRqmxDr_y2g>
    <xmx:y-KsZ2EZz6v4Zf0UY5HGxn8ecTkg3KIJ5JnxzLPvKz-sWURd3aEtRA>
    <xmx:y-KsZ1ATbAXJVKGlhbs0Y2n2_n8y-RflQKL8pm1gPfLi0asqeOvFZnnW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Feb 2025 13:04:59 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Lucas Oshiro <lucasseikioshiro@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [GSoC][PATCH v2] t7603: replace test -f by test_path_is_file
In-Reply-To: <20250212172909.21257-1-lucasseikioshiro@gmail.com> (Lucas
	Oshiro's message of "Wed, 12 Feb 2025 14:28:16 -0300")
References: <20250212172909.21257-1-lucasseikioshiro@gmail.com>
Date: Wed, 12 Feb 2025 10:04:57 -0800
Message-ID: <xmqqy0ybt4xi.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lucas Oshiro <lucasseikioshiro@gmail.com> writes:

> `test_path_is_file` provides a better output when asserting whether a
> file exists. Replace the occurrences of `test -f` in t7603 by it,
> facilitating the trace of possible test fails.
>
> Signed-off-by: Lucas Oshiro <lucasseikioshiro@gmail.com>
> ---
>
> The only difference from v1 is a little typo, missing the t before the
> test name.


I think I fixed that while queueing the v1 iteration already.

You can check what happened to your patch by observing
https://git.kernel.org/pub/scm/git/git.git/log/?h=seen and
https://git.kernel.org/pub/scm/git/git.git/log/?h=next; other
hosting sites may have similar lists, but I find the one at k.org
the handiest to view.

Thanks.
