Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B39854D8DA7
	for <git@vger.kernel.org>; Tue,  3 Mar 2026 16:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772554922; cv=none; b=VxtL8798MP3joa8bGoqoKgVuA7IMBVUwRhrUawLRDd8NiOsCGNaSC0EXvr1iKETTt2uDSymQ5bi3hgKtz4oXtx5c+T1JptgspCr8AqjtEZInsLg9/0hpugfSM3cq5+0hCH20FCTrr+2wyki75PmNjo/GuBBSjavo/pFDOlsLDjY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772554922; c=relaxed/simple;
	bh=5elSO2wSLculfbZCcED42Y3AgQTU56mxd+cmXvLtx8c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=MFP8UFBxebBh5Kod1toPLZml+5YCKpKVc3zNmj8akyqf8YnmJiwDlqU6p5kTxDu4OmDlA1PkrtxUwd9X42eO60QylQ7AFN/SPMNa9qXFn4UAxGAPCtgtJqF0M959mkqxEptMMGPpAjCFi9agpdJMAN6YT4Om+c3Em95qzCJrKtk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VrZheSQu; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=nvvr5cDQ; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VrZheSQu";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="nvvr5cDQ"
Received: from phl-compute-08.internal (phl-compute-08.internal [10.202.2.48])
	by mailfout.phl.internal (Postfix) with ESMTP id B71E9EC055A;
	Tue,  3 Mar 2026 11:21:56 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-08.internal (MEProxy); Tue, 03 Mar 2026 11:21:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772554916; x=1772641316; bh=LRmxflN/jS
	PTavaeOA5HK/GskPZzcf5inf/QclX8xr8=; b=VrZheSQu1Iz5FaUTDINMtcvDAt
	tCsUhEfLEXRQFEmUu9BVtVTs4ou+Uc8r40KbExhbDykBG1N5qAQSNigZPXMaklBC
	FsnyRSPm57/JbOwGsUVMfcsCCdg3AYrLw0fDsPTja/Ukpc3VJCOq0KPaZR8014LT
	C6HvPuGEcNz9sWMn6JgWGs2lJaaHbG9PwGUjH027PTN9m6v+/dff7IvN+BMZ61ST
	rw93vmMgTlsBEG5f1DX/U6lw2h+vG08d4Y2NWKcvXKAeb7q4kcJJFYCsFy5a05rU
	QyDoQAg9cAkegNnZySHYsKaxEHHkO5q/4Mx3v2fnXDRkEQu48kHOIwNbPokA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772554916; x=1772641316; bh=LRmxflN/jSPTavaeOA5HK/GskPZzcf5inf/
	QclX8xr8=; b=nvvr5cDQmwosjrUxX4NjJcKAuFzFuH/pkpUVzB73Pwi6lIUAdil
	6/pp04Kte2vhGOHgd9TF2EG2oiqxhzZrVFP+qO5nW1ZhvgwdnsRuteJF5vjmB9K1
	qI6KPTViKtZuygQh47f1qVZzuD9nmmpublgDSROuyK4UKnYag9l/pO82VWYDXKke
	75wv7JejEItX/XDjCYtesX7YCxyRXGM4AGzJRcmrJC8721OhjJE3YvfeL5Gezije
	VD6jO2Ixnu+klPMZOLW7P4IKSSwnJmRb7vn9fV0Ae98Dxwr2SOKWQ8uKAjofDD5D
	xdVs/VRx+yBTK6TcoH4MPceYeQx8NPiwDkA==
X-ME-Sender: <xms:pAqnabm-6Qgmjw2fxvRNNSz45dZ1o_P9FLJbYgwfp8lSzcM_2lPfEQ>
    <xme:pAqnaWRiPr9YcrKwwe8a1WBpYYa0uIony8pF6gVcnhoJAdSmIEepaPTuEF_w8Itqz
    GtfdDF93AfwDVMkfuQMpnwICaVQzzkwpSl31mIeTCF7ai6CiYWO>
X-ME-Received: <xmr:pAqnafDEoxrbwJJEDhqxiZJ-P6UlyZ7OHzxytAKb8rKI-yXU7UhWpXVZKmXO5uGkjXcR5QxvjYljRQKZOarH0VwhwzfJq6yNDg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddviedutdegucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepfedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepjhgrhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtd
    dtheesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghl
    rdhorhhgpdhrtghpthhtohepghhithhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:pAqnadT9tBCNqDz7Ke7ZCNiR8t_L-XrqWBY9eRMgW_TbVi2Kbttgjg>
    <xmx:pAqnadoG7vriO7WzPHoW-FPrVoTfI8EwLhP6q7u9J-ijGyrui2AORQ>
    <xmx:pAqnafxHChmU-59XoCVBNVE-zfhIF_AgIWmuoBk3M55u3mIxgw5hEQ>
    <xmx:pAqnaSIYMDhB052Dui-aWFiB7uHc1dYCqjNbu3y56s-1qmiyUICI3w>
    <xmx:pAqnaaRxdYHu1vFnOkloqS9YeIUo_rjytGDT-6mEH3UAsQWJf8retRnb>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 3 Mar 2026 11:21:56 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 2/3] path: use the right datatype
In-Reply-To: <20260302142138.712273-3-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Mon, 2 Mar 2026 19:51:37 +0530")
References: <20260302142138.712273-1-jayatheerthkulkarni2005@gmail.com>
	<20260302142138.712273-3-jayatheerthkulkarni2005@gmail.com>
Date: Tue, 03 Mar 2026 08:21:54 -0800
Message-ID: <xmqq4imwg9y5.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

> The strlen() function returns a size_t
> Storing this in a standard signed int is a bad practice
> that invites overflow vulnerabilities if paths get absurdly long.
>
> Signed-off-by: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
> ---
>  path.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/path.c b/path.c
> index f613d8bbd1..56be5e1726 100644
> --- a/path.c
> +++ b/path.c
> @@ -58,7 +58,7 @@ static void strbuf_cleanup_path(struct strbuf *sb)
>  
>  static int dir_prefix(const char *buf, const char *dir)
>  {
> -	int len = strlen(dir);
> +	size_t len = strlen(dir);
>  	return !strncmp(buf, dir, len) &&
>  		(is_dir_sep(buf[len]) || buf[len] == '\0');
>  }

Obviously correct.

We also could tell it to return "bool" without disrupting much else,
as this is a file-scope static function that are only used inside
"if (...)" conditions without its return value stored in any
variable, if we are interested in type kosherness.

I have to wonder if it is easier to read if we used our standard
helper functions, e.g.,

        const char *tail;

        return (skip_prefix(buf, dir, &tail) &&
		(!*tail || is_dir_sep(*tail)));

but probably not.

Thanks.
