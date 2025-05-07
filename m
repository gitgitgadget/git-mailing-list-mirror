Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F195728EA68
	for <git@vger.kernel.org>; Wed,  7 May 2025 20:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746649561; cv=none; b=L3aIUpjyd2UkuFyEMBF8nSXqe2HyjoqVwWk0Z4pgz7HarN9bebqWx9awU74F7EEcbUNJMaoixIzb5cjEegVZizsCBgCpFa/MYC9MfVUEbeEZYm4Ry2NnyFHsFap6CDy/dPNp5KfdmkbNpqqEdT6Zo/0XF8TgAS4WxUyf2O3+Xyo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746649561; c=relaxed/simple;
	bh=OG+dHeFScQy8K1QY/wUJicJyDNa1p/9e/sudK91czXk=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=sX4uZBO/o3da8JeBknQHOINC2cS5f1rb8pJ1P6AAITwaCpk6273wdfpf59l8shZMnnR4GWAYAgq/pGjoeLV8CK5DxptYuKzNCxShxs2UdTgMzDEokjCLCRob6KobW6mXovFgXKWfrnHGK+KZJ77nY4xkYGOMnnS4Co0poLJ2Dmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=XbXGFxrv; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=iKp7q0/E; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="XbXGFxrv";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="iKp7q0/E"
Received: from phl-compute-05.internal (phl-compute-05.phl.internal [10.202.2.45])
	by mailfout.phl.internal (Postfix) with ESMTP id 117B0138011C;
	Wed,  7 May 2025 16:25:58 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-05.internal (MEProxy); Wed, 07 May 2025 16:25:58 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746649558; x=1746735958; bh=W1ttVWBhdb
	un4yaN2n9vK/0AvK7pA2KJUz6/tFhbH5o=; b=XbXGFxrvcXzajN7DWIiI+hxKPB
	HbF6I7iW6dt7BfrdlwDK3+H96WCi3Lv0rfbzlpi6ifw9li0wn0I0u6JAwrxCVAKw
	6BH7Y10fdYtf8EhQVnraQl3Ku3iuBCC2LALBAU4VazGAar31DXICziZ5xijaGb1k
	KW53g7de2BZ5a5G7yftCGwhEFYJBO5CogFJTzQdRhcPhBC0VPz6Pyy0JhzFpAPqz
	8vR34cdQwYk3ykHS8I6qlnTaA3lKfWzpyu0+WPJtVoAoh310yyZpJW41CDsv2xlE
	QZXIb/WwpSonaPfnKHJIoNxTrLPS09njA9Y+6USYpFIDI9ADKUq0SNH8sYDg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746649558; x=1746735958; bh=W1ttVWBhdbun4yaN2n9vK/0AvK7pA2KJUz6
	/tFhbH5o=; b=iKp7q0/EUS6FZ7I2JjHcwr/4Yrlog7S9jPFFBcI4LNzjaJO5hdi
	9pxm3U0uybpeaHf9+ZO2Ilch0Jmfi4TR4S358R2q+vcGuFqZH1XsfJ45Rfx4edYm
	S1VW65u3ojAqdNoBUmT9Ogz5t2EtFiTygIbp1Kczka9XDWw6sBP5W0o5RrOYXq6/
	5nJg5jmGPOEd1Dxcy8pVIK5d94B0WLm/WScK421dOJmv4G2aKdvZGKkojifci6Bp
	WzhMTqq5RVaHxso/O1z05By3yxx2KYXvydkOOmm1YZGiXA0Q/3NACweFagK9rXQL
	KcD4qWRiXofQEzRlZsKRr9A+4lVcO/V/vHw==
X-ME-Sender: <xms:1cEbaKIAPEooHa5sq9f3_YT659RJxbNKMjhSxkrAG01RtgVrPJvVkw>
    <xme:1cEbaCLta91fOoM-SiEbE4_qbxO66vdw7APGZDqoHwx_CELJ7w1j544Hwai4W8KOi
    9LUypwcxRJmRxLJdw>
X-ME-Received: <xmr:1cEbaKvbuExqIql2Oc5sPoSZCTfruJ2lRx7nDou60c7Li4epN9xls66-ZBAjSgDQJC3-_0Vtco2TGNmctnZguupZgndz-kRnW827>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvkeejkeduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepfeevteetjeehueegffelvdetieevffeu
    feejleeuffetiefggfeftdfhfeeigeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohephedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtoheplhgvohhnmhhitg
    hhrghlrghkieesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifohho
    ugduvdefsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhgihhtghgrughgvghtse
    hgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhr
    ghdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:1cEbaPaVmNBm82IiKQQd7ikQIdJSIWLL652iLOi90jd-Nh2a_svjoA>
    <xmx:1cEbaBaivrZVaDwn_K9pXjC5EPRCIuakcbTTr4exgOI_k5zFSVkb0w>
    <xmx:1cEbaLBj-RUQfyqnFEc-wmbyvoWd_SlbAgiCVQwsZrgH5ZNX6ojeng>
    <xmx:1cEbaHYjnWP7_lyHKbPwVDfttDlAhkB-oiqxsOOSwrE-5NPyfJ-hcg>
    <xmx:1sEbaD7SU4OqWBXi6nQZNKzpyh1_VJHjSMhmPEzdjbTInhd6KFsANOPV>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 7 May 2025 16:25:57 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Leon Michalak <leonmichalak6@gmail.com>
Cc: Phillip Wood <phillip.wood123@gmail.com>,  Leon Michalak via
 GitGitGadget <gitgitgadget@gmail.com>,  git@vger.kernel.org
Subject: Re: [PATCH 2/3] add-patch: add diff.context command line overrides
In-Reply-To: <CAP9jKjGEDY78MSrZVS2FxAoikPZpGazqem2XHDVmXqMjcox6yg@mail.gmail.com>
	(Leon Michalak's message of "Wed, 7 May 2025 19:28:54 +0100")
References: <pull.1915.git.1746436719.gitgitgadget@gmail.com>
	<7700eb173e73bb240852dc1c7ce26f3d1f95d8ca.1746436719.git.gitgitgadget@gmail.com>
	<61fe7690-87af-4159-be87-cd39c09475fe@gmail.com>
	<xmqq8qn8cn0q.fsf@gitster.g>
	<CAP9jKjGEDY78MSrZVS2FxAoikPZpGazqem2XHDVmXqMjcox6yg@mail.gmail.com>
Date: Wed, 07 May 2025 13:25:56 -0700
Message-ID: <xmqqo6w4b223.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Leon Michalak <leonmichalak6@gmail.com> writes:

> I think I may be misunderstanding, so I'll elaborate on what I
> personally intended my documentation to mean.
>
> When I put in the documentation "implies --interactive/--patch" it
> reads to me as "this assumes you are also using either --interactive
> or --patch and that if you don't specify one or the other it will do
> nothing or possibly error (which is what I chose in the end, based on
> the initial discussion in a separate thread)". I didn't think it would
> read as "you must have both settings" or "if you don't specify these
> the command will assume it as if you had and effectively act as if you
> had".
>
> I'm not sure if the wording was confusing or it generally has
> different meanings to others so perhaps that might clarify at least
> what I intended :)

We use "imply" to mean quite a different thing from what you said in
the above explanation, and that is where my reaction came from.

We say "option A implies option B" only when the command behaves as
if the user gave option B when only option A is given (and without
giving B).  For example, "git commit --help" has

        `--short`::
                When doing a dry-run, give the output in the short-format. See
                linkgit:git-status[1] for details. Implies `--dry-run`.

The `--short` option does not make any sense when you are actually
creating a commit; if you say "git commit --short", the command
behaves as if you said "git commit --dry-run --short".

If something works only under certain condition, it seems we tend to
say "this only works when/with ...", so in this case, we would have
said "The -U<n> option is only effective for --interactive or --patch
mode of this command" to express what you meant to convey, I think.

Thanks.

