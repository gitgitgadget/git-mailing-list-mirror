Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C771199930
	for <git@vger.kernel.org>; Mon, 30 Sep 2024 19:43:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727725432; cv=none; b=myyaH0Za3S9P6vvrrSfgfOLfUiABpSegdqCISHxKEAKJNUsWE5oYmP8RarsoheNeWcymmwKG7HqGI8yxKfMMNhr6UOOTEjQhH9F4+++bjHzk8nDolXTAzHQ5w3N5kXi//enVyoTefkLNMq6d9rBAdfGy7WC8xSgHi02EMu3NQyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727725432; c=relaxed/simple;
	bh=ZNnVWz0rEuFXzoP8Glp+uPo/Zw+e6cu+FIBiXKq5QfQ=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=H7+tuzdTfWuQpbDfoMNMz3dfkPQDl7ywy00msp4xgZzydodgL1W/5p1XdcZ9WrmtH/8+OcO3PYDY8g04hPHJVO+ca+nKI2dH+/hJizXH2LNqpk+0VQbhAOV5Ftkf3K31C8Sy8sq5FVVnBJlToWdbQGcgCcIBbafkT5EMVXETiww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=eMPCJwwH; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=MbFMlIHU; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="eMPCJwwH";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="MbFMlIHU"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 8701C1140231;
	Mon, 30 Sep 2024 15:43:49 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Mon, 30 Sep 2024 15:43:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1727725429; x=1727811829; bh=QlEGT14S1c
	/cJeMeXTw/yLs5NEC6Ra5lujD0mqc8lu0=; b=eMPCJwwHVGvtWwVqTWFi9tKy1C
	ZPs6H5V/Ij7GHhbuQ4TwhcdN+kBqOV4if8w5r36WnX/g3Lr7f21CikDAciaTOzH5
	dtoRaYgm2XoCCC2ybIJWnC1gAlCennObCuJEi9Mwa/QrYiIduBlxxtT1ot3q5ktB
	kDQYYInOu6igqPMmpxcMYGnjv9vUuWjLtn81lyCq9LG4mdkm1vgW/W6srJJuLcb4
	2DmR5Chinrz2O0mkSWC6wYVsyk9h/RjaWMMJiQMN6Yhbcs2Dbvz4IsXZSZjO7T/y
	zkJ3jJFxw/Q6peKSV51J+rUruVCHnKB4V7pD73YAP7l4xh+hsbJ8RdCNiU4A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm2; t=1727725429; x=1727811829; bh=QlEGT14S1c/cJeMeXTw/yLs5NEC6
	Ra5lujD0mqc8lu0=; b=MbFMlIHUMY4OAowNDgmPJkErRbvlY7OHTc9SErR+3HbA
	bhlLjn2LF9ZqUOvXbh/vKUPkyd6TdtXQwGQYSVI3dVBLsvHBVrF1Uj0F9JwrMOHL
	0BLBOQHFHE03CA9nqnPYMRUnGkBfIcxw4wCutFC8m6+ulmls0Ks1PK6j3cBg4aGb
	aGka9U3+glDbwju8jneavQxbaXSOXTrig59G2szyWUcwuvAcWKjElb+2IyhTiCnm
	VidfDTxJqxRnKZ+uQkror2tLF4XoCPL0Al6UabUuyTferN5r6L3YpdvKbUmw9Fik
	fK8jq7Pr2dqugz6NUA3IxOIf2AtTQPRlWvAArRlpMw==
X-ME-Sender: <xms:df_6ZrG4VzCnxONd4nOdVb_ZiIrV96TvitqYo1IbfNvBij_YsFE0Hw>
    <xme:df_6ZoXFam7HcKpNQImf8ZMpj0XFdo1nLal1wd9exbY90BaYoRNfCMpokh6fCW1WK
    GV5D1RnUgmCK_ir_g>
X-ME-Received: <xmr:df_6ZtLv51T1nka2bLb91uUdfbV0UPNZT4jgdfkwaxJbl6NjKZhVi8AvrWzGbc7Q1yqXf-meb9LEzrlrLdhPtD5w4zE76uEJe_9Rxzo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeftddrvdduhedgudegudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeeipdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtohepshhhvghjihgrlhhuohesghhmrghilhdrtghomhdprh
    gtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepjhhohhhntggrihekieesghhm
    rghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:df_6ZpE0s_7oVC3kmwAs-lM5LIsyvfsjQ-5N98UWR0piatI-WrmJ3g>
    <xmx:df_6ZhVsd-MLWNqV4aUuFl6i-jTP3iBXDDA2eI_dwJjaI-w9mUfk4w>
    <xmx:df_6ZkN_Nn_8F9Pj0N_uvtda-wXJZgsDQc2t001dC2y11dITGr528Q>
    <xmx:df_6Zg3z6_67MjzJP6mW7q8TSuYUqP4vMkWy5biNKW3x2BzBbd_Ihg>
    <xmx:df_6ZgG7VDFR8gjm88KE9EyzB8BhJ7a1CqJgzmbaMzdB2srUdmF91D_4>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 30 Sep 2024 15:43:48 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "John Cai via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  shejialuo <shejialuo@gmail.com>,  Patrick
 Steinhardt <ps@pks.im>,  John Cai <johncai86@gmail.com>
Subject: Re: [PATCH v2 2/4] annotate: remove usage of the_repository global
In-Reply-To: <2a29d113815015b82d807d94f8d551c3f885cb9c.1727718031.git.gitgitgadget@gmail.com>
	(John Cai via GitGitGadget's message of "Mon, 30 Sep 2024 17:40:28
	+0000")
References: <pull.1788.git.git.1727185364.gitgitgadget@gmail.com>
	<pull.1788.v2.git.git.1727718030.gitgitgadget@gmail.com>
	<2a29d113815015b82d807d94f8d551c3f885cb9c.1727718031.git.gitgitgadget@gmail.com>
Date: Mon, 30 Sep 2024 12:43:47 -0700
Message-ID: <xmqqa5fp53m4.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: John Cai <johncai86@gmail.com>
>
> Remove the the_repository with the repository argument that gets passed
> down through the builtin function.
>
> Signed-off-by: John Cai <johncai86@gmail.com>
> ---
>  builtin/annotate.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/builtin/annotate.c b/builtin/annotate.c
> index a99179fe4dd..ce3dfaafb28 100644
> --- a/builtin/annotate.c
> +++ b/builtin/annotate.c
> @@ -4,7 +4,6 @@
>   * Copyright (C) 2006 Ryan Anderson
>   */
>  
> -#define USE_THE_REPOSITORY_VARIABLE
>  #include "git-compat-util.h"
>  #include "builtin.h"
>  #include "strvec.h"
> @@ -12,7 +11,7 @@
>  int cmd_annotate(int argc,
>  		 const char **argv,
>  		 const char *prefix,
> -		 struct repository *repo UNUSED)
> +		 struct repository *repo)
>  {
>  	struct strvec args = STRVEC_INIT;
>  	int i;
> @@ -23,5 +22,5 @@ int cmd_annotate(int argc,
>  		strvec_push(&args, argv[i]);
>  	}
>  
> -	return cmd_blame(args.nr, args.v, prefix, the_repository);
> +	return cmd_blame(args.nr, args.v, prefix, repo);
>  }

This looks obviously correct.  Nicely done.
