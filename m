Received: from fhigh-a2-smtp.messagingengine.com (fhigh-a2-smtp.messagingengine.com [103.168.172.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC9084039
	for <git@vger.kernel.org>; Sun, 15 Mar 2026 05:05:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773551154; cv=none; b=R472LXCmt/C/XNWyzcdXRQZLdeIjFWRQr98kNx4agpD5+AvspgTfAKYhcHEFmycYUTKlrZYmiW5LgcSf7CXZacAaQ4hz98ylfJt8c6mK+5S4d9wTFoEJCcf86bczecZJDZScwkivlvc3svKmMkeyDd5nk+uAD4vV+CEKuvomEKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773551154; c=relaxed/simple;
	bh=UNmewV6nJZDbjBta8v2OM+a2efpbZqbaOlPlXXLvTc0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=PcHyA3/F9N2SeP8NQxPCpk3DqgHVmCmzKzRVRxU/x9XZuXXdwtjWNOvc33wqw4/Ora2y+NzbhNvwdryYYy1cpttKfjErdpt+3ogCLP6GQOfiVR48YzXak3xdU+iv5akCcnOzHVphT7NHCL26dVvvVFPzKz1h5Q+ensts52gEVRQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fY1uDKIB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oH2p7CIp; arc=none smtp.client-ip=103.168.172.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fY1uDKIB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oH2p7CIp"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 0FD011400144;
	Sun, 15 Mar 2026 01:05:52 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 15 Mar 2026 01:05:52 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773551152; x=1773637552; bh=N4fbl7c3ak
	bEUJGtRd2h6c797fxL8xaEgeB1oIZ/Dtk=; b=fY1uDKIBR8qg4LykOXSlS92Jv6
	v1v2LPXO5uDt+K7Oo5CshKKQqrg0dptPEWhNhGQNQCUzZ3IQAT3bBtNuJ+N+Jj09
	H38xRuiJtOayH1a1yqqTOQkKZBdJK77AWkT8ooIO8C+dcel8F6z0CNCpuCcb9tOP
	Th3gt82rb2LTeVeGj4jbG/o+AD+RljSbwCplPMDCL4JDjcGk25ztm7qWS2NyPwDE
	/T+3+0N6AsuBFFA1KttqBXYy1qJZNh+DJIKrpfIoFGMD3e0GxTYyjJeBkhNjQLe4
	qTtAI0whs1YU508+qy95i1m7usWbqnUYzYAW4vNJ6uG15iXrnjL6aU2z/MQg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773551152; x=1773637552; bh=N4fbl7c3akbEUJGtRd2h6c797fxL8xaEgeB
	1oIZ/Dtk=; b=oH2p7CIpmaujulwX3NFnOqtpRm4kd2c0qC0+oZvQXsiDAUAlxuY
	gwIrwhN/vvk1QqODDZfbYtC6T7CZ9uji7q5O0+Af+Fc33ACjXNAlQE6Jo0tc/nU1
	DrZXzqklAG6Xegrna+WhD8tvJo6SwNfN/F9+4oGcRx9uPD1mCqJK8pzHVGTA2H2h
	314Y7MYdlL6v4ADeKJZGLL4ElmgB1ewT8z9VdaldCKAj19MqWCirRLTC2qDxrFa5
	FiouKAi56Nva6qAAXO8DqCr25+ENP8R+8lT59NHImGYWkR/SS0EtvSypnwhsZ8rj
	CWMJ7sBzCezP/KPktVUxkT4FWGDhtLoRP3A==
X-ME-Sender: <xms:Lz62aXdHmGOYB3OyFxHBhwhF2Niouiss1o9tSO2343DPmKUpF-933A>
    <xme:Lz62afw3c35Mlk92396W8sYu04tdrIBUVSxgYH964kozVTyaqVXSpxCLQ_QmIfVgt
    Ow_t1cT-ZgCFJ95R84TQ-IDi9l49rVtYer-5gO82r1dsHWiOeXd>
X-ME-Received: <xmr:Lz62aUITyQYSr8ZV3RU2NcDKaIL2GcBi01iYcXCrCVBmDOhh4nEuakhlJmWmGjqwlrZZ1Cd_PsUMnFc9-QtVkPyk_hLiu8kY-w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvleegheejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepledpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtoheprggurhhirghnrdhrrghtihhusegtohhllhgrsghorh
    grrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghp
    thhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhish
    htohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthho
    pehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Lz62aZE0T5VAfc-_PfIxRqPV5AY2sm_HGOXkSBpNFBFBngOCBg_fTQ>
    <xmx:Lz62aY_XH3Gas_cFxYxo7FIc23pN0a2-4-HQ9p7uGI7_Pa3pnlWLcw>
    <xmx:Lz62aRL4rpFzhNQl-4UJ0zQEjd4TDHpDNLI2ToORD7I1PmlfMsQ2kg>
    <xmx:Lz62aevH_k81LzJmUgMRj8hQpwVFql89i5GtoQnJY1A1BzCMX5_BRg>
    <xmx:MD62afoptjfVUclCyVPmokW8zDKzjxoLBTWZtfN2G7NrsdQ85rJpenSP>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 15 Mar 2026 01:05:51 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Emily Shaffer
 <emilyshaffer@google.com>,  Patrick Steinhardt <ps@pks.im>,  Josh Steadmon
 <steadmon@google.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  "brian m . carlson"
 <sandals@crustytoothpaste.net>
Subject: Re: [PATCH v3 1/9] repository: fix repo_init() memleak due to
 missing _clear()
In-Reply-To: <20260309133739.294555-2-adrian.ratiu@collabora.com> (Adrian
	Ratiu's message of "Mon, 9 Mar 2026 15:37:31 +0200")
References: <20260204173328.1601807-1-adrian.ratiu@collabora.com>
	<20260309133739.294555-1-adrian.ratiu@collabora.com>
	<20260309133739.294555-2-adrian.ratiu@collabora.com>
Date: Sat, 14 Mar 2026 22:05:50 -0700
Message-ID: <xmqq7brdvg0h.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Adrian Ratiu <adrian.ratiu@collabora.com> writes:

> There is an old pre-existing memory leak in repo_init() due to failing
> to call clear_repository_format() in the error case.
>
> It went undetected because a specific bug is required to trigger it:
> enable a v1 extension in a repository with format v0. Obviously this
> can only happen in a development environment, so it does not trigger
> in normal usage, however the memleak is real and needs fixing.
>
> Fix it by also calling clear_repository_format() in the error case.
>
> Signed-off-by: Adrian Ratiu <adrian.ratiu@collabora.com>
> ---
>  repository.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/repository.c b/repository.c
> index 0b8f7ec200..fb4356ca55 100644
> --- a/repository.c
> +++ b/repository.c
> @@ -322,6 +322,7 @@ int repo_init(struct repository *repo,
>  	return 0;
>  
>  error:
> +	clear_repository_format(&format);
>  	repo_clear(repo);
>  	return -1;
>  }

It is arguable if the fault is on the caller, or the callee which is
read_and_verify_repository_format() that answers the caller "hey,
you do not have a valid format to work with" without releasing the
thing *it* sample-read.  As you said, this only triggers in a broken
environment, and there is just a single caller-callee involved, so I
am fine fixing it on the caller side like this patch does.

Thanks.
