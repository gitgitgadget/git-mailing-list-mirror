Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97F893822A3
	for <git@vger.kernel.org>; Tue, 10 Mar 2026 04:54:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773118473; cv=none; b=k/BI9P1uJQ3rQUqLyq3RP8NY1N3T5mzmyhb3/WfcVjo0B8/0lz8kh3Xd2L5paPY9E69BatnCxdqxPReiOv0JArQLJ8/yYlixTCEuQZLOEt38hOpF3s5iWipS4a6VmLdzF19cgOqCsmNQ1WGwqXUXjFc5GTiy998ihjrTSUay7fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773118473; c=relaxed/simple;
	bh=vuiN5oXZecnRLzVCr+Rh+AroA19kSZxyMeeuKdjf3Xk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aYYigYgjYkvt+B4dFV1h/tbk/rvETisB0GxHxcNNbrbsl/PWV5qXNYW2YsRwxy4ohA/aAPoSMlbr1sJbGCVhRWLktdMH1QRcD0NRj0Z33/goyKhXr0tOQ0VtcnUv8KOOnEmSSPSwA6neSk5wPwgHsdAmPwRYcsOU1IcEpxxyr1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=lpxLUg8c; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=n4pTLGcL; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="lpxLUg8c";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="n4pTLGcL"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 99A671D00168;
	Tue, 10 Mar 2026 00:54:30 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Tue, 10 Mar 2026 00:54:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773118470; x=1773204870; bh=L0Q8oA8OTK
	6aLBt2bh70Bqs5Fy7Akcx74R8kHkMhD0w=; b=lpxLUg8cZGm+6bBPFBSsIQ/PqC
	mEJeredvWLXnkFDRIDsL9SqhIk+/cVbFTBYLmaYbQLZ3d3r2iJnp3EAWQnm9WkBD
	Tw009XEdMz10uX7VdSO4IuczAbbq+2HSDVsEZhLwvxieJfbvxZYpE3pC1vWcs+W6
	CJHwPgJvtZfQbtSbgDYMUgzBRzTFNaOhXnb6SgsiUNdtTlXO7XZz38oUdFvN4btR
	XNaksIzu3lPVHdnj4FCruHNNdeiEVOppZQ4MeEQjos1S2UwN+LXsWTWR9T9WmSRN
	XmDii75cwlhl5Br50WwSSEB5BT2n7pNLtW7vgON2RmWgD+Su8vDktKfs5ziA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773118470; x=1773204870; bh=L0Q8oA8OTK6aLBt2bh70Bqs5Fy7Akcx74R8
	kHkMhD0w=; b=n4pTLGcL/38i244IIM74WzEWHdN4h7RIlXPoG7YbJDxagxKOpjZ
	Tdo3UHkbi9mCg5+fCcrNszR3ZdJ7p28mXz7y6oxKvNl0jlc1NEv44pnmtkiKa6LC
	GQOUBpXq+DVyGJCSbn3/MkBSxftMeTI0iM2ESTrLJt2atLv5piRJ15We+hgAGTKG
	mbekmjgqv9xmQBFL01keonWZTaPqXAuh/Dib4T/EobAqYQOl3pJbSM460F7zOJ1X
	5oehHDU/ZIH16VeWRU+FjvZNAzDcE5lmyCeE2Mut6FmdhXcR+szsINqOZa9ILOAk
	w3cL0cKsB5zGUkZ/WLGgtw+bWfLepjG1tUA==
X-ME-Sender: <xms:BqSvaY9wWyjClykknGh0rW21o0qjay_NWJSgeWLCPj6ZXsKeOx-KEw>
    <xme:BqSvaYJetc3UeKLQLlgw7NGdE9dcnSAg_AsKb-MkRC8xde6_qjg9Sp5a14Es3Hc41
    Tbjn75h1QT9sIcKILcCwywWtWInt9z9RnTa9D0PcllDC_C6n8ly9g>
X-ME-Received: <xmr:BqSvabYReJlPMmkk5XLaj46nyk_HTy1iNJeC5lVX7NL_71E_siYbgQGuPGa5ip5REPtF_Qx2y9Iirrs8uHg8pVJfDAI-xfKYdQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkedtudegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeettddtveffueeiieelffeftdeigf
    efkeevteevveeutdelhfdtudfgledtjeeludenucffohhmrghinhepkhgvrhhnvghlrdho
    rhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepphgrsghlohhoshgrsggrthgvrhhrsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:BqSvaSKSm0hQS7IyXzQnzifuJzV3-2KOZRCGaZH9XstU5qAkKgbhuA>
    <xmx:BqSvaRBAQU0FOM9WbI6o-kYAbhuhrXHYearLdQ-_fezqC5xLc8W60A>
    <xmx:BqSvafonqH2a1sZgk2iZCCycuaprhncRLeM2koeKqhFMdf6fl0DTAg>
    <xmx:BqSvaUirzqiSbKgWCr62HfoF-r6HQ0oT3DG46q7SyOsUDjiwrOFTqA>
    <xmx:BqSvaUJ_F6FOLlbbaFsYyVQBZXps9vE8qPaV5QjW70Dxcn29IrByboaF>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Mar 2026 00:54:30 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Pablo Sabater <pabloosabaterr@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [GSoC PATCH] format-patch: write numbered list in cover letter
In-Reply-To: <20260310041929.1687483-1-pabloosabaterr@gmail.com> (Pablo
	Sabater's message of "Tue, 10 Mar 2026 05:19:29 +0100")
References: <20260310041929.1687483-1-pabloosabaterr@gmail.com>
Date: Mon, 09 Mar 2026 21:54:28 -0700
Message-ID: <xmqqo6kwxp17.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Pablo Sabater <pabloosabaterr@gmail.com> writes:

> Cover letter generated with 'git format-patch --cover-letter' uses
> shortlog grouping commits by author. For a single author patch grouping
> by author add useless information and makes it hard to follow patch
> references: "second patch does x and y patch does z"
>
> Replace the shortlog with a numbered list of patches:
>
>   [1/2]: first commit
>   [2/2]: second commit
>
> shortlog grouping by author is lost, both for single author patches
> and multiple author patches
>
> suggested as #leftoverbits by Junio C Hamano at
> https://lore.kernel.org/git/xmqqbjhjxp2d.fsf@gitster.g/
>
> Signed-off-by: Pablo Sabater <pabloosabaterr@gmail.com>
> ---
> I haven't tried to group by author on multiple authors patches to keep it simple 
> but I believe it's doable.

How does this compare with

  https://lore.kernel.org/git/cover.1772839973.git.mroik@delayed.space/

I wonder.
