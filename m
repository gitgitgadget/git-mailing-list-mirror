Received: from fout-a6-smtp.messagingengine.com (fout-a6-smtp.messagingengine.com [103.168.172.149])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F295244BC96
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 18:25:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.149
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770402327; cv=none; b=FumTzuhv+ZhDOFqrcadd0bIu914JFfkdoMhCb2b7p6hHdpTp9LTAvqZ2TIGf5m4CwJs7KZ7NhWaGpZOXyhLsmB0+u1VZKpvI09wIbGmBZSoymABgQ3oblZc/rbPJMrcm/eiv/B/q64khtyqtAxikP3M0JL4ewlAdkwORcD+HW+U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770402327; c=relaxed/simple;
	bh=5dcVi7Ind6aKUBoqU29kP35dL+Vf5e14VD4IrkNqlbY=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=qL7QOMwbcXsGRy0pernHRFDBZF5pVtaJ4cASBZLM4C29OlaDN5RHT/aBiOHazCcNrNRVKfvLwyaupE0GCcWrKSnhmyUooH98EJr3d1/fO3Q2yiCCUwxrVHSfP2B8GCmWz9yGjMNWqKwLyQOT3LG39iLzjqbPjufLEh/V/Y/3rxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Q0AdI/yT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=pBQSa5XR; arc=none smtp.client-ip=103.168.172.149
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Q0AdI/yT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="pBQSa5XR"
Received: from phl-compute-12.internal (phl-compute-12.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 04D1AEC059B;
	Fri,  6 Feb 2026 13:25:26 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 06 Feb 2026 13:25:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1770402326; x=1770488726; bh=vQMA8E6vZY
	B1/onJiyOS1jkUiP1yit3+VoM05ODXsBk=; b=Q0AdI/yTSd5SBkKcXds5t9Kgp8
	6ZWiSrqz03oiKHRhrOXcWQ73wszRIEeArhkA1W2n6XxWR7IjCSutJFplV03atjfS
	7XHxeFgne6JvNtxSvbparDHscFULDXRV86di1PSpgfr0+mOFzjwp99h/Lrk3mnvp
	OBWQ5uqk/P3zsC5Kxl3n39br+pYbnkC2kvPcO4MRk32J2UR/DRzjOV5ic2JoEux4
	6kES0ezZva+466Izy5E2CkTJQXBiEg29N1MgHRBDfbep7N5ig8ul40iajbZ8Ef/d
	Ky9tqGKLT0ybPRStUK3xPLNkh1nle0tDFFHUP9JrdUaLDx3OaCP8dADEUpng==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1770402326; x=1770488726; bh=vQMA8E6vZYB1/onJiyOS1jkUiP1yit3+VoM
	05ODXsBk=; b=pBQSa5XRhzNVhB+yeHzhM6fBWzF2CuapEKWsNP/j+pNjtDmh/gj
	5JUScGF1P61bzf6QB8cvlxnp7sEdwzblngeibxDSyErJQukvjmR4XI13GZguVqCq
	rb/d59hVId1+lXEn5Mk5yfxSwx4DBh/JHxMzP86XZyBxZPMJu5+B9Bx6jEX4zk4N
	3U7ojoi023rNqyc0FUuVDpHEbsGe+bOIvvzPgTNXXnY212d1LkHKI8UDAC8ERSTW
	wYBbYbf2MyicME54eYpKQP52Ko09oHpyMtU2NW4UB4z+xYwQlZy8cB+RqsJPr1Kd
	6dRemh/hX1ojE9K+qdTwkEO6VebST7w8qRw==
X-ME-Sender: <xms:FTKGaVTYAid-d52zefjGsFyrGClCR1SfeNKxESxCFue8lWS5o1eXdQ>
    <xme:FTKGabV6zefvCkrSZdJ9AXjGByrLV7lKzzpptFUiDj1lN7CaGUeg0EovTxun_MV3E
    _53cfewif6wg7BTNGjbFUQkMg48qh0gtNH_Ha2eG5Hpm7i_y7F9>
X-ME-Received: <xmr:FTKGafQVPtdqxvnpfgWNCsg69NG2LfFm6uZZdfwqEZgz6MAomDT-KrDXxcUSMt0_9lVMkBQLyLDe1cHjqIwvt2-rVNR3H9LbzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddukeekkeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepuddtpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegrsghrrghhrghmrgguvghkuhhnlhgvhedtsehgmh
    grihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdp
    rhgtphhtthhopehpshesphhkshdrihhmpdhrtghpthhtohepphhhihhllhhiphdrfihooh
    guuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsiigvuggvrhdruggvvhesghhm
    rghilhdrtghomhdprhgtphhtthhopegthhhrihhsthhirghnrdgtohhuuggvrhesghhmrg
    hilhdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghughhssggrkhhksehf
    rghsthhmrghilhdrtghomhdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilh
    drtghomhdprhgtphhtthhopehkrghrthhhihhkrddukeeksehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:FTKGaT2SjXIkszp7OxrRjzBsurlzsQH8Swgp2Ke2WAWrHPu3-ewK0Q>
    <xmx:FTKGaffpAwrGAvn-nTFDCbOZlQesdsbKGNsn1XqNNs2ZR1aAaP7jtw>
    <xmx:FTKGabP_lII4JotpG9amskbP3s4wmM3hYte4WPFCtVuqin8Bqha9Kg>
    <xmx:FTKGaTUa8P2mnm28rSsVLosdN5ftWtAPqeEpyTHnkG_j0BKIZvbI0w>
    <xmx:FTKGaU5uvawBD_gSsHgrNF5UAF4CjU64_i05R9vxJL2zlmzFX-NouuEK>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 6 Feb 2026 13:25:25 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Abraham Samuel Adekunle <abrahamadekunle50@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood123@gmail.com>,  SZEDER =?utf-8?Q?G=C3=A1bor?=
 <szeder.dev@gmail.com>,
  Christian Couder <christian.couder@gmail.com>,  Kristoffer Haugsbakk
 <kristofferhaugsbakk@fastmail.com>,  Ben Knoble <ben.knoble@gmail.com>,
  Karthik Nayak <karthik.188@gmail.com>
Subject: Re: [PATCH v3 1/3] interactive -p: add new `--rework-with-file`
 flag to interactive machinery
In-Reply-To: <c0fa65b429b4a5c33c4a2092e0e8d014a61e4569.1770390576.git.abrahamadekunle50@gmail.com>
	(Abraham Samuel Adekunle's message of "Fri, 6 Feb 2026 16:54:47
	+0100")
References: <cover.1770390576.git.abrahamadekunle50@gmail.com>
	<c0fa65b429b4a5c33c4a2092e0e8d014a61e4569.1770390576.git.abrahamadekunle50@gmail.com>
Date: Fri, 06 Feb 2026 10:25:23 -0800
Message-ID: <xmqq8qd5g25o.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Abraham Samuel Adekunle <abrahamadekunle50@gmail.com> writes:

> When using the interactive add, reset, stash or checkout machinery, we do
> not have the option of reworking with a file because the session automatically
> advances to the next file or ends if we have just one file, immediately all hunks
> in a file are decided on.

The last part of the sentence after the last comma does not read
very well, at least to me.

We recommend to fold lines in such a way that after a few e-mail
exchange and quoting it will still stay within 80-column, so a
practical fill-column value lies somewhere around ~70.  Your lines a
slightly longer.

> Introduce the flag "--rework-with-file" when interactively selecting patches with the
> '--patch' option, which does not auto advance, thereby allowing users the option
> to rework with files.
> This ensures the current auto-advance method stays as the default method.

OK.  There may be suggestions for better option names from others; I
do not think of any right now.

> diff --git a/add-interactive.h b/add-interactive.h
> index da49502b76..aef2feca56 100644
> --- a/add-interactive.h
> +++ b/add-interactive.h
> @@ -6,9 +6,10 @@
>  struct add_p_opt {
>  	int context;
>  	int interhunkcontext;
> +	int no_auto_advance;
>  };

We add a new risk of double-negation confusion, e.g.,

    if (!opt->no_auto_advance)
	... do the auto-advance thing ...

where it may be easier to follow if it were written

    if (opt->auto_advance)
	... do the auto-advance thing ...

Would it make it harder to arrange the code if we made this member
"auto_advance" that defaults to "true"?  We have ADD_P_OPT_INIT that
everybody is supposed to call already, like this

> -#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1 }
> +#define ADD_P_OPT_INIT { .context = -1, .interhunkcontext = -1, .no_auto_advance = 0 }

so I do not imagine it would be too much hassle.

> @@ -28,7 +29,7 @@ struct add_i_state {
>  
>  	int use_single_key;
>  	char *interactive_diff_filter, *interactive_diff_algorithm;
> -	int context, interhunkcontext;
> +	int context, interhunkcontext, no_auto_advance;
>  };

Likewise.

> diff --git a/builtin/add.c b/builtin/add.c
> index 32709794b3..408827cf54 100644
> --- a/builtin/add.c
> +++ b/builtin/add.c
> @@ -256,6 +256,8 @@ static struct option builtin_add_options[] = {
>  	OPT_GROUP(""),
>  	OPT_BOOL('i', "interactive", &add_interactive, N_("interactive picking")),
>  	OPT_BOOL('p', "patch", &patch_interactive, N_("select hunks interactively")),
> +	OPT_BOOL(0, "rework-with-file", &add_p_opt.no_auto_advance,
> +		 N_("rework with files when selecting hunks interactively")),

Likewise.
