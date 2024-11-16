Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F04558222
	for <git@vger.kernel.org>; Sat, 16 Nov 2024 11:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731756316; cv=none; b=IKL+Nez/hD/r24LNLWDUPKsDcGfFmAxV04jQgwm/wbNH8A59ZVGXSG+zR0HTdtZ6LNRhSYGUE1UAiUByocwQQNF6JaBGGAaWF/tZgg1wqt0XdMULbdLbDwv5oYI9spXDS3WuqO3NMgE/uGYzLROj7oXVPs7D+MMZDrKuE07pOwM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731756316; c=relaxed/simple;
	bh=oDhwGLR3WJ7Dnnw5Cfzih/HoVVy9JGED8bO1pet63Ro=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=snAlsELUKWE1yrbJSID6+ALptVX7PqoVoKfoZxO/h2dGQc8rUDudi3h8Z7EzdB+MSV79UJqzOOtBj842YdKFmzapBTz4hoMkMwGlMdooN3sC2esyaMsYcXGyiuCkv8bkMsiGovOzTCzT4jUqbqbnOWyNjXMOnkGh9k3D3Dyr5jQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=t/NO1SHe; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=k5UIMFy9; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="t/NO1SHe";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="k5UIMFy9"
Received: from phl-compute-11.internal (phl-compute-11.phl.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id E6BD81380501;
	Sat, 16 Nov 2024 06:25:11 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-11.internal (MEProxy); Sat, 16 Nov 2024 06:25:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-transfer-encoding:content-type:content-type:date:date
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm3; t=1731756311;
	 x=1731842711; bh=beLii466CJjh+gvF4R5IhENSV7td7157tYXzYrNaGIQ=; b=
	t/NO1SHeAG1dR2NB84A3pBiJd9ClIPnIb6NoNVrwzr+FQQQ/EHad/VXW/nYymkHp
	vnbKhcy2UCOTWd3pz+y4Vy5iqlPyvkRj6+ZRW8Z+F+71956i8CDr9A2tvhhKhemR
	q41sJX5zWvZC/TovuMUAzN9sKxsSfwMmxpYzZniMtYG7nhUfboyt86Ggud2e5Apy
	QLcVmMJidSnjQF/GA+IsLq6GRhy9bW77noz8BKha3G8kZyFIRCtew/CLUee0t7Nr
	JlDEkPcbaV1gFn3WPu+blBQpqzT4vGcqc6zGFT2LP2i0+1hpIjNxtJimBqblE4Zv
	QrWZ5RjgTMYXSS9YCC1UfA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1731756311; x=
	1731842711; bh=beLii466CJjh+gvF4R5IhENSV7td7157tYXzYrNaGIQ=; b=k
	5UIMFy9Q0FHwaYexsvBhwERfmepKLYCXd3chf/RujAgUPglUQv3SgdtDFLEsN8PE
	TE1uXQsvueXWe2PqppjWM9D3XNzifIBZQsYDJzL6umycL5nfmS68WsuRWTq/4ptl
	O+xj/rempPifKYk/mFfRHAl15830OeB2YDhBlIhtykIwSjCIPOEUYpAOaacTe+fc
	fJmYJLcFsHBTDcwI/z0dVOaDvDU/bzrD95EILTp41DFwGQe/9SpxZTkfvUwP5zSN
	M5yXqKevBqxFzpJkRDRnIvd5HiRK0BB+WKjrBbTZmZJf+oH/ckU6oWxR2dY445as
	WYaz8oi9rNuKT8GOy/l/Q==
X-ME-Sender: <xms:F4E4Zw8wbQbyuR2F_zXcusZVbH8nD5-73lTeeFRmU9WUTt1b6cYYLQ>
    <xme:F4E4Z4sMdW1Gcg2dEPtYOhGpgxu6UPTgnPWWf_cjOCWOeRH_rVa0TTAKX1ybOCut-
    O5vQI9XrAPKyAKMtw>
X-ME-Received: <xmr:F4E4Z2CRn9VggNwk-9nItDddKzyIij3f1LICIRZXu7m8J3cuhtGImiwICobnc_YhMKSnBBcEyGcDIpPvGT99_Z_zO631rwtS18ldJjXzNyn3wg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrvdeigddvhecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecunecujfgurhepfffhvfevuf
    fkfhggtggugfgjsehtkeertddttdejnecuhfhrohhmpefrrghtrhhitghkucfuthgvihhn
    hhgrrhguthcuoehpshesphhkshdrihhmqeenucggtffrrghtthgvrhhnpedvfeejiedtte
    elheeiteekveeftdefvdehkedvveetffdvveevjeejleegtedvgfenucevlhhushhtvghr
    ufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehpshesphhkshdrihhmpdhnsg
    gprhgtphhtthhopedvpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopehgihhtshht
    vghrsehpohgsohigrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlh
    drohhrgh
X-ME-Proxy: <xmx:F4E4ZweS8Nq3h_35rdtaUenJeSGF0f9iVdqp5Oe8UsGRKg4R1pjNnw>
    <xmx:F4E4Z1M7WEjgwpQVgQjLeqyn_Cq4SrRApIwelqCX0T_4w16o5jQ_-w>
    <xmx:F4E4Z6lwSD4JawtnHjmip7qTDm_Yciisz4p-MW6xI79gJUztffopRA>
    <xmx:F4E4Z3tfeXbDN1EO8hDq4SgjKUUx2rEHCAytePSmc7E8sgoLq_Z33w>
    <xmx:F4E4Z-Y_Av35ECKeWTSCpL94jQxHjKnYKSxmnRzIVHyDR9G1G_3cPisZ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 16 Nov 2024 06:25:10 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id b607cdb8 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 16 Nov 2024 11:24:23 +0000 (UTC)
Date: Sat, 16 Nov 2024 12:24:02 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2024, #06; Thu, 14)
Message-ID: <ZziAy187d_VU55QM@pks.im>
References: <xmqqy11kys9z.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <xmqqy11kys9z.fsf@gitster.g>

On Sat, Nov 16, 2024 at 08:46:32AM +0900, Junio C Hamano wrote:
> * ps/clar-build-improvement (2024-11-12) 4 commits
>  - Makefile: let clar header targets depend on their scripts
>  - cmake: use verbatim arguments when invoking clar commands
>  - cmake: use SH_EXE to execute clar scripts
>  - t/unit-tests: convert "clar-generate.awk" into a shell script
> 
>  Fix for clar unit tests to support CMake build.
> 
>  Will merge to 'next'?
>  source: <20241111-pks-clar-build-improvements-v2-0-d4794d8d1b30@pks.im>

I've sent a v3 yesterday that fixes a single commit message issue via
[1]. That version should be ready for 'next'.

[1]: <20241115-pks-clar-build-improvements-v3-0-29672bf65ec6@pks.im>

> * ps/send-pack-unhide-error-in-atomic-push (2024-11-14) 2 commits
>  - transport: don't ignore git-receive-pack(1) exit code on atomic push
>  - t5504: modernize test by moving heredocs into test bodies
> 
>  "git push --atomic --porcelain" used to ignore failures from the
>  other side, losing the error status from the child process, which
>  has been corrected.
> 
>  Comments?
>  source: <20241113-pks-push-atomic-respect-exit-code-v1-0-7965f01e7f4e@pks.im>

Jiang Xin has sent an alternative series that is more involved. I'll
have a look at it.

> * ps/leakfixes-part-10 (2024-11-13) 28 commits
>  - t: remove TEST_PASSES_SANITIZE_LEAK annotations
>  - test-lib: unconditionally enable leak checking
>  - t: remove unneeded !SANITIZE_LEAK prerequisites
>  - t: mark some tests as leak free
>  - t5601: work around leak sanitizer issue
>  - git-compat-util: drop now-unused `UNLEAK()` macro
>  - global: drop `UNLEAK()` annotation
>  - t/helper: fix leaking commit graph in "read-graph" subcommand
>  - builtin/branch: fix leaking sorting options
>  - builtin/init-db: fix leaking directory paths
>  - builtin/help: fix leaks in `check_git_cmd()`
>  - help: fix leaking return value from `help_unknown_cmd()`
>  - help: fix leaking `struct cmdnames`
>  - help: refactor to not use globals for reading config
>  - builtin/sparse-checkout: fix leaking sanitized patterns
>  - split-index: fix memory leak in `move_cache_to_base_index()`
>  - git: refactor builtin handling to use a `struct strvec`
>  - git: refactor alias handling to use a `struct strvec`
>  - strvec: introduce new `strvec_splice()` function
>  - line-log: fix leak when rewriting commit parents
>  - bisect: fix various cases where we leak commit list items
>  - bisect: fix leaking commit list items in `check_merge_base()`
>  - bisect: fix multiple leaks in `bisect_next_all()`
>  - bisect: fix leaking `current_bad_oid`
>  - bisect: fix leaking string in `handle_bad_merge_base()`
>  - bisect: fix leaking good/bad terms when reading multipe times
>  - builtin/blame: fix leaking blame entries with `--incremental`
>  - Merge branch 'ps/leakfixes-part-9' into ps/leakfixes-part-10
> 
>  Leakfixes.
> 
>  Will merge to 'next'?
>  source: <20241111-b4-pks-leak-fixes-pt10-v2-0-6154bf91f0b0@pks.im>

Rubén's review went through all of the patches and his findings have
been addressed. The other comment from Peff seemed to only relate to
dropping the use of `UNLEAK()`, so I don't think he had a full look at
the patch series. So personally I don't plan to reroll this, but am not
sure whether this had enough review exposure.

Patrick
