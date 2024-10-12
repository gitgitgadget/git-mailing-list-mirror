Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 637CECA6B
	for <git@vger.kernel.org>; Sat, 12 Oct 2024 02:04:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728698683; cv=none; b=k/EFZ0sIHjVLQahAKvhVIl717FpGwLHkVxaqx5yyfUY+L7Z1u53woow1ZQWda6o3Q0WMBHcJW93FqfUFjJMBsxZnyTPKl/KBXuZ35izu6ZgnNl5G8Cezzj9XNbj2Yd79soy12iQPUBMhQZKb4Xeytmo+1fHLp3aDeiygTYRPwPc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728698683; c=relaxed/simple;
	bh=JENce+yiemN81y0ciOHOx3svLayhhCB3/22Rwc/tGyM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=a926r6wf1uig2afoets0mmHn+DQbdWTBfP1wb85M+EfOjy0UbiNyh+XPfVXHyHg0x6wXwbRTXna428THwtErbDlCirbyIWm5ffbgfF3dVfBnj1DHZ3bQ0/D67vHQCUVj9CZYN3mrHmvS/CS9eHUCVhWbUNnT+K1FI8FsYfkz9pk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fDBCgA5b; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=HG+Z2p+h; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fDBCgA5b";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="HG+Z2p+h"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id 60B3C1380472;
	Fri, 11 Oct 2024 22:04:40 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Fri, 11 Oct 2024 22:04:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1728698680; x=1728785080; bh=odaMIIsEVF
	bud1PPxn4I/sEJGVf8rEVwFWW9OwtCVlk=; b=fDBCgA5bSiGIOv+0PtyNOdzdJU
	TB0juRHepiN48p/0wWpDs6e/v9yvWPlQEQtMWdlPg/tHzT6kpNSnsnLwMp2iyR+8
	zxi+5GtfwC3oWaT78Lj3iloPcu7lUJAxLTfwax+wmeX029GFktCHirR0hhfUZwH0
	ltfZszpCRQaDugV+0y24xoPCove3EqL/pH+FzMRGfq81FaTMxW0QiCjaFsh2fBEH
	IvKTn237QMFa6gv4J93weQbf75F08jAUCt/5iUo3Dc3G7MGkbgGxaw6V219eEHFH
	j+8iQmlK4Msu0kJWhuwPss/ltsvt9Aro6lYsK0UYGo5sVd7edLbWD9nqyxEA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1728698680; x=1728785080; bh=odaMIIsEVFbud1PPxn4I/sEJGVf8
	rEVwFWW9OwtCVlk=; b=HG+Z2p+htn8iGSBkapii1qrLdTDtCf3NgqJDeblf1UfR
	0n2WR7tiQStIIWL5KovEJWQNTOMkTyjkjfkEjPpkhWgTAAdDItDK08fIRZQy1g+X
	yRF0+3/EoS8kpnQGcTNGMOTbpaenpEkDgqhNGBWfBnozBb+CHgsAFEkVzxmxlmny
	IkaZ0yT2sCM4HBm3afprIelDr+J9Rgq3t9wcz/tarpW1XnDqBa1rAJq7Nrjw6a9g
	2COJRQGE5Mmud611yT03i6FLdYEqGe6j3h9wsRQIOp4aDs0TR1K6MtasEo2ouLg2
	kLnzjYckoslmYMJtkf+L+OkgG7SxF8fZPzfAec/hFw==
X-ME-Sender: <xms:N9kJZwfjZkzarZfca2sUJHm9NA-sIPu__FpBz3Badaa3WJuyR9Hr9g>
    <xme:N9kJZyMQMZyO5U_hnBVg1SxOgYoZwKsctsLt1mX5obx38oVKjbN9XdvmKcyx22S1y
    oglUpN7MxUR-c_5xA>
X-ME-Received: <xmr:N9kJZxipB8faYtkH1SLqU_VNMm9kBNEqS6UbaxdHWgM1ADC7JgtBHHHHZuxPkhKum4BoaQbAW6syxm6cpGUMxTU236W3CumcMXJcMBE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdegtddgvdegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeegfefh
    tddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomhenuc
    evlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipdhmohguvgepshhmthhpoh
    huthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepghhithesvhhgvghr
    rdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegvshgthhifrghrthiisehgvghnthhooh
    drohhrghdprhgtphhtthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhm
    pdhrtghpthhtohepphhhihhllhhiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprh
    gtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:ONkJZ1_7MZcxUzjT7gkqvajkRTSp_xLEkAIPi_RfuG25PvkInXXGyQ>
    <xmx:ONkJZ8sl96GMUsPgCQVWXT1GQpnbLS-_4SJ3uwLABb3VKPX6gGeQsg>
    <xmx:ONkJZ8EVOmSh84fZuowz88LYZKrFyfeZ3DOXrVnbAQFxn07DtIhQjw>
    <xmx:ONkJZ7M60LpeImvjVCoVcotuFXrMZR34Qd8mzm5yPEMTMv-dynKW8Q>
    <xmx:ONkJZwgYf17YWq9OhsOtNvNz9foVwW3dh7egAR4_HGwUuVgBIFbe7IXp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Oct 2024 22:04:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org,  Eli Schwartz <eschwartz@gentoo.org>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Phillip Wood
 <phillip.wood123@gmail.com>
Subject: Re: [RFC PATCH v2 00/24] Modernize our build system
In-Reply-To: <cover.1728485139.git.ps@pks.im> (Patrick Steinhardt's message of
	"Wed, 9 Oct 2024 16:56:01 +0200")
References: <cover.1727881164.git.ps@pks.im> <cover.1728485139.git.ps@pks.im>
Date: Fri, 11 Oct 2024 19:04:38 -0700
Message-ID: <xmqqh69i9ivd.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> this is the second version of the patch series that modernizes our build
> system by introducing Meson. This series is still in an RFC state.

I'll keep it in the broken-out repository (https://github.com/gitster/git)
but eject it out of 'seen' for now.  Builds with the topic seem to
be unhappy with circular dependency, 

cf. https://github.com/git/git/actions/runs/11299216196
