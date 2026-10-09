Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 307063C343F
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 18:27:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570466; cv=none; b=PaXw/jVYSf8xQPkwpjAz7JNiw1bGAogYARy+hcpok7KTTDPrBIIjCEkyYBxdfUbYVqoRQglL30TusLMw1X3EnO7aKybLatp7v1TZqDnR7y59PAfFvnGxnGfg0VhEuwqnyGWCIUJJ90zX1yit+ZDpLR/lT3y9rM9o/X3RB/FeNmg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570466; c=relaxed/simple;
	bh=ti+fL6O3aRoeDGEH4NbtX+IL1SyxQjiRx7SZFt2HzoY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nh8XWpCKuB/e+FA6eVC62TPkbzHsVtxwHFf6qA+utnOGluwmscesQpEHUs+WVhP3MH8z1SNyQcrrfQJL28oEx08PHbbbnbt4+XGWvmtNWQlWoMkktss3QT9Yb3h0iL5b+82lPikldsO72iN6fS8+Pg0wIochUKGFimYQY1YUXao=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=BH0vwrk/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=FhL9lUzk; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="BH0vwrk/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="FhL9lUzk"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 6A31A7A00E1
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 14:27:43 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Fri, 09 Oct 2026 14:27:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791570463; x=1791656863; bh=C74R7R93Be
	NFx4ROKdNFhD1PVkj9w2AWQdNYoAn3hBM=; b=BH0vwrk/D4+uOLpNO+9stUPH7O
	nRBJG4TgrQZDa8m5+E8cWkSRT4PlXJsUbpnKEiTr2yqOFFlvBi4w5qO2oadcSfkE
	4TukL2U8axRLEMhC0PWq4ZsYNkoij9rRiYtX1rrjffP3yxTXpKqtN7kjURdZQcNs
	20Ad1HKJAj7Emp6tONZWAwKHI2WLl/Jj0AVdcgzN+fc33LJZNvhaEdMAMQ6L2I3Q
	v60wkz4A20WfJZDEbGY3tyeRcwAyAJEhzyZpAUl6rlZiNQkVdhjGsM2/4kJEV01X
	7npAVyxJXA3unsOWTlbPwddudjRorZgyXEHwQkB0JlTfgfJDS7UpX30Q9awQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791570463; x=1791656863; bh=C74R7R93BeNFx4ROKdNFhD1PVkj9w2AWQdN
	YoAn3hBM=; b=FhL9lUzkWegZkNhmhkvqp/cszOuoANhQo4GdwcX64qfjk5XAQAW
	ek36uUnoQfDubgR31DkZ6iIXjzL5DNnlz7dpjpxWPzDokE1UBsVPediFTu9mPM97
	N9bNmB+RmbXa7V0GbyNPFvVkq+fa2IynBgnHFBBliN5WOZpfKb7Wtg0U4iWtyLpy
	4lvx7xGQN20x2xV8DkR9N9oBOodha9y4J8m+RAXUY+XWzHpP2vj0/IsBh8q4+cHw
	nMXbNjGP66Cv46MQKRoO5vMlIuAuuIghcHnUHgshs47Cc9KmsAPyhWavsflMRV/e
	ddXvT18NIS7FCjEkTcH/g8F/TXWaNI9qZtg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791570463; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:HiAdTdS1RBVTinktOzIf9bLoGHg7Jz8ST/iLwI8qVx5CL3c
	7SKWuPJl3N6GxVUuKGM0JdZIdLlxFkCp4IogB2laOLgJ/39MotDjpWlwlmpmTgc1
	cWIy3lOrC6qgLzR0GQxxNsu5eMI+ccDn06IrCuQLjpBl6G3u1bVD3SwIb8YBqVTD
	Zg5vdj2y6l9R4xYz/cvlN6SSij4U3zcVe+5QotcRgoums399hYE8Rkd7RpYkh50D
	IQ5FmyYe4Y46NSUPl2AQX+twe8kFLvvdjPW7W6YWDWhHsTaoAtCH0Ov/RTSwrGDD
	bELvCyTFLPPyIbWH7eb32RPlJwWq6noiHe55Tpw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:CS1uvRGGWHmQ6U5ry6AzaTfB0J4hBzxJQSJkx3mEWrM=:ti+fL6O3aRoeDGEH4NbtX+IL1SyxQjiRx7SZFt2HzoY=;
X-ME-Sender: <xms:HzLJasDgsEVswXIEiqOU0WL8tLdS_r0cX72urrgT4PqpgI0cEl8-0w>
    <xme:HzLJagw2CkaE_cn1CQTOOA-j3rO4rxAEQAxzwser_WBWAQpKCXJGRqhXn-CgIUSca
    7y7_ZHRkHLKzHITuZONZisGJWRtTXJwYyLNL_3HZW9OMeZ1uiJYVPg>
X-ME-Received: <xmr:HzLJah2nOyVrcohVDkrL63gP7JLwVojDHjfn1kBO_YWP3nqk7WO4WK3y4OAwWUsmUlv98C67JesENrcCXFJej2uZApyDEvez3Kt3>
X-ME-Proxy-Cause: dmFkZTGpig+tChP347ZiS4r+0Opy9hqt5Xb8W9OShER6yhhqPmeHrVy8RepY5lsZeMLz+k
    bBBTTSlUeDxW7478It1PkCrqFmUdYCkH2zADRfgHYz+LGhIDNz0cai5WkPxq7Ript/1kNZ
    r/8Ynid4uY29suVu1UdBhuyxXR3buH8sW+M4HgZ5jxsi0f5GzzBrut+xM05/HkcibJlXJk
    2b7DRLDUvG8bGewAtQWMP2JoH3gmbBbgyp4JxnvgfaycDYXeoeANVdH54Z46qxtOEGM034
    eKf4J07AOVjrEJZnWIqf2ef5y8mGVGDLAbvLnV3ML61WVXYGrrueZLhvqMpZ9OEdnUIynP
    C6EqY5PiJx9ngM7EZBNoaG4Ma/0gxcUa111uz/2aQ3dPQlUlMpBJYVzkPRFqUSl9UuGmhB
    C9OBLzRi8zTKMvVDmf6Cg1zEdVxkiw0ZwWkq1JR1RUOHHeN8XIga9EMVQQ1QyWD13Qy1PK
    IwsdI8QqBNQxDWa4VAPi0crrYrc8QIN3WS/PXvAEJcBs4IVPFhvq6hhUZPxD3+/seC8PWD
    gWNG1QpGgnYvwlQ4KnMKt6a0DCJCUbXY+PxXO8mbGwgrykiGyQ+/jxG8YJEYkJoi4JC/P9
    228eaka4Oc1UzGZnMkFHx0EURmift6OdmHaxuQyMqRdguGf1ITJtg2PEfLcA
X-ME-Proxy: <xmx:HzLJaoyj9TWLDMbTu43z6Hv80455YuAnI_kcl_CSa_4d3IvuoN6DFw>
    <xmx:HzLJagE_Sx99PZSebn5oZBy8J8K2jfGvr0wfSKY80_GqkHVpLGcT1A>
    <xmx:HzLJajYZ3jJh7n-RxAlIj_5MxBfzil6o0IKqa6QGXz7LavIj9yeXcQ>
    <xmx:HzLJaqCb2bhFx3sGgkj5rsc1GX-YyETE0j44wPXP0MSOuVyAG2ATpA>
    <xmx:HzLJau2batXlxO0EQM-Y-0PnQhWYjUmSV2YaXtyGGHo0XFrukl5Z-gDj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 14:27:42 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Jeff King <peff@peff.net>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 6/6] doc: git-pull: link to new merge conflicts guide
In-Reply-To: <ac77db6762c55eff9b6883eba98bfde3694aef24.1791547213.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 09 Oct 2026 12:00:13
	+0000")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
	<ac77db6762c55eff9b6883eba98bfde3694aef24.1791547213.git.gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 11:27:41 -0700
Message-ID: <xmqqo6d2pw4i.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Julia Evans <julia@jvns.ca>
>
> Signed-off-by: Julia Evans <julia@jvns.ca>
> ---
>  Documentation/git-pull.adoc | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/git-pull.adoc b/Documentation/git-pull.adoc
> index 88f4fd3926..73f6d460bb 100644
> --- a/Documentation/git-pull.adoc
> +++ b/Documentation/git-pull.adoc
> @@ -38,7 +38,8 @@ or `pull.ff` with your preferred behaviour.
>  
>  If there's a merge conflict during the merge or rebase that you don't
>  want to handle, you can safely abort it with `git merge --abort` or
> -`git rebase --abort`.
> +`git rebase --abort`. See linkgit:gitmergeconflicts[7]
> +(or `git help mergeconflicts`) for a guide to handling merge conflicts.
>  
>  OPTIONS
>  -------

Very good.
