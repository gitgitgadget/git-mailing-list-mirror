Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A54A13A3F7
	for <git@vger.kernel.org>; Tue, 29 Apr 2025 23:08:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745968123; cv=none; b=Z9Ms3TpsP6/N5p9fXSb5M1kK9tOvViVjZUaUkth2uUVKe+8lgm5XMWAJim6bXp5clJHNdKISRb42rCNBsOOgK+XNvTlVO9LFkWGXImCN4JJTufLKdZs2eydxeKLueesr/rZ7QpZkN3tscerdHsXKS/gf4D/k07GrvRvOvWYTIYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745968123; c=relaxed/simple;
	bh=Abo2FelPEeEew2XcXKOV138YQd2K3OUjG2N6FFtEc6A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=HePtmbp+5WmHwxBaXdH/aDDpykYiu5bcsPB5p/FRkpNmRMgmcEzChNYgVFFk+t2VnbF7RBtj7kYtSEzVldD8bvGqUbHAkvR9KykX+yLYXF+kZJSh3eZhRrONBO5u9pi8ZAMGR9K7r58RuZk7jr8Ky7DzkytBnxnKyxDegpoKOcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=MgghwjJZ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tmGjwRQO; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="MgghwjJZ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tmGjwRQO"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 20F1A1380876;
	Tue, 29 Apr 2025 19:08:39 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 29 Apr 2025 19:08:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1745968119; x=1746054519; bh=pH8GACVfsm
	cWYDvSowrZsibBnF2aEgElLxMoKaHuckc=; b=MgghwjJZFrlaeHjbdkZmVM3lnH
	SBMPmJ0RrarHge0R94t71NqFRkRdEWYGM0qAgdVfuVVS8TImZp9D2LZLX6ggUz5Q
	JolEGFCxzNBv8YqXdX5/gnJIbeJbjqHeWUFQy8USOZL6rhhWPUBv+RKPIgN50srQ
	4u3JDj553M9qloSB3W7/B78f6vANFjuMpmBiixIdmKw/KRXCTwK5KSl8I8DlUULz
	wD417+jVWUnb7XZACKWR+d5O0Vh05W6U59kZNu8OJ4wovd1jnodBlZf1o5tFBuvy
	DFNc6LM06gDR/KnU8BKFQkSBYUSVneGNeEd0zx7Ko/opBabpZQrfMnoihe1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1745968119; x=1746054519; bh=pH8GACVfsmcWYDvSowrZsibBnF2aEgElLxM
	oKaHuckc=; b=tmGjwRQO9s3kzZo/xLmudWbri4qbXiZ758panxR3tJEr3kr75PO
	gP/tKcMOgcLSjEwe9aRi5PKYTueYEbBwbVZgU6qLoMlJRCPYUjWhNIrsNTuxdCpz
	787lDRj1LBBseRXGYbnNO03yzkC8iGqnxHp1GmXjFRxZDJeDkNleK+3Z0PYm0L0g
	jy7id+uZD/eNDeE0b9Wmmvl73LFAXvoVjyNovgWdKAbIWjzrsUqh3j4oHXwOtsPG
	DEACDbq9/TxM0+UuYIa7xsrWJ/QuXAumhxO+00ZaMNv6cVX5uCwRdQC8II8DbeGk
	pZz/P24ToPHOaZYrxPRGMwm0V0NmGpMtEqg==
X-ME-Sender: <xms:9lsRaJ3ZSkQ91B6dX1oQOP5CKrfVo_3-MERy3jboKFmCdZ56Ywbs1g>
    <xme:9lsRaAHSE14OwNccIERNEVh9nnmpXlmhXk10gOcb1yJxB2tufKmEAboaTwnJV3KGK
    VqEwYmtHTLOEdebwg>
X-ME-Received: <xmr:9lsRaJ6oaUtyPAbuRf1aW0JlLf3QfgknRUVIbIy6DBhIShKWuPv881Cr396gXq5qay8IC_xmBqRL6KvAe_OVDGWeJ9ezvaglnVH0>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvieehuddtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepueffveeifffhuddufeehvdelgfdtgeff
    teevueefieekffetfeefuefgueeufeefnecuffhomhgrihhnpehofhhfihgtvgefieehrd
    gtohhmpdhouhhtlhhoohhkrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghr
    rghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtg
    hpthhtohepuddupdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgrghrghgrughi
    thihrgdtkeeslhhivhgvrdgtohhmpdhrtghpthhtohepjhhulhhirghnsehsfigrghgvmh
    grkhgvrhhsrdhorhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrugesghhmrghilhdrtghomhdprh
    gtphhtthhopehsrghnuggrlhhssegtrhhushhthihtohhothhhphgrshhtvgdrnhgvthdp
    rhgtphhtthhopeifihgrghhnvdeffeesohhuthhlohhokhdrtghomhdprhgtphhtthhope
    hgrhgvghhkhheslhhinhhugihfohhunhgurghtihhonhdrohhrghdprhgtphhtthhopegv
    hhhuvghlshesghhmrghilhdrtghomhdprhgtphhtthhopehsuhhnshhhihhnvgesshhunh
    hshhhinhgvtghordgtohhm
X-ME-Proxy: <xmx:9lsRaG0rBsTO9v37mUKhYOCZVvyXBeT9uHUxksVOH1pzPQWY9hoSnw>
    <xmx:9lsRaMEvZMz5ILuV7hu4kf7WXrtFmIfUyKlnvzZTQJYV6mfRwoqOgQ>
    <xmx:9lsRaH9XYu6YWBKXzlUSpg6UtUJpGhg31Rf87GSgQ0wdGq1MHXa1ZA>
    <xmx:9lsRaJnsLBi5vtXzob2zqQHwIp1G7gSaDXsAqrVNZdC6NpzGF67YnQ>
    <xmx:91sRaEuRY0BIrcHIcKF_jz0enlQBqzTiYjQ9kaqjnGVcdlVGxxvl-RvZ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 29 Apr 2025 19:08:38 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Aditya Garg <gargaditya08@live.com>
Cc: Julian Swagemakers <julian@swagemakers.org>,  git@vger.kernel.org,  M
 Hickford <mirth.hickford@gmail.com>,  sandals@crustytoothpaste.net,
  Shengyu Qu <wiagn233@outlook.com>,  Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>,  Erik Huelsmann <ehuels@gmail.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,  Yao Zi <ziyao@disroot.org>
Subject: Re: [PATCH v4] send-email: add --[no-]outlook-id-fix option
In-Reply-To: <PN3PR01MB9597AD101D75F316C722E84CB8802@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	(Aditya Garg's message of "Tue, 29 Apr 2025 16:37:09 +0000")
References: <PN3PR01MB9597DA8661D1AFDF4C927A11B8812@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
	<PN3PR01MB9597AD101D75F316C722E84CB8802@PN3PR01MB9597.INDPRD01.PROD.OUTLOOK.COM>
Date: Tue, 29 Apr 2025 16:08:36 -0700
Message-ID: <xmqq5xim4lcb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Aditya Garg <gargaditya08@live.com> writes:

> Add an option to allow users to specifically enable or disable
> retrieving the Message-ID from the Outlook SMTP server. This can be used
> for other hosts mimicking the behaviour of Outlook, or for users who set
> a custom domain to be a CNAME for the Outlook SMTP server.
>
> While at it, lets also add missing * in description of --no-smtp-auth.
>
> Helped-by: Junio C Hamano <gitster@pobox.com>
> Signed-off-by: Aditya Garg <gargaditya08@live.com>
> ---
> v2: Replace tab with spaces in "outlookidtweak" => \$outlook_id_tweak,
> v3: Rename to --[no-]outlook-id-fix and make it bool. Also add missing
>     * in description of --no-smtp-auth.
> v4: Improve documentation and the log message. Also, have the final
>     "return $outlook_id_fix;" on its own line.
>
>  Documentation/git-send-email.adoc | 13 +++++++++++++
>  git-send-email.perl               | 14 ++++++++++++--
>  2 files changed, 25 insertions(+), 2 deletions(-)
>
> diff --git a/Documentation/git-send-email.adoc b/Documentation/git-send-email.adoc
> index 7f223db42d..7ccca16296 100644
> --- a/Documentation/git-send-email.adoc
> +++ b/Documentation/git-send-email.adoc
> @@ -115,6 +115,19 @@ illustration below where `[PATCH v2 0/3]` is in reply to `[PATCH 0/2]`:
>  Only necessary if --compose is also set.  If --compose
>  is not set, this will be prompted for.
>  
> +--[no-]outlook-id-fix::
> +	Microsoft Outlook SMTP servers discard the Message-ID sent via email and
> +	assign a new random Message-ID, thus breaking threads.
> +
> +	With `--outlook-id-fix`, 'git send-email' uses a mechanism specific to
> +	Outlook servers to learn the Message-ID the server assigned to fix the
> +	threading. Use it only when you know that the server reports the
> +	rewritten Message-ID the same way as Outlook servers do.
> +
> +	Without this option specified, the fix is done by default when talking
> +	to 'smtp.office365.com' or 'smtp-mail.outlook.com'. Use
> +	`--no-outlook-id-fix` to disable even when talking to these two servers.

You'd need the usual "a line with only + on it as the paragraph
separator, with subsequent paragraphs dedented" mark-up.  I'll tweak
this part on my end.
