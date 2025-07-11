Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F068015E5D4
	for <git@vger.kernel.org>; Fri, 11 Jul 2025 15:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752246065; cv=none; b=s+/1Mb69i/xzsJHU/uqX9r1zo/6BWSNxN+D8WbLB3RfiTdkjDKlJuHmU9ONxqphgAmNvD7OdsBKOsMsgk7lbEOKwn0PAfBoeUGD03+RUBzKL/Hc0AhMV09KtDHdYOtGcMPiHGoQUTCQtQ+eg6PZFVK8g8j33WoyvMtrwPnwyR1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752246065; c=relaxed/simple;
	bh=QvEAi1qZEfMbiSGGP1cTIUJCGIQGn49YP+ccExOerRw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CYKRQiWeF3GqsgnwSdKCowri900A7S6dzP6p/aY4abSEVeZA0xlSQ0eojQUKkJvgEtj114+YicTijaAMavzHH76tsm21PKbKh55bPpKfJgxctyMO4rEBeU9IaSUBKgnxaRqg5h4qVNqF/eN4RHNH7deiummvDPRkRXRSPaNAXQ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=fasKCicL; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=C+2qmaQR; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="fasKCicL";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="C+2qmaQR"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 1D8C5EC02D0;
	Fri, 11 Jul 2025 11:01:00 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-11.internal (MEProxy); Fri, 11 Jul 2025 11:01:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752246060; x=1752332460; bh=J2MW6wNcD0
	xKvET2BSQ2qAjyUGjn/fuuDthTzwJOcho=; b=fasKCicLfgPvKhR/Z/tqdeH3eZ
	2RNEqq/FxWXATYODxmUrpRAQ/X7CO5osgH9cMi6nF3U/cb1EdU3ZsU4jj+y5oahv
	ACgoltMet9ib6oykIUBEY1AF7AWNxza4ifA9xkxw1hS7pyxblrqTzdiotW4b8f/N
	RTFYjstGvBlANth7y/wlkOT6xgF7ip0P2vldgtKapuyZGHTNxmcvReWlILtw1sew
	nrZ1x3AiqBB5/L0PHtgKZX7cTdt/6kWFPM3Red/JJcw5QwfkOAHvAMFushTSvzYJ
	yhMfmtW+rNwBbXizXNbUGA/DHpNtMx/+PP73himTlMlujMxH7qcdE7JnkHSA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752246060; x=1752332460; bh=J2MW6wNcD0xKvET2BSQ2qAjyUGjn/fuuDth
	TzwJOcho=; b=C+2qmaQR9bEEWODD661Tl8EcJZuSbbQqtphxJ+wTgxeg2Ruw4At
	Id4fVnzYgCVWEN1MpNTAdAvQ737XgWO9pYS8gDDI9dRa0yxPqrRxm52WQODqEHX7
	BO1ozHqYwTKcbqdFBmqexoC+27YwYEuAKBzLPEC+votFum57L5pIalvesuZtHnft
	KeMii4E46w4uXmsDVWM+D/DfVs2iH9FF6fzDUpnjsD9snx2lrYUa239PK+G2tWV1
	qcfYVUvfChO6ZqMXLsdciZTjGSt+YkOSsmsCuLYCErTHRsQx6UgTvzSeThfsIDUg
	WBdxZrE7Gh4eULB7ulohlg3QVzSEMKAByUQ==
X-ME-Sender: <xms:KydxaMQHgGU1TlWWQLSy26rDaGuzUYlCtuqyIcTOFxaEdP3wVyMr7g>
    <xme:KydxaDOcbgzBi3c2e3WQMVbeMspf58Y9FMsHgG0bTSpuGFdY4h0WpoBvG88C-oF70
    P57XPTcNENx6RxUrw>
X-ME-Received: <xmr:KydxaJahCDMhIlZX42PF78G3D-zkWgDFVI2LW19YkCZnzM58dvItjHn3KHgcMJ1zIxbydWUnDJDq-g1DaQBFQkWoYZge0YJ0PzZ4sVg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdegfeeivdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtoheprhgrmhhsrg
    ihsehrrghmshgrhihjohhnvghsrdhplhhushdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogi
    drtghomh
X-ME-Proxy: <xmx:KydxaFykDA4U_JkSeK2eZz8HCoyBMLQSyXtTfYcIAjPYkM4dwrXBSA>
    <xmx:KydxaMKJCb8opgPGrE_oJwDT9uzYzDUk-3dPiMwlxmGvBBQGBT8y6w>
    <xmx:KydxaHqGvsZod35fyG3_ls9PpKtlz-8ZEQD1YJJAd3gFaoBv3BgZUA>
    <xmx:KydxaDIIChZj9Fr4pZsBY3C-JOloIG-JJycKfMMv7Z-I8bV92v0bXA>
    <xmx:LCdxaKgjaOeYG73EtdhNfTbizwMJBzMUcQSMqAB_xgvdIBm8_uldWzJr>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Jul 2025 11:00:58 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Ramsay Jones <ramsay@ramsayjones.plus.com>,  git@vger.kernel.org
Subject: Re: [-SPAM-] What's cooking in git.git (Jul 2025, #03; Wed, 9)
In-Reply-To: <aHDP_GK0ytKkp_3n@pks.im> (Patrick Steinhardt's message of "Fri,
	11 Jul 2025 10:49:00 +0200")
References: <xmqqv7o08ocn.fsf@gitster.g>
	<f614e1c8-91a9-4430-9d60-5aca05170b4a@ramsayjones.plus.com>
	<xmqqo6tr698f.fsf@gitster.g>
	<61a9185d-8ed8-4794-8f7e-1ed64503cc62@ramsayjones.plus.com>
	<aHDP_GK0ytKkp_3n@pks.im>
Date: Fri, 11 Jul 2025 08:00:57 -0700
Message-ID: <xmqq34b24vrq.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> I'm happy to just drop the patch and let you handle the regression.
>
> There aren't any dependencies between the patches in this series, so
> it's as easy as removing the patch. Junio, do you want me to resend the
> series with the patch dropped or will you drop the patch on your side? 

Will do.  As always, thanks for working well together.
