Received: from fhigh-a8-smtp.messagingengine.com (fhigh-a8-smtp.messagingengine.com [103.168.172.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E3344CDA35
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 18:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791829083; cv=none; b=pYeiE2XTQ174l0Ay0/393WKI7uBpXN6er/hkzleh3K1BcUw1oRghu/tG6rQHdSE3Cu2sY/TYY7/nY7N/WSujrXO8pRqCtBHI5PwVjf60grvqmI5V9MiCua5TaVdno1lW7fUDjOkdrc5QijwnvAVNUemO3uzD6vHzCrZHSegf3sw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791829083; c=relaxed/simple;
	bh=tR7lAW2U9bbuXMzRhIQz/yuVtR3wilAWe1TANUSMCKo=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Nq4zLWUGqncCknQN1bNZMvIfSV30ogSWg35sJaO9bb0raycc48+3HmbPvun74qN3J7r4LdWqP0peexlKQT0KUindm0nmLypYJfF/Y7cFOTBAcTO8uZzeR1l4WMr9n6X5KODrw2b8/u6ImYI14894F+GSxhCXEN1bBjE5ENLqpUQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=d+tSkiEP; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=VxpSH1U9; arc=none smtp.client-ip=103.168.172.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="d+tSkiEP";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="VxpSH1U9"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.phl.internal (Postfix) with ESMTP id 6519014000F7
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 14:18:01 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Mon, 12 Oct 2026 14:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791829081; x=1791915481; bh=0J+5HWj395
	qyDH486RZC1sDeKkygC9Pdwq6nt9rJgu4=; b=d+tSkiEPJxR79F59C8TaqFqYae
	ToQD0E+QITXSUZVrNWchBefWKYrnJt6AfRBEKERd8ieCN16A9IyNCH4fW33fNBmT
	n06ADC7KpqLw1rAIQ7chIbSdqgFv//Fw3YjFvs0K06OisROKdskK8zBAKYlqWgf0
	+32QGxVicMsqI1FsBoN/JgxqRnG6wvOp96gTb6Nk2/3pxdJAFdnnVK8qvxvi14si
	ZhwtdJ1vAo4tNtfKV1vxZA9W2i0wYqAEXofcqy9hGBb46jFLtoayyiOGyoYDVkXe
	EeOG7W0gN5g//6Lw2sTHrwend2wg0Lt3vdchGNsX86HDBGTJqDdm+UIgcdaQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791829081; x=1791915481; bh=0J+5HWj395qyDH486RZC1sDeKkygC9Pdwq6
	nt9rJgu4=; b=VxpSH1U9y03mXiMG2cmAq0lRwarWcEzISQqK/9KIXEXyYp4bX29
	JHWGQC+ZPfHTTmBLqPiNNWe4AZXgonyzyqtqPe8ljXNL1OebQpRhBkUwZJZSlFyj
	PJgD4aVGZqhYTTZuQ7YB507q/gCHT5lNqFs7feWYo/eXMDOyWNyP4lvNWIlymC59
	jk+z4gi6j0osnhlNW0Vi26bAFbFmbGr0AW80VftLmpE77pZ49lloIq7oPXK2uVr1
	cQX+lHLXpEqSPMs69L+Fmd81cY+isSYn8OGI0H3jqM991Pgg2hDXHazHXhW3wDOH
	FiZeEXDmVTQULk/vCXz17cHTP3jfg0vgDsg==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791829081; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:TnvmMA8LRT+CpDk+wpSUp0iXInx1Sv0r/c5vPHh8Sx4oOPj
	snvd+MZQhLph82eR1Ug/nboPAS8GZCBT63SwBQi5Km4AX+Xzx/TbA1MIAip1VCvp
	NX96XU3hu7ZnYBJhJDbo5eFR1H0JXSYqtdLKMMGmcJWhQ9lYOPFTtq7LfntPOv7m
	qev1tB6K8uhrFhU6qYrNcnBJqL097/2PByUoXY0ABQN4uT6og/UNViqWAO3iPobV
	MUWnw+1WEuegr4mq9vmN3NpLge1sxeNUlgVVzOcEkHLHgIPDooCVfOkJFIeFWsl8
	quJPkcpLhVJ2zChyVYmtqaQ8iOOAK0fphjwlRdw==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:gB7XnbtgZGP7GJVXfFBd8xzYtdXLY2cneO3+64pdOw0=:tR7lAW2U9bbuXMzRhIQz/yuVtR3wilAWe1TANUSMCKo=;
X-ME-Sender: <xms:WSTNavW7Bg_M91JHTJp-5Zj0v_HaUxqEcBavVHpIstkqIvQtZHQuiA>
    <xme:WSTNap0pZi1opVd9yHOA2o99gRveJDJ0-PZqp7Uvbmy3ByoAkOdoqSif1qjnjkfJZ
    CuNZ2KL4yNeXJTCnAZ-uCocCEAMaug8nwEy6ZB1H0Fq0Th3N3iPfrs>
X-ME-Received: <xmr:WSTNatqh4ouRcMqt9SymdunZv722Qq2OE_dnnwup1gq-q8GGaY9sPN1eg1y3KlVnqeXH4lL4dY9bbILtjrv8Jo8OrH0kCc3NyvCC>
X-ME-Proxy-Cause: dmFkZTEFoYVPM+XgsZ/FXcDmAO7A0g9Z1VdKzintxuf8qjLpXxwzAoKf/aG/ydZjGceTak
    do/XUokOwXe525OS3N1MRMj8VXYD80SXebrj9o5hy279iqG+K2Utxn3wZ0mIp8n65jXGKU
    axemCAM4TbSRUPXZRRbWNUO5dFwqLVes4X72u5lhDifK0H6b+uRWf30/ig4ZLzK157GbhH
    65XhvX6Nr39oHfmxL5uBcDxVGAMaRHq3+opNXmhJWHD6wPFUWS0YD+DeRM2RPhpfe0hSrT
    t6CQ2g3IBmhxrTk2OLkGoxdCPP7e/Xk+SkBPSW4WzefC2MLATluAJcV6QTq43UxR6mZoD0
    TJzee3VVzmaX4+Khb9gq8Gf3c6JzdUJ49bSPYoM9FDsnnAsffdeX4aL8Ugzj5oeGfuIP6v
    KxozdsBhLaSXGSMHbVA3JelRfNUiMbPWXkjteGdq9dYJW+e2EtYYGgw0JUSe4YfNQ1iMfh
    n2nW35hAtfZIyKGqm1D65psmfVCwNbT7uCGZPNZP+FAzCvO0EcZXN01mReUFfgq6e6PYDy
    G4pYJiRCVjaaGy01BjVhhhnwmsEMgqJeeeUHf1fKMTVZfSif3f4Ut9sg1mR5YdUnSM8+ZR
    5n218PylDb8jCttF4vZiGJXWguDl05vQ93BiHwxX8c7t90RsaMp/FDBv4Crw
X-ME-Proxy: <xmx:WSTNagU0kPzDMIaTRNGjecSCzDoMk6Qdd09SV1lkF5bmeOjN_8ku8Q>
    <xmx:WSTNaoZ4c6qJU7vFtEsOMa5bpuz1PACWmFmgnJAobEKpRzPRK_DUlg>
    <xmx:WSTNatcUSPNgJnaJJ1zW4YmtGdOePiO1sY5pJHr2LDzqjJnmGD-l0g>
    <xmx:WSTNai1leHTXQihCcJSm6OrU8Cq2d2CBPeaQKwvuk9xjeBlp2N1PhA>
    <xmx:WSTNau6lVnDrGvlcfUYevG2psTtSLZkuWtAhM8w96N4bjuziE2r1PA77>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 12 Oct 2026 14:18:00 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Julia Evans via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  Jeff King <peff@peff.net>,  "D. Ben
 Knoble" <ben.knoble@gmail.com>,  Julia Evans <julia@jvns.ca>
Subject: Re: [PATCH v3 0/6] [doc] Add new page on merge conflicts
In-Reply-To: <pull.2237.v3.git.1791816795.gitgitgadget@gmail.com> (Julia Evans
	via GitGitGadget's message of "Mon, 12 Oct 2026 14:53:09 +0000")
References: <pull.2237.git.1790261062.gitgitgadget@gmail.com>
	<pull.2237.v3.git.1791816795.gitgitgadget@gmail.com>
Date: Mon, 12 Oct 2026 11:17:59 -0700
Message-ID: <xmqqse2a7pgo.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Julia Evans via GitGitGadget" <gitgitgadget@gmail.com> writes:

> Changed in v2:
>
>  * Explain what a merge conflict is (thanks to Junio & Ben)
>  * rewrite the "ours" vs "theirs" section (thanks to Patrick for the
>    comments)
>  * add git log --merge (thanks to Ben)
>  * Leave most of the content of git cherry-pick as-is, to make this patch
>    set smaller (thanks to Junio)
>  * remove the SYNOPSIS since hopefully that won't be required anymore by the
>    time this is merged
>  * Fix a typo in git revert (s/reverted conflict/reverted commit/)
>  * 's/the the/the/' (thanks to Patrick)
>  * s/[doc] Thing/doc: thing/ in commit messages (thanks to Tuomas)'
>  * squash the commit fixing the linter error (thanks to Junio)
>  * list reviewers in Reviewed-by

I had some comments on diff3 in [1/6]; everything else looked good.

Thanks.
