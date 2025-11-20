Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6EB314A7E
	for <git@vger.kernel.org>; Thu, 20 Nov 2025 22:06:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763676380; cv=none; b=POc/xb1tCEEr9o5svWKyBk8I/unHUjk80a6SOMWN8mkz/eq0LGxp66eMd5+OjvhJzqsex+FGg+wct+vCKqhcIH1MxU9gVG86CdW15CQQiXf0A3c+QQJcz9iH1AMEgtUmkZ+wXeaPr44CmUkKkntvj/ywf6dz3NUc1mgnhooLsoI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763676380; c=relaxed/simple;
	bh=SviY6wnK+cBu0KfK2S2gujjxUk+FYSRA4g0MF6A7Ai0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mMrtNCbD6OrcS43BoDQWPchD8UXO+NNL5K6jnJCOQDlTiNj5oDqcrkJumL+pNkVLD1mT4bB/+UHnLiA7N3f+murd/a7edTrlVxmvxrY6ItrjhkudQN9W1urOGq924gGSZlvEomzi1e2WN4YxP1w2C8/dCtIjb//EfuAswSWQtfI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V6EoX4LH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=jZmpwFSG; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V6EoX4LH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="jZmpwFSG"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6AE0214002A9;
	Thu, 20 Nov 2025 17:06:17 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Thu, 20 Nov 2025 17:06:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1763676377; x=1763762777; bh=Y8VDpfPOha
	k8XSMK4TDDws5zWgcYiwhCtl0o44qjxG4=; b=V6EoX4LHkETiY1CVVFTLQoX7pP
	DhhqMELusBEt5dbCwzTJoFNg8y8aaliaxtWk2eYMPyLwnW4ptOMtn9+kXmjZ73T6
	uwSYK/Tz/vYmldoQOXBH+vRNeKAA4G9gYNai280JI6oGjmENsMqB2nQSd7h13Ke7
	XhCo/ur3RVVt+9CMa0f9ewJk/SFM7IKY58PvyTV0IO+SuNjXRurizY4XE/ESX4dA
	H1w+1k/tDX7wdcMdHvYicy2SMd3t1kwP9ywwgt7pBqG8UhMPaF4y1b4Nh4Bs1JOM
	o+al+ehgF3GOmirjdX97Zyu9tStPVUBCYxfEdRaZZ4jZ0ezBevSdl0BY77ag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1763676377; x=1763762777; bh=Y8VDpfPOhak8XSMK4TDDws5zWgcYiwhCtl0
	o44qjxG4=; b=jZmpwFSGi5FubPvhI2IjIPLINZLUIs6ThK2K2tf/DKLjcrIsrJx
	+Ta3Bkxvhus39Dps8XLxwO5sBirqQvr2dWVnEgGAecGA3t2/MqXRC37JSnEFl6Tu
	ng71J90jgIkq/MyMEEYZsyY7SobVsGIWyNxIkYv9fZUcE0x8m1lFIo1MLAPv+oJU
	4KUNdrATlg7Sb2GCAGO1e0zI2Yinb5LL5RcsTUgfL4qsz3ZFKku06izXDPq7jF7g
	dBs+SwKDxjIG20IA1M7ofSz1mG2eVAPxyV3UdUWS0caNjRvgPaTM6iaTikWR57/a
	SPvEeXHNEVxDld2jytR492ZSbupGf9amR+A==
X-ME-Sender: <xms:2ZAfaXn4pUEuZ3LbvLGikUPrPrAJp7pjXoEf4AwbgWES1N55dTP_rQ>
    <xme:2ZAfaSR5RcBRJN9Li2qGjGB_xf456P1-CHSd7nWRGyn1TZbPgHDQfe16z5lpYZz1e
    mUQTSG78ylBWP1woWeE915gODad3nvlP6SrURyz_znur4cAM7Bx-HU>
X-ME-Received: <xmr:2ZAfabD0GGJBITsB_5jksILcRxLE7cY9AbWa8N6J17oUGsvuz5_8JIp4jvkLyFxoMjABtn7y7OMGSMOaPIzVqiUTsiirtrGWe4EJ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddvvdekvdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtse
    hvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosgho
    gidrtghomh
X-ME-Proxy: <xmx:2ZAfaZTSgEtEA2GC5TDCrePp9QzbQKUXuTmjqQuZn28oZsECIBk76A>
    <xmx:2ZAfaZoc3MV_GRt4E6RPeiD1GDQNkUvfXqcTlCd4LW_OjnWfeTJmiQ>
    <xmx:2ZAfabwK9PT3UUDKheLAjvV-RO96BY4qw54i0HYRvhzUqRS9fN_P6g>
    <xmx:2ZAfaeKDsOjb4kU9E-PHFFMmpssd-TF60sYXMlESePCVZU_rN3ZsEQ>
    <xmx:2ZAfaSZJCIMbmoLGBP4S6l_jaoJKwvYPoTqswEdWGI2nr7GN3nLHO1nv>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 20 Nov 2025 17:06:16 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 12/13] odb: handle changing a repository's commondir
In-Reply-To: <20251119-b4-pks-odb-creation-v1-12-2b2ed2612cb6@pks.im> (Patrick
	Steinhardt's message of "Wed, 19 Nov 2025 08:51:00 +0100")
References: <20251119-b4-pks-odb-creation-v1-0-2b2ed2612cb6@pks.im>
	<20251119-b4-pks-odb-creation-v1-12-2b2ed2612cb6@pks.im>
Date: Thu, 20 Nov 2025 14:06:15 -0800
Message-ID: <xmqq34687414.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> -static void set_git_dir_1(const char *path)
> +static void setup_git_env_internal(const char *git_dir,
> +				   bool skip_initializing_odb)
> +{

Hopefully we won't gain too many callers of this function, and ...

> +static void set_git_dir_1(const char *path, bool skip_initializing_odb)
>  {

... this function, as ...

> -	set_git_dir_1(path);
> +	set_git_dir_1(path, true);
> ...
> -	set_git_dir_1(path);
> +	set_git_dir_1(path, false);

... it is almost impossible to tell from the call site which one is
for initializing the ODB (hint: "true" does initialize the ODB, oh,
no it is the other way around, or is it correct?  now everybody is
confused).

We could do "enum { INIT_DB, NO_INIT_DB }" instead of bool and the
calling sites would become self-describing, but as long as we won't
have too many calling sites, the current code should be OK.

