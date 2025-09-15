Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44733E55A
	for <git@vger.kernel.org>; Mon, 15 Sep 2025 19:19:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1757963958; cv=none; b=TM/n1tjjT6L2lXJrPKitl1foXlC8l8rIoSZcoQBTazcygixGvZui6Pxah68a8y4qCNF0b7FjejXiB9B7Vgn25cNNF9pLhGF6ihiksQ39lC+wpdfxmdI3974RiblHygDsW4Q2VZHj29NeJSH+9MkcaA6wtEnP/zOon+YWyvYDsrs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1757963958; c=relaxed/simple;
	bh=FdHJ+9bBR9u1YbD3vWXydqpOdb4flwZ8IivBj5aaru0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=A4LpQ9zsTFYh0zjxKF3yirlf25PcrA7J/T17TBxOzrJoJmc08cde/TV1fUksSl4Ca+EfXIT2ADlPuvQQfczwWRl1PzpZN+2FNEugLRd3Np5mLmbnTnx9X3enoQU7rTpEGNNjrseCfP6h0qfGAXIJFRBMtdKYKAsiHMSb4JoD25E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=cUDZeiYa; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LRXLJXF2; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="cUDZeiYa";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LRXLJXF2"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 427F81D00188;
	Mon, 15 Sep 2025 15:19:15 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 15 Sep 2025 15:19:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1757963955;
	 x=1758050355; bh=DTws/K9nhA80aDV7tNzJahrtlQ6iPFU7q0/xjdIt0tg=; b=
	cUDZeiYaN5AsU4lsVBPGYTzM3OwVFI8Q3D3mwdZ/KC7TUqiiayFof2WkODHAAnC7
	bb9Ay0sjJxtedcymwsQfvUusdbGzYWAEQarZZn/JxYJnPh2NDU/BIVCR0NIagv79
	VRPjF3V7LCkEvUKqY+zob2KEHeaS6j6BIi2a8LErOhEtIl8a8N6YSYhCik5n5Toz
	IlW3T9SK+895GdGu7eFgBs9mLPyZ2xSrp5erMKhJ3x+WJRFQuH8qElW1jGSPc7t5
	dipSK8F6PjmHaKJh/c6Ju6Me1XytBbUJHXLm+EZoQssvhl/6fNpW+cL1bY45jsP4
	5t+MZc8SPIsny2bBkNjgEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1757963955; x=
	1758050355; bh=DTws/K9nhA80aDV7tNzJahrtlQ6iPFU7q0/xjdIt0tg=; b=L
	RXLJXF2J056QiVM+yaB9uI8v++vgbfEPFLstC9dfHW63JDnlYkyUXzowwQiZoEBZ
	+T6vQZzRQnmOd3mZWzX0JDYPLbiE6yxEKalrq1xnvFnrChSOCUZLCjZbAmGgadhU
	mujP2u2e4k6MX0lCJ1uriOW2M0pRg53ho8dm0VZGpj0HU4vdSNqvE/hyY1MMSf6q
	BC4wmClC2nfTqxYN1wXI43D+rs1FwaqwhwKOZ6KNQE9AoKyQ012LXaXJtHrNQc8u
	pHBaqgwzSPiOPV4F+UCPXCk1fkynxOkc2ypCTq0bz+bwyHDIEe3SR/sYkh465vFL
	+BHH8EfY7N101uj0spaKA==
X-ME-Sender: <xms:smbIaLWhLIlMMrufPDzs8VPymhSzQXDp0hNxXYfhwl7kfQO5LYAlaw>
    <xme:smbIaBJUaXXduIq_OYteGdDTwfe8tavtvQKcdZc3aWfxAJ0WsFExz6DCNl82Y4Vmh
    lnx0SPs1fI4YZt9PQ>
X-ME-Received: <xmr:smbIaN1lqEoXJVD8unY92aB0UDlCyi91E8M7sSQcTmwupvawG93jiA4vTq9JkJXh9Y-ejxf7DJaDuytRHzTO-AC3p0O6eXUON9qndaw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdefkeehudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepjedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepkhhrihhsthhofhhfvghrhhgruhhgshgsrghkkhesfh
    grshhtmhgrihhlrdgtohhmpdhrtghpthhtoheptghouggvsehkhhgruhhgshgsrghkkhdr
    nhgrmhgvpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtph
    htthhopehsuhhnshhhihhnvgesshhunhhshhhinhgvtghordgtohhmpdhrtghpthhtohep
    phgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:smbIaH7BqOrHEL88Dn3VORFbCAcqraTh3poCQ54fKCBnAfd50OcxuQ>
    <xmx:smbIaG_2Jn5zwY7lw04gFU33sLbOWfss0TFxHOd4CIlPaukt8tt0HA>
    <xmx:smbIaOUCLZwF7wdkXgle_prDwSuxT_ZPJ5gcbbtzZUU4ZNOr40ZLFA>
    <xmx:smbIaJr0SL-rAGfzelgnMFEUGq0QKwanxMvA9f3-GfUerta7N2z7pA>
    <xmx:s2bIaKVVnU57GsEDIXQtrHXPwJz_qidf_IVVyIIjHee57Zn2O8fFhF5k>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 15 Sep 2025 15:19:14 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: kristofferhaugsbakk@fastmail.com
Cc: Kristoffer Haugsbakk <code@khaugsbakk.name>,  git@vger.kernel.org,  Eric
 Sunshine <sunshine@sunshineco.com>,  peff@peff.net,  Patrick Steinhardt
 <ps@pks.im>
Subject: Re: [PATCH v5 0/8] you-still-use-that??: improve breaking changes
 troubleshooting
In-Reply-To: <cover.1757879060.git.code@khaugsbakk.name>
	(kristofferhaugsbakk@fastmail.com's message of "Sun, 14 Sep 2025
	21:49:34 +0200")
References: <cover.1757446619.git.code@khaugsbakk.name>
	<cover.1757879060.git.code@khaugsbakk.name>
Date: Mon, 15 Sep 2025 12:19:13 -0700
Message-ID: <xmqqy0qffrri.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

kristofferhaugsbakk@fastmail.com writes:

> § Changes in v5
>
> Fix the leak that Peff found (with Peff’s suggestion).  Also fix (with
> Peff’s help) a regression where you were able to get into an infinite
> alias loop specifically when using deprecated builtin names.

When merged to 'seen' and run with WITH_BREAKING_CHANGES=YesPlease,
looping alias test would chage the behaviour, and the test needs to
be prepared for it, I think.  Here is how t0014 fails

expecting success of 0014.4 'looping aliases - deprecated builtins':
        test_config alias.whatchanged pack-redundant &&
        test_config alias.pack-redundant whatchanged &&
        cat >expect <<-EOF &&
        ${SQ}whatchanged${SQ} is aliased to ${SQ}pack-redundant${SQ}
        ${SQ}pack-redundant${SQ} is aliased to ${SQ}whatchanged${SQ}
        ${SQ}whatchanged${SQ} is aliased to ${SQ}pack-redundant${SQ}
        fatal: alias loop detected: expansion of ${SQ}whatchanged${SQ} does not terminate:
          whatchanged <==
          pack-redundant ==>
        EOF
        test_must_fail git whatchanged -h 2>actual &&
        test_cmp expect actual

--- expect      2025-09-15 19:16:26.340366359 +0000
+++ actual      2025-09-15 19:16:26.360366313 +0000
@@ -1,6 +1 @@
-'whatchanged' is aliased to 'pack-redundant'
-'pack-redundant' is aliased to 'whatchanged'
-'whatchanged' is aliased to 'pack-redundant'
-fatal: alias loop detected: expansion of 'whatchanged' does not terminate:
-  whatchanged <==
-  pack-redundant ==>
+fatal: cannot handle whatchanged as a builtin
not ok 4 - looping aliases - deprecated builtins
