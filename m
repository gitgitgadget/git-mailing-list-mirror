Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4DE678C9C
	for <git@vger.kernel.org>; Thu, 13 Mar 2025 19:16:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741893373; cv=none; b=WAAF58s3X57J3bZODGG+O9qSacMvDVcVA8l9J8Qpdb1+Ah0yw0ojBCla3ZUIh1OJ6rFxsVwDaPqoXSZVAV3hBue0MpjlDCLRPgxqk2jgm9hEUCumM2CeRhmPXWSaAKt9k68/t2lM+1O1OF5orGe0j7aDKQZ+FWuuhdYzc8t2//U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741893373; c=relaxed/simple;
	bh=zhTeAJphKm8/TiGa+b7NCuwHk9JH4bFFWKxGEBqKuXQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=K4aECXc4y9ybB9uZPdR2Y037gLY3nisJmDAgjRORhNgOvLzCpZtlTCUbp+n9nsyFIDXDBZyQiQc7Ackc1oYB5AZGTK6DJsHVGJlI0gmGAKXzVRD0h1xiTxuADQCSgXVJSWP7tbVKBFRVd9XbEc05lGl7LfEpuPYPHbh14dwS15g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=V6QhmrXs; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=L0oKeJ3V; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="V6QhmrXs";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="L0oKeJ3V"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A1FA911400DA;
	Thu, 13 Mar 2025 15:16:09 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Thu, 13 Mar 2025 15:16:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1741893369; x=1741979769; bh=cGc1Rbr/hG
	J1REX+aqM7QDVVQpkZVKBdJLZ9bu+dYCw=; b=V6QhmrXsPf+u5G+Irg6fa+boDZ
	7pYTm59+R1zeAkeCe0aon1BCTv8f68E1yxUk2TnnFyuafULyfFIw2R46cZLg1tPO
	V1s7JY20mKWg2ScPRBcFh3pzu38vtfexVE5GjLlCTMI0oMxtCOIFeT/M/6cBAZCJ
	zD3McsU1tYsJOAiqRYViPOrx+y3nJbPwRyB0c19HQjF124DkSYTbpF8zynHfFijo
	TYAHdONLYFae9b95xyAbjzGJRfThgdEQwx91a+k5GyMUHdQr/JwmxB9LRsDtoQEF
	eShytkqFdCwnQntp0Fc5tJn5NuFXdvwirb3t6XwZ3r7lxig+fAmEo5tDXTUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741893369; x=1741979769; bh=cGc1Rbr/hGJ1REX+aqM7QDVVQpkZVKBdJLZ
	9bu+dYCw=; b=L0oKeJ3V6+T29z3En95cc8rsryV9yYkXBylgdhaaV5ONF2S0rTi
	h6yJet5oL5N7f4FpRTbYxBZRGBS3JHzUcCutrtBsM2jLzNrtOi2iE/gpByR1mdcu
	+nyO9mC7pSypcAo0+fXbFa/E0menes6KVhu91zCIw62fmpTvvmMQ+PKv7TYUROO9
	grPn6TvhVomYSoDxesMpbksljsW+ZRaMvOZkosHh6rYlcBoFIx4uQW5onpiCIZq7
	e1M8/obWz5moo/zIhJ3BdBPgXQ3zDLioAcycQc8i8UT+bL+L0wluTmk8MCw/rFpt
	i4el9N+Ki/p2lC4J52ykpCDMy8OPOvtTCTQ==
X-ME-Sender: <xms:-S7TZwC5PX5IPp93cNuITdXSuqROwzuku3I9z2h8s2oVfLkEzB47tQ>
    <xme:-S7TZyjhcwha4J3yFIk5tszes6rUKsHJVKwLvNXAwZUFEM9jRAnKjKedC9MwoQGzR
    ViY__3LDpCK97-xXA>
X-ME-Received: <xmr:-S7TZzkm4e1z88fJ7EkxOamlX_hN8RpVC5BvdO2TjQYkSOBsSI8y2N0OZfIOmJzcm1ouudrJxCJw30gpbboLNsx0yLL8T_M_B9G-9vk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduvdekjeejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepffeiteeujeevfeehuddvjeduffeijeeg
    fefhtddvkeefjeejhedtgeefgfeijedtnecuffhomhgrihhnpehgihhthhhusgdrtghomh
    enucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgihht
    shhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhmth
    hpohhuthdprhgtphhtthhopegsjhgrrhhnihhighesshhimhhnvghtrdhishdprhgtphht
    thhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepshhusghmih
    htsegsuhhgshdruggvsghirghnrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphho
    sghogidrtghomh
X-ME-Proxy: <xmx:-S7TZ2zoo4BmNpk1oBlmtDlgq_H5BRnUZ1C_vpbZmQdkbWINJId8og>
    <xmx:-S7TZ1TCbjCt83NX9FZKb6OsaAOAhU8UKFeVSVmQzettNzgtrW6fHw>
    <xmx:-S7TZxbSFqDWWB-hD54KeJsAz7V8mJ17elCCfAgSsgsH5ZFsG21LyQ>
    <xmx:-S7TZ-TIXN17fs2V_q6aq7Rtgh4bISsR8ijFE1DKFUL9x4iVTcAv4A>
    <xmx:-S7TZzMQoSNHkc0W95cC0_31T1No02cqjT4Jgq0AFYqgTFvI_idOyxcy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Mar 2025 15:16:08 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Bjarni Ingi Gislason <bjarniig@simnet.is>
Cc: git@vger.kernel.org,  Debian Bug Tracking System <submit@bugs.debian.org>
Subject: Re: git-filter-branch.1: Some remarks and a patch with editorial
 changes for this man page
In-Reply-To: <174188934245.21716.6680332666412833022.reportbug@kassi.invalid.is>
	(Bjarni Ingi Gislason's message of "Thu, 13 Mar 2025 18:25:46 +0000")
References: <174188934245.21716.6680332666412833022.reportbug@kassi.invalid.is>
Date: Thu, 13 Mar 2025 12:16:07 -0700
Message-ID: <xmqq34fgoi6g.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Bjarni Ingi Gislason <bjarniig@simnet.is> writes:

> Package: git-man
> Version: 1:2.47.2-0.1
> Severity: minor
> Tags: patch

Thanks for noticing and reporting.

The patches you made against git-<foo>.1 files (this message and the
other one for imap-send) unfortunately are not something we can use,
as all we write is asciidoc sources, e.g. a URL with marked up this
way,

    https://github.com/newren/git-filter-repo/[git filter-repo]

and it seems to me that the problem you are reporting and groff has
trouble with is how the URL marked up that way is rendered in roff.

I think what needs to be patched would be the toolchain that goes
from AsciiDoc input files to xml to manpages, not intermediate
output files for individual documentation source files.

Thanks.
