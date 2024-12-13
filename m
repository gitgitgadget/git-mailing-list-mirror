Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C113E1DFE33
	for <git@vger.kernel.org>; Fri, 13 Dec 2024 14:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734101299; cv=none; b=hlusSGtj4Ew/9WZuoThkSO94kAzsNpP3EOcd154Hm5ocfYgzZTvvffudmO/jrW3JLiIul//xdFITUJC+K8N3rY25Oqj4t46geSs9HWwD7QOmEd08F24NA4ioGfwmX53hN+hRv5EJeqqQEU7noVWvDgtjpGN8DHvQWgxcAu8v7N0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734101299; c=relaxed/simple;
	bh=23pPRFpV2b2AfnX4lPzLcYdeUYMBOXIGoFVisFh+M7Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=oqjVxxhNKDIsup+jx4UxiJn2co212iA01e88I2C6l3wybp1EYepaW3JhhFgGNkRQqfIC3OLD5VgYQSHPbJOWK6IyWhBci/Odxbza2hCW0vymG/cRqyiMK6wkSCM0E4NhP9+cvYNXQfRNdNrlY5RY0+WDe8qH8yYKDVYBxvblmsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lBTXb1Hx; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wfhb6YYu; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lBTXb1Hx";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wfhb6YYu"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id CDE4F1140066;
	Fri, 13 Dec 2024 09:48:16 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 13 Dec 2024 09:48:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734101296; x=1734187696; bh=gMqMylM+Kc
	scrfoaV03tzq2MUWjfDouMzWc5uXyv/I4=; b=lBTXb1Hx+zmNTtJP0DBntk783Y
	bq2oUYWXCBATgHbdR42Mm00R7c2XS3xsU0192HJVj6gPOPzT0jVdvcSc3/J7bQRe
	fTitkulpfxo0Cmir+BJhHGcLsEiadE//kvA7MtTpgZ/qfbJDRp1tVoKGhFdBU2vK
	i0FtESS81BAIgIvHKazVLsofzcKGbAYY5vtIEL0DdCsRgXSE5fNOk9ekgRZx6COI
	X/czOzUk2eGv4pLhRgeix9dPBkJzc/Pbn5VNqanLCkbFs6W3EW8cEjsG3uipEr/H
	RIyuxfnzIkAVN/WGb6s7yjoF/pYXvKYi120iR+IzmswY4Eyu8eKyJdroKhHA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734101296; x=1734187696; bh=gMqMylM+KcscrfoaV03tzq2MUWjfDouMzWc
	5uXyv/I4=; b=wfhb6YYuO+YR6M1J3yyt9Dzp/bs39Zy2OfN+BSAKHXaP+IsnVqU
	P+gr/vzFjwGYA8kDkrfV1ddIzFDdQWqjPOwau4vITXoMa48l0rEaXGUUoQ/Lo9bq
	7vcffUNfEUdymi4rOf+kObhCvLYl5G+2raBN8ifG0YTX+gUwBHmIrRi+JeTmGrm/
	NnrcZPdXK491LAUYxfBBYV+N6P05udMbW7tKWr6JUsz/sxivXDgS58LHm8zl7rtJ
	tKAx6aDQ7FQ2l+Pf8rxy2Tb0eAhCsebwiylwY4ZXO13gWfc1ooN/gm8VG2IU1TTP
	xsZHE5m0nGza3GIpJqnLsjQhVNYGQvbuK8Q==
X-ME-Sender: <xms:MElcZ2Yr5Pi7XOfIJqg0qVu5hmGJx6DfGNTw8hiS338ujIj47QnmDg>
    <xme:MElcZ5Y6IrbPT0m-Z13W_2wCl8O56UKXkzeo05EbgxVSTud13B4zyfThiF9Z7kVn9
    SMKVpJFYzGqP8hghw>
X-ME-Received: <xmr:MElcZw8O3lpNq4cZYuL8Uc5-CbNxU2IHk_Ed7fJzAbd8y7aYABYsRv0LwOWbhLdqSQtKAYc8nSEubwjIkxQ20LvAFB-nd_0s1s2AEA0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrkeejgdeijecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecu
    hfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrd
    gtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeel
    ueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmh
    epmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphht
    thhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegthhhrihhsthhirghnrd
    gtohhuuggvrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:MElcZ4ri5G1snUhKyweJmetZx1qkCjMk1RoMb8WFv_cGN8otNXyP5g>
    <xmx:MElcZxo1eC0kUkMMvUyVyGJO5QUl1RocJtWeQxjKfZGWINWKt8WkWw>
    <xmx:MElcZ2SUwlwUpM1pHsV4jOcrBztvv9r8cAqioPbuI5JcHVuzKj4Uqg>
    <xmx:MElcZxqY-EaXgcU68bG7nADfOJtCIHYPDeWx0qAUJMhwCXgulqiQrA>
    <xmx:MElcZ4WiW0PtED2TrFVbNFPcn0YfSmbGTTy21SeJYPdNuUsc5cVQrU0N>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Dec 2024 09:48:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Christian Couder <christian.couder@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Dec 2024, #05; Thu, 12)
In-Reply-To: <CAP8UFD0mizHEAjW6A86-Ndp-h2RySQU+18oL-5fG9Ni_S70ycw@mail.gmail.com>
	(Christian Couder's message of "Fri, 13 Dec 2024 15:40:57 +0100")
References: <xmqq8qslf5h1.fsf@gitster.g>
	<CAP8UFD0mizHEAjW6A86-Ndp-h2RySQU+18oL-5fG9Ni_S70ycw@mail.gmail.com>
Date: Fri, 13 Dec 2024 06:48:14 -0800
Message-ID: <xmqqfrmrbpw1.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Christian Couder <christian.couder@gmail.com> writes:

> A few typo fix suggestions:

Thanks.  Very much appreciated.
