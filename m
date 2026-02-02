Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0803A29A9C9
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 21:33:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770068012; cv=none; b=Tb/89K9uFsEwh/ak41kWNacFlUYWAtfBTUHWX3xrux6WB+1FI+XDtJ/nvYhnJDOZAPaLxeCZeW2BaKhkNTgMUZDWq/LAty/8TYoDF5L/5pmhpj68Ff7ZC3KFotF4ZioV6UpfeELKzKyOdy3BEdvS9cGoscwtD1tSJPNpJQ3FrQ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770068012; c=relaxed/simple;
	bh=aAHL3Tu5oT4pBfkog0Nkh6rJtPSkrphFcB1dagZMLIw=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=idZxHigN6QOT/f6SR3E2YD4uyxy4ckXHFttlQP9z77N55tYdu5mm8ihctMgck6AnrzoF1UaXK1KkZrKiLcIQUwb7hBuoGIFzYJg1JbUC9GNniYRhGxMyMp5VdMqiwY1HLAO+vu6ffxVXeiK6JI9mq42WRGB6lDs0qrlLGRiv9/w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=Zc4tsOQX; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=drY1DgLU; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="Zc4tsOQX";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="drY1DgLU"
Received: from phl-compute-07.internal (phl-compute-07.internal [10.202.2.47])
	by mailfout.stl.internal (Postfix) with ESMTP id 15FD61D00066;
	Mon,  2 Feb 2026 16:33:30 -0500 (EST)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-07.internal (MEProxy); Mon, 02 Feb 2026 16:33:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-transfer-encoding:content-type:content-type:date
	:date:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to; s=fm2; t=1770068009;
	 x=1770154409; bh=+gaZsTjFwoV/iHyM0OwIC5GQ+Fj+phb3rcSIugEM9sk=; b=
	Zc4tsOQXH4WtIrHcj6nqhUSFFQj+WaKoAPiclRVWk3QsEAfCzpF7WOOojEQGvnnf
	iGdUc8AfZ02XxEwdyZAbwvOpxh9TyhHj9CxCp8YamMfsSAumDnVTj1FFh4T9mfYI
	cCY1oumkUwCZWyhi/5zeENHoJmtuwSCOYWunKB1HiaDNqJQMc1JDphffqnWMZQ9Q
	4Tw+ADv5FcP/mPyAurUt8yRSBJ5WlKxUgHctT5IxQ2PsKcRod+nTTe+1rfZ+kyul
	v4tQ2ry3t6xFyzdHCXbvhNWot4hMGpOU+PSmtX8DwAS9tzvXA3ApDQ/FvGBnduT7
	Ap1OPljp/cJyiGb9Ar3MKQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-transfer-encoding
	:content-type:content-type:date:date:feedback-id:feedback-id
	:from:from:in-reply-to:in-reply-to:message-id:mime-version
	:references:reply-to:subject:subject:to:to:x-me-proxy
	:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1770068009; x=
	1770154409; bh=+gaZsTjFwoV/iHyM0OwIC5GQ+Fj+phb3rcSIugEM9sk=; b=d
	rY1DgLUOM2EqHiYDrqKaB/an1qJPN+EYBJkcKkzsDm82wq90PG4LuX+UiQ/bJ97L
	GV+3C0AACp2f0eGyIE4UBSc5Oz/899Fza7DONEO6xDlhc33TPC42Qww/IjT+iWVV
	kzAvCkaHG3iXwvQ+BTtsq+Gnisl1SU6aQFbL/De1PInTrrHIcfFG4yLazDRsXW1j
	1aELCQXgxzs9iAT0+qvcJ3R5XVEakUOWBCpyT8JKOUsE6jh4IB3xTsiTaIhDmDiM
	0QMfMzFr/EgoHO4lEleb20cuC59v5efsmDB7z/hjm3RaRvgZ1zBaJPoXtZ8bXQPO
	95jzxTs/aDO+FfVN8dkKw==
X-ME-Sender: <xms:KRiBaftmsrADLsrfdRpbDMjthrP2QXYrJctt4mTZlCeMfYsPkHS2wQ>
    <xme:KRiBaRLJjqyOkX_kwGm5qvW4ml0ta21tgTMayCdk8id_51B1BWPJttQeUimQjZHtb
    aLKdqaEae_CI7wYADN9mv6YJy3tPxljGcSO4QGABxkm712yCupM>
X-ME-Received: <xmr:KRiBaQ-dvgHvHd0cJTl6ceOwZXnouPtQB-75l1ZTzeA0Fi5irMaVAjtYoDtjN92fsVq4dbaoih49jKQW8my4p4K1qf22xdLF6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefgedrtddtgddujeekjedvucetufdoteggodetrf
    dotffvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfurfetoffkrfgpnffqhgenuceu
    rghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmnecujf
    gurhephffvvefujghffffkfgggtgfgsehtkeertddtreejnecuhfhrohhmpefluhhnihho
    ucevucfjrghmrghnohcuoehgihhtshhtvghrsehpohgsohigrdgtohhmqeenucggtffrrg
    htthgvrhhnpedtffdvteegvddtkeetfeevueevlefgkeefheeigfehveehvdekheelveev
    fedtheenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hgihhtshhtvghrsehpohgsohigrdgtohhmpdhnsggprhgtphhtthhopeejpdhmohguvgep
    shhmthhpohhuthdprhgtphhtthhopegsvghnrdhknhhosghlvgesghhmrghilhdrtghomh
    dprhgtphhtthhopehhrghrrghlughnohhrughgrhgvnhesghhmrghilhdrtghomhdprhgt
    phhtthhopehphhhilhhlihhprdifohhougduvdefsehgmhgrihhlrdgtohhmpdhrtghpth
    htohepghhithesvhhgvghrrdhkvghrnhgvlhdrohhrghdprhgtphhtthhopehgihhtghhi
    thhgrggughgvthesghhmrghilhdrtghomhdprhgtphhtthhopehphhhilhhlihhprdifoh
    hougesughunhgvlhhmrdhorhhgrdhukhdprhgtphhtthhopehgihhtshhtvghrsehpohgs
    ohigrdgtohhm
X-ME-Proxy: <xmx:KRiBaSy5ZR31HVkDE3MEALFHfjR3UT6NbwTK_pxt8ZmjD_zdj8HddA>
    <xmx:KRiBaV67FznMrn2n3_xay54LDUgwWXTIMN6ht7NnZ-OJVWbyWhI7UQ>
    <xmx:KRiBaR82gm7vaSSZeWQUM7MhNEh0dCy7LPknwRzqsQ_GVR5clbO_WQ>
    <xmx:KRiBaSqjMWQHtaRew3iiEOFwLMrxaqUPAWeqDNTGU10Gh2mcwb4jXw>
    <xmx:KRiBafbC32fWXozLlG977x8yo9LPDQFKLcGgsREtmokRyM-Np_2yLQTd>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 2 Feb 2026 16:33:29 -0500 (EST)
From: Junio C Hamano <gitster@pobox.com>
To: "D. Ben Knoble" <ben.knoble@gmail.com>
Cc: Harald Nordgren <haraldnordgren@gmail.com>,  phillip.wood123@gmail.com,
  git@vger.kernel.org,  gitgitgadget@gmail.com,  phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] revisions: add @{default} shorthand for default branch
In-Reply-To: <CALnO6CDrdfSFuY8xjvno3+2MVB2JHUYdNsYTYqqRsfcDiWa1uQ@mail.gmail.com>
	(D. Ben Knoble's message of "Mon, 2 Feb 2026 14:40:38 -0500")
References: <d92bd08f-abee-49a6-89ad-3be5e0c06ad6@gmail.com>
	<20260202101445.13790-1-haraldnordgren@gmail.com>
	<CALnO6CDrdfSFuY8xjvno3+2MVB2JHUYdNsYTYqqRsfcDiWa1uQ@mail.gmail.com>
Date: Mon, 02 Feb 2026 13:33:27 -0800
Message-ID: <xmqqa4xqygns.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit

"D. Ben Knoble" <ben.knoble@gmail.com> writes:

> If you don't need to be on a branch, then "git switch -d origin" (or
> upstream, or whatever your remote is) should work just fine.
>
> That just makes discovering the name of the remote the "interesting" part…

The only thing that is different is if you need to _name_ a branch,
or the commit pointed at is sufficient.  In order to run something
like "git shortlog origin..", "git shortlog @{default}.." is not
needed.

Of course, checking out and to be on the branch requires you to name
a branch (otherwise when two branches point at the same commit, you
cannot tell which one you want to check out).


