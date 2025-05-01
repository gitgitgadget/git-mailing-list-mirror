Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5C333F6
	for <git@vger.kernel.org>; Thu,  1 May 2025 16:31:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746117122; cv=none; b=puw+edbp9tVF8weOJ6FpwnxFIgyZT5vT33oAdVN0vKDujhmDKaYF/IAU9c/u/J4K9TSF6pIkctvs+Sm8yoSMlIfed0ysLVQ3gwXGc40JKWBp33jkdmIn1rKPkhv9vx6i0Gmkz+XV+pa5y8jkdYpp6BtLwamdkol2vPieJGgxBkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746117122; c=relaxed/simple;
	bh=4l569yMJva+7JzCjVN+d2iPSmokmnzxLl8yZv/wzIfw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iZfxT7dDFBKMbp+JYwnvyUtrww7L4x1F0rX6eaWryqe6taBUo89545p5idpd3HC2bygy5ggMdXoGmWeuyi5iquqKiwpaTLMZo4wwd5Uai84Rg3UVCxXvZis0ydIeBe8xHLOp5iCVYD7H5YFp/KdIdNU+tqkIk9Qx0wPgyEDuLbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=b+i8A85+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Wn/mcv5s; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="b+i8A85+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Wn/mcv5s"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id D3188114013D;
	Thu,  1 May 2025 12:31:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Thu, 01 May 2025 12:31:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1746117118;
	 x=1746203518; bh=JifzlNp3THkJc9jHi7+jp55iYtXGostaNwLWYH39LBw=; b=
	b+i8A85+RhFboggwa2O8FBfwV3w58+zjtFOlh8bev26NEvUnRuxHByCchpi/NVw3
	EU6eHnCa1ST3/Hl/2g5DhqBn70YoAP4ILJ4SAO0ElqzCfnZPjqloSuKUXEoc2JwQ
	1fke1JnvvOh6ZANLKcNyHi2YnAkeDYjSd0Pjb1JeRdJ7q5OjYsvhc58oM77VQAiV
	MoFnQfjX31vlIIcBLkR+23oWxMr5NMszvZxam4PbgH0HBy4JYJkuWep9f31iUUwE
	KZzXMkwvD6wu8m5Kj69PhckY8AhqiZX0OM/6mAe8SucisVS4Gwa0L3I9Xpj+/Q3+
	eU/tmysLa33UjH4pYm74xA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1746117118; x=
	1746203518; bh=JifzlNp3THkJc9jHi7+jp55iYtXGostaNwLWYH39LBw=; b=W
	n/mcv5sz0B6lcOay7fdrHener1j9WZljDcMJnGMG9kuCaYUL03iUWm6L/veLBIX/
	iUh+s6YQR3fNjWSOxjO6It3PHGDlJY9pUM7iauFFSjXiG5oKX85YxU5apBfW5eg+
	CpXjueMQleDkmZGUjuGmhKkzcP4aV1C4jTJL6CzM3FprYkfD/cmuPBuFeHESTtVy
	hM4caGlyHOW6CMtz8cXg8rIPnbZx2Kk5WluuknLZPR4ZLMsgRZgKotXBCQOnbhEy
	Ypgixbqf1uU+MtoTr8MbIU1W/XmdFQgu9DfmR5VNRUndXChFQritnfkICc8ODn/k
	smhqf5+hA1pfLXkf5AUmg==
X-ME-Sender: <xms:_qETaLFj4JzQnRKA-BseEvxpj8fdA3sOLV135MbKNlaWdZ9qWmzkSw>
    <xme:_qETaIWUPRJtY6LVfXKPw8dVe3djTBOtnzKOJttFToVyrv9tJokUqEplU9WrnvTJd
    7WvfV9QyG7s_j-Xcw>
X-ME-Received: <xmr:_qETaNISpE_YYR8mdEMNJV-T3jpUMqfr9WvyLYdVBRl3vQOivYIl2B5DXd0hdD45CJZce1dKdqpc83TvW76idtApyrhTRGowJUbE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvjedttdeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkefotddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeekgfdtuedvjeffgfehueefueeghfdt
    jefhgfekhffhteeiffetheelhedtgfehtdenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeejpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehkrhhishhtoh
    hffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehj
    rghsohhnuddutghhohgtrgesphhrohhtohhnrdhmvgdprhgtphhtthhopehgihhtsehvgh
    gvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheprggtlhhophhtvgesghhmrghilhdr
    tghomhdprhgtphhtthhopehrhhhoughgvghssegtihhstghordgtohhmpdhrtghpthhtoh
    eprhhphhhoughgvghssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhsthgvrhes
    phhosghogidrtghomh
X-ME-Proxy: <xmx:_qETaJEbQAymD-Qb4_p0DV0GBwHnid8VNM9ZH0rgvIt4klwt423loQ>
    <xmx:_qETaBXH_zNUtaOJpR4JleU1VVCFK2tR7UP4777r5vkzoIUdP_CV2A>
    <xmx:_qETaEM-By-AcmGBPWQUcVdhLD85TheGHkgQdTyOGUafw_NQRsNBVw>
    <xmx:_qETaA1GZ3olVM5pTJDbZsrmjeQ4F3SDBHveKlqW_kEY2Ca2tFujKw>
    <xmx:_qETaDXUWkCdz-Pyk3rftg9qvwqjDJX0ECy6kcYQbAIdx0cE0gjliHJe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 May 2025 12:31:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com>
Cc: "Jason Cho" <jason11choca@proton.me>,  "git@vger.kernel.org"
 <git@vger.kernel.org>,  "aclopte@gmail.com" <aclopte@gmail.com>,
  "rhodges@cisco.com" <rhodges@cisco.com>,  "rphodges@gmail.com"
 <rphodges@gmail.com>
Subject: Re: [PATCH v3] apply: --intent-to-add should imply --index
In-Reply-To: <8a61dc13-0b7e-437d-b060-c17bff483c7a@app.fastmail.com>
	(Kristoffer Haugsbakk's message of "Thu, 01 May 2025 14:48:11 +0200")
References: <93yuUC_Wn9lQIDzJuvAWbCQ35kz1YxeNhsLLX67x9VzoPtRugVLNaHC_p1sWBzMxWy_VVRRl8av3Dx5PHw4_Cch0gmWs40DDrZRaezLVkGk=@proton.me>
	<8a61dc13-0b7e-437d-b060-c17bff483c7a@app.fastmail.com>
Date: Thu, 01 May 2025 09:31:56 -0700
Message-ID: <xmqqmsbwxpfn.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Kristoffer Haugsbakk" <kristofferhaugsbakk@fastmail.com> writes:

>> Johannes Altmanninger submitted patch v3 titled "apply: --intent-to-add
>> should imply --index" to fix this issue.
>>
>> Is this fix merged? If so, which Git version includes this fix.
>
> I can’t find any commits by Johannes Altmanninger that addresses this.
> I also can’t find any commits that start with `apply: --intent-to-add`.

The documentation says this:

    --intent-to-add::
            When applying the patch only to the working tree, mark new
            files to be added to the index later (see `--intent-to-add`
            option in linkgit:git-add[1]). This option is ignored unless
            running in a Git repository and `--index` is not specified.
            Note that `--index` could be implied by other options such
            as `--cached` or `--3way`.

It is clear that whoever wrote it understands that for this option
to be effective, the patch needs to affect the index, and one way to
do so is for the user to pass `--index`.  But at the same time, that
is not the only option that makes the command touch the index (e.g.,
`--cached` does, too), and it would make it behave incorrectly if a
patch automatically pretends that `--index` was given when this
option was given.

I can't find the patch either, but given the above documentation, is
it even still relevant?

Thanks.

