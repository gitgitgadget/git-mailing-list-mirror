Received: from fout-a5-smtp.messagingengine.com (fout-a5-smtp.messagingengine.com [103.168.172.148])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51FFE3BB9FA
	for <git@vger.kernel.org>; Thu, 12 Mar 2026 22:04:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.148
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773353060; cv=none; b=ArxDEUiau0pLrdmeC4WISwj5r8uev8vahJ7MLLqfe1mWIV1mFuWnJXFRkD4Ydpgyt9vBqgvZukZAflnqiqNoaxUzwA5RMagyvnQdHeMKhzuh8oYJ9DEEpEwtfdR14pHwNR69EyWLmbWYcHEYpOo9+lnTuBtVKQyn8La0kY094vE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773353060; c=relaxed/simple;
	bh=+TmF7psuUeXdI5GNqAt0l7ZFHIcytuQkJMSg4/hHlYA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=ED4WQPBAW+nPQqbFBPw96XB4uamW7HkxaaTjtpKUxEZe4zZbwi4u3lGSskVpjspvh9JI6gM+Ntiw+gmZ9I3S/1Fcj/IU5CRLynn/DwMhYjzEclDLqeqM3Oea+h7VyONNtl75dYdRXGxgpaxAfJu1jhFZ2zChZq6boNiiY4ZsBeQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=AaednxWd; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=rNZiFIds; arc=none smtp.client-ip=103.168.172.148
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="AaednxWd";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="rNZiFIds"
Received: from phl-compute-09.internal (phl-compute-09.internal [10.202.2.49])
	by mailfout.phl.internal (Postfix) with ESMTP id B4DB3EC0538;
	Thu, 12 Mar 2026 18:04:18 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-09.internal (MEProxy); Thu, 12 Mar 2026 18:04:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1773353058; x=1773439458; bh=nf//3pC9Et
	QJgr/Od7vCeXVfJiIJNo+a/px8lvgIsM8=; b=AaednxWdD45bHpVBt0We84YojZ
	Q9ZZWDO25v+FogMuYU+n1Su9YEr1a9WIsjFaAjo66J3b7C2HStiEKJi7e+x/bh+e
	bwIiN+0KJUA5YSvzIBtsWB8HsmCrlEvd17aRjF6u/Fq9NBCfHWAwGkn42nP03Zss
	YyGQbC6WjcjgA3mLmp/k7kkE0lcWy6GniD7t+rwTI3lJvL+5KZNt28RANSvccMNb
	MFj01ixUCv6uFs2040X7XMm0iNaDJqmSknSvzU+eDuHuP7pPp7L9dp24+FSCgfzJ
	teKaIhoIPz02I1MtlHDogkvQtuGw22NqWtqqVdHp2gV3pt841YMuE60XQxlg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1773353058; x=1773439458; bh=nf//3pC9EtQJgr/Od7vCeXVfJiIJNo+a/px
	8lvgIsM8=; b=rNZiFIds8bVr37scwWM/XsyTKmMLN2+wnFg4UvW1c4/ukDkUhyz
	CHFKjEmwosl47IsdCz0I+roKKDnKTe9NIJmv1x1CyvV+ORwilX65fJN2IVG94PhB
	VXvVC5Zax6F2TpxApUT2sB9n+dNrPRGJRkwzJ6SJe8/6yGwVjxEodynUOVWHM0kY
	3zYkEP+Q/0jUSmXFMJsZJqqQOskIe/Xco3AqblNaLRKJ4p+0ceWv7lHfwbG20wsV
	qSpsRDewhRx8LzDxRnjt3kuZhq/Jt01QJqVNf9JjIssZ+iY9Swv05NoRsJSucGsk
	rra+3mY20e4iqYT0ZOrIOAePXSMWFHo6XVg==
X-ME-Sender: <xms:YjizadAvTBxQzD3eW2_-TOHpSv88IP8wzStKeCw4zDjv7r03R1yrIw>
    <xme:YjizaSj8U1ZTtJ3MgIql-ZjPYHUPjd5xo6kXuaLw-7w6X_EQE8JLFgKrTL9a2Uw-O
    dOL1Q-zY4HkeW8BYWONm-MVsgj8-9ADdYtjF1tFUrhgOaaBEo1s>
X-ME-Received: <xmr:YjizadlaGMniVE6-PTvk0wkp2QFypRmAe-Ia1nkdBnq57zZO5jBXCEOA_qdNXCUj1rWmpMIghBO1gGgiPbj9yQ6wiYOQ92Yc_Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvkeejleefucetufdoteggodetrf
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
X-ME-Proxy: <xmx:YjizaWqyKUj47FFN52pFE6g8REMkO5mAUX0pPRh4uEle892f8pMzEw>
    <xmx:YjizaeFoBUPx3aj3kPpy16pp7d_ANATvb2RrQKKEReAeWrdO7zCntA>
    <xmx:YjizaawbioERwqiQ7ZrSngKw81xY6KsqWLzRz0Aa_TgOZto0OZoXBQ>
    <xmx:YjizabpjJW_50UXrove5OnOgdFbg_XDhpIzX-zhSQ7tWDutdqNLF-w>
    <xmx:YjizaXg1cIJK0fR_WRYT9Tfx_c98jedRTtbp11rPlnyflPOXjAMoqESf>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 12 Mar 2026 18:04:18 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Andrew Au <cshung@gmail.com>
Cc: git@vger.kernel.org,  peff@peff.net
Subject: Re: [PATCH v4] transport-helper, connect: use clean_on_exit to reap
 children on abnormal exit
In-Reply-To: <20260312214945.4050010-1-cshung@gmail.com> (Andrew Au's message
	of "Thu, 12 Mar 2026 21:49:37 +0000")
References: <20260311184206.GA1911377@coredump.intra.peff.net>
	<20260312214945.4050010-1-cshung@gmail.com>
Date: Thu, 12 Mar 2026 15:04:17 -0700
Message-ID: <xmqqsea4aen2.fsf@gitster.g>
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
> ---
>  connect.c          | 4 ++++
>  transport-helper.c | 2 ++
>  2 files changed, 6 insertions(+)

Thanks, queued.


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
