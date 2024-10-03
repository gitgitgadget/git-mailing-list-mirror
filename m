Received: from fout-a3-smtp.messagingengine.com (fout-a3-smtp.messagingengine.com [103.168.172.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39D8416C453
	for <git@vger.kernel.org>; Thu,  3 Oct 2024 16:26:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727972788; cv=none; b=YXa0kcdCX11dnCVaDkG9zKyCiUUVcIyJ8M5H0p3loiFDdtXp7O1EuzkhFSRlPSmAboPQ0n/uuz4UBIBPXX6mKHTG2WmYfkowZXx9YIRa06x37me5OfvBVWnsr4Uzcig20Xn1YiTyLI2ZeTD3B6FZS14VUAM3Ae1Swh0Kq4S8yQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727972788; c=relaxed/simple;
	bh=80VZPXgaNC/FdwWTHcdYhP0ttCXWP0pL03SASvoxRXA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BOMB7HBsGQzBhwXpdemBA1ksmjUWI0YlvBQr/T5IOJqMjpWU7ybjA912d8/c7ZsZuAJ8jKv7hLUXUkq4zxkaH8/+RiKV8c+b+BiuoK4MLf64HvgEu5YrWDlClVbx2DATZzbDeT3QpSz9LgH7be4nry0yBVQV7G1gazeHsx8GPT8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=mk+nSL8V; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mJcmpm9Y; arc=none smtp.client-ip=103.168.172.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="mk+nSL8V";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mJcmpm9Y"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 61F2613801B0;
	Thu,  3 Oct 2024 12:26:25 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Thu, 03 Oct 2024 12:26:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727972785; x=1728059185; bh=N9UVYWYPzN
	ys8drHJ3fChMgmmVL9Eketp6OnUkxSvFk=; b=mk+nSL8VtzCW1iZ71snvbi92jI
	PvA0JW8N4unGqoWze48HlsF9odoOcdhqoC9UKj791AH2eynKDWEh2GJC2BXumZHg
	+oiJV1Q0OZE2+wj4U989qgqroOzq5pDUMirDwCxFuic3ZDRvG45yQg9HcgqUI/Pd
	rfZ3NdsBSjpR4xsIuTmVdQ65mBprnW+k+F/mNKNQ72cLCkHu0SibpUBMwiK+dDJJ
	8OHv3YDUqjnrzZ9nH92kcljguYDD9T161e5CV6rodEwb4YfepC5CKF9lFny77Ce2
	b/38ZJsO8cnSAhGEG1/vPQ+0axulUm1Y9PWk5QrTvf3wjqjngHh6St0WJVHw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727972785; x=1728059185; bh=N9UVYWYPzNys8drHJ3fChMgmmVL9
	Eketp6OnUkxSvFk=; b=mJcmpm9Yaur4sdPpCP8XNeOdl4dfzPSPcxy9VKW8FzKD
	A6e6V+699cMEPquL6ogBaSyjzU/uN3zouMYEbVXNFRJiv+rjN0//Me14pqXny4Fd
	mu0PMsGtA5e03G9/H0vT8cFQtHKwX5ym72C6zea54wHCyzSkguGcEAzsq3o32aok
	VdswiKNv0iLtVOxA798mc4N/8OP+dLR3EUBuQ6Rf82EmGq+VpEu1uJss1UUCBVfg
	xKcdVCHqRoD0nYVMkAvmMJIySBZIx0hZhL4rHRBQZPI7AGnWNLtgLZzdSGrxjGrZ
	bO7n0fhDo37W11m6canrTqEy35bTKGOBeBFIy/dQIg==
X-ME-Sender: <xms:scX-ZutFOGwqsHq2xxnojl_ytvAP4RVoD80ITxyxxS94mezBbkcsUg>
    <xme:scX-ZjcDYSm9MNTgsoZt7ZFf-PSFio-d02-1TBwQ-XgTK9MCrqyQMqUnxfDP9t5db
    4xAH-sTNpEsKYx89w>
X-ME-Received: <xmr:scX-ZpwgRmdhjfc7LsOkxf79At5HOunMabGbqTTWA9qFB8Ilgy-_bELaWDPE0Td8M5Ny05JyaX0eRImjcYOKQ_xSLBVgECN0KITHr5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvddvuddguddttdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehpvghffh
    esphgvfhhfrdhnvghtpdhrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhr
    tghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:scX-ZpN225bOGC45qhjlW0n1jqhpPrWeHvj6uDmhVENeMsEcpw_W-w>
    <xmx:scX-Zu9SwW1lopFOmbGnTCcwi1ZlGb70GG3lStxV-vSDe3akCPvBNA>
    <xmx:scX-ZhWmDaPnZIVmdk-dHyX_gnwtsaBdEzVn2lsAxIZaTG8pwK2JaQ>
    <xmx:scX-ZncmAHQokbQBjXQXb92LtzKD1p7MIXo8AeN9xpn0YjAC8JaB6Q>
    <xmx:scX-Zuz7vmShgpZ-K6jqFYH8D8c2IsmrCrPIL-VDtHuMgAmiXoQdfJNs>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 3 Oct 2024 12:26:24 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Jeff King via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Jeff King <peff@peff.net>,  Derrick
 Stolee <stolee@gmail.com>
Subject: Re: [PATCH v2 3/3] diff: modify output_prefix function pointer
In-Reply-To: <e1d825ad212d91505eee9d911abbd3ba6bc170b1.1727956724.git.gitgitgadget@gmail.com>
	(Jeff King via GitGitGadget's message of "Thu, 03 Oct 2024 11:58:44
	+0000")
References: <pull.1806.git.1727885224966.gitgitgadget@gmail.com>
	<pull.1806.v2.git.1727956724.gitgitgadget@gmail.com>
	<e1d825ad212d91505eee9d911abbd3ba6bc170b1.1727956724.git.gitgitgadget@gmail.com>
Date: Thu, 03 Oct 2024 09:26:23 -0700
Message-ID: <xmqqsetdi24w.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Jeff King via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Jeff King <peff@peff.net>
>
> The uses of the output_prefix function pointer in the diff_options
> struct is currently difficult to work with by returning a pointer to a
> strbuf. There is only one use that cares about the length of the string,
> which appears to be the only justification of the return type.
>
> We already noticed confusing memory issues around this return type, so
> use a const char * return type to make it clear that the caller does not
> own this string buffer.
>
> Signed-off-by: Jeff King <peff@peff.net>
> Signed-off-by: Derrick Stolee <stolee@gmail.com>
> ---
>  diff-lib.c   | 4 ++--
>  diff.c       | 8 +++-----
>  diff.h       | 2 +-
>  graph.c      | 4 ++--
>  log-tree.c   | 4 ++--
>  range-diff.c | 4 ++--
>  6 files changed, 12 insertions(+), 14 deletions(-)

Very nice.

>  			if (opt->diffopt.output_prefix) {
> -				struct strbuf *msg = NULL;
> +				const char *msg;
>  				msg = opt->diffopt.output_prefix(&opt->diffopt,
>  					opt->diffopt.output_prefix_data);
> -				fwrite(msg->buf, msg->len, 1, opt->diffopt.file);
> +				fwrite(msg, strlen(msg), 1, opt->diffopt.file);
>  			}

OK.  We are not relying on the strbuf being able to have embedded
NUL in the buffer, and this looks very sensible.

Thanks.
