Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2EE3117A2F6
	for <git@vger.kernel.org>; Wed,  3 Sep 2025 18:46:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756925182; cv=none; b=fTRp6PTlg0Cgz9IfXua8afHThn9gh7D7+HqSdTOUcd3276oW7ltYqrUgmW08m9su/1VHfCI8Imbqu/iT2OiEQkhe3Rz0zlpL2wAU2+ptNO642X9VatuU0UbLIBpjKjmEdt6ZFtXZWJKowQCIQuel2pN5cocpmzudesca2KEIX58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756925182; c=relaxed/simple;
	bh=dcITxY0r89ihAG9FS/krJMGKIEX3MECzimjmf3XEWIw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=i4tL/C1sm7KEWF39dJFygKl76b+PmjHQxyXf6DTI92yR+IFs+BslqFpOpOtmEv5GBiCGFMKza+a6gCe2pGVXqsSQFqx86WaHbNq0lNrEmvKaKe5L3QYHpfiokVhUc3HBpP7Tk1IdkGbfPcEHWlhOOYgdTz5hq4FkMqUXIFg7x3w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=j04nu4C1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=RcTgrrlu; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="j04nu4C1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="RcTgrrlu"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 4441BEC028B;
	Wed,  3 Sep 2025 14:46:20 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 03 Sep 2025 14:46:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756925180; x=1757011580; bh=QWAnioCypY
	VwkSEfxDaxu7IKbtTJUoeAa4s3u2d5yOA=; b=j04nu4C1TjBzMO1yg7jW9WU/aw
	QXJsbPyZ02erf7WiOXxn7cFgnOBTkW+J5es+XYk0gvmx0ycOzgpTvwbwAGsGUIqA
	vznhdkJp4nRRY+K7WdWCm7H7tSdXmdjkZVS6k/+KwhK0YEXX6WEGT+ju+Mbo2kEA
	9dvIhQRLyI5dTjHYrGqJI9uEx2srBsa03suoC1QRPviJ3D5doXP4Yji6jxUUqxyG
	jcxwJOJpp44otQYMH6BD5Hos3SRiO2JMZP8ie3+QYRHwNwLHPaM61Gp2Kaeeg/7P
	ARFWqC1H/FQvJxHMuHbBCfSPudOPue2Nol/2qLb/+09RzMc/k5Y/5WpE0PnA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756925180; x=1757011580; bh=QWAnioCypYVwkSEfxDaxu7IKbtTJUoeAa4s
	3u2d5yOA=; b=RcTgrrluflZqhmSSbHcJ+kOeHQjabmb1QdMuaBVq9rm6Ih1gnWV
	6zgCEYxcimxonFYnLmdiHmnsE8P9OM7jPLceYIQaRJbCWYU5aoNi1iXLTtpy3eNq
	4BcjAZeNRfMwnFCOAFwAyWeBZBkptLq7H+KzEHQxRGRZxpFE4TQRXsrz9CIL+UDj
	xHjoGjKTcAfHx4t5ankJpZUpHsuLf1L4FT4P3zl4DcumiPeZw2Ury2ywGs97rra9
	pgjsZqm6hRqMZxakv07zLTc3omOiTAPxiOq1GpIKqojcgfB+CIEx4HU7IJKVW3YP
	ygOupNbc9XL1V4CO/GtKW89XXP62FwtxNTw==
X-ME-Sender: <xms:-4y4aKlrNqTbxINwr5ogniIJ_8n1gqaV5paB_VhnclDcaa8NlQ012Q>
    <xme:-4y4aMa6mwtrolRrvJ09RgoicgIrWZh03Blt-YCI1OBNYGY2vInkfzBwiiUd6h05J
    00uiFM_GDo2KuKefA>
X-ME-Received: <xmr:-4y4aFN4xJZVF-eqyoLFpz-G600JFtyqtCmFmkUZV-V1wvwSvqtRxgc_sldBwMdUVZl7GzYvIwiPNlZcGZiP48ZjRt-tiZuyYSxqhSg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefledtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepthhoohhnsehiohhttghlrdgtohhmpdhrtghpthhtohepph
    hssehpkhhsrdhimhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:-4y4aBYDh0kjJEuvOPnHOtJi6Tu_ZyXECON7x9hu6rWA8Dkf6m1UtA>
    <xmx:-4y4aD1iINbFkxifLyvRdJr-b74wCcZEXbDb12aqZVLDFT8OoCWenQ>
    <xmx:-4y4aHe1M0L7dyLL7HNOPyxY_1YmOYKeQmndHddBhM0iFrteCVX9Zw>
    <xmx:-4y4aEEU7jtmdbA-mpcFcdA2yETnxoyST-QI4Ka0iD5I6lEMGeKdSg>
    <xmx:_Iy4aHeYhk3p5ApQXEP022zjdc_YLDphbPdZL8eBCg6n9wf_8MaDqIao>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 3 Sep 2025 14:46:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Toon Claes <toon@iotcl.com>
Cc: Patrick Steinhardt <ps@pks.im>,  git@vger.kernel.org
Subject: Re: [PATCH v2 2/2] t0450: add allowlist for builtins with missing
 .adoc
In-Reply-To: <87bjnrg4ky.fsf@iotcl.com> (Toon Claes's message of "Wed, 03 Sep
	2025 13:26:05 +0200")
References: <20250804073002.1586332-1-toon@iotcl.com>
	<20250808095943.3312265-3-toon@iotcl.com> <xmqq7bzdfoxe.fsf@gitster.g>
	<aJs5D2jPh8Uom96p@pks.im> <xmqq8qj3rqgn.fsf@gitster.g>
	<xmqq5xe0incd.fsf@gitster.g> <87bjnrg4ky.fsf@iotcl.com>
Date: Wed, 03 Sep 2025 11:46:17 -0700
Message-ID: <xmqq1ponfk7a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Toon Claes <toon@iotcl.com> writes:

> --text follows this line--
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Toon, did you have a chance to take a look at Patrick's update?  Can
>> we move forward by squashing it into your [2/2]?
>
> Hi Junio,
>
> Yes, I've reviewed the changes, and they look good to me. I like the
> code more than the /clever/ approach I was attempting. My code succeeded
> on my machine, but it didn't on CI (sorry, I only saw that too late, I
> was rushing into my time off).
>
> Thanks both!

OK, then let me squash that into the base patch and mark the topic
for 'next'.

Thanks.
