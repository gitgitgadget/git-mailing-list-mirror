Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1195237A4F
	for <git@vger.kernel.org>; Fri, 10 Oct 2025 21:25:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760131521; cv=none; b=MfzncQXauO5uFnq342kXw2rlX1sOxxZ/Gr3iMc0UC0Es1RWLzApXZKsRRgX54g0/tmXJGqjVaME8qk/52K7BQ831lBnvoNg/lz/wJOtPwEeEuSBDE75BeFk3e/p1vqMNxDlBLNzvKuVZ/5nHddbnbuQNEE7f42sLhbPn2ehA/oI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760131521; c=relaxed/simple;
	bh=cou/2eNvkxMA6dUX9NJrxfJcWgaooUEHw52MntWZBGA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=suXYopk3MkCrsqdZhAyO6ICVWf5W6EYwoBM8joqYdOxFZ1iUcOMEv6iGb9Thr1w9959GticGxGJLI4Zl/Lc2OzvkL7kWkQnHM9RXKGAoxx/gqWNw+BoM6Ior3ghn6rvI1Cpx3Rz8UusnXJghpkRfeSNxrXXlPKpHOjtSNVld6bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TugLXdk+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=oDm5oERk; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TugLXdk+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="oDm5oERk"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 9A13B1D000E0;
	Fri, 10 Oct 2025 17:25:18 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Fri, 10 Oct 2025 17:25:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1760131518; x=1760217918; bh=cou/2eNvkx
	MA6dUX9NJrxfJcWgaooUEHw52MntWZBGA=; b=TugLXdk+uLd/hmO0J+TupTHGD6
	QLcurluzvvWFwz4Y4dOa5hi3DcPmD0kDMqAnY81TgF740OCkHGzqcLjkm9fU3cO9
	xTg3gNQdm1+DkZrGPSu3C3VXfBOtDvHcB+Yk7r9TUTEnEDEFmhlu7ueAdi7ACS6+
	W7FC/6AfkZKVa3dVbHjo9QK3ex8eaWBKSSRrW3dgdl/HqNkCOfj5r2BnJN1m5ZJ6
	HkVBLA6CPFrJQGxRaO5ZNISAd7Gu+YCdksdTqECdZTFo84D1QU8qx+K43y9hLqpz
	QSfGJVc1xMfB6wy7qpnd5OmTFVo7JFDnIYUMpXuaz/p6JwtU4E1fTb3bEqZA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1760131518; x=1760217918; bh=cou/2eNvkxMA6dUX9NJrxfJcWgaooUEHw52
	MntWZBGA=; b=oDm5oERk7O1BsPqgckxDZ6DYIOpyhYfqxUd9xUN9E9MNRk9IQ18
	7CX6tworLpQ21ZxNVyKfiSlvztSet1QUG7MJdLC4diyi01qPQR3P9AkPtEyos14w
	CxuaOjt+Lbz+4unI07rPdPGchHOayGI1CSNivr88WV0QjTUs4hz6EGbQeruWJ4tm
	CdGkYI1pzJenm+h72MwZS3mD8Z0l73+7RI++UtmXxdNEP9XcG2tln2ZjHA73yhU5
	aJNS+SLthYJ7totwV5ioCBtph80Lgx/d9Kw6oRvOUvIN72199EHU8C8ZIqZIio+n
	m+wIoJNWGwzbOaR0Fk3I5oGp2+dSLimoR5Q==
X-ME-Sender: <xms:vnnpaDu-lZWVVhjXZFxFVmdwW5xCbYPNUYDDo1Z0Aqr-3rtZIYulCg>
    <xme:vnnpaMOE2aqBHJTotea3_xFTmgfhy9I2qxO0MoXAXAXoPNNtIboUQRLtV73PXZHNu
    W8qy_LB9kVJUoyGObtNCigfjz_XF1zEU1LM9yoLPI4aefKeI8M0>
X-ME-Received: <xmr:vnnpaJ00ChQYhM6jLZ4Q2c7HnKh94n9MSHXoWF-XM_pckidZAuu7JGm6-SfaxSZGewJ5rCYdX1mwOIplBb9N35K-eu1uRDC49tK5>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggdduuddtudefucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepthhhohhmrghsrdhuhhhlvgesmhgrihhlsghogidrth
    huqdgurhgvshguvghnrdguvgdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:vnnpaAP26mSCEfARRB3GGBCK312ZmgMlEmttQx1nhVDlsDjEcAdV-Q>
    <xmx:vnnpaB17qOOxG0_S-tYlOTOTQ_DyIWKj8jdKP-lfBiy4CgJoTks40A>
    <xmx:vnnpaPE5Q1XrNLIa1LvMSN7xTI3l3DpD1BgsSU8va-RzG6DJSyCOIw>
    <xmx:vnnpaG4_xIkTqhDkrvUHBoEAIcRB76HXxtoIYk5lMjnTZzmJrVC0sg>
    <xmx:vnnpaHBbD-u2G8gl6dYaUS0P-5fi7wyVhsZB0RNPf5LAqkkbw0Woo3FZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Oct 2025 17:25:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de>
Cc: <git@vger.kernel.org>
Subject: Re: [PATCH] contrib/credential: Amend and harmonize Makefiles
In-Reply-To: <c7cd0568-8161-205f-7f3e-ce63808dec8e@mailbox.tu-dresden.de>
	(Thomas Uhle's message of "Fri, 10 Oct 2025 23:03:47 +0200")
References: <48d92664-41af-bb59-1844-7bb57f21924f@mailbox.tu-dresden.de>
	<xmqqbjme8rs4.fsf@gitster.g>
	<c7cd0568-8161-205f-7f3e-ce63808dec8e@mailbox.tu-dresden.de>
Date: Fri, 10 Oct 2025 14:25:16 -0700
Message-ID: <xmqqo6qe78lf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Uhle <thomas.uhle@mailbox.tu-dresden.de> writes:

>> Content-Type: text/plain; format=flowed; charset="US-ASCII"

Please make sure your MUA does not corrupt whitespaces by sending
your e-mails with "format=flowed"

$ git am ./+tu-credential-install
warning: Patch sent with format=flowed; space at the end of lines might be lost.
Applying: contrib/credential: Amend and harmonize Makefiles

