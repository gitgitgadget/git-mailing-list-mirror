Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61C2A13AC1
	for <git@vger.kernel.org>; Tue,  4 Mar 2025 22:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741126008; cv=none; b=pSAk3bpCpiGx+wTEqHZJB8ppeoZC35qcZvJft19ejhAba9ZNN2pYzIB/fekknd9/ZxgndMri3sZam76PSkg5AuMcJZVdqCogKBDPtdRuZXoqiclYqKnYeVhfh/O+47lQcTTD/JqSWrialtvF7MGQZbEND05nloCJ6q+vloNq1kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741126008; c=relaxed/simple;
	bh=JsJ7y3ex9KExc4k8Wz7awKY4wxQmefAwczx1vTW4iQI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=hRejs6xrn1aKEV8XqLNeaENcDXx74MbyVcRtGiUSBevVhskliAN37FEg4lEFqiyp+ufN0hYf2esJJ5xDYEmL+aFyQ7lVGQ20E/CqplKfE2iJxOFLzvLp4UNpAuTwwU1I1jiZtHN2TkXzJxQ/g8CmFH9/0f/kiSi92NM6D5ozu7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=F32P6n6S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=WdVnU1Jg; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="F32P6n6S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="WdVnU1Jg"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 7401013826E4;
	Tue,  4 Mar 2025 17:06:45 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 04 Mar 2025 17:06:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741126005; x=1741212405; bh=UrzJrpoLa1
	45NK9N4j7M/NyiGiyIvYyZWv5GKJHkvj0=; b=F32P6n6SFE+nFXq0pnGezUeX/3
	eCIPnWCZWfFB7+PMetd4shx2gvet8RczfnzU6JtDc2+N/00waXlsE+ZAyvkjPFYN
	BIaPk1QgfHm2eG93RwLVW1oojtVQWQ0qsnBddQhhF7YlxTOUXgrK0YIhVMiI4w02
	RlOT9cNDeSP+fFg3GlGybT6YML3t3IT7ytfCEl8aTqgOmtQQaPlkHh3JfDYPDFhl
	ghaAqyEpAj8gbPnvtjujQBeuzMFNPh0l3cDw7b2UMXKF9tlSDQ5x8lwCNV3P7ZDh
	r4euyPkXTdC/49GwIkNqoiVRJXZ13wzxVhw3Linbx1aLvMI+fM7yZTA7HQEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741126005; x=1741212405; bh=UrzJrpoLa145NK9N4j7M/NyiGiyIvYyZWv5
	GKJHkvj0=; b=WdVnU1Jgsw8gseW/sxtXyjPV61KKTeAt5wuq9xhdafcTth7LBPP
	cT+ondf52VcczGmky0TVfW5PoLDrAo5oM8fW+ffnUujNQtByw/Qn/YX3sO/xvPiA
	vWi0cGr7+E4lfHMa4wzD3S6p07TeIYHcied2RqTBJFBL6bQwuc4lZwSBD7YHSD96
	oXEfYNDqwZSsYUD7YLZN1JoChu+vyQkrFs/bzXnE1MIutTWfFxysOZepM+erS+n9
	SabFSdEcQcUOKm0wW6dcZqj3UuAHzRV28i/xIEvELvuriYyrLk8p3eicypU3NGn/
	bAW/mKPAcUkHKgf5f+Qh3recDdOd4tB/4VQ==
X-ME-Sender: <xms:dXnHZ38kLC1TW21mputnHSKv3YYjKKm6O5fDXRh-QYJMxmdwMSNLLQ>
    <xme:dXnHZzvAn_NXKuMc_zLFG9AXwDKelISckHYBgwZHlSivnCZhu06T6jV41IYs4fXNL
    xj5dkzwwPOW9_BdYw>
X-ME-Received: <xmr:dXnHZ1AzfpmS3_2Lf_jasmiYBF7uTjtcI-alBimKizIh-qx2UfM0wr-oc6iGIjLkYpeiSA3OsvlJDY4_wzpEGkKnFoSrpkrSdO8w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddutdefudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrd
    himhdprhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtgho
    mhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:dXnHZzclea9TACzqUKhX2EzbZybMNMeNaW1TvoiUhPKK7koiUS1_tw>
    <xmx:dXnHZ8MG_MpEAU1d1lAc0Xt42PJqeH-MhrNgRLSDoHJveLygs4YOaw>
    <xmx:dXnHZ1mvDLLAxsHbqru6uKlFKbI9VxZKUpMquThfEJrrStPXb8RSuw>
    <xmx:dXnHZ2swmnshjOQuH7YIcE5V-8h4Ke8eBab_rJEdr5oCInOUwM0pAA>
    <xmx:dXnHZ5pBW3wTG-InjHOAD0AFxNypACLDmit-SLtERy0OQehymN71G6n6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 4 Mar 2025 17:06:44 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>,  git@vger.kernel.org
Subject: Re: [GSoC][RFC PATCH 0/6] Add --subject-extra-prefix flag to
 format-patch
In-Reply-To: <Z8aspywaD0mAyHwd@pks.im> (Patrick Steinhardt's message of "Tue,
	4 Mar 2025 08:32:55 +0100")
References: <20250303220029.10716-1-lucasseikioshiro@gmail.com>
	<xmqq7c55vhj8.fsf@gitster.g> <Z8aspywaD0mAyHwd@pks.im>
Date: Tue, 04 Mar 2025 14:06:43 -0800
Message-ID: <xmqq5xkoo3gs.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I do understand though that `--rfc=GSoC` is not exactly discoverable for
> a newcomer. Maybe a simpler fix would be to introduce an alias for that
> option that is more discoverable? I don't have a great idea for how to
> name it -- the best that comes to mind is `--patch-prefix`, which
> mirrors `--subject-prefix`.

The problem with it is that having "patch" vs "subject" prefix will
make it confusing which one is which.

Let's step back and examine what we already have.

 * The "--subject-prefix" is configurable and format.subjectPrefix
   is meant to go to .git/config for repositories that work with
   projects with special needs (they tell you to use not [PATCH] but
   subproject specific moniker like [PATCH rcu] instead).

 * The "--rfc[=<word>]" has no configuration and it is deliberately
   so, as it is meant to be used as needed, on occasions that call
   for it, pretty much decided per invocation.

Are these two points above not clear in our documentation?  If so,
we should fix it, but I do not think giving a synonym to --rfc is a
good way to clarify it.

If it is a GSoC topic sent to this list, it _will_ be GSoC topic for
the entire iterations of the same topic.  So it would be good to use
--subject-prefix="GSoC PATCH" (or configure format.subjectPrefix in
the repository to use that, if a student works with us only on GSoC
topics during the Summer-of-Code program duration), and on occasion,
when students are not so sure about their patches (yet), use of --rfc
would be a good way, which would give us "[RFC GSoC PATCH 0/6]", to
mark the patches as such.

Another problem with --patch-prefix synonym is that --rfc is not
necessarily a prefix.  With

	git format-patch --rfc='-WIP' --subject-prefix='GSoC PATCH'

you would get "[GSoC PATCH WIP 0/6]" instead.

In any case, I think it is the root cause of this disease to treat
GSoC mark as something extra that requires a new marker that is
separate from the usual PATCH marker.  Using whatever mechanism you
would use your string in place for the standard PATCH mark to make
it say "GSoC PATCH" would be the most appropriate, without mucking
with an extra option, be it '--rfc' or '--subject-extra-prefix', I
would say.

Thanks.
