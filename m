Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C630527FD71
	for <git@vger.kernel.org>; Wed, 25 Jun 2025 16:07:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1750867639; cv=none; b=cDcLy1z7mTzqK/K7I+4aeqrf6M3h7X+ukE8rgg2GThbpsj7c+BX9tsvcSYnqnd66mDEIpU5FLOi1cVEkSwi6atv6wphQkIKdpEg85aIR5VYgTL9zZ+dfzaeWOJV10UoOAiOlTuzD7K5/exeWuQCGZ5Uv2zBBAKSfMmdhCBVDxiM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1750867639; c=relaxed/simple;
	bh=2AwkRe1d2wztDth8DUY9GynnPoyRqcNvd+vvw9bKjsE=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ffmRmciR8lnAihwG9cOPL+/6tRCYGHdjL9Vw27VmGkjSoXPyK333bRIe5dQzr/ymvQjOz3tQOoR9yj7pj3kCYso+sxhttGqWXOx0KHMvcQpdg7yvOHCMcG7JP66kvUOUT5mI9L5J7xUmBRxM2gZL8UbAJVF4dVSLh3vbEXnK7zU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=O/K+27vJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=kICJCAww; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="O/K+27vJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="kICJCAww"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id CE1A6EC00DB;
	Wed, 25 Jun 2025 12:07:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Wed, 25 Jun 2025 12:07:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm1; t=1750867636;
	 x=1750954036; bh=C8MXH9jjRlkfIJGlFETfweLgFXI+KEbbiyEcbEF+oWQ=; b=
	O/K+27vJ92nRjDaQys4zHB0K8Sq0KB/KuYVdd9Afk84FuK6+z6bvKsqv6XqAaWjf
	vZhfpnpZej6NtNKjlIrO8Xx32Tz7/VOXT1X27iMKKUTe9aN4N8KyT0h7DuLqiLn7
	gY5LieNNMTfYBNRjfoFJ0NRPQQSWUCkISoK9c1/xkKPvKD8qYqPqvauSWmWZzG3W
	1pAAg0GcyONTL4XOb3VSpgoEcWyNbplH/5Da+4ubdr8xtxiiMoaeNBafKAsesjNO
	KymENgiEpRCM0WCnCUSFiMQoNlEktkdMosES0ZGktYNS7XdQHabXnlBG7CBT7Zeh
	SfSLKkLdhKAYQuhUFhtKTw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1750867636; x=
	1750954036; bh=C8MXH9jjRlkfIJGlFETfweLgFXI+KEbbiyEcbEF+oWQ=; b=k
	ICJCAwwLlqLbOPi8LV05Y/SRj5O9GMn52paqvq94TGbYYQ+EgG6ZXKNm8baJoZxM
	b12p9MMBm9N8VHS91ElbAySIGe8GN+YfdMNHSTkDAr+J38fmDGwtMwwDvEzxk0Yw
	vK5s+FLUaPsGfDw+/EZvcV4QFLQHGulNfz8eUtesuRd6oGzqpglAN6uCx7paF4Lk
	0byJsTo3URBAiJ/Bv6wbOImheXe5SxuXY1ZcomWDjJBc4OWlK6rkdCfsN9WEnSbe
	J9GX6ywqwUgu5wT9wi8IQ1jVkJaVtHCIKdj3f11I3KPPp1YXgUMG/nVFhat9X7sB
	sDJu5nPyGmJO78P0ajF3w==
X-ME-Sender: <xms:tB5caNMRXX63M26ZRTmmtldJUGnNAEL5DMXb57l6yXvc10RXxJALTA>
    <xme:tB5caP9EHhxvCeLpkmBuxNSgjl_I3ZEkF5BGXO3lEaGvv62MMeiixU9Nazd4FOsa1
    Qn7CbsjQh9VUH1LlA>
X-ME-Received: <xmr:tB5caMTSVN9c80RiuvVm1VkGQTTsiI5eQDMbjOaKoMN8aSrTzUR3RPnyVdvKDb3urEFyBcavMm6UBMrclZYRI7DP6-TXN4mgb1VxqCU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtddvgddvfedvudcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtgfesthekredttderjeenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnheptdffvdetgedvtdekteefveeuveelgfekfeehiefgheevhedvkeehleevveef
    tdehnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohephedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pegtrghrvghnrghssehgmhgrihhlrdgtohhmpdhrtghpthhtoheptghhrhhishdrthhorh
    gvkhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgt
    ohhm
X-ME-Proxy: <xmx:tB5caJtBDdYHC4YQA9r2sZVcgbfA7kvrgdVvCihjnQEhxDoFIPTvfg>
    <xmx:tB5caFf1vS2jkl1ytug_8jktPD1nH1oY3o-IUQVTA8W6sYbfcd-TUg>
    <xmx:tB5caF08aEOZRdmdSXoy4QUDyDH8TygFmYynTjowmMjI6XojH2-EPg>
    <xmx:tB5caB_T9hf-4nHyDV8dqJCzHOlfNJ6rcthHyn3MMMvfrimYyea7aw>
    <xmx:tB5caCOeMAx2NGFvJKe2l96HzMavDvTch9fZRmr7a3P5rFazslPL2aLp>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 25 Jun 2025 12:07:16 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: =?utf-8?Q?Carlo_Marcelo_Arenas_Bel=C3=B3n_via_GitGitGadget?=
 <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?=
 <carenas@gmail.com>,
  Chris Torek <chris.torek@gmail.com>
Subject: Re: [PATCH v2 1/3] compat/posix.h: track SA_RESTART fallback
In-Reply-To: <e82b7425bbc2540fa5ef3fd4584e6f902485d064.1750836928.git.gitgitgadget@gmail.com>
	("Carlo Marcelo Arenas =?utf-8?Q?Bel=C3=B3n?= via GitGitGadget"'s message
 of "Wed, 25
	Jun 2025 07:35:26 +0000")
References: <pull.2002.git.git.1750774122.gitgitgadget@gmail.com>
	<pull.2002.v2.git.git.1750836928.gitgitgadget@gmail.com>
	<e82b7425bbc2540fa5ef3fd4584e6f902485d064.1750836928.git.gitgitgadget@gmail.com>
Date: Wed, 25 Jun 2025 09:07:15 -0700
Message-ID: <xmqq4iw3yfd8.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"Carlo Marcelo Arenas Belón via GitGitGadget"
<gitgitgadget@gmail.com> writes:

> +# Define USE_NON_POSIX_SIGNAL if don't have support for SA_RESTART or
> +# prefer using ANSI C signal() over POSIX sigaction()
> +
> +AC_CACHE_CHECK([whether SA_RESTART is supported], [ac_cv_siginterrupt], [
> +	AC_COMPILE_IFELSE(
> +		[AC_LANG_PROGRAM([#include <signal.h>], [[
> +		#ifdef SA_RESTART
> +		#endif
> +		siginterrupt(SIGCHLD, 1)

This is curious.  What is this #ifdef/#endif doing that does not
have anything in it?

> +		]])],[ac_cv_siginterrupt=yes],[
> +			ac_cv_siginterrupt=no
> +			USE_NON_POSIX_SIGNAL=UnfortunatelyYes
> +		]
> +	)
> +])
> +GIT_CONF_SUBST([USE_NON_POSIX_SIGNAL])
