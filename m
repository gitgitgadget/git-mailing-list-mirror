Received: from fout-a2-smtp.messagingengine.com (fout-a2-smtp.messagingengine.com [103.168.172.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52F792727F3
	for <git@vger.kernel.org>; Fri, 22 May 2026 06:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779431577; cv=none; b=BCa67MuZs4/rJhOpObpNaVIwK/FnmveQay8XoY9cc0O9Dhg1NQ4QWni6cWYdKIhUtS8Q14Ho6YNGjR9fiv+MhkvT9x7zaOLScKi9jX2TpkCbzoSH37ltqoxNAyGTC6ZDWApWOCM+7JofKKxD7iV+CjbpsFreveVa3r3SngmV10s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779431577; c=relaxed/simple;
	bh=8EU3AywCLrZcChNvfjcfWMkVj73vBSskT6T6BuNcr7A=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=GBnF6H3S8zBkztEYFCfWg47qq5rLOrayK91MR4OTZVHcW6wCLY0q83X2AVXhuXrliQPD6HOa2vMhezDKB1dVNcCuxBSegDtUh5iwga6F6A9yr/PQlAOFmw6J6522KbpHO0Md7gJAs+y5hSUVF1Xmn2QoV5t0YzqQWaPnNxhZ0Us=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=WiwTFfzP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=vEX1zOQ9; arc=none smtp.client-ip=103.168.172.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="WiwTFfzP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="vEX1zOQ9"
Received: from phl-compute-04.internal (phl-compute-04.internal [10.202.2.44])
	by mailfout.phl.internal (Postfix) with ESMTP id A01E9EC00AB;
	Fri, 22 May 2026 02:32:54 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-04.internal (MEProxy); Fri, 22 May 2026 02:32:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1779431574; x=1779517974; bh=/SrJNGmM4U
	xIKH0paK3R522np3hMJlzdYUYGIdAvtVw=; b=WiwTFfzPZWrFdTWj5t7/ga3j/3
	/TdMJanF3gud6DJX0anwi9LipXPyTA3D7ROtvXpDufTAPKsUcP99J3j5z/1JXq1u
	dE8T9OkvteyHzWytKfeg9HokM/1oLSNF/mGQjJNJ/Gfyoyrl6XEpEEnY5CGf03Dm
	SqIDoVyhpvQAKCv8MkMiYTld7sxCug6Kt2+eAaq55wQB9nQduwbaBwy06X+LLcFx
	4yhSOnwaP20CrVV1j/Ww2too948a8j89Lko7SAjx7fjtItMG3lhFEfBL8InW/Rlv
	bZjVxzZSMdbmqBN1bbR5UxI0uRzPp7HwvDtJ3sGFSA06qpJE2gwVOMCu+hYw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1779431574; x=1779517974; bh=/SrJNGmM4UxIKH0paK3R522np3hMJlzdYUY
	GIdAvtVw=; b=vEX1zOQ9BK3S+1Dy42CzPdhsPZqU5CGNU9D7NQXVGyPfy0hXyE6
	V+LWzLRfuTnNpNTMDeVFVZL3MZpn4cj0O4gE29MAod03pdBNvQ7j/fdNFdasR29J
	nwZoYBLGsI76hHNthEK3kTTiwp+p6bb+vuEEXHc9RFfKrkeQ7eBDLSAMMA8uiD17
	7SblKnYR6/ybYr8pMOgm6j+fPdwyMWeqmxkvLa4B5vmobRkusAe96hZun2yoGCmq
	7YAh5+qay45DcB2oiOmqi1U6WQbdCXXMCaQ7lhUS8G49L0Btrk3SIHp2N/IwlHVQ
	r0O+nW26NSHvKk2/arkifRaeJPhPan3VOww==
X-ME-Sender: <xms:lvgPatdOKujyBpibiCzp31V0o9VgCY98bi__cm9cc7santbXdLUlNg>
    <xme:lvgPaqS2dYsjR75F2qWaIIfEMMxiL40HV8Ow-IV4mJIDpeN-riqaJSFV1XBXDYIvY
    gJD-fSPWCxPft55du7GYWVtsL6kSxwSvD02_BE1sDMZ9I4fzqguxA>
X-ME-Received: <xmr:lvgPasvZ8k1Lsc5BLn52oxSZZNZ65sTUEoluL9lhXJXHEYekFWPRtvtrzsvC0fhTkfoIU0f8ZQoZTs-2-AYjFt9m376YG9Nfkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefhedrtddtgddugeelieduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepkedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepshhiugguhhdrrhgrmhgrnhdrphgrnhhtsehorhgrtg
    hlvgdrtghomhdprhgtphhtthhopehjiehtsehkuggsghdrohhrghdprhgtphhtthhopehj
    ohhhrghnnhgvshdrshgthhhinhguvghlihhnsehgmhigrdguvgdprhgtphhtthhopehgih
    htsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtoheptghouggvsehkhhgruhhg
    shgsrghkkhdrnhgrmhgvpdhrtghpthhtohepnhgvfihrvghnsehgmhgrihhlrdgtohhmpd
    hrtghpthhtohepphhssehpkhhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:lvgPajc7IKYpgcC5vDL2l3-Y5mKLfa8ArTeknzPNG8XBD4Z-x5b2ZA>
    <xmx:lvgPauYu3yGTmR-AlCwvwY0HeKzR_sYDGgfIgzNsb4nRHCBOzOXJVA>
    <xmx:lvgPataZ6YBHRYUmP-rhIfCdZzkX_e2TRVLnrYw1CCpKJkJgi2J46A>
    <xmx:lvgParIUuKsQYGpxlxEsmfntxhH3VpoSKN2oENZeiXf5bWhplwYQqQ>
    <xmx:lvgPak9Aj3NhSq6KDgKD4VJgsbkmpGcGzvfSBBSJvR_4ijZdsbouHT9U>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 22 May 2026 02:32:53 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Siddh Raman Pant <siddh.raman.pant@oracle.com>,
    Johannes Sixt <j6t@kdbg.org>, Johannes Schindelin
 <Johannes.Schindelin@gmx.de>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,
  Elijah Newren <newren@gmail.com>,  Patrick Steinhardt <ps@pks.im>
Subject: Re: [PATCH] compat/mingw: Allow SIGKILL to kill in mingw_kill.
In-Reply-To: <20260522061652.50078-1-siddh.raman.pant@oracle.com> (Siddh Raman
	Pant's message of "Fri, 22 May 2026 11:46:52 +0530")
References: <20260522061652.50078-1-siddh.raman.pant@oracle.com>
Date: Fri, 22 May 2026 15:32:52 +0900
Message-ID: <xmqqwlwwt0mj.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Siddh Raman Pant <siddh.raman.pant@oracle.com> writes:

> mingw_kill() only allows SIGTERM for killing a process.
>
> Let's also allow the natural SIGKILL for the same so that callers don't
> have to do ifdef soup for special Windows handling.
>
> Signed-off-by: Siddh Raman Pant <siddh.raman.pant@oracle.com>
> ---
>  compat/mingw.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

I do not do windows, so I'd like to ask those much more clueful than
I am to see if they see any downsides.

The current code only handles TERM (to terminate) or 0 (to probe)
and everything else results in EINVAL, so the updated behaviour is
to pretend as if TERM is sent and do whatever PROCESS_TERMINATE
does, instead of doing nothing and erroring with EINVAL.  Which does
sound like an improvement over the status quo.

What I am wondering is if there are different kind of "kill" in the
Windows land, just like there are distinction between TERM and KILL.
For example, the program ought to be able to block TERM but not
KILL.  There are other termination-inducing signals like SIGQUIT but
until we start using them in our code, this emulation layer does not
have to know about them, I think.

Thanks.

> diff --git a/compat/mingw.c b/compat/mingw.c
> index aa7525f419cb..00a994aa9f47 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2250,7 +2250,7 @@ int mingw_execvp(const char *cmd, char *const *argv)
>  
>  int mingw_kill(pid_t pid, int sig)
>  {
> -	if (pid > 0 && sig == SIGTERM) {
> +	if (pid > 0 && (sig == SIGTERM || sig == SIGKILL)) {
>  		HANDLE h = OpenProcess(PROCESS_TERMINATE, FALSE, pid);
>  
>  		if (TerminateProcess(h, -1)) {
