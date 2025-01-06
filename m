Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D28C86353
	for <git@vger.kernel.org>; Mon,  6 Jan 2025 14:52:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736175145; cv=none; b=u9P6T2kLeyQYVQpz2SJABhaJh28oBawKOi4/Zc62ScgQrQPknNctbDhQkik5SfKeGf9dguwLAxoctv+oyyqylClTkb5ENxjgJseQNcrAYL9oJgcKpjFtNxF9xsykmsfsXfRg0+6rJw7oS36/5CIhGQCBNRvCwqDwn6BDyAy5W9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736175145; c=relaxed/simple;
	bh=O3ft5/pk6QWQ8pC+QuvVK186fABuaYoreXO5EYK0+XU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=eNYwVM6VFLVDBAMo1uEc180quGmeRAMUWwC+c7X34sNwevqeqCtWPz7KgsPzh4cc7m5c4z2NUMF7YQUP2yFI99Dt0Ola6xm1yMB8EGetXAupSNSRSXeca511wMUpdXvecLBW7R3eqV4csxhpq3TIRyALkIn598o69aMsrS8qa3g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Bez5aLw2; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=tgJyDNz1; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Bez5aLw2";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="tgJyDNz1"
Received: from phl-compute-04.internal (phl-compute-04.phl.internal [10.202.2.44])
	by mailfout.stl.internal (Postfix) with ESMTP id 2CA4111400D1;
	Mon,  6 Jan 2025 09:52:22 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-04.internal (MEProxy); Mon, 06 Jan 2025 09:52:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1736175142; x=1736261542; bh=QdNatZd7/3
	sz4v15gH919KjXcxUmbDWaob+07WVt4D8=; b=Bez5aLw2AhNpBlsz8UVv3GttaE
	6uC5vuIHm1oy4OQ8L7gDbwwPRdhJBs9/64AxdIhatSkvH9X4QoB1XUGkKZUcFL5K
	Z958dH/lGtQcToUXjoMatpXkFnvXwWfpzhFDZDbNrPaBOQGyeITn8FAmtTZoegQq
	ZjBcBzNbUZ3xYf0ZJTSIQLLH2AAGH6xdwdmiw0xqD8MCLOzp+27wXCwJ/1w0pb4D
	U+dVSC6tGvl+Yrt7SxlTJgm5pRFF8980v26/ffwvF4XGYu8KqEk5Fncm6SSnhIH9
	3l1grL7KKAdY929dLHSzv/35RTNNpKkVSDYvWzf+QP3kMFMnoMEKeXK3K7JQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1736175142; x=1736261542; bh=QdNatZd7/3sz4v15gH919KjXcxUmbDWaob+
	07WVt4D8=; b=tgJyDNz1OFAx4ZvsHFJpkY+yVYKYmvEScywCGFNNir3y0OZh8HO
	uK5LGx8QJne74edbQoa6Y/hmpXDLI5XcmpacBhCwDyReOFQdag+wb9jG+eG2vWLk
	AayvKyDZA6vnwCICtm1HO25ofeOfwYDhqTt9Ju/Kdk1nC9PyhB1wQ6f/lX8HYQ+k
	5hunstx9ELbS9XAO0QQKIl6GC9iNst5PSY1bXint92U6bWfWj+dYufkpnjkD4NQx
	F02UuJbRIG+i+aiRCp/s2RmEZWYofJvf5lQhwWmhL5q31QR+73yR8lr+FtLxq3Kd
	MfUiSq5kf7ihzIuEqTQe+PtG817/jInsKkQ==
X-ME-Sender: <xms:Je57Z8IXc-DLF3P0FuOMg5SU3U39H5Pn5mvS0s0IfHAay7O2vbafrA>
    <xme:Je57Z8KFJ2NU_xiIXr7F10gAuw2gIB6_CBgb798n3NkTs-VEr-jfQspQi9tpjMFLh
    8MrWNqLvGbLS7mmow>
X-ME-Received: <xmr:Je57Z8uXODyA8H5ASz2NQEBrhRsJJooPyjJ9Z4xj-DFbHqRN87ALPz19FNWx7JYCaHmMoAhjaBi03CwfA69LmcLBl84562YlDFQI>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrudegtddgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdggtfgfnhhsuhgsshgtrhhisggvpdfu
    rfetoffkrfgpnffqhgenuceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevuf
    gjfhffkfgfgggtsehttdertddtredtnecuhfhrohhmpefluhhnihhoucevucfjrghmrghn
    ohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrghtthgvrhhnpeffie
    etueejveefheduvdejudffieejgeefhfdtvdekfeejjeehtdegfefgieejtdenucffohhm
    rghinhepghhithhhuhgsrdgtohhmnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrg
    hmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtghomhdpnhgspghrtghp
    thhtohepfedpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjheitheskhgusghgrd
    horhhgpdhrtghpthhtohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphht
    thhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:Je57Z5ZvgLpZksJ_CSlpj34P_B8CaFItOjl5irfhpNOlW1ADyQXQSg>
    <xmx:Je57ZzYLfPtrXgguaIA7hFgNtXn3AW7XqFTd8zjuk02MiB6jN4czvg>
    <xmx:Je57Z1DmkTDgVC1tlFbf4caCYRwmz-fTA8zLQ3xPUC3xYcfjGGwHIQ>
    <xmx:Je57Z5aBaOctNOLRv78jSj-Q8fgdu1RzrJudHUJtMHobEZpw6L7L7Q>
    <xmx:Ju57Z_HFEsD3Bz1qf0SkG6XIvU5lXuepMw3n4rn1BnZJ8VhfjCrd02O7>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 6 Jan 2025 09:52:21 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: Johannes Sixt <j6t@kdbg.org>
Cc: Git Mailing List <git@vger.kernel.org>
Subject: Re: [GIT PULL] gitk: Bulgarian translation
In-Reply-To: <9f806733-2498-4959-8878-9aae4e623bde@kdbg.org> (Johannes Sixt's
	message of "Sun, 5 Jan 2025 22:40:08 +0100")
References: <9f806733-2498-4959-8878-9aae4e623bde@kdbg.org>
Date: Mon, 06 Jan 2025 06:52:20 -0800
Message-ID: <xmqqed1g2dwb.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Johannes Sixt <j6t@kdbg.org> writes:

> The following changes since commit 661734e6c8c38d2cd2000481ffb22cca6e2b0e5e:
>
>   Merge branch 'ah/commit-id-to-clipboard' (2024-12-17 21:54:58 +0100)
>
> are available in the Git repository at:
>
>   https://github.com/j6t/gitk.git master
>
> for you to fetch changes up to e76b53ef23871ff81ab305822eb605baf0cc5bd3:
>
>   gitk: Update Bulgarian translation (327t) (2024-12-24 11:58:09 +0100)
>
> ----------------------------------------------------------------
> Alexander Shopov (1):
>       gitk: Update Bulgarian translation (327t)
>
>  po/bg.po | 730 +++++++++++++++++++++++++++++++++------------------------------
>  1 file changed, 385 insertions(+), 345 deletions(-)

Thanks, pulled.
