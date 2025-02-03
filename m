Received: from fhigh-a1-smtp.messagingengine.com (fhigh-a1-smtp.messagingengine.com [103.168.172.152])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC675205ADE
	for <git@vger.kernel.org>; Mon,  3 Feb 2025 14:01:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.152
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738591299; cv=none; b=p86i5AAB+QEQ/vzAWFPMsTD8GqRDcYIJnfy9hOVNmMkm8fQ8Sv6KnZzHeHxHPoyST46UTJbvdWp0vA/DlWjpTtT+H4VT5mx/Qddu4NLfIZluzm3SxtPSaElKQlUGpcoVLCQKd+3nJn+mClhBZ0an2K8hpfEsr6XfTEGSZAACF9g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738591299; c=relaxed/simple;
	bh=pW36p+Smm+3zrY4bsM+92+0pyACiVPX3Ni3m18A+c9Q=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CRaVtzl5eEVsK68kJfWEJF6BbiZAXJmRUoR5COg4S5uEe0XQSh0IbJF/R1scNiIwswNVbF93vMI1oIEE6pXwnTzY6TbbrxJADgzqK+9Y7+J7nwLEfTnDi1pqYLdOkMV3UpEy0QLzTJ7b3j017MKdQDLblXzzgPMqR1MNXVI5jZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qkJpiUUB; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=NABcTaU2; arc=none smtp.client-ip=103.168.172.152
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qkJpiUUB";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="NABcTaU2"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.phl.internal (Postfix) with ESMTP id AD36A11400A6;
	Mon,  3 Feb 2025 09:01:35 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Mon, 03 Feb 2025 09:01:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1738591295; x=1738677695; bh=ug3Flh95jN
	OYvdtvVhOD+sbOCVdBtfBIrqQBzJpGw08=; b=qkJpiUUBD+wtMGpbVjx8Yeynpt
	9O+wiGrhUqmIkg70d8gq5HX7dHEGeMKz999F84MoIOfzs0ZunB1+oumu9PjzE3LC
	4f/zpz3qDKpziWf4A84bjPdCfpQP/9Fg8m8Q1gJl/tv5CBCIISwXuz9m5GFCvjsW
	dp57MAOrcV1BTsXfltnwi/87MgURFblkzuLxyrBVLD2sz9pkUdXsANJv0rmRD6QD
	enYzC8ydHUlp8JdEmMdjEFle3H6OlLSLzTeUgIbq74pxAK/Y6/b4rmNXiTMy3ART
	biIdgMMT2vtStnj9UPKb5xyNyHM69asDMe3WAc8nNV4FZo11ryZEDdLVc/EQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1738591295; x=1738677695; bh=ug3Flh95jNOYvdtvVhOD+sbOCVdBtfBIrqQ
	BzJpGw08=; b=NABcTaU2WpKpoBA5X4LpE22gDXPhz+0kaxMY++0ugDWB493QwUU
	Mn8L+nx3/2wuCmsdPObacuhpLQHCRmhPpXtzm8Bz+GUhtypDxyKNRyX+7OXcAWkR
	M2pKBZTEURyryml5w49VW5/wfLu7sZI2wecHZgHiyJegfXLWhMvg3JW5W2TIEIfK
	jGvXayvHWLLfJdVk6M5v56rVSJmCxiV79xr2mW+wvtbQeHicxUc3rxv/DLn8o1Mk
	6emNzso2A8P+JaK6BBpSj9Er/t3h+j1mFzqchudnC+CxKuaWoslOYmvAipL5HHiy
	HOHO5sepgwBgPU2aluZ7OG5B9MakNpynRoA==
X-ME-Sender: <xms:P8ygZ7i1KS58R7pVb1LiekFVBSLsboje8IZJbjSdz1bsqX_6vGg4AA>
    <xme:P8ygZ4DLm37-Z-nm5j_DW_YAnc68OcZHtq95Qbi-FyfInBZpuhUUCjTkD-vQQOZ1u
    0tCdb8C_t0m0o0NqA>
X-ME-Received: <xmr:P8ygZ7H9inIVple1JhN46LIV8QgjZ6ymTThF3qE8aH5e6W9wtUoKLt8V52kxD9QKebeOOZofLcxt8zWcbiLqvPPFLw0E3D8PBdsc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddujeejlecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdfotddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeeikeeufefhtedvffdtgeefkefhffeggfef
    iedvudegfffgffffveevvdeileffudenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeefpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehpshesphhkshdrih
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:P8ygZ4R2KkdPA5oGgER5FsI93kxqDD0RtNkSMOO7NTrlETx2fR8vzA>
    <xmx:P8ygZ4zSgmlhTvk91ZhVGCwHQZAH4B_tmbb3E0pOJ49VpJlw71I99A>
    <xmx:P8ygZ-4J1HdpPWONeSjIGVERKchPMvqx4RKotrv3Ic9frGZQxcEfeQ>
    <xmx:P8ygZ9yfOYTgcf2kBNSH5Gy2mZPIQ7mtH6fKPQpwS3OHa4J1CYSPSg>
    <xmx:P8ygZ09_jkuvhsS7lEezCWxjQhO_YM-JVBsZgjUw6WC5gXd8ZIXx_215>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 3 Feb 2025 09:01:34 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] setup: fix reinit of repos with incompatible
 GIT_DEFAULT_REF_FORMAT
In-Reply-To: <Z6BUOs7k1rzGOGTN@pks.im> (Patrick Steinhardt's message of "Mon,
	3 Feb 2025 06:29:30 +0100")
References: <20250130-b4-pks-reinit-default-ref-format-v1-0-d2769ca01207@pks.im>
	<20250130-b4-pks-reinit-default-ref-format-v1-2-d2769ca01207@pks.im>
	<xmqqv7tu623n.fsf@gitster.g> <Z6BUOs7k1rzGOGTN@pks.im>
Date: Mon, 03 Feb 2025 06:01:33 -0800
Message-ID: <xmqqikpryvnm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> So from my point of view we should treat the environment variables the
> same as we treat "init.defaultRefFormat" and "init.defaultObjectFormat".
> Those indicate defaults, but do not cause us to change the format of
> existing repostiories.

Hmph, as somebody who often does things like

    $ GIT_EDITOR=: git do-something
    $ GIT_AUTHOR_NAME=foo GIT_AUTHOR_EMAIL=bar@baz git commit -a

I do not necessarily see the environment variables as replacement
for configured defaults.  They are, at least to me, more like a
single-shot override of the configured defaults, so if we were to
complain and error out command line options (we do do so, don't we?),
I would expect the environment variable that gives a single-shot
setting to be treated the same way.

Thanks.



