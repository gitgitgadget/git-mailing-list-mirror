Received: from fhigh-b6-smtp.messagingengine.com (fhigh-b6-smtp.messagingengine.com [202.12.124.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1367D2CCB9
	for <git@vger.kernel.org>; Sat, 18 Jul 2026 17:34:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784396055; cv=none; b=NeT/usz2y1hEG37tFff3k6DHfuySZ7rKjbxm+a88ZvO1c9cGrCJG3fV9i0HFpToLq14IhPuDVQcFqyoPvfw+eLno50sjw/lFefSECotMh5DPrk/VzPMlcdCNpzIDlS9SBJgh6Qlv9ncLAWHNDN+Hb6VqINgY0pnkdvoOSJ2bv8E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784396055; c=relaxed/simple;
	bh=L7zrBw4XK9mBo2iViDA94dEPcM87Ja5OZuKGR+vKZf8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=UXXau/RXTiw4kjAHnNaTemTJXFZxoSzAeVfTRHOcSxpzLdwXG/ttKkCtsF0f/cYwrZn+Pdt/W0IziyuzNBO0NVs9IFAyrs/vf6+bjt/kfrp7Z+JhmyjNrtBcLpjZwUeQHA1SyWjUw3HqZdLnjwb56oPBFaM48JRzYYUlinLt6lw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AnyJUWz+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AU85UchD; arc=none smtp.client-ip=202.12.124.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AnyJUWz+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AU85UchD"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 2CACA7A0084;
	Sat, 18 Jul 2026 13:34:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Sat, 18 Jul 2026 13:34:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1784396052;
	 x=1784482452; bh=h4wsPc4i0Z613CWSK07SfZ35LIIfcYTKbc1SsqT+NhY=; b=
	AnyJUWz+w+TiIm7CARNluHDar00mXPlVHwYvYfJSrAE5ZSoEIs2AuGEFwpoU3ygZ
	lX6c89YlzDsqtBYNa/Wyozf/P9XWAJ+QAY/Dt9Zcj6Ff5GxIZmr4Yn/sIqiUrjPd
	IeqC+Uz9nxRJAa1SjwLd9bbLQVmc3l4NKa3nqn13i/k/sKosjEQzYBsBtJ/xFvMy
	hCL5tMN9PqI4/C2Hs9pBrPy64XyVJF2PIuGLWGlNtRCCSCbxG7o03t2o3AOZoFFM
	u/qUwFFQn//zdnTW8QmLLYcVwGgDxQG20/mA8AN7AlWw1uZ6pRCwHrdcJlI4J6AQ
	HmYbBjDZ3NFHFggz+OCoEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1784396052; x=
	1784482452; bh=h4wsPc4i0Z613CWSK07SfZ35LIIfcYTKbc1SsqT+NhY=; b=A
	U85UchD9vC0Xtgzm4HfymgqJR9EgJJaIGEYZJhv4WphmyDYf7wVXEuzNaANK5tJx
	yHb6Qo6ttKPBvhxoqCxDfGAa5GYLyUsKPxjrMVou4LgPpWIWzprGwA4twrUHy2vO
	zLPtwRBfQD+3KcXLdQhCyrobYLNvloFirsNsAHoA/CDDnrSQgzaTgCslLbtNm+Oi
	zrpqtwhQIRwi+Z6QT7DK+yMnN4WT1jZ4vZwL0zPkvgXNFU+kn9EWaQRQ9G/Jrb/w
	kIuNUvr8F4SRA5SK9HcNfS3g495lW6ZyiZRXg/5mAgx6YgTUJkhtKPOQO896lpgx
	XZoWwkEi0rP/smnd8uvPQ==
X-ME-Sender: <xms:ErlbaiPVOmgj0A35-zMcszzpHqNPaUE5jn0VEXpsz2YGaq_aw8TnBg>
    <xme:ErlbajM2nBE6Fbaz1VDW_2bBZ8kPFmVBx_JCOL3EZxP-EnOr3-J-4PvRWW8FZ8eiY
    V5Ko_149XiM6qhsqvEo1sXqZ9wrpN0VRfdi1JaE7gCSZfWPV4gxvQ>
X-ME-Received: <xmr:ErlbarjBfPQifk_T6ddUx38xT16TzVOUvLubgYlb5R09oOstmeypozwqH4BhGQk-XimJFAv-zI06Y4FQJgfUfdphp3JsSOoMdw>
X-ME-Proxy-Cause: dmFkZTFjOYhDMWUPMQBaTbI4kJbeJLRlMLIjhFZv9NA9+iRGCqvCbR426PYMM3TNyi2OE9
    PLAGWpYTILX9PHsgBVbN3/uCfj9R3RPh+ZGCtChAqJEJWEnthfdXt3yUrpqyAoIzyzp1Au
    PO5IpowOn4Kklx2L4zQIO2lwOSdwjROkUmbrl8UHQAhdHapZRxTmBUbm+TasOwJXAwQQsR
    0vjqOGFi08J9tsv2HqKup1BHvfN3eg3z+JH/2j4vRX216kx1IfGx0PsPYo4oL9lFjSSG1t
    zUueEerg0v7DmaVP3cU8t3e3q7Hj0x2p3HX8geq3sgGjMOYNtwHDZP6xKDig4bkKJNU4PY
    MOeQFOrXxu7XwJJcD2yULvNwnbbCvVknNkIl7uyPSB4Vjq6A5LY6jwMgi1k6PYkAHE4oFt
    N13MBPfclWpSGpsZ7N6hnoAuuj+F8OEfihULEiIwYFIrmC346ZOYsjeTdlOnM2IqMg1qdM
    T6VWmDB7DZOj/JA5FpnAkZjfvYyN14eWO1vlh1sFNvwydf0nAnArSDZvnCqNPPDKliKyds
    v9zBgWZZhIx5Ijj9fX1WquoHlVDv2ijvo9a3qFdxQK3GQCTLd5m1MqqDVFid1GqkuSTqiQ
    wEEzNdrFqNSCUnbfhOGW3u4AFN9UyfE2vYbx0o0y/hiwTMIs3AcKKCEEUN8w
X-ME-Proxy: <xmx:Erlbaos5eeMmv2HcssO-TFGyN3m4Eeq5EzHEzFmIxVPPvTUcMXpuWg>
    <xmx:ErlbapQ2KaICX5lBWO_heOCInDmoOQT8lDnhNnfSHuGQ24ML_B829Q>
    <xmx:Erlbas2UUg1r1FWLG9tOc2v8dyTbMpGNETDRf4nQl-mt2onyuE0EAA>
    <xmx:Erlbauvkr0RLTl9NLNrsIZ65RzZzgD2w9MWqwrBfHbklOuyKzMGWow>
    <xmx:FLlbaprwq0siWrjvNUlK-tqDT7Nd8cI_QojgUc0BvFFCxMoNrY8lPn8O>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 18 Jul 2026 13:34:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
    Phillip Wood <phillip.wood123@gmail.com>,
    Toon Claes <toon@iotcl.com>,
    Patrick Steinhardt <ps@pks.im>
Cc: Git List <git@vger.kernel.org>,  stsp <stsp2@yandex.ru>
Subject: Re: [PATCH] branch: report kind of checkout when rejecting delete
In-Reply-To: <9865fc6b-e3fe-4614-9ffe-71af776e1796@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Sat, 18 Jul 2026 06:39:18 +0200")
References: <9865fc6b-e3fe-4614-9ffe-71af776e1796@web.de>
Date: Sat, 18 Jul 2026 10:34:09 -0700
Message-ID: <xmqqjyqsqk1a.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

René Scharfe <l.s.r@web.de> writes:

> git branch refuses to delete branches that are currently checked out
> with a message like this: "error: cannot delete branch 'foo' used by
> worktree at '/path/of/worktree'".  This can be confusing with internal
> checkouts, e.g. if one tries to delete a branch associated with an
> active bisect run.
>
> Mention the kind of internal checkout, if any, to spare the user from
> remembering that they might have forgotten a bisect or rebase.  To do
> that, register the checkout reason in a strintmap alongside the existing
> strmap that stores the worktree path.
>
> Suggested-by: stsp <stsp2@yandex.ru>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> Original message:
> https://lore.kernel.org/git/cae34516-5437-49d3-8d39-16f4059a81a8@yandex.ru/

This reminds me of another recent discussion on rewriting a branch
that is checked out elsewhere, where the "git history" command
forgot to apply the same safety check:

https://lore.kernel.org/git/e7dbcede-4486-459c-aa64-e44690e01fe0@gmail.com/

We definitely need an easy-to-use API to determine consistently
which branches are in use, and to teach all commands that repoint
branch tips to use it to offer the same safety to users.  The
framework that this patch introduces might be a good starting point
for that effort.

> diff --git a/branch.h b/branch.h
> index 3dc6e2a0ff..d1073fe1cd 100644
> --- a/branch.h
> +++ b/branch.h
> @@ -15,6 +15,14 @@ enum branch_track {
>  	BRANCH_TRACK_SIMPLE,
>  };
>  
> +enum branch_checkout_kind {
> +	BRANCH_CHECKOUT_KIND_UNSPECIFIED = 0,
> +	BRANCH_CHECKOUT_KIND_CHECKOUT,
> +	BRANCH_CHECKOUT_KIND_REBASE,
> +	BRANCH_CHECKOUT_KIND_BISECT,
> +	BRANCH_CHECKOUT_KIND_UPDATE_REF,
> +};
> +
> ...
> +/*
> + * If the branch at 'refname' is currently checked out in a worktree,
> + * then return the kind of checkout, i.e. whether it was done by an
> + * actual checkout or a rebase etc.
> + */
> +enum branch_checkout_kind branch_checkout_kind(const char *refname);

OK.

> diff --git a/builtin/branch.c b/builtin/branch.c
> index dede60d27b..3223347129 100644
> --- a/builtin/branch.c
> +++ b/builtin/branch.c
> @@ -266,9 +266,34 @@ static int delete_branches(int argc, const char **argv, int force, int kinds,
>  		if (kinds == FILTER_REFS_BRANCHES) {
>  			const char *path;
>  			if ((path = branch_checked_out(name))) {
> -				error(_("cannot delete branch '%s' "
> -					"used by worktree at '%s'"),
> -				      bname.buf, path);
> +				int kind = branch_checkout_kind(name);

Not "enum branch_checkout_kind" but "int"?

> +				switch (kind) {
> +				case BRANCH_CHECKOUT_KIND_CHECKOUT:
> +					error(_("cannot delete branch '%s' "
> +						"used by worktree at '%s'"),
> +					      bname.buf, path);
> +					break;

We may want to be more explicit and say "cannot delete
branch 'frotz' checked out in worktree at '/tmp/nitfol'"
instead.  Unless this is a catch-all entry for states that
are neither 'rebase', 'bisect', nor 'rebase-merges' but are
somehow otherwise in use, that is.

> +				case BRANCH_CHECKOUT_KIND_UPDATE_REF:
> +					error(_("cannot delete branch '%s' "
> +						"used by worktree at '%s' "
> +						"for update-ref"),
> +					      bname.buf, path);
> +					break;

I was quite lost when searching for cases where this 'update-ref'
state might be encountered, and I still lack confidence.  Can
we make the diagnostic message a bit friendlier to our users?

For instance, something like: 'You are rebasing a history with
merges in that other worktree, and the tip of this branch will
be updated when that process completes, so you cannot delete
it from here.'  (Naturally, I may have misidentified the exact
nature of the error, but this illustrates the level of detail and
user-facing clarity I hope to see.)

> diff --git a/t/t3200-branch.sh b/t/t3200-branch.sh
> index e2682a83a0..e5df493b66 100755
> --- a/t/t3200-branch.sh
> +++ b/t/t3200-branch.sh
> @@ -930,7 +930,7 @@ test_expect_success 'deleting currently checked out branch fails' '
>  	git worktree add -b my7 my7 &&
>  	test_must_fail git -C my7 branch -d my7 &&
>  	test_must_fail git branch -d my7 2>actual &&
> -	grep "^error: cannot delete branch .my7. used by worktree at " actual &&
> +	test_grep "^error: cannot delete branch '"'"'my7'"'"' used by worktree at '"'.*'\$"'" actual &&
>  	rm -r my7 &&
>  	git worktree prune
>  '
> @@ -941,7 +941,7 @@ test_expect_success 'deleting in-use branch fails' '
>  	git -C my7 bisect start HEAD HEAD~2 &&
>  	test_must_fail git -C my7 branch -d my7 &&
>  	test_must_fail git branch -d my7 2>actual &&
> -	grep "^error: cannot delete branch .my7. used by worktree at " actual &&
> +	test_grep "^error: cannot delete branch '"'"'my7'"'"' used by worktree at '"'.*' for bisect\$"'" actual &&
>  	rm -r my7 &&
>  	git worktree prune
>  '

We distinguish four kinds in the code but we test only two of them?

Thanks.  I very much like the direction this is taking us.
