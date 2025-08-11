Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83DD6296BD4
	for <git@vger.kernel.org>; Mon, 11 Aug 2025 16:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1754928812; cv=none; b=BRoGSkysnd2hwaF4TjmtOgQ8vPqDmiR/WD9PMr6lViJG3dzkdb2vvhDnKu6dxTyoA+Pp3nv0qKEYCseVIypQvM18cnP+h8PuDLHHQiguT9O1XOWujha2OsVduM4TfLg76rC8TxIUtjWRAibvQEtP7r4JtU+ESZnYmaWcJfDzcC0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1754928812; c=relaxed/simple;
	bh=PUXMV8QSUZrtNj4WhRbQ8GJUlkMf7x7iDNPllGeuOco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=o+egAxvTi2r0Qy4/pDQB/6gqrIt2UsSAS4x1lGa7bY1/Gl8s/9aluSQCrP2K/X7Fig7NJu3VUDWJZR/i3I1UBzXuk/knC443h6SXxp5P+cq8BWjlhZJuX0j2gJUPEZXzJz2kzf+j7OmnlhVzX6MRdpknNiS3P0bjPaGxZHLkXNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AeDXGz3k; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fm/MuRwJ; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AeDXGz3k";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fm/MuRwJ"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6B1B67A0055;
	Mon, 11 Aug 2025 12:13:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Mon, 11 Aug 2025 12:13:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1754928809; x=1755015209; bh=PUXMV8QSUZ
	rtNj4WhRbQ8GJUlkMf7x7iDNPllGeuOco=; b=AeDXGz3krtQPOIaSiXtoFnfdm0
	lAzlp8OAoE9biPnQBxNiiqi8O03i4RJlaWZoIuV58E5NAdWUfufMVKiC+uQ0nTAa
	e1WEilczWf6TJmcPGi2V3Nf4zWWk+32FE6Ur00+dwX6kj3kC21v0jMJKChy8eCO0
	oTu3pt/7fGfaYlDyrgys+eeljVxk0flAEOR/s7Q746hVhdwrldnpqczl7y08GOnv
	6ZYpOBSZghuzbrqPmFHl/wTyAQAOXYRI5w6jW6bTKOZ89Tgs/9T6J29J0jn0MeCr
	c/gcY4+8IaBaeZX+gfZdylzDIVSwI/JUn/KA84xCVqfElcXUtfyHMmgKCEag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1754928809; x=1755015209; bh=PUXMV8QSUZrtNj4WhRbQ8GJUlkMf7x7iDNP
	llGeuOco=; b=Fm/MuRwJ+U4nehwJLeqt1MArX7hmbHS//zNrSM8gcfN5zX0YPmy
	Bufs2EsnZ8Su/7llzMDmZ5yIuMgsczjS2aDm8sWwLQcGhZrH4jPIDNz+WXQp2JmY
	yFLy5zW6xlp58PkM2Ws36Xiy2q71OKaFb+VpxteyELvrzv6Q5lkpffdn3Qsu5qlK
	wHywobMLYOG4P6JclCSzbjgTKWKKDMaLc5fk1Lvqz+WAOLEsrhOseHPLUieU55zY
	55SMwO01aD0WYkv8FqJjgvl2YqDXIw0vmwFQXqLNQcyqscEsWsq/aasAPm+e8LpP
	5YQmotGwwjP4Bx5X6Y/NCIfabAF09lPyOIA==
X-ME-Sender: <xms:qRaaaPgiZrcF2L7Q5bFdCcKKJWOQQZ0D0tpfkQuoBj2_izJX3WsRGQ>
    <xme:qRaaaEcOS2-zi6PVts0A_Ab7ZykvhpZtSOmfdmShNa22j9SbUhKZgCUZj2Mwoqmni
    X5wHT_QjU6t_VnUwA>
X-ME-Received: <xmr:qRaaaPhNKnHIh12BKx7wz6AcnTJC4rDsZXZU4fDKw4PSKxCdS1Ns1SLmweiXPBI9620vtawzw0OUPcr4ezCCdCR2IRfOTR7_i3TWquY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgddufedvledtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopegrhihurdgthhgrnhguvghkrghrsehgmhgrihhlrdgtohhm
    pdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehs
    hhihrghmthhhrghkkhgrrhdttddusehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhith
    hsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qRaaaMzRJYh1oclco2L75ciNX9JvLw9izqIDQrtbV9zNKXjkzaBNDQ>
    <xmx:qRaaaLO619F0zT8nwCatqQwGBeajQQ_CylLVm4hVV5r8usCkWb3Oiw>
    <xmx:qRaaaNXGo49AyN5bOwJAb-MpEnib_UOE5c8ash6DnpNKZkGQKUcoqw>
    <xmx:qRaaaP0KiU6k5W2Iizx4kqUes7Hx1_pun7RnIvXmx5QxT4PutzNCqA>
    <xmx:qRaaaKHssocTu4fYzFh548Jf6PptNUNWwM9t1X1KFDpkA513f8_f69AW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 11 Aug 2025 12:13:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ayush Chandekar <ayu.chandekar@gmail.com>,  christian.couder@gmail.com,
  git@vger.kernel.org,  shyamthakkar001@gmail.com
Subject: Re: [GSOC PATCH v2 1/2] environment: remove the global variable
 'merge_log_config'
In-Reply-To: <076c19ae-58fc-4823-9679-1d5fe6e46211@gmail.com> (Phillip Wood's
	message of "Mon, 11 Aug 2025 15:42:48 +0100")
References: <cover.1754868681.git.ayu.chandekar@gmail.com>
	<3aa014ed46d14e31ea0c2f6b7631e7e4cbbd3943.1754868681.git.ayu.chandekar@gmail.com>
	<076c19ae-58fc-4823-9679-1d5fe6e46211@gmail.com>
Date: Mon, 11 Aug 2025 09:13:27 -0700
Message-ID: <xmqqikit3kgo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> Hi Ayush
>
> On 11/08/2025 00:45, Ayush Chandekar wrote:
>> The global variable 'merge_log_config', set via the "merge.log" or
>> "merge.summary" settings, is only used in 'cmd_fmt_merge_msg()' and
>> 'cmd_merge()' to adjust the 'shortlog_len' variable.
>> Remove 'merge_log_config' globally and localize it in
>> 'cmd_fmt_merge_msg()' and 'cmd_merge()'. Set its value by passing it in
>> 'fmt_merge_msg_config()' by passing its pointer to the function via the
>> callback parameter.
>
> This looks like a good solution

When fmt_merge_msg_config() needs to read more stuff, the callback
parameter may have to be updated, but this will do for now.

Thanks.
