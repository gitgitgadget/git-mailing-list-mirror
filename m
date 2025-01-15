Received: from fout-b6-smtp.messagingengine.com (fout-b6-smtp.messagingengine.com [202.12.124.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0EB51DA62E
	for <git@vger.kernel.org>; Wed, 15 Jan 2025 22:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736980851; cv=none; b=LVMYDkueUAH/ddc1uFEgYekWS0eu8U4J5ktUq6xFVFUr/ceqaMc0Y+u+uVpKLLAZT1O4nA73EL1sAZAOKT2zPmj0a4dYsvxRQdPrAiXty39f7bww/I/S1M3JIDqcTzqEBoanwZq7wfjQJAcEtlykRn/kxaPB+bx7g9ovTo4vs0Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736980851; c=relaxed/simple;
	bh=xiR6UHZIt25yAPsdTTRKRSyaaFO47b2yX0ggkCbmqBI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Q86Jn4n/sUVmOkAIESFyXXDqVi3BqyLqVXi1ptqtYo3ZtqhtRlsMKv70XZ+osYUgVzD7z097wrDcblG+0dG5sgOmVsaBeYB70uYaVyKC8QBMbEyjAqnSwEqF/u/w6lVXIhjsT3efY8RB+FC9gkDM3E6ww6yhbknPs6tlm2i4oBI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=HBpbBY6L; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nJSpLTxD; arc=none smtp.client-ip=202.12.124.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="HBpbBY6L";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nJSpLTxD"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.stl.internal (Postfix) with ESMTP id 886871140197;
	Wed, 15 Jan 2025 17:40:48 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Wed, 15 Jan 2025 17:40:48 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736980848; x=1737067248; bh=6bVhwbi6ey
	Z+/dsGs0jrqfpMIU1MOsLNBkBfYPWPV2U=; b=HBpbBY6Lyws1BsDHvO7i6Y52KQ
	ezgaUHjuKmD54tLCJ2cQBOIkCFSWfpQ7RzIH0IeLLnJu1s1TMUKWaYGyZKDLu6eN
	Pw9ZcvkuQZQ4/gDK9EahgJ4oxe8l1eOhYQFodretiY8sxFZRsb2zQ2wuA4jyOF8y
	XYfJDPCykGS0S7anZ1IUsLGIjAm31Fg+SRPk5tvwB5Sg/efiO4agjWOBudQOGsJn
	8szu+gXyuSyZcQBPyjxbF51jBpmJYpcRzmCiHANj+TN4anxKHBgp0uR9LI5He0Kk
	kywy0hqAhfUI7h0DX9l7MuBMyxFD3aXOuvApklXB8Khxg0Hpxg/K08NP1jag==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736980848; x=1737067248; bh=6bVhwbi6eyZ+/dsGs0jrqfpMIU1MOsLNBkB
	fYPWPV2U=; b=nJSpLTxDlJ62ExAmqWiN8Z77mPZTU9q7T58BXuftPm/OuNl2VuB
	X9Ef2Xxfosp5uYv+VCDttqKs8wI/AZE6rI41hAQ5en+wjcmQh3keCIWGKmFSHe6B
	IwzBAiOkvhCIu92ZLXqTVRedIxsQjeXkpT8YIvAhTbbiteIlmhCQZLQbiPsXXatL
	Os3e7fRXwnTqJLcUHRXAwBTUdrQTxlbyozx9odEVp69MOzh+iqOTDaN1VPzpetdL
	NaXqKs6lyc9hmgNPX9fcpAk9ClWgmLdHdnnA1gSBdtHiRCaXfTgSrzNgwTR8+/mb
	CDSvD1HG/c+1WKr6XhnyInbHWaQjQ1vjupQ==
X-ME-Sender: <xms:bzmIZ4ko9lD3mQZgFIdPttoi3e_yOw4RgNtdl2rorhBGbFW9SZggmg>
    <xme:bzmIZ310fBUoucb5bxY00i6s1RlAO0mhOV9Ys8u49H3BAG8nRxQwBM4k355UVy89K
    mhmafAp-G0Tmiguyw>
X-ME-Received: <xmr:bzmIZ2o_Qrfi7ovsBFo2KyLIkNZ5tumpVQ4PXdhZnHy0JZyhD5tCP8IfY35My_M5I49ivcUIDu974PNqks6nvQp7UzdkgQXX9r9o>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudeitdcutefuodetggdotefrodftvfcurf
    hrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffrtefo
    kffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsuc
    dlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhr
    ohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtoh
    hmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueff
    teeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmh
    grihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthho
    peduvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepshhtvggrughmohhnsehgoh
    hoghhlvgdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhg
    pdhrtghpthhtoheptggrlhhvihhnfigrnhesghhoohhglhgvrdgtohhmpdhrtghpthhtoh
    epnhgrshgrmhhufhhfihhnsehgohhoghhlvgdrtghomhdprhgtphhtthhopegvmhhrrghs
    shesghhoohhglhgvrdgtohhmpdhrtghpthhtohepshgrnhgurghlshestghruhhsthihth
    hoohhthhhprghsthgvrdhnvghtpdhrtghpthhtohepmhhhsehglhgrnhguihhumhdrohhr
    ghdprhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepshhunhhshhhinhgvse
    hsuhhnshhhihhnvggtohdrtghomh
X-ME-Proxy: <xmx:bzmIZ0moyTK0flimrMJGN8aqm4JsVVn8yzPTahbSauSUof3g7Z66aA>
    <xmx:bzmIZ20BnnoR_7qlrad5GZQ6S0I65HnwVQh0UzpqcsDgdDfWOYc5SQ>
    <xmx:bzmIZ7sl8YFhWGOs4gtVZfFVX5VFegV4IuqeqRaJflcrpxerPflPkA>
    <xmx:bzmIZyWklGBjJGiTBQ1hMPIiLBmrkgToQcDvDPtxouLstWOemX8-6Q>
    <xmx:cDmIZ8P3dZa0R79AnoCUPCTMoMFVT5QvICidxXtT_ZjQXycvC-KUypI5>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jan 2025 17:40:47 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Josh Steadmon <steadmon@google.com>
Cc: git@vger.kernel.org,  calvinwan@google.com,  nasamuffin@google.com,
  emrass@google.com,  sandals@crustytoothpaste.net,  mh@glandium.org,
  ps@pks.im,  sunshine@sunshineco.com,  phillip.wood123@gmail.com,
  allred.sean@gmail.com
Subject: Re: [PATCH v6 1/5] common-main: split init and exit code into new
 files
In-Reply-To: <ff6cd62397ec2755d15e9d76f9af8a84b54a36c1.1736971328.git.steadmon@google.com>
	(Josh Steadmon's message of "Wed, 15 Jan 2025 12:05:40 -0800")
References: <cover.1723054623.git.steadmon@google.com>
	<cover.1736971328.git.steadmon@google.com>
	<ff6cd62397ec2755d15e9d76f9af8a84b54a36c1.1736971328.git.steadmon@google.com>
Date: Wed, 15 Jan 2025 14:40:46 -0800
Message-ID: <xmqqr053wvip.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Josh Steadmon <steadmon@google.com> writes:

> This split has previously been proposed ([1], [2]) to support fuzz tests
> and unit tests by avoiding conflicting definitions for main(). However,
> both of those issues were resolved by other methods of avoiding symbol
> conflicts. Now we are trying to make libgit.a more self-contained, so
> hopefully we can revisit this approach.

Yay!

> Additionally, move the initialization code out of main() into a new
> init_git() function in its own file. Include this in libgit.a as well,
> so that external users can share our setup code without calling our
> main().

Sounds good.

> diff --git a/common-main.c b/common-main.c
> index 8e68ac9e42..6b7ab077b0 100644
> --- a/common-main.c
> +++ b/common-main.c
> @@ -1,92 +1,13 @@
> ...
> +#include "common-init.h"
>  
>  int main(int argc, const char **argv)
>  {
>  	int result;
>  
> +	init_git(argv);
>  	result = cmd_main(argc, argv);
>  
>  	/* Not exit(3), but a wrapper calling our common_exit() */
>  	exit(result);
>  }

Nice.  Very nice.  I wasn't too carefully validating what we lost
here is identical to what we added to init_git(), but hopefully
others would spot and stop us if that is not the case.

Thanks.
