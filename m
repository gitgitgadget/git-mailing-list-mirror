Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4837198E77
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727719957; cv=none; b=URZqaAfa16Hnxlq8DhCbx9b0PERTGBGRnQL+iRISOsecy6+vrVTNIhF2gjwniBRx/71ElukoaslvNJcqrRwb05djkgCnHymqvpr5ztPmMOgf3sDOrzX16mVzzrk+oqljT0CkxoQIKUT42+AojKs36COoU/zhur0rpTxrt10kzIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727719957; c=relaxed/simple;
	bh=PeJZd9zgK8eVUFAHbDaVcrG3iHnNVmJpy3APu9WJYR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=YiB6DjTFdMNs1mBtSxkWZaeRmHRH6xsknpEv863pgqnkHXKaqhAOrEKrBoWGtFu0cvk9JRkTbLBPfsD9XhQLnJXKHjhRjWnWKAJJmHqRFiISYvp/FWxpdvijdJAfu0ixkCl33aGogex/uiXgK1Z+YmchqCECX/fKXwWGF3wvevY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hZAPe44j; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=I6KoLo3q; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hZAPe44j";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="I6KoLo3q"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id A922D13802A6;
	Mon, 30 Sep 2024 14:12:34 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Mon, 30 Sep 2024 14:12:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727719954; x=1727806354; bh=+7ZOSVBLYF
	Zd87kHe1nG5JLwNGLO7AxyQcyB+Ms0Y0k=; b=hZAPe44jdauU8lwnl/fZIa8KPq
	C26LhWmdq4jfIx0SINqVatglV29Gq+LkXzUFNvB3TUbXsrMgTT8FPDJWgcOLrY3/
	J5d/sfX5ZX1kwwzQC4OwU1Kl5ycTUAQhtqrbcgT/FzYBPueNThNWFxTmDv8RkBj9
	1+ftIbEoO1Ms3U0qj5997rkxhbB9Lv3QXv0dvW4CaMgcgpyVsc+K5XaWfulOlKsZ
	/IMJXR8DNW6WcNAOVoDCe37wCfsT/wTA4F8yTY+uZIMptPk2u/sUYMj9JkLYfxFS
	FWEY4agDT0OQNeokaoYx1ZCA7RcByYWcX9Ll8qVxjePyNCCNalrm+ONBUx6A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727719954; x=1727806354; bh=+7ZOSVBLYFZd87kHe1nG5JLwNGLO
	7AxyQcyB+Ms0Y0k=; b=I6KoLo3qbaJtT5b28VAl2cuzM5Gcj/3Z53dSu51xKCNr
	Pmuwlh8E0JKKPxzoFQlsnnRJpfZ/PtNvWVUaxHeYg/5j9sFM5VsAKTfCMXsq6aHW
	SeH1pzI2wg/IG8NuvvpX3wEcQNcUC1QDJAPwEJXwBZLu5rzObtvQBJ5aRQRwSc3X
	TqyjfvHMydtTKwzTU9SllQ2qw7KrRsU3SY84awiyq48efVydW+Kr++9GXQX/qx6F
	CM2tD8jSnYeGrrmQwRkqg6eFMgU4rn2WRDR92DU7BuJdQ3IK7kMpauC7gqFDHhcs
	WiLA3YgklgB8LPAzxbbMyA/BqVIWwDI6Q+cb0bymNA==
X-ME-Sender: <xms:Eur6Zhr81ZqeKZroKMeCWFWuvtKqwF7_7VZgdiwufMj-8wdOgGoz_g>
    <xme:Eur6ZjrPiWmDNUYw2IKhTJC1gVoT37x2JSZi62ymiPQGOkdDmWJnnM9OEjLtVD2Js
    Jem5Vhp3UILHc4PRA>
X-ME-Received: <xmr:Eur6ZuOvsww-9IGnL_BzUxQXdaLK4cStMqx3bFHpFoMTP14RHSrnRupQiBS-NZJydPDDB_Uq3enLRnohG4CKmKoFD3jUtoWk0QQRjes>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedguddvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehjohhhrghnnhgvsh
    drshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopeguvghvodhgihhtsegu
    rhgsvggrthdrlhhipdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Eur6Zs5Brxz3hMgl9jL3e7JRQNpqynzW4U0yWj85kFrtOhjU8qca4g>
    <xmx:Eur6Zg7d6TUdZGPZkQOI3nSCLIwJWd27L9q7gOr41rMOF9gCJuZYOA>
    <xmx:Eur6ZkhP_H75l58wbQ5D5J0cQKJv-N_HGyXqp0FZLyl8kR_pUpy_Aw>
    <xmx:Eur6Zi4DprmEPvHkM-_-zy3xMgLLAJypQHBSAx4u-21j3LOwXAF1uQ>
    <xmx:Eur6Zr2J92ZuPa3Do-396GSQx5rEidabG0f00LwhSFAs0Qux_2uiCskf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 14:12:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc: Beat Bolli <dev+git@drbeat.li>,  git@vger.kernel.org
Subject: Re: [PATCH] unicode: update the width tables to Unicode 16
In-Reply-To: <43570a02-3c99-1d07-4403-3e95c6e6720a@gmx.de> (Johannes
	Schindelin's message of "Sun, 29 Sep 2024 20:58:45 +0200 (CEST)")
References: <20240912204047.1020213-1-dev+git@drbeat.li>
	<7449ce5b-5308-ce6e-394d-43dec511ef16@gmx.de>
	<xmqqy13qhrot.fsf@gitster.g>
	<43570a02-3c99-1d07-4403-3e95c6e6720a@gmx.de>
Date: Mon, 30 Sep 2024 11:12:32 -0700
Message-ID: <xmqq34lh80z3.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> Oh, but I obviously was not suggesting as crude a thing as to scrape it
> unconditionally, and certainly not daily. No, I was thinking about
> something checking the `Last-Modified:` header and only acting upon
> updated Unicode definitions, and checking for updates only on a weekly
> basis. Something along these lines:
> ...
> Sadly, to update the repository variable, we cannot use `permissions:`
> because the workflow syntax does not offer the `variables` scope.
> Therefore a Personal Access Token would need to be stored as a repository
> secret. I used a fine-grained token in my tests whose sope was
> Repository > Variables: read-write.

And it can make a patch and send it to the list and get reviewed the
usual way.  It is a bit curious whose Sob should be on such a patch,
but we can work out the details, if we were seriously to automate
it.  It all seems workable.

You may have already noticed, but I am lazy and tolerate manual
tasks if they do not come more often than once per quarter ;-)

Thanks.
