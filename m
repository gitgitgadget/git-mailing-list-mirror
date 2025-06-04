Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C43521E522
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 12:32:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749040361; cv=none; b=guPLMGqiLbjD31AxQwCf1ZzvTLQ1AqCZ1Du5PDRmLQIiHWdyEiJ/K/W4S9OwyepPiPj7yOV553Rh9+MBLQLBTi8crekxA85O/tzsqzTXUt3mv3mif8mJ8RgQArw2+APUiORPHTEqg3gg/dFuVrNXHkZ5OFNxd0qke5hRp/jTC4s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749040361; c=relaxed/simple;
	bh=uFpIeB2/SZyxxo77V+0tJLpTuVNU5P/BtrMK9DO1FDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=aynV8vFDkB8v40PAVnQvDveU8zi62YihGeWVfHP5qKdSmhey/N/+gjuwPWqHk2UKQJxlRRmsDYE8/seypFhZXu+NCO77fJPcvxQ4ZmGIvASpi54bAVne27wI/XMGoRZAC1hLo5Woy3mmvWpsFP1ENPqFli85osIYRPqVfqcok80=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WTNRGd1a; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oob//l3B; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WTNRGd1a";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oob//l3B"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id BB2B513804D8;
	Wed,  4 Jun 2025 08:32:37 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 04 Jun 2025 08:32:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1749040357;
	 x=1749126757; bh=SX6E2vm3KsYWkvjio0vlqspbvk1AZiQYVjawgIX468Y=; b=
	WTNRGd1aakLWUsgHg13W64VnUGgsn4Y9Zn4wudJOiUa7lTGlX/0595K6g7FsXKWu
	Wj/vUNTPTghiDPI81NFlf5ss38ZxwYfBXaLq/m3mkqZrTgKZWhw2wSNqBcg5xwiC
	5CugoAZqxt/aW1vh0Xl+7enZigppHV0zoTo/0CizR6KB+0s54o2xkruPLeZcgfoE
	tbGKUENwCB+gxnHjTe+LVnu9Ws+FXH+VyXtmhsla5iH6DxLPW28GFyz5CPKf9C2S
	fO3LbfCmvqurD+LprZSg9L+zCeDyZwVsh5YkCeQbP/WiBkr5TRtdpzQU2OPJUqua
	NunQVrMpcFM4exzBbM71wQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1749040357; x=
	1749126757; bh=SX6E2vm3KsYWkvjio0vlqspbvk1AZiQYVjawgIX468Y=; b=o
	ob//l3BVN5dHT7+BaJVwhLqWVyQafqpBS6pN3KBEc3h9ztt2nKH5FHUfqZMa4e9/
	dpQbvnppX1tsgb0e8YLKuJwRuLivcLN/PWWut7wvF1D90ubMAtJAmLehNU1Sfha8
	5g48JQ3nFzEHS+zUwLGOvv5ILEY3UWGA0/OBpMRCJUJ8lly38Kr7659X/KwY6GVU
	AW0qw4KzVJN8IAX99mGoGeOUpTO7iZjANwjc+nftuYowHxxc7nz9oWb+Ozx47f/Q
	VoqKW3T8RVI9gOe6I9UKtCiSXgIwkgfHxnU2gszG3LDP0Nm7ct2RYlEaBnl+w7bR
	mxk+xkJh2nNmE9+UMtpEA==
X-ME-Sender: <xms:5DxAaKf7jkzhqvreJ2rO_iRDZ8Z83-nK41QDxky9MEYfGS5A2JStPQ>
    <xme:5DxAaENM4yaevGdZL5JyJRE29XIGPoCoPYtc7j5TFrF5pWsfOyI0Kzu4uI_Bykq6d
    cgorryFiqWUDsVCWA>
X-ME-Received: <xmr:5DxAaLgCcCRXi-Bw8M9or0XsCekB0vUMk1f1mHL11diEzIL0XQE43UciN_989B7jTO8w9ZQIORefiXnicC4BQa_8vaLPDB2ozj4q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvudegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopeehtddvtddvgeeffe
    dttdehieesshhmrghilhdrnhhjuhdrvgguuhdrtghnpdhrtghpthhtohepghhithhgihht
    ghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhu
    nhhshhhinhgvsehsuhhnshhhihhnvggtohdrtghomhdprhgtphhtthhopehgihhtshhtvg
    hrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:5DxAaH_kpXz2x3xxupB4SKCzEHxtc_oVBPfv00Vf5oAcGNUziU6XnA>
    <xmx:5DxAaGsoRCGqx-cMTZ1jPWJe-XXRU_KduO_f6_2ty5-sJn7aybFRYw>
    <xmx:5DxAaOHz3_MmdKJgyh0WJP43CEZOuminVfXEz965lFdrbLTgAXS5XQ>
    <xmx:5DxAaFOOgG-I1N4q5ux6_7KqmyLDnuLySj_3NaRvxs2QrnIZczWDtQ>
    <xmx:5TxAaLpY3f5rel4g1DE9M02dcUWfqsn47XQ9XIDyD0RWPnZCOIyhlpxl>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 08:32:36 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: lidongyan <502024330056@smail.nju.edu.cn>
Cc: Lidong Yan via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Eric Sunshine
 <sunshine@sunshineco.com>
Subject: Re: [PATCH v3] pack-bitmap: remove checks before bitmap_free
In-Reply-To: <B7032488-F47A-46B9-AF9C-D059AFC31FE8@smail.nju.edu.cn>
	(lidongyan's message of "Tue, 3 Jun 2025 23:32:23 +0800")
References: <pull.1977.v2.git.git.1748628846.gitgitgadget@gmail.com>
	<pull.1977.v3.git.git.1748915181113.gitgitgadget@gmail.com>
	<xmqq1ps1s698.fsf@gitster.g>
	<0BFD6581-2BB9-439B-9837-767FA98900C5@smail.nju.edu.cn>
	<xmqqwm9sq2lq.fsf@gitster.g>
	<B7032488-F47A-46B9-AF9C-D059AFC31FE8@smail.nju.edu.cn>
Date: Wed, 04 Jun 2025 05:32:35 -0700
Message-ID: <xmqqcybjg00s.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

lidongyan <502024330056@smail.nju.edu.cn> writes:

> No, this test case should only fail when ’SANITIZE_LEAK’ is set. I heard
> that other developer call this type of test as prereq. So only when git is
> compiled with `-fsanitize=address` and `export ASAN_OPTION=detect_leaks=1`
> and without changes as
>
> - if (!cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap))
> - bitmap_free(roots_bitmap);
> + cascade_pseudo_merges_1(bitmap_git, cb.base, roots_bitmap);
> + bitmap_free(roots_bitmap);
>
> This test case would fail.

If the test tickles the code path that used to be broken (and
corrected by the patch), temporarily reverting only the code changes
to pack-bitmap.c and then this test (under leak sanitizer, of
course) should have failed.  And if the test passed with such an
experiment, you would have noticed that something is wrong.

But you didn't notice it and sent the patch, so I'd assume that you
saw such a test still failed.  IOW, with "export" forgotten in the
test, the original (unfixed) code still leaked, without using the
bitmap traversal, right?

Which was where my question came from.

Or perhaps you didn't do that "is my test really tickling the bug I
fixed and makes the original code without my fix fail?" test?  Which
also explains why lack of "export" was not noticed.

