Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7263F20E6
	for <git@vger.kernel.org>; Fri,  9 May 2025 01:03:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746752614; cv=none; b=hUMGPoaS8UATEmEF2UBAf+QcsiuF40wuhZ3u5ZrgNHA0QChyIrRlgUk5VxxzqxI51dJtsQCNlqAitj59u0S/xTdQr7pYocjlQkRDNWPOO35hgUVkhxn8wCq06g0PoBjVJIUdCg9g9LHA/nwgLGIIQdbt30hZuEmq/Tnqu9cso6U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746752614; c=relaxed/simple;
	bh=gfmm8Ic6sCo85f4YZJng4WuXDFjxdz16Tx3KJC+N1V4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JOtznANAKYiAEhctwaxJqgTGIy28vo+Jw2JDbwtXeLGycKvrSMC6ossjvaTKZ0N9QQ+ek2qy7fuIHgnRaTdKjLRq3zslFEh5iMtUPsS3abKGt8V/ai+qGaE23p340OJoHDE9vte7JkuIRkY4ovBd95QxLQy9hs+YJE3KNvbpd7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d2uHRk6r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=PQ9ix18w; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d2uHRk6r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="PQ9ix18w"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 3260413801F2;
	Thu,  8 May 2025 21:03:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Thu, 08 May 2025 21:03:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746752610; x=1746839010; bh=ntHXkxNfQe
	t9IxMC+zPK4lYva/PdF7yKeFriyhZyq00=; b=d2uHRk6ryq4hSfupAz8veckFHy
	udVsjDcKoyrl7FFgmN62djhy66KH0WeOhhdCAwD/lTf2yvDb5jxn5VVchT2GnFhe
	Ez/HnLyMoDwJNOuHOr3IsCYQxEYzvSD+OuUSfSVTiqb9Kg98VgM5BwZKpnJDhBtG
	hOpaywZ3sYcprtknn57qBR5xvQEsxU+HxMSKhA2jri/5Wik0X//ozNNx6YPtM6wf
	1bHisiKLh6VQ9t6twAkytgjr7OSJl1byCGOYbiTxYmwhnvfGrV79Cvm4Ui0ag7ZS
	QAD4CK+kjmbs0Ko/h91dBTq9OnLhqzXXcpmxV1hvT4IdcsjnyHVdTs0Gx9Hg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746752610; x=1746839010; bh=ntHXkxNfQet9IxMC+zPK4lYva/PdF7yKeFr
	iyhZyq00=; b=PQ9ix18wfUjUdQUWhJFlc+N0kVdRzfYdVegpSaNo95qqlbn6eKt
	ZrPSd+3KyAoPkYRPayqVzoxZLzH64PRfY9z9ql8fDpHLjby24lbXo+rlXxj0/Exq
	fOFpvLn4uGubOTYz2o0GMMXsPiDgDNsXZyi0TjPDcXqITlRqrwXaJrQDm3oQ20yU
	NCzSPDww+W053EJBfyDDggzwcSfqUaatW7T3tysC4xEq+RDsR/VqfJinR/g2Fp0Q
	LNfC725jJSsboSrbsn1WLnEsqegWJ+2ZNFYXHuZ0DgMlnz/XDBh50+nyvcGObUiw
	i3iaAMNPv6eEX4EDCFGJ/5Sc+oWSnJvCIaw==
X-ME-Sender: <xms:YVQdaPLKsorkZQc5k-HHIhXLare6AN4wC2j7SYZs-fAu7zv1sRN-Zw>
    <xme:YVQdaDLxg-utCLCAAyZ0yAoU1ODIiS5L_tFP56R9fYMIxg52Pxwqudz0J88kyJwhN
    Xf-nzcSJqgvhGKBFA>
X-ME-Received: <xmr:YVQdaHv2WH9smst73tUcopRHvEptc4PMa7VLxva18_oIH8rrH8vfDYLJNC8fK0yp4M1xZTICZgzboz8x7PSon-g0pmWxVKhC8TCd>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleduvdehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepvghstghhfigrrh
    htiiesghgvnhhtohhordhorhhgpdhrtghpthhtoheprhgrmhhsrgihsehrrghmshgrhihj
    ohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvg
    hlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopegtohhnghgu
    rghnhhhqgiesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsoh
    igrdgtohhm
X-ME-Proxy: <xmx:YVQdaIbgmk5ImTmWbHzKVhrYjV1G8PlVrM3GNpsBbkErP7xw32cf7w>
    <xmx:YVQdaGbBdQnQSOxhhRs7N4SMZlCbVPu7qofl8drQAYNRaLuXnA0kjA>
    <xmx:YVQdaMCY0xGpAwVo45fKXYPeQnO4zoQV1IfW59u1pSUbu8acsZ299Q>
    <xmx:YVQdaEYb8nX25rUgNK43vKbedXuoRaEeYU4dQE7uftPo5arNbbAisg>
    <xmx:YlQdaCE0DSpLy8CXRfwgfv--SadzmogNScf64_OvUR70KmzUZU80cfz0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 8 May 2025 21:03:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Eli Schwartz <eschwartz@gentoo.org>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  GIT Mailing-list
 <git@vger.kernel.org>,  Patrick Steinhardt <ps@pks.im>,  =?utf-8?B?xJBv?=
 =?utf-8?B?w6BuIFRy4bqnbiBDw7RuZw==?=
 Danh <congdanhqx@gmail.com>
Subject: Re: [PATCH 3/5] meson: correct path to system config/attribute files
In-Reply-To: <5a91094a-08d5-4bf8-a4c3-1d54cc970f67@gentoo.org> (Eli Schwartz's
	message of "Thu, 8 May 2025 18:50:59 -0400")
References: <20250508164443.1506440-1-ramsay@ramsayjones.plus.com>
	<20250508164443.1506440-2-ramsay@ramsayjones.plus.com>
	<20250508164443.1506440-3-ramsay@ramsayjones.plus.com>
	<20250508164443.1506440-4-ramsay@ramsayjones.plus.com>
	<xmqqr00y4vvd.fsf@gitster.g>
	<5a91094a-08d5-4bf8-a4c3-1d54cc970f67@gentoo.org>
Date: Thu, 08 May 2025 18:03:27 -0700
Message-ID: <xmqqcyci4mu8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Eli Schwartz <eschwartz@gentoo.org> writes:

> Meson guarantees that arrays of strings e.g.
>
> libgit_c_args = [
>     '-Dfoo=string containing the $ (mighty dollar)',
>     '-Dbar=string containing the ` soft-deprecated',
>     '-Doopsies=string containing the \' (you read that right)',
> ]
>
>
> are passed to the shell in a manner suitable for reinterpretation as an
> argv array,...

Very nice.  Just I wanted to hear from a system that we are trying
to adopt and promote ;-)

