Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C96BB282F25
	for <git@vger.kernel.org>; Mon,  2 Mar 2026 22:11:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772489498; cv=none; b=MZPlStoav2FnmAzGR7FftJZkDDKdN47opgbP0AFPbWi55F3afJuZcT1JSuPeBKWW96FjEkowm1G+x86rEw6xopiD//k1W3ieZJlUtuOE3Yj3LjvDcn1p6tpiPRWoWEnuCZW5hv7Ap3qbjOy55+blxchctM+Q44O0wZUMEX+GZts=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772489498; c=relaxed/simple;
	bh=ZbyaCuYcs5o+5ZQi1wALc8Frw/KdH1ipRCvO5rP+ccY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=efmQhGrZQYbYfKe5M68NADNfyhk4GKt3dOpJUOCF+9Jq7h9NWzA2Rw0xdJIZQ/Rj2I7+iimU3HIR7LlhqTk7tyzYQX+u7Xgt2QCVU2QwOZHZL9CEv+YOP6xc2+4rs++wF4codEIxLp3sXkjAelZmYROPYB5aCsLIVIeuu6oIpn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=jHp/MQgS; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TDePwid1; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="jHp/MQgS";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TDePwid1"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 1A1BAEC0350;
	Mon,  2 Mar 2026 17:11:37 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 02 Mar 2026 17:11:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772489497; x=1772575897; bh=+856K2TcNW
	HeCwHOOW424DsI2V2c++BqDXCEvVNLL7k=; b=jHp/MQgSNwD0rsTZ4TIWbH+74y
	gm0rDFHa0OEZZvagK8t30UM6ysBnKXc0nWY3i/jKTJDl0otY5JjmFSbZdwGDGd3e
	m4Fsi6GNjYvX2FVnrpme7LIkk2V/8O/gSGM+4ozIXFIJw9RPYSBK+tjx349odg2q
	4D0He0OFDjDqxIIU66HSZBJzgwFp5ejTQeQ0i3fA1Z1sX3WjUOq6cv7QZewuMUNW
	3ARUpmVvOH77YEkSK1JBgWiYCJiF86+5ujgEqMr5PvfwjNFmXwYA2BZRylbP9TWV
	NB49KzYBs4muaE6fFReu1GcPb8ltpQqW1VOVdT0m7ntpgr50YxoUY4qzjpag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772489497; x=1772575897; bh=+856K2TcNWHeCwHOOW424DsI2V2c++BqDXC
	EvVNLL7k=; b=TDePwid12lqPvgWctp+YG05SPcHLEdwa62mweYiwjF3WWbURMS9
	GXr5naFTe+NEiRdN60fHmm40vvZUuT/j/xFlsVxD97N+Ui/x4QWeC07UjC5N4YGE
	A9hdU/4jQSkfIifU/EdiiCF/irlWQX5oiio9QK0hwQovIsZHavRpWc5sDDVSTOCG
	dw/9AHgsZnZm3Ah6fRXcbHBXH50UB5701t56ILdkShMQCLuu+udvKXXp6qL5ughm
	AX18QbeZG9bo/shFn7e89x5hlieXAxanzIjtbN1bDmHotUKJKu5u2YkrZ6u/wSzb
	ue+IkFo5JlLZzoGk6IWkGGUFJe7eBRbqFmQ==
X-ME-Sender: <xms:GAumaTFOUsqOXlQdHSJFRjtLHr1aWS4Z1Jlx2lGNzgyukr5EI5h2qQ>
    <xme:GAumaREg7RC-aE6PhU3i7e1YWaSCL5XEMaZA36gaNmxX54psixzIkDYFSm45Vdv6a
    V8-MO1FbYyXtdl6brbgP4UJVBkyMkneEUti5_zNdwp7TXhf7nxnIA>
X-ME-Received: <xmr:GAumaRQMohyw7J-JjatsJFLIYYQdYX7uUE0-Y-Qmt_PdVHrC8uPPhi_3ypEJNdfBxXWMjMkUHlFdKKjgiM_ZQMVR-GaeKXo0-g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvheekkeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrtghosgdrkhgvlhhlvghrsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepnhgrshhsvghrrdhgrhgrihhnrgifihesohhsshdrqhhurghltgho
    mhhmrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprh
    gtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehp
    shesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:GAumaSKTUVDmeCZgerO1T_lNlszOh5b9h8t2yH_Hfl1OlAEWUdfjlA>
    <xmx:GAumacY1EpulUr7-_ik1VJf087TrznlzXZCiaYF3o_CujoNBgSf7tQ>
    <xmx:GAumaU-l3JTzLgzLw7zbtiwkl4M5Tda3SMic0IX2rLgBGEEqfIzGOQ>
    <xmx:GAumadbK-hOCt7rnNLIHFAJgA-HuP1UGNL2dpAIB00lv7WiAX8k-BQ>
    <xmx:GQumaaBx6siWUJ4zJPJ-iAY3diFzeRcbOCEFIPXn3icBq8k6d_ZhC42U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Mar 2026 17:11:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.keller@gmail.com>
Cc: Nasser Grainawi <nasser.grainawi@oss.qualcomm.com>,
  git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>
Subject: Re: [PATCH v4] submodule: fetch missing objects from default remote
In-Reply-To: <CA+P7+xqC10D9a3zp7JO_yoK9Vjpg+xua7yH=fGXjApUYisTf4w@mail.gmail.com>
	(Jacob Keller's message of "Mon, 2 Mar 2026 14:09:18 -0800")
References: <20260122152722.866341-1-nasser.grainawi@oss.qualcomm.com>
	<20260301025327.3845292-1-nasser.grainawi@oss.qualcomm.com>
	<CA+P7+xqC10D9a3zp7JO_yoK9Vjpg+xua7yH=fGXjApUYisTf4w@mail.gmail.com>
Date: Mon, 02 Mar 2026 14:11:35 -0800
Message-ID: <xmqqms0pyj8o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jacob Keller <jacob.keller@gmail.com> writes:

>> v4 includes fixes for the issues Junio patched in seen and I confirmed
>> it merges cleanly to seen (with v3 reverted) as well as next and passes
>> tests.
>>
>
> v4 looks good, thanks!
>
> Reviewed-by: Jacob Keller <jacob.keller@gmail.com>

Thanks.  Will wiggle your Reviewed-by in while queuing the patch.

