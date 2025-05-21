Received: from fout-b5-smtp.messagingengine.com (fout-b5-smtp.messagingengine.com [202.12.124.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 324342609E7
	for <git@vger.kernel.org>; Wed, 21 May 2025 13:44:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747835063; cv=none; b=nm2yXLPwo+HgZkPd9yMPHmH8r79TK/kNcNFy1Zb7DDEUUoQDJf7ngNIRxCwxLGRxLboAoO849iYqnwA1Ahg6vb5ErmQL0m8e+D7IuOiH5I011Xf9JJuz4TOGgVaRVE0mA3jDcyK/C0GA1JesVmwKmKPeZyBeCTHarTJla8mIO4o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747835063; c=relaxed/simple;
	bh=wzgWbET8YLzWlJmyc6DInQwEcfGBWkLq+PRAP4P8umE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=IE6DZ8rlvIgEsdgtT3Acu5J/Fap5OsWsvIQ6dGMYK28+kMXoUlGFs5Gr45mntlhTM5ZfcNbJUh5HmIGgebGItZDra5AgyvTzLFVTFgxhwwr/4yynlMw23yc6AbRs6+OR69y42Ze61iulU4uCd1SzNOuwjjT5eBj1sdHDq+IR6LQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HP0TvQIt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=J8gLZlun; arc=none smtp.client-ip=202.12.124.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HP0TvQIt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="J8gLZlun"
Received: from phl-compute-09.internal (phl-compute-09.phl.internal [10.202.2.49])
	by mailfout.stl.internal (Postfix) with ESMTP id 1EF611140150;
	Wed, 21 May 2025 09:44:20 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 21 May 2025 09:44:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1747835059; x=1747921459; bh=S5Bk79F+C4
	6K8tmIVigmOHNHcn+Vbcj3Kqbu4QH+GA8=; b=HP0TvQItaatuS14phNu0t3a7uV
	+WpXtzMabQ9B7kZ1iSN+1BrbVUfFAQh0GYs2MglE7RUDmwLvqkr1wK/XtgR8FSWZ
	aJdSOsXgsLILc6/CbIOLv5/nhJb+fKl85Irsyc+HFvUUuq4oYZxxo3KP8cddK/Yv
	APW1ekBegiPu5Sx0LnzpSQenWA5cC2itRhQEeFyKqBrAmmSL2DmlLz/843MjIywx
	xbPGUQ5MQrXer4isA86Ao4bPht85FB7hy7QH5aEdTMAAP/ng/YRGqUdCYZZetSdx
	ey3ZamzXZwij4uDKJk2ijqJ2Vw+2XwjeweL0Fj4DllqvfIIKKRsx+hu87P0w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1747835059; x=1747921459; bh=S5Bk79F+C46K8tmIVigmOHNHcn+Vbcj3Kqb
	u4QH+GA8=; b=J8gLZlunpg0j3ToLJ6pyYusLkVohJZJ5A2lf1gMzKp2HGBI2PAt
	jA0WsnilG5xlrZ2GKTvrxjFNIZth+1M2wmexJqZ1efxUyHlTThrekDJA9jVGYrpC
	ltvm83pqfb0EUgMay+O9YHdh0kgN2fzQj9fGXYMsLUMkIH3u/cnGUEf63qjR0Tl5
	oZlKs30nfA85USfI+3d2Zziv9Z1nZ5zKhnhlmMdd/fd58YAZENzLZfZOvjXCHTzg
	uVdtTM90O7X6fHJn4Z/JbVrkFWFGP4ADBhqIiADae/AkWVeLiSm+ywFbLY8J1Vwy
	og4jlqe16AKLNHbWg1HPIIY6t51RRxHNslQ==
X-ME-Sender: <xms:s9gtaN_MSifbFXbaYhfBIn4KtsUN7iLcpKsnXuI-8f-300IqcJWXmw>
    <xme:s9gtaBuxc3Zlkp_UMhxkGcE6njuIooo9qIDg2i87-9_r7d4AA8PKnVCdqOoYQxVIY
    p5RCQ0EkEtbUP9i_w>
X-ME-Received: <xmr:s9gtaLACpQZZsFd5rAhFI6L3f2sVo4OolOhRSRlpLjgEheLYR_1Lq_Dw_Xjdi_R5wYm3ShV9psg_RF6PWzlCkJ1Rn5gVPgMSG4W_BuQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddtgdefvdefucdltddurdegfedvrddttd
    dmucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgf
    nhhsuhgsshgtrhhisggvpdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttd
    enucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefl
    uhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenuc
    ggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfefiedvudegfffgffff
    veevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfh
    hrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeefpdhm
    ohguvgepshhmthhpohhuthdprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtg
    hpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:s9gtaBexz3NbjLewhrmInZpSEHGszWgB6rYsTk9Fl3hroXTOGPHs4Q>
    <xmx:s9gtaCPVAFgbYFwCum_hRKnPIsqyP8KiaPJ7O4yX0YLW_v-cCUMf3g>
    <xmx:s9gtaDnOAo8a6HC8j1ukQ4A1otc5_uqAOr7TS5fiqTy1Qe8pf_ZFsA>
    <xmx:s9gtaMuVomZP70AziOGOZYTeYKZIvGVhH1xu56F97FSgJXkm6Wg4ag>
    <xmx:s9gtaOKj-IxfrN0B6aHjz4VUqP_vbDg8sOFwPULZxRghElyGiUI34lSC>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 21 May 2025 09:44:19 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 08/13] t/helper: add zlib test-tool
In-Reply-To: <20250519170335.GB772062@coredump.intra.peff.net> (Jeff King's
	message of "Mon, 19 May 2025 13:03:35 -0400")
References: <20250516044916.GA21985@coredump.intra.peff.net>
	<20250516044959.GH22242@coredump.intra.peff.net>
	<xmqqo6voprrk.fsf@gitster.g>
	<20250519170335.GB772062@coredump.intra.peff.net>
Date: Wed, 21 May 2025 06:44:17 -0700
Message-ID: <xmqqbjrmdqoe.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> I thought at first there might be an opportunity to also simplify some
> of the assignments, similar to 03e7c454e9 (unpack_loose_header():
> simplify next_out assignment, 2025-02-25), but I don't think so (in that
> commit the complication was that we inflated a little before hitting the
> loop).

Yeah, you're right.  This one was a bit simpler that everything is
done inside the loop.
