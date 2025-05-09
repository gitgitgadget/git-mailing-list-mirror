Received: from fhigh-a5-smtp.messagingengine.com (fhigh-a5-smtp.messagingengine.com [103.168.172.156])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D3ABB2376EB
	for <git@vger.kernel.org>; Fri,  9 May 2025 20:37:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.156
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746823070; cv=none; b=LdTLbbHk6X+qs3gVif4f6sDA8DN44FnOPsyDQcgNz2LYsVy4P2mKrnPqsBoC2mItbIdk6CzgR3d8gagNsbsISfQ/dYJAfsLqHyTDn9Zwa9ZCpwpnHYl7BdkDoMvg84SsJfSGs19E5i9pF7ToX8+x+G0Pq0nbdl/kNZWttDK3Lc8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746823070; c=relaxed/simple;
	bh=x0mEqIQ0gD7i4c/Fz5aQZ18U5i61WwCUcEWZRfCkX3s=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=LBfeMvejW0KlTpaAxSEiPyoqdwN0XYTREtr18BBsBMa27QiBVrC/E1F3SL3BT+u3Pte4oL16ipqT78R0OQrE0BVFz8NdR6nTBo3z/+2JafCew35v0vK90W//HFbjOGsZKx4/Fwkxtn/pXOObXqHeLK9+8H5wwHE52eB42CTsHzs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=KFy1+3r7; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=sfuNY8Vm; arc=none smtp.client-ip=103.168.172.156
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="KFy1+3r7";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="sfuNY8Vm"
Received: from phl-compute-06.internal (phl-compute-06.phl.internal [10.202.2.46])
	by mailfhigh.phl.internal (Postfix) with ESMTP id A28EA11400C7;
	Fri,  9 May 2025 16:37:46 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-06.internal (MEProxy); Fri, 09 May 2025 16:37:46 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1746823066; x=1746909466; bh=A5C2YIWd9i
	25WBDxPV/YlDUjSgwIH/Z18AeE3xGWmQU=; b=KFy1+3r7S3roTbKadheqfvRTAm
	m/PYFUIj5XNfX0IQRZvq5ailhhB9DlVmLQuKp/x9hIYhv0TXiEtf3nzxa7Ice6+W
	qZCX/0VKEKRTCP4w3DWHCsCelIQ5qIRt56/wlvzmk+eY6ydw/mLwd84IAJMPgcHd
	Kdox1G9IsS1rIbIN48Svh8BDn2V6WpEwQaOTmISweFoa9cDrGqbEMCsp374S6kQR
	/UtsiaPmWvL1ZVSy396ID/5zSu94iZFMvMvRED2tV+Ctk4tKLKHasuOpDJYi8i/Q
	e0NfxwVuUQ5F7cUFn1mk22HXCS7xQGHUKQ9/NNVHIQ66xmgOvwE7ae+AGwUw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1746823066; x=1746909466; bh=A5C2YIWd9i25WBDxPV/YlDUjSgwIH/Z18Ae
	E3xGWmQU=; b=sfuNY8VmK7zNwR9LJC6U1BbLK5VrwyP/UQT4u8LoHCIceUQz9wr
	rsH4XQefIgWfwZMmNN/AF7H417fcL/iJ+le9T4hfLHfAxCfyzwwJ9lGnfvWCel16
	2txK0uz6+/DfnQxisfjlZmausofI/IKq3IT14mCLVocQFLRUX1xcVr1U6hdSViSR
	tg8pF1FRI3X3WUaAiksCvrUwxru6IiFcxllFdTqNA9tXYUXzZr5D4Lnt5DZH2fSL
	Wi6FW2O8fHXGWNfALJSCeWkQYWOJEr7BjDF+jOVRfbkGpNGY/MIYqbd4DVoMKby6
	AVs61nWj3UrMxj81iwEXr7GKMyjLe6A/jvg==
X-ME-Sender: <xms:mWceaOsFb9SNzZjx5YRPzN07D9zAfQXPbvivuTYLllQtplt01_pu_w>
    <xme:mWceaDfDMLlH_Gf6JCaF4UvqtUmP0-F7ZkfDD6tmBeTqUxaan-x6apLA2ryD3zQLU
    IZYXZU7XekZ9gkB2g>
X-ME-Received: <xmr:mWceaJzgOkm80zCWMHugIkundxoT6DsFFVtyhYQ1q75a64RiKsqgzXoZg1O_ZuMV4KH9Ho_cmUXvR1nSswGN7cxX6B5wF52uBaVS>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefvddrtddtgddvleefiedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggv
    pdfurfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucesvcftvggtihhpih
    gvnhhtshculddquddttddmnecujfgurhephffvvefujghffffkfgggtgesthdtofdttder
    tdenucfhrhhomheplfhunhhiohcuvecujfgrmhgrnhhouceoghhithhsthgvrhesphhosg
    hogidrtghomheqnecuggftrfgrthhtvghrnhepieekueefhfetvdfftdegfeekhfffgefg
    feeivddugeffgfffffevvedvieelffdunecuvehluhhsthgvrhfuihiivgeptdenucfrrg
    hrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghr
    tghpthhtohepiedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepghhithhgihhtgh
    grughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghr
    nhgvlhdrohhrghdprhgtphhtthhopegtohguvgeskhhhrghughhssggrkhhkrdhnrghmvg
    dprhgtphhtthhopehpvghffhesphgvfhhfrdhnvghtpdhrtghpthhtohepphhhihhllhhi
    phdrfihoohguseguuhhnvghlmhdrohhrghdruhhkpdhrtghpthhtohepghhithhsthgvrh
    esphhosghogidrtghomh
X-ME-Proxy: <xmx:mWceaJM2kbCK3u393Neb3kytUbENUI14TgdGME39Qvcgw_RS_rvvmA>
    <xmx:mWceaO8SpKoF1DSMxI7YEtPeyZq42UjVFBnviCzvNRRB3sQUDmL-ig>
    <xmx:mWceaBVmGUgpZ8v1dCf3K48jSaLUzBVfMiblUG9CwHS76fQd3JROjw>
    <xmx:mWceaHfmgEhfpXJmuJ2v879fGn427NIxTo3oboPHBohYLzUFwfsZSA>
    <xmx:mmceaARTbu6MimJGUnjWrOFcaF7kwZfzYiZYCENxgVuSQTc6-K4QpaO0>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 May 2025 16:37:44 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Kristoffer Haugsbakk <code@khaugsbakk.name>,  Jeff
 King <peff@peff.net>,  Phillip Wood <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH 2/2] sequencer: rework reflog message handling
In-Reply-To: <90c6912478683d96ef18b521506c703a2467585e.1746807747.git.gitgitgadget@gmail.com>
	(Phillip Wood via GitGitGadget's message of "Fri, 09 May 2025 16:22:27
	+0000")
References: <pull.1919.git.1746807747.gitgitgadget@gmail.com>
	<90c6912478683d96ef18b521506c703a2467585e.1746807747.git.gitgitgadget@gmail.com>
Date: Fri, 09 May 2025 13:37:43 -0700
Message-ID: <xmqqfrhdzfjc.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Fix this by creating the reflog message nearer to where the commit is
> created and storing it in a local variable which is passed as an
> additional parameter to run_git_commit() rather than storing the message
> in `struct replay_ctx`. This makes it harder to forget to call
> `reflog_message()` before creating a commit and using a variable with a
> narrower scope means that a stale value cannot carried across a from one
> iteration of the loop to the next which should prevent any similar
> use-after-free bugs in the future.

Nice.

> @@ -1124,10 +1119,10 @@ static int run_command_silent_on_success(struct child_process *cmd)
>   * author metadata.
>   */
>  static int run_git_commit(const char *defmsg,
> +			  const char *reflog_action,
>  			  struct replay_opts *opts,
>  			  unsigned int flags)
> ...
>  static int try_to_commit(struct repository *r,
>  			 struct strbuf *msg, const char *author,
> +			 const char *reflog_action,
>  			 struct replay_opts *opts, unsigned int flags,
>  			 struct object_id *oid)
> ...
>  static int do_commit(struct repository *r,
>  		     const char *msg_file, const char *author,
> +		     const char *reflog_action,
>  		     struct replay_opts *opts, unsigned int flags,
>  		     struct object_id *oid)

OK.  We no longer have the reflog_action as a part of replay_opts,
but they are almost always passed together, so making them sit
together in the list of parameters does make sense.

Will queue.  Thanks.
