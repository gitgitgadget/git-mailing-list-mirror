Received: from fout-b3-smtp.messagingengine.com (fout-b3-smtp.messagingengine.com [202.12.124.146])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE620374725
	for <git@vger.kernel.org>; Mon,  1 Jun 2026 12:23:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.146
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780316594; cv=none; b=kKPwnvlB/pJERoeutG2liQDxIs75RLn1UMhQQJys4pyBATDA0+hGnvLHpaBjDBUJs8d3U6leK+tb3TN64KLvn6JzxtM7VIEVunDhSWrNDyZiI6pUfVvGT18LrTbi/lU6j/I5G3dOZiyY+yPabNno+74XoEY0/MrylTP7cdVbW04=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780316594; c=relaxed/simple;
	bh=u7F9cPs6AjwSAB1aRisi0DZvlY4AaEhwZX1htjY5wZs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=CuTa3MCKRyCgOGGQmJxwZi4rbczo1kDQP1bWNv8wBns2CP20ZyApw0g7Dl1E5Cl32Mbs2Ru8o/8zWNBJ293nijgbig/bDco4ixzI4GaA0LeQUffihBx00k29detbqPRYOBnDEm+NmKObv0N646pVjoYgkmz8ed1OQKPyzTsBHcQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TUkhfM6x; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=N/MthF7t; arc=none smtp.client-ip=202.12.124.146
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TUkhfM6x";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="N/MthF7t"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 1F14A1D00356;
	Mon,  1 Jun 2026 08:23:12 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 01 Jun 2026 08:23:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1780316591; x=1780402991; bh=ydgFesSSrL
	zZsmpkH+XQkvNDz99ksLwkM81f4RFqqWw=; b=TUkhfM6xP3mQEMQ3NXx+8nX12+
	fNV6Ho3SUE2TNsfainBL9gTZbtp39vjBiY/pGMl+aTLt0+2zmozMox3HcaT+GDVn
	0/Y9fAjIoNtlh5tNrU4PJNCQ6NdQRXoUbQAV12BCJhIyzf9cqJ86uiibzJWok1NH
	C+vuVrtN0t6Hfo3LC3nnAmKEez0o7yoNLLb9ZoVvk0VEBiaCCRXs/0i13eheS5EC
	VP9JwAnfkp1RqWBEHiUN9BKLQzDPsPiiaxEx4Osn4OWIJuu4dnSedPM7uxBwEDNt
	bMMqesK1NH0KxJAVpE5jmeCWryxvVKtF1qQHPXi/mh667kvlsjqyS2fhZAUQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1780316591; x=1780402991; bh=ydgFesSSrLzZsmpkH+XQkvNDz99ksLwkM81
	f4RFqqWw=; b=N/MthF7t8QlGcMUpNDt0srmATtApJjaIgu+uilOoKXWlTJ6BvTs
	DWn5lg5pZJDL5IYyJo2RUE0ooIOyNhtZ7FSGoQZoONIR+cosJbYPUPUoXWfYt7vA
	3+Jr3ElCTv3g+Ov0gozQd8Z+nDicy/Ho2/gSVUe9OdpZYtALLb6vtOlPv/PoYbRB
	/U8v92zyhWhH1p7QhNejplgYVXA2qlp0jt/BK04mWneGfQYqbycJOteqm0rM5sxR
	EBNuJ61EYv5ItR0ynV3lt435rkubATv2FUj/ChWD/tz8vY/iDB+NP9a8zpz1kOBn
	0aw3msjLgFOmY89B6YM/L7ZfnYRhZNDvvHw==
X-ME-Sender: <xms:r3kdahvvMj9XWfjV0QlCcW-OJDx1VGPs9XtFCge2fBK1HGoxFApDuQ>
    <xme:r3kdahfRlOXljZ1Q79Qu8GiCe_Pc1X4RqC6OP8h4szG4I6vVG3lrDky5pzyQsSMPr
    nA1t2bw55ZzpVozpOTFDJGHDVOpE_tUVlOMAYJ2cGs8M6uwzn1d>
X-ME-Received: <xmr:r3kdapy-VZXZ-CrV8GnPxT4SQlYbq63o55OtryZiXwlG7N0ozl6Ohaaj-3KoPm4mX5KyDhLF0pfETWNw8f-T-aSpjeRrhnAJB067>
X-ME-Proxy-Cause: dmFkZTFU0uNpxw5mXyXttPkI/3cwLj/YdmpiIWQkuyuaFozrhLvKIsOmm2wE89wP9ueWaw
    YRXXIcPSJEvNc6saHzd3rZY29YsjhSjU05rS54/iS5nL1o4nREXSrTdueq/ndYp2hUPdiF
    ine+G90HoqFP8Gwl+LoRcGG2RXZlE4bPghPDX+boYWPHg62KqDIcMafFG0hUkd/eNg3LT3
    BC/1W7jET7pYmsXbB6FpGpSwIPEIbg+m5Hr9R9hdp2tlF6p4WJ3jow/LiltZ+XHOUxOHG/
    gs6uFx6g6Lk0q/oOg5bcpC1sIS3m2bLkAsCtFaVTj935czNQwF0Df1POCzjZgCtSDr7NTM
    cCLhI/AzGcBbuSaylFLJTVjxkfM/b2TxuBP5jkgqS6r1Q+pYUQabgLkcLX/H/VK/ycC+Ze
    IAnOn9uf9PQTvE4EfHscUSbhsO/KSleYRydCgYq7Y3Y+DPinbXpavpn88ARmmhZ+XntLZE
    AMqS8RXXw0b1A2mI+XgJrD9OMXXO8YLorYlB/p0inwncMeu2aTsWAZN/+HWXGbgLet/7Md
    SBmdBY3FnWIdM2rf+KT3ibUSsithPOgOhMs66c1EfsbbZilD1iHxviaP2I/6dHMsJQ7fIJ
    OBjRrffu9mg2fPyQQNF8uPTp1/MVtDFRX1GWaBhQ72V+LmhbLldBLNOMB0Ug
X-ME-Proxy: <xmx:r3kdanFesne4HF9liYxwePV_1OC8fCHpOYSeN_0uUGaW9X2nJMDSkA>
    <xmx:r3kdatzxOPMrh0keAm60xPnqxTUHYJDOu_Y42ll2qv_p-8TsM-xatQ>
    <xmx:r3kdaovw8MWppmc3NnWyDnT7ON3qR5p2jRuhuCnTja2ICop5HEM51g>
    <xmx:r3kdaq1gwpFk9tqVvENoHqXcnGd5riIbrRUG1OLpOg-qcdrba7v8Bw>
    <xmx:r3kdatS_AjUKYso6dva5zSQTJDb6ZJzgTfCZkdwOIQvmJfmPKgSayjhy>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 1 Jun 2026 08:23:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Elijah Newren <newren@gmail.com>
Subject: Re: [PATCH 2/5] merge-ort: drop unnecessary show_all_errors from
 collect_merge_info()
In-Reply-To: <949b5d8e3f3aefd9497a7b85d860259b9d5db418.1776731171.git.gitgitgadget@gmail.com>
	(Elijah Newren via GitGitGadget's message of "Tue, 21 Apr 2026
	00:26:08 +0000")
References: <pull.2096.git.1776731171.gitgitgadget@gmail.com>
	<949b5d8e3f3aefd9497a7b85d860259b9d5db418.1776731171.git.gitgitgadget@gmail.com>
Date: Mon, 01 Jun 2026 21:23:10 +0900
Message-ID: <xmqqy0gy4fgx.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Elijah Newren <newren@gmail.com>
>
> collect_merge_info() has set info.show_all_errors = 1 since
> d2bc1994f363 (merge-ort: implement a very basic collect_merge_info(),
> 2020-12-13).  This setting was copied from unpack-trees.c where it
> controls batching of error messages for porcelain display, but
> merge-ort has no such error-batching logic and never needed it.
>
> With show_all_errors set, traverse_trees() captures a negative callback
> return but continues processing remaining entries rather than stopping
> immediately.  Removing the setting restores the default behavior where
> a negative return from collect_merge_info_callback() breaks out of the
> traversal loop right away, allowing a future commit to exit early when
> a corrupt tree is detected.

Nice spotting.  As the error handling eventually is to die without
making any further damange, returning early without seeing "more
errors" is a good change.

>
> Signed-off-by: Elijah Newren <newren@gmail.com>
> ---
>  merge-ort.c | 1 -
>  1 file changed, 1 deletion(-)
>
> diff --git a/merge-ort.c b/merge-ort.c
> index 4b8e32209d..74e9636020 100644
> --- a/merge-ort.c
> +++ b/merge-ort.c
> @@ -1740,7 +1740,6 @@ static int collect_merge_info(struct merge_options *opt,
>  	setup_traverse_info(&info, opt->priv->toplevel_dir);
>  	info.fn = collect_merge_info_callback;
>  	info.data = opt;
> -	info.show_all_errors = 1;
>  
>  	if (repo_parse_tree(opt->repo, merge_base) < 0 ||
>  	    repo_parse_tree(opt->repo, side1) < 0 ||
