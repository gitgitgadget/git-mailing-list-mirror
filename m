Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC85288A0
	for <git@vger.kernel.org>; Thu, 19 Jun 2025 01:24:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750296249; cv=none; b=Hcvvu47gOBQ8dmbggQeuzyjVtCRSVDxHhUq00nQeWEdsWi5fwjD3/85TgZf6N+2eNQFOWTlSVh3mmFWMG6qEvIO0j+fw7WmhynSN7LEsULQFffjcda331a38nH6hCmDztezyAoC9lboHF65DMFUDb4Igk0w2HyMVveBhMvS2n0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750296249; c=relaxed/simple;
	bh=yXDrSl5BspClEUiD3mIriKM3qF/Kh9P7OIa/GkFrKqA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=DtnkFCPk8+m8P+KTXoyHKvfvYVZiyxyM5qP26XcqsxNY7yMd1GoHyf85aDoqJQZY9prBvyhV4ADNV2pSzNh5RxWCRqr+0RttUCUDXDy2pidvzDAPW1yRc1zW11chTrolS0K7uWE2HpYZa5K/zyzFQqrO1eoZ8rLJUYu9gpZQEuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MIqVOuh4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=BtDph0Vx; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MIqVOuh4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="BtDph0Vx"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id C320A11400A0;
	Wed, 18 Jun 2025 21:24:05 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 18 Jun 2025 21:24:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1750296245;
	 x=1750382645; bh=+gmWJtclxuOkX41y1F3VzkA1KNZWpkA5EVE9ZZlYvuo=; b=
	MIqVOuh4XRLc/2cbo2YmJ85vbjDe40cYOE4Q5kpy8hdcsRBX+O/Nqzo8+G5SmXkp
	ZTqsceQw4MVSKxwqVZ6OLqqqjH9rx8gvmfyLenSEktEiWShQ6LjJDGAP6ph+MHW2
	xB2+pD9uLGuZZfWyAcHC33YQa/yrRCmvPsBaPZL73pdmQsZJzZWndz74dGP2sbRJ
	5mVVd1gMUIChPSh80Iv+mqpsg72ONpmCTzBf5BKtXj/GzCYmHiAuolUKyRS9Z2D1
	ATYwf50QMxi6TVlnd/OmTf3l7iYT6O5+lYU+WeoS5ogvwdeY6mLEAB0cV0VLKElR
	OdfgEdGUvzW0ydXvXQcnag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1750296245; x=
	1750382645; bh=+gmWJtclxuOkX41y1F3VzkA1KNZWpkA5EVE9ZZlYvuo=; b=B
	tDph0Vxk6/LMKBo30RB1VlorTWWmTEdlAncFeUWTsdUBNt1qaRhkumpuCUe5yDEi
	PZe09NtMn0OLchQ9F/Y6lBXWXztGHZ+Sta2HRpQJl/ODMI8bVEgVKjsBRE37HjN9
	5XxwkDWsnb02ReS5zsu6baAWkV5ZuEGar3xiILLddpKeR+NCodkquCd3nsSO+FPR
	+HVPJw0szQFVidWtfPjXPNWZuZishWeu+xD9TVMaTAVUNvvUnn/jqTiwWF366HnP
	lJ87Hvo+IOs4XN8N4hI/U8ELMmOJnwSJof3so3Hj+3M1h03b/xBivg6AMDzwfYvo
	ckwUQL8acQuuoLsysJdng==
X-ME-Sender: <xms:tWZTaGQHtCA1URPhf7h_7VRJfNBe1Ewd672FXKlV9QG0GeBXgd10-g>
    <xme:tWZTaLwZcXv26WBloJV3DPKu6ckpPSmJwhzYNVnJB-LeVEcWqsvFfWETlAFagpXuu
    zUAS3W1w4UKXdcSAw>
X-ME-Received: <xmr:tWZTaD019-TCq9nvQCYBs8V5eZcZmiZBk4e3LB7lJpcPJ5gQTvY709_2Xv9ttVX0ycPd_aH60qmJ0eR0vAndHtLp2KUkNDJyW_qF>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgdegudelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:tWZTaCDlNdYVkHhldzDAZShjVr1l8I3XTvXTvIs61iDH76HQ8WnllA>
    <xmx:tWZTaPgSkdYKE6JAVt4IjKaIawI7jAn0otUDYr5TXUdH8uFJ6dzcgQ>
    <xmx:tWZTaOp_VsDEMIEh9rWs6hKk-NOgq7BS6WyzCToa6IqNrflzmIT_3Q>
    <xmx:tWZTaChEFuZtUGnrchZavvbk7C7aGixtvkGsDfWT_ib8hkIqUiQOfw>
    <xmx:tWZTaLl74-teFeAkS_8gabIfnKD3RsiH2a6wRHHG0owDZA8Qd7Xn4I7i>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Jun 2025 21:24:05 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH 2/9] doc: git-log convert rev-list-description  to new
 doc format
In-Reply-To: <ff22d0f1adf823ea3baf3ad3ddbf25add1187ce6.1749373787.git.gitgitgadget@gmail.com>
	(=?utf-8?Q?=22Jean-No=C3=ABl?= Avila via GitGitGadget"'s message of "Sun,
 08 Jun 2025
	09:09:39 +0000")
References: <pull.1933.git.1749373787.gitgitgadget@gmail.com>
	<ff22d0f1adf823ea3baf3ad3ddbf25add1187ce6.1749373787.git.gitgitgadget@gmail.com>
Date: Wed, 18 Jun 2025 18:24:03 -0700
Message-ID: <xmqqh60ccymk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -A special notation "'<commit1>'..'<commit2>'" can be used as a
> -short-hand for "^'<commit1>' '<commit2>'". For example, either of
> +A special notation "`<commit1>..<commit2>`" can be used as a
> +short-hand for "`^<commit1> <commit2>`". For example, either of

It didn't look like there are huge differences in the rendered
output with this change (and the below hunk) ...

>  the following may be used interchangeably:
>  
>  ifdef::git-rev-list[]
> @@ -43,7 +43,7 @@ $ git log HEAD ^origin
>  -----------------------------------------------------------------------
>  endif::git-log[]
>  
> -Another special notation is "'<commit1>'...'<commit2>'" which is useful
> +Another special notation is "`<commit1>...<commit2>`" which is useful

... or without, but semantically the updated one of course is more
correct ;-)
