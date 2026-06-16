Received: from fhigh-b4-smtp.messagingengine.com (fhigh-b4-smtp.messagingengine.com [202.12.124.155])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB6702F7EE5
	for <git@vger.kernel.org>; Tue, 16 Jun 2026 11:17:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.155
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781608652; cv=none; b=KFMAqUTV77g4WoNkzyhHwPD812gLY9YAukMpMmWgzJIg0BjNctLzqLzUlx8nZ+vch2W1aNs2PYTVjVfqcIfjcO/IGUwvcH4TGOAoFPXc/DmqkqBS52z25KYjF+Pi5ol1USOY0ihTisJV7gw45Uy6ib/v8UYuAdtaQCxlW34YRYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781608652; c=relaxed/simple;
	bh=Dhad148o25JZl1blII4RR1K4g+A9YnMqYJ/yAEdVFPU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mke/JJqjZxeSrraIutVSMI4/l1dWMd+aHcOrFYT4+YfyrTx8ghV1BtO8GPSPetsgTrj/AizMgkVAUwBE7RzhzFU9+GmqLrHCuzCMhQuIKil6Rj4YHKc0EKivIrfehkN6VvAcB6Uu83cE9P+Nr82SJZn9ApIj4TDA9sTTqd6MOgU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=TfrTso3S; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=dEpgPaR/; arc=none smtp.client-ip=202.12.124.155
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="TfrTso3S";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="dEpgPaR/"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id E90B17A01B5;
	Tue, 16 Jun 2026 07:17:29 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Tue, 16 Jun 2026 07:17:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1781608649; x=1781695049; bh=PdReQ8Il8K
	tu1hh1ASdokEHgJaftjGCLJ/ZY4uPT9zI=; b=TfrTso3SzhtrIlpriyoe6ITaqG
	KwpasEByTduo3MxffO2qQqkeprOuj20b5gv8sSx3z/dlEwfkcBWim/rgHxk/hizF
	xcai0hXG9nfuJuHKcQdXdMh7aTQYvaoDSWEbmdFosPLPo1dt5TgE6UQzjfNtOR3M
	OudR0jDgbZOTXJJ40sh7QQJEXAIXMEtXDp1/wfCaO/34uZ9pSIe4jRqVz/5Ou9mk
	ZutdZR0a3hd6dPHPmR4Qyne17mYDoTIKMfiWgMvEmZKo1axvCbfnJLUJUEcgaBYX
	2ipT7RLFRQj+M4wwnErlqKWqHkzkEQTGRDHn2inanI+ZiMdDOzFuxtFz+NjQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1781608649; x=1781695049; bh=PdReQ8Il8Ktu1hh1ASdokEHgJaftjGCLJ/Z
	Y4uPT9zI=; b=dEpgPaR/6dGaNhm7bUCkkaOXPBTIj9WuSfYl4mQ9fNfvSB9mFi8
	mtCKAoesag53kqPs+7VQQESvhsH74rTcnCWJUmjk2G5sNuPT30QfV8oPjFAYiFdS
	uT24lYECBNp+TphbSL8V5XvLNCAOuNsdnIhMLX/qHyd0+na6jEv+uzdht4cdpkqh
	S4gs1QYdeaHuanYynpxpnKEkLSElVSHnA/KRionrQx4dUqeCLjNCkTAoFMgnpI/N
	mRUUC5aRHfE64an8snxPYJWRZ/Pxoc10a58VMjwFivVv5OJxTDouqTk+rv5QtTQQ
	feDDTRs3Loeo4LoV0LJawZUQEBvi4Vg3iiQ==
X-ME-Sender: <xms:yTAxamJ9hpmKUyXTJgat1NlUakidZTtD34Zhc7HoBhmvuwQoK3vXeg>
    <xme:yTAxallmE3f72qeRoyMxCkVR4Y6FoUB2YRw_kAhsPKdA-WCNBDUCHj3xmTyBqvqVH
    x5L9d3EwgGq5okKpgW5tsde-gSGTSI8ghnO9Z2395PCT323e29zyQ>
X-ME-Received: <xmr:yTAxakGSwN2qQRjH0hFYtCUCx2QiQ7BqY-qI0H1vMSdDhj7coyucAKCM6EC1kRquOTWzjABSTooiF8OojJcypYU32LMYyk8zruuU>
X-ME-Proxy-Cause: dmFkZTE/E4tsC84U4bmJ3rHNEDKpJ/E490m6jvCIhReKFIUpltKj9OmRmRj5BRADlYTZMe
    LTkzeCEZqiWuIT0t+YSyMznox+yXMnZ3rL657jrWpRniq93FmO8WvgYQaefqJqA5E1ubTG
    52mX5Zak9fGoXZIZ+cSDwEXbOXH34L/zvrMoe8+9n1qPj2UqHQ/Eu0XpPl400nN7B4Lr/h
    W/2WqHUUeGdNX/O0j+LiiB6Y/h6zmImgZOZbDsSGcJhy4CrknSLx+nTaGw1jVoCA7H+PSw
    t+qVKjlY44U6zQtbUma5tGCM8UMn+HF2uIWcpKuX7Rf3ZW3TQMqn+xFpwQCqrullaKBMr2
    4gau7xkEHIN3Mo6SowqKmHJrnC73/x+mNI+yuL0IFRKZsQYDFqpUkQAb4CuFfDvFj/X2Px
    TUcy2/Fj2bYKXUrpNkyK+EWaxA9ypFGN8FM89ul76zN6QRANmWYbpIgVQh/O5bxbD7KnA8
    FFZ7CNzFoYCnz7DCDcUvwX+D9wrARGCdjGveHv9pmExitwH6LzrMIRv2ymCIoX5/CLHGD3
    Ctt1ojaQRnbv67WO0ESXUs+DGUJg0pgtZISPsL7H35hV+LGfzcWDo+8bF+US2zCLu7vfS/
    aqZ9r9VjZwirrg82rFpOtUp/+piKjppNehPDRH5iEENVfdBQYGrpylkgjjfg
X-ME-Proxy: <xmx:yTAxalEvG4mPWyZm_HYr7DQrtKvgEHcLktnumVfkuPFpf8xMeRrz_A>
    <xmx:yTAxahNnIxSuuD2cJoGvOT9XwSgHn9zMbin8CsQ7WKBrWg5n6eUtBQ>
    <xmx:yTAxakF2w-vBRCJkqi9-zdch--DuZ43m3dFK0s77rZFF0epCpBGpbA>
    <xmx:yTAxaoPJNs4WTI8ebyFGSdEDKaAW4ia0Y2t-S2Xjjj3Hg6EhOWALgA>
    <xmx:yTAxatv0ZSOfmKgEn2d2Z7Dg9ZUI_1xNTSTDlzwgLZZIws-mOOfPZMtM>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Jun 2026 07:17:29 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Subject: Re: [PATCH 3/4] builtin/refs: add "update" subcommand
In-Reply-To: <20260616-pks-refs-writing-subcommands-v1-3-9f5219b6109d@pks.im>
	(Patrick Steinhardt's message of "Tue, 16 Jun 2026 10:44:08 +0200")
References: <20260616-pks-refs-writing-subcommands-v1-0-9f5219b6109d@pks.im>
	<20260616-pks-refs-writing-subcommands-v1-3-9f5219b6109d@pks.im>
Date: Tue, 16 Jun 2026 04:17:27 -0700
Message-ID: <xmqqeci6bupk.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Patrick Steinhardt <ps@pks.im> writes:

> Add a new "update" subcommand which mirrors `git update-ref <refname>
> <oldoid> <newoid>`. This follows the same reasoning as the preceding
> commit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  Documentation/git-refs.adoc |   7 ++
>  builtin/refs.c              |  50 +++++++++++++
>  t/meson.build               |   1 +
>  t/t1465-refs-update.sh      | 179 ++++++++++++++++++++++++++++++++++++++++++++
>  4 files changed, 237 insertions(+)

I do not offhand know (and I am still away by 2 hours from the time
I wake up and start functioning) if update-ref shares the same
issue, but with "delete, update, rename" combo, lack of "create"
feels a bit annoying.  Wouldn't we want to offer an option to users
who want to ensure that the refs they create are truly new and they
are not overwriting a ref somebody has created?  Either (1) drop
"delete" and take a special value (e.g. "") as <newvalue> to signal
deletion and make the same special value used as <oldvalue> signals
creation, or (2) add "create" and insist that "update" takes only an
existing ref, would make the annoyance go away, I guess.

> +test_expect_success 'update creates a new reference' '
> +	test_when_finished "rm -rf repo" &&
> +	setup_repo repo &&
> +	(
> +		cd repo &&
> +		A=$(git rev-parse A) &&
> +		git refs update refs/heads/foo $A &&
> +		test_ref_matches refs/heads/foo "$A"
> +	)
> +'

Here we cannot test (and I strongly suspect that "git refs update"
and "git update-ref" lack ability to do so) a case where a creation
is attempted on an existing ref and fails.
