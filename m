Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1878721D3F5
	for <git@vger.kernel.org>; Tue, 18 Nov 2025 17:03:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763485416; cv=none; b=H2wuqXw93AzvtahgJmyeV5w914uRR8ZnyOLEbuxs/HDIuUGtPqndUowlNtt9GYXwRZzyPe8CBoocU2SGJgOY0TXchNIq5On3UqC46I7osp3Lq2b9dMDAHkif9ON4pomwAdPp8HK9cOcSogd5KhQmrz9m2G5tjNO8TO+yrt9/ZPE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763485416; c=relaxed/simple;
	bh=WLTBaTEIR+cmg8BveOUbDLdcrsytXUfGrvivo7NW6E4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LTTYqad3boV+unHUPZiLBR46t6LjzDDeMkUNACJd8RWDuo22a6TH6uj1u+fBF5RdKACi61tUNSQVGDmdTR/xZ8zvLcMjQvqWJvHUfyFS2OcCbRvCC9yj9S6fXWRppLFWpCbY5TCayEgz+N/ySzqvRVkdt6sXsyTbLu33gQjb/nQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YcpudfVD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=e5vNc8Yq; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YcpudfVD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="e5vNc8Yq"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1FAA1EC0177;
	Tue, 18 Nov 2025 12:03:33 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Tue, 18 Nov 2025 12:03:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763485413; x=1763571813; bh=vEUnTJrnNy
	G1mmZaJcx7Gc0DVqK7/EPSB31qSQnKECw=; b=YcpudfVD8fU7yIBbs+pa9NCBXq
	RpFHsEtJLEDq7CrZiF/uQlHWfy4JmcmRqaK1VA9PKRY9uoqAtiPEjErKrrfum5Cv
	faoQXu9kEoD9YiBFB8EK84951Yub9Ea8hiWfkuEnT4fb8ZrlKC+3TaPDbsdRAHbT
	a2dKHfg0aOV91U7zI7jw/RdQLpua1f4Y4WsyGbtSeGZUp2EpTGtwj7GI56RPAL70
	IvrETxGPHQca8WQOQzhjGPYw2nCU2fNlYwRHSJEGMYTz31ifINVeJqhQeAtXjIyZ
	7H/++Gmac4XJw3+GJr595Qo6Iic3hPXymR1Ab0j57jlWqTIkAR5DIIOY2/cg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763485413; x=1763571813; bh=vEUnTJrnNyG1mmZaJcx7Gc0DVqK7/EPSB31
	qSQnKECw=; b=e5vNc8YqUUOCIgI//GEw+0k+dSzau1kkyG4wZejwRNxHRohuRzf
	SFUmNXMBSwj2Yh4N9XJN3mo1Pnm82W0RUZlISgo6Cb4F7Du/FAC+Xj0B2AhevB1u
	Flt5d9rI8yZx6XtUoPMkAMXXky25JirroeYLNaSsA5IMsgRWA9EF0eVW7gjeeaw1
	kEUyHbQoFSEKBDc5J3rWrPrTveHoCupxKPtuw0WbZOGYEQxONyUL2I4SWdEpNc8M
	KKDX9b25gQ5sEAphcEsuTo/OKiUzMIKQx5tmzFDDJ3d5BHYUizAiLF0PUE1D0m5I
	XmW8sOmIwBn6BG20iD9QR1YtCWswRBTjysg==
X-ME-Sender: <xms:5KYcaWC2BnkxERqp5VL_OZvcjXfeAGmLpkmYbfkhgF7PzNdnjVo_RA>
    <xme:5KYcaXinZFNOFFrgOMXiWtB6oLLYhCLAywnFb64uBwnryNc4JLI0K9mHffAqi2-PQ
    2BXRu5g58iAkb_CWx9WxOJMoquYqFEQiE0gY1HF9bxaA6pPL-pXOw>
X-ME-Received: <xmr:5KYcaekr29DFp_hJjXQsWpD5iP5v2GVRkUZU12S6tU9SmZHfD--FAD5dyisi2urMJnm0FA8ckZILH0k3hmq_TfYwWyL8alsWOtRq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvddukeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefhtddvkeefjeejhedtgeefgfei
    jedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenucevlhhushhtvghrufhiiigvpe
    dtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhnsggprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithes
    vhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunh
    hshhhinhgvtghordgtohhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtgho
    mh
X-ME-Proxy: <xmx:5KYcaToWsTg567Bd3vWlV8Z_VZtT6hE3drdujyYN10iM4FAepJxoLQ>
    <xmx:5KYcaXHIF7S6kFiLUwoInMxBgD5F2Wb-slAplGtuczW-CVCOtqlC4w>
    <xmx:5KYcafwr-CCOZ4LubHZirvONWn4KYlx_cks-MULfUzJrr7H6tCswIw>
    <xmx:5KYcaco1ap1n7ZolWRrQCM-nvuZqBEtbwXY9qpQxlLMDhWbY4uknSA>
    <xmx:5aYcaZl3b9VcU2x_OCY46J5CmUkP7Kl4QDuT_xFulbPwn8r8fdzEwAbs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Nov 2025 12:03:32 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Eric Sunshine <sunshine@sunshineco.com>
Subject: Re: [PATCH 0/2] worktree list: fix column alignment
In-Reply-To: <cover.1763482051.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Tue, 18 Nov 2025 16:07:31 +0000")
References: <cover.1763482051.git.phillip.wood@dunelm.org.uk>
Date: Tue, 18 Nov 2025 09:03:30 -0800
Message-ID: <xmqqzf8je0il.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> If a worktree path contains a multibyte character we end up with
> excess padding between the columns in the output of "git worktree
> list". This series fixes that and quotes the path to avoid control
> characters messing up the output as well.

Great.  Thanks.


>
> Base-Commit: fd372d9b1a69a01a676398882bbe3840bf51fe72
> Published-As: https://github.com/phillipwood/git/releases/tag/pw%2Fworktree-list-spacing%2Fv1
> View-Changes-At: https://github.com/phillipwood/git/compare/fd372d9b1...b42d0f668
> Fetch-It-Via: git fetch https://github.com/phillipwood/git pw/worktree-list-spacing/v1
>
>
> Phillip Wood (2):
>   worktree list: fix column spacing
>   worktree list: quote paths
>
>  builtin/worktree.c       | 41 ++++++++++++++++++++++++++++------------
>  t/t2402-worktree-list.sh | 37 +++++++++++++++++++++++-------------
>  2 files changed, 53 insertions(+), 25 deletions(-)
