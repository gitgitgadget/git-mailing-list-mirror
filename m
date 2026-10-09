Received: from fout-b8-smtp.messagingengine.com (fout-b8-smtp.messagingengine.com [202.12.124.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 936D7502D47
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 18:24:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791570255; cv=none; b=ZuHb0pZZBHPqiHzSPKZGH81NMxZwbONjo8EcToTMMirizay82IT+1rzki4cSB0JSeYnjyzp+oQPu1N9oH4GoRe6LLLmgMxIZBugioz+OT6j2qHR8+HmlSJPBLig4Wmml3dW+lMuQycba8UtfsfF8zw26mZJG6+7w4zcyHpmV4VU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791570255; c=relaxed/simple;
	bh=ru4f4MiaASodPR6Oi7NUh5ZnfLqW3pF0SQEeW+p6sKg=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qSR/JtcNj0+OciLYrxoJebx+VS47FCJdOgUlb82k4861gj1k00kgEhiLfrCihfxBovKPo45aKNAePrOSteG5Y5SpB+DijHQp3q2nC0pS3ViT66T/awtR0q49BrtRsHcPjO38X8EAnOwPZa/o47NkYieSVxv4A8QYvNN2E+E1dSY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=qDjmUrdX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=h6QbRmGB; arc=none smtp.client-ip=202.12.124.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="qDjmUrdX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="h6QbRmGB"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 68F231D000E3
	for <git@vger.kernel.org>; Fri,  9 Oct 2026 14:24:11 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 09 Oct 2026 14:24:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791570251; x=1791656651; bh=mskFxY615Z
	JJU2QCQVpWaBaQWlLgwzhZW3GHQlztzDU=; b=qDjmUrdXUvWmbfOmfD3JXFL4iA
	xH0Pys35eS6YM+zDZuuAbFO1dLm7Ynh2cOJXiKwzP3YwYottrWPGhd1vp3M+nVXt
	w3qY8OkU0QoHK9e8BX5p4hhIHhTNaJ4K9iMnX9jCU0wpYpFsMLk6mL53a2CtALvr
	9ynYdSqPnzpAFlMIR2QBLOiWPgS0cR2RRUKPEbYlflmWz+uIi6lWlPLUFKdvwmhC
	32MFFK1tjBtv/2YFvUs32AkRaD+GpOq6qXXs+gfe36PtQlPS7jDKrOLBdWEipBnH
	SjfO+vnzl3hVLihsjbAzMcqjC67PbFtHi0WxBDSCXvzIEkYvhbexHqeRksuw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791570251; x=1791656651; bh=mskFxY615ZJJU2QCQVpWaBaQWlLgwzhZW3G
	HQlztzDU=; b=h6QbRmGBI4JtPFUx83zFTIjkixD+QQXp0+prbpDach99VEwV363
	I+ohjFvCUMmZ/Kt9y5wX++CBc0U7ZbAnJ8E0ZSVXhiXGPXv4tdoBWwv48r/dKCqW
	F+EAYRRZQXe9g5/lkRYOOzCrggO2QunR9aRnq7u55G7B3W+ozNqLw7oYS8TFIMzm
	S4EJH6ok0wM7qh9rbrdSEkBCdr5b/ZfMfe/EY1KBrdg5NNHPgm5PLvzrCO/D1xC6
	19/ie+44ty2mtSE5SYFTqttOVgysf33AVX5753cxgDViaXX+0Q0zrrVSDbk1KlZD
	5LIkcHXz3GNXbux5HLCSjK0z3c7WD1VhovQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791570251; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:f6OGK14IVfMIvHF25K2yKZ+lVdX+PwAUj0JduYztmYU8ifo
	t7CyQLCVr7Tr5cGR8O6ozSaONnWLv2RI81ICEhnceno9qfHek/ucGwkjbfUg8YOb
	IKJAQlKqw98cGfK46SXhkgXOiotQC9NfFZ5zNB5KZFAimMqUlBpr1+iLFWhE02Kk
	cuAFZ2Aukdskzz5Z1NfvkjUxXCMWB2KdQoxTLaps+ij+51d6oxXzfrkBMmk1Gsd5
	9NdVdEKGqJ7INNXChviErC8UMYEROWtZ7g/tZND5hvDpKhRLESxAAqzetw5lIFs/
	YvMI++wussBC7iFmEZGMnNm3+aJr3r8laqt75KQ==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:alDaQVw+z3xe/XjRKWX8nijxBw2YAAslrcQLuY5WJsY=:ru4f4MiaASodPR6Oi7NUh5ZnfLqW3pF0SQEeW+p6sKg=;
X-ME-Sender: <xms:SjHJavJspR7CJsldeR-kVGMl0dHKwU2c4Gn3_fHR3o3bhyH9aQUY7g>
    <xme:SjHJagurrOKg26lBv-2qoLYfRGopQnUTQogCoPQ6Tibd8sfasvz6_VkG91LOHoSXz
    kntu3DjTP_dibwQXo_6dChBG4wsmOLMuAjd9AL20yLzjRy9BynS6A>
X-ME-Received: <xmr:SjHJauIjBGyKf-ppq2BSt-Oxtw73V9K7prEFDrsW2AVjm7S06U_9W6oqJ2-2Tpvjdr5uXNq_FmzSwQd6YZUTs6famBT3ocDzwOC->
X-ME-Proxy-Cause: dmFkZTGBVY4n3G8KuOAKFis8co+J1dhOUEsK+IA/HMm0apNN0OR1pulSwND8MKZ7liXRk3
    L2PAiF48nhDZiGquG2ZMwAbz26Cvq5Q7+TtfvCxyIGwgb9mxtrgVleaaYVvZoZYz20vVt8
    O4b4xTz19VmHcOxPKHtBGb8H5RcFYPahSS9YSmSAjOgNa8qATs4XwrhDgd1yfvM5MgkMw/
    iJjRL9XkAAceRBLYrPxy0MQLOsrCTkwR0bTMbH10htskrRwzpFt88MzAiAkrGKvNH4TaqW
    wUbhPLMPUzSCIQWWMqM7f+kSMWT7nPvr4RH45LBJCzm7hLrJwEotSgSZiKdIoCg+J8KMNu
    b9dvNFCgUmccuhYT4EZklFoWjcSWRXVYPVS06lSLZdVA/a5o68OtSTWJ9tdOkauUOYfsyv
    18SexK7eykBy07/1eL/sgMQ7RMqP2yTlUE1fovMZsTmffivrhyeVdO1rr7+W4zzprfAKX/
    sRVH74DciZXsayxW71pmGNCzxmedmUAjn/cwkvqpPeedgTXE5is7Ig4K1WU1l1ONqyhjjr
    OqJ8Im5R7pCWBL4Pxj6esXV/9Z/jWJodbqz0WtQxo3Am27AGYr7ZYkqzIyfpqZ7opwEsos
    gUNbe2E4taphHQobrsR8XwNk5oZhFS8EoPIHE8Fm+B5i/EriTtjyyi2dG2ug
X-ME-Proxy: <xmx:SzHJap8nDQ5GFYCOZMfpRNx4N6Z5_ArWxcNZ3pLu41Of0YktHqAf0g>
    <xmx:SzHJanwYFIhvWeoxFo4dvu97N8kmfmMc30Fn6R4O1j5S2QHNetq-jg>
    <xmx:SzHJam4wuIycxOScPazg7RSxtN_Z7JW8xHpnj-jtOdLMEP7RwbGXFw>
    <xmx:SzHJau9twP3Q2WEw__ASWpClZOVA7cTYmhRbpY87BAP18PQTmORtCg>
    <xmx:SzHJaoF0tMHz-wv9Soqu410QBKGRAu0XHTgV2NQwm7SubvviGID0QUad>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Oct 2026 14:24:10 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Jeff King <peff@peff.net>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v2 4/6] doc: git-revert: link to new merge conflicts guide
In-Reply-To: <cfa0a8254ad88aa954af9cc3c4151993e07fe91c.1791547213.git.gitgitgadget@gmail.com>
	(Julia Evans via GitGitGadget's message of "Fri, 09 Oct 2026 12:00:11
	+0000")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v2.git.1791547213.gitgitgadget@gmail.com>
	<cfa0a8254ad88aa954af9cc3c4151993e07fe91c.1791547213.git.gitgitgadget@gmail.com>
Date: Fri, 09 Oct 2026 11:24:09 -0700
Message-ID: <xmqqwlrqpwae.fsf@gitster.g>
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
>  Documentation/git-revert.adoc | 5 +++++
>  1 file changed, 5 insertions(+)
>
> diff --git a/Documentation/git-revert.adoc b/Documentation/git-revert.adoc
> index ffba365e63..1edf98b9aa 100644
> --- a/Documentation/git-revert.adoc
> +++ b/Documentation/git-revert.adoc
> @@ -31,6 +31,10 @@ both will discard uncommitted changes in your working directory.
>  See "Reset, restore and revert" in linkgit:git[1] for the differences
>  between the three commands.
>  
> +If there have been new commits since the reverted commit, there may
> +be a merge conflict. See linkgit:gitmergeconflicts[7]
> +(or `git help mergeconflicts`) for a guide to handling merge conflicts.
> +

This is a strange thing to say.  Is it worth special casing the
revert of the tip commit that much?  "Reverting a commit may resolt
in a merge conflict" should be sufficient, I would think.



>  OPTIONS
>  -------
>  <commit>...::
> @@ -162,6 +166,7 @@ include::config/revert.adoc[]
>  SEE ALSO
>  --------
>  linkgit:git-cherry-pick[1]
> +linkgit:gitmergeconflicts[7]
>  
>  GIT
>  ---
