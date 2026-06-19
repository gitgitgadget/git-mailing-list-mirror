Received: from fhigh-b2-smtp.messagingengine.com (fhigh-b2-smtp.messagingengine.com [202.12.124.153])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CCE43B71B3
	for <git@vger.kernel.org>; Fri, 19 Jun 2026 15:42:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.153
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781883780; cv=none; b=GtHdKcfiHJRSGiAu1lmGmc/NQqDCGESxJTNEKe3dT6rX4SClP/DWgXbt/eX4Y+PohZHLJ7qrqKNgeCPePZTYa4LXVxiOEcSi62y0ugI4r1lqvvgZroLyxw1YBMGBLswDmYJxnmXKCXkfdcdhX8hV7W444a3WGQMs1iwRhp1hGQI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781883780; c=relaxed/simple;
	bh=BbupDABMNEHDLl30Wh/wsRWW67FNooPFxvVyXa432NA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bJDOe68n8ZwpA+boPc336Y0bs3lQxsgyOXCRBQcULeiZc2ckSV/02Ge5LZOCe26pu3gUTHOx+GTbYa0iTcthUSlcO84pbw5eegbAGT1EUPv5QzNpHMHCR7MQg8yhOKoNRe71lbBhNSdaM7orzuvKWA/4dt6OQOailGLGyFmIM/Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=n5BP8sOe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=i9lzh4KT; arc=none smtp.client-ip=202.12.124.153
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="n5BP8sOe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="i9lzh4KT"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 4D7307A0116;
	Fri, 19 Jun 2026 11:42:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 19 Jun 2026 11:42:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781883775; x=1781970175; bh=JBBBM7uhfX
	XRt6ZNPoPiwjqN2vqF0Rz2j4GZEQGv6HY=; b=n5BP8sOeAQY0kolk9aftR2AuFX
	1zAtqeNNnIC/zccHkjjp2+22btouPd552v3mGmj6PlLJ4VnAnO9QZ/5t6j6y7hnh
	C3F0NDYwH4HAynlGyPyr/w6USeVRXhy5jIinFDE3cyg72YTLUP0qv/E6gWkpymO9
	MS+9giJy7mh4uZRLNQAORYHUfiWR+6d3No8s04nx2+ylS1uGG+ZgE1ca8ur298N0
	CNj4X+lhWxU/0jMOnRzl1mubqogQnqAuZvpfc76ZxJ7NPzISB1s0wDsiKjhsx61F
	MbcfSsHzejXHXC38OfJZqpCu3aypRYGjbQ/ST+WbuOgVvtd+v2zNtTxXExBA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781883775; x=1781970175; bh=JBBBM7uhfXXRt6ZNPoPiwjqN2vqF0Rz2j4G
	ZEQGv6HY=; b=i9lzh4KT+cH3LD4FIBJFtBMak1s//ThEzcvnjE/uhJm6wo69+7Y
	znbLpsCwgPuYv3uTuE4aTysiGs0gQ2IFoKkNZHjI+UnsQszvFOniFo5MzTVCNG3y
	ceZFff3iJQzTlBkPETdySu62OVcLvMYgAaKbHOjSpKoousOnj9rV47Tv9dmc7mTg
	lcWvwX+VBMOH52KuelAoySBul5BEm0smDq4zrG4yZWRzEhJUiwQ/ztJBEY5QKhuE
	FnvCNU6g7XFQU3gq/1j7nt0PqTQ8WOeX0p8RfGfgXIYJHfWJBgbLytxRVuGNKcG4
	RmWSvFkS1nAzPq5uvZRPFcAhvD8LQKiuFBA==
X-ME-Sender: <xms:f2M1anT2ubktvL-qoIz4JOyRKMdllfF6SqKvTtzjjAwGPUyrTOeZ6g>
    <xme:f2M1arArWPES14iUt3gTbxIQsRCkc0QmjPoEoThnwpLY3vZS9Firew-5xwDFuXSl4
    3WaHcd2s4YMpPH9CSM4FWgbcvx7rsPvdTao6nWY6mYSfmH3YmSIPw>
X-ME-Received: <xmr:f2M1avGVTsv6g0drQq5rRnvakYNVQTUKfQzVxgMRrsHJezn_iZO2CBjohuewkmy7Utf_QRMWA7iI_eyyM-wbyIt25IcnbOSwzK5D>
X-ME-Proxy-Cause: dmFkZTGlesXX8jo+RMTXGdL8VQhTgnohVz9Om2bNErqsZWghIHAsfa1aXyEm29fTbhPawx
    4hwY0IIi7gaE4o4LOKt3c9zahlf0MIirrIGlE8fyIrVd4owq98Lwd/gmVttaDlGW/VkgFO
    wQcy8KOSPZQevAT55F/JQvkMkGwXOxIq5521/CgkgKXpbTAwGSu4G1Mdr+KC/lxuaBErsk
    iP+MpJnAi0zj17PKEzzgzsz5mnnUGXdAA3LdqpqqgeFiKL3jS1T3mA2oEPHF0qKsAvv/ZH
    yiib6iXJBKZwhTX6U1lvMGgdhKm+dxuCTITnedjw+aoUSJWdregF5ncaH9SUarOM8o55cU
    t5PUvlKWHAOBHzmn89Qw1GSu4cG/n1qjBCOyW4YWrUzbeqgoQMjQSTzYg7PZU8YJ60e3Ho
    7+82hEbGmYsOe8bFey4dY5hUs1tY8l0Ji7QHTcOlmVqowzbhfsV8xawSrAzu3eN6prczOC
    OsJR8RbOEsGi9sDaVAwQto6jPSPvHXdxtBCDXfCFtP2am2A3lNuZ/vswT5cFPW+XmMLnnD
    HdHRBs+R/CeP8gYaElOgHbg5tcxQVP5sQVYHl1L1HGQNdSImoBPPIzSXf0i68Id2MGV+Vs
    h6j76FtsIUfml99fI4daOLESEjV7ctPAegFVPICT9htclAtqymp7ZskDIDOw
X-ME-Proxy: <xmx:f2M1atDLB_LuVpM845QhYQkUs8sRjYBhHs3qDlel6QQie-dO-S9H2w>
    <xmx:f2M1avV745lFva08aFMBUlnl4DrJlFYD0fY7ADp7PoXN9oJBJ2b51A>
    <xmx:f2M1ahpFY_UoP-S40tr6sYVjBsIWZrTlVCu2cEeoPQhOp1PZXBaBgg>
    <xmx:f2M1arQjLF-U0f3wT6GIzO_PpReRbyL0HNi2bQkmASMvcWYaodqGFA>
    <xmx:f2M1aosR3-6CAxP4XSMo7xlrhi30JeI7CNHvBkb29z7CeXKMgN0VVDlW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 19 Jun 2026 11:42:54 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  Harald Nordgren via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org,  Kristoffer
 Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Johannes Sixt
 <j6t@kdbg.org>
Subject: Re: [PATCH v14 4/6] branch: add --prune-merged <branch>
In-Reply-To: <42ffcb36-7fff-4948-9b8d-2c54eb626e66@gmail.com> (Phillip Wood's
	message of "Fri, 19 Jun 2026 14:13:27 +0100")
References: <pull.2285.v13.git.git.1780684553.gitgitgadget@gmail.com>
	<pull.2285.v14.git.git.1780999917.gitgitgadget@gmail.com>
	<9924373da0a0598cabe4f08f3bc4200833679171.1780999917.git.gitgitgadget@gmail.com>
	<78b6dfdd-df61-4c44-96eb-b527cb26243c@gmail.com>
	<CAHwyqnUsjpCHfS=eBphmkdDGYpQZ_LQUJi1mjrxV8ZXi+w4yhg@mail.gmail.com>
	<37f2a483-c8bf-4c24-84de-c6233cc20b25@gmail.com>
	<xmqqcxxnsufl.fsf@gitster.g>
	<42ffcb36-7fff-4948-9b8d-2c54eb626e66@gmail.com>
Date: Fri, 19 Jun 2026 08:42:53 -0700
Message-ID: <xmqqh5mymt8i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> I was thinking that if I have feature1 with upstream origin/master and 
> feature2 with upstream feautre1, then once feature1 is merged I'd still 
> like "git log @{u}.." and "git rebase" without an explicit upstream to 
> work when feature2 is checked out. If "git branch --prune-merged 
> origin/master" deletes feautre1 then those commands stop working. Maybe 
> it would be sensible to update feature2's upstream once feature1 is 
> merged (which I think is what you're saying above) but do we really want 
> to force the user to do that by deleting feature1?

Ahh, reference with @{upstream}.  Yeah, that _does_ make sense.
