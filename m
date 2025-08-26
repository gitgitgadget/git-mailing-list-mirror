Received: from mail-il1-f175.google.com (mail-il1-f175.google.com [209.85.166.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7D34BA34
	for <git@vger.kernel.org>; Tue, 26 Aug 2025 01:58:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1756173490; cv=none; b=mbXP+Ce+eC8dGkE0Ln+uTdtSdaEIWziAkHqMAk6hiCUQSGDqfjyjrv/mU4wGt31EJUlPRTZ94v4n/mmZCj+9VSjUA4ffN9MaF6AQ0/8VH8XNGT1tpEfaBTuRWV64usxEtm3XxOzGBRVazNYo8nKz4X8qb+7mAxd3xIH1yqvt2Vk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1756173490; c=relaxed/simple;
	bh=qLPEMvHFUxiP7TEuazLiaBJfpgFpGd5aw80Z/Fx2fOs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aiEgmQiG3zP0/IrjcrRWDXztHRT/KyIrludZtaDfcfrQImnfL+qMQd3bcqyr+5Tp3UddPKdZf121TVCwm6wu4i27Affc019PY3MCMU8KfHhuwktGylIa5jrSs3L+S/Hl4bPY70dWT6RibM9x5FoEFT+eLvRj3Lr0zOi5lA47EuQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b=DZKhMkNx; arc=none smtp.client-ip=209.85.166.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr.com header.i=@ttaylorr.com header.b="DZKhMkNx"
Received: by mail-il1-f175.google.com with SMTP id e9e14a558f8ab-3ea8b3a64a7so14409825ab.0
        for <git@vger.kernel.org>; Mon, 25 Aug 2025 18:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr.com; s=google; t=1756173488; x=1756778288; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=sp9NdweLHDcnqgCz+1+SRKvPqODtoM7kxhu3Bt33EgM=;
        b=DZKhMkNx4msEaqo8cY4bqUiT5gF7TzW/lnQYzitGy+/tCvTZTO6Oeqnj+33VYIVVCQ
         A7qmO8E0cotW0SPBiJMqG1Px3/9CfHVmhRTIHECAjJyJMziejkqVdBUy/CLJv57mr9g4
         ldevQUAkO7e3zVs7/mfzsrqEJEiMQCl5BfvpV04++RXyaJLlZu4K0T+zqHKELlmvVzlE
         somtpJjW1TiJy5oP3U0fHpVPmtLu9H3Z1Wq+HNo3Nti0PbUMKNugBeK3DJLn0cEvt/QO
         ELQBkMnm3R2eTTZfQ0/yME4KODmM5BEKoW54w6xPInKmTDzK182J5RyXY2oXH5SI/4+o
         fw5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1756173488; x=1756778288;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sp9NdweLHDcnqgCz+1+SRKvPqODtoM7kxhu3Bt33EgM=;
        b=A2fEjGzm0O9m9s1QlsrkcsYPBuiTpEMXBdHqnYnr+QOGIxzGq82u4SsTC/vWUl3C7o
         OiUYmqXHVwGpRwGwsb8ewi6biQZaavZpquTfnjwa0GnfXa2g8xWatRfN6ppUo8NhykaF
         afRMa14DkinUyj6uZlm6H8YmU8ZiDs4yTGMR1h0IhtIsWiHJZ/OfxV26B9SEqLZT4dhL
         mdJ0FeCUK37L5lTAJqwoLUw5uHKHxb9yk4o0yb3Nq1kX6UbjZt6RPE8LqR0XeCzcI7Ql
         3n6nY6RAtDWidIi+bncawuj3bNW40ZSn0bTgFPAB5JiX3O8WwMgiO0qQGSjbI5RXqvy9
         Uz/Q==
X-Gm-Message-State: AOJu0YxLsn5To+7T1oxIU3CWDm6ehrna4vlrjS6FDJw6LpIMJTl9A8ih
	VG/78jLGt7Eto91rCAqeCXu+3lIQczU582CCZeakz9k3ZQIR507giwKPs5YML55lHIQ=
X-Gm-Gg: ASbGnct3UwR4zN1altRjqnVY+UPICGSPTghnYP7ev4b1pUO5ZG4x77wDadyTX7P/MVA
	mJU7734IKf6SeyTkoVxQEt3Wp1s9AqN6kYNN4B0Xb4sp2e6SLNWgEJRYgRQP55eoT9kBCHVTQqZ
	nHPwtwy/fexkJwao5Zsd2fdiRFL397YqpBB1lhkRsFRXq2POH0F45AySc48ACrkxyq6UVDu8fPO
	ZyY4ZZmqGpm5jQ8N5Dvc+tI9EB3sX3nVxAV1ubrn3AJaJKgYeWeNevEv5chXpJ3iOqNkSez8EvV
	ZGxeWYM9igmESi1owpHU3sEzuzaRGdz7NVgXF7tFq7d3acEVkA/l2myjlddYjbYenjeBkNKQ4Ks
	9i76mSYLZ4t/nl9kbwvWcekwbVCWLoNm0TkH5RFyM1izvJGxBlTylear8b4Eai35u6K2dgjPg2R
	M/jT748WkzSwmgjwdd2bZdpZvZ3A==
X-Google-Smtp-Source: AGHT+IHWZ4ypudrN4wGR0ya3jDrBMSSXBpsleYq9ef5eJI559TFPqFDEBdwZiSbAe4KPipkUD7Srjg==
X-Received: by 2002:a05:6e02:b4c:b0:3eb:aa04:a67b with SMTP id e9e14a558f8ab-3ebaa04a7d8mr117975405ab.24.1756173487583;
        Mon, 25 Aug 2025 18:58:07 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with UTF8SMTPSA id e9e14a558f8ab-3ec79dabe36sm31233285ab.29.2025.08.25.18.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Aug 2025 18:58:07 -0700 (PDT)
Date: Mon, 25 Aug 2025 21:58:06 -0400
From: Taylor Blau <me@ttaylorr.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, Karthik Nayak <karthik.188@gmail.com>,
	Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 08/16] packfile: refactor `prepare_packed_git()` to
 work on packfile store
Message-ID: <aK0UrslvCQsglMiA@nand.local>
References: <20250821-b4-pks-packfiles-store-v2-0-d10623355e9f@pks.im>
 <20250821-b4-pks-packfiles-store-v2-8-d10623355e9f@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20250821-b4-pks-packfiles-store-v2-8-d10623355e9f@pks.im>

On Thu, Aug 21, 2025 at 09:39:06AM +0200, Patrick Steinhardt wrote:
> The `prepare_packed_git()` function and its friends are responsible for
> loading packfiles as well as the multi-pack index for a given object
> database. Refactor these functions to accept a packfile store instead of
> a repository to clarify their scope.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  packfile.c | 43 +++++++++++++++++++------------------------
>  1 file changed, 19 insertions(+), 24 deletions(-)
>
> diff --git a/packfile.c b/packfile.c
> index 90f15b0c20..2e45a3a05f 100644
> --- a/packfile.c
> +++ b/packfile.c
> @@ -974,38 +974,33 @@ static int sort_pack(const struct packed_git *a, const struct packed_git *b)
>  	return -1;
>  }
>
> -static void rearrange_packed_git(struct repository *r)
> -{
> -	sort_packs(&r->objects->packfiles->packs, sort_pack);
> -}

OK, makes sense -- it looks like you inlined rearrange_packed_git() in
its sole caller packfile_store_prepare() below. I think that could have
been done as a separate step, but it's equally fine to include it here,
too.

> -static void prepare_packed_git_mru(struct repository *r)
> +static void packfile_store_prepare_mru(struct packfile_store *store)
>  {
>  	struct packed_git *p;
>
> -	INIT_LIST_HEAD(&r->objects->packfiles->mru);
> +	INIT_LIST_HEAD(&store->mru);
>
> -	for (p = r->objects->packfiles->packs; p; p = p->next)
> -		list_add_tail(&p->mru, &r->objects->packfiles->mru);
> +	for (p = store->packs; p; p = p->next)
> +		list_add_tail(&p->mru, &store->mru);

Looks all good.

> -static void prepare_packed_git(struct repository *r)
> +static void packfile_store_prepare(struct packfile_store *store)
>  {
>  	struct odb_source *source;
>
> -	if (r->objects->packfiles->initialized)
> +	if (store->initialized)
>  		return;
>
> -	odb_prepare_alternates(r->objects);
> -	for (source = r->objects->sources; source; source = source->next) {
> -		int local = (source == r->objects->sources);
> +	odb_prepare_alternates(store->odb);

Hmmm. I admit that I don't love that the packfile_store knows about the
object_store that it belongs to. This feels like a layering violation
and makes me worry that we pushed too much down into the new
packfile_store. I'm not sure I have a better idea off the top of my
head, though.

Everything down from here looks good to me.

Thanks,
Taylor
