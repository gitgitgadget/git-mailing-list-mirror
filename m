Received: from fout-b4-smtp.messagingengine.com (fout-b4-smtp.messagingengine.com [202.12.124.147])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF49535950
	for <git@vger.kernel.org>; Mon, 12 Oct 2026 00:32:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.147
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791765132; cv=none; b=bb3Ix7Mppcc/BmZ8VzWKofe3Gr+GLj1WrvblMb7Fmk4lJTTtiGuypo1yzzcPxQ4PmQIS7Q7clciNdGN+mjBwrsGWpNcpFo90mhnA0Qk+rhG2B/K9EK4OnPd9IjziSpw2gwgj7fiCAiDLBDwOY/6ulDfFOkNr2ZgGOwDMIeb+p5g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791765132; c=relaxed/simple;
	bh=IPqYBjYhXHPzWpE1cba5X8/gwN9ZGq63057wODsuPKU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=RYyoPmcLW4oE2EKLwB5KNYydWaY95BUPqWQcWfnSptJEaZh3f03w+46bpzEj/eMuWUQ0QGKwu9xjY89uSG5gHuNMMIzLtbLBBIkGPKMCVJQ5gh94d2W9gwr4WHAJgBGOe11ZTM9k1HWScFf55uZgm//8cZAh/wByZ6OZhCg3WsA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=hJa+ZCIT; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=LmgoJxXI; arc=none smtp.client-ip=202.12.124.147
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="hJa+ZCIT";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="LmgoJxXI"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfout.stl.internal (Postfix) with ESMTP id EC29A1D00046
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 20:32:10 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-02.internal (MEProxy); Sun, 11 Oct 2026 20:32:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1791765130; x=1791851530; bh=Bz1WSUAmyG
	BXH8w6l1PCs5W5MoprTsi/lT1TQboqj+0=; b=hJa+ZCIT2OmOOjytchEr2pkZUJ
	ap+YQXIuW50zhG6SOE3KR3Asl+V9paQSt0KARnT8DJ985a4jmuoJ5x0+IgyfKCjI
	ZE9njr0SuWqafBN3B3sZQ2uVGuQay0wyasv3o2R0c58SqB7CGopYX/FnQlcSQ5IW
	WdTBm7zmgGd4JW+Z/mI5NsDeDYsGsZt/3xq/pmqNdhCE+7vF5MrQ6kqyzcMBrK+3
	XRVgQklD76Qty4MIlK5q6EKPD7xEXxxUVmGO/m/IYxZaQor/zMPcA0J3GVT/Jo/5
	lT08bIlOQTLqCuh2BTplgVwoh5pdA1alNlAIickg4sH6GULhifi99lV9v95A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
	1791765130; x=1791851530; bh=Bz1WSUAmyGBXH8w6l1PCs5W5MoprTsi/lT1
	TQboqj+0=; b=LmgoJxXI2nggRmhay2p2T3q0KXrxFRkq/xbN0TSNF1RnsKQLnob
	E0pVbnZaMBaJhsKDrTjgckMg9pzgSHhnhUnzBYmbZiu21xJrD/Eoe8vkWqF+6ALs
	8RsrfEbK1c9w56tYXjbmqfyh5xnyX4PK/fNuJeXe6KbS37UtFuTqZO8On+S6Rz4n
	E5hwgLuGhsrSabrK9l5eNhJsOjLjUm1XDpuL2r9yhZfrVqMBBKvwnpuHMvv2D6kn
	GkQwM5iqpyb8GIFh/QN5xGphz1vxXF7q5qFBfckjVkRWocxoNebKpEr+ZUsSwJlN
	OWKMB2Vmyui8DIlYDaZloupMBet52hONyYQ==
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=sign d=pobox.com a=rsa-sha256;
DKIM2-Signature: i=1; m=1; t=1791765130; d=pobox.com;
	mf=PGdpdHN0ZXJAcG9ib3guY29tPg==;
	rt=PGdpdEB2Z2VyLmtlcm5lbC5vcmc+;
	s=fm1:rsa-sha256:adCO3+sxI9wlunUeKamEqP/MRCGadPyeNyNC6nxlAvFOHlL
	iqdLhnqQxSyt7UYWZLZBZJWu3bn1c6KMZSWe2nu6qKPnTZ2woYbUeqWWamJuvbfk
	TH5UqdHX/vBnGf/agCAh2zICBIwVFHSmnq605jrclrdO+YhIJuire7QYrETujGjU
	BNdyojpjRtPknoszZqVP5M7TgnCmIfwM59XE/WFhAC3lF971kPn+C6lQgZJNAJi6
	g+tZXObeg3jyFYvZe67snEiusvfBTx9qVM7967e7rIufU8ZMYtemErc+XljQ+0R8
	nhOIsfHLHRL+ZFbhHbTp1u+o80iQDhQ8PSUTzlg==;
X-DKIM2-Info: draft=ietf-dkim-dkim2-spec-06;
	repo=github.com/dkim2wg/interop; date=2026-10-04; sw=lmtpprox;
	action=mi-m=1; hc=12;
	hn=cc,content-type,date,feedback-id,from,in-reply-to,message-id,
	mime-version,references,subject,to,user-agent;
Message-Instance: m=1; h=sha256:cQ6H4By0HYAKAMsL/YHbBpmxsU0xnw73FY17ngla6HE=:IPqYBjYhXHPzWpE1cba5X8/gwN9ZGq63057wODsuPKU=;
X-ME-Sender: <xms:iSrMapMYwIqCNfpHwQMsRIu4Qn5FoAIv_RgbrmTTAo4ZoAYXpfaY-w>
    <xme:iSrMasr2EVrr-1XJx1sGMLy37Ldm4fNzk70jsGilqbmAIxdRu5hXi7XjDqNqbXnAK
    FDQwsR78xk7dUb33pE9a-HKgrcLubCWXnxpXeEDCjAaTGLnn9xLFb4>
X-ME-Received: <xmr:iSrMamdkTHOYrirfizsqrCrzOGptqtU1X04mAr-RO0HA7hGmhEc2bqUydxCaMPQyYP4HQWblYxJ109neSy4ju6HL4c_c-cX8C6KS>
X-ME-Proxy-Cause: dmFkZTGFeI0807J7BGBHO0YoFlmc2zHfdoe8LqR4qKxyKhA53chWJ8fCyyJA7xG/LL0HiE
    tD9CV2JHA85E9SlSmuyrn0LGHGXXP0LtfMXDpcSQ8lm6tVAdqE0mNlPWjvEDw3IX1lQJlp
    Qxnycx0koVt0xlqO1tyxf6A4DvNrpyaqzyg5MDHdjbdfuR6Sj6EG3ChbdXsGQJREljqye2
    MTFQP2l2yqJI7Gvk1m1+97U1BCA89JKEV6F69clCa4PavgrLvnrtL8Av3TSakIlJVP2VKY
    PG7RFhDtgPRMXO1Rd61NIGyCF1Pe6P8xjSFGtUchcez9vLNZ0tJoDML3HyWpIAULIkM+st
    xm2is/A7FUbFLC2DxmLuIofzv2qOK3DjSq12aQ8QczR84DHbJuCvgmXMciSZ3DS29Kid99
    nQoMimLZNpHIYKH5UmDJBks7AJTVrCQPhGDOWj86qcFRsaXZ0lT9Qh8cNs95MuQ/N0OIQn
    o+sSzOzW1cLAkGoRb86y77I8HxUX+rVJTz57DQTftEocU/XQDZoQbcgm+E6TrRvyJMa6Xs
    PoFuEJQhj1byvRVJmWbWoHTxKrK1rIVH35cCEgAkuWOz5CacU1Nz6+jN44dAk4Iy+x61HL
    QBlP2QEEW45aY+kmr6pow+Sz7aYvdr15oHSc40ACtevJHhAZUhV9LsQ3r9rA
X-ME-Proxy: <xmx:iSrMaqSp_OxyV1_EUlf3sd1mkZj8O0N9TAA-OX4QxFCDccD8F2H5YA>
    <xmx:iSrManbuB_eQc8e6UhdKO9unZNWoTUWqvQn62Iua13740fyd5Vg7Gw>
    <xmx:iSrMaleHzwXXcd5R7i5NQ3EcxfZOADSdYyZLGIXEf2-a94eSbzohBQ>
    <xmx:iSrMagKItbZ5aJ4CZ3KrIqWKlq0ZP_MhnoEOehXQjSrssvXCiXAP9A>
    <xmx:iirMaoK1rs3aicnFC5ceEH-LdKz2GjTVaeRESQlMLnDpOfOTfh5D02vW>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 11 Oct 2026 20:32:09 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Thomas Bachem <mail@thomasbachem.com>
Cc: Thomas Bachem via GitGitGadget <gitgitgadget@gmail.com>,
  git@vger.kernel.org,  Patrick Steinhardt <ps@pks.im>,  Phillip Wood
 <phillip.wood@dunelm.org.uk>,  Phillip Wood <phillip.wood123@gmail.com>
Subject: Re: [PATCH v7 1/2] rerere: wait for MERGE_RR.lock before giving up
In-Reply-To: <CAA0xjtpuQE1UiQEPjfmsp9BZPROucfXCOpok5ADjMRB-rTZRiw@mail.gmail.com>
	(Thomas Bachem's message of "Sun, 11 Oct 2026 16:18:09 +0200")
References: <pull.2214.git.1788337897490.gitgitgadget@gmail.com>
	<pull.2214.v7.git.1791627204.gitgitgadget@gmail.com>
	<3dc3d02f12a3118ac9e270c19960815f6b8170cb.1791627204.git.gitgitgadget@gmail.com>
	<xmqqqzhxf4uo.fsf@gitster.g>
	<CAA0xjtpuQE1UiQEPjfmsp9BZPROucfXCOpok5ADjMRB-rTZRiw@mail.gmail.com>
Date: Sun, 11 Oct 2026 17:32:08 -0700
Message-ID: <xmqqv777bvxz.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Thomas Bachem <mail@thomasbachem.com> writes:

>>         wait && # just in case the background unlocker is still active
>
> It is. Instead of the comment, I'll move the wait into
> test_when_finished, as pack-refs-tests.sh does, so it runs however
> the test ends.

Ah, that sounds quite sensible.

Thanks.
