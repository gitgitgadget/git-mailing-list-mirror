Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9EE21E573F
	for <git@vger.kernel.org>; Tue, 11 Mar 2025 23:29:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741735773; cv=none; b=XWA7LQRpVxHQowWu+aj2awi0og4H3r+l4mE4oHS6r0YNw5Z5E3lCENG13++t74XBqUuTv/75MP/Zkr+1En7ILd5BVZoTM39RWCySLBgqtIpYYYuQE2xbpKkoU0KIdopK1Vmjsyb1/d/mZ7noWXLivqV6JOVo3jZ6LsXCxOqv3SU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741735773; c=relaxed/simple;
	bh=HsTNsnu96xP08gNCWRHl8iZ9KLJMvU84zUtb8El2pec=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eBQfVKiIUXoOiaASLgjvbYiV2f/qNPS0Txs8tnMHpiEnVyvyFARQw4G+M79Z8xYDBL8IKdAis8xAw29gRPXGhoFgl+Uwvd6iOPblAswl54kEpspv0HDNiFYfInBExAxihks3YWo09z8fYDTyChHyeL+D4p/RsevHMEYxHsVG6do=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=G0nw8GwH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=m3svau64; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="G0nw8GwH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="m3svau64"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id C981F114011F;
	Tue, 11 Mar 2025 19:29:29 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Tue, 11 Mar 2025 19:29:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741735769; x=1741822169; bh=msrLXiuI/X
	NtUk60S0ek8S3/C4hFwtnmtTS68qDDH1Y=; b=G0nw8GwHXQfZQH2ACzf+bq9Vni
	VninKOtjcjhtTrItSc0OGc1og+bNksbMcmgCbIMSz+0yOwRUEFTAchOuGSlUn7Eu
	YqnKquVVzmabozH1VWMPMEgoVSHY+r/JqbK4yAH3Lc3f8fzfdalUkogxv6jvBooN
	8Nk/oUKM+QOaJYFiFMBDpO3PSkfwXIGDfD+KwPv06lOjDcuXx/Uk2kGWqlU1MH/G
	LC5fZM0Oo87PPRq+g6gPzxfXtO8QbARM0jtJG18d90bs91Fj/0+lXI/njl+LB0K5
	5bXEEHLzvQkVPjbXy2v9ZAGhL+REv38Cop9NV2oklYEqyVawG/bAk+2y0YzQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741735769; x=1741822169; bh=msrLXiuI/XNtUk60S0ek8S3/C4hFwtnmtTS
	68qDDH1Y=; b=m3svau64e5NTNJ8LWZahcJrGm+i/8yCq4ujZrnOdHsBvV/6a+/I
	x4ELP6Y31lBFqi+51uDsxQ/ErlBYPRXxyTdZ5+3dt7/nUQjFAQtP9ElLRvma0MNM
	d+nTSFNrUv61gMSm9MGzy2HfOCrhwjfuV+BbKGQ+5EEbJ/YPkYwkJ0G1qEXG1Eht
	3mDLpLCgmb74wPzM9K0BH3m184RnPGCVFM/7qf6WK/Y6Big6idwlEzuwqfwR55o/
	23g3b6Z6zO0i/jeipToPTU7mkRu0WOYfyJ0Hp0/gRwLwF56HrHrHRBVbCUr2s9zK
	imSRywtKrpzkBwVea2HWnZdeGPiVAfN+D6w==
X-ME-Sender: <xms:WcfQZ0sNOv3rPah3XIfczHseSQKxX1eipdynuWR31f-UMdywTVbZEw>
    <xme:WcfQZxcnw4xAqKWLhh9kuZcV4MDUA1wsAjOkgAuohdf2kpNEHh7PLsLp9CKNimmUG
    wDha2NEKKv8D2RH2g>
X-ME-Received: <xmr:WcfQZ_ymyjbYMnsRYJ1OEmCiWxs7J7lcGd8YGPsfJnffA0yYSX5BV0OVH7GOm6Jq0VWwat48UuCEL5h3b399CPdT77a4T_HKuDnV>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdefheduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnheptedttdevffeuieeilefffedtiefgfeek
    veetveevuedtlefhtddugfeltdejledunecuffhomhgrihhnpehkvghrnhgvlhdrohhrgh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeekpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvthhhohhmshhonhesvggufigrrh
    guthhhohhmshhonhdrtghomhdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdr
    tghomhdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehjohhhrg
    hnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehtohhonhes
    ihhothgtlhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:WcfQZ3PtgiMlvgGDactAWicn36p80oWfzx3pZr4kL_ISstgsurtiGw>
    <xmx:WcfQZ08wXJzBBVNxCrGeNah6Tm3na2eCHW4iwrLKOxiQWO4qzbzqBA>
    <xmx:WcfQZ_UnYvIEwEgto4Zww0pyDebGoQtNVjB77NHA3b-s-nUfLisiYw>
    <xmx:WcfQZ9eyKiK-X-27Rh2_zVTIOx437hB6DCsA4XqByO5yNC3NhRP8sQ>
    <xmx:WcfQZ4RGoeCGJJKIDaUbsbrnL1cHphqe1eE3KSmH5lvGkFpVRvy2aB-n>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Mar 2025 19:29:28 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Edward Thomson <ethomson@edwardthomson.com>,
  Justin Tobler <jltobler@gmail.com>,  Johannes Sixt <j6t@kdbg.org>,
  Johannes Schindelin <Johannes.Schindelin@gmx.de>,  Toon Claes
 <toon@iotcl.com>
Subject: Re: [PATCH v6 00/18] reftable: stop using "git-compat-util.h"
In-Reply-To: <xmqqjz9nkrqt.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	18 Feb 2025 10:55:06 -0800")
References: <20250127-pks-reftable-drop-git-compat-util-v1-0-6e280a564877@pks.im>
	<20250218-pks-reftable-drop-git-compat-util-v6-0-8c1f39fb4c02@pks.im>
	<xmqqjz9nkrqt.fsf@gitster.g>
Date: Tue, 11 Mar 2025 16:29:27 -0700
Message-ID: <xmqqa59r2lk8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> Changes in v6:
>>   - I have rebased the patch series on top of "master" at 03944513488
>>     (The eleventh batch, 2025-02-14). On the one hand this gets rid of
>>     the conflict with the zlib-ng changes, which have meanwhile been
>>     merged to that branch. And on the other hand it pulls in the new CI
>>     build for MSVC+Meson, which allows me to have better test coverage
>>     on Windows to better detect breakage there.
>>   - Stop moving around Win32 files so that we do the minimum viable
>>     change in this context. Hopefully, this makes it easier for Dscho to
>>     integrate into Git for Windows. If it doesn't I don't really have
>>     any other good ideas for how to do it, so the only alternative would
>>     be to just ignore Windows altogether.
>>   - Link to v5: https://lore.kernel.org/r/20250207-pks-reftable-drop-git-compat-util-v5-0-ba2adc79110f@pks.im
>
> Thanks.  I think the "unlink" thing on Windows I have was queued
> depended on the previous iteration of this series so let me make
> sure that I'd unentangle it while replacing the topic with this
> round.
>
> Will queue.  Thanks.

So, sorry I lost track.  I think I saw you ask Dscho about the
Windows specific bits once in a thread on What's cooking report,
but I do not recall the outcome.  Is this topic (and the unlink fix
that depends on this series) now OK, or would we see further updates
once 2.49 is tagged?

Thanks.
