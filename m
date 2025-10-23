Received: from fout-b7-smtp.messagingengine.com (fout-b7-smtp.messagingengine.com [202.12.124.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D53A2036ED
	for <git@vger.kernel.org>; Thu, 23 Oct 2025 18:47:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761245256; cv=none; b=XomCQfQ+qXR6/aYnfEBapzzQQrZqmR43jELsxUuKGyKTqaX3ItpUvjew9ZQsTEXodTocPhl3AHYhodvDeAQwVmyTDILD1DFONNH5JbKzcRWR7M8kVchbakkxcPWCH/Ej1tgo+ShLx/FBXBmtxn4y6f7Xszc6hGO5gTLUxZr45MI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761245256; c=relaxed/simple;
	bh=C4KCLYD6ZDNCjDxtakl9RjoNVxw9/qppgcTrBQd6ESU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BGJoXS7zN1xVy3d0Pq10Xp49oIlcPaMhSO0SAKR3so5BdlsE8wI5h3SJoUkkQMJjcEOpv9XQGBNxW9jJBQGitNiGL+3tEtIb+IT2riu8aqkIQZ/QzDhI9IhULxKyuVneqHBnKxzqcG5z1uzLr/Zpi0Y4I7Pumtaxr1WNos2cULw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NlUrYCX4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Vgys8vsT; arc=none smtp.client-ip=202.12.124.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NlUrYCX4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Vgys8vsT"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 49A711D00120;
	Thu, 23 Oct 2025 14:47:33 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-10.internal (MEProxy); Thu, 23 Oct 2025 14:47:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761245253; x=1761331653; bh=C4KCLYD6ZD
	NCjDxtakl9RjoNVxw9/qppgcTrBQd6ESU=; b=NlUrYCX4aoj4/ZiZXx6HtjLZhM
	BVj+vOoBgX029mD0dF7Iq8HZtw7aOeGWmvduBHDJWYoXtEV1P2sCxDSkPolybT8f
	uoBOY94f0bFvbDknb4Csq2oYWVJmmfJTH6JiLo9RHhlu5xPzUDgSTU0I7DnEiYL4
	NxuAxxf80GIse9MO/HCfq3igKxFArrU0Ha2HGAUfT88rA8PdyxrgtJ5BBo8UkyAa
	wmCD2uBtgQLzspqkFvVB+YfcbgaHoYriKzGDwCRg+vr1nP6x5wGdvc6acQqJu/q6
	IeLOii7lyLPTvkdgM9R/muu0aR4pUDWmM3uar7Wt4W1xP3+9EkAXTXIzFWCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761245253; x=1761331653; bh=C4KCLYD6ZDNCjDxtakl9RjoNVxw9/qppgcT
	rBQd6ESU=; b=Vgys8vsTCtCn4WXzOTqpgl+h5V6abeEzsp1OJCEVq1ogTfmzQVy
	5d6NdvI+humgDeG814ppz1VLUvZo/O58h2sUmYNGkZKJ/bK5zU86VbKV9YPMgv2N
	WajGfwxZv8QTf0zuSRW8Udq0ElKQFjdMBKypLB4vUzejbbxN6jqW6Fg+64YGhEVm
	T9AUVDmOMYlqpZiu2JRks0OA9Q5u4euWl6xU9UMvEXsCjfuvp6340yY5FN/iAiSb
	VJoUZH6eHolI5S+V1webNTRIv5Fiv9WGQHatOArFbOth7sSm/bhqV0RIkML9Z19z
	V7k6T8BcFxu17QL61UQLyKqO6l8KxtMeT6A==
X-ME-Sender: <xms:Q3j6aFV3GPYEvL_0RLOMOi1xb2-0vRHN1iXJz5KhjyUJPnhwORK6mA>
    <xme:Q3j6aP9BMgNBYCEar7JQYjJ5oEqMLFDIeGQY5P_V_N0dPKNMPI_HaWWGw4A-2onvP
    OBXqcWm-MWsh_wu3RvB0B_BKto9IeZJCXUvZtkReI1u9D-IisgBzg>
X-ME-Received: <xmr:Q3j6aHjTiymXk5r4xHS6MMbJVfNDXB89V-wLaRQ37sYuwfWJbTXIXw7x_5hCbblxU7eELBpTpgPf8z3jSvVLY6jzxMPYp2o-65j_>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeejvddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepudehpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgt
    phhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdprhgtph
    htthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhopehpshesphhkshdr
    ihhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtph
    htthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
X-ME-Proxy: <xmx:Q3j6aDf-jW7jHjKg2toYPBJxxJQlwhOI-u7Wi1wwtTkrmqHXGAUOnA>
    <xmx:Q3j6aIKsuUXagWQp_Yf2pRYjoCdOncFP93ctUGAVwG22NX5gTzXJdw>
    <xmx:Q3j6aImyjXipWfa-wS4OCg9Sye9ifD4q-okQt0f_KuA9Et839Td8Zw>
    <xmx:Q3j6aIeK62cJWUqr94jGeKZ_A8aytco9xNNxV943ZNg8P0FWXxUyIA>
    <xmx:RXj6aIC7_mAljijTw38zbOZv1PWSOKtcVbhJWhCdVwe4-vpgz6sB3WLU>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 23 Oct 2025 14:47:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddharth Asthana <siddharthasthana31@gmail.com>
Cc: git@vger.kernel.org,  christian.couder@gmail.com,
  phillip.wood123@gmail.com,  phillip.wood@dunelm.org.uk,
  newren@gmail.com,  ps@pks.im,  karthik.188@gmail.com,
  code@khaugsbakk.name,  rybak.a.v@gmail.com,  jltobler@gmail.com,
  toon@iotcl.com,  johncai86@gmail.com,  johannes.schindelin@gmx.de
Subject: Re: [PATCH v4 0/3] replay: make atomic ref updates the default
In-Reply-To: <20251022185045.29256-1-siddharthasthana31@gmail.com> (Siddharth
	Asthana's message of "Thu, 23 Oct 2025 00:20:42 +0530")
References: <20251013183311.33329-1-siddharthasthana31@gmail.com>
	<20251022185045.29256-1-siddharthasthana31@gmail.com>
Date: Thu, 23 Oct 2025 11:47:30 -0700
Message-ID: <xmqq7bwlv4jh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddharth Asthana <siddharthasthana31@gmail.com> writes:

> This is v4 of the git-replay atomic updates series.
>
> Based on feedback from v3, this version improves the naming and
> implementation for clarity and type safety. Thanks to Junio, Christian,
> Elijah, Phillip, Patrick, and Karthik for the detailed reviews.
>
> ## Changes in v4
>
> **Renamed --update-refs to --ref-action**
>
> Junio pointed out that "--update-refs=print" is semantically awkward.
> Answering "print" to the question "update refs?" doesn't make sense.
> The actual question is "what action should we take on the refs?"
>
> Changed to --ref-action=(update|print) where both values are verbs that
> answer "what action?". This makes the interface clearer.
>
> **Aligned config name with command-line option**
>
> Changed replay.defaultAction to replay.refAction. The config variable
> now mirrors the option name, making the relationship obvious.
>
> **Unified config and command-line values**

I didn't see anything glaringly wrong in this round, even though I
picked a couple of small nits in one patch, so we might want a
hopefully small and final reroll before marking the topic for
'next'.

Is everybody else happy with this iteration otherwise?

Thanks.
