Received: from fhigh-b1-smtp.messagingengine.com (fhigh-b1-smtp.messagingengine.com [202.12.124.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9C372EDD5D
	for <git@vger.kernel.org>; Tue, 23 Sep 2025 07:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758614183; cv=none; b=oEyZipv4ssRrKQNmc1jdC24fw43N+AK1c8qcnuUbjjCtevu7HyqIOJg5zjirsH9krWinx7qi5QjwRi+wmcKgtwLUgX67L11PVkF6nUEEcjtogY4esyCgfldo7I4YXFm7DK9MP/ef1l5fPdgY/YGXxhCMTvgBe4GWVkFFNHkT258=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758614183; c=relaxed/simple;
	bh=b1S7yL86R3lsgtjtFaZ86W7sbfNfGZyxBlsVIkVzEEI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NnvTrOGmh3NzSDQqvPNZGnup1H405mw/VtbvYcUUljgr4DbaDy9hAd9N0fBIkxhzV7e3NoboLq8xMUeqvzJdMbiEiYR9p+qJQjlI+36/vEhYLPUOgnE3qGr7t/v0CRvnWh5Ci/SdQva5Uhru75tvPJiFoDLfEyvGbCiWdsz78S0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=l4LpYB7C; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TFxxrypJ; arc=none smtp.client-ip=202.12.124.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="l4LpYB7C";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TFxxrypJ"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id CA37C7A0141;
	Tue, 23 Sep 2025 03:56:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Tue, 23 Sep 2025 03:56:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1758614179;
	 x=1758700579; bh=b1S7yL86R3lsgtjtFaZ86W7sbfNfGZyxBlsVIkVzEEI=; b=
	l4LpYB7CRCCjgeaN8CbWJAlKlX3AWpeMy2pEisXh4eaiRhED2lJpzLaU5Q/Yw9Pp
	zEfx6F8xPhqJIW6REy9YgBQDC/ZlQNHNRFzdj9Ja8wELF5m+J1yy/5xA3eLjTGww
	tMBrAU8KmMbnVp3srnTV33uYCKvGXYQrBei4xvQFhg4o1fuCuzIE/ifxXe8x4tSv
	ct5Qgo9AHB/P5AiA3ZRLYdRRbyFn/EJst7oDyeZ2TZDGRtJUOUcHO+gV1Dg9JQbf
	PNkUyGffJ7MhPpYoq7VitktDajCiATm0I+JS2fcprgnfddif+TPwwflnAvc98OvD
	2QGt0b6HsjTdKcNje9RWFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1758614179; x=
	1758700579; bh=b1S7yL86R3lsgtjtFaZ86W7sbfNfGZyxBlsVIkVzEEI=; b=T
	FxxrypJI1ptOZXEQfeLVchW6+xnAWQVOCpP5PFyOJtn6K9jW7arwYPNC69mUU5Yn
	4RLM3N1t3/KRkaZHpPWZlt8MrsY0gAPPAVn+PL/DagxB6SZBN5DLqwfK698V3aWg
	SYcVLJJ7AZjIXGFNPZgOLWPnV4IMW1pUpnpcT05EHtJxRhQ//9Bl6iwm/dayPYtg
	MLY3k5tibrTVcL0mEr6wWH002en0MNL7+Dv0tE6EBDFwkQkTduU/NtyF1fhAXPHt
	svkve/E/gWBYoONRlnkHifFpzzY4napTtDa6yYKtZvhyYxqvlPf4bjWxljSmwU06
	R1Gn3scqX0/5iDnBMyzKw==
X-ME-Sender: <xms:o1LSaAu47P-lm-TIk10DmXs0LYzDEzENNGuDZYdhnrGzuRCAIL77vg>
    <xme:o1LSaLRMaLJdywjDkLqnbGCBUJ3RDe1wLf1xC2ww61MuM5GvKEVtdJejTyuAun5st
    Q-zob6ZaPWfoGN5Azg5neeAxsN1MV_H7F82Y0TGhxf7IBg9HCsH_g>
X-ME-Received: <xmr:o1LSaGOWgyZw6NmCEkH86bdms5wPyiPCOf_ycty3AZFYfaKgjyYlZy3EZUJhfqODRK_rEQTTsnTyOs6YSiPFJQhALSqYff_ZDDr4OwA0PDDK>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdeitddulecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtugfgjgesthekrodttddtjeenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    eptdeludetgfelueejgffhvedvveefhedvvdfggeehgeekjedvfedtkeejkedvgeetnecu
    ffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeeg
    pdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesgh
    hmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdprhgtphhtth
    hopegrlhgrnhgurggtohhsthgrsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:o1LSaAZI_mpemLKKKgBbbtM_Po25a8kEGAEa-3-W2Y1QG8BlzuXzOQ>
    <xmx:o1LSaAwibSTBrpeWjlt2yaNADIAcUgDF3IZ5ls70zCFZtFzooODzRA>
    <xmx:o1LSaLItS3VrCl9X1Y02_-52e9HIw8FDaZ3p0V1UkwK7Pai3X5e9vg>
    <xmx:o1LSaKrzOpslf6xO3k0BIKcPNkoWghoAxvzzMQvEpHOXp7obPe2XAw>
    <xmx:o1LSaPoms3F6aMgY7camjxWJ30MvvJdfTQlTI7_2DENgQWY7EOvVLYyM>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 23 Sep 2025 03:56:18 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id e88b72e1 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 23 Sep 2025 07:56:17 +0000 (UTC)
Date: Tue, 23 Sep 2025 09:56:13 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Alan Da Costa via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Alan Da Costa <alandacosta@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH] lockfile: add case insensitive filesystem note
Message-ID: <aNJSnUGzzMlmrDQw@pks.im>
References: <pull.2053.git.git.1758578084468.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <pull.2053.git.git.1758578084468.gitgitgadget@gmail.com>

On Mon, Sep 22, 2025 at 09:54:44PM +0000, Alan Da Costa via GitGitGadget wrote:
> From: Alan Da Costa <alandacosta@gmail.com>
> When running git fetch or git pull on a case insensitive filesystem
> (e.g., default macOS), if multiple case variants of the same remote ref
> exist (often after a case-only rename), both variant locks map to the
> same on-disk path. When a local update is required, Git creates a lock
> for the first variant and then attempts to lock the second, which
> collides with the same lock file, so an “existing lock” error is
> reported. The underlying issue is mixed-case refs; resolve it by
> consolidating the remote to a single-case variant and update local refs
> accordingly.

Are you aware of Karthik's recent patch series at [1]? It looks like
this addresses your exact problem in a more direct way, and the
resulting error messages that we have in that patch series also give a
bit more advice for how to handle the situation.

The patch series wasn't merged yet, but will probably be merged soon.
Could you maybe test that series and say whether it addresses your need?

Thanks!

Patrick

[1]: https://lore.kernel.org/git/20250902-587-git-fetch-1-fails-fetches-on-case-insensitive-repositories-v1-0-35e69bbb507d@gmail.com/
