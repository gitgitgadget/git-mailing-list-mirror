Received: from fout-b2-smtp.messagingengine.com (fout-b2-smtp.messagingengine.com [202.12.124.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4EBA030E827
	for <git@vger.kernel.org>; Tue, 16 Dec 2025 08:08:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765872520; cv=none; b=Wm31BFRmV7yxTgz8Y3YOeYoP0z7xeJ1+/jsKQm/mDJQtuqw+9RyfdPNaFenFqCjb9x6ht8MxzU7Eu5o3dtngisqzRu/14YkQyeFoeE0jwoVE9b7zoE9o+261Fo/KPFNUwNueq3yHV13qpd6njoskJwauNUlxaOhVsMvQN66bs+E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765872520; c=relaxed/simple;
	bh=z+FJEtXs19DzNVYpHLMFhm2HjdWwhkw16yqD0/axl7o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ocmzt5x4lyOb/uwjFzAMqNr4pUQOSlaNO0ZNr659Ur0ahUeT+gi5ZBDGMxHuPXdMzPOs2DhUZOPf9rS31cCfIDqFB3vJvWckZehv49gzdopk9sk5CCl6SfzA29PIUYXkmCkREcF6XcDw4KawqnFgvrCA95x2YWSjm1ufY4+6CS0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=meu5yAZU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=y8mjPtTE; arc=none smtp.client-ip=202.12.124.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="meu5yAZU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="y8mjPtTE"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id 2EC091D00117;
	Tue, 16 Dec 2025 03:08:34 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Tue, 16 Dec 2025 03:08:34 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1765872514; x=1765958914; bh=S95Klae1c/
	dQudYsa0pfGihV1iUnryVIQaQi+k8yXl0=; b=meu5yAZUSEfBDz2ZxjMra62+B5
	lxHy40EnD+hoRZ5kArpywVUd7mED3RFIeX8ouUpHZrBnj7Imvi0CxgNBdt3aapyY
	mMCwpb+W+CJR7mEcLLBieFNYdHiQS6rgB4f114qR2Kw+jAVnAcHV7/5BuPNLD3Xd
	g6LnKoNG3ve4P1mXY8VwReNyUXzRu32Iiu43ACPfcwmlOpL8gp2R6IDEBmlh2bNx
	noEPgFmc1zRrfbAvSTn8X1egRqyWc/7yJjbl/DvzujWuKEX8mIBI6kI+v6UvPXck
	lU9YKCes1GZJm/QwhVLpSKwLVt9YcySggJQ0SbMJsH26whHPO+MyTlUNT3TQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1765872514; x=1765958914; bh=S95Klae1c/dQudYsa0pfGihV1iUnryVIQaQ
	i+k8yXl0=; b=y8mjPtTE70gDEqFixdgmFFwevMzAbM5bpuhTzAfUu7MHRWchNYz
	cnufRIIdohd/DilX7w1bermkDRxd8J8a7QLzRe74oU5d/NJni+ISJ9Rs9q4CSW8b
	kxCEr9HFJcHR+7D1aUc5dluuM31VT7s9UNue7LZcUu02KY/6FS8xeuekL1/ZEfhE
	jpw9GI4MQlZ07naUI6/KkdRXOxgFfz8mOB8sR9ffVeXtBjINBPvxGzu4Id0OJnbQ
	9EE/lHQa8pLKIHouJH00w6njtWDLZWtu4224W1FDExfkSKU4ipeBneC+A2Vhn+Y2
	5jTXhSbsItnKph3zUbt29rDeLJww0jzD4qA==
X-ME-Sender: <xms:gRNBaSSgP1yiC0bzVFf41wcPh0_uP_wJdyw7XrCEVj5G97JNulYYzA>
    <xme:gRNBaUVu88HV872JhOMG-fqqbNXCQR5jfSdqYLhkUEBnKh9jWuIN_nLwrm6voIecb
    CGMAKY8O0zraUgehJ47QwqNXDR3y01A-iHQWXOBOnXwaUZ5K5Br_w>
X-ME-Received: <xmr:gRNBaUQq-jp1YsItK3nrH1QsHMcgfoo3G0n8N6nAvksjC-87n1bYhoHCukK5Rdmn10921VKxQ_32fHgNaSue2zQE8PysN6wDTSfYGMiUNw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgdefleduhecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpefrrghtrhhitghk
    ucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpe
    evkeekfffhiedtleduiefgjedttedvledvudehgfeugedugffhueekhfejvdektdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhksh
    drihhmpdhnsggprhgtphhtthhopedutddpmhhouggvpehsmhhtphhouhhtpdhrtghpthht
    oheprghvrghrrggssehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrd
    hkvghrnhgvlhdrohhrghdprhgtphhtthhopegrughrihgrnhdrrhgrthhiuhestgholhhl
    rggsohhrrgdrtghomhdprhgtphhtthhopehruggrmhgriihiohesghhoohhglhgvrdgtoh
    hmpdhrtghpthhtohepshhtvggrughmohhnsehgohhoghhlvgdrtghomhdprhgtphhtthho
    pehgihhtshhtvghrsehpohgsohigrdgtohhmpdhrtghpthhtohepvghmihhlhihshhgrfh
    hfvghrsehgohhoghhlvgdrtghomhdprhgtphhtthhopehkrhhishhtohhffhgvrhhhrghu
    ghhssggrkhhksehfrghsthhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprd
    ifohhougduvdefsehgmhgrihhlrdgtohhm
X-ME-Proxy: <xmx:gRNBaU0Yov3pxY9iu51AWoUECWSG7sbeWa8clyoe6M8d7z7mPy3Y1w>
    <xmx:gRNBacde8yhoMIXBhW0qJtt7oI3AUg05wtWPbBpBZ2a7xB8-EIGgqg>
    <xmx:gRNBaUOcPOFTPxcROW1M8Uu5rozJvWFq-BpQ2_wZIS1W2wcIaUCt8w>
    <xmx:gRNBaYUjtxbd05d92RegNQ7Ag7-Azd4WltAJdyRldm9SdUXE1gk14Q>
    <xmx:ghNBaaUHui8PmH3cYIuaBmO3CtNCERhDmUrQGo7bnz4FrE7Ch4jw1mbp>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 16 Dec 2025 03:08:32 -0500 (EST)
Received: 
	by mail (OpenSMTPD) with ESMTPSA id a5194a5b (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Tue, 16 Dec 2025 08:08:30 +0000 (UTC)
Date: Tue, 16 Dec 2025 09:08:22 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Adrian Ratiu <adrian.ratiu@collabora.com>
Cc: git@vger.kernel.org, Emily Shaffer <emilyshaffer@google.com>,
	Rodrigo Damazio Bovendorp <rdamazio@google.com>,
	Junio C Hamano <gitster@pobox.com>,
	Josh Steadmon <steadmon@google.com>,
	Ben Knoble <ben.knoble@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Subject: Re: [PATCH v4 03/11] hook: provide stdin via callback
Message-ID: <aUETdm_-JnL78s8o@pks.im>
References: <20250925125352.1728840-1-adrian.ratiu@collabora.com>
 <20251204141535.1986263-1-adrian.ratiu@collabora.com>
 <20251204141535.1986263-4-adrian.ratiu@collabora.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20251204141535.1986263-4-adrian.ratiu@collabora.com>

On Thu, Dec 04, 2025 at 04:15:27PM +0200, Adrian Ratiu wrote:
> diff --git a/hook.h b/hook.h
> index 11863fa734..51cab785ea 100644
> --- a/hook.h
> +++ b/hook.h
> @@ -37,6 +38,43 @@ struct run_hooks_opt
>  	 * Path to file which should be piped to stdin for each hook.
>  	 */
>  	const char *path_to_stdin;
> +
> +	/**
> +	 * Callback used to incrementally feed a child hook stdin pipe.
> +	 *
> +	 * Useful especially if a hook consumes large quantities of data
> +	 * (e.g. a list of all refs in a client push), so feeding it via
> +	 * in-memory strings or slurping to/from files is inefficient.
> +	 * While the callback allows piecemeal writing, it can also be
> +	 * used for smaller inputs, where it gets called only once.
> +	 *
> +	 * Add hook callback initalization context to `feed_pipe_ctx`.
> +	 * Add Hook callback internal state to `feed_pipe_cb_data`.

Tiniest nit just to prove that I'm somewhat paying attention:
s/Hook/hook/. This definitely doesn't warrant a reroll.

Patrick
