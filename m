Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79D328A40A
	for <git@vger.kernel.org>; Wed,  7 May 2025 17:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746638761; cv=none; b=P3S3+CW6+W0zJmTe/Jo5L1VXQuIoHyhagmhMvk3P5XPpThCwIzXTrL1TQJ09UxUQbkJzDase1QgNwbZw8KEla5S89dP1KrPpUqaNJJh8UIgExsA+VDmnzItIm9qIuEnn14Y55hqFTL5au8gZkUz7c/k+LGmLCRjx3ZOzAg81Q9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746638761; c=relaxed/simple;
	bh=s53Tgr77dAE5UFviiAVYQ5wX/FBW6HeGaDrIwBKRHyw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U1DYAqU3i2rRXaVqjPqRrSs3Gzfyj9Qwr6Ao0ha2dmrO5wIyfE6IuZJDHFMt43rXjv/79IhztUAsnJsR4hnVXrd+qQ5L5uCm0M2wOkEvDPUREEZE5Qa0o7VR8e2H2dLU3Qej2REX6+7nUoe/E8v7gwEgnA0Jf4zoS9NmdJfJtCg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=nlt3s8qV; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=bSWEBV4L; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="nlt3s8qV";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="bSWEBV4L"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id 926941380198;
	Wed,  7 May 2025 13:25:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Wed, 07 May 2025 13:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746638758; x=1746725158; bh=b/THYf/mqY
	x40NgHlQmlkCO+U1N6alLNOCV2t6WTO+o=; b=nlt3s8qVQ0UhfQnIC1Rma2donV
	evhXivy1KFjeL/o5T8ZAkbYb/Yg/R8aLeWxOB77BvXhEPxNI1QTIvH7FpQoPT529
	4rFbE5I0PnDjL6sRSnFeZnWBBGkPMm3mR6oF4UZ0UlpNSrYr021geN8IPVbMVfT2
	0Wtwi9ETJ5+PBdFUYrMk2BaiU1r/vUFfRrRStU8OwSdTsBZaAwnsxr/17Qlpbj6d
	9EMmiaRd0wmsg10MEs/EW40InvWpviFCpawShsMVuKdwM3pDnt5zLVso+wIqJBil
	OcVzX5qihObVAIrqG3dN02YeS1bI7oHBmPiHRexZkOGHKbvXJf+s83yzSNVQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746638758; x=1746725158; bh=b/THYf/mqYx40NgHlQmlkCO+U1N6alLNOCV
	2t6WTO+o=; b=bSWEBV4LAX/+oxp1KonvGKt8TluW5Xv16AX5VGl1iA1mBypqkfl
	ACltDR+lGERHL/Tqfb5f8WctvRRY5Ilccd1sOopwiMGJwihBy+oSttq1LhaBLGzX
	8ipA7Id+hdnGbiZvzKSF13c6QfxkBUXSP2R2Uw4RB/NUwWzTw+fRp+0y78uDCbJD
	GLul4/1XPZp7fc7TrMceiREhCKixhcW4EjYrwcmiWXjusupiAnHciJ7xyLMlRYqe
	UQgCHWHq1pT66MXdu7wUg7PzxqF1dfRZk4jvLdk4MIEUHb83Z9/ztNSip/2UEeaU
	iMgEiIOwiS4iLpLUscR2XbiVjAAao0+LWdw==
X-ME-Sender: <xms:ppcbaEKGX2V0ISAzGhrYZ_70as3-atUTPsLsKckfZB5aKRQDUuqMKA>
    <xme:ppcbaEKSGUVyp5OPDtbcHtVVHZqfFZqchAXJbwrvyW6ioMIavAccIENNl-eTz9rFd
    Pz2XlvdbgZxTfm1MQ>
X-ME-Received: <xmr:ppcbaEvqgm0oFu5NXEX6Of9eM_wjjTlGCLfXAc6a9kzQXexdnBXT9V8Dd0BGeOajo_D8IndrtWQ6r5c8rczyISNT1wvX9XmM-1Jr>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejgeehucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthht
    ohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:ppcbaBaQRIupBXIEqaKDH3nti2JzXmLaAQ8XAqyCllwXO8amOo1acA>
    <xmx:ppcbaLbhMArynSih_Yhd0YDeJAwxvxLw_7Hyn7k6EuAg_ILph-i30A>
    <xmx:ppcbaNA6SKrNx05Izq8jMB7vinx23i54eRfDeFu5KTbgPe2d1N2tGg>
    <xmx:ppcbaBZ89W-ZsyAtWYfeyRr90Jnky3D9w1bHR1dg_rr7FZ_y4u3kiQ>
    <xmx:ppcbaDrLLlGuZ-m0OGrmOY05kUtbGRM1fyrZQFGNpZpevUg73rmbjGMh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 13:25:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 10/10] contrib: remove "git-new-workdir"
In-Reply-To: <aBr9ZhSmbYtRp6o0@pks.im> (Patrick Steinhardt's message of "Wed,
	7 May 2025 08:27:50 +0200")
References: <20250506-pks-contrib-spring-cleanup-v1-0-e6d5ddd79a72@pks.im>
	<20250506-pks-contrib-spring-cleanup-v1-10-e6d5ddd79a72@pks.im>
	<xmqqjz6tikak.fsf@gitster.g> <aBr9ZhSmbYtRp6o0@pks.im>
Date: Wed, 07 May 2025 10:25:56 -0700
Message-ID: <xmqqwmascoyj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> hasn't really worked like that in the past. I think though that we have
> outgrown the old concept of "contrib/" for quite a while already, and
> that it doesn't really work well in its current form. The ecosystem
> around Git has grown big enough that we don't want to and cannot host it
> as part of Git itself anymore, so that original need has gone away.

Yes.  Thanks for saying this again---I think I said something along
the line from time to time for the past 10 years ;-).  The ecosystem
is mature enough that we no longer have to ship "batteries included"
manner to make the initial end-user experience of Git tolerable.

> If this is something that the project can agree on I'm happy to rewrite
> "contrib/README" accordingly. Maybe I should even do it without having
> any consent yet so that it can serve as a starting point for discussion.

Yeah, the latter is a good attitude to see.  It is way easier for
everybody involved what the issues are if we have something to base
our discussion on.

Thanks.

