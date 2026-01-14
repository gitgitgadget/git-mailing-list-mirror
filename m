Received: from fout-a8-smtp.messagingengine.com (fout-a8-smtp.messagingengine.com [103.168.172.151])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC33D1E9906
	for <git@vger.kernel.org>; Wed, 14 Jan 2026 00:27:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.151
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768350459; cv=none; b=A/3GyinHTtMmILEE+qGL2kXFdrhUKa88vwEywgOnsRAPb4Pm3+hY7D8oHP8vojGju7N2ovIta1LP6qqzZ802kbZUsXT8kOzIRT4WutTTo8Bi0fJLujhbW0G+Tc26frCfqxsrPqNBruiY4XUj5/El7NbmboBWz6Shgz0HVmi28nI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768350459; c=relaxed/simple;
	bh=DRsIXEONtPonnFf8Xu+J5Ki+MNkykQ1YBThJmT50+ZQ=;
	h=From:To:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=TlSQgSZa4tkS2LQfYyjkN5mOcknMqmlE+RkGJKeIHqREzuiRfWt+OzDMwG9Mx/MTqXlpRhSMLC1/kxxf70lpbgxS3hBBgct9o5rE1IVe5WxeKi2l0uVpMLuQ80tkNAZWjahKSGmUoqAQTGxxhtL+3sIqQ4sWL0buhX1Itg3etLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=PBib8FkP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D8n9bi3m; arc=none smtp.client-ip=103.168.172.151
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="PBib8FkP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D8n9bi3m"
Received: from phl-compute-05.internal (phl-compute-05.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 00C1FEC0244;
	Tue, 13 Jan 2026 19:27:37 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Tue, 13 Jan 2026 19:27:36 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1768350456; x=1768436856; bh=oVIgteFjwo
	PlXrHWX/2eHr9JT0IXEZEkUKZ5Cm8hh9A=; b=PBib8FkPXVib9UQN9NRSd9Tur1
	W7/KBE4XP5IjuxMBLUX5JzYraP1JOLJeKezr3hO9fkq7jsBMA1xWE0tBxZAyInCV
	pzkove6iQBA1mc0hWue27qd+TJZtandzjIIMzZzqM7uX10EMV22ptOmG10om9yvu
	EWRTnAsGOT4gHEahkiUv8MGmk5BNMivmZ3taGpbj5AD1+vfS/4dPGTxYVKu3JNQj
	HgYEOF5jTkpueAX/nIvA0N6uyKDVCik/qob7nbB7NXwe2YqCUm+Sk0eCnypSO16e
	h311HnBnQ7i4Aq6mzEV1Q2oyySH9SIl6Py/pUeBufPRa08yqJT8dchFjt/WQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1768350456; x=1768436856; bh=oVIgteFjwoPlXrHWX/2eHr9JT0IXEZEkUKZ
	5Cm8hh9A=; b=D8n9bi3mKaqgJJq6Qv0FN9coqktw/fVEzu3UdiHaDZtzQ+6GEFD
	klEyr9kI7bcs0YQ234sp/5j5ZmiBD4PqhYr2No3lv144RrpinhrBU6xqtJ6toDaY
	CExtcbM+iA1gWC6/hWQWasn8kBpRp/sC+maUdfhOj2tLGgrB3qMIjJUQeS+TRaI4
	fiA4XdJnWrQ7LlI4KWJJdrGDoQJbu95X1vangnfFjeLXn4LyKGDQAenzV0IONrw+
	IEGnn1Kurz5r9rAbYGczE7OlHOliCdT5TdJpO1p9sEjMr8IFPvbLEb4glOQfO5ln
	U9ZDehK8Vng8fKvcR8mS0CVhtuiKHXsm/Cg==
X-ME-Sender: <xms:-OJmaTa8YKf7rrAHw7rTgO6q_1dDgktBToeZiggsjoxRjhzFYc_6SQ>
    <xme:-OJmaYZGpFv5MIgoo7d0l95veycarqPWqfdn1xfhoSeR9uwUjFtgWJRwonkSDoI1x
    erSwbXfYW759lmVrqSh8cwp10iBEC8sq4juAXwCvqvb9znFGPPg>
X-ME-Received: <xmr:-OJmaTlhHwhizVyjHg131WFVc_Z4KIKKhhryc5vPDsg8pVQk4KLMTQADcMn723wQeqiRYF4szs7d1s5e45PrClvwh68r_0IfSdbwe4M>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdduvddujeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvffujghffffkfgggtgesthdtredttd
    ertdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphho
    sghogidrtghomheqnecuggftrfgrthhtvghrnhepkefhueduteekgfdtueegvdfgueeiue
    dvlefggfefkedvffduvddvkeeuhfeifeejnecuvehluhhsthgvrhfuihiivgeptdenucfr
    rghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspg
    hrtghpthhtohepvddpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhg
    vghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrd
    gtohhm
X-ME-Proxy: <xmx:-OJmaUzkG906wH4K6GOmIHtCRMMnbPqulmI8PLULd4tNcO-NE8WZqg>
    <xmx:-OJmaRP60nu_7h6I8MjenahtxkfNUTmBprEvoa_gXwgjEKgfnJmrSA>
    <xmx:-OJmaYR3nea7eTyzV-HiVjaGy1zPUQL1JxQIFG0kQfhIRXvCQ3PVCw>
    <xmx:-OJmafYtsSvP13hSfucSgIxVczFbPSQS8pdOcJd-T2nX9rAwYfjMKw>
    <xmx:-OJmaWwdxmaI96v3jG7rSI2uoWPI6GulADjUyNFKN82yCw-FTLpwFn0s>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 13 Jan 2026 19:27:36 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jan 2026, #04)
In-Reply-To: <xmqqjyxli89m.fsf@gitster.g> (Junio C. Hamano's message of "Tue,
	13 Jan 2026 12:10:13 -0800")
References: <xmqqjyxli89m.fsf@gitster.g>
Date: Tue, 13 Jan 2026 16:27:35 -0800
Message-ID: <xmqq1pjthwco.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

The following topics have been merged to 'next'.

> * ps/ref-consistency-checks (2026-01-12) 17 commits
>
>  Update code paths that check data integrity around refs subsystem.
>
>  Will merge to 'next".
>  cf. <CAOLa=ZShPP3BPXa=YnC-vuX4zF=pUTFdUidZwOdna8bfVTNM9w@mail.gmail.com>
>  source: <20260112-pks-refs-verify-fixes-v2-0-2e9e453bd6c3@pks.im>

> * cs/rebased-subtree-split (2026-01-09) 1 commit
>
>  The split command in "git subtree" (in contrib/) has been taught to
>  deal better with rebased history.
>
>  Will merge to 'next'.
>  source: <20260110011811.788219-1-ask+git@howdoi.land>

> * kt/http-backend-errors (2026-01-11) 1 commit
>
>  Some error messages from the http transport layer lacked the
>  terminating newline, which has been corrected.
>
>  Will merge to 'next'.
>  source: <20260112014508.17248-1-kj@kjtsanaktsidis.id.au>

> * ps/t1410-cleanup (2026-01-11) 1 commit
>
>  Test clean-up.
>
>  Will merge to 'next'.
>  source: <20260111191525.17087-1-pushkarkumarsingh1970@gmail.com>

> * tb/macos-iconv-workarounds (2026-01-11) 2 commits
>
>  The iconv library on macOS fails to correctly handle stateful
>  ISO/IEC 2022 encoded strings.  Work it around instead of replacing
>  it wholesale from homebrew.
>
>  Will merge to 'next'.
>  source: <20260111195151.716191-1-tboegi@web.de>
