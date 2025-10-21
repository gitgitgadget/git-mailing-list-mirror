Received: from fhigh-a6-smtp.messagingengine.com (fhigh-a6-smtp.messagingengine.com [103.168.172.157])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B47524729A
	for <git@vger.kernel.org>; Tue, 21 Oct 2025 07:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.157
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761032481; cv=none; b=pemXOait0IANxB8AK0kQTUcze4Bx9unTxuAEtl0h507zV4yL8EitIC+kutYv8z2akjm0RZecYlLscUwu4D7aAEyCwRUtyFzjIOGHibgN1oexGeYTuy+RXu3apCFEnBNFCtmYkNJ1MSD2kDnsqFaZhOBCFSgE+KhN6vQlDrLqrio=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761032481; c=relaxed/simple;
	bh=BoPchStx9LY/UKNFmdEnS7AUNiSkikfaYyX5VUshuCA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=uEmPEOL3HCWeac4OQ8vWx2GlrOYZxre2u9eDLxZl9G81uDEDlUXENqkPm2hzKt5CXINjq5PfkH18ooPfNeVcla1VySxj3vXYSig/vTDbLYmMsGhoIiXxzWtHeMrnM1GnXk5MVVvR8r1q82u94uiOpIkm2OqubJuvVFiQryniEa0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=fkcipqKb; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=XYmO4OiS; arc=none smtp.client-ip=103.168.172.157
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="fkcipqKb";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="XYmO4OiS"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 65AEC14000BA;
	Tue, 21 Oct 2025 03:41:19 -0400 (EDT)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-01.internal (MEProxy); Tue, 21 Oct 2025 03:41:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1761032479; x=1761118879; bh=KKoBAavJSq
	DIC+0IxXs/8R4Wq13Cq119X+kiWL7oW5c=; b=fkcipqKbNXAwAb83aDdNPqLh4f
	7YvQs0QaWSVsgJ6Qw6iLXuY1RfR/zsg970BC0VX85bo3pq4YILEv0cE0DzfY6MxO
	kjc+fb3jKrsWc8dhFXEu7b44R6EgHvYENYdt3nXYrDY9OvtIgF4rQf9gSQK8dqDL
	O+L9KJLgkycro8mZ9T+yVhXu3YwKK6e/9S0UGas7VF2MnmFPKp1Kt6hu45SkzGX2
	T1Sf6/ngO1yVSpiRdQqqGiX59zON4r0pWXtwS3/bOtP9BRLIwt14nB7hDrW9Fw/A
	smkOfepM3OvTqIosFyUW5Cr7VA2pb85KvtUnppJuTBazeopd0bzyNQObROdg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1761032479; x=1761118879; bh=KKoBAavJSqDIC+0IxXs/8R4Wq13Cq119X+k
	iWL7oW5c=; b=XYmO4OiS61atPoE91b8ANWQPzf/mtEMAuNj/XY5+r7NI0m1otJd
	oUZ26SygqbnhUmdulqhrwR6FD90zkoB6xyN7ylRfK9qA9ASaOKJ/8JEB0otuUuoT
	nTXv2W2zfkWSfv5q/SXeoWBMEIPhV+Pwdq4863f0j7mHRnV4Wf9JatNRYeLHMsUx
	jPJ7Q05NvWzZJRGj56xEV8+X8QuW9JQ2fjbz1gJGaCNJrgUwZoFLFTmoq6YIvVKx
	QD2NxreMUompf0xaVExUWuTIn28V9loCtNEkqRmDzRz0wi9K0xQCYiUJA2MkUDql
	gTotV5ug3vGUb/D0ADfiVLllMjwqrcuPkUg==
X-ME-Sender: <xms:Hzn3aAqUnNytyBtkKf9ZyQ6RBenFIfWROMjKAmCArkM7If3ayCvrwg>
    <xme:Hzn3aJPkl_MCk5GjTXGjNSNkZ0aywSYOpJeugxxrNN3UJC0ZKhWLiXK1Ur3l-27Mf
    8d326k4-YehMML67ty-Xcm7uL7y5Sat70spDM66Dm5yCkD8rCbEvlg>
X-ME-Received: <xmr:Hzn3aI05qufqqkX5XRscv0Of4stMMc651YoRBq29L5c4S6eHNZQtjEpsZh5xglNqO6LCPDw1J3ucIAMwDJ1PyqEBY4hkQ2C6efxbjxoE7UtoRw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdeggddugedtuddvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomheprfgrthhrihgt
    khcuufhtvghinhhhrghrughtuceophhssehpkhhsrdhimheqnecuggftrfgrthhtvghrnh
    epveekkeffhfeitdeludeigfejtdetvdelvdduhefgueegudfghfeukefhjedvkedtnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepphhssehpkh
    hsrdhimhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    ohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopegrvhgrrhgrsg
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
    pdhrtghpthhtoheprhgurghmrgiiihhosehgohhoghhlvgdrtghomhdprhgtphhtthhope
    grughrihgrnhdrrhgrthhiuhestgholhhlrggsohhrrgdrtghomhdprhgtphhtthhopegv
    mhhilhihshhhrghffhgvrhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepphhhihhllh
    hiphdrfihoohguuddvfeesghhmrghilhdrtghomhdprhgtphhtthhopehsthgvrggumhho
    nhesghhoohhglhgvrdgtohhmpdhrtghpthhtohepsggvnhdrkhhnohgslhgvsehgmhgrih
    hlrdgtohhm
X-ME-Proxy: <xmx:Hzn3aIDkt_QLSjesAoh943bt_TAdpiDjKpz57Gem8kIGZ3chSa4DlQ>
    <xmx:Hzn3aFJ6F5Et0TVRHhsWObbPP2WT-wdJCnIL2D9ZV5q7M-0Rzn-TAg>
    <xmx:Hzn3aBl3HtCic05x8R2XTww6IvSBUuwFgSsikFkXSZ-Emro8dOd7vQ>
    <xmx:Hzn3aOYnDD4NFT1DwBLsD-FnO-7VIyGNfxg0YVvR909ore91SR6pXg>
    <xmx:Hzn3aCMCKrPZN61JVVOStpIftFfvjlHP_RRqOvZw9G72HeppOuNIUE7Y>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 21 Oct 2025 03:41:17 -0400 (EDT)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id 032c25f0 (TLSv1.3:TLS_CHACHA20_POLY1305_SHA256:256:NO);
	Tue, 21 Oct 2025 07:41:17 +0000 (UTC)
Date: Tue, 21 Oct 2025 09:41:14 +0200
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v2 02/10] hook: provide stdin via callback
Message-ID: <aPc5GhzFSdrMvOZK@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-1-adrian.ratiu@collabora.com>
 <20251017141544.1538542-3-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251017141544.1538542-3-adrian.ratiu@collabora.com>

On Fri, Oct 17, 2025 at 05:15:36PM +0300, Adrian Ratiu wrote:
> diff --git a/hook.h b/hook.h
> index 11863fa734..ebe5dc450e 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -37,6 +38,28 @@ struct run_hooks_opt
>  	 * Path to file which should be piped to stdin for each hook.
>  	 */
>  	const char *path_to_stdin;
> +
> +	/**
> +	 * Callback to ask for more content to pipe to each hook stdin.
> +	 *
> +	 * If a hook needs to consume large quantities of data (e.g. a
> +	 * list of all refs received in a client push), feeding data via
> +	 * in-memory strings or slurping to/from files via path_to_stdin
> +	 * is inefficient, so this callback allows for piecemeal writes.
> +	 *
> +	 * Add initalization context to hook.feed_pipe_ctx.
> +	 *
> +	 * The caller owns hook.feed_pipe_ctx and has to release any
> +	 * resources after hooks finish execution.
> +	 */
> +	feed_pipe_fn feed_pipe;
> +	void *feed_pipe_ctx;
> +
> +	/**
> +	 * Use this to keep internal state for your feed_pipe_fn callback.
> +	 * Only useful when using run_hooks_opt.feed_pipe, otherwise ignore it.
> +	 */
> +	void *feed_pipe_cb_data;

Are these fields used as any of the callback arguments? If so, let's
document which of the fields they correspond to, as it's otherwise hard
to follow.

Patrick
