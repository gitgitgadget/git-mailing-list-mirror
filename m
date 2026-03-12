Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C260F29D27D
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 20:49:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773348553; cv=none; b=may1AFB1UtCs9MCiQ+noz/euTgakhCDFvKKy2deqGDCZakUwEC1b0GzE2vbpCPxxhvmvOiKJtQfCxguso1OxRoZE0YTpY5t1cOS7rgOzAckStINW+ToiY7gOAZeCQdELxtg0HyoWIvgC9BGFJGBw3qembfxLs59JzearaKQPimk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773348553; c=relaxed/simple;
	bh=ED7BxLVEmhhROkvKYBANENcdw+PiOBqBB5NoLEEpIDM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pTUufweoEw00SU6LRbsx80scxzv6jitxF09UxVse0LKSagZR5gVAzzdbv71usfE7Rr2S/hYzbMht7bnJYrg2CqKaIDyHYVupaLB+YS/HvTgNs1lCNN7E3NvNVwffErN0bDAsGXpOp8LHTUP4+1RyHrf629ZCRVS1shGZYzZt9Qs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ItbVJav1; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=4DQ5wbaa; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ItbVJav1";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="4DQ5wbaa"
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfout.phl.internal (Postfix) with ESMTP id 0FBB8EC0B02;
	Thu, 12 Mar 2026 16:49:12 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-06.internal (MEProxy); Thu, 12 Mar 2026 16:49:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773348552; x=1773434952; bh=st/UokuU7q
	zlKWuZHwYi1O8DE7OE8C5RJrIk8iJCVnE=; b=ItbVJav1q2RliPm37quuavFtG9
	KB3SBMCNeExU7A4etrf0PTU+VHncbJ/8zAcEmmZW16Fhn7px4ceX4gy9aEp5L2aG
	Yc5k1DM7q0JKgJYXUA5tKYHVBNvGWfHP5uvu2JMF0m7SoSErTrXKcPDvc2Jq4mAm
	6Da4hiv/yzORWt0ZVy0elvnt8w+EX+/+lXocpwK6VuQfWSIDIGsS2iRm3BbpI30B
	4Rk3YsIsCCzh8w2j7Don9y64ugNnoLCZDG18J35sLRRvcV1aXRDr3X1v8S55ZtzQ
	i8dna0zQBv2cS7PvIKE4TUPSsqRX+qIVJV/o1pQ8I6QsodMYfyNcerYetVeA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773348552; x=1773434952; bh=st/UokuU7qzlKWuZHwYi1O8DE7OE8C5RJrI
	k8iJCVnE=; b=4DQ5wbaad6pyvX7hoMaR1sEkJ9nbNyDaAUW7+px9dKuV/ga9p/x
	zJbUJQukB6/9hDmyHpF/v++CjyjhUjguixKJ3hoadVnwyEldebzxV6DLNkML0DyO
	U+qGNhIXsOHAyAKzENDtA11XjgaDru0Z23p1tjkvMjeLUqzY5mPiICTTf5xJ/f3p
	YWAYc5fG1joee3465+lH8fE741eGO7euDq9pDNr8cVOnw7lt6c8kY39s1U+V1znl
	q2ZZ5ypZUzTNVivxU71syyzc9NHLmOCGPu0nd1R1lnwUpZjHcUAJTldSweQXDOS/
	rJaZZaDCpkO/StRUZqFWWzb6wyRvyWayQtA==
X-ME-Sender: <xms:xyazaU-0ZTb3li_z3bllIt-UnVCjmx5aqwltoS6G-L1-v8mNheO3DA>
    <xme:xyazaTuAT6cRFGEJUBMS35WWNgj7OuhrAjQ324DPdjtN8g-lO5Ynf-XKBurttc_lE
    zXU2VrxBJGEhsTPbYGnRZjeANrXHaiLV7bByEvK5Ipwvx2kLEgq>
X-ME-Received: <xmr:xyazafCoXHjn-0hTubgA-Em-pGeiQphhshBFH1l94pHMCzP_zbfz_mBy49HJyAF-y5F9L-VrJGCp3WNLUhDKYcPzAbUXE4ueHw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejjeekucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucenucfjughrpefhvfevufgjfhffkfgfgggtsehttdertd
    dtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghnohcuoehgihhtshhtvghrsehp
    ohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeefveetteejheeugeffledvteeive
    ffueefjeelueffteeigffgfedthfefieegieenucevlhhushhtvghrufhiiigvpedtnecu
    rfgrrhgrmhepmhgrihhlfhhrohhmpehgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsg
    gprhgtphhtthhopeegpdhmohguvgepshhmthhpohhuthdprhgtphhtthhopegtshhhuhhn
    ghesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrd
    horhhgpdhrtghpthhtohepphgvfhhfsehpvghffhdrnhgvthdprhgtphhtthhopehgihht
    shhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:xyazaTWcmzVRx1VgwDsDYx8xoaCDDcoAjt66EbERhrd-w6pAVvsX7g>
    <xmx:yCazaVBWtkU87izLYth4dKwGNFWo4V8BXz5BgbNiBMaOM6y1Fizy1A>
    <xmx:yCazae_thMDq4Vvcc0fgdXFDlD-SN61Tt_Kbvk0Ha0H2tN9LAKVkPg>
    <xmx:yCazaUEcnYiIvyb0OWwKT7Z__kWtTLWhNNxvUTERDdZRzxNm9NeRyA>
    <xmx:yCazaS8KMgzIr313yR592zKg57dz5SWPUsOG3V5pjUCo5oy5MW8eYsMJ>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 16:49:11 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andrew Au <cshung@gmail.com>
Cc: git@vger.kernel.org,
    peff@peff.net
Subject: Re: [PATCH v3] transport-helper, connect: use clean_on_exit to reap
 children on abnormal exit
In-Reply-To: <20260312195813.4006430-1-cshung@gmail.com> (Andrew Au's message
	of "Thu, 12 Mar 2026 19:55:59 +0000")
References: <20260311184206.GA1911377@coredump.intra.peff.net>
	<20260312195813.4006430-1-cshung@gmail.com>
Date: Thu, 12 Mar 2026 13:49:10 -0700
Message-ID: <xmqqzf4cbwop.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Andrew Au <cshung@gmail.com> writes:

> When a long-running service (e.g., a source indexer) runs as PID 1
> inside a container and repeatedly spawns git, git may in turn spawn
> child processes such as git-remote-https or ssh. If git exits abnormally
> (e.g., via exit(128) on a transport error), the normal cleanup paths
> (disconnect_helper, finish_connect) are bypassed, and these children are
> never waited on. The children are reparented to PID 1, which does not
> reap them, so they accumulate as zombies over time.
>
> Set clean_on_exit and wait_after_clean on child_process structs in both
> transport-helper.c and connect.c so that the existing run-command
> cleanup infrastructure handles reaping on any exit path. This avoids
> rolling custom atexit handlers that call finish_command(), which could
> deadlock if the child is blocked waiting for the parent to close a pipe.
>
> The clean_on_exit mechanism sends SIGTERM first, then waits, ensuring
> the child terminates promptly. It also handles signal-based exits, not
> just atexit.
>
> Signed-off-by: Andrew Au <cshung@gmail.com>
>
> Co-authored-by: Copilot <223556219+Copilot@users.noreply.github.com>

Do not throw a blank line inside your trailer block.  In addition,
we do not want somebody who cannot stand beind the patch and certify
DCO listed there.  See also SubmittingPatches::[ai].

> Thanks to Jeff King for suggesting the clean_on_exit approach,
> which is simpler and avoids potential deadlocks from the atexit
> handler in v2. Also thanks to Junio for catching the inaccurate
> description of the PID 1 scenario.

This version looks quite simple and clean, taking advantage of
existing machinery to clean these processes up.

>  connect.c          | 4 ++++
>  transport-helper.c | 2 ++
>  2 files changed, 6 insertions(+)
>
> diff --git a/connect.c b/connect.c
> index eef752f14..5039adca7 100644
> --- a/connect.c
> +++ b/connect.c
> @@ -989,6 +989,8 @@ static struct child_process *git_proxy_connect(int fd[2], char *host)
>  	strvec_push(&proxy->args, port);
>  	proxy->in = -1;
>  	proxy->out = -1;
> +	proxy->clean_on_exit = 1;
> +	proxy->wait_after_clean = 1;
>  	if (start_command(proxy))
>  		die(_("cannot start proxy %s"), git_proxy_command);
>  	fd[0] = proxy->out; /* read from proxy stdout */
> @@ -1447,6 +1449,8 @@ struct child_process *git_connect(int fd[2], const char *url,
>  		}
>  		strvec_push(&conn->args, cmd.buf);
>  
> +		conn->clean_on_exit = 1;
> +		conn->wait_after_clean = 1;
>  		if (start_command(conn))
>  			die(_("unable to fork"));
>  
> diff --git a/transport-helper.c b/transport-helper.c
> index e95267a4a..6633a999b 100644
> --- a/transport-helper.c
> +++ b/transport-helper.c
> @@ -140,6 +140,8 @@ static struct child_process *get_helper(struct transport *transport)
>  
>  	helper->trace2_child_class = helper->args.v[0]; /* "remote-<name>" */
>  
> +	helper->clean_on_exit = 1;
> +	helper->wait_after_clean = 1;
>  	code = start_command(helper);
>  	if (code < 0 && errno == ENOENT)
>  		die(_("unable to find remote helper for '%s'"), data->name);
