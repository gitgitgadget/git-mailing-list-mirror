Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2240A6F53E
	for <git@vger.kernel.org>; Sat, 17 May 2025 13:09:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747487385; cv=none; b=djoAxrOdgZE6y3Gkr+dX1rwgTm9PPGN3Lr2n9h0Q30Oze9icgcPU35BWBKOcPP1v/e6Bob9dC6r7RuW2wtUTG5fkiORccaA9gDXfPQVPIkls7d9beWpKixXOiu55rYqsmhkbe5OomfeCaArRljuziaoWroqIldCN3vzxxwqpo4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747487385; c=relaxed/simple;
	bh=kIsQqyLGfwBoDwZP7/7gC9foBHN+W2821NCY711PfYs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mp6YUACrPZiV7hiuIgjbI/37Pg+FNuEJajEUfUq3eTOOat/tMsgu/VyDFG79Vg0J+U7Km7bzygP/ge7yVgBNL9spNidqHCt6IA3cMcqiNUeGYaKfcBpXQtVYah7WrPOpfagg2RRj5y48y24pTzyerHoaZbqVnuacodW2S4W7WOs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=DN3Xtj2G; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tEqIlPbM; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="DN3Xtj2G";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tEqIlPbM"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.stl.internal (Postfix) with ESMTP id D03A011400F1;
	Sat, 17 May 2025 09:09:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Sat, 17 May 2025 09:09:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747487380; x=1747573780; bh=vDXLREtjEf
	F0EuJgkjEkXRmEU+onuArzMWN8cQdyvqw=; b=DN3Xtj2G/Ake/69METrv4FO6GM
	iqmKLBJl3yk1l5vFJb4OWkI/jQq7du1iwXFbrn/Q0CRcWbdmpEd8SBV5DWMzdoim
	TwOvUx4MVf7Fth30cE6I6V5g/GMW01OMhCsP1bKUjQCuZ/zFfJETNzSAEVESJ8RH
	5HaKiV97feBIAkedcsoEL+lffMh5grPVnH3KrZCsCfHa14uaHUDim1FKNWuBFDhZ
	cO9pGO1RPqlkqELuq/l/H7WctkMqJsEvNiuycWtu0j3Uz7ktx+l/3jsYKM7rnhav
	+W0k5HdUCSz8FWcAjxc836EqXHONkhuwLwUCs8MrHBLZIQdpTqzo1OZ6idOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747487380; x=1747573780; bh=vDXLREtjEfF0EuJgkjEkXRmEU+onuArzMWN
	8cQdyvqw=; b=tEqIlPbM962sZYZhGmICeIzwj6C+M90ojvctKjTepxcyPxcmLnR
	r2J9IEG1CrRt9gylo4WbqaBZ9cRIx+Tf0BUElbQN7sIFLXGWVT5fu4IdCkYfiJy7
	Vq/hnY5KQ6hMd5pc29bcQkkW7Ptwm7qy6Y+NmGaM5XLSxfi59SV3R90ynmAPaFj+
	kb69g6dpmSgA3F6t16Ph+GFzsm+eHdQUrObVKjQbH1FQrQtfGI05e7F6lBU5P2uE
	t8mpk3CSsq8caLi1manybMMrHYq+AFYQfcJsKZWRbrYA6vqpjHhpUfS14AaKEheP
	kTfx4aGky3RuPzu3V26wpM0ot/DA6KGn9Rg==
X-ME-Sender: <xms:lIooaLPIcMvT4DhC0m8sPcS1s91Mu7O_hfEQoNkwCjZz-WiotzgJBg>
    <xme:lIooaF9iUHrJyNzOKPmI8Z10fLFrxQ5p8TD-TPdPibqgyt2e0JFHhAk_PayGn-EYN
    cLQx8E9VLj26PaNrA>
X-ME-Received: <xmr:lIooaKSUj1XnX729bvfgsNCSHPXEFIIFNGDLmYeoxi9T1KikuuQ5F5fkAqXZIrU6EGFa_6CnApacgcMXcQdaNun4P60rnluWBmkvqQQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdefudehjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusg
    hgrdhorhhgpdhrtghpthhtohepughhrghrieduheelheesghhmrghilhdrtghomhdprhgt
    phhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtoh
    epghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghr
    sehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:lIooaPsNwfEJzsudQSwxXjn0VoEYcaIkUyTY8GAYWMAoIPpq_rpgVg>
    <xmx:lIooaDc6aisjDJ9-Q3tbx7csi7A9-rdm5ri_9SmX87bwQHqcTZrhRw>
    <xmx:lIooaL3PIsqEc6SPeqLLYO4jjckDcwc3Zv6ULb-Y71iZ6oAOWUltTg>
    <xmx:lIooaP_STzI3Bf4cduUuBeWlZwj_BNYGjfVz-d0DdZt3bqW1u3RAVg>
    <xmx:lIooaIfudJDUpuEKy7U6jqtNAtHViedEXQZth42cJtmPiHJn-caimY7I>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 17 May 2025 09:09:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Moumita <dhar61595@gmail.com>,  Eric Sunshine <sunshine@sunshineco.com>,
  git@vger.kernel.org
Subject: Re: [PATCH v6 1/1] userdiff: extend Bash pattern to cover more
 shell function forms
In-Reply-To: <8343694f-6e05-43c5-862a-63702314760e@kdbg.org> (Johannes Sixt's
	message of "Fri, 16 May 2025 09:25:43 +0200")
References: <20250511125809.14180-1-dhar61595@gmail.com>
	<20250511141101.18450-1-dhar61595@gmail.com>
	<20250511141101.18450-2-dhar61595@gmail.com>
	<8343694f-6e05-43c5-862a-63702314760e@kdbg.org>
Date: Sat, 17 May 2025 06:09:38 -0700
Message-ID: <xmqq8qmvs7sd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

>> +y=<RED>3.14<RESET><GREEN>2.71<RESET>
>> +z=<RED>.5<RESET><GREEN>.75<RESET>
>
> When do decimal numbers occur in shell scripts? Wouldn't it be more
> often the case that a fullstop is part of a regular expression or a file
> name or version number that happens to be surrounded by numbers? In that
> case, we would prefer to capture the digit sequences as separate words.

Sorry but I am confused.  

Do you want a filename "sample.3gp" treated as having separate
parts, "sample", ".3", and "gp", instead of a single word?
