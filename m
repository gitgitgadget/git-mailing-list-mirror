Received: from fhigh-b7-smtp.messagingengine.com (fhigh-b7-smtp.messagingengine.com [202.12.124.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C261A168BD
	for <git@vger.kernel.org>; Mon, 26 Jan 2026 17:35:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769448925; cv=none; b=PTGGtFYYj0j3CTfmBU9x0QPa6bD74YIN1CkyiVs+YunFWCDrqpF9B741OrB4SvI6fOtgCL0orgtvuQ0XUAQuUk5RiHCG9QvY6szbTvA848PJ6knfQJLy+21SQBDoVUL2/kSKkRCPRDKo7fn/ljm+lYZRrVok1I/fTa60nsGqzz8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769448925; c=relaxed/simple;
	bh=EuYYST1aITEGKWU2MyFVCH2TztwLXbLeM7r6nA06t34=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RrL+QlWsteQiz1iUOnqwU3c+dA5zsYWcd8AaobIuWAYbBNLV8h8agFpFl0laNud7xoRbSwuJ+XDAS1xGzzFJMTBkvabkiIgRH8Jf8WNGvCY7y6HGEllNRolQR093OHisXBVgDjx0oPih9ITBPw4IP7iWYewINIg5KaarUi9Iwhg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=QVtpj3+L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dhIE7aTk; arc=none smtp.client-ip=202.12.124.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="QVtpj3+L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dhIE7aTk"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CCAD07A0111;
	Mon, 26 Jan 2026 12:35:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 26 Jan 2026 12:35:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1769448922; x=1769535322; bh=SLGGwhete8
	5uUoHgNY/XR1QShvL1+kVYTOlmF0fWLLs=; b=QVtpj3+LTRkNeZG1PjoviYnqSX
	gbe7iCtm/O03V7dE9uSQdm/sM9+xGp2NOpyY2G67dPi9khluFdOc62fPqnvt/q73
	q1F+WA7tj+zY4wYz6jMNsvF7RVZ+7/n2Razypf9kk+gxQhaBAPpP55imFICcfRFW
	G1IFKVyQil+TTp2UEZK/ugbFUDW7sc94Bby5bOpq9mm8/i4wMFiriVdcDFU4v3IT
	NhyS+U1x6sTqMYf17g47aNSPdgiYy7OWXEk8zrcVrpGf3fG0oa/uL6t6qUDxu/S4
	Y0KLxXEWd4mccsMNO0Ayz978Ujv94g4uZuUyzl03qzvhVXa7Nwj4CU1DebDA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1769448922; x=1769535322; bh=SLGGwhete85uUoHgNY/XR1QShvL1+kVYTOl
	mF0fWLLs=; b=dhIE7aTknD2yjdIrh0KiissqIAF6+1vQ0AJzl0dbDrOPV9SNi/k
	bGV2Pin+YbThDD4bGwnbbkEIJVtycZ765zqE7PQ5Z9+top/0fm/ko+ZMPNJoJk2r
	cTYyiR6NTKQ/6pebRWw5wuyu4eAJ2PEakstY9pM6BFTUEQ0pwgKqbQ410Vi96M5I
	EPrs1kXWiMOvk3EgUFCEHXMZgp0mlA1iA4TWMgQI0j+GxoJvfaU96vkHGGJnJxf8
	gkpff1G3LgI2KZcw0g+d/gsvnMU/OPbdDEfxA5LPjIokEx3qCD/XIdeajjsrlnOd
	P/qm564UNn468S92AJgh7inrsquc+qR/BNw==
X-ME-Sender: <xms:2qV3aZFM8sKRRGxq_ZbN2DnMfmKDtDsGkELDor1uwmTdCIB_DzbkLQ>
    <xme:2qV3aVWgz2jIJzA3vzAQpIgWAMYeItnZC2BOpPIWt1OIDSa0QY_1Pp_k3Qv2TR-Id
    pACN-vmalQrIgfA8tmoyRMOCNWL8LHvYDvKAVGfmfp0w3sJ1rahFw>
X-ME-Received: <xmr:2qV3aQKwuRwT5XeqaNOeq7-FRvblLzQpc_cAyzS8Fh4s7p86hJtOFx3zSp83k7Vj4r03-8tGNLA8iSMU1nfx9WhWNWPX6r4wwtl3Y48>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduheekvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepgedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilh
    drtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghp
    thhtohepvgiivghkihgvlhhnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhope
    hgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:2qV3ad_KKeZPnDZTB9GvDez5ju6PVlgq9Z3XRLJ1PQ65F0wFxPKkVg>
    <xmx:2qV3abLw5KAdgm8UoexvlaKRnCYab3H4SJA9a5s-60Em_MaV9PFpjw>
    <xmx:2qV3aam1aMD8dAHP8cYjCzMgZBz_ZdyEjc5Hj1YNaBYZ8eaYyJN58g>
    <xmx:2qV3aXNCgo0Fajm850y_41TF2lZPd8JIVC3nySVRNC6wXFAH6L_dlA>
    <xmx:2qV3abosFokRFKDoF0RDAWT82Gqp_IgM-kdSw8qZUvmC1rQjLORHI3sh>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 26 Jan 2026 12:35:22 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: git@vger.kernel.org,  Ezekiel Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH 0/2] xdiff: Remove unneeded members from xrecord_t and
 xdlclass_t
In-Reply-To: <cover.1769424529.git.phillip.wood@dunelm.org.uk> (Phillip Wood's
	message of "Mon, 26 Jan 2026 10:48:50 +0000")
References: <cover.1769424529.git.phillip.wood@dunelm.org.uk>
Date: Mon, 26 Jan 2026 09:35:21 -0800
Message-ID: <xmqqtsw8i8fa.fsf@gitster.g>
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
> This series has a couple of cleanups on top of 'en/xdiff-cleanup-2'
> that reduce the sizes of the xrecord_t and xdlclass_t. Unfortunately
> they conflict with 'en/xdiff-cleanup-3' in seen, in particular with
> db8a50ca6b9 (xdiff: don't waste time guessing the number of lines,
> 2026-01-02). I'm not particularly convinced that moving the call to
> xdl_classify_record() out of xdl_prepare_ctx() in that commit is
> a good idea, but if we decide that we do want to stop classifying
> lines in xdl_prepare_ctx() we can start passing the hashes out in a
> separate array rather than wasting space in xrecord_t.

Both patches look well reasoned and sensible.

It is unfortunate that the en/xdiff-cleanup-3 wants to pull these
fields in a different direction, but the topic has been dormant for
quite a while, so let's tentatively kick it out of 'seen' and see
how well this one does, until we decide how to consolidate the two
topics.  Thanks.
