Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A15A449620
	for <git@vger.kernel.org>; Thu, 18 Sep 2025 00:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758155577; cv=none; b=b73HMxqu8WZVpkLcdKqwh3hVjs5vHaO8uobZF6zIYhkrGB+tBSgt8gqaF0gksQo2uNXPoOwb0sXAXBJbqnlHIbGqZX79VN9ihEXoZ77eJKGPyhxP99P7js6IoOR3McpgI4PCAVYDZJ/7oJgZPbjIB//ikXH55AMlGnLW+yr8PGM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758155577; c=relaxed/simple;
	bh=Ld5OeEPJKQ5qLcfHtnY5wQeR6NnbiMSIu2VHiBAwK48=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TyL8rjI+GZ2nTcJyTslKxqeioIkLfUkLnTFVdjkkugVcLw7kjJqWlK5lNX2C/f0OH6LEPxZNub1xv1ZgGo1G1iW8fi8V/WF+wKrqPcERUKugYP7BYTfDVtzBQoEQj0K95GYq5zhoXBqQzoUolz1t/Lqzl/ZirtbfR0vDzRw99f8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=k4GIDfnt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jL4yNZ5B; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="k4GIDfnt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jL4yNZ5B"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id A996A1D0005E;
	Wed, 17 Sep 2025 20:32:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 17 Sep 2025 20:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758155574; x=1758241974; bh=Ld5OeEPJKQ
	5qLcfHtnY5wQeR6NnbiMSIu2VHiBAwK48=; b=k4GIDfntYz3TrUHmOjkwycjg/Z
	QkMXzhZvfMvwhM0OtRjNyU+rNcReSz4TblA8KG4W/Yixb7PCy2jtgnCMlPHiVwQc
	3zFXirgx+bSGqOXQZ4u724QppznUwz46dozF44KaGJ3kOvRx0bk0ciOR8v70mz3L
	DEgfq8opUQATC3M3RESa2MQSRf8/O0eoWHBOJK/ovfHpJGMF5mUPND8fRRQmYWpY
	w/f32l+rqWl0kC+nKMf2TZxJNSF0mWYE4M+tn4QjXVPiiHnSLLVMCj+y89RKcVkz
	/gVTDS8SqDKveVm7R9ya/KKlK/+qcrvKU4pnDzJGZGZJgmFl9hEwZQSsFZEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758155574; x=1758241974; bh=Ld5OeEPJKQ5qLcfHtnY5wQeR6NnbiMSIu2V
	HiBAwK48=; b=jL4yNZ5B0XL8p8iQYtNYLPHg7X/vv+bzwcIHzMQQ6PUg7j7Vhiz
	5TqTNCuudxW5MwHM85xBdQAO5Qd4RTHTsQDoykmoU5ZRL7t+/mUC805GKh/3g0L/
	sU65RUOTRVMLvjf+WFuJhl3JVeYMqcPJfBLj2JBhnNpbL4MhU1VxD/DCyB3xVKW1
	DAUNIcpNND7TGQI4H+WaUkchKxCXck7U0eNCW7wlSr9juRxMKgjXD8lNGVlOT10H
	4c24pLBPuv59LXLvglKqFTdP4D9PFaXrCvq23tFBfBfYVOeYlmWBfjW4WjaFx4Yx
	Gkm5Jj+px8Pt0aqeZNNVteiOHZWqxJ8PJ5g==
X-ME-Sender: <xms:NlPLaFecdXHDYegaKUStVLgmgNpBx5OIvP2PiFZD9BwwhTzwDL-IHQ>
    <xme:NlPLaNzIp_lBlL2zi18WJJfAZ9v91CSa-KOhJ4w0vMX7kMQHJ5XqAIgVhLt87yzVr
    TzCg6_xJAAbmnWreQ>
X-ME-Received: <xmr:NlPLaLE71ta8-glGSyOV1CqgEyY87_83WW_LySeB3n-mj5BqFWKx5PSZN94tAvB5wWoITHVkvMUGBMbAlTrOQCkDAdzkF3j7vyiLxHQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeggeeltdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecunecujfgurhephffvvefujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevff
    eufeejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesjhhj
    vghrphhhrghnrdighiiipdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NlPLaBymRSUaJ3NzTeABjeOerT07VVPHCN7dKVpyFRfT4Af1Y-qdOw>
    <xmx:NlPLaMsvSyo4kQZVrBom91Z6kZhrHHAvQdQUz6bZDu9uXR1uFuSn-A>
    <xmx:NlPLaO3OAjDRh9j3bi-p2bVECa3bwUGgV4UjOLfOq6PWOEOXZ0yQcA>
    <xmx:NlPLaH_vw1pSZ2VGltAxO3wZcHIwPWzcVycggapV_iEcqd1_eI5xpw>
    <xmx:NlPLaOiVq2BfnaVilQ2T_eOgslEPT8SP69RUVhV6GNJjReirM4EBZxIC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 Sep 2025 20:32:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Julien Jerphanion <git@jjerphan.xyz>
Cc: "gitgitgadget@gmail.com" <gitgitgadget@gmail.com>,
  "git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: [PATCH] Add `-u` short option for `git pull`
In-Reply-To: <VVHyXy0fQW1fnBgiAFswUMEMMX4wnc3YIZWSRtSJzZbHOt0dfY0wCJt69MDxfue54cN2gPd8StlVtW2ERYKZcEs8Hpm7X5TaXrygCN2rK-A=@jjerphan.xyz>
	(Julien Jerphanion's message of "Wed, 17 Sep 2025 16:21:12 +0000")
References: <pull.2037.git.git.1756147789443.gitgitgadget@gmail.com>
	<xmqqikiam90b.fsf@gitster.g>
	<VVHyXy0fQW1fnBgiAFswUMEMMX4wnc3YIZWSRtSJzZbHOt0dfY0wCJt69MDxfue54cN2gPd8StlVtW2ERYKZcEs8Hpm7X5TaXrygCN2rK-A=@jjerphan.xyz>
Date: Wed, 17 Sep 2025 17:32:52 -0700
Message-ID: <xmqqplboa9cb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Julien Jerphanion <git@jjerphan.xyz> writes:

[jc: line-wrapped an overly long single line]

> Having this shortcut would be really useful for some use cases
> where one needs to pull locally branches from forks before
> updating them and pushing them again on the fork instead than on
> the upstream project (typical use case for conda-forge's
> feedstocks).

Sorry, do you mean that you stay on a single branch, and then you
would pull from one place with "git pull -u" followed by "git push"
to push back there, and repeat that for other places, practically
redefining the meaning of the "upstream" to "the last remote
repository I pulled from and I am supposed to push to that remote
and nowhere else in my workflow"?

