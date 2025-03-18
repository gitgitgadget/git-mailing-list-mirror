Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30C9B20F078
	for <git@vger.kernel.org>; Tue, 18 Mar 2025 17:27:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742318852; cv=none; b=rBSU31EoF22EvDPisDlj03J4PMdh0ZLIeStAWtQJh/6PYYOeFgAy65ksfC81HS5aCiW/RgAfDFta1VaUApEuiAmV2Pmb+SMP0BZjE4SdRtAmziApPvdncoff/tCyU2B92nHBJ0H8EQvwZ5uDDCJeJQ+L8aAOpqnEQ6Sl5//7ltc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742318852; c=relaxed/simple;
	bh=zfF4yuS6cBlkgFkful2YvcrMMnlTRu7MmzOO17D81S0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=cxZ+XZiIi5S2yJhEbes1JKOC0Jj8VagHvrIEIWtW8uGHZx0Mr+ud8TVr/N7h+5p+Efn/Ahu+ZN20xHQywh4eLN9Y+ZA851EYC3mbEzbGEO8K7+hLIAYu6GA8z003JDAj9SuQph2VRLeCttahYpGAmWB9Uap8DboESfuBhcjcrQc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q3hZhzdi; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=zNYsMMNz; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q3hZhzdi";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="zNYsMMNz"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 305DF25401B4;
	Tue, 18 Mar 2025 13:27:26 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 18 Mar 2025 13:27:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742318846; x=1742405246; bh=n9aVZHW6JR
	SXEmwLv9JR6nRRkKD/6aMMcx++SVQX3oQ=; b=Q3hZhzdiQgAsCtm4nYMrkO+f3Q
	ghz8vZeDXVWNVohb4D9N12pd/ZX/n4pihJ0wHhkciu839Vbz0lZwHgrhw2/ejnix
	SFwQVhotAs+PlZGZRR9i9GdHKhqvPEpD+HTOD+6WpKxynojqOxsNOYvfuQhCrhhX
	zXQc4Crd98nbfX0g2Ry6dDKHuNVKAXsDDNeJKrrrR4b6yB5Ox30FCxeHTWJxCOOu
	XP1wKItJ3EHlSjmNO9SWUxgjqDxvg0pLTYp+Hil9zvP6gZ1srTQXxTYAxcqy3O/4
	ziFflH957h003khnYgZDWQ0f5caFZA7bkgAQKAcPvKNVMNrn5OWtxRy6Fm4g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742318846; x=1742405246; bh=n9aVZHW6JRSXEmwLv9JR6nRRkKD/6aMMcx+
	+SVQX3oQ=; b=zNYsMMNz6N+5YKSqU0Q5HWPH9SHO9mpl0u0Ds4fgAE3YkPANZqc
	Bnlox44FeAFwgCWqnL7Q6LoXEBn2zMfjZbX5fUaleF/yD/hBMl++RGL1IO4p583n
	GFF+hYefXjsLSw1lGx3osVT6jLApputeV4NRXutNR7RxPOU+RmenqLOY5ggCf1pK
	q/QT/RYuqzD3E0GwHTRNZhmExUzY1SWSugd7xFC68pMu5GslAAli6eEuSZOTOX1l
	Pi/FqgHAxMQ8/qlHJZnk8oZQ0EQQ0izNioSuO9rG37/ZtQNdKa75qVsbLA1b5HoB
	d0/ndYZKYIu9RMCvfgY+R2GeftCREtg+4Pw==
X-ME-Sender: <xms:_azZZ_csgu5t67-p2p0cDd9Xacr7d9niYiXHkSxxF8ncwZgmpNKK9g>
    <xme:_azZZ1MrfW8ftj6Z-aYsfz10lxqb7hHT8Sa7lTYTRftSATPyG6-hT-3hXIEtmgb-g
    ridYs9TnOJcjqUUlA>
X-ME-Received: <xmr:_azZZ4hcHM8U3ADMUT6ApzuR6Nh7Z7DCUa2Cfa_wT4CxXwltuFYVxpN2HeHGL1sdMARDeLU2dRYV9_qObpsU-UaiZCUdjJvhpYTDYfU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddugeeftdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiph
    drfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopegurghvihgusehmrghn
    uggvlhgsvghrghdrohhrghdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrg
    hilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhr
    tghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:_azZZw8CeSz3DO2EXgtlXxoWFqTew0Q1nMggZIkblAy8G0A9j6FbXw>
    <xmx:_azZZ7sed8tUU7z15k4psZUsnnEhLkDRH1QuHNOHvIbfNmFXBRC7CA>
    <xmx:_azZZ_GznqZfFQSJ4aQSl3ZL3XsccfvdfkgG_9fGd_A5ZJNQHCMRYQ>
    <xmx:_azZZyO1BtqjJXyK8Wvdqn7anZR0WpGOXueZAOD1VN6AaVN8iryhpg>
    <xmx:_qzZZ_i9wD796y2CUY8rRR6xkbz5kC95CgATwmiHRX5MLzrxTeDoiW7O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Mar 2025 13:27:25 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: David Mandelberg <david@mandelberg.org>,  David Mandelberg via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Jacob Keller
 <jacob.keller@gmail.com>
Subject: Re: [PATCH v3 2/2] completion: fix bugs with slashes in remote names
In-Reply-To: <d6945541-c106-49a2-8072-2a4e1b8903eb@gmail.com> (Phillip Wood's
	message of "Tue, 18 Mar 2025 17:02:03 +0000")
References: <pull.1901.git.git.1740901525.gitgitgadget@gmail.com>
	<1587533591c81d38977e62165784f8eb@mandelberg.org>
	<c80d20d93c92422437150084f402ac36@mandelberg.org>
	<xmqqo6y3dzno.fsf@gitster.g>
	<015b89f8-63eb-4203-8d43-47c9a6d65cda@mandelberg.org>
	<xmqq34ffdwnl.fsf@gitster.g>
	<d6945541-c106-49a2-8072-2a4e1b8903eb@gmail.com>
Date: Tue, 18 Mar 2025 10:27:24 -0700
Message-ID: <xmqq4izq45c3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 14/03/2025 23:23, Junio C Hamano wrote:
>> Entirely up to you.  I do not plan to perform an in-detail review on
>> the topic (I do not consider myself quite qualified), but others who
>> saw earlier rounds of the patch may want to say "now this is perfect"
>> or "now this is perfect with this and that changes", and if you do not
>> think the differenes between v3 and your upcoming v4 are small enough,
>> it may be more efficient to wait for a bit to collect more comments.
>
> I'm not an expert on our completion script but from a general shell
> scripting perspective this version looks fine to me.

OK, then let me see if I can squash in before merging the topic to
'next'.
