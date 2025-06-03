Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02E7317C224
	for <git@vger.kernel.org>; Tue,  3 Jun 2025 20:43:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748983439; cv=none; b=SN/cXBRb0+lHL3WKf5fXJv6zL02izK3LS1lvI8GlvggJEbvsAAhxi1mvR3KPCj05yyb7RLHVezFz4Gy329wKnEmNJ2AHMplyWfqmYgut8loItcMGKYNwwSSwjcmXdjV8Qnzj64CNoqyJQvyfzS4lP2xDx0RcbKceq5bRpPJ95Xg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748983439; c=relaxed/simple;
	bh=4UEGV4bHaA/qMeOmXq15PEDaS8S8Dp0f79VsCjE1GEU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=kXbifTtq7glZvIwQw+ZzhGa71jKLGuNl8vwJtrAUb4apAtRASP7INAhNtDpkYFjkO7lmoBe/QqXFQFW/K0uMjYnAiz4VXOq/7qWErF/02TJc48aZDxuSyLdkPu442IEeKylIPyo/bOPVzgHAclvDyhpApOrcWEnmff19NK3PoNI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=wUaSYU5V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pcoZn1yk; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="wUaSYU5V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pcoZn1yk"
Received: from phl-compute-02.internal (phl-compute-02.phl.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id EDD40138034A;
	Tue,  3 Jun 2025 16:43:55 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 03 Jun 2025 16:43:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1748983435;
	 x=1749069835; bh=AzDZClnmKHIiKosQZsDImoOhDy1LWIn9/zLWrongwT4=; b=
	wUaSYU5VpDYfnsNPydg7Famzr57j0mn9jOrwPryiMWhUa3RmkmW5ULxjMaqUNnN6
	n2ko/eSlbqQM+4P6XV7aIhkl9r3TESmPmpujNGj2XQbRT+mwCiB2TWCQ97HTf3a8
	+PH9sq5tEMn+BCpAcYwu4XN4uIdmgcTDOCLeYuQbO0hnRD+qspn7SJcalIz925sp
	eA++l8yfb9zQ8WmZDI2DkVYzCVY+K0zD5/6kDcUIVeLpxUAALSn6c/PorGUMgq2r
	RJk+UfZVKadgGPeE6HVyoC/VyFyY+LyvtvPv8xhTU3N0YbHK/Ptzycp0udqTqJFv
	xtAoXY6V9tADjthIg4PbiQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1748983435; x=
	1749069835; bh=AzDZClnmKHIiKosQZsDImoOhDy1LWIn9/zLWrongwT4=; b=p
	coZn1yktaEccJmKEQB7QrWQYqQz8SN+Fbluyzr0pONAsopU2odMRcfsbPASw5sqD
	JV+7wd2SVwVd3VtXwz1uam7ADhQcSY8zG6FQzxML0c/ntjO0nGmMLe5vyUI8XKs3
	T+iYoqE+jjJMNoVrPNHAsZxQA8s2uBlqnJGwQ1QoniKS8q9KEGGrUsPkeIE9qaCS
	Sob/jhvg53Yvq/SNM0S/ArBeYP4PI+MGk/dfjHZRj0gsYeg0vfBGDfYVz0hO4jZf
	YU70HSp32DRVzv5kAMGsoqTqKkGFxXiz6rwmq6ozHrFuuou5pbqNyr4A0F+3njtu
	BivOElBI8gfAny1JIbeGA==
X-ME-Sender: <xms:i14_aDWd4mozDCnWaMA26lL1S4GRIL7Jfd9jI3vfgkz-T0ERa_VKPg>
    <xme:i14_aLmpjEa-iv-BA5tf84FHp0SHYFGRQp7eYyTjmKL9tY2nHwv66PXDSBy8NX2nF
    y91nkMj2IXoDsCtUQ>
X-ME-Received: <xmr:i14_aPbRTEbXGMZ5D2ZY1HNDvgv6R0ROmOu5SPwv5QEebK3wEFCkcm22xyDrl701b4Bxf-uFIP6VfHWHTndjQfTZRzryllBeFVFW>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddtreej
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeef
    heeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtohhllhhinhdrfh
    hunhhkudesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpth
    htohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:i14_aOXVAxushFL5Bsi9_NozcKjWmmnrmHJIj2gOZL49qxGEpZYryg>
    <xmx:i14_aNmULfQaAC0YeEpNB5ba6sP2wYmFi7edkXrRSf_gyFBmdz5Uwg>
    <xmx:i14_aLfyFdJm4Nlugk_U4iJM1vTMpCMSkOhpUe8BzJmImAI_nPtVoQ>
    <xmx:i14_aHFTuhDSR1XNEF5vnslN2ayQn53hlamBddflSRVNT6xgSIuepQ>
    <xmx:i14_aGLIAafeiwBVDSbGLeavF7KLgC6nTzjhm4D1Fu5V1HqtpmsClGfg>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Jun 2025 16:43:55 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Collin Funk <collin.funk1@gmail.com>
Cc: git@vger.kernel.org,  =?utf-8?Q?Jean-No=C3=ABl?= Avila
 <jn.avila@free.fr>
Subject: Re: [PATCH] CodingGuidelines: document formatting required by
 generate-configlist.sh.
In-Reply-To: <87sekgpsbe.fsf@gmail.com> (Collin Funk's message of "Tue, 03 Jun
	2025 11:56:37 -0700")
References: <xmqqplflsmic.fsf@gitster.g>
	<45c586122afab8ae3624be6963d64e770b7396b2.1748911713.git.collin.funk1@gmail.com>
	<xmqqiklcri3o.fsf@gitster.g> <87sekgpsbe.fsf@gmail.com>
Date: Tue, 03 Jun 2025 13:43:54 -0700
Message-ID: <xmqq5xhcimid.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

Collin Funk <collin.funk1@gmail.com> writes:

>>     `core.var1`::
>>     `core.var2`::
>> 	Description common to `core.var1` and `core.var2`.
>
> This markup is different than what is used in
> Documentation/config/*.adoc though.

We are updating them gradually while avoiding collisions with
patches that do other "real" work; see many recent patches to
Documentation/config/ area by Jean-Noël Avila for more, e.g.
d30c5cc4 (doc: convert git-mergetool options to new synopsis style,
2025-05-25).

Thanks.
