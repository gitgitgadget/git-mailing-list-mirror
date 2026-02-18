Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D2C123817F
	for <git@vger.kernel.org>; Wed, 18 Feb 2026 17:55:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771437359; cv=none; b=mktBChFeY3ZHIBDfVHj8m8LLD2v4+t6vozEB4n5GruZivFHZ/LWqr6v/JTeUQwiKPVjEkgxQFqLhw7R8DSDC1Shz1emG9cIzNvq0YpeV2nIO9Xp/LEsjKWj/m4lnvC1gHD+zNE1dDC+6Xb4H4W7Iii9NU5caakyHcIrY6eJ5P4E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771437359; c=relaxed/simple;
	bh=4bhHfwXMvKE1YF5opJL0h49glSGz5P4MPsk3Kj8fpMw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=lc3WOx4HiWIlPWid4taL+TcAO94pgjTZpt5a1ot6KQooWdPEXpSTWJRaIkFxBUPPFgz4Gtst7uoI3j3lam+XxYN0qwGHPfNKvs2C7lKDzUSTRygyqJoqveLKzzJjxGdWeHZhtjBaylK4ur58lPucCXkHvgED6X0xXIreN+D/9W4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Ib0X8G+P; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iZf7Mrsd; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Ib0X8G+P";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iZf7Mrsd"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id D2A581D00136;
	Wed, 18 Feb 2026 12:55:57 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-03.internal (MEProxy); Wed, 18 Feb 2026 12:55:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771437357; x=1771523757; bh=g8spt7+nnS
	PLnrsX4qxJZvCEPFMjjfw2Lu1pJw+uliU=; b=Ib0X8G+PqczAiKTQvQJsjLvQB2
	kNnOHaaj56jsPmHaVrSlY4lNwfAERZu3HDIAZNtQ6erw48hwQ+9MvxoN1FwDHGGN
	ELXWeuPcUIswyIVds3X6WPt5OgOwhmbwdMKz/0oQcu8MCeZqTxh4btJ5aIviQYce
	NIi2YfQBldqYCbWxw36POivO/WJEyRScVk5C59u2tLjSiDkqSuwwekyKHc+a4JYQ
	WdoQH2Ff1XAMZjC2LcN5OtSj8JqKbeMuFj/8Qv/z7nnSxKRlJ65gIeNdkTxaberX
	4fZQZI4hQ9moRHBZP/wfWi+hUsTkvBZOP4ez4MC0AUDGePJ79HAYTUgVfL6Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771437357; x=1771523757; bh=g8spt7+nnSPLnrsX4qxJZvCEPFMjjfw2Lu1
	pJw+uliU=; b=iZf7Mrsd7ucTuODH2A4Bh477LWw5z720rTNCf09Y4PJR+LZuvsw
	gLLIrygNSY0o6wCaPv5DWU61VulOj9ghbR9rrnYqwP9FFHmgTzMFN6VI69ABwSzG
	8YwV89l2AryD3Hpn9YMgy39PPJ/vPnbtnF5KUvwULJWLMT6BP+EUD0rCauDwjlZ3
	UD48bVPgDwH01ldZGZUQAQ2UNPYlmFHKGf1cOKGX+ZH87IZ00gCvtjmWZ4S2RSST
	l6gQ3ltkrT2b7+VBWTRRpUZSVjst5PXfsIzSz6AgFRdDlvoV00o7Xn9H+iSJig18
	kzChkgLzGBSQdjTYbvFswJ81D/voZz1hBgA==
X-ME-Sender: <xms:Lf2VafsaZ3tQChCzutrhV1xPPFb8_kjz9NEHoehPpMjZIsKkbWIYAg>
    <xme:Lf2VaXXltNFQQbqMt2WI6yIwagL2oUN2NxhvK8KI_PkkzUh-13c1AjyTPC81hwWt6
    9qV0VS-Oh23SfYSDDV3yyt9Jn_cXgSEdLe7jCKRm1gvLNAIX1aWYA>
X-ME-Received: <xmr:Lf2VabFjG3E7VTOtYZA3gcDdqljL_fkPrUcGU1BSRcX4NWBKYGAjR7apdrVfKDM5SdHHXcWC1dKoqAlpcHSzz2sVcEqx4EqKcQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvvdefvdelucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehkohhjihdrnh
    grkhgrmhgrrhhusehgrhgvvgdrnhgvthdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:Lf2VaZ2iB6_iM-GWQ1vgpNHawY-8cEn89uSgbWSN3106DlttXQwPmA>
    <xmx:Lf2VadMHK6ak_Yr69ImggUNG15kIxQ_dr9LvTcUvmNabcmraJqO4GQ>
    <xmx:Lf2VaY5A2p3DZFAfd2D4ZalF66R4ckZVQ1jIvL2RfbGwbKwQaQEHJA>
    <xmx:Lf2VaX1YDklVq5FRl1zqSj-pYcaZmx1zI8NGAeUt4ceoOn-6HgwH5A>
    <xmx:Lf2VacNL9He5p_nsyYa4TKewq_mQUprJM2O8S3HZrf09cL4zZCjKz4SL>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Feb 2026 12:55:57 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Koji
 Nakamaru <koji.nakamaru@gree.net>
Subject: Re: [PATCH v3] osxkeychain: define build targets in the top-level
 Makefile.
In-Reply-To: <pull.2046.v3.git.1771391650713.gitgitgadget@gmail.com> (Koji
	Nakamaru via GitGitGadget's message of "Wed, 18 Feb 2026 05:14:10
	+0000")
References: <pull.2046.v2.git.1770775169908.gitgitgadget@gmail.com>
	<pull.2046.v3.git.1771391650713.gitgitgadget@gmail.com>
Date: Wed, 18 Feb 2026 09:55:55 -0800
Message-ID: <xmqq7bsa7x78.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Koji Nakamaru via GitGitGadget" <gitgitgadget@gmail.com> writes:

> +contrib/credential/osxkeychain/git-credential-osxkeychain.o: contrib/credential/osxkeychain/git-credential-osxkeychain.c GIT-CFLAGS
> +	@mkdir -p contrib/credential/osxkeychain/.depend
> +	$(QUIET_LINK)$(CC) -o $@ -c $(dep_args) $(compdb_args) $(ALL_CFLAGS) $(EXTRA_CPPFLAGS) $<

I notice that many other places in the Makefile we seem to use
$(call mkdir_p_parent_template).  Do we want to do so here, too?

Other than that, looking good.  Thanks for updating.
