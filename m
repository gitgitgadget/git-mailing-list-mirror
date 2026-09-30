Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FFC74749C1
	for <git@vger.kernel.org>; Wed, 30 Sep 2026 21:33:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804001; cv=none; b=bc3kkvuEFN1z1vXjtcKnnh9JQmBfB6/LhGrSliVnCYykaVwZLbenTYnZnSmAAKRCnWMslLjO6WeVeGeKU+4/2wuq70Mjku6JYKyy9Us9ELLywjneQkoEnQ8AYg+ypPG/0Z65K2cknoDQlGk2wXE0Vqli7Ld8HEd+vLP9bx2wfNc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804001; c=relaxed/simple;
	bh=SwWuDZeGQWFy6ypYUjSh1TzjxrzRY7Wq6T1RK1sGR14=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=VdQFcOwXWHP3NKzMJPr+raL0DfnvGXi2Fhc8T4IvEeNGy5hNpBUYLFPBup4jeR3Qdb60WaPn/IK2SUWb6/mNpXFkAn/y2M1Ppn2yTXd6vRwlSNV2oK9ChgZu9Aw8f0SH1V4pPKTsHAi3OXMqoNXt2Xc0cAg91Q5YrjagwN8Lp8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=B+aU+bFj; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=wMlnnAXg; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="B+aU+bFj";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="wMlnnAXg"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 28B35EC0171;
	Wed, 30 Sep 2026 17:33:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Wed, 30 Sep 2026 17:33:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1790803998; x=1790890398; bh=EaVREcw20v
	CmtfME1ROzp8bRIrDccTf70vdsaP5HP9M=; b=B+aU+bFjogxSqNV53gMikYnsU/
	HEN4VpfUT79JwEe7/uhjKu30OlXjHsItMC0PC63MGplclhydTofZIek4AIsVte6q
	1bEjBH4RzU/jIbX8IhxCAzYzie4ZHWg22GbzpgvMH3BGV5t6D2IDE3dc7GOrOFf+
	pqWZNpWHkbN8kwNK5/nAMrg1nCepXgtqPkEo48uJ762ygQEEO+ZS/3nam9Jsbv1n
	rq3ON6Rb51xAIFq9FvqG09FjzOKyw9UcLd8uKVPyJLGgscjPFNae8QOt9d8e6lis
	cLgDPnaJxQJz7LqJnA0cydYUN6u6nmXrHWXPkEEX90lis1IfQfpkizpafWIA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1790803998; x=1790890398; bh=EaVREcw20vCmtfME1ROzp8bRIrDccTf70vd
	saP5HP9M=; b=wMlnnAXg8KSpzu7I7V4z6x1/RrHA5KEoVK09WDIHTt/sVbfLV27
	iBsB/m/l9hz3UqaTpNIOEAx/s7U99D83CpvZo/LBNNJpF9+KRo4tPG5OBn0aIFTe
	7dKMjz0YeGAfbRZgdwrDVmcn2Po2YJM+YweCZW68z+lp4+3/dgmden5ShEWYgLob
	Qo2sBaAam6Ll+zEoilDsdjF2cTx+rnuC7KRB5NuDLHy3z3VSdb/KNHeT8YrA3qsR
	GqibzOox5r9PURVQ01wHk8qlW40uD5OmoPEB6oRmyb5kwrq6L+9Jb42y/H/GsGz0
	bqvuFZUSZpAr9mOJTe9vgLirPIBsGOtfaGw==
X-ME-Sender: <xms:HoC9ah_WzuPkIYIwdj7cAbXhhpbIaNqcQwGChn22mVh-qPK54y3EWw>
    <xme:HoC9asvFM319VKixovPNsDhbLtGvCKdz-QEdfkR0scM-99gLonpw-JunskILhBptf
    CfVfPlAizB8eZqscDYTRsqZqxkasTvxkYCE2m04yYSEyL4ZmUEru_Q>
X-ME-Received: <xmr:HoC9akCnzaHbX9GEaZsPCG47XBOUdmCqHEx60nJjg2xaCvkm4Qy0NTCRE-PsbZDz3Vmk4plSUrlUlg_ONjug6HJp-DxjdMhmceMS>
X-ME-Proxy-Cause: dmFkZTFctpe3FmXdW12BOWhgfm1FWTfGooq7UbriOSHU9+NfxtFNLwetUOCyCT17W0+On1
    ZPC8dXinh1wvc/7U4N3xLaHpFFwX0+cSw8avyvvr+wKhPzUqqYgnfG6bUlsNCwLD/kVTuX
    y9qbJpVf3usw9DRLoaCo80dHBa4Z/6h6Q9r03u3HPFR3or8i06WdO9JDVR7sZKABzLcqPz
    5lN41ExIV96GWEXstq7KW3Iz3ySNqPosvbB2nzjLwsKTiCGhQllGZN06uTyNAPB5TXq4uV
    538F8tiuEqMZovDzrG9W2dKnSG7lwzUjjE0CsrrJ6vN9otB/A85C1NH8AtZgHZMkSZMJiY
    hS+loCsvn1HD3JAk2BE/O3wBtB3hAkcVjnyK+b293/+b1rcpOOXR4wFqJ4giWPnBvSKAYs
    lCzuOuXJmqbY2ZDfvmahBIGRIdCYZ1dne5SqR96D6wYBFeqwQ4MF9MaZg1ZSvcmhnfd1wG
    Trpk88PXfpVxp0EjeGyVDApaoAvD6oeCtop2zCoC7FaxF1Ws5gagOnwyKkY0vXgJr8eSE5
    m15E0Ezto05rZDyWw2XSX0lnyWpsEUVWNcXuqcYNjw6lu/bxB87qcqTyNZDCLzPjO7LEBj
    y7EwFiMZ8OpTR3dSJZL4bM7hwZI7J1O0HpmSAG+pkfo/s/esa0feEgFJkkow
X-ME-Proxy: <xmx:HoC9akXE8zAA_tsPg1QbHqj7K-ymOjecOtUBYnrcCgn5wKRqsXeZiQ>
    <xmx:HoC9aiDF_UwLWGBZj6BHVRKa0TORA96B7SMros5Cj2t8eqJEHm590Q>
    <xmx:HoC9an_8PY86W1mYICJ_QndaQ-_rRLmp3cvrXEIBprgxb3d8QhZPJQ>
    <xmx:HoC9apGvPR22dZlAtfHcKWAe7t3N6O5SXHkcleCozOTUyXpQNmEdsw>
    <xmx:HoC9anhdEniE76l2Zu3b9blqX3_W226pDySr3hQpDynFQn9NWHMQBYJe>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 30 Sep 2026 17:33:17 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Harald Nordgren <haraldnordgren@gmail.com>
Subject: Re: [PATCH] stash: allow custom conflict labels for pop
In-Reply-To: <pull.2430.git.git.1790801929375.gitgitgadget@gmail.com> (Harald
	Nordgren via GitGitGadget's message of "Wed, 30 Sep 2026 20:58:49
	+0000")
References: <pull.2430.git.git.1790801929375.gitgitgadget@gmail.com>
Date: Wed, 30 Sep 2026 14:33:16 -0700
Message-ID: <xmqqfqyq8lwj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Harald Nordgren via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Since 13817db274 (stash: add --label-ours, --label-theirs, --label-base
> for apply, 2026-04-28), "git stash apply" accepts custom labels for
> conflict markers, but "git stash pop" does not, although it applies the
> entry the same way and only differs by dropping it afterward. A caller
> that wants its own labels has to use apply and drop the entry itself.
>
> Teach "git stash pop" the same three options.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>
> ---
>     stash: allow custom conflict labels for pop
>     
>     git stash pop now accepts the conflict label options that git stash
>     apply gained in 2.55.

This is not a new problem, but is it just me who finds this
"feature" more about "because we can do it", not "because we need to
have it"?  Stepping back a bit, why did we add these three options
to "stash apply" in the first place?

If there is no good use case, perhaps what we should be doing is to
remove from "git stash apply" these three options, not adding the
same to another command.

I know that the underlying machinery to allow different labels were
invented for "checkout" that automatically stashes and then pops
while switching branches, and the "checkout" command wanted to use
labels that are different from what "git stash pop/apply" uses.  So
I would not question that there is a very good use case for the
underlying machinery to allow us to use different labels.

But was it really helpful and necessary, beyond "Having the feature
exposed to lower level component command like 'stash apply' makes it
slightly easier to debug", to add these three options to the "git
stash apply" command in the first place?  Who in their right mind
would type

    $ git stash pop --label-base=B --label-ours=O --label-theirs=T

every time they unstash a saved change?

Maybe I am not seeing an obvious use case, but I would blame the
lack of justification in the proposed log message for that.  And "We
can add the same three options" is not it.  "A caller that wants its
own labels has to..." is not it either.  Why does that caller want
such a strange thing?  What we have in the proposed log message is
exactly "because we can" and not "because we need them in order to
do X".

