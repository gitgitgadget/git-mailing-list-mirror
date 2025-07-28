Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C087221A428
	for <git@vger.kernel.org>; Mon, 28 Jul 2025 20:52:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1753735926; cv=none; b=jtyDPiMAJKDFFygwyK5Xs2ybIp0feXBsNok8yFjzvFSnX13Qes5Q5EGpsL8rKx5S1SFG+gqTQsLcRCMKeaM99UrPQ2++t7Y/uIqX+I7Y17O9YFJzGYneAKCnX2/7E4iaxyONI2Ce/ulqBG5esGJUP+h4ytdp++Dj3Yl+0JXmBKQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1753735926; c=relaxed/simple;
	bh=b7yuJiYGKA5w0N/5n2TS4/2FiuXd+0xKb88PAfBzljM=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=uTk18tVczRO7hnbtPUFTZ+aSppn9vAY7nkh20Kwk4/ap8HkNty39b0WHeOMuSvEbqj6oTugE4aWe7HIB5+U3JLI+heR4eH1lxoRY+GBBqsl40RipdQbzWiJGEuh0cf6HVpQsd3Gwrae3aZd/+jNmrwves5IUzNqs8Rb/N9+KdEA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=YcJHdbLX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=AQE1hWZ7; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="YcJHdbLX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="AQE1hWZ7"
Received: from phl-compute-01.internal (phl-compute-01.phl.internal [10.202.2.41])
	by mailfout.stl.internal (Postfix) with ESMTP id DBF1D1D00104;
	Mon, 28 Jul 2025 16:52:03 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-01.internal (MEProxy); Mon, 28 Jul 2025 16:52:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1753735923; x=1753822323; bh=qOl/N5GWiE
	X5Ydkul8gkV/mmU7sEj8K8B459HByyUOQ=; b=YcJHdbLX3UxtWxaogpVjAY3BH4
	NPTxUBq9fJZi4n/mdChcdjNHGvL7NfwbuJ8anGSCC61NKycKnsda9bzKxKgvuLem
	X3iLCJkjX6X/AejvOSm1/GeOo8H6JvHhVO8kqRhqBDvBV+Xthu+5W5hU8/kwxdEN
	VWsyZvSsNFaYwW21zvKFQ1tgaW7K5nkk+jw6KBcUpRt3Xs+hNaFa/Q5Ka7HJgdzi
	Hm4qyeuBqHSz/kS7AxlkCLfx53HLcOSDl/BpPXC7mu07jbAPD/0BlPXyNb//aLHF
	FGKEfbdVS8T+JeAeHUUG8gbamwMVLYC4Aq8TsCNBDJOiyrwjUygw0wHqkygA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1753735923; x=1753822323; bh=qOl/N5GWiEX5Ydkul8gkV/mmU7sEj8K8B45
	9HByyUOQ=; b=AQE1hWZ7rsAG6YT8jQ8Tlj2+sDZrDhyICUq0BeBr9Rz6Ce7+kTi
	Fdor9zJsAaGvb9nbEbjNHt0y9k5+zkB+fxewCkTbip2j6aWRg9ZYNerneeY4q3vk
	Adm8e3YVSDcF4nKRbUTYZJS6xzZjTQ+/+XSSoWaaF6d6EahGrRpDfch0yUvJgBoU
	LLyvsj5sylVJzzjZv9CZ1+32o0A2ft5I+vQ9BQPEAlhsKjMD4SyzWkdxsg1qxGOz
	HegoVmAcdo85KgTUo6PHm3Vxok53E3hNWQS4b3JM93tVb+n/s9NsH0gzkgsVOKC0
	RtkJmottzocM5nUA0PZ7VBKQ3bHLQXh/BCA==
X-ME-Sender: <xms:8-KHaEqdtrlHT4pZfRgu5o2o9ePuDFtBeTTowe4UwJd2vGVJZNn51Q>
    <xme:8-KHaFOCM76FbcE841ahOrJzs-4d58DEuVL80ysq6q8DbfyAIb6JYf2fRpOIX_IkB
    fRIf-QxmdAsfkidKg>
X-ME-Received: <xmr:8-KHaFwdqTpXqTkA6B7yWtxnhwh1ZzocOnuzWOa6BOSK8FIsfclIvwdN64mblthQE3sHcDda-87ZJI03DmrICoCJzs2jm7_3xcO1Rkw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeeffedrtdefgdelfedukecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpuffrtefokffrpgfnqfghnecuuegr
    ihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenucfjug
    hrpefhvfevufgjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucev
    ucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtth
    gvrhhnpeefveetteejheeugeffledvteeiveffueefjeelueffteeigffgfedthfefieeg
    ieenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehgih
    htshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeegpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehjlhhtohgslhgvrhesghhmrghilhdrtghomhdprhgtph
    htthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepphhssehp
    khhsrdhimhdprhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:8-KHaOtdc3Bv5Y7FCUR1vNFz-Z4hbeP9cn11uFK9aCAsDlXQsl2edw>
    <xmx:8-KHaO5sujSo39tPHEOGioGXiIn7HtUwhXG__flhXLO3FtpiCwSy7A>
    <xmx:8-KHaNRIkUiyVeIFJ4ND06u9o04arH3QvZfV7BNGrZUwbCZ-vaiOig>
    <xmx:8-KHaNpg54Psa3Mwcprx1J3MdXlvW9_In0GzN1PKEBjuNM49qan8Lw>
    <xmx:8-KHaCYWpIFeH6_qZCSYqpWl9i6Hp9X_zilqxdwLyBGouEuPDRCsDdlI>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 28 Jul 2025 16:52:03 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Justin Tobler <jltobler@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im
Subject: Re: [PATCH] builtin: unmark git-switch and git-restore as experimental
In-Reply-To: <20250728194218.2379432-1-jltobler@gmail.com> (Justin Tobler's
	message of "Mon, 28 Jul 2025 14:42:18 -0500")
References: <20250722180818.1043014-1-jltobler@gmail.com>
	<20250728194218.2379432-1-jltobler@gmail.com>
Date: Mon, 28 Jul 2025 13:52:01 -0700
Message-ID: <xmqq1pq0ujgu.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Justin Tobler <jltobler@gmail.com> writes:

> In 4e43b7ff (Declare both git-switch and git-restore experimental,
> 2019-04-25), the newly introduced git-switch(1) and git-restore(1)
> commands were marked as experimental. This was done to provide time to
> make breaking changes to the interface. It has now been over six years
> since these commands were implemented and there hasn't been much change.
> Consequently, users have grown to rely on how these commands work and it
> is no longer feasible to make any breaking changes.
>
> Let's remove the experimental label for git-switch(1) and
> git-restore(1).
>
> Signed-off-by: Justin Tobler <jltobler@gmail.com>
> ---
>  Documentation/git-restore.adoc | 2 --
>  Documentation/git-switch.adoc  | 2 --
>  2 files changed, 4 deletions(-)

Thanks for tying loose ends.  This completely slipped my mind.

Will queue.  Thanks.

> diff --git a/Documentation/git-restore.adoc b/Documentation/git-restore.adoc
> index 877b7772e66..3763a7f4f43 100644
> --- a/Documentation/git-restore.adoc
> +++ b/Documentation/git-restore.adoc
> @@ -28,8 +28,6 @@ otherwise from the index. Use `--source` to restore from a different commit.
>  See "Reset, restore and revert" in linkgit:git[1] for the differences
>  between the three commands.
>  
> -THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> -
>  OPTIONS
>  -------
>  `-s <tree>`::
> diff --git a/Documentation/git-switch.adoc b/Documentation/git-switch.adoc
> index 9f62abf9e2b..87707e92652 100644
> --- a/Documentation/git-switch.adoc
> +++ b/Documentation/git-switch.adoc
> @@ -29,8 +29,6 @@ Switching branches does not require a clean index and working tree
>  however if the operation leads to loss of local changes, unless told
>  otherwise with `--discard-changes` or `--merge`.
>  
> -THIS COMMAND IS EXPERIMENTAL. THE BEHAVIOR MAY CHANGE.
> -
>  OPTIONS
>  -------
>  _<branch>_::
