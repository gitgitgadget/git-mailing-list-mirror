Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7746222611
	for <git@vger.kernel.org>; Fri, 21 Mar 2025 06:11:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742537511; cv=none; b=Ey+MZtLO3MLbu6LLzk/ChDzv+nB0YYKpxl+7SiJV+M0MZ4Ukg3zGYccZgRX/Oohc12HupfzYUsmfLlQlCG5VpyfncKw9RNxebPpkXPP4Du/GnT0tsOMyQpNky12bd+aLRspnpKkjJp+hnhd4xpdLAUOsxbvRbuZAEkzwymCzHSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742537511; c=relaxed/simple;
	bh=Ig3by110JwVZtN9bnTRbPNNOs1QSind2OaG5jGr4Hrc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=G0zP5rL9s5RnbbsHFq9FKT2P4khLGkW4Gnph68TpKctVurLkU163HL9EuoOAFCj/rAiWF4qqZ6cBaDjGzp9+FCYprJWYvBSqTE4nw9IjRFt+HsqrPXfqa1d7qFLkfGGAcLHOdEhMvujt5btAAsGFFSTLn4VG2Ezp4FDaUoOGgsg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qILorfQl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hSXQax9R; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qILorfQl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hSXQax9R"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfout.stl.internal (Postfix) with ESMTP id 712C6114019A;
	Fri, 21 Mar 2025 02:11:47 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 21 Mar 2025 02:11:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1742537507; x=1742623907; bh=Ig3by110Jw
	VZtN9bnTRbPNNOs1QSind2OaG5jGr4Hrc=; b=qILorfQlBzrOIPv5a3+abOSmhK
	gjWBHek9C2M19uUh8aHniHY6kdbzpHLlnmDiM3KYdZscPXrldqUT5v5euE/2jz7z
	y+5/OF1HX1E7amaXaosgyj7v5bEidKEmDEzfKl5BIJG0q/GEXwevU2oi+SHYAhyq
	YPJwhfsiQWw2mX0iCelSYBdY0fXImPm+5fKSegJVtAt/AwXEpzUX5yWAAzQu4eBP
	GNhqYR6Jts0C2Dh1ELAl/Msq4cWcthCP8bUh9//4ybWXN3r+s+wBsc4JKQ+dp0A4
	dBNnP+YwJtxX/63XilWi3Prm5pP2lqq3Sz3Rq8CmbKkY5VayiusR0El2pgzw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1742537507; x=1742623907; bh=Ig3by110JwVZtN9bnTRbPNNOs1QSind2OaG
	5jGr4Hrc=; b=hSXQax9RCuMnhZpiHRH73GnAcps7BHzApCKiqJWy1ZYkM7xmvHx
	rhbshyeBpxzsFs8Fd5vCsXzPE9UxxBZRK4XAx1R/fXSJr1xbHS3ntt3XSWjo2Kg5
	VWFb/uwO1fd0no932oqsUs3xu8e7I0GPYD220+1OnbZs/pK6geqrVSt0jZMq1D2+
	5IyyBV1afoBuykzhNGmCTLBbJaAsjAcptWAqYqq3TXXw55OZQccUZDRuDm6nDh/u
	LAwLbc/Ckq+bDR/spxql+JFHPXKKeseYToLMoMAiFmAIb1qSnGfDtQTp+wI/mgsR
	7PAwKmT7KjGyE1tEM4o1uMyd8/Lo6wKfT8g==
X-ME-Sender: <xms:IwPdZ1CDMSnz11spbE6t_mdocm4bB0zD-pNFSBmztyASXeysFCdBAg>
    <xme:IwPdZzjlxLv3QGFsT8PoA_tj6svHGPnOw26M4Ow_41Mt69N5gjX69t2XxbgfQetcy
    kPBtig0wEnyUBDQCA>
X-ME-Received: <xmr:IwPdZwlBxq-JMjdd7VKycScf6LcwnAah72IlvZJVMJD6zs1hcfbk6PsQoITieBAcTVzNbq_PVKdHrhUdNHJttcGds85gVloOyhTqCLs>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduhedtfeegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehhmhiitddtjeesghhmrghilhdrtghomhdprhgtphhtthhopehg
    ihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesph
    hosghogidrtghomh
X-ME-Proxy: <xmx:IwPdZ_wyB_2EVtQzihsCYpnDzTFWqPVd_hSQhbH7M7j_6kKG5cR3cA>
    <xmx:IwPdZ6ThcvgQTK7fRqRefU7EX21UKjnzo0VHfMgqOcQIsaF2oM2JHg>
    <xmx:IwPdZyYHurskSWMAuLliUGlDrl-ELAIdDAhMo3yPfhVVDt3W2LPqhw>
    <xmx:IwPdZ7TARg4kzuC7sDLB6n5FrHc8AQODDVGZTisoEP16DOnXg9HHag>
    <xmx:IwPdZwMyxMO7Tzx3a5Q6ma9lLTsa9ydSBsD1XirH6Ml_MErWRrZeMxxu>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 21 Mar 2025 02:11:46 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: "gtXfined H." <hmz007@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH] index-pack, unpack-objects: restore missing ->init_fn
In-Reply-To: <Z9rC0VCbh8Noaq4e@pks.im> (Patrick Steinhardt's message of "Wed,
	19 Mar 2025 14:12:49 +0100")
References: <20250318111616.113941-1-hmz007@gmail.com>
	<Z9qPMvclpdEIjQ3l@pks.im>
	<CAGr7CZnNdTsUuJU+Z8HBX6wQu_HF-faDPPhuLx7u-Y=TGeop+w@mail.gmail.com>
	<Z9rC0VCbh8Noaq4e@pks.im>
Date: Thu, 20 Mar 2025 23:11:45 -0700
Message-ID: <xmqq4izmx68u.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Fair enough. I'm also fine with the patch as-is as it addresses the
> issue true to the original spirit. Improving `git_hash_clone()` would be
> an extra step that doesn't need to be part of this series, nor does it
> have to be you who implements it.

Sounds sensible.
