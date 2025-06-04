Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BDFCB29115A
	for <git@vger.kernel.org>; Wed,  4 Jun 2025 14:45:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749048315; cv=none; b=Ra7ek5KH2jLJbulIz3Oh7Lj5qk2Sd//gnif/3B2LlpiuZbVfUFlFTOWmrw2WMR5rJs778JFFpKQ0s7z2czsd2F3h9/0rYZzFUxMgiNKHJ+LGV+wbtOndCYLrDHbC548Ud9Otl4WTDNVOMV2q8unY5Tr4pAwtLOF/2Zu+qgOfe8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749048315; c=relaxed/simple;
	bh=bI6egJsuxBwCm6mrkF5r6oFflRLJEekxN+aNnZslpm4=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=tOjQ+PX0YETDoa9/Kst3pUlsmoODbQjanEhCCjVVz4VfuN0T1pHvTOmAkgcozKgZ/6CIWlSMZ68dWi514brhCjEM9bT/h2NKEx0nGpGBl2XINVk2KIm/N5NPXb4Lbx9v7vLqgaoeYz7qj4sbFgE/VgVtFtD3eDjzrfSMIAzCcMY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d1OdVy5y; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nucK2eYu; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d1OdVy5y";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nucK2eYu"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id C6FF9138049B;
	Wed,  4 Jun 2025 10:45:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 04 Jun 2025 10:45:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749048312; x=1749134712; bh=bI6egJsuxB
	wCm6mrkF5r6oFflRLJEekxN+aNnZslpm4=; b=d1OdVy5yOpAwffQz9Pp3qsIV3X
	qC3Vlk2q+fkEUiQc1uDG33n9lGjCHT3EgakgAtNSn378oPB/lY5/p9JfdNREb+VY
	F+3DSot9LDZIFldLXHrO8ZuwzDsPb5tn0lCyVE2uFN4kGB0b3KS5+LU++P8T7Tpb
	ciRku70EjJO8U7e5xmfwdjppHnHxBGih3dWdbDUkECxnNVh25j9g2TfYhl3Hnx1R
	Dc22jEKeSNbuI0U2rks6IgS8SjXbTZsHo2NVO0KvZrRUtELkwO40bISD3wONO6C0
	wlLJZVrWDkFQa4SG7HFobI4zVO6+wLEdrGXdtQdsamYI3oXWa09yelQf5GkQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749048312; x=1749134712; bh=bI6egJsuxBwCm6mrkF5r6oFflRLJEekxN+a
	NnZslpm4=; b=nucK2eYubhLIFAHOoYQbQ3Bh78IL2LyYxIRzN7Pg7RcbGN1ECgF
	XxarVLgSzHQBDs5ZjlSzMruCKGhEbPYJzitpSVpgPmfghNpmnHv7pjr7W34lzJrs
	8ABst6ue3PIi76+YRy3oQqwwTL8mKdTGs5Qy0ludjRJlR4+F/zn2xfrTYVaMBSaz
	PmcK5sxlYyNJjzpeqRzXgypCWL6/nJ5sMFiqosa0ZibNkVpPkYKBkwVGpa2jpK/j
	dNNM8GVHrLny71Zl900pfgvhyz2mPte+mTYVyeskWmsV3R3C0NKVOEtxSCnt/y+q
	20l5KADlTgPNAvU7zn/EtFsegd2LzWJf4oQ==
X-ME-Sender: <xms:-FtAaN3-QuHvQraedTdmfWrxDRZNwHsNR8ecOCrGNwwZVP_IgnsZGg>
    <xme:-FtAaEEuM_wFo_cjoTm5jkwssJ6zDrnouwLc-551yQRhf3eHCLuOrftvNFTVGrn44
    pbi8U2uzFOBsz7b-g>
X-ME-Received: <xmr:-FtAaN5vpVZxsQBY8cshmFMDL7legrS9tOkL51a1Fl0A3ha27oi8HZ_gVdDI8v_hNdyhYMOpMEhlobzWZO9NvZkLmuB5BGVfdp0L>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddvvdekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepphhssehpkhhsrdhimh
    dprhgtphhtthhopehphhhilhhlihhprdifohhougesughunhgvlhhmrdhorhhgrdhukhdp
    rhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepkh
    hrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfhgrshhtmhgrihhlrdgtohhmpdhrtghp
    thhtohepghhithesmhgrthhthhhivghuqdhmohihrdhfrhdprhgtphhtthhopehsuhhnsh
    hhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohepthhmiiesphhosgho
    gidrtghomhdprhgtphhtthhopehnvgifrhgvnhesghhmrghilhdrtghomhdprhgtphhtth
    hopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:-FtAaK2BfXDA9klKXNyL14zmHVibdN_YldWGgeswQuTUgdpErow6QQ>
    <xmx:-FtAaAFpsXVDBBLnRArwkKgx_i0vNahVkzFca8j6RS-5mTeHE-4SpQ>
    <xmx:-FtAaL83s6xlsLpQPc7hyWPAcOsKF8szECh--qbKVSGymB_mq6CJDA>
    <xmx:-FtAaNnnFQWNzHhqD38aPbQmiwqtHNLrOlsEcayqhAMNtGKPBVMwPw>
    <xmx:-FtAaLxpOjd6bRyEhmi1eRcf-X3xKWjqCKzRCIqh-gos_4GIxyFRWLSY>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Jun 2025 10:45:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Phillip Wood <phillip.wood@dunelm.org.uk>,  git@vger.kernel.org,
  Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,  Matthieu Moy
 <git@matthieu-moy.fr>,  Eric Sunshine <sunshine@sunshineco.com>,  Todd
 Zullinger <tmz@pobox.com>,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH v3 04/11] contrib: remove "thunderbird-patch-inline"
In-Reply-To: <xmqqplg8rx2b.fsf@gitster.g> (Junio C. Hamano's message of "Fri,
	16 May 2025 15:49:00 -0700")
References: <20250512-pks-contrib-spring-cleanup-v3-0-32e151b0bfb0@pks.im>
	<20250512-pks-contrib-spring-cleanup-v3-4-32e151b0bfb0@pks.im>
	<xmqqplg8rx2b.fsf@gitster.g>
Date: Wed, 04 Jun 2025 07:45:10 -0700
Message-ID: <xmqqy0u7d0qx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Junio C Hamano <gitster@pobox.com> writes:

> Patrick Steinhardt <ps@pks.im> writes:
>
>> The "thunderbird-patch-inline" directory in "contrib/" contains a script
>> to send patch files via Thunderbird. This script depends on the
> ...
> I've dropped this step out of 'next' for now, to give Phillip's
> update a chance.
>
> cf. <20250516135540.218937-1-phillip.wood123@gmail.com>

Now it seems that Phillip's update did not quite gain large
following, so let me resurrect this step.
