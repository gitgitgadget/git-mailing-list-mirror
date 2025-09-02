Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E38401E9B0D
	for <git@vger.kernel.org>; Tue,  2 Sep 2025 22:38:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756852717; cv=none; b=RPYAAHEGe+VWLo+UcjGZGIf6iDax2+hrtt2m4RKZJRCuqFk0cUGiEaSmFk9ifzRodNmtC3yfeBsw1+Fi+8B/PsvvsLpGT9ty7kvpnq2+ebMkiuPGryvRN5qS8LPVndrpzqUd2KtBYcRop3FMedXS0cV31Pez+Pw1DJWN0dWYxEY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756852717; c=relaxed/simple;
	bh=h/ZjycPAaKcxBKtxl0A23z6KRFiAw+R3X9ooCBu4BUw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YtOYPrKRNnGISQ5oPpD79QEuPaYFnJrjBtqj+KSXw9ikp+TW7N4U758cWas9VwupQhbMQPKWAa/mxWcqyYc9L58+s8Fup+DGVrAX+GWXU9Q5btXNbuAhaGcewR4cilpJXFp8ogbteve2x8mTiZVdYwrFdlel0coaCX8jWkyGXNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Oa/gTytZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=aMAR0txW; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oa/gTytZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="aMAR0txW"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfhigh.phl.internal (Postfix) with ESMTP id E6E6614000EC;
	Tue,  2 Sep 2025 18:38:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 02 Sep 2025 18:38:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1756852714; x=1756939114; bh=h/ZjycPAaK
	cxBKtxl0A23z6KRFiAw+R3X9ooCBu4BUw=; b=Oa/gTytZ1xojvyE63eeUZlp3/S
	pHpT/2uTNRZIRzXvLK4flPQHa/9o2KcCP0pE2H/rUWB7dTcS4HH3zA2Gpwa5UJXs
	4gJJ7il+KyS1qkk6LEzj7Z2d9Ra98q0k0BxBA2FfFZkbGEXRetg+v02taeMNvHGZ
	C77NVEZWNZCE5F5Xtzy6C8fVFLQCBILqlBQgp4eA75UePWNkSa5X7mWzg/+3etLk
	QdQnC8ipoKTKpAzRk7/M6kd/Snj/ypQKconVWi/pxklYHEO4vemDJDJD1Gl8lbwX
	7qHPE1ZJbQzPqIZKfo60yFZKiitelYjnklhsrNu+u6afUT7Q6FVjhQ+3NRQA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1756852714; x=1756939114; bh=h/ZjycPAaKcxBKtxl0A23z6KRFiAw+R3X9o
	oCBu4BUw=; b=aMAR0txWbhu2ktwUtH4ezkRZAnbpXPLcC3M2Jk38ftX/p3XtvFl
	WJVvtssS+iNi9NGg8BiHUCswUJ6O5q+ZNq4UIKrT/Ekt1o8eyIozlJtDy9ZYtBlY
	LomfpdDerJHipmN17W0gMdVR1i3AB24FYYRPFzpzDuqqKFjkDPGxa3sKHji6a/56
	DOAJ9eg4ONUB/rNih5HTbcdZs+ntNwUGXI4qRBtKLOIEKSy+GnFvDaTH41rRWA/P
	zgtLPXP56QXwisJ2Ojnn9fiuFWJsjV33eSxjSk4hH4FZuND1w3hFR/lR5fN6OQEW
	BwRm3a0zvZAVVpHjgGuoHKQUt9/VOvln+Wg==
X-ME-Sender: <xms:6nG3aAdHOpDmgWfJTuLPOzDcknn_kbqe9d0AWYIeAgjn5DJm0w_Qug>
    <xme:6nG3aNsaJ_TxW7tYMdPVN0_nWitpGnUJOXYJWfOlBuPpfaJ1vRNcLb-HtjL1wVUQW
    5DHV8zG2souOLMgmg>
X-ME-Received: <xmr:6nG3aH9bTEgyuRE5JUGaqsdRCK7w9rCkFePRS4MTYL1qpSRY3Sj6XUaK1Mfh3IzVYWdvsDgVmP2cmOCRE1-0dDhJg1dE6Lm7hQJkBtY>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceurghi
    lhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujfgurh
    ephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcuvecu
    jfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrthhtvg
    hrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeeigeei
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepghhith
    hsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehsmhht
    phhouhhtpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhl
    thhosghlvghrsehgmhgrihhlrdgtohhmpdhrtghpthhtohepshhhvghjihgrlhhuohesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:6nG3aA3M4BJkkYFDwRyv4UVYCxhn1z7eUl4z-zXxTIH5LwGTFTTdng>
    <xmx:6nG3aEDpAmeJedH5DTpvCCURj-pkD6p7sNbz1tFhe-ta1SyB4FQHcA>
    <xmx:6nG3aEcYBlfAsaBUoLDFYtTj2DT_14IZmKeotXOu65wvLqi6g17xEg>
    <xmx:6nG3aJ5hTXLvZNhVRtLEsh9uKMaTHBnCQ9UyYTuHKXBjiY20DU49IA>
    <xmx:6nG3aMO_dMhLlBs1xZbkGsZ1EcxmGR6sHGIVBiYE_lplMG3mRzegToaf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 2 Sep 2025 18:38:34 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  jltobler@gmail.com,  shejialuo@gmail.com
Subject: Re: [PATCH v2 4/5] refs/reftable: add fsck check for trailing newline
In-Reply-To: <20250902-228-reftable-introduce-consistency-checks-v2-4-4f96b3834779@gmail.com>
	(Karthik Nayak's message of "Tue, 02 Sep 2025 09:05:24 +0200")
References: <20250902-228-reftable-introduce-consistency-checks-v2-0-4f96b3834779@gmail.com>
	<20250902-228-reftable-introduce-consistency-checks-v2-4-4f96b3834779@gmail.com>
Date: Tue, 02 Sep 2025 15:38:33 -0700
Message-ID: <xmqqseh4h446.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Introduce a fsck check for the reftable backend, which checks if the
> 'tables.list' contains a newline. The reftable backend writes a trailing
> newline when writing the 'tables.list', but it doesn't check for it when
> reading the file. A missing newline however indicates that the file was
> manually tampered with, so let's raise this as an error to the user.

Hmph, how does the code react to other kinds of "manual tampering"?
For example, if an empty line is inserted between two existing lines
(or at the beginning of the file, for that matter), would the parser
detect it as a corrupt file and die?

If so, it makes me strongly suspect that we are better off enforcing
that the file does not end in an incomplete line at runtime and barf
just the same way, instead of "most of the anomalies that the write
codepath would never produce would cause error on the read codepath,
but only this one that the read codepath is happy with is caught by
the fsck", which does not sound quite right.

