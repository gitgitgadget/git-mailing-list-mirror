Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48F5414885B
	for <git@vger.kernel.org>; Tue, 17 Dec 2024 20:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734468444; cv=none; b=uCS1jl1tgVY0ECvhNj8WPZBpDiXSIOOrb7J2S4WqkGl0hsymjMRKMb9AqtM6Y6UujKNCsFU3tHpNANuH3RBKO1fzRsgVyXrzETU0J7uDFQkCg9uyrzVmZPGQylDwthxwRfcGzKWI1dlJ3ijQ9TSL9eL5bqoenpP9L4Owhk5PIYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734468444; c=relaxed/simple;
	bh=Dq7ORsBT1sZXjCi7RbYfcPFtUaM5DeIzTwkP+Wi7ZEo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UWfjwjKSzWXUe8wxV3NGDqzh/hVoMQWeD5KNxILKYbiUmfj7TiEyihZcyv6zDUZnqoIn/Roc1YnkGiv1GKydlItlgx/IjvNvPN/HjHrJ9XzDvWln1Tyg3kCjB7FHSTJfUnmYVeDt/6rxR9HKOfxvMy/22u2VkOJbUUlUcsLV+a8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=pJulJADP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=ep4MZ4CY; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="pJulJADP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="ep4MZ4CY"
Received: from phl-compute-03.internal (phl-compute-03.phl.internal [10.202.2.43])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 5A6592540184;
	Tue, 17 Dec 2024 15:47:21 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-03.internal (MEProxy); Tue, 17 Dec 2024 15:47:21 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1734468441; x=1734554841; bh=Lex8xmq18X
	gPrOyTXjbXjCqoz4aXq0RPcYfj9c0YEr0=; b=pJulJADPVMe++to/dHWSH+jV/N
	Y2wZPFuvQK9SJcDwR3Wd0E8JfUJ9C46imI8dAKqktIPDEoI6zUy5UpYXvKLPFNJc
	7zVYOGx1DzCRcP5z8DGqNwFhz7phFT0K25H6ZWEWj7ogK8bJd1GkPSfeDEbPgEel
	YCWwjHdurVAH+u2y/pjkcoR4FcNxG0gKTZPqh2ByZ+m1piMiv7+KzKTvs7N7gCqX
	s6ekbGZUd6GOQGe7sTwYlA9e26crBISuNevFTAgmVkABeVSW84JemCjSwrpdBDwx
	rsSEt5bXBmkErSs1UEuY/2Aqd09sFZOv5Y3EsCKi+Emq4Vgk3dpWalmwqGOQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734468441; x=1734554841; bh=Lex8xmq18XgPrOyTXjbXjCqoz4aXq0RPcYf
	j9c0YEr0=; b=ep4MZ4CY+OS2TilwtOY0vnneqrhd3iUubIcqja48YLewTflnC0F
	yGdsXctlNNg10w9LTBdwHSpzcwjh4gK7Y8oP9ZT/lBsWIJEuudAR45GjlcgSu3H4
	L8pZTdpkQazhJdUbb49NrswSrhr/QyBRgc8+pRb3To6yPFGumkq3YqkjsIiL4AbO
	Ztl8Oe0eLnQk7durWe7nZr3zTSaBGvZjVrinQt5F/tH50v5TxUUZmwbKFc6G9Zxh
	8FFnq9nsZ/+g0Rqn1bio3K6T8C1RtvqX1dq5qZu5HcF+Ha4uAw+IFrG8WhOhDP9i
	xrd/XiYqh/x4IHp9GBJRWeg9iVi7Om/oNJw==
X-ME-Sender: <xms:WONhZ8rP4eqgy_jR4xZFK2Tw0HUk3I3KtpTar0xT5D0rOgxTjjWteg>
    <xme:WONhZyoRA-X7GD-5ybYsOAahnozfm_2m0WgJvr9s6eGVm1hW8IkmJckZK6o3JTBd_
    WJXDba8toRgVTwOlQ>
X-ME-Received: <xmr:WONhZxNj0nn6gJvjdAI9J9nAZz4zOHAlqFUEt9wQBLabnuugj4w2AmXmR-sza2fXb73s1eL4mzRQBW52xxLQpQLmrT9VOMfu5eLI8kE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleehgddugeefucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeufeej
    leeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrug
    hgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgv
    lhdrohhrghdprhgtphhtthhopehshhgvjhhirghluhhosehgmhgrihhlrdgtohhmpdhrtg
    hpthhtoheplhhouhhishifphhfsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:WeNhZz6t_vfSWZy9BivnM8XzRJPjzz7LMIl30PZCNesIFOK_f0BJUA>
    <xmx:WeNhZ747gRy1T5q7Aj2HJEKGVaOBZBb1YFC6XiW24ORT6zOYTh1bEw>
    <xmx:WeNhZzjAwZYetAbTLT9QV8Fuhou0gcpYh08kopNJqPJXVzhgQ_VBVw>
    <xmx:WeNhZ165bnnzNy9QmL2ISxGrUHVwjHsIT8YlsZjvTIJa7_kpulF5uw>
    <xmx:WeNhZxT6qNMjPt3zpzW6reVN5Wvq-Xod0FSZY9B58nc0cucUIShFDP_X>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Dec 2024 15:47:20 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Wang Bing-hua via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  shejialuo <shejialuo@gmail.com>,  Wang Bing-hua
 <louiswpf@gmail.com>
Subject: Re: [PATCH v2] remote: align --verbose output with spaces
In-Reply-To: <pull.1837.v2.git.1734455884405.gitgitgadget@gmail.com> (Wang
	Bing-hua via GitGitGadget's message of "Tue, 17 Dec 2024 17:18:04
	+0000")
References: <pull.1837.git.1734439176360.gitgitgadget@gmail.com>
	<pull.1837.v2.git.1734455884405.gitgitgadget@gmail.com>
Date: Tue, 17 Dec 2024 12:47:19 -0800
Message-ID: <xmqq4j32yr3c.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Wang Bing-hua via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Wang Bing-hua <louiswpf@gmail.com>
>
> Remote names exceeding a tab width could cause misalignment.
> Align --verbose output with spaces instead of a tab.

While I am still not convinced if this change is a good idea (see
my earlier comment in a separate message)...

> +static int calc_maxwidth(struct string_list *list)
> +{
> +	int max = 0;
> +	struct string_list_item *item;
> +
> +	for_each_string_list_item (item, list) {
> +		int w = utf8_strwidth(item->string);
> +
> +		if (w > max)
> +			max = w;
> +	}
> +	return max;
> +}
> +
>  static int show_all(void)
>  {
>  	struct string_list list = STRING_LIST_INIT_DUP;
> @@ -1287,16 +1302,25 @@ static int show_all(void)
>  	result = for_each_remote(get_one_entry, &list);
>  
>  	if (!result) {
> -		int i;
> +		int maxwidth = 0;
> +		struct string_list_item *item;
>  
> +		if (verbose)
> +			maxwidth = calc_maxwidth(&list);

I wonder if it is a better idea to extend get_one_entry() interface
to take not just a string_list but something like

	struct remotes_data {
		int maxwidth;
		struct string_list *list_of_remotes;
	};

if we think it is a good idea to give richer output to show_all()
function (instead of keep it spartan and compatible for the sake of
not breaking machine readers).  There may be things other than
maxwidth that future changes to "git remote [-v]" may find needed.
And with such a change, you do not need a separate iteration over
the list of remotes just to call calc_maxwidth() callback.  Keeping
a tally of "max length we have seen" inside get_one_entry() regardless
of "--verbose" setting shouldn't be too costly and help reduce the
complexity of the code.

>  		string_list_sort(&list);
> -		for (i = 0; i < list.nr; i++) {
> -			struct string_list_item *item = list.items + i;
> -			if (verbose)
> -				printf("%s\t%s\n", item->string,
> -					item->util ? (const char *)item->util : "");
> -			else {
> -				if (i && !strcmp((item - 1)->string, item->string))
> +		for_each_string_list_item (item, &list) {

Use of for_each_string_list_item() instead of a manual iteration is
probably a good idea here.  If this were a larger change, that may
deserve to be a preparatory step on its own, but it is probably OK
to do so in the same patch.

> +			if (verbose) {
> +				struct strbuf s = STRBUF_INIT;
> +
> +				strbuf_utf8_align(&s, ALIGN_LEFT, maxwidth + 1,
> +						  item->string);
> +				if (item->util)
> +					strbuf_addstr(&s, item->util);
> +				printf("%s\n", s.buf);
> +				strbuf_release(&s);

Wouldn't it work to just do (totally untested code snippet below;
may have off-by-one around maxwidth)

				printf("%.*s%s", maxwidth, item->string,
					item->util ? "" : item->util);

without using any strbuf operation?
