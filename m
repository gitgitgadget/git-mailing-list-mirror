Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05DC62D73B5
	for <git@vger.kernel.org>; Tue, 14 Apr 2026 17:06:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776186402; cv=none; b=VbXlJXxmUrzibPhefq2si0B8AnZhcZxKcHQD2clRXYpf5jMK8B/J4jJb8caXJd2XwEsLZeYCNiyFgK+dzKFsmY7LZW8vou9ACzYhya8UsU8GcTzswqPtk+huK2/lSTeJ3l5ppQPSH5XZN7kOg0VhFtZ1GM0zGevbbZPQrHiedG0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776186402; c=relaxed/simple;
	bh=etgp3DjYbo/+mNQj5cBkMrq16N85eUZVZTpILIMDn+M=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VwbL9KA3a3WR/WLRwfCwZhaN7TgqTc6YmWiP+VYNvlSlsJWfRhqttYZ/b6ZrdK9pGsHXx4cm19/alygyfrDokaagjKO9yy3Smcgiq+16iFbjFuiFbF2StYlZVuAzkQYeASIhzH+5h12fQsD3iRVPAzrFwHBW0dUemd0De4iQpfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=tYx3lZnv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rAGmE6P9; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="tYx3lZnv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rAGmE6P9"
Received: from phl-compute-03.internal (phl-compute-03.internal [10.202.2.43])
	by mailfout.stl.internal (Postfix) with ESMTP id 16E8C1D001C0;
	Tue, 14 Apr 2026 13:06:40 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 14 Apr 2026 13:06:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1776186399; x=1776272799; bh=ZgA4Bj/FCc
	wLFtI9SN/dZhf45Wx3ArY1YQAJhXLtXDk=; b=tYx3lZnvIFael1webbv3jqNh9K
	f+xJoo+ZM1OWjCTv5mu7B0LyODrNyYMQmECPK1KjWvMY57E5R/PqlFRY+NoiCDhh
	J1OSyx1lwm++C6f4/bcwLVunp5eQujkMmfzNgZHzWy7uzSZ/BHdTNk9Z82MoA1p0
	itjeIC3v9+8xDnPUtqKD4ybQVQxV4h+yWyOv3Yn1QkAPj8oSp/8wpKrveBU2kpus
	LVr27/bP9k46njevDPp0/CwxzE12YeYrbjkYscOm4MO7Qiu78kBRzXgl0sWH2Ec5
	R2HnhJthWS3QvWwTm0yhcqhrrdbROpcALMwkN3ppajQWTzLAMUpXik6RLDGQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1776186399; x=1776272799; bh=ZgA4Bj/FCcwLFtI9SN/dZhf45Wx3ArY1YQA
	JhXLtXDk=; b=rAGmE6P9A3vLcI+so5EomMqa/tF58PAuUQL2Rf/AIVqqDjP3872
	QfhY7OWnwZXw8LUH0cTtiNBx5GXundNHuH1em4yOk6hRL+9/vJOkz+nWbv/CbfeF
	fe4HVX9moRyDJTor6BVB6bxA8pVn4FwUin5txGAhlkOqOH6PPzm3PVRPmMY3B0Vm
	6Cl6x/5k4vkx2mpVp8GfM6ORqYOei6VZO9c2xZ+6neQqr4Dc7MQpMfWzsmOQNjMC
	NddNQT4N5a7p94SYpmgd2xjo9OWCvuQIQ0oo0vWEHqPPvI6zFVBf7KHPjMtKYMWL
	TMyt75XUz5+5xhgnTdsXoRi5CYbkH4s/1YQ==
X-ME-Sender: <xms:H3TeaSD4gExYQ7d4GFiymdrCch_YOhqqM-xMowwUswJrbKKgtkM9XQ>
    <xme:H3TeaZFMImdhJ_7JHVgojW5xx1AH7KCIRZQjURfgARSw2I-ZPn4gF2yPgVD0yjQ8K
    _yyQ1l5EuADMooPbqeQpWjgjKeTTALrbrbB30USaDpNCI45ekM81g>
X-ME-Received: <xmr:H3TeaaAYt4FRDn3y9vi_nh51KOu-Zy4BXJIN2eSEBPzzsKSVovcUsqGZQD7mYU0Yp1lOtfkkoDCJ5RP4lWH7xgitcUhLiRfILw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgdegudejvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdfotddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpefgteejgeduveeuteeiudfhhfeguddtjefhjedvffelteelhfdtveejueehudff
    ueenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdp
    nhgspghrtghpthhtohepuddtpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehphh
    hilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhg
    ihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopeihtghhihhnrdhgihhtsehgmhgrihhlrdgt
    ohhmpdhrtghpthhtoheplhdrshdrrhesfigvsgdruggvpdhrtghpthhtohepphgvfhhfse
    hpvghffhdrnhgvthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtgho
    mhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhmrghilhdrtghomhdprhgtphhtth
    hopegviigvkhhivghlnhgvfihrvghnsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:H3TeaXk9Cl_GGgw84ZNqr-eUTf9PKTcKbGMRHwYfza0XEPYzoKTrGw>
    <xmx:H3TeaYO6QKBx1Kynu5ZXKuGzdr4G8WpIwRaWkDtfv9r6xDK7dWSidA>
    <xmx:H3TeaU-T58Y0DKXOxQ6iSVrcYS0no-ZZhLy1Fkz-44HZPki8pjJXkg>
    <xmx:H3TeaaEbh6GLxJns7x3OoINK_wnzwe9Mlbuv4UZRCpILrY1TDMcJzQ>
    <xmx:H3TeaWz1ZMf-G6V5X1hCJwOx7nu2Du3efnaTo_FaHifdKkMapGeAhm9T>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 14 Apr 2026 13:06:39 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Yee Cheng Chin <ychin.git@gmail.com>,  =?utf-8?Q?R?=
 =?utf-8?Q?en=C3=A9?= Scharfe
 <l.s.r@web.de>,  Jeff King <peff@peff.net>,  "D. Ben Knoble"
 <ben.knoble@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,  Ezekiel
 Newren <ezekielnewren@gmail.com>
Subject: Re: [PATCH v5 0/6] Xdiff cleanup part 3
In-Reply-To: <df244360-e9a9-44c0-946d-29288e6dd269@gmail.com> (Phillip Wood's
	message of "Tue, 14 Apr 2026 11:08:11 +0100")
References: <pull.2156.v4.git.git.1774890003.gitgitgadget@gmail.com>
	<pull.2156.v5.git.git.1775679988.gitgitgadget@gmail.com>
	<df244360-e9a9-44c0-946d-29288e6dd269@gmail.com>
Date: Tue, 14 Apr 2026 10:06:38 -0700
Message-ID: <xmqqeckhbhep.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Phillip Wood <phillip.wood123@gmail.com> writes:

> On 08/04/2026 21:26, Ezekiel Newren via GitGitGadget wrote:
>> Changes in v5:
>> 
>>   * drop commit "xdiff/xdl_cleanup_records: simplify INVESTIGATE handling for
>>     clarity".
>>   * add braces around the else clause
>> 
>> I didn't see a better way to rewrite how action is used so I reverted to
>> what it used to be.
>
> That's a shame, the diff below uses a local variable to avoid altering the
> arrays as suggested in [1]. The comments about the double evaluation of
> xdl_bogosort() in patch 4 [2,3] also seem to have been overlooked.

Thanks for keeping an eye on this topic.  Very much appreciated.

>
> Thanks
>
> Phillip
>
> [1] https://lore.kernel.org/git/87a54698-396d-4de8-bd9d-cd72f8d1e8df@gmail.com
> [2] https://lore.kernel.org/git/32c34d0d-9358-43e3-9d58-5999b3ffd6c2@gmail.com
> [3] https://lore.kernel.org/git/xmqqcy0oj2s1.fsf@gitster.g
>
> ---- 8< ----
> diff --git a/xdiff/xprepare.c b/xdiff/xprepare.c
> index 471d9567c9..9966b4715d 100644
> --- a/xdiff/xprepare.c
> +++ b/xdiff/xprepare.c
> @@ -329,24 +329,42 @@ static int xdl_cleanup_records(xdlclassifier_t *cf, xdfile_t *xdf1, xdfile_t *xd
>   	 */
>   	xdf1->nreff = 0;
>   	for (i = xdf1->dstart; i <= xdf1->dend; i++) {
> -		if (action1[i] == KEEP ||
> -		    (action1[i] == INVESTIGATE && !xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))) {
> +		uint8_t action = action1[i];
> +
> +		if (action == INVESTIGATE) {
> +			if (!xdl_clean_mmatch(action1, i, xdf1->dstart, xdf1->dend))
> +				action = KEEP;
> +			else
> +				action = DISCARD;
> +		}
> +
> +		if (action == KEEP) {
>   			xdf1->reference_index[xdf1->nreff++] = i;
> -			/* changed[i] remains false, i.e. keep */
> -		} else
> +			/* changed[i] remains false */
> +		} else if (action == DISCARD)
>   			xdf1->changed[i] = true;
> -			/* i.e. discard */
> +		else
> +			BUG("Illegal state for action1[i]");
>   	}
>
>   	xdf2->nreff = 0;
>   	for (i = xdf2->dstart; i <= xdf2->dend; i++) {
> -		if (action2[i] == KEEP ||
> -		    (action2[i] == INVESTIGATE && !xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))) {
> +		uint8_t action = action2[i];
> +
> +		if (action == INVESTIGATE) {
> +			if (!xdl_clean_mmatch(action2, i, xdf2->dstart, xdf2->dend))
> +				action = KEEP;
> +			else
> +				action = DISCARD;
> +		}
> +
> +		if (action == KEEP) {
>   			xdf2->reference_index[xdf2->nreff++] = i;
> -			/* changed[i] remains false, i.e. keep */
> -		} else
> +			/* changed[i] remains false */
> +		} else if (action == DISCARD)
>   			xdf2->changed[i] = true;
> -			/* i.e. discard */
> +		else
> +			BUG("Illegal state for action2[i]");
>   	}
>
>   cleanup:
