Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F122CBA50
	for <git@vger.kernel.org>; Tue, 25 Mar 2025 19:34:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742931271; cv=none; b=UVXbEWs/UcjG1XcNIDdZNegsvJafHht4sbdUgINPXTT7j0AD7NEXvMBhY1lM2V/DoL9MV/CIidsGY0y43bTp3lC5Uw7AyxTn/rMVCYorgzDM+R7XKrPgFPn2+Lsn/ZtqTls19oqGvZOCBnszSU80e6sgYOQWF9dZt2AukE4cN3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742931271; c=relaxed/simple;
	bh=AEAJJaNXFk2AFpoZrMHxW7tjve2jQ1D8cWhmohCpxyc=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=avvHNMxQcOv1D048SYC85XbQVL/TN2uwMHY0ubB8x47jSEKok7/bBz4IMfiDLYAUixp1oE4EoJtcmXf2rw85qQ8qj1zgJJcVqGL4UBuBvn4bmpRU3hP7/MdYTj2mzsQBUns77FUNaxgqA5MV1+IUciC+LqTRmF9ywu65KVIdB8Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Oj+4xbrv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Pug6gv4D; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Oj+4xbrv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Pug6gv4D"
Received: from phl-compute-08.internal (phl-compute-08.phl.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id E3E2B13833DF;
	Tue, 25 Mar 2025 15:34:27 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-08.internal (MEProxy); Tue, 25 Mar 2025 15:34:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1742931267; x=1743017667; bh=TEUeMvfKWz
	vla7VO8ydQswkitJ5SwwV+zzB7r5PIxo0=; b=Oj+4xbrveBwufRtACAuXba3WwT
	1hzdlQoQxTbORmeQMsq5qMp75ZVBXIhualppTRHZY517rQiz98C/AbIQlJrxMY5g
	tB64856DiOD2mY0shnuZUM3YyqRoANDVVkpbn2cxJpASCgD/k6+P+pMxCtJGvauR
	8mZFzJUuilv/SM1dQt7Td0AYnTH/qlmsCSCemTT4AbqEBFN1qi3o2O8/T4WGK3pz
	Y9vwiUCkT8Y9tVEoyKHjgPcFLOnKxxg6t16YlsXXk+emxbfDFG4dp0y4q+QG8ylj
	KV3kodQpF3kShEXFW90iS3l/fk4kyb2AYgj3hZe77niseGC/6O+F+MBl/zdQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1742931267; x=1743017667; bh=TEUeMvfKWzvla7VO8ydQswkitJ5SwwV+zzB
	7r5PIxo0=; b=Pug6gv4Dc1VAzS60qDpdNTAv9ehGQy7G6A028QR0fUNN+s41gP2
	Vk6mEnxL7mtRWbDt/KO4z+c30Da+YfaSN2x51baqXj0+m+J6cYpnWESMDn0jFLYP
	zVong3xzCKZ9TrIadh4Sa6NySOS6VeC8avbPOQ9oFQZdDLVtTx1iG0DNkbbVx+Ue
	agd9EMJvOb7spZ9WdDJvc2mn5YF70wJrhrtMzR9stnyLs6e9nsbInKHk46WQipji
	PMaHQ7WDGW5z9mFXsBoXP1fGkMJehM7gNUfQuyUuIXqfLx0+M7HMVicVpQRtHIvQ
	y+PFVZUBXvOZouJ6kgck1cpkyrMoDkrPpHQ==
X-ME-Sender: <xms:QwXjZ6gHVorrfRg59Z2YQroKLV-wSo8w3Q1oWjoGZP7BSWUr1TX4pA>
    <xme:QwXjZ7BOWDiKAwc6XL-IajYYZlxabPa835Fb67hSo_8ia7XPLga_pm9yaBTwfqbLM
    6BWxD67diYDeJWRIg>
X-ME-Received: <xmr:QwXjZyH563XeeXdqkR09uGqQLahaUBQ0F-3lK2kKwMC2h9dWEbJBD4StKWMnASgGjzsoY79B_J86NaDqm2mQ29ytSu4pUZ-J8AA0RYk>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduieefhedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhephfeftefggedugeeltdejveefffetgffg
    teevvdeugeffheettdegvdeigeehheegnecuffhomhgrihhnpegtphhprhgvfhgvrhgvnh
    gtvgdrtghomhdpghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepgedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihht
    ghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvg
    hrnhgvlhdrohhrghdprhgtphhtthhopehjohhhrghnnhgvshdrshgthhhinhguvghlihhn
    sehgmhigrdguvgdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:QwXjZzQlnMSFh-ZP8ljnuDWCF3KMmzBvwqkr9t_F60_WLU78w-9hWg>
    <xmx:QwXjZ3xTHKCwKpXyX0l8eAFcOpHhg2vkXIeerpIgQ65QsyqII3xPEQ>
    <xmx:QwXjZx6QR54fg9A7K_hycpMtAWdasbNhx_XIjZXX7xOowscj9xuYwA>
    <xmx:QwXjZ0ziOAKEeD5az0BpGrGpnLaUWGNoE4GgZ_C17TPHVWyY8awgng>
    <xmx:QwXjZ5vuz9uDhByoCBg8pORneh_EYOLZmhvxM4OoUTCAt2KEzvVFpfLi>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 25 Mar 2025 15:34:27 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH 0/2] Avoid the comma operator
In-Reply-To: <pull.1889.git.1742889711.gitgitgadget@gmail.com> (Johannes
	Schindelin via GitGitGadget's message of "Tue, 25 Mar 2025 08:01:48
	+0000")
References: <pull.1889.git.1742889711.gitgitgadget@gmail.com>
Date: Tue, 25 Mar 2025 12:34:25 -0700
Message-ID: <xmqqh63gnbum.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> The comma operator
> [https://en.cppreference.com/w/c/language/operator_other#Comma_operator] is
> rarely used in C anymore, and typically indicates a typo. Just like in these
> instances, where a semicolon was meant to be used, as there is no need to
> discard the first statement's result here.
>
> Johannes Schindelin (2):
>   remote-curl: avoid using the comma operator unnecessarily
>   rebase: avoid using the comma operator unnecessarily

Well spotted.

These two looked somehow surprisingly bad.

If I hadn't known better, I may have spent quite some time wondering
if these are some ways to hide an unexpected behaviour behind the
differences between a comma and a semicolon for nefarious purposes.

Will queue.  Thanks.

>
>  builtin/rebase.c | 2 +-
>  remote-curl.c    | 2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
>
>
> base-commit: 683c54c999c301c2cd6f715c411407c413b1d84e
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1889%2Fdscho%2Fcomma-operator-v1
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1889/dscho/comma-operator-v1
> Pull-Request: https://github.com/gitgitgadget/git/pull/1889
