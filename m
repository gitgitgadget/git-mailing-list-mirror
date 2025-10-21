Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B465277011
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 20:52:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761079939; cv=none; b=oc1CJr5+US2ZPWf0ZXtJWE+mSPtyd5/T6EOVBVwq6OZxrmGYBh0ZChUKCSbYEHQbl9ssTzjvCi8CC582bcCqB7Ma3M/Hpf5oPQFcklVLo74CISVn7bEdg8ju6mPiUmYgpSLGkdy0dFo2cxhld/E2IwyUDUYAeGTVzY+FStbyypo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761079939; c=relaxed/simple;
	bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I2440taaYshfvOWMOtAKbEXJ4YHJQtNhEUtSBO4zT/TjoFVeV9VUTpy2j/kMGMKDKo4kFCDSzrDLh2M2P+lxuGm8og3tyq4MC9V0uU+dJtYbNp7luOJCOnSVe0DvbHespoAqUDRhgIRKkSK/0j4wqKA6IH0//xX8eEfQgI1XRQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=g1Kr4KEU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VdQXApGB; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="g1Kr4KEU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VdQXApGB"
Received: from phl-compute-10.internal (phl-compute-10.internal [10.202.2.50])
	by mailfout.stl.internal (Postfix) with ESMTP id 914DF1D00109;
	Tue, 21 Oct 2025 16:52:16 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-10.internal (MEProxy); Tue, 21 Oct 2025 16:52:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1761079936; x=1761166336; bh=47DEQpj8HB
	Sa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=g1Kr4KEUZIvskTHpMJeaq1ggOd
	CR8TMx/kc+8hcnVUmRqFgvjAbUPUFhRUDvF8M0T1VnWx85/2PKBJ+LkcLjQ8USNg
	pKiPiaah4N0RQ3zDM7DLinbfOQLKZ58fYNqplaUoRqS62WRfr/Ow/ZXkKV5xXN2S
	JeWM3GMKm3mANhZSc3Syj27FAeHHfPNQUSFYA8J3VnwufUloSS5h/Fsmdh5lk26g
	Om0rD82U2ctlJB3hBfq4ZRcaV3bdcyiPyhFfC9xZS5Lrc3vERINyrmvLw8htSo5K
	2VhmnUABBB94vjd4lKvbJaqdODaa5elBcb9oaJVd+ncA3s6kuJElg6tXxuOA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761079936; x=1761166336; bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJW
	ZG3hSuFU=; b=VdQXApGB+eRIkypMbDJtDn3VihdvVIsX+eCDGlD586d7F9Ybo7K
	mlWceP471U2G9I2GsPKxA3oiQuzRkpFt2rrB6Ct+LdM2aCZmmUAn+tYNoyEIjp8q
	EGPKZK+fhXjkaTjXT8AoV6YKQ90TERWgm3eDwjmtmQqzMKc0SPm0VjsGDrwwOa+g
	qgY0p77tu11LiMMiVfnwSrHu8ho1s+5zvuxss7+j70yVrXWRqcJy+Hs+s0F6jUay
	9S+Sq4/n5zL3YbDc5p/TEbNnNTK2ecY5OebU0ADkV9yfwcyxf+jL5FCd3vCijFWM
	tU48fQGFdsgukykFHpaASH5blhOaKkUiCCA==
X-ME-Sender: <xms:gPL3aPdTGKMKgVztNMoTa4CXsuJMon_iA7Gpjp-yGbfsQqAvIE0IXQ>
    <xme:gPL3aByRS17-BMbp5h6SGNwCAlIIqkdRTS-gOKe0BKLmbKeg772Lw1_BJ7eUHCPN8
    bljIOOyMEmWl13jWwU8tuP2YXVor2jSb-kNGP6Zs_2CvcbyRci_jQ>
X-ME-Received: <xmr:gPL3aM8pAow8MkgdbKIysM778r9wMQT9oaINrxlCaSMEqtmv0e6CcTEfHmuq7q0haamsDqFp79mEWI0npqFYM9EP8nqAvZYGBLk9>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedujeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnefgmh
    hpthihucgsohguhiculdehtddmnecujfgurhephffvvefujghffffkfgggtgesthdtredt
    tdervdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesph
    hosghogidrtghomheqnecuggftrfgrthhtvghrnheptdeghfduvdetteetieffkedtfffg
    udetjefhieevudduueeivdelhfeukeffkeehnecuvehluhhsthgvrhfuihiivgeptdenuc
    frrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgs
    pghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesph
    hkshdrihhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgt
    phhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomhdprhgtphhtthhopehsoh
    hrghgrnhhovhesghhmrghilhdrtghomhdprhgtphhtthhopehjnhdrrghvihhlrgesfhhr
    vggvrdhfrhdprhgtphhtthhopehmrghrthhinhhvohhniiesghhmrghilhdrtghomhdprh
    gtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehfrghsthhmrghilhdr
    tghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtthhope
    hkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:gPL3aHzIxMsOby8SRzYdE_QnMkgn-wUL6fFmRQYAx-oDL4Vncy0K2g>
    <xmx:gPL3aMqcVkW5nbuvWljN4Q0MSsLd0S9Md5BE8z_fhNAfOqZathkC1Q>
    <xmx:gPL3aIq1-OXGcU5zu4O9O547OnllYm6ElIeEAvIa25r3yCp5SZKF8g>
    <xmx:gPL3aMCw9_jaH2nYdd-itWsvkLk-6xGRM8Ddxx3AnG04ROgpGgJDTQ>
    <xmx:gPL3aGusTRNix0UtasnttJrSovSED4pQfT6va223h1pW9f4_MzJbKcch>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 16:52:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  "D. Ben Knoble" <ben.knoble@gmail.com>,  Sergey
 Organov <sorganov@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?= AVILA
 <jn.avila@free.fr>,  Martin
 von Zweigbergk <martinvonz@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Elijah Newren <newren@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v5 03/12] replay: stop using `the_repository`
In-Reply-To: <20251021-b4-pks-history-builtin-v5-3-78d23f578fe6@pks.im>
	(Patrick Steinhardt's message of "Tue, 21 Oct 2025 16:15:51 +0200")
References: <20251021-b4-pks-history-builtin-v5-0-78d23f578fe6@pks.im>
	<20251021-b4-pks-history-builtin-v5-3-78d23f578fe6@pks.im>
Date: Tue, 21 Oct 2025 13:52:14 -0700
Message-ID: <xmqqv7k8t1tt.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii

