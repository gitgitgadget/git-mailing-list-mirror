Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8876C156
	for <git@vger.kernel.org>; Sat, 28 Sep 2024 07:03:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727506984; cv=none; b=p1LaeCOg33HlglndQ04haDa75Kdnm9aip/XIQ5KYxezVHYeWsN/2AOf95gTM1f4we5ScM7PeG6JGPb8Vr6CnOdXHjmAt0F7gJogDb0zy33e1Vrp36W9SU3hmCKRG906n8NG0uzU7MmxI3iA/eDO8vpUthAFXdDIsTA88ip5i53E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727506984; c=relaxed/simple;
	bh=PS1IpPTtyulllLYqU7b86hVOXZ+GtKkUeFs8Ce4T9dM=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aaODLZ1oJW6EYCdvX9XstYHG/TjJ42HsflMClDUBdgM1Q1hiTtJaBKCmZlGGpmWZxBHJM8GTu1iCk+HTiQu/Jwil0DQOzwxq6d8G2Z4/WmTtoMVCwiPpgFsKKj57eJPzhMIlulDap7iYmEAZrF7K6Ix9i3Kb87samUPHHm3ZD9c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=CdKLe5Qf; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Fqx38+R+; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="CdKLe5Qf";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Fqx38+R+"
Received: from phl-compute-10.internal (phl-compute-10.phl.internal [10.202.2.50])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 69C411140238;
	Sat, 28 Sep 2024 03:03:00 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-10.internal (MEProxy); Sat, 28 Sep 2024 03:03:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1727506980;
	 x=1727593380; bh=x4SX5Xyn/FJ4zJBcUQfX3dFw5GZlwVg36ZUHnlqL5/A=; b=
	CdKLe5QfJ4wLBWchuKXMJ0j4pE/sBJJoszkwAsmdEBABoHCjccwdSJnrkVqw2lz0
	iYJqvdjCFFjJdSjxVXM+4KPKP/h/eDXeyYlt8fclSeYv5YWSByU2GEr4SzQPfgTB
	Az0vGVE51JbSsFJTkIqH0XanfbahNVLpqhfXy3y2vTXDs5fRWjzyESWwzMp7d7h2
	3YT9nePqfzwd9Mdc6pRXzc2BvV/LyOY2/Iwebps3maXN1zL4ayex39CEsjq3DHij
	ZaaYDk0DN68SEnEztejWebvMaqiZ1kTTzdEHyoNVN0uyU/lz9BG/wkag/M/T9rd8
	q/f/IflSxV7r2MVlbY1OgQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1727506980; x=
	1727593380; bh=x4SX5Xyn/FJ4zJBcUQfX3dFw5GZlwVg36ZUHnlqL5/A=; b=F
	qx38+R+ReNVS2TQiOjg8w2Bh0LaabjU6wsKXYL/ONurvLEQpQoIV6V9ihpG5Okmz
	Cs68rSAIzgSeNaQvj1HHsM5Bi4iw1wuyg9KJUAjX0k7Q/TGBNxwVvjvC5Ky0bVNZ
	oGF1qwPdnxzgTbsyVcNPgBMLA6OYZnzxpKH24o2VcRZfw8hTqZza9pb9pDejozCk
	pA/EierNoQXSG8EkkCDCy4OAufsKlKH44oWrWNTFl4s4Ht+X93Y5FFa+CN3j4p5J
	cVmQDbFn+sYGV99RNEcBgvOQlhpNrFtmfc8WqNzjWn7WlPPOa7PHdVWzOrdKA3r4
	85h4bxis9kwd8ePjIZC9A==
X-ME-Sender: <xms:I6r3ZuDnZGodDk_iTWQCp8pdyYieBOx9Brq28lXv-Vo1UU8xoKmH8g>
    <xme:I6r3ZogWwD_WLuuPEIgKifgUNPwcldnsT6tPbLqtuJaSxkuD1HR6MMPBk25lfJNca
    m4nh138SUVfyqu5eA>
X-ME-Received: <xmr:I6r3ZhkgyGUMyy2A4rPS3ftnDE1oGmCnoV4BymirD_VHYcUFIqdHS_elRz73rWm-E9mCtupNwfgdqlZQccfkeLSkfoiX9mbEY_aF7TtEq9E>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddutddguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtugfgjgesthekredttddt
    jeenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepvdefjeeitdetleehieetkeevfedtfedvheekvdev
    teffvdevveejjeelgeetvdfgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepjedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrggrrhhtihgtrdhsihhvrghrrggrmhesghhmrghi
    lhdrtghomhdprhgtphhtthhopehshhihrghmthhhrghkkhgrrhdttddusehgmhgrihhlrd
    gtohhmpdhrtghpthhtoheptghhrhhishhtihgrnhdrtghouhguvghrsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtth
    hopegthhhrihhstghoohhlsehtuhigfhgrmhhilhihrdhorhhgpdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:I6r3ZsyM-6yKtjYhTiyKTOJ0-De5Qd7JH2UDf_-NxyF1WDJzctHhaA>
    <xmx:I6r3ZjT_7ZctCkkrPkwYm28ISk6xfvZidMbLGDnq_ZgOUkiGkIlasQ>
    <xmx:I6r3Znb9dGBcJ5ctYlvNKSdRobkexCemIHj79xIlnIWPwLnnV4Gv5w>
    <xmx:I6r3ZsSA7ZyFqJsDnujn9XVTXFHGcQ6omPyzjnUmKDhcdNLV1cTxhA>
    <xmx:JKr3ZsRS_NeNkS4bbKBhvrr2cY5EjAe3qLVrqG8NI2LjQVakEKt5IuyU>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 28 Sep 2024 03:02:58 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 7c8e4c2a (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 28 Sep 2024 07:02:14 +0000 (UTC)
Date: Sat, 28 Sep 2024 09:02:36 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: Christian Couder <christian.couder@gmail.com>,
	Ghanshyam Thakkar <shyamthakkar001@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Kaartic Sivaraam <kaartic.sivaraam@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [GSoC][PATCH] unit-tests: add tests for oidset.h
Message-ID: <ZveqArC9NNs44Fjc@pks.im>
References: <20240824172028.39419-1-shyamthakkar001@gmail.com>
 <CAP8UFD2yTMNmx0n1jhOu7dz_4XeOyTy1iLmRWYmuf9QJf75hsQ@mail.gmail.com>
 <xmqqy13ei819.fsf@gitster.g>
 <CAP8UFD3JzYCJf4+JLvfW_8m6kp=O0NMKi1dF1Fof9=DmvZ4u2w@mail.gmail.com>
 <xmqqcykpgchf.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqcykpgchf.fsf@gitster.g>

On Fri, Sep 27, 2024 at 11:47:40AM -0700, Junio C Hamano wrote:
> Christian Couder <christian.couder@gmail.com> writes:
> 
> > On Thu, Sep 26, 2024 at 8:28 PM Junio C Hamano <gitster@pobox.com> wrote:
> >
> >> I'll discard this one by the end of this week unless the topic sees
> >> any activity.  It looks to me that the project decided that a longer
> >> term direction to adopt "clar" as the unit-tests framework, so this
> >> patch would need to be written even if it were perfect in the old
> >> world order anyway.
> >
> > Yeah, unless Ghanshyam or someone else wants to continue working on
> > it, I think finishing this work should be part of the "Convert unit
> > tests to use the clar testing framework" Outreachy project that
> > Patrick and Phillip agreed to co-mentor. This project will only start
> > next December though (supposing a good Outreachy intern is selected),
> > so it's fine to discard it in the meantime.
> 
> And of course it does not have to wait until December.
> 
> If anybody wants to work on adding a unit test for oidset, they can
> do so immediately.  A new unit-test, including the oidset one,
> should be written using clar framework.

I'm also happy to help anybody who wants write such a new unit test
suite.

Let me use this to give a quick status update regarding my upstream
quest to address the feedback I got during reviews on the clar itself:

  - There is a .editorconfig file now.

  - All the cross-platform compatibility fixes have been merged.

  - We have Win32 wired up in CI. Doing so via Makefiles was too much of
    a hassle, so I converted the project to use CMake for easier cross
    platform testability. The fact that the project uses CMake does not
    impact us though, as we wire it up ourselves anyway.

  - All memory allocation errors are now handled consistently.

Currently in review is:

  - Self-tests for the clar, where we use clar to assert that clar
    works.

  - A small memory leak fix, as well as wiring up leak sanitizers in CI.

I've also got a patch series sitting locally that introduces type-safe
wrappers for the assertions that I'll move into review once self-tests
have landed. That would then address the last bit of feedback I got, if
I remember correctly.

Just to let you folks know that I didn't just do nothing after this has
landed in Git.

Patrick
