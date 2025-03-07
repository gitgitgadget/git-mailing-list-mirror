Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E622257AF9
	for <git@vger.kernel.org>; Fri,  7 Mar 2025 21:28:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741382904; cv=none; b=Vxl0fA+RA3XraigW1taZlk47hIxc/XTsAgThlCVIsTEdovq0+zuCtB+NnmB9+4v/rloiMeBd3s+wpYDYv81A9YGhkqUjzBpe+oGgaxSh1ORgwqgQtDXZ6tbj6PR2wTwThV1xB/DjfNf05O6rQ1cJkE9S6Mi22IWo0wYGJWrAr7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741382904; c=relaxed/simple;
	bh=e7URO6RWIU9iMH58k2eK7ZaVEvsE5afoPq+YoUpQ5kc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=B4D8q8ego1/xRHrb0luPVGS16hVeh0WCfy0dx/sQbo4Gg8ScUjUSZKqjrYASqhnZgkY9Q2rCwSTH460fKYWPFX88dOepJkleaw44mj3wVfGWMpqDMSwq0QuWo/sxNmSV0vsX/sOcXFyk+zxACYdZz7lZuPAmRwSHuA29aTT/CT4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=c6sPK65r; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=CUpvTbAM; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="c6sPK65r";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="CUpvTbAM"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 77C9725401B2;
	Fri,  7 Mar 2025 16:28:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Fri, 07 Mar 2025 16:28:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741382901; x=1741469301; bh=eLdlLQvk61
	44dOjw6VqCfSVdsyV99bWmS/uB7VgP1K4=; b=c6sPK65r2eeRiIeO5Tzsfmy4Lo
	I/wkTAH6YWqiOfA3eejmhY6HYfuIfmNvVLGxB7DM4uAtW51WPvh1hgE6UGYs75A8
	75WDPiWeQaP6RIdfBc9Ui6NJg3UpouEDGnusAH05cQulww27lCozV997d1I9njbE
	yCLm90/S3OTNbmFfGl6FyvEq9ynIS4c3jpzDDMycLU31L/ttPu/cDmhC9yGEosRv
	jIBUnLhWZoBEcHAWRHiHyzmu704zXoQ+GL9yJpquVDXOSq2zRLklJJgSs7oaW2QV
	nOQWD3o6gieo+MAOEbdN98ToxkuvvGYf4hEH6BuguosM11l7xatwYxFI/lKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741382901; x=1741469301; bh=eLdlLQvk6144dOjw6VqCfSVdsyV99bWmS/u
	B7VgP1K4=; b=CUpvTbAMQOlLPZl1p5lcLIYavMwk6JR89h6BaS7LbBLELFVJxhu
	b5YVkydCn3EoRk4KaQUFnyafFelPeERHisN8gfkNhbsmYa67x4gqizUkkx7feq5d
	Y9QhVxhkDXrw766EKbJYmDSrz4QblF594xw9rePVKlEfKPB0sHXCpfuu8n82kVuc
	0YyK+D8AXDlS+7nuEZCPxqERBb108mLHqzVgncW0Tq5wGUDMmu1YXLgKySlBXXSu
	ey1iPvSqxpJPhy63atsEIu/niow5lJR3GtvBIqfQIYgixa21H3NC85KCieh1n84g
	QmZMwiqs21d+amtx2dUtDdpBFe5blx/W5Gg==
X-ME-Sender: <xms:9WTLZ8eJ55Ez62aVRx4mAfBtwFUiGbnB9FSEfCeSrrkuO9Qdn7XegA>
    <xme:9WTLZ-OPyAJFsM18ldzW9DEzbPSbxZZPW8zEVWd0aSCt12EbFwytqEqSV50cqrKLX
    kmNlV-p8tWnUHuCyQ>
X-ME-Received: <xmr:9WTLZ9iNT9erDfhgbKbn314U1aAiIgYPsN8kkk9PM5raBV2KCNZI8YFmohKMll-3U5ipf6He5AQ3-ECY2O2k48t4P28aqJj2jYQN>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduuddujeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtsh
    htvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:9WTLZx_hUn70jTjtu34hIaEXQW9KmLZxTtOUqwO5j7j8s4dC6HWOCQ>
    <xmx:9WTLZ4t4Y-aQ0WewTNz54yZKrSsd97BNQEKb-96AvJuv58P7bcJM-w>
    <xmx:9WTLZ4HRsaGoJOxm_7_Inep7Izcgd3ZtgGAC8o0dSaPy1SdsUDR1fg>
    <xmx:9WTLZ3OreQ6n12BOHvAmk03blRH5jg7J_pcMpzBzYLDjckrftGkE3A>
    <xmx:9WTLZ6IVvPhfPcctbtun585FZJzchveUZVpr6dmxU-V90ukXTsgZZnMQ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 7 Mar 2025 16:28:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Karthik Nayak <karthik.188@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/2] reflog: implement subcommand to drop reflogs
In-Reply-To: <Z8rdg90kxmKHHbyh@pks.im> (Patrick Steinhardt's message of "Fri,
	7 Mar 2025 12:50:27 +0100")
References: <20250307-493-add-command-to-purge-reflog-entries-v1-0-84ab8529cf9e@gmail.com>
	<20250307-493-add-command-to-purge-reflog-entries-v1-2-84ab8529cf9e@gmail.com>
	<Z8rdg90kxmKHHbyh@pks.im>
Date: Fri, 07 Mar 2025 13:28:19 -0800
Message-ID: <xmqqbjuccyz0.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

>> +The "drop" subcommand removes the reflog for the specified references.
>> +In contrast, "expire" can be used to prune all entries from a reflog,
>> +but the reflog itself will still exist for that reference. To fully
>> +remove the reflog for specific references, use the "drop" subcommand.
>
> The last sentence feels like pointless duplication to me. We should
> likely also point out how it is different from "delete". How about:
>
>     The "drop" subcommand completely removes the reflog for the
>     specified references. This is in contrast to "expire" and "delete",
>     both of which can be used to delete reflog entries, but not the
>     reflog itself.
>
> It might also be useful to add a comment to "delete" to say that it
> deletes entries, but not the reflog.

Good.


>> +#define BUILTIN_REFLOG_DROP_USAGE \
>> +	N_("git reflog drop [--all | <refs>...]")
>> +

We need a matching change to Documentation/git-reflog.adoc file,
too, right?
