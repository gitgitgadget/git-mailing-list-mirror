Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0FCC285C95
	for <git@vger.kernel.org>; Tue, 16 Sep 2025 21:53:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758059614; cv=none; b=CdU7fpvM+aKMuzU4iT71lsi8XwD4KJj9k3CuvDnHF4ijYtQ2aUQjuk98PCZ/0atE0qRCDe+WFkJSmD3jnSxqbVqTd4J7XdBBtqyssgvCP5hLeo+t2pzDzpNmnuCBbuS0zRi0vZ4+28LmbsZzG/RC/J0S/iEWUk++aQMN4lxu9lo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758059614; c=relaxed/simple;
	bh=+wzXslYdWfLuPtxJGlu+XMrQMzRgF65jKnzrexVy54Y=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JHKxh+elNhrv0fUiYc0NrWMRiIgacULiRseVKgEqcQYDNsAYNBKI5v8HsSqyWBpeK4fFReQQjl5z9wvqYfMOJyo0/fvuUhUPgYhGrLxYulKC4ky5YPTby7459x3pz/qPctmxNmtHDb8wuIMxZgI8Gy51EA/LaAz1QvFHVKuqa08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=rvV2dj3p; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ZuEIGtLG; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="rvV2dj3p";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ZuEIGtLG"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id B7BF2EC01FA;
	Tue, 16 Sep 2025 17:53:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-12.internal (MEProxy); Tue, 16 Sep 2025 17:53:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1758059610; x=1758146010; bh=xwJ3TM8A0N
	V46QiQqABSF4YACXzoAI3jRj7Eico+C74=; b=rvV2dj3pFt4Wdiz4QBiNZcQEuN
	AHCsT8jUJsdYClNDcyx0UiBRx0EgvyjlSqvzZgMa7IPMlSCpiUC5EVL//rtJMyIy
	oJYJ9DfeHjykV4XDD6KkO0mTQThoiFAU8AQm04uttZRRZanKco2xEMkgs0UinXAx
	2evltLDKPiT87DEjpZab8DlGqBO01JbB02jXUduoQRn9EfCEcYFh26KzucGrde1g
	Paan0cfOLQD2sxG0AinfXMEgu1cpNwtgARFYcG1raT2eTYkQ+sYklNYYBBPOyIQT
	taVqc5rPZDDdXdOHAoFCqHBSMjE+6jc/ipy/6VbxsbXVHravCp6Yg1OFDyrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1758059610; x=1758146010; bh=xwJ3TM8A0NV46QiQqABSF4YACXzoAI3jRj7
	Eico+C74=; b=ZuEIGtLGOZhEhoZNuFmYu64wpnilTODGRlL6Q42pWEZnCPL43Cw
	QlG3vItlSm/HMDpHpu4APlLm2tWOCIOQFVFO7On3SIYncPDBQOyLPzR8tKwpYbnY
	n28KhEb2ujGLLhpeSpwThtmtiT8d8a+jwrG0FcuUEWWaupknFHeYh7ld6FD79nBZ
	03VSqgJqAsOQcO3PNvGA+gjZ4DPdvk9/OkW+SPE4VF/8FiQlC4RWGe2ZbYDG/4hZ
	80cazkKtxqsXf+1iRYjsbz7J4EB83vrcITeNIpqYPCiIWCEEhTd/0p549NbNGTAR
	D6bezAO5mchbepcgyJU5h+bOw/hs8bLImKg==
X-ME-Sender: <xms:WtzJaFmHMFcBbGyLG4DvnczpF4vddi-8ie41NN2Wjum-9plxKNIvKQ>
    <xme:WtzJaJTxEvZrLxNhQ9-oyCi6fRZWUMd4LdfpQdAqgqirLgZBCrlZTRBQDxVdxKzZT
    pvfexncnd-Q3bclWw>
X-ME-Received: <xmr:WtzJaMFDebsexceiQzZAQG1ZXsDb9XCkwumEWQ06adPCcbsQgZDS1HmYJVIKfF-UYHU6EOtBjYvRC5yDD6397h9Lo3Wf_hn2LJolDME>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdegudejtdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeettddtveffueeiieelffeftdeigfefkeevteevveeutdelhfdtudfgledtjeel
    udenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepkhgrrh
    hthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdr
    khgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhovgdrughrvgifsehinhguvgigvgigtg
    hhrghnghgvrdgtohhmpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphht
    thhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtg
    homh
X-ME-Proxy: <xmx:WtzJaGEO4_8bc-wqThw-Is4DXg1G8qchVOYYiVQCiEA7fEX-ZFYkQw>
    <xmx:WtzJaCRkNOEJuMHyhqXhPzx2yZdFjIrPCKBEjR8OpHOXRz3kahi-8w>
    <xmx:WtzJaPJxf4xCtCoCCkIkmbuQMB3X8LF_OZ31fy2XOypkbPQ99cRdMA>
    <xmx:WtzJaFb0iDgSpbcKJ27e1VUAMpke6OYVwUN6ljdzWSSb038o0jxTmw>
    <xmx:WtzJaP2foiwec1NSJE3ygUmtfnzYl0UX2esy1_Y88wODSMqY5ttGUv9l>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Sep 2025 17:53:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  joe.drew@indexexchange.com,  peff@peff.net,
  ps@pks.im
Subject: Re: [PATCH v3 0/4] refs/files: fix issues with git-fetch on
 case-insensitive FS
In-Reply-To: <20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
	(Karthik Nayak's message of "Sat, 13 Sep 2025 22:54:28 +0200")
References: <20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com>
	<20250913-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v3-0-195569740b57@gmail.com>
Date: Tue, 16 Sep 2025 14:53:28 -0700
Message-ID: <xmqqh5x2m5d3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> Changes in v3:
> - Rename duplicate_reference_case_cmp() to
>   transaction_has_case_conflicting_update() and add comments.
> - Improve commit messages.
> - Add an additional test in the 4th commit to showcase D/F conflicts in
>   case-sensistive file systems.
> - Link to v2: https://lore.kernel.org/r/20250908-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v2-0-b2eb2459befb@gmail.com

I think I like this "latest first and then historical" order in the
cover letter much better than the other way around.

I see that this topic is pretty much done?  There still are a few
questions from Justin's reply that may want to be answered, but I
have a feeling that the answer to them would not require a new
iteration.

Looking good.  Thanks.
