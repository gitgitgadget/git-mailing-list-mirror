Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0888299957
	for <git@vger.kernel.org>; Fri, 18 Jul 2025 14:38:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1752849515; cv=none; b=Qszp+OasDX/y9YAfSP0FR+6nHFEhYCCKsZaPSQD89zCbudQOL2+eA3I0L7jjYHNO/SfWPsNphdn6hL0MRCVnmBa7hRn55p5JTm6DWJ7X5e4o7Ye3uYcgwUofPVK7G6ge8nKaK8OZM/WrBMhbTdZGMykgzfuXgJmhIOLrvixEWhw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1752849515; c=relaxed/simple;
	bh=tkQs17sX5Z3S0OWN0pQ21eLjUKRCpB/yz5bsE0ylwho=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=iaBs06LfjDGnBPDl9fhzTPKCfiPwbBZx+R+iykyPLua/h40tH86R87slVdWJUnGm6WeGBzNpoma2IXyXx+bIYQOUaDvYQIupNYf6Xt3+UT9tXO2/IIc7FVXWff8oraWd4sAKQH7P30PWe+QKN1+4F58S8EFLJ7ZmUyrgpbWfAeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aHZn8wJz; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=YJd4ZmzN; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aHZn8wJz";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="YJd4ZmzN"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 07B447A003E;
	Fri, 18 Jul 2025 10:38:32 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Fri, 18 Jul 2025 10:38:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1752849511; x=1752935911; bh=eARc/S40OX
	Z2llmZqbJxNpAOHs01gNdBg3Ss8xCZCz8=; b=aHZn8wJzERGnmfPQ+/6xmXrV/g
	uS2DX4uOKPJaiUK8dhy/dw3/OzbNOX0n3SSsamCAFTIUFE1Nb3zA9ZXfOJwnBqxH
	VIi5fzUa9urq5SgPmc6JeRPVpH135jolDzq9435LGnBSFyEB35iFkN+/oNRDGgT2
	gvXfPL8hlrrhzocgN9OcC5q6RpfwS32Jg9aZghMl45/ypaN0rTJID0G0M3ckHBkl
	iRytDqKg9MqLk6FHt8pI8DG6hL1OoiRBpGRsN/8cSJog01E47K1qK9EwThqL0S0W
	t652q3nksM35Zkc2DFyNJpgTTSnmKXTDAFCpN/kUlD71Xe0BUKpIOvEpqMeQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1752849511; x=1752935911; bh=eARc/S40OXZ2llmZqbJxNpAOHs01gNdBg3S
	s8xCZCz8=; b=YJd4ZmzNF93sHFwptzyZbl0OvX+2+VhI3aX8qJFFfpJZeNCQ/wE
	v0zGtpN+u+2HzGcbfywVQEf8UEHPD2q+dTAyb2/pJCvUNRw8Gt2nD1IswYlJY+iM
	LcWPzYmsKh/Sa0gyY5BKCmnw2WpTZHz9096C1F+gZM8rp4DESZAz5I1ePXZrmn87
	S/lzdsVdnhM8eRyU/JHCIrnBHWFUn85FWlr361K4n1k7YMyvTd4NIxMpz79XErnx
	uiTXrT+hDfuwiLOawnyy2CarxiUqLuQVWRUvA0D/b3GSbm59jEsgK/UDdMfJ96WL
	3bLtLHxpTQo9w4NLvMo4IUqMHuW/UhwYyvw==
X-ME-Sender: <xms:Z1x6aBJmo3nhJrjxPaSTDiuliCqv-60LwXpAabd3ogm9fIOsMMGNig>
    <xme:Z1x6aIo08e93eoeY5WZSSibQu9vUa9roQ_swcuCW2h-tqW51EZ19RkBMuxasJy_2t
    bsxSHFdPFWjHomImA>
X-ME-Received: <xmr:Z1x6aAKFwH_TfRzqm8ELeDZ6EeEWZe12kwe4IW5DOqCId_mYW1n4nCLugU8zILm50gUugM5o8w7rJUsph2RL5U4bLfQCUogFyhgF7l8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdeifeejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeehpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomh
    dprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohep
    nhgvfihrvghnsehgmhgrihhlrdgtohhmpdhrtghpthhtohepvgiivghkihgvlhhnvgifrh
    gvnhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:Z1x6aNQqZutm_mxpMBYmIM9eNUMVcDQGgtZfNv1GVlNEkogWov0AUw>
    <xmx:Z1x6aPsNZ1z_RXoZ-TvpZq8ZivxhhIUH2lamNQBYmW5UEbUmYP4AXg>
    <xmx:Z1x6aOa9DdKXvBz_LmKZ1nUDhnqX2AFj090y79UVEi0G1CmeN7s3DQ>
    <xmx:Z1x6aFHA70OYps5kHuyVV7HtTzNqQWwsEWFd4Kv3IRuynHcpoXz1PA>
    <xmx:Z1x6aEq9srCD1371S2WOYf99TgqcsPxQSYNljcnUwo9MutJ82SYNuJ9v>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 18 Jul 2025 10:38:31 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>,  Ezekiel Newren
 <ezekielnewren@gmail.com>
Subject: Re: [PATCH 0/7] RFC: Accelerate xdiff and begin its rustification
In-Reply-To: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com> (Ezekiel
	Newren via GitGitGadget's message of "Thu, 17 Jul 2025 20:32:17
	+0000")
References: <pull.1980.git.git.1752784344.gitgitgadget@gmail.com>
Date: Fri, 18 Jul 2025 07:38:29 -0700
Message-ID: <xmqqjz454l96.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Ezekiel Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> This series accelerates xdiff by 5-19%.

;-)

Do we know how much of that can be attributed to the hash algorithm
difference, and how much for languages?

The earlier parts of the series to trim unused code and refactor
look to me that they are good changes regardless of whether we
introduce a different hash algorithm, and/or we use an
implementation of that different hash algorithm written in Rust.
IOW, even if neither of these two happens, I would think that the
earlier parts are independently good pieces.

Thanks for starting this effort.  And thanks Elijah for helping.

And in case nobody has said this yet, welcome to the Git development
community.
