Received: from fout-a4-smtp.messagingengine.com (fout-a4-smtp.messagingengine.com [103.168.172.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B08851A3A80
	for <git@vger.kernel.org>; Tue, 11 Aug 2026 22:46:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786488370; cv=none; b=BZTmg4H1fRgA9gGf5Co9gTc5ElEHsO5TaZ+qeNvKaFk85sKlJISu0BY4+08iKZxckpG6psg9EL30zFSbvJIm/pmhldNV87JPUg/h4mtkP9twm4Fe7skthf2HfFnbwA+IxJn1L59E91oBgZvw5JnHhE7Rac80mIWniRq1npctSY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786488370; c=relaxed/simple;
	bh=aGE8AkXKXljmeg/J2WZK24WaQMy3biDA+ow/D4QEueo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=I9CNSFSWXXRMoq0EuNRJWv9lwitbj3ofCtQRsPuiuewKp+Mm5uRSoyWxwEjVC0l8+z0jHhfYnR0GSJ4Dx0xozW4KoCxVdTz+7fElQy8DKppk5sJ08CxV6QCCmsW9oAZZ3PBGv8HDl4MTe/pmpQdGXnRrb4lSV+Msv68zX3Pu5aU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=z8FtQUyg; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=GID8/1Xh; arc=none smtp.client-ip=103.168.172.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="z8FtQUyg";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="GID8/1Xh"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id D6306EC00E5;
	Tue, 11 Aug 2026 18:46:07 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Tue, 11 Aug 2026 18:46:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1786488367;
	 x=1786574767; bh=V7dN9xnRul/+NcAkiAdjlCj5osQqh1OWb8WSiGYEeAs=; b=
	z8FtQUygYOu9wQ5mBQJyfFfu/jDQceUZNhhXFZkyK6E7oIbwOAQXHPVIoFfST6dL
	p8IG7dmFYk7gSqgXEOvHmVo8KvjEy5XKAIYT+NlxGiTmvLkLcBWgrMVOx+DMLROc
	/bn4lHCOek5Kq4o8HdzgJ9Z0QJaOp/xe2bmPub+9yTLI314VukRSpVFbdvBpi/6s
	Nm1qT8b1niF/djXuTT+qEUrv3A4sjuoga+52YOxpXi8BUhJaEv72X3/udGt++blj
	tVBpFUYqmmIdJIRd3zPtL2CNqVrMkoMFVHpG+6abb6JrNTxygTFpz2XJBYDF/046
	n5VciV1M26xPfcp/pHc9kg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1786488367; x=
	1786574767; bh=V7dN9xnRul/+NcAkiAdjlCj5osQqh1OWb8WSiGYEeAs=; b=G
	ID8/1XhuypCbjP1xsobY1X0CmqgzFfRhHD4QBHz9Jem90g7USCBm8bGQ4WImhwsR
	RYyuIOcyiHfbL06qLDCTY1IbH2UI3JP46TdUwjmoUf/0WKyJHVI+JBZCWicg6zky
	b2TcvdDWijws7Q6aP/eZJwWbs5EdTav1syYL1xwe3agNENaz8/0HxNuu6swA1aWM
	x525d2S4K7rUrVl23PjJFLYTCpazibVdIkpaIcOVRTm/pN9XRDdxNBTmB+qf7pU1
	SKFK7/xQSzNu9LcqL4uLq2XwB6APmY4SuBk7JqkptHlJk7NFlWacg5oMRcE5x+Z8
	dyGtKdwmhMD+O0607TTag==
X-ME-Sender: <xms:L6Z7amzJZparkqj840bT2KByPdEFMcgdrcNa3i876gd1hSQ_wXtLYA>
    <xme:L6Z7ahXGs0hE1w0lNEM1aHFbvXSUBRryx77IlmoAj3vdd-ushahgsEXI1b9Y2WDJZ
    QwI_AS6L501QGWDpeKlEKuPJDPX1rkZbeGmbf8YwjmzyVWTEVju>
X-ME-Received: <xmr:L6Z7aujyat3L86j06_W6jIfUfJFu1t8u2zb5VV-SAZa5Bc83tWfbd29KNJtejfjJl92dcnB-Jgjy4fvJV0pUxCQmuLdDaLVH8w>
X-ME-Proxy-Cause: dmFkZTGD/G/CJ1y8Q+/uLuCwGYrMkQHlTClcLrVVmuU9T3XD/ckYPx7NOObH5k60mBuCW6
    2OuIih6tK7tkK08omsAeXm5P0MkJI+r04kGG09XHbHPUtC90/hxUj+UMyXQZLuUZDBOUfc
    LR0Du4V2gf04VX46mBuy15TjzBxpbY6DMCi2hJ1ga+oT9yr7A8NXHR/VsxVyE/nYjLfx0q
    W7caMaz1S67arPQL+diqtGroNxrSmujWedHOkj9svp+joIQT5OSlaOiVfWzwkFWA+SCWrU
    wuO0qUrjevPzUo05P9z3qGrh6fBUMsC1RW/LxZQaKNhL05x5Z20uyJ3iG9qAo9kjZFMkmt
    ZiU7GI2igLM8TG8EzKDLyFxVk8e42v5X2eB0yrHhL+45OenT62jLmKlxU1651wKH2Tpe4i
    dizq8O9aE0zj061SA0XYA5/KP33kXEY47toMpmGdpKW75Z0Clg7/IY0NjRfCOWW5QjaGLf
    GkKvMd2Bo4ayQpHXkb2kpmNfvqKICJxxbODRcXhq4Kac+d/v+dtO/Kr5DXaYBpwARUdolS
    2Qv2e4vZho9O7AbHekrszQr7O6TTJsOPkfGBXujDog2el1ADaSKl+hukKUHwNVku64uTLF
    R/MVTXGN4HHxN1F2QRLE2L9pPKdqNyd9oohL8e3ZEESlza2sDQbKxrvazAUg
X-ME-Proxy: <xmx:L6Z7apD6ju9J4pYuqy1U94BFgJzD4Rwco-VClauAgtqmIpnMM9omvA>
    <xmx:L6Z7asud_Hki1FmSUzZlFL6-LIk8IiF7fefmpFGj1KcfwCQhwBmHeQ>
    <xmx:L6Z7alePL0i-d5MFJ_YblbPqNjFknrD7fkFmhueRlyI8jjptJCdpxA>
    <xmx:L6Z7ap-C_48TePcQsannLsX_cuE1r4t4Ndr4aCqVuyIGvxXQs681uA>
    <xmx:L6Z7apQF7mthJWybBAqGllJR2yPflGypZQybx1bK3pKS7icTb7oaRTcN>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Aug 2026 18:46:06 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc: Matthias =?utf-8?Q?A=C3=9Fhauer?= via GitGitGadget
 <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Marc Branchaud <marcnarc@xiplink.com>,
  =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,  Eric
 Sunshine <sunshine@sunshineco.com>,
  Matthias =?utf-8?Q?A=C3=9Fhauer?= <mha1993@live.de>
Subject: Re: [PATCH v1.5] worktree: Fix out of bounds read that causes data
 loss and reject invalid empty input in worktree add
In-Reply-To: <52ee6501-24ac-402b-b650-92a829030380@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
	message of "Tue, 11 Aug 2026 23:34:07 +0200")
References: <pull.2187.git.1784978348.gitgitgadget@gmail.com>
	<52ee6501-24ac-402b-b650-92a829030380@web.de>
Date: Tue, 11 Aug 2026 15:46:05 -0700
Message-ID: <xmqqwltwz36a.fsf@gitster.g>
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

> From: =?UTF-8?q?Matthias=20A=C3=9Fhauer?= <mha1993@live.de>
>
> `worktree_basename` tries to read from memory before the passed `path`
> string, if `path` is empty (or only consists of directory separators).
> That results in unexpected nonsense data being returned to the caller,
> which can lead to issues, such as `git worktree add ""` recursively
> deleting the current working directory, including `.git`.
>
> Stop reading out of bounds in these cases to avoid that behaviour.
>
> This leads to `git worktree add ""` consistently exiting with the
> message `BUG: How come '' becomes empty after sanitization?`, which is
> still undesirable, but at least it doesn't result in data loss anymore.
>
> This fixes https://github.com/git-for-windows/git/issues/6346
>
> Signed-off-by: René Scharfe <l.s.r@web.de>
> ---
> How about this while we're waiting for a reroll?  It implements what the
> commit message says, nothing more.  Follows the style of the first loop.

This one I think is obvious and clear.  Why not take the authorship
too so that we do not have to worry about DCO?

>
>  builtin/worktree.c | 8 +++-----
>  1 file changed, 3 insertions(+), 5 deletions(-)
>
> diff --git a/builtin/worktree.c b/builtin/worktree.c
> index 654d27c3e1..a770dd5ead 100644
> --- a/builtin/worktree.c
> +++ b/builtin/worktree.c
> @@ -303,11 +303,9 @@ static const char *worktree_basename(const char *path, int *olen)
>  	while (len && is_dir_sep(path[len - 1]))
>  		len--;
>  
> -	for (name = path + len - 1; name > path; name--)
> -		if (is_dir_sep(*name)) {
> -			name++;
> -			break;
> -		}
> +	name = path + len;
> +	while (name > path && !is_dir_sep(name[-1]))
> +		name--;
>  
>  	*olen = len;
>  	return name;
