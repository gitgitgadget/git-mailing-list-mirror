Received: from fout-a7-smtp.messagingengine.com (fout-a7-smtp.messagingengine.com [103.168.172.150])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DEB142BE026
	for <git@vger.kernel.org>; Wed, 15 Jul 2026 15:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.150
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784128630; cv=none; b=P8SbIaeXO5Xy+ZeJX3TQHe5WcWA5XUF9t51yO+iE3Xo7+EwHXIet4QLDyWz/hdidl848B62Mup/gh2PyyaG9lL+moSDsvT0dej5ZCQN7U9Fk9TtLH8BxPvC709gnQJvv7I9R94Det4BIg5ITvZMFhiB221QETvt2MopHLQX6flE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784128630; c=relaxed/simple;
	bh=xHP1Jg71EKPHFeEcTrpOCvqI02iESl16zhTnVG7HYTI=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VXgHPUYmdxlgZazMIJjvJvB6XoVQd0I3gJgQDZ9U/76os2Cv9T9+HVTp6MI0JYBEMMgwkGyDLLHOwv/JEF+NT8lQChzh+lVDfwcQFsv+9oWmaSIwiaJSNk+VpDGPnBOGK1C8RoT5x7ezVWfcM1+LMc7jvF5vbGoaD2vTGPJ1b7g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XejUWaOl; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=mkHvu+Te; arc=none smtp.client-ip=103.168.172.150
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XejUWaOl";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="mkHvu+Te"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.phl.internal (Postfix) with ESMTP id 13BE9EC011D;
	Wed, 15 Jul 2026 11:17:08 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Wed, 15 Jul 2026 11:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1784128628; x=1784215028; bh=NVGFnSM01s
	rZp1eN9IKbNq1+Xxwgilsll5UX+tMQwUc=; b=XejUWaOll3PthwTuf3PYT9BxBF
	Nn63gfAhanewGPwYIcB15tZOXqcUnQgCgrPs8eq8UJ3D4lj+21unfJZ0kRpZt2OV
	ZKemCSDNmIiNkVSNl7Pnldg56YF+/Q41qnw66EQo3T+q/oxUxjvdzYheCCA2hxAR
	8neY2KJO41TV3U3GdFtyiajC+oHG2R3hfx+mly3nUdX1OCme1ma0zS4fJkXAzVLv
	5nZKjgj2l+UrerFyni3gTuhAgtyX5wR/rTJwGlXeG5N52/+EIOw/JLH92xuqbeLj
	XW6r4D6KwLzAqUlVJ0EqlhZlc4kpUVRduS2ulFreRnLcAIaBO6RwGGbm0h1Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1784128628; x=1784215028; bh=NVGFnSM01srZp1eN9IKbNq1+Xxwgilsll5U
	X+tMQwUc=; b=mkHvu+TejQvdYRu6t2I+SxURS29zzpS/jeussTgie8z3k3FcIxN
	mKIDaVV7Qy2PzyJ7qUlxHRxD7PDWzjKf2Ss6NfVH8c76jST3TcdADkDOtesPFd7B
	9QFPUU2ZzYBKcjAaaVa11M/FrQwpj1HbeWPvlxY7CKDsH4K9uf7FslkHh1ZOAHdX
	65CquwujqStd6uC8uIkDlgwbsWhRfsr1Wv56dY/wUVYqaeJO/9pKE/ydH62d0TWY
	kxHQ9Tpf3Jt7dwZWg7rssk6tTn4UpFVVqMzzx8cKYXCsFpOjmjXwL1TCD7PqLjze
	9k1Byku5zkxNSa42gPnKP5gtVoD7rfGBXjA==
X-ME-Sender: <xms:c6RXauOjGKpMxwpwkLseRr0sV2yFS1Vhvnu8Yum7uCkGKrX9yF5ESg>
    <xme:c6RXakax0TD3SOcLDPqhTvTjpRX-5Ljp6Pwx2tv1JrPY7xHh8-SynkOZ-VqIuW3kW
    ZoUoVrXZrS1DGnJNLijBTrHuGERNBrKEROYdIYEnkJWQ_HxM3z-Ag>
X-ME-Received: <xmr:c6RXaipnk4M-NnrBJyIMmveTJm4VjIxWXWe2zO-5L5lnOpLNHVnUfOnVn25KsEJVvJOn2IRsmPrp5dMZqjgA1YFhkjDpSPbYrVO1s1k>
X-ME-Proxy-Cause: dmFkZTE0mmV2QDF+/enNRLG97Jjw2DWsRrVFhTj2rkczBA6UxYodbD3BYg43DaxWv9R5bu
    aCZJWwL74zIxIEGvlnmLBT7xDC+ba/fhvtoHMv6QdcDGQlpyoXIjSOOgvsGWEWdM4m7Kwh
    CaAoV8Fhi9v6zI/sfapdtOEFdPS33wehxVfWjLzlpdZNbMnn0SSMmrbmdk+j2D8QZzrtNy
    nX7bxE8FioFRe1lEW7ADbp2FxGEN3DP0j73TQ56uGvy3ype7tGflqnFEbSpjwgZdfe1vu3
    OCCR8sYIyPaoLiQPF912HSPZ3gOGXHJtuq7wjYQGEHXs4kpM/xJtxiFRCCb+l2PZ+Y3jHP
    XBIMCyRsbeUGG03eU6zw2S/32DJVRF35u6pXCPpCNjxNlGPSnp7COWf11/n23y5WAR3jJm
    ZXRhJeKUll2GQ+8aTWYJGq6I9xb41ZPb00Ms1rMZiBnr54km/svzJP0yyLVtguwjFyI3Op
    jb744tP4fUvqnSwX8SPqXWLxO3XFDTs8+gJqU+sl12H09jNox+frIr7c+o5pCItlYiTftN
    /ZPkiOL+e4OawANV79JBW3Zdm5ISe7gWyJcXfvr3SIBhAterag42Rz3OqRvUDP3tgUxO9P
    txIbusiJ6GKDymR2udJGfnL+3Jnc9ZO8t3lqlLCHTAyr3kz4rfZmIkXP41RQ
X-ME-Proxy: <xmx:c6RXaoYs9ePTtqZPQSfYexb9mJK2xP9dlDIY7Cl_YThNpHnwxCjdjw>
    <xmx:c6RXaqTUTf8UnNXT2f5r9PSsPjpFdvazUwNJsxW14o8Dw_j2Yh-7Yw>
    <xmx:c6RXav5i8OpNo-oDIQi4RM8P32gVaEHVOTA42_tAKG7hvHFASyudKw>
    <xmx:c6RXavxjRfX_g1e2uKrmfq0N4lHvAPk_vEpGGQqiMPPiZMLG-TiXUQ>
    <xmx:dKRXaiuusv5nvviSMHFOyXLzKc-1y6d7vZm11yND_eq8NuIx6j6r1FS1>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 15 Jul 2026 11:17:07 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
Cc: git@vger.kernel.org
Subject: Re: [PATCH] diff: ignore unmerged paths outside prefix with
 --relative --cached
In-Reply-To: <20260715060523.GA517940@coredump.intra.peff.net> (Jeff King's
	message of "Wed, 15 Jul 2026 02:05:23 -0400")
References: <20260715060523.GA517940@coredump.intra.peff.net>
Date: Wed, 15 Jul 2026 08:17:06 -0700
Message-ID: <xmqqjyqwp9jh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Jeff King <peff@peff.net> writes:

> A diff using --relative ignores entries outside the current directory.
> This results in a segfault when we try to process an unmerged entry
> that's outside of our prefix, since we end up with a NULL diff_filepair
> and use it without checking that it's valid.
> ...
> +cc Junio, as you may have some wisdom on that further exploration.

Will take a look at the history myself, but I would probably not
have much wisdom on a change from 2011.  I often do not even
remember what I ate for breakfast yesterday ;-).

>  diff-lib.c               | 2 +-
>  t/t4045-diff-relative.sh | 9 +++++++++
>  2 files changed, 10 insertions(+), 1 deletion(-)
>
> diff --git a/diff-lib.c b/diff-lib.c
> index ae91027a02..a23119b852 100644
> --- a/diff-lib.c
> +++ b/diff-lib.c
> @@ -467,7 +467,7 @@ static void do_oneway_diff(struct unpack_trees_options *o,
>  	if (cached && idx && ce_stage(idx)) {
>  		struct diff_filepair *pair;
>  		pair = diff_unmerge(&revs->diffopt, idx->name);
> -		if (tree)
> +		if (pair && tree)
>  			fill_filespec(pair->one, &tree->oid, 1,
>  				      tree->ce_mode);
>  		return;
> diff --git a/t/t4045-diff-relative.sh b/t/t4045-diff-relative.sh
> index 2c8493fe66..167be0bdcc 100755
> --- a/t/t4045-diff-relative.sh
> +++ b/t/t4045-diff-relative.sh
> @@ -245,4 +245,13 @@ test_expect_failure 'diff --relative with change in subdir' '
>  	test_cmp expected out
>  '
>  
> +test_expect_success 'diff --relative --cached with change in subdir' '
> +	git switch br3 &&
> +	test_when_finished "git merge --abort" &&
> +	test_must_fail git merge sub1 &&
> +	echo file0 >expected &&
> +	git -C subdir diff --relative --name-only --cached >out &&
> +	test_cmp expected out
> +'
> +
>  test_done
