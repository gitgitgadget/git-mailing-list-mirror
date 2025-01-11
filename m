Received: from fhigh-b5-smtp.messagingengine.com (fhigh-b5-smtp.messagingengine.com [202.12.124.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A58C4D53C
	for <git@vger.kernel.org>; Sat, 11 Jan 2025 00:45:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736556321; cv=none; b=RxRutMxkDy4DKm0uyV58tt/8NAaCK9oos3s5oC4Gjw08fpv6nZTlqyiKz0FNuJF3JvXKdexxs1EUKlaV1HeYBQa+7/dwVbLaOVfXY0Pl0gJ4kE37ysIglJjDYNpNirIdra3vJVq5JmE+HFFqV2ZSI56qXDxZVQF+KD8BoeJGIaA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736556321; c=relaxed/simple;
	bh=0nb59FQs5XPKcA5FCT269jnNpsJgZ7A+z5irhuD3AR8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=OY5bGShbIQ0V37xjCSDLvkiB02iyaUKA+wAPmgvXaupEfRXxK/2bqFCxKfybCrJFE9jYZZmTCDZOoVA6FRWX1HLp6uBCsGFIS7tEydR6uGW3jEbjYGcGMM+ewJKRLsqe7O3GDIbq93yP4zlbvZuDRxm/gDy721qWn9lei669Ze4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=69L7Gsn+; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=IfsNtWJQ; arc=none smtp.client-ip=202.12.124.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="69L7Gsn+";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="IfsNtWJQ"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 7AE5D254020B;
	Fri, 10 Jan 2025 19:45:18 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-12.internal (MEProxy); Fri, 10 Jan 2025 19:45:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736556318; x=1736642718; bh=Do6CaQgacU
	rpyiiGua/J8no/lKhn0uDVpwZ3kPRgcKU=; b=69L7Gsn+JU2mfMBSFZum2B0Kkc
	5N80Eu0IvmDpZyWF+lxoNO62eFhgWMm3efgx0lz5a9xg9FAnuqjx9gWlTiDXPlKb
	vnqCGIBHcyvu1nTaBxuCR1cXna3Ct7ZVZI3hhR+HpymLzb3EZoc/Trqj2c0LGABh
	gJqyrlEZmsidqhY1fMQIkrgOQMy3Y4gP1OGYgA69cqB0wqytGJzbXtcbtWOjx/aP
	DDperiZPMHkTOmlleOfHlPPZPGczGJqqleMqlS0AtQ/vN23YwVET4h5qMu4d9xdG
	GgNazEyy+jsNutnxaQIfk/Xm9GVxSZz5uKmHoG5TtCz2C9jvIUl6JF+vKHEw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736556318; x=1736642718; bh=Do6CaQgacUrpyiiGua/J8no/lKhn0uDVpwZ
	3kPRgcKU=; b=IfsNtWJQD3WEgRMU1ni81878wBCmY62IM0E3Nd0FdvmBtH3ErH/
	vSEuZ7RjSsO9GsbhKSFh+MLyxQta2rnp5uDT+/fIUBzY+rnVmOuKSwThHD8GnIU9
	JdBwPC5dMDbW4G0mUGeIhBMqihXhRDcvjJgI9oWuagpz5Mg38EckwAE7LWcB9snu
	JFnB9UN5ZjWXz3hujEvZzCSGO2dFjCCMUer6rR2H1v04oVGOmHDKRM+Cm6Lreebl
	6Klnx47y1ld2HYpeyG3o037e1YncQOExttf5tgMuVPSPY+CjHvXgxq37R3PTR8wr
	M3DA2ON20V46/9c2Ol4V1F2wXaYJAT6n2Pw==
X-ME-Sender: <xms:Hr-BZ7IzWWi3GwjVHb58fbt-bQw-dngwGxWiHd5CAa30SZN6443QTQ>
    <xme:Hr-BZ_IKe94UJ9_z7U_-yNZbU6hADEo3-ZRQ6LBdXUqnnfn5N7F7KQJyIEYMuNdI0
    o7n4qHxd8gT4SNLFw>
X-ME-Received: <xmr:Hr-BZzttsTB84a5K6NRBuKxoh_g237bLwqm4VEbiIRBx_P77ckqMLzJ6tTb-_JPk9cYGAk8fW7AhOzVUDxkQTQOsXTxH5l9LuqoL>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegledgvdehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnh
    htshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtredttdertden
    ucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogi
    drtghomheqnecuggftrfgrthhtvghrnhephfeifefhkeehhfekkeffvdegheevffethfev
    keelkeeileetgeetudffvedtieffnecuffhomhgrihhnpegtrhhushhthihtohhothhhph
    grshhtvgdrnhgvthenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhl
    fhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeeipd
    hmohguvgepshhmthhpohhuthdprhgtphhtthhopehsrghnuggrlhhssegtrhhushhthiht
    ohhothhhphgrshhtvgdrnhgvthdprhgtphhtthhopehmihhrthhhrdhhihgtkhhfohhrug
    esghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdho
    rhhgpdhrtghpthhtohepuggvrhhrihgtkhhsthholhgvvgesghhithhhuhgsrdgtohhmpd
    hrtghpthhtohepshhtohhlvggvsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithhs
    thgvrhesphhosghogidrtghomh
X-ME-Proxy: <xmx:Hr-BZ0bw9UR0NxawdG17BQM_wu85vGYwKUx32-y6r9psB-5m3u-e5Q>
    <xmx:Hr-BZyb2YcMXjCFPIK8pRnFuqZmZYQbNROMqZhrWJExL93yW_XiK1g>
    <xmx:Hr-BZ4COypMUzuxnrP61UmZ6zPIJcPqZL4nCY8CRT0_NMNWPUG09Mw>
    <xmx:Hr-BZwY-47nVaSJUqFIURLq4kuW8wCelfh8y2Tho6yw2nLhEmFIyKg>
    <xmx:Hr-BZ3PpIgnkWN1L82VU9ufvDtqN4_uOU63M2s1sClv0XgRGRrP11FTj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Jan 2025 19:45:17 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "brian m. carlson" <sandals@crustytoothpaste.net>
Cc: M Hickford <mirth.hickford@gmail.com>,  git@vger.kernel.org,
  derrickstolee@github.com,  stolee@gmail.com
Subject: Re: transfer.credentialsInUrl should warn about personal access
 tokens in user field #leftoverbits
In-Reply-To: <Z4G2Ze8S5PKfKjmI@tapette.crustytoothpaste.net> (brian
	m. carlson's message of "Sat, 11 Jan 2025 00:08:05 +0000")
References: <20250110210500.675629-1-mirth.hickford@gmail.com>
	<xmqqh6665p8j.fsf@gitster.g>
	<Z4GZ0oiZCC2Wl3bN@tapette.crustytoothpaste.net>
	<xmqqa5by5lm2.fsf@gitster.g>
	<Z4G2Ze8S5PKfKjmI@tapette.crustytoothpaste.net>
Date: Fri, 10 Jan 2025 16:45:16 -0800
Message-ID: <xmqqv7umb2lf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"brian m. carlson" <sandals@crustytoothpaste.net> writes:

>> When the former is true and the latter is false, it is an indication
>> that for that site with the username-or-token, there wasn't anything
>> necessary to authenticate and the access was authorized.  Which is
>> what the original poster wants us to warn against.
>
> No, I don't think that will work in the general case.  Here's why.  If I
> do `git push https://bmc@git.crustytoothpaste.net/git/bmc/xyzzy.git`,
> that uses Kerberos (Negotiate).  There's a username there to make
> libcurl enable auth, but it's never used and a credential helper is
> never invoked, so case 1 is true and case 2 is false.
>
> Now, we _could_ do that only for Basic auth, which would catch the
> GitHub case.  However, it's _also_ possible to use TLS client
> certificate auth (and I think Bitbucket does support that) and use the
> username only for choosing the account (because, say, your work account
> uses a client certificate and your personal account uses something
> else).  There might be Basic auth sent (say, if you'd set
> `http.proactiveAuth`), but the server would ignore it since you were
> already authenticated via the TLS cert.  That would also make case 1 be
> true and case 2 be false.
>
> Perhaps that latter case is not worth worrying about, but it is a
> possibility and I'm sure some people will hit it.  Maybe with a config
> option for the advice that's okay, though.

Thanks, so in short, if we really want to do this "warning", it has
to look at the "username" string and "guess" that it is something
the user does not want to have as a value to remote.*.url field X-<.

So "should warn" in the title is not really #leftoverbits (i.e. we
clearly know it is a good idea, we just didn't have bandwidth to do
it, anybody is welcome to fill the void) at this point.

Thanks.
