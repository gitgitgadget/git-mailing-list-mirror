Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2CEE2206AE
	for <git@vger.kernel.org>; Mon, 10 Mar 2025 07:37:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741592257; cv=none; b=qavpoCfVTR0UTTgxdIkra1oITycjJjHZGjftpyv9Fn1A5zEl6/gXc1Ww89A5tflUBN9YJBgDe7Vwx1hlnC6H5xhhXf71ptcoW5laXxN9KAmk+Jnlbzne5uIUzl2FmqEwWYdL1/F3zOwlpRGuCqKSJNnWfERTovsiemNYebY049I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741592257; c=relaxed/simple;
	bh=NNc3h2/mLj6WBD29GCstwkdbh+Zdd6ynXB1tyIBdhcU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=hjVZ9QqpVhm3xdjJiUj3cW3rfifEotv4rSWlT2RP8RZ3QUW8Z1qUzMJJ6WnWVNCOhjTfBQTU/wncfyO5shDMR8j33NfTMWQNwJ9RYJ1R3HpKSZVs4+Guy8gsLIjpcvw7LlbukyxHsYdk3Tdmtl2arYuxpHUcQF/EUaepCaJhbMU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=lCz0eJmh; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=Chpt/0aG; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="lCz0eJmh";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="Chpt/0aG"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id B99EE11400F5;
	Mon, 10 Mar 2025 03:37:34 -0400 (EDT)
Received: from phl-mailfrontend-02 ([10.202.2.163])
  by phl-compute-04.internal (MEProxy); Mon, 10 Mar 2025 03:37:34 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1741592254; x=1741678654; bh=QIr1TSU48Y
	MbKWMblzQcoxSX9aUcov3u0X2LjA/W3qs=; b=lCz0eJmh+0Pkc0efy9Q5aPVhDq
	YuGGpgBZlcI1E5r6wwR4wBcIyyh+W2/GpfIb6clpCO6tLblscZJHsUZk93rlvr3o
	eiZ2rWqidQWiyKPrNe+ogkX5JNwabgcvvHOKVx4lzkvJQl+R2EEsUA7deS0CIqt/
	j3z7HKwpM8mneeoCx5fP3DEDW6rwqIqkgiCe3Z1gC9o2sHSeWRHAk3f0XdMeEdMl
	4R1v2qvaxVIstLXJggRjt1kUIEe0BdvcEd4JK//reul+H8bR7T/NDi6sDxr/3zgi
	fyegSNjy2CSY86q9de0EQ08iBGqC+nUhSIGTOg50wJ+eImSCvAd/s4RzNvoA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1741592254; x=1741678654; bh=QIr1TSU48YMbKWMblzQcoxSX9aUcov3u0X2
	LjA/W3qs=; b=Chpt/0aGVuIiMGC/e+jIZzavsw7UibHOUHIVT1zJi670sWgvXCV
	PnFWzG86rXPM9dbsCUjfTi32T0hP7aA+ooNXRSwC0PHZQe8GEU6jaGAs6La8whsi
	Gu0l55QJnoaFtVT8tpKJrFrCkhlbKsdvyGmHj1af1amFhgJHw5EgWDYHDVnXzRZj
	2mh1uMPX3Il292HBGd333Lc6y6Fhj7zgJuU1NkAKQMMMIVmF6uNRmyrLLJkS71Oc
	uTfGMovWkcky/jMTBUWJorCqLbja2Catj90Du+SC5LFmNudygaZQszg5/9Oq3nFJ
	U09vPffb0572yKZgid97wMTtxb5MKbl2wSA==
X-ME-Sender: <xms:vpbOZ_2CAHZNDBCsv_OvfAF-TZ9Z4bukv-V8KdE4-5-GyAWcqxe5FQ>
    <xme:vpbOZ-EvGSP-HtSfCwt3SxEmVPfsqMpp3h7b90RG48zHxiRzFpEvU-JSOHDYmZJdq
    BbWmLztZWWsK7eesA>
X-ME-Received: <xmr:vpbOZ_7gicu11ZhJYoib6f3-MebmpV_pq-GDbsRU62Ogg9Hf1HouRTKNQxp2xqSdC3nm3MO1-jDOGZzgWEHNbYL4y724B3hkIrRI0MkFz2wcxA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgdduudekjeeiucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhepfffhvfevuffkfhggtggujgesthdtredttddt
    vdenucfhrhhomheprfgrthhrihgtkhcuufhtvghinhhhrghrughtuceophhssehpkhhsrd
    himheqnecuggftrfgrthhtvghrnhepveekkeffhfeitdeludeigfejtdetvdelvdduhefg
    ueegudfghfeukefhjedvkedtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpe
    hmrghilhhfrhhomhepphhssehpkhhsrdhimhdpnhgspghrtghpthhtohepfedpmhhouggv
    pehsmhhtphhouhhtpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrgh
    dprhgtphhtthhopehgihhtghhithhgrggughgvthesghhmrghilhdrtghomhdprhgtphht
    thhopegvmhhilhihhiihhihlihhmvgdoghhithesghhmrghilhdrtghomh
X-ME-Proxy: <xmx:vpbOZ01s5Hw0ofhnXIiahjB8apeqj6Vb6RL6Dv-KMtpZSxUzYzCmWw>
    <xmx:vpbOZyEPzz_OJxJj5-dkF-a8qv02HfgNsFREYniHhw7_5tLfr41qMw>
    <xmx:vpbOZ1-zE0TCiLI0Wa7a4G8IVm_p4JHRN_Va5lpe8c9vjDRLan48PQ>
    <xmx:vpbOZ_lKvN82HZCt-QFBh1OPK1kJ-f-UFNPFMm_xdicmDoNkDRTkVw>
    <xmx:vpbOZ-CFVdb1vV8UsygxlHOrm9yF_b3laRoeJFU0bmNEKmnl6GG8tqMb>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 10 Mar 2025 03:37:33 -0400 (EDT)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id 0c9505fa (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Mon, 10 Mar 2025 07:37:30 +0000 (UTC)
Date: Mon, 10 Mar 2025 08:37:25 +0100
From: Patrick Steinhardt <ps@pks.im>
To: emilylime via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, emilylime <emilyyyylime+git@gmail.com>
Subject: Re: [PATCH] archive: error instead of triggering a segfault in `git
 archive --remote=""`
Message-ID: <Z86WtQ-3Rk9OSmn_@pks.im>
References: <pull.1877.git.1741515155475.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1877.git.1741515155475.gitgitgadget@gmail.com>

On Sun, Mar 09, 2025 at 10:12:35AM +0000, emilylime via GitGitGadget wrote:
> From: emilylime <emilyyyylime+git@gmail.com>

This is missing a bit of a description:

    - What is the observed bug?
    - When does the bug trigger?
    - Optional: since when does the bug exist?
    - How do we fix it?
    - Optional: are there alternative ways to fix this bug that you have
      considered but found to be less optimal.

> Signed-off-by: emilylime <emilyyyylime+git@gmail.com>

We usually prefer people to sign off with their full name.

> diff --git a/builtin/archive.c b/builtin/archive.c
> index 13ea7308c8b..b6fdbfc7dca 100644
> --- a/builtin/archive.c
> +++ b/builtin/archive.c
> @@ -97,6 +97,10 @@ int cmd_archive(int argc,
>  	argc = parse_options(argc, argv, prefix, local_opts, NULL,
>  			     PARSE_OPT_KEEP_ALL);
>  
> +	if (remote && !remote[0]) {

Okay, so this triggers in case the user passes "--remote ''"?
I see that we ultimately pass the string to `remote_get()`, so does that
function segfault? If so, can other callers of that function segfault in
a similar way? In that case, we should probably address the issue deeper
down in the call stack.

> +		usage(N_("Option 'remote' may not be left empty"));

Error and usage strings should start with a lower-case letter.

> +	}

The curly braces aren't required.

It would also be nice to add a testcase, e.g. in "t/t5000-tar-tree.sh".

Thanks!

Patrick
