Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 534B631A572
	for <git@vger.kernel.org>; Mon, 13 Jul 2026 16:39:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783960790; cv=none; b=UpG2OKxIwl52MEhoTYHstjRL87rdlZo5X9Rput34QJKyUVMwg4NaA73E1j9jmjVDOg1g/emM85Rovac88CyOrg2rqRSES8faW8sn+e5hijM54th+Nr28R2hXO1OaOTpvqsnNKK21BPlSRmDTfiVn7Zj2L69iNotuJhyj3XhMznQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783960790; c=relaxed/simple;
	bh=5dD+Ncg3fI60Wv6RQeI/mNCFdTNW6XniT8QUdrFIQeM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=JWv4nLZo1JhFKbtkxp+1cVCDWLdVdBltr69ZA8iHORu6eXOmEQL9t94NRH/Ti+SZOHmVyPO5UDrY0/kUdmtmwrbxvqoy34YyTFMf5vOdTU4yQ+I5wGaRY1tMe1FoCQCN9KDOx0GY3LIopEf+GVdegECI7EDWSq6wwn1Po4tclFU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=dHkId5No; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Xm707ooI; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="dHkId5No";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Xm707ooI"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id 5F0DAEC02CF;
	Mon, 13 Jul 2026 12:39:48 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Mon, 13 Jul 2026 12:39:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1783960788; x=1784047188; bh=2pjA2ZZWnp
	hMxHzmvyNnvL8PNcsM436Lqto5nJbyfuA=; b=dHkId5NoDYOpUpMftlALyVs2q0
	ncrQK8Rtf21Yk8Pva3Fis0kMis/UqBKdCmZZp4ZSJS1qH0ohJLMVRFJYvBOoCSdo
	CTiUZYhjIJP1byEj8NTxR8I9nE8b33kVRBFNTlUR3XS0wu34bkCgGrTlhKtT9TvB
	Nc240HYRoKtCG1VpfvHcPpJLWygKi9990V0mGEsC4oDFyLpmIfQy10wbfnZUjRDH
	LmQ3T9mxt+kciiia6NMgSTkxjb+Ls9qAS79QZTtSH5cwEBM2T9n1cloqx/OzLWid
	XN0ggIh8+V5gqvb4/Hv4SfpEKRLof0/vl2I3fmZjLakudWQ0Lmnx/9M3+3FA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1783960788; x=1784047188; bh=2pjA2ZZWnphMxHzmvyNnvL8PNcsM436Lqto
	5nJbyfuA=; b=Xm707ooI0YAsG6OenftHGTJPg9mLgs0avdT/BX9IEF1DPNYG1vU
	JoMhtpeyc9Qeq9czSG3Kziqtbj5ngO7RraIskWS/d4PweEfowaWrY1H23FkTWyIq
	PpConBeWZDEl0eIu6P8LJ/GyC4nEfo3Sbw9+uRMgUb0N27Hv7QuALWurD+UMw5KL
	hmMhUqewpo5+jn0XRm3QOAVZwK+JbNNjHQ+hsg6QOQ2yRf7av3j2mzYmaeVveQvq
	4fBXF5l/D0osmZLMf6G76qWWr843d8TNSTLp31/9/642ZC2vNCHMPEiJsub9tE3G
	0nJrF7t7a7v0GHoG6WiJYXJMp/pSYBTHjmg==
X-ME-Sender: <xms:1BRVakExPwk5GAqu_PkqziUecbmiVcHCSJkkmcyrLpjWrHjMzMdXKg>
    <xme:1BRVav4-yK7amNvpUfS0JWa-i6ngPqNGLUjJMsJJdG5TbDLrtJ3kTaUVGKsWL3aZI
    c9qwg_BSNhuxj911hwQPcbVmZ8b6v2eCtlLRsAia5_uT_4taHJtMg>
X-ME-Received: <xmr:1BRVahzbIDHw7D4Osj9eHo1QIS7jk-YB86fpM_bGf3dnM2FohAS4Dy8MNRw9gdCsMOCo4OCMxIdcemcD4zIbBSMyv7VkCEP7Ywtsnhk>
X-ME-Proxy-Cause: dmFkZTEvW8Utf0RCtDmmLS73arfXWp21xNekA85b964ZvdzPO6rnYnYz7pVqQby1fZuvJu
    puJW60rKD2T0KXYdUOdH4jQrDpaeiJQgLcyNzxn9Kqbc9jLn+yzlFTl5s+E5M7rWcW3uIn
    PbQoFfI53I0Ir+LzpXHtXiQgWCnhsPnr9s7Gj4CUooLuy1/SXMvowrZikwPdVbFMVd4WNr
    h1erWK2dr4GbqXOSeAY/e3Gq7JafA2lComf2I++fJ4nehLVXTMhoKSEFd5EDOQLF6wx33W
    chF6Ry8KiKKJ2x7mAjbmy3VgQjGriL6USZTBst14oEk+dMUR3LN34KN9hLlZMe4tStIwMQ
    pRDxa1BIUSkd/BLfIqxBwSoCNgXb8eLb9n+87vIJmxjOt+jCbNNZX3AwlkQne3NBNPTXdP
    T8aJGtBHeyNKYisU/elnnPyFBY25JJ2qh5LxqI6LbsCGnkqQYsO9BFUAwzd8eJlAYtu12A
    xp74FhdNcttdvjqlRPvYU6H2Fseox+j/84kU6oMhHhkfIW3gMI1RdbiqxVcy79022wPH1M
    oG7C3YZPdqhmIYpDyUB81vZrycmZ6OYXFZKNfGAi+nBwMmt8j2OcfxJRO5EPTA9rSB/rhQ
    9JrwvZGkjNOSEV3a95H8D5yKlwk1Epg5S+jM393AnY9Xa/UkZLk4Wjktwp1w
X-ME-Proxy: <xmx:1BRVamMoNcMVF8uZFCA3DXn8ZkWJhNrzjPyW9s4Vr6rTtNXmr8cTPg>
    <xmx:1BRVavlTr3bzXxIUb1C4uDRbKzsC-fptMrWgMeJZMtCYegF49L0qbA>
    <xmx:1BRVajQtRncd2E72KF-VWD6gcj7x3ZDOFJqv5R-9tWBl54dxehgamg>
    <xmx:1BRVamXzdGLcHj6cDRPzXG38nyX6xJpur8pRpyEz3bFrqQ_FI0XRng>
    <xmx:1BRVare9YhJy6q3_9uS2EzjjYJNAy75ik2qA5hKWTM2zc4562V0ndOwS>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 13 Jul 2026 12:39:47 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Tian Yuchen <cat@malon.dev>
Cc: git@vger.kernel.org,  pabloosabaterr@gmail.com,  cirnovskyv@gmail.com,
  szeder.dev@gmail.com,  Christian Couder <christian.couder@gmail.com>,
  Ayush Chandekar <ayu.chandekar@gmail.com>,  Olamide Caleb Bello
 <belkid98@gmail.com>
Subject: Re: [PATCH v11 06/10] environment: migrate apply_default_whitespace
 and apply_default_ignorewhitespace
In-Reply-To: <20260713035738.1606138-7-cat@malon.dev> (Tian Yuchen's message
	of "Mon, 13 Jul 2026 11:57:34 +0800")
References: <20260712111734.1073514-1-cat@malon.dev>
	<20260713035738.1606138-1-cat@malon.dev>
	<20260713035738.1606138-7-cat@malon.dev>
Date: Mon, 13 Jul 2026 09:39:46 -0700
Message-ID: <xmqqa4ruyhbh.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Tian Yuchen <cat@malon.dev> writes:

> Subject: Re: [PATCH v11 06/10] environment: migrate apply_default_whitespace and apply_default_ignorewhitespace

Are there patches 7..10/10 posted somewhere else?  I didn't see them
in the thread (neither did "b4").

>  
> -static void git_apply_config(void)
> +static void git_apply_config(struct repository *repo)
>  {
> -	repo_config_get_string(the_repository, "apply.whitespace", &apply_default_whitespace);
> -	repo_config_get_string(the_repository, "apply.ignorewhitespace", &apply_default_ignorewhitespace);
> -	repo_config(the_repository, git_xmerge_config, NULL);
> +	struct repo_config_values *cfg = repo_config_values(repo);
> +
> +	FREE_AND_NULL(cfg->apply_default_whitespace);
> +	repo_config_get_string(repo, "apply.whitespace",
> +			       &cfg->apply_default_whitespace);
> +	FREE_AND_NULL(cfg->apply_default_ignorewhitespace);
> +	repo_config_get_string(repo, "apply.ignorewhitespace",
> +			       &cfg->apply_default_ignorewhitespace);
> +	repo_config(repo, git_xmerge_config, NULL);
>  }

OK.

>  static int parse_whitespace_option(struct apply_state *state, const char *option)
> @@ -126,10 +132,15 @@ int init_apply_state(struct apply_state *state,
>  	strset_init(&state->kept_symlinks);
>  	strbuf_init(&state->root, 0);
>  
> -	git_apply_config();
> -	if (apply_default_whitespace && parse_whitespace_option(state, apply_default_whitespace))
> +	git_apply_config(repo);
> +
> +	struct repo_config_values *cfg = repo_config_values(repo);

Doesn't "-Wdeclaration-after-statement" complain on this, declaring cfg
after calling "git_apply_config(repo)" on the line before?

