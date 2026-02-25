Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9F021E5B7B
	for <git@vger.kernel.org>; Wed, 25 Feb 2026 02:44:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771987498; cv=none; b=WY/+7ct6nYq/NMCKEweDqUXCQg9sp2rBKdC2GwBvGt4V2YeZeGwNwL6HOO4TnozCMmjHKfYfT9h9G8nXCMoRBpamTMUCAbjGD3uNjsLMWIgFM+qiRP1as3xnhVvWcDYp3faqZONYOBRS3YFhfIK/nmHK5DEjzVbogI8KaMUhd6o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771987498; c=relaxed/simple;
	bh=aVVQ5k4BHbrl+CQtvnHl+gLvCGSqFpIQvDRpqLDA2+8=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=pIwrNgwVgQR9Vu7f6sn8MiKE0zt2fvKvcnjFb74CIMCxSj8HQbvsqch+/XvaYdBHWtN1U3YvVcn0M1TTwaXALvNaOAMvNBp92rsZKDpaiZJuLXul35zJfI83+7AaiOmP6Ki2kOJlcVUlYRd8PsEe1KfJNYVe1FdanPuGxkEzX7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=ApxYVDY6; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=D8zrThfi; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="ApxYVDY6";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="D8zrThfi"
Received: from phl-compute-11.internal (phl-compute-11.internal [10.202.2.51])
	by mailfout.phl.internal (Postfix) with ESMTP id 19DB1EC057B;
	Tue, 24 Feb 2026 21:44:56 -0500 (EST)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-11.internal (MEProxy); Tue, 24 Feb 2026 21:44:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm2; t=1771987496; x=1772073896; bh=ej8DmUFNex
	s0tUIRNWtNMIzBvE2RV+YdrDmobGgQ6cc=; b=ApxYVDY6ks8ZkYGmB8eruUfPcP
	FE3vGGedACn0SNii1PAs+D6KxXnzsDpIBLtfCwV4JIEFxzmXrSw4DVOG6TxNEE1O
	g7/6grMo4+IZQVZjWqwaCSbdFw16d1DjeTMuw0voATueztnjoxrmha/6mj2FFXSh
	sLtDG9/3j407PN/2gn2KKv4IABGacyB8AHWAGzh9jwcW6zgmzP0db1LtUvEj3XNa
	LyrQC0D/Jp4tgkKdxP6Eg/Z0bnnI3LE1LpwE3fUN4nnyMJvWWgVf3CJGV9bkA8/l
	olntVF7CHIvVcF5b5IVNtv6RcljmEvyiBc0PEjHzNws80M+wLGzmUcOgiDwQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
	1771987496; x=1772073896; bh=ej8DmUFNexs0tUIRNWtNMIzBvE2RV+YdrDm
	obGgQ6cc=; b=D8zrThfiMQ2F6XObj5xUjFuYTgt3YwF72b3lN6XScCEH6+5+VXS
	dFNr3TpPdO8flnQnrjAoqiGvclD97QvVAsYD6L6mMMEy46IBwyXrc6+dYZDyZjXg
	6ltUNOayIRmX7kv1kv1xcLDK7TbCmIu4do0kQvwo3MNq4d82v5bfccdXoKDHB1OY
	+qHKbvQ6vBrx3XZlgWi31FhTX3MwtHnw331u3k8DMsWcKMszhzPvn8Rp3QkhM1SQ
	tJuGxXmEpxQ7pMXatrxNTEmBmpsFItbnt105+rXTW1uMTQYaP77uzXidIrbTIQAH
	d/bDl2JruTjzlVg6arpKpZNpsHVe5Q8Q+Rw==
X-ME-Sender: <xms:J2KeaX0KXHySiU1VNoMrguNBZzTJEIw9PYCn2bJ0zUa3mUYXfQcr6A>
    <xme:J2KeaYqljOhKmg7lq7Evg5iYDkm5c56kNK13d-EdusUSSAcJfvhLo-FH4KD1uT71s
    eOAy4SSfqNKcnvRj9KCYLLYM8_BiZNabDkuCicKWCRbWCXflQjZ>
X-ME-Received: <xmr:J2KeabhM8i7sycINUIxs4VQcYgXX2_4rOVGhWmGLBU1EthAtKnWyRxVs2bazfNN38_cLghJBYSDx2s1pbBU74iowbJfbnsvf5w>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddvgeduleduucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgesthdtredttdertdenucfhrhhomheplfhunhhiohcu
    vecujfgrmhgrnhhouceoghhithhsthgvrhesphhosghogidrtghomheqnecuggftrfgrth
    htvghrnhepkeffiedugeetvdehffevffeuteelhefhieevffeuiedvvdekkeffffdvieeh
    ffdunecuffhomhgrihhnpehgihhtqdhstghmrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomhepghhithhsthgvrhesphhosghogidrtgho
    mhdpnhgspghrtghpthhtohepledpmhhouggvpehsmhhtphhouhhtpdhrtghpthhtohepjh
    grhigrthhhvggvrhhthhhkuhhlkhgrrhhnihdvtddtheesghhmrghilhdrtghomhdprhgt
    phhtthhopehvrghluhhsohhuthhrihhksehgmhgrihhlrdgtohhmpdhrtghpthhtoheprg
    ihuhdrtghhrghnuggvkhgrrhesghhmrghilhdrtghomhdprhgtphhtthhopehgihhtsehv
    ghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtghpthhtohepjhhlthhosghlvghrsehgmhgrih
    hlrdgtohhmpdhrtghpthhtohepkhgrrhhthhhikhdrudekkeesghhmrghilhdrtghomhdp
    rhgtphhtthhopehluhgtrghsshgvihhkihhoshhhihhrohesghhmrghilhdrtghomhdprh
    gtphhtthhopehsihguughhrghrthhhrghsthhhrghnrgefudesghhmrghilhdrtghomhdp
    rhgtphhtthhopehgihhtshhtvghrsehpohgsohigrdgtohhm
X-ME-Proxy: <xmx:J2Keac-vRAWbSNkSS9T9mcTJzerxsbRgncoay9tm0oC17ES8ry3tow>
    <xmx:J2KeafUEhwryXEVbSpsNuwznPc37SZ2h2Z8-SYX2UZVCwjHrBHPjsw>
    <xmx:J2KeaYDwbuOjzAU6cZ1ixQvSrMJ6mRRIYnQviLkJt54zDAmNjKkr7g>
    <xmx:J2KeacFiVgGrMq2sHtW2TLadCoXgsOu5U4y7SDe0qB7vV4vt976VZw>
    <xmx:KGKeaUxJHf2DGmfs3yFPrPL6rN-GcT3NIOI4D7mZ7Sdr0_jHub61G1ou>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 24 Feb 2026 21:44:55 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Cc: valusoutrik@gmail.com,  ayu.chandekar@gmail.com,  git@vger.kernel.org,
  jltobler@gmail.com,  karthik.188@gmail.com,  lucasseikioshiro@gmail.com,
  siddharthasthana31@gmail.com
Subject: Re: [RFC RFC PATCH] builtin/repo.c: change info default behavior to
 show all fields
In-Reply-To: <20260225001439.54954-1-jayatheerthkulkarni2005@gmail.com>
	(K. Jayatheerth's message of "Wed, 25 Feb 2026 05:44:39 +0530")
References: <20260224220833.17730-1-valusoutrik@gmail.com>
	<20260225001439.54954-1-jayatheerthkulkarni2005@gmail.com>
Date: Tue, 24 Feb 2026 18:44:53 -0800
Message-ID: <xmqqjyw1cziy.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

K Jayatheerth <jayatheerthkulkarni2005@gmail.com> writes:

>>> They do not matter plumbing commands intended to be used in scripts.
>>> What matters more is being predictable.
>
>> My bad for this ... I did not know about plumbing commands.
>
> In the Pro Git book there is a chapter which has a very good description of
> plumbing vs porcelain [1]. It might help.
>
>>> And it is more predictable.  If you ask for two things, you get two
>>> things.  If you ask for one thing, you get one thing.  If you ask
>>> for zero things?  You get none.
>
>> Got it.
>> Thanks for the clarification.
>
> [1] https://git-scm.com/book/en/v2/Git-Internals-Plumbing-and-Porcelain
>
> Regards,
> Jayatheerth

Thanks for clarifying what I left unsaid.  Very much appreciated.
