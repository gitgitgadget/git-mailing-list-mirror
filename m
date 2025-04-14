Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE0BF1A9B28
	for <git@vger.kernel.org>; Mon, 14 Apr 2025 21:47:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744667257; cv=none; b=sQJBvsJ2rHQYTXrbVTgLA0ivDdj8GYS5k0z/b1G+M6AxZ/mUK3DBU0qGYgaZAWK44iV2aJrDqsWvt4I5rxq4299M0AkK4FolefRnU91P0cWMybnr7d0jEq6dZBS8WKb1VxWxVW4vh3v+waVe7CsP3Gw+OcF4JjLyxrnyNGnOagw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744667257; c=relaxed/simple;
	bh=o5yr1XpBKmTtLvdyDEmrhHzZK862YgXW0x6wYrkojpw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=k90SS9xAMHkUZ1ri7E4zn3jncvdS7z5Jt1wnpwxSHmjOXfJbHRCl8bOuQ9IpMMLA72EBqK4N1FC++2Uh2UvE2eiMB/5X9gfgW6jG5Bnm8oCJxOIwc+BHoZj1EKmsUgnHA4uyPV1AKKgJYFH6pRgIYGkVNbJJbM9iLKzBxcmz6SU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=LBfkyllD; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Iglpnrlt; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="LBfkyllD";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Iglpnrlt"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.phl.internal (Postfix) with ESMTP id 77AB3138053D;
	Mon, 14 Apr 2025 17:47:34 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 14 Apr 2025 17:47:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1744667254;
	 x=1744753654; bh=bDYpBSoqeBPLAPfmbnsOk5642ia3nLAPMERy5dwSnBw=; b=
	LBfkyllDttR5tfApUIhyHN4PQBxyqBFyd2kdhy2VRiD1JqlpBoPfup4iHhbsTgda
	JmcbrPvkofezSP7Tx6K7yAVYz52Ljr9ZfBM+3z+jKErKaoC4Kh3h9PabP7Q9MD82
	TE0A115/zpTUf6Qnq5duXQWSs6rpc+DrZaia+ArV54Soyxe1FFzbsAcdJfC+Pb6a
	9l8ilhzYSlBXJ200lfvFTAgytUY6O/LgUECN+nKEyzIdxZWgOiahxOQFAvB5y0LQ
	/7lr4tL4hFUO7uM+eabizrkd9x8VzB1y2Eu/47zOP2qDLIWbo2WDpX6g1mRaBaEs
	v9jZT0W6nCkz7jBVLMdy0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1744667254; x=
	1744753654; bh=bDYpBSoqeBPLAPfmbnsOk5642ia3nLAPMERy5dwSnBw=; b=I
	glpnrltv4sV9ZhOuvziAt7BcxnkOGPDK/cZSiqRk/bNj+f5a8SD5eWSUY5u3ot75
	BsjnL911SQmIEelDPlcXbS/72Yi7ulzs9Shs8HzhZV57UEbhCNKViTz8HgS4fVJc
	CapmcG/ZsxrD69Lf7pmM5x/kQdPFu5OSW/L2jqwGyp5/37dOllscPdo4UXaJZ5zC
	PRJCgeYJu+DHyDBSpSspDRxXkHYvv5SJ8WMb/mAV6RctBt5GNfopVPF+vzLnZAC4
	0wQAM0KaO/uZ+hUcDL1ygpr8t3jSiYMyXOp3Zai8oKOMw9HE7QGdooJ/gK8M9Ii3
	WfZURz3pbr6/1Ukx610dA==
X-ME-Sender: <xms:doL9Zx5oRDA7rQJ1_FQcoPtS8bbQU46zRmFDSTjzYXEeHliSFiPqFQ>
    <xme:doL9Z-5kSUo2tRRhZwLOCpwkf7W2g_vcWKvKgi_TWgqFpJlewv-wol4Zlm1d-RQWe
    wgnkkPkUdclyQkO9A>
X-ME-Received: <xmr:doL9Z4cltvg9WCGIQmICCw1hUetdDZvfztoDcygvhQbtdWrvv1TzPMmV56KiwYNq49Kar65eN_hXJ2rFKD48pRreWaLt1CsF6q2k>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvvdduieejucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgfgsehtkeertddt
    reejnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpoh
    gsohigrdgtohhmqeenucggtffrrghtthgvrhhnpedtffdvteegvddtkeetfeevueevlefg
    keefheeigfehveehvdekheelveevfedtheenucevlhhushhtvghrufhiiigvpedtnecurf
    grrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggp
    rhgtphhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhith
    hgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgv
    rhhnvghlrdhorhhgpdhrtghpthhtohepmhgrrhhtihhnrdgrghhrvghnsehgmhgrihhlrd
    gtohhmpdhrtghpthhtohepjhhnrdgrvhhilhgrsehfrhgvvgdrfhhrpdhrtghpthhtohep
    ghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:doL9Z6KwnHqcdOF6fzkSvrDiuK5OsAC_4Itg3z05LuIPqZqvqxf8dw>
    <xmx:doL9Z1KFBIkyU7iSlyyEUrhz4K7OtDm1yVHqpRwrY02xlvmLKHWH0Q>
    <xmx:doL9ZzwMM-uOvidOi_DESVMrzd9VTHOGBFA71-I4cPu1owpnlaOaJw>
    <xmx:doL9ZxKvp8Om4Y254559PM1E019gFYN95B4aJKOqWXh8KIkFKPnDZA>
    <xmx:doL9ZwwGNmVVLbb--ABB4KLasrSWLeIiYFh7_L5GnOTGtI0npEN8zm0J>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 14 Apr 2025 17:47:33 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Jean-No=C3=ABl_Avila_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Martin =?utf-8?Q?=C3=85gren?=
 <martin.agren@gmail.com>,  =?utf-8?Q?Jean-No=C3=ABl?=
 Avila <jn.avila@free.fr>
Subject: Re: [PATCH v2 0/7] doc: convert git-reset, git-rm and git-mv to new
 documentation format
In-Reply-To: <pull.1896.v2.git.1744460450.gitgitgadget@gmail.com>
 (=?utf-8?Q?=22Jean-No=C3=ABl?=
	Avila via GitGitGadget"'s message of "Sat, 12 Apr 2025 12:20:43
	+0000")
References: <pull.1896.git.1743354964.gitgitgadget@gmail.com>
	<pull.1896.v2.git.1744460450.gitgitgadget@gmail.com>
Date: Mon, 14 Apr 2025 14:47:32 -0700
Message-ID: <xmqqbjsypg97.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Jean-Noël Avila via GitGitGadget" <gitgitgadget@gmail.com> writes:

> doc: convert git-reset, git-rm and git-mv to new documentation format
>
> change since V1:
>
>  * fix remarks from reviewers
>  * stack the commit fixing the handling of three-dot notation
>
> Jean-Noël Avila (7):
>   doc: convert git-reset to new documentation format
>   doc: fix synopsis analysis logic
>   doc: convert git-rm to new documentation format
>   doc: move synopsis git-mv commands in the synopsis section
>   doc: convert git-mv to new documentation format

It was very obvious that the updates for the above relative to the
previous iteration are all good ones.

>   doc: fix asciidoctor synopsis processing of triple-dots

I'll need to look at this a bit carefully, as regexp over
<mark><up><language><input> tend to become pure gibberish ;-)

>   doc: add markup for characters in Guidelines

Looking good.

Will queue.  Thanks.
