Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13DA2AD24
	for <git@vger.kernel.org>; Mon, 27 Jul 2026 00:06:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785110809; cv=none; b=mq9VKvRvRIXKAVxL9la8iBiA7urEUXnnXmK38FfAf0GJYnrZxuVci2foYBn9OKNQW0VgyMyKTKvvSe9hD2wgnEZkAyiEz0CDrX/L5L0nqab9jDbo45Q54CP3g+woN8kZnMgouj0Iie0C5FOBcxDMYPjSbh/9YxI2gR/rkB+sRKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785110809; c=relaxed/simple;
	bh=/rjRsdXIjlSfQAiahyNoqXMzW91unzr/tPAoMvaIUkA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=AOnbevlPapQH0qSPPuChbJtxRWSvGZtGpGPqa9HLZ4rAmuwLKockjpx0gb6rH515QJBGFX+B6BqG4QJO237AomU8fqfTU6PzPNxKuuVYOC3Zn/fd/w87zAGstOQ37s73/LpH3axdvuvP21Oe9joI7s+JO3YxaMD3Bwbr6agj1uU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=koKHQyZo; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=TaojyRkZ; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="koKHQyZo";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="TaojyRkZ"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E3BDE7A005F;
	Sun, 26 Jul 2026 20:06:45 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-05.internal (MEProxy); Sun, 26 Jul 2026 20:06:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1785110805; x=1785197205; bh=nImc6itl18
	YV4U72N1RzuT/dVJV+UQGFFqc44hBqBUc=; b=koKHQyZonLKVPWfIHUhceH0C3p
	96eKJjAh/NsjYiCJOnuUscjo85LwI8MYm1ECQa/GtxzrnHx2dyC/RiVQCQyVUxYX
	6ROKRecosD2BGNAT4Aas+JvjK2kz0Jt48n1qArn8uUTDs8RyrQb/ZN8QB+CzwHNZ
	VvPrz2PCKi9ldNWlbx1bvdgGfPvGVuSa3o7O+YX/5bAVTJeHQkl42B56c/OphCv+
	BUukK1Q669ShCKTv/jrQ74DWlvDR9lj3qLLFLbX3zS9tcbn0tsb8fT5zV6GDbwhJ
	x2FBH2spHnLxR76uP7LYPgU599xVyeIcch8AalBjMdfeZaqjymr+MAAWW3qw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1785110805; x=1785197205; bh=nImc6itl18YV4U72N1RzuT/dVJV+UQGFFqc
	44hBqBUc=; b=TaojyRkZj72sVJntNy1SWKuVrq14OvOCL5ZoRORMRN1aOh0EuB5
	RSGsJk4TtzlTbdBxDg/XT4gww0ULaROcq4WAZ++T9+l+5ok79rylCdBRvjHk+s3x
	TCA3pZ09B7NGUJmyaBDV5Mr51vDbXLOZqRXPS9yKNYp0tNjsBaAp3PvEb8OMCjVj
	sq13J0Ik8qqKdUGnpIs5PvRqszGvbw1iBlGc4UhzT6K4bpfzaU4+N/jXLzzODlU8
	qUJxgyNQv7VN2HbKZim70xWt0B+Ldq8SejoB7d/qd2gcPG8SgMDKjytK0ZtscEby
	gZhpduuNgf+L4KyqmtAR3tJJHBRsO30ymEw==
X-ME-Sender: <xms:FaFmakUg5S-xZzMdu2vm2DzAfXrkfTW3YHbN0CbsnzpPnq1PCt8O_w>
    <xme:FaFmavehVfCW7LOC4aLJrxt_tht4uBc_ICUEekzbP6tp83PkR3A5om_3p_nc5QJGW
    dxjMPI2I7bPfGQ_LwTKS5N6NEyoRnrJUoHYwRGl7COzkjHS4gReajs>
X-ME-Received: <xmr:FaFmagtzwGivoiixvTwaxG4ADoFt_czd4g8caHnuUfIj9PhIBKUKNrx4rtyUZj96zgT3OP7ZYft1GzQ__FYFWGO1Z9-Qum2hPQ>
X-ME-Proxy-Cause: dmFkZTGW6T/Vn3di/yFJqcamssl/8CMoO9EDfwHw4Az0Tda47IZrWlml4WNQRv+H57ziQ5
    FMYqhb6ACFmtQ58bxmdiQixLxsOWyqNQdRsQH/U35WfUn8bbNQ8P1t4GQmvLlpajN/KY8y
    aaZfNhHhDecoyvQrHaFFrvQ1BY0Eg4XjwBW2RyRsDmM/s6kt+Vm5RtYh/72WXzneAKLxf2
    XoWPcSy82k9NflAQwQnDECrWDdOjbIvArXo9FQiFy9XVOyerl6M8bQ5mBcgzR2gCcxlVOp
    NFUZOrpVXoQiaSY6mPovNS2D5YoUWLLnKUwEdYhwcQ1ewGJqvatuHJU95uCgn9nnC7oLfK
    99s4/knDrerm3iqlmPvz5+HF58+ZqwjVwCF/D/qpWBXjDzqRYyxqjHGS6NGKGH7CC6AfJm
    suppYEjF2ZkIiyMA70TlieLFq7M/LgvJg6MyNB7JB8dQfOeUWUkb8XxiZf3cin9TVXiQKA
    POvGhw6zwUDNPO7ek8/8c1gkpzzx+FcFzPl1vB4FkPovYAWiMv8G38v4SL53JaxG7Gy4bQ
    SsvA+bNhvOruiQq9NctJw59/1JmNhhVq1xfL4qkZmnhrJpRBAr7tgKRpF7pywwLs3q1OIA
    Tph48VgTQv1yb6SrFjhmRlirMh1W+lob3wP+ys+7xM/2BqboPBN5aY7KwlHA
X-ME-Proxy: <xmx:FaFmau8HEp8BtOh6kEgm_G04xD4s6iB_ooib8bRoeJTAgFznIXnXBA>
    <xmx:FaFmar3XN7UyOrkTvIbrqbEnvKvxAsujwFoGvgsh0g30Klbzpvt9Fg>
    <xmx:FaFmajAD0yCEaS2AmIgw81dSGNLTmNpLOJ6rrs8QuDS5z4aorp1sKA>
    <xmx:FaFmanfDLnVmPiLS4WDqndr6hGc0k7A2QJhKTSv8m3HYtnC7KihFfw>
    <xmx:FaFmanZVnL9Wo8BSralYSJZ-uxtk12Z_sJulgodC5gS96eDdCanHGTB9>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 26 Jul 2026 20:06:45 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Hardik Kumar <hardikxk@gmail.com>
Cc: git@vger.kernel.org,  l.s.r@web.de,  pabloosabaterr@gmail.com
Subject: Re: [PATCH v2] utf8: use size_t for string width methods and callee
 sites.
In-Reply-To: <20260726195718.1914131-1-hardikxk@gmail.com> (Hardik Kumar's
	message of "Mon, 27 Jul 2026 01:27:18 +0530")
References: <DK8L6JM14UNS.16B15DIOFW1K5@gmail.com>
	<20260726195718.1914131-1-hardikxk@gmail.com>
Date: Sun, 26 Jul 2026 17:06:43 -0700
Message-ID: <xmqqpl09s3cc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Hardik Kumar <hardikxk@gmail.com> writes:

> utf8_strwidth() and utf8_strnwidth() return int, even though the
> return value is always non-negative:
>
> - utf8_strnwidth() accumulates the width into a size_t and otherwise
>   returns its size_t len parameter,
> - utf8_strwidth() just forwards its result.
>
> Change their signatures to return size_t instead.
>
> Update the types of the variables the said method is used to avoid
> potential UB caused by implicit conversion from size_t to int.

The goal looks attractive on the surface, and the change to make
utf8_strwidth() and utf8_strnwidth() return 'size_t' clears an
existing TODO.  However, the updates to the call sites to support
this change introduce several bugs due to unsigned integer underflow
and incorrect mixed-sign comparisons.

Consider just one example:

> diff --git a/diff.c b/diff.c
> index 589c196..4887958 100644
> --- a/diff.c
> +++ b/diff.c
> @@ -2952,7 +2952,8 @@ static int utf8_ish_width(const char **start)
>  
>  static void show_stats(struct diffstat_t *data, struct diff_options *options)
>  {
> -	int i, len, add, del, adds = 0, dels = 0;
> +	int i, add, del, adds = 0, dels = 0;
> +	size_t len;
>  	uintmax_t max_change = 0, max_len = 0;
>  	int total_files = data->nr, count;
>  	int width, name_width, graph_width, number_width = 0, bin_width = 0;

The above change impacts code later in the function (among other
things):

		/*
		 * "scale" the filename
		 */
		len = name_width;
		name_len = utf8_strwidth(name);
		if (name_width < name_len) {
			char *slash;
			prefix = "...";
			len -= 3;
			if (len < 0)
				len = 0;

Here, 'len' used to be an 'int', but now it is 'size_t', which is
unsigned.  The safeguard to prevent 'len' from going down to an
unacceptably low value by clipping it to 0 never triggers, because
'if (len < 0)' can never be true.  If len is less than 3, len -= 3
will result in a fairly large value, and the subsequent computation
would go bananas to see a value with little relation to name_len.

Another example.

> diff --git a/pretty.c b/pretty.c
> index d8a9f37..f7d392d 100644
> --- a/pretty.c
> +++ b/pretty.c
> @@ -1805,11 +1805,12 @@ static size_t format_and_pad_commit(struct strbuf *sb, /* in UTF-8 */
>  {
>  	struct strbuf local_sb = STRBUF_INIT;
>  	size_t total_consumed = 0;
> -	int len, padding = c->padding;
> +	int padding = c->padding;
> +	size_t len;
>  
>  	if (padding < 0) {
>  		const char *start = strrchr(sb->buf, '\n');
> -		int occupied;
> +		size_t occupied;
>  		if (!start)
>  			start = sb->buf;
>  		occupied = utf8_strnwidth(start, strlen(start), 1);

After this post-context, 'occupied' is incremented, and then we have
this:

		padding = (-padding) - occupied;

If 'occupied' is sufficiently large, 'padding' can become negative
here.  Because padding remains an 'int' and can become negative, it
impacts code a bit further down in the same function (among other
similar comparisons):

	if (c->flush_type == flush_left_and_steal) {
		const char *ch = sb->buf + sb->len - 1;
		while (len > padding && ch > sb->buf) {
			const char *p;
			if (*ch == ' ') {
				ch--;
				padding++;
				continue;
			}

We compare 'len' and 'padding', first promoting 'padding' to
'size_t', so when 'padding' is negative, we compare 'len' with a
fairly large number due to unsigned wraparound.  We will fail to
"steal" spaces as we will not loop here.

I will stop here.  What makes reviewing this change so unpleasant is
that on the surface, changing variable definitions to flip int to
size_t looks pretty, yet the real breakage appears in places that
are not shown in the patch at all.

So, this needs more work to become acceptable, I am afraid.
