Received: from fout-b1-smtp.messagingengine.com (fout-b1-smtp.messagingengine.com [202.12.124.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69FC3845AF
	for <git@vger.kernel.org>; Wed,  4 Mar 2026 20:51:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1772657466; cv=none; b=Ew+Vvdh4SKSzphJBYAXO48mgHD2Lta75JMncFyJFmH3j32JxXzq5s28KoYPVUQpz0G4MyJDwVTgE1jYBhnHB8/U3C4jJ8ha1ygtkEt3qCieM75GMEfBP1uuNcde/7CB5q/evp8g0SygGiJi+ppovHGrSnbCJgt/uNej5IsPxedk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1772657466; c=relaxed/simple;
	bh=QIItLzjNFUCNPUDHrJJYGUpA5VqXKzaLyzxd6Ux7J3k=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=U5ShiKCkWLB5NHCHspm7VL3T6Vrd0Do6W6nO3F/j0om/gjPduwnO/j8rx9EWrrwiEqgR96Obzkrvo1ka09wY7WwOaBrHVNQq1c5/yPerQv895et8sCHCyhEfGZ1D4U7W9lOXoCvxoaTrGa9aBjGx6FZF1lw/E96LlgCHh1AsOvk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=VvtJeGt/; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xNQkwBpu; arc=none smtp.client-ip=202.12.124.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="VvtJeGt/";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xNQkwBpu"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id 646BA1D00237;
	Wed,  4 Mar 2026 15:51:02 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Wed, 04 Mar 2026 15:51:02 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1772657462; x=1772743862; bh=qPBzA/oC6x
	GDRdXMyFQomRp5YN6a7tLBRuE101JMFFU=; b=VvtJeGt/nm097q+/NmB4thsxwU
	PDEikTYRPTdIhsvx7sqKpgVgUQ9MmwEuhlTN+BrYkJgAXHESeUNmvPmamFhyBqXf
	G1Z+iHkxJU8DIF6sV6deEqpvLuunODjiwegpHz/yPIzQVqC+oqaClEjGPUz7qjRN
	8+vIJfA30xE8Jr9HMgEr7L3N6EIYqNXPZByJ1QUX/sx50iAd2+gOX2PFwYkML5Zh
	cCp1a86HwcVlcf8E8GclEnb+XAse1WLNyHFt/IL2diJlXHLEt5vMakuuEyK9Tw1B
	hxt0jSEYhEvcN1RSsFEuXRB3z3FI91MYWFolWRMuMvDQBna9aLes5eEurQ9w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1772657462; x=1772743862; bh=qPBzA/oC6xGDRdXMyFQomRp5YN6a7tLBRuE
	101JMFFU=; b=xNQkwBpuqApsduDAvQIAQ6rTgg0D+InsmH1zCRHUR2wUodDTewj
	M9mM5i/I0/6gnoYqBWmvWOTSqa0fB8QSCDTP9h4fnc4vWGdf1cXXae7EXrCOpVfo
	66HjlACfDSJPp6Zc/fJnVLrOgN0tHuym/4SSPAM5XR8iwMyIPfhFTHrw0OWSJqKf
	GEtGOyam1wbgxvlV/b6neaw/2/3N+7Px4RXpwPkonw2U9hBhLUhs+U5cPQ2T9wkZ
	f9Kvd8V/x/ekb/Gn/gD0WB4fjKru756UwS1OxPdcgOTz1ttyXr10nGgC7vZi+2Sg
	ILaH7Xo1zX9/jF4zLCj9oF3XROqeLH9QqOw==
X-ME-Sender: <xms:NpuoaXKCjArSLPXuElx46Z4RfmCS35qivLPZTUa7HCk9arJ7gLdPkg>
    <xme:Npuoae03j8-7DBOayxrPU8VIRhkR0jRe_C0amdXCP5fOWK6ZOUfTkivj6VZmSr4WY
    vJrPz7p6JCA2yXUxuh-4mijGhNY7Vkf6vOov3HB6MCNNzayj1ix>
X-ME-Received: <xmr:NpuoaZgYeWnZmRfcEeUBIF3JfrYxzT5yKpLHebVkvuu7OKEYzSQdBrfHeoznDZeQKM0z7qrqaCi8uTLX72WHJ75J5XCu-_VSKg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvieeghedtucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepfeevteetjeehueegffelvdetieevffeufeejleeuffetiefggfeftdfhfeei
    geeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepgh
    hithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghpthhtohepiedpmhhouggvpehs
    mhhtphhouhhtpdhrtghpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtoh
    hmpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthho
    pehpshesphhkshdrihhmpdhrtghpthhtohepphgruhhlsehprghulhhtrghrjhgrnhdrtg
    homhdprhgtphhtthhopehgihhthhhusgesphgruhhlihhsrghgvggvkhdrtghomhdprhgt
    phhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:NpuoaXV4tRSjtm_RGVPuSDxF7PCD7MsBLP8wIL6P50qI1Vm8DiPB3A>
    <xmx:NpuoaQU3z8PO9iXxPXwXyM9vYD6i5GavSeOfgv1OEV3rO9xKDVRtdA>
    <xmx:NpuoafgJdSh1Wqc3zAStFGSwoCdVIjgy8M-whQ88OUWwLPuFsOikpw>
    <xmx:NpuoaTaFcq_q8iwoFPFBgqbMpwZiMRWo2VQEwriCcIVj-XpghyiZAw>
    <xmx:NpuoaVSExaiYtNI7Rk0Ff-j87uF98WFxGzuYpPjE9J7ATawF3vCMpydt>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 4 Mar 2026 15:51:01 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Paul Tarjan
 <paul@paultarjan.com>,  Paul Tarjan <github@paulisageek.com>
Subject: Re: [PATCH v8 08/12] run-command: add close_fd_above_stderr option
In-Reply-To: <29a6461915ce9d2abedb29e475d589bb8d24934a.1772648125.git.gitgitgadget@gmail.com>
	(Paul Tarjan via GitGitGadget's message of "Wed, 04 Mar 2026 18:15:21
	+0000")
References: <pull.2147.v7.git.git.1772065643.gitgitgadget@gmail.com>
	<pull.2147.v8.git.git.1772648125.gitgitgadget@gmail.com>
	<29a6461915ce9d2abedb29e475d589bb8d24934a.1772648125.git.gitgitgadget@gmail.com>
Date: Wed, 04 Mar 2026 12:51:00 -0800
Message-ID: <xmqq8qc771zf.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Paul Tarjan via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Paul Tarjan <github@paulisageek.com>
>
> Add a new option to struct child_process that closes file descriptors
> 3 and above in the child after forking but before exec.  Without this,
> long-running child processes inherit pipe endpoints and other
> descriptors from the parent environment.
>
> The upper bound for the fd scan comes from sysconf(_SC_OPEN_MAX),
> capped at 4096 to avoid excessive iteration when the limit is set
> very high.
>
> Signed-off-by: Paul Tarjan <github@paulisageek.com>
> ---
>  run-command.c | 11 +++++++++++
>  run-command.h |  9 +++++++++
>  2 files changed, 20 insertions(+)
>
> diff --git a/run-command.c b/run-command.c
> index e3e02475cc..cbadcf5ff8 100644
> --- a/run-command.c
> +++ b/run-command.c
> @@ -832,6 +832,17 @@ fail_pipe:
>  			child_close(cmd->out);
>  		}
>  
> +		if (cmd->close_fd_above_stderr) {
> +			long max_fd = sysconf(_SC_OPEN_MAX);
> +			int fd;
> +			if (max_fd < 0 || max_fd > 4096)
> +				max_fd = 4096;
> +			for (fd = 3; fd < max_fd; fd++) {
> +				if (fd != child_notifier)
> +					close(fd);
> +			}
> +		}
> +
>  		if (cmd->dir && chdir(cmd->dir))
>  			child_die(CHILD_ERR_CHDIR);

The need for this particular "close file descriptors other than the
standard ones" may be common enough that I do not mind to have it
inside "run-command.c", but I wonder if a generic callback function
to call here in the child between fork and exec that the caller can
supply would be a good thing to have.  Then, any caller who may want
to set close_fd_above_stderr could instead prepare a callback that
does the body of the above if statement themselves.

> diff --git a/run-command.h b/run-command.h
> index 0df25e445f..a1aa1b1069 100644
> --- a/run-command.h
> +++ b/run-command.h
> @@ -141,6 +141,15 @@ struct child_process {
>  	unsigned stdout_to_stderr:1;
>  	unsigned clean_on_exit:1;
>  	unsigned wait_after_clean:1;
> +
> +	/**
> +	 * Close file descriptors 3 and above in the child after forking
> +	 * but before exec.  This prevents the long-running child from
> +	 * inheriting pipe endpoints or other descriptors from the parent
> +	 * environment (e.g., the test harness).
> +	 */
> +	unsigned close_fd_above_stderr:1;
> +
>  	void (*clean_on_exit_handler)(struct child_process *process);
>  };
