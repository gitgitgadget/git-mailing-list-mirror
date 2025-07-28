Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E693B273D6A
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 15:43:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753717439; cv=none; b=OYnzkkeukKFwzCvskXyId8viAtwpmMQ/j++82f4aC7KexAKG8vWdbIcb0tbOnEru8T8lNaRG3lhETVgUeVieBGwE0hbMvpvW54+uCdprrERuGOnHRHAlMkbLmOMvZt9HMPn/FcFJ5RLCvUN805wJA0f4vac+EtYsJ6/iNvHV+48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753717439; c=relaxed/simple;
	bh=gg649UjR6qZgSrvgAtqZq7EyFudtG2Q72L1tGY5Hfko=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FUBUJ0F8/cNbU8LpkdbQptYAzml868bDnpYlr3iDzkYuUtTBLHt+KPxI6A4TxBUB9h7f2kOnUy8lktyDNGeibV89tPuHPv9NbXgvfIzQ7oZNPZR1kmiCiIzGBRuMx1RXd4uftShQP5fni3Zn35RkHuaXvUIBddXF4/ighEcRfXo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=kUJB5Jfj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=QN9THrlt; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="kUJB5Jfj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="QN9THrlt"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfout.phl.internal (Postfix) with ESMTP id F34CBEC006F;
	Mon, 28 Jul 2025 11:43:56 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Mon, 28 Jul 2025 11:43:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753717436; x=1753803836; bh=AVL67fTMl3
	aGdLN8fegbGTWZISJpQwFyXvRNtw2fLHs=; b=kUJB5JfjTj/qutNGnm+wbOa51+
	w0LIVmaA/dI3f3mLHrEGlohU+SQHl7pqwxuopfjtwWCzPggTCMzGSvjxHu8w9d3L
	3iLCenvm7y8n2VdMOkZai/B1yqOEDsS1o0wOBUbzN/gsOctl6St/2+uQV2vozQ4z
	TvTSRmbhRKBkhMxuOtEIgdMty5LnAAhyDSyPYH09YlQpKNQEi6AOlSudawC9L5hW
	+6E0J4O08TNqtmYSgizvbIhrDnYhwVFtgICSvJ3C4fadqe4MrTg5zMLnADIVgE71
	/SeKL+6zBw2yH8b97uZLRLj521hDM/t0eZnizOowtVms70ADDOi6YZ4oDtbg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753717436; x=1753803836; bh=AVL67fTMl3aGdLN8fegbGTWZISJpQwFyXvR
	Ntw2fLHs=; b=QN9THrltvHqlLQOqXjxEmAnLdXy4YDjjFpcyY2z2QWeaz3EXJy6
	CVgWMIZzZCBgvVNju0usa4isr/4MGB/Mg5VkgQjewf/kS/oTSvrW/0GgAz/S3byi
	MGwpR+st9EqXhSIizDWcQeM8CDgGywRRrQLSwELFf3W27SzvUvqmFfawHa30l0ne
	KK8qQHemWEu1GtrZUsIHFMS+foKBtI0WRRAKhhTjJbVL1dcCe/bX3DGjcH4zQ1i8
	tMTuOiGgs0bjx/D1WDm0ADLqFZZSZha9Fe82yQb3hEsefA+25WWavydNG+EP4lGS
	24paa/4siHcxIucE9KPIk+/Gi/xPNgQFihQ==
X-ME-Sender: <xms:vJqHaOvohFPcXURs_dgm_37qAqr1G7h_8jsmB9edZ_bBMa8_nWJ4dw>
    <xme:vJqHaO_gkB616Of9jIXqV7nn3Xn3wY4JnL58q-ZoONuoqNMEqtJGyMdfHYs_jojQj
    q9Tf-5W8PerY22dDg>
X-ME-Received: <xmr:vJqHaAOqu1HB65Frt7LCc6UNl-N_BHuOodk9VFOFCQVMcTJy3tHWanHFdmeV7OWF6No2vHp5vjEqY8h0ZzNboQNIVVFG2tnIXpInhMg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelvdehiecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffffveevvdeileff
    udenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvh
    hgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvght
    pdhrtghpthhtohepjhhhtggrrhhltdekudegsehgmhgrihhlrdgtohhmpdhrtghpthhtoh
    epghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vJqHaEHSf_EdRe8e3arvzjZD2W6RgJrPS6XifOF-2ED-Rsd13Mr4-g>
    <xmx:vJqHaGRFO-CDs_ausyCQrTipTcfd8wdjVWc6z4rJ1qmnXVbgK-QWcw>
    <xmx:vJqHaJur_b_89Nrj-AVQd8NX2j6GX2OIYGmVIkClacrjv0sisowi1Q>
    <xmx:vJqHaGKUhDu1NcDYyZEnfXsSXqc2TUmI_uLidLKVPgIPh9a2VVxdOw>
    <xmx:vJqHaI7lGP0aL9Xrub4XWkNHu230IADol4qwlZyKWkku3PyHcgRBXLmd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 11:43:56 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Jeff King <peff@peff.net>,  Han Jiang
 <jhcarl0814@gmail.com>
Subject: Re: [PATCH 0/4] builtin/remote: rework how remote refs get renamed
In-Reply-To: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
	(Patrick Steinhardt's message of "Mon, 28 Jul 2025 15:08:44 +0200")
References: <20250728-pks-remote-rename-improvements-v1-0-f654f2b5c5ae@pks.im>
Date: Mon, 28 Jul 2025 08:43:54 -0700
Message-ID: <xmqqzfcowcat.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On the other hand this series reworks the logic used to rename remotes
> so that we use two transactions instead of one transaction per ref. This
> fixes quadratic runtime behaviour, where renaming 10k refs takes ~4
> minutes, 100k takes hours. This results in a significant speedup with
> both the "files" backend (benchmarked with a smaller number of refs to
> retain sanity):

Great.  Hopefully we will teach transaction mechanism to sort out
its D/F false-positive bug so that we do not have to risk succeesing
the removal half of these two transactions while failing the adding
half of them soonish?

> But in any case, it's one more case where the "reftable" backend
> outperforms the "files" backend.

;-).

> The series is built on top of e4ef0485fd7 (The fourteenth batch,
> 2025-07-24) with ps/reflog-migrate-fixes at de7cc0782a7 (refs: fix
> invalid old object IDs when migrating reflogs, 2025-07-25) merged into
> it.
>
> I'd normally have withheld sending until that series was merged to
> "next", but given that I promised to send something on Friday already I
> decided to just get it out. In any case, if that causes problems I'm
> happy to wait a bit before this series here gets merged into "seen".
>
> Thanks!

Great.  Will queue.  If the reflog-migrate-fix needs further work,
it shouldn't be too hard to rebase this one on my end, either.

