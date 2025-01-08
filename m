Received: from fhigh-b3-smtp.messagingengine.com (fhigh-b3-smtp.messagingengine.com [202.12.124.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E95E113D52E
	for <git@vger.kernel.org>; Wed,  8 Jan 2025 16:07:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736352429; cv=none; b=tzQ8DNNtinH3LKp5aBYAqu0xcW3hURuKFNrguqTAtqoMq8kBMgQvCeRDGrNtf5qnU+5eVPf9FlCtkvTzcjB4xnd53lM2GTMOHA/go2NNDmxdnjqZQlnc/6G12XGhJYFo61a+13rdnNaLqbHEjie5Q1q+BjSvY30hs1GJiqLWceM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736352429; c=relaxed/simple;
	bh=3wIUuffL1Mjnaxhq20ADOXdtw0rIN/Hc30i7RxNHaco=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Wtj+SGx0M7Bq0YlXUyelVVmkQIzJEwsYTU1GIBfbY+Ad+l1dpyzJLTBuKs4aKIpMTEA6baAO0UMrP7YOjKOMH3/tw4Xw+RsBDNFxquIcNH28qO3QS5uCIi31jazmfcwAtOFMl9UqA8NnCqPhg+ncM1fcJJ7HwuEIVo7kp3fwsls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=IvL9Tp/A; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FCAcuCQ+; arc=none smtp.client-ip=202.12.124.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="IvL9Tp/A";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FCAcuCQ+"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.stl.internal (Postfix) with ESMTP id DA09A2540197;
	Wed,  8 Jan 2025 11:07:06 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Wed, 08 Jan 2025 11:07:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736352426; x=1736438826; bh=v9qsXuDddQ
	RhkexH+VSnbSYwLl9P1HWQua8mo7bD9UA=; b=IvL9Tp/AbnNmi5mt/6yuBwOxaz
	ct5eZ6PTZdoi6w2RvEGJ03jUgGE6Bt0FqWnxSZxyML05RAclh4AkeLOLMAJ5XJrK
	7+2CNEVCBho6XY2J8bKPXLfEm6TsuvIVjzSEqEVpozTMq1SGQZww6BTZnjXuQBCk
	oKUGieYtaj+ig/N1ow6s5I63VVZQ7lf48STx7bS7Q91wmckRcwWV4CAaVEitMBgJ
	B7LVj13f1O6ygwM6ovKyhGXTScaZuYplqXjFY0T+W5MvKQJJBDWxjNbtiE/YjSFg
	w24h2U9sopRqWy0uUCtPO0Z0mD80v16MAzhrljUgsuTJM2GdLfRQMDyK7LMw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736352426; x=1736438826; bh=v9qsXuDddQRhkexH+VSnbSYwLl9P1HWQua8
	mo7bD9UA=; b=FCAcuCQ+4kmbn41zk68/u/Ongm8KL6mbpfx+pObQN4uXmLsWXCu
	u5NnVpoWgfr78BpjkAFV8d0i0JjPoUzRSpWTiwjOYf8lwJwYID5hEahv0RaSCdY7
	pvG7K+JtOQoiPDN3dlnNpkavc/z8esKOfZHIhAth7RRnO1lhMArJo53s+AluVn7r
	vaEjV4NDDRLtUiE3DR3vbeZZjtpYXZnchL6KAkldmjILwN+onfz1vgjgBa6nV+nF
	aan6wdQH+WcxNI0AnyxUwHHAEXXdipiULGO+57epHwZOtCrxi1QEBwTXbBBPu+IQ
	3gR/SXonw6a3OUrhdntQqJBHrPQHAln/0vQ==
X-ME-Sender: <xms:qqJ-Z0nLb9m9cnYJISUvg--zHYX3U_yRIeM_mSrpvJwaOjfYv5c4kg>
    <xme:qqJ-Zz1AfwLOKgRjJWDUdMezTLftRjmlnu7gyJbPxTf1Yc0P4SRPUqkcyTN29YzPJ
    -G4u4v5a-sBgnZiQQ>
X-ME-Received: <xmr:qqJ-ZyqAgXnehuDML3S3YhXAx9E-OFHFSvtez3Jbp9Xr5jCXppSgrAZfZ-ONT3o_od3Cn6Zg0zYjSSLGA59g9qM4M6KVCUH1dZmi>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeggedgkeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefgfeei
    vddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehsrghmsehgvghnthhoohdrohhrghdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepvghstghhfigrrhhtiiesghgvnh
    htohhordhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:qqJ-Zwm65Oyc4d-72L7hAAtRZtdiMb8Av-g908nlIRNQlioYmEriCw>
    <xmx:qqJ-Zy0QF-favPW7Gvkq9QM-_KJR6rD15_CCTMzOz795WeUoHkad0A>
    <xmx:qqJ-Z3vtvI2UavfyXahZ3dGeQ-JohaiC4gXzqWBHrDBoIfPYuUYu-w>
    <xmx:qqJ-Z-UwzyCL_q9rDNL6EGBPblOxkEY-t_rO48oCNAqPcxlhEiGe5g>
    <xmx:qqJ-Z-9cftIQmEKcqOGaTlqnqruILFsb_TjNQ6CoLX8J21tf1p55yYzB>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 8 Jan 2025 11:07:05 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Sam James <sam@gentoo.org>,  git@vger.kernel.org,  Eli Schwartz
 <eschwartz@gentoo.org>
Subject: Re: [PATCH] meson: fix perl dependencies
In-Reply-To: <Z34Zv55SSDexBxHQ@pks.im> (Patrick Steinhardt's message of "Wed,
	8 Jan 2025 07:22:55 +0100")
References: <371571630df201b0b0c680f6437decc6c60ecd3b.1736307757.git.sam@gentoo.org>
	<Z34Zv55SSDexBxHQ@pks.im>
Date: Wed, 08 Jan 2025 08:07:04 -0800
Message-ID: <xmqqfrltnvbr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> On Wed, Jan 08, 2025 at 03:42:37AM +0000, Sam James wrote:
>> `generate_perl_command` needs `depends: [git_version_file]` and the uses
>> in top-level meson.build were fine, but the ones in perl/ weren't, causing
>> parallel build failures in some cases as GIT-BUILD-OPTIONS wasn't yet
>> available.
>
> Thanks for your patch! The change looks obviously correct to me.
>
> Patrick

Thanks, both.  Will fast-track to 'master' before the final gets
tagged, but we may want to advertise 'meson' support still as work
in progress in the release notes.
