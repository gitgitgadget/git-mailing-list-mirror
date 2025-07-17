Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFDAD282EB
	for <git@vger.kernel.org>; Thu, 17 Jul 2025 05:48:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752731322; cv=none; b=iYGB+WBTO7fZ2pOfojXeU8k7PvFz4Qnjh+e7YFRVyM09tlYRc2ubOTvbqpqew1rt+f4NBBi037oz4EXW+AdWlLMf7YHem24rEwJkiV5Qt3hoAHBDd8+t2TIME6GKW6iwMGaagrkhFRbV230dkydGc69KrIkzL+iV0kWeTt9Zl0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752731322; c=relaxed/simple;
	bh=pmUBolmDGHy9xs+mXLZ8L3g6sLdsniLxB4iyw4jWJDE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=bsGB248ZIqGAMWrHw4t5k9zK7RagziiFdfQhk+JSUo7AZBn0htPo5wN0/6vdYttwb6nCyuMNolrnn6D8x8ysXvcFF4fbQsk1q6mp8Ao3eSDmsVyJ0esyNOW9+1DCXyqTe3yQAuKh791KLE11ariujkE/EFPdMcLx/ZzI5Pjvfi8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=J2jD43CX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=gC26AmhJ; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="J2jD43CX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="gC26AmhJ"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 813531D0017A;
	Thu, 17 Jul 2025 01:48:38 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Thu, 17 Jul 2025 01:48:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752731318; x=1752817718; bh=kf9+oNu6Yb
	Nhjmcq/Q07o+BuSAMyknCX13iVvMltQ10=; b=J2jD43CXcC3zdfT4igvaBYTIiX
	ymClU1sGuLL6wgRngV5fuqVrTVqNFUyVcmN04tawdHLR4bI0BArNMLvgOp9F2M5d
	aNXWyIVwD35Me/JwfVZPzamhRgE9A7ohlPUSnJA2g45hLDd+CImJ2rcNltjq1SUT
	kgSJ5l8HzkzHC3kb/H0+cfZnP4BR55QUIIvGjC04ybwrPTxKKMB4zNbD3bvUednC
	T+SNzwxV09J6U/RBfY9miQzAV9YtmAGo6Qne+CmSITrXoQzXB15cFQX6XmgqPsf/
	mK4H97xwdEakiPapgYCFUcvOaS+cZt/LLUzBJ908JXSh28e1n4mZbNxxx/Bg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752731318; x=1752817718; bh=kf9+oNu6YbNhjmcq/Q07o+BuSAMyknCX13i
	VvMltQ10=; b=gC26AmhJMGUZdqJNQyV7EP650zRc37/ZxUErPhntA/ssK0WaIua
	/5QrqRHfJ3WFkmS0u2QNQ2zw0pNuwzW4TGN+P8d7DkqXfXmoK+uyOZejaOCFji9e
	Lf60tz9dV5qNO01tg8HxwlBCxrR/qnR39EJz60q96BkMqqILDBrJFcVLr2HWOu1W
	ILKquR2IjMlYqOd3vdJOsTu+7jIiOpU9Nf5t4oMm+UFFw8XZ8mRSaDtBbvcWN2nP
	SCMslQ4hKqLKLr3p+cekgk+QYjUUgPlT7L8he30jqX9vWH4iTfwS9TeV/4L5NV+3
	BvFHpcSU658IrVe9B++6RUfz2PYNs4SmhrQ==
X-ME-Sender: <xms:to54aDrLkt1rtm4dj0G3epB3oPfglDpSvlBbrErtkNtaF1NBpzgthA>
    <xme:to54aJI2oYJq4pLOLzT9pLqPKfpzvw6qF7BIwrBZd-Pn1_y87iQd2dWi6H_pV6LQ9
    9ss-56BFHcqksneWw>
X-ME-Received: <xmr:to54aGqS5OWc-croTCFTaB1ksrI0r_kpy8B1fGam0QOUyzEqgupnSYx6Kf8KoVaGNvdtutuThwmt3cNQYYxhx_LoUsTyq0oE3Vvx-fI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdehleejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopeihlhguhhhomhgvvdguvdesghhmrghilhdrtghomhdprh
    gtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehjiehtsehkug
    gsghdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:to54aBxQq1i6goazqVaMQNUlrZOhOt_LQOY2NOv-gWQoPxHgRFKgVg>
    <xmx:to54aKOdttBEoS94WTZbcf2LRQ38U6VbQpalUoQPPGvWQmc2NMN5Wg>
    <xmx:to54aG7Y3vFklgGNlOwnpmM3rWFUTKtfwQRWuLAQEVEjm3k5jvdycQ>
    <xmx:to54aDk8LhOHy07NLUWWfVSHnwz4qmHtGEtbx74a7rla2pCptRLl-g>
    <xmx:to54aP_Ynm2mS2StMhyBwFotFCxnJIkwBwnOn6MfNWCoq8CqTelMmvJf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 17 Jul 2025 01:48:37 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Lidong Yan <yldhome2d2@gmail.com>
Cc: Eric Sunshine <sunshine@sunshineco.com>,  git@vger.kernel.org,
  j6t@kdbg.org
Subject: Re: [PATCH] pull: add pull.autoStash config option
In-Reply-To: <174669ED-8E02-49BB-BD61-277DBCA4D890@gmail.com> (Lidong Yan's
	message of "Thu, 17 Jul 2025 13:01:42 +0800")
References: <xmqq5xfsdv3w.fsf@gitster.g>
	<20250717030732.75106-1-yldhome2d2@gmail.com>
	<CAPig+cTQ017qGK_Qx04+R_0rCXEOirW+oLEjeaDoCFJiQbnsGw@mail.gmail.com>
	<78DFE806-5DAC-4A90-893B-77F32E393E07@gmail.com>
	<xmqqms938mbq.fsf@gitster.g>
	<174669ED-8E02-49BB-BD61-277DBCA4D890@gmail.com>
Date: Wed, 16 Jul 2025 22:48:36 -0700
Message-ID: <xmqq5xfr8j0r.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Lidong Yan <yldhome2d2@gmail.com> writes:

> Yeah. Though I considered that when pull.rebase = false, checking
> merge.autoStash instead of rebase.autoStashmight confuse users
> who rely on setting rebase.autoStash for their merge operations.

Yes, that would be a behaviour change, but it is just one time
thing.  You notice your "git pull" do not autostash and instead
stops, you scratch your head and go read the documentation, and set
pull.autostash to true (which as I said I would not necessarily
recommend) or merge.autostash to true (which may not be as bad) and
move on.

I didn't consider it when I wrote my earlier message, but I like
your idea of defeating rebase.autostash and merge.autostash when
pull.autostash is explicitly set to false very much.  With it, users
can set {rebase,merge}.autostash to true so that their local rebases
and merges, for which they are familiar with what both sides did,
would autostash (and autounstash), and set pull.autostash to false
so their "git pull" would be stopped when they have local changes
that would interfere with the operation, if they wanted to.

Thanks.


