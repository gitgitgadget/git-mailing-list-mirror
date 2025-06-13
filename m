Received: from fhigh-a7-smtp.messagingengine.com (fhigh-a7-smtp.messagingengine.com [103.168.172.158])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D41E24677D
	for <git@vger.kernel.org>; Fri, 13 Jun 2025 20:37:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.158
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749847069; cv=none; b=alRVMonYjdE+BsLT/P7SxPEU2ZIwciv4JTX9Y26ktoFbYK6zLcbtlo0eEUSEWz/LV1PNCXnStjLEEzX5hIQkMTS0A8GXEw3NhPQtqe33IRrzf+/4VTNEU40eVIUtSeLpQN/yuDHO5EmP2yf/O0Pp2dgrOZx9lLeUImDUgbmbSNM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749847069; c=relaxed/simple;
	bh=VCfAWglBsxSgjri+a3PrnQaWAZe9a6ct6HxvnPJKkKA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=mhHi4mhahq5GNMf1LYghhDSakvK6di/xkFy7Jh0f3FUMFf/dCXrooqUufEdkGcynHUX5n6lAkRsUjgM6r+6L1rKKORltb888rvQMwePDpC8BGVrj4bTUeSW5UrUof7A2OnfG6SsaDeMQ+X5q2dpWt0acH3shMrti82pRJvunx8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Eaml1czt; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k0vYyDaQ; arc=none smtp.client-ip=103.168.172.158
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Eaml1czt";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k0vYyDaQ"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 2095B1140151;
	Fri, 13 Jun 2025 16:37:44 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 13 Jun 2025 16:37:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1749847064; x=1749933464; bh=ou/oFXqWgC
	nTXafU9+zc927vEdbxUxGLVvgSXwlyz8g=; b=Eaml1cztaiDFufo5Lw9Fu9BuAu
	t9WS9uo0kh/T+GSZnIbn/YVFROhWyAlyWj4svH82da7Bli0+MGy0v2BYnwD+9M5o
	IWhk6HHiKNJzq63tlRKBvRDtDPYMrbAYyKg2itERouvX7zTQtBaM1DKVAJdHka1S
	n4az9UED/e2vJPJQpXJuQ3QxexLFZxflY1DSEZ8rTVWnR1+UMbPV7LNmk2M7fdUA
	NaTNai9Dzi+VU9az/5RHYISf12Ku8J/ex95Bb5yUEMOs+pyV/x7eFhLh/N85/cHr
	Unejst3rEWuRwZAlTDXPMHoMWJI3yQ5dsKId/wKdS9qBUnPPxzRjuyqSdNLw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1749847064; x=1749933464; bh=ou/oFXqWgCnTXafU9+zc927vEdbxUxGLVvg
	SXwlyz8g=; b=k0vYyDaQY1c7yBhrLvSpnUZqIhTyFEDTDifeOIzC84rni/DIarK
	0CEn69kitNHCmJ8oQeqn+cs5Uj4giR4UgAf3RGSn5bvTvtHQEHCWYe22nFSLFM2x
	wFtyExkqJ7X/+GKTldKIYz2fv8h39SffVnK9NpxEp2EfqEafRLfRGRbNUFejgqJl
	lbMH4SHX0lrX/MDZwPdc7O+2Nf7bL/LGIfzxfzlkA23YCvtSiosyD/9iWgKeNpcp
	exGfYKi9gtmS7ExGFRnM5lU8+AVhAP6NcgO5ml+KY3OY2GDkLtS3nd6H0nRbFbci
	crXg0+GAaupct6kyKJRFnu50DEK8igsChTA==
X-ME-Sender: <xms:F4xMaF32p2q4E54UQFXfbeyftAExhvfFhZ59NKzrqXFu0aML3wh3XQ>
    <xme:F4xMaMGPjVyf3AWEW0t3NAOx0CHcwQcP7atQFWYeQ9c6CZSi9RJdPq5bZ-KoK5Tk5
    11xEdUgYLQglyAk7w>
X-ME-Received: <xmr:F4xMaF7zuXJXc6_0Gtwst-v2f4M3qQTaX6tPwQssWVmq5gyJ-kgPQb-6R5I4dvWlpULhMJxSd49es2cT4m-M7b5NJarMe7vidGd->
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddugddukeelvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdp
    uffrtefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivg
    hnthhsucdlqddutddtmdenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertddtredt
    necuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsoh
    igrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeiveffueef
    jeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecurfgrrh
    grmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgt
    phhtthhopeehpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtghhithhgrg
    gughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhn
    vghlrdhorhhgpdhrtghpthhtoheprghlvgigghhuohdutddvfeesghhmrghilhdrtghomh
    dprhgtphhtthhopehguhhokeegieesphhurhguuhgvrdgvughupdhrtghpthhtohepghhi
    thhsthgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:F4xMaC1_Xg00TfexY0euw0iNqO-2LdpVXK20qCfL52313fA2cHhcEQ>
    <xmx:F4xMaIFYPheBRHQOdIvYo8JB_LGvGPyJ5raQLO3HhqvLlzQh_bAkTg>
    <xmx:F4xMaD8x4t4v8Fg5JtpLW3Uxl2b0lb-ykOtUJlAFxt328tjmxLb77Q>
    <xmx:F4xMaFkjP5lldg0kEC62PCo1QpfJMKt8BruHW_QTfOMVuBe3JPoiXw>
    <xmx:GIxMaErf2W4Z24XsbxhiEycJiQGzyO2xxPZ09zaQv3jG22DfrKrigkE6>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 13 Jun 2025 16:37:43 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Alex via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Alex <alexguo1023@gmail.com>,  jinyaoguo
 <guo846@purdue.edu>
Subject: Re: [PATCH] Allocate msg only after fatal checks to avoid leaks
In-Reply-To: <pull.1998.git.git.1749843142000.gitgitgadget@gmail.com> (Alex
	via GitGitGadget's message of "Fri, 13 Jun 2025 19:32:21 +0000")
References: <pull.1998.git.git.1749843142000.gitgitgadget@gmail.com>
Date: Fri, 13 Jun 2025 13:37:41 -0700
Message-ID: <xmqqzfeb74yy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Alex via GitGitGadget" <gitgitgadget@gmail.com> writes:

> -	if (type != OBJ_BLOB) {
> -		strbuf_release(&msg->buf);
> -		free(value);
> -		free(msg);
> -		die(_("cannot read note data from non-blob object '%s'."), arg);
> -	}
> +    if (type != OBJ_BLOB) {
> +        free(value);
> +        die(_("cannot read note data from non-blob object '%s'."), arg);
> +    }
> +
> +    msg = xmalloc(sizeof(*msg));
> +    strbuf_init(&msg->buf, 0);

ALl the new lines seem to be indented by four spaces.  Check with
Documantation/CodingGuidelines.

Also, Documantation/SubmittingPatches::[[real-name]] asks folks to
use their real name as authorname.  You prefer your purdue
address, that is fine, but let's do something like

    From: Jinyao Guo <guo846@purdue.edu>
    Signed-off-by: Jinyao Guo <guo846@purdue.edu>

