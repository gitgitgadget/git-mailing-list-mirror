Received: from fhigh-a3-smtp.messagingengine.com (fhigh-a3-smtp.messagingengine.com [103.168.172.154])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2296F3B38AC
	for <git@vger.kernel.org>; Wed, 24 Jun 2026 17:09:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.154
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782320966; cv=none; b=SO8ajxQWdnd6sCky7hoOg5y71GQNyeH/sMoVmV3FJYMUcmzto9pUK1606PYd2xrlqWMoYV3EcAGG2CCwhBFJPQGe7tQQ4/ZWrsdIU9e54TkP2seOthQeDxTjhglL6nJGTk+WJDjPg+pWQPHebeV6JVNNG1XPLk5urAtNZFoZKes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782320966; c=relaxed/simple;
	bh=fdE/7p0l+JtFsHmYDBx7YExwRDXQQGwHqYHsABPunoA=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=BGCiwCz7gZvE/0Pe8XO1Rzwp2FNHmPfbima/5/+s0Yta8peTFoiQnSpSxxfeQLcdR+fuDNKtDtgZi8zYi50fYw8khd++ldy7aWk2bwcKl9CYTlRHQe2KSPBtW3md6ckyK0g6kFmaOaPVjYiK0CHO5Eg7EepREbsdF2E2vq2tle4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=NGelHrNU; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=eVhnzGeY; arc=none smtp.client-ip=103.168.172.154
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="NGelHrNU";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="eVhnzGeY"
Received: from phl-compute-01.internal (phl-compute-01.internal [10.202.2.41])
	by mailfhigh.phl.internal (Postfix) with ESMTP id F1FF41400171;
	Wed, 24 Jun 2026 13:09:22 -0400 (EDT)
Received: from phl-frontend-02 ([10.202.2.161])
  by phl-compute-01.internal (MEProxy); Wed, 24 Jun 2026 13:09:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1782320962; x=1782407362; bh=oOA6BdCMBF
	HtZeDn41xsVGq/QtwD/V23VYuJlRNoA9w=; b=NGelHrNUYSR3umP9aSsYa56+qb
	mrCCbEfTdy0sz74LFsd0f6ef5CudMSgP+7H1q9rZV48yGui1AhhldaHQ0r57hZ28
	KjNAjwHHyniq/GLq+c0dpHs8OmfkgLb+Xms8TyBOB9gv3lFh7krMrWf8lV8Yhi7b
	FQtf4bj6hLpT8dQI+qQv0Yjx+1wxT+2hz4n2FSxK4PzNr3UxRGULeW3OTLjyhAVA
	lc6huSFDSRlaO2E+TxDNkX9aCecwmu1N9c2sTMzWqLNly4mld5/eStHOuLNPoHIo
	lgFdf0wPRvqsJ3yqkoEpDQf/TMCybkUYSLSy3799yCMl3ELDk+ZkNT8DZlCA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1782320962; x=1782407362; bh=oOA6BdCMBFHtZeDn41xsVGq/QtwD/V23VYu
	JlRNoA9w=; b=eVhnzGeYH1sgWop5SQq3ZCwP1sCl4oaFXV2/rlOrObu0/medm1d
	UMW5SMQ5IZjG7TJdIEi6ZR+iPnTxOYmCuCmW+PFXUPwUeJmrfou3TqJOqPIpho6J
	tnqFcMBkmRDeEBs9powV2qAraAZ937gBtifQ/MUilbyr/gYYHzaUGDiYiOocxfaN
	TJaow9wxEpTQCTvYr5mtpsv/PWUB0RaRT1lJOCUqbFX8KPrLPYAFdroFICVPiSuP
	ZzOntbTv1Nyf8PgRFsjcy9GjzVVn3UG0Kd/JjSTH0OF6IV3P9HQuIDsPIPJCEJfO
	c1vaQm1DIrrH+fBgo58MQBFBKef6rkMGmGw==
X-ME-Sender: <xms:Qg88aiUux4nuu-9h75xx9qVG954Ag3tVGitiniFszNPMyXpWlmtcog>
    <xme:Qg88aiQl0TR3UWr2QG6N8RTuzXruMbuTI7WigXKtnjgowlrzJ9frYc8-6o-tXfnqg
    Da2JzLu5Hqqv8RTKv7qMKRY55CwIR3IBEAjKSkCB8BohC_C1L-nfA>
X-ME-Received: <xmr:Qg88agODXiIfjfsZjBXUg5h4VVIqFWyplv6Cz3mk4GIlpeT73rxvtWLMCilZ7oK0vc3VAap1cDrosUphOho8Ea0Dv8kVcnVD57IBOEI>
X-ME-Proxy-Cause: dmFkZTF7RP1bRRVqqNJAc2RL4Ddtd2HSwLzxKefRGmzPinrrwqZgKJ/fPT52Fj9b3PyDJy
    4jOc31We7urD4bD/BmjYnhyu0+ylPOjEzGOERrpumk9vrBgSGv0JnV0PJ3qraAkfOadJzx
    t2zETNPIQ0hMQRKj40wj+aJwy20RPH/DXQl3unFcHArBwWZNS40E62fbU/ajOUcs7605YB
    Bw11Dlwvu//bugGZOtcm3wyjFYrPZk5nEO5tZXigRPWo51J6kh4IlCM0vOl+1dh9IJVvJy
    lctdOCDJDNAK66MI2ogZiBc3dhSxFPpHHSe4mD0rmFRK+V6UAxfw+4ssGJ9SiosNGH4fbU
    LCrEdDpUIk94yGsAhMNT6OYvPXEOWOQz58Sdi5lcCALU6AybarwAAStilKyFSDGHOgvLIz
    FASAvWSZnASyoVa0LxtGnWE3yADuJobgfBpuOEcpIqBwGU2nRHkZJCwIEG02c3DXxwoVQ2
    u9CAFj5Z4vBatEGgqndxcAH7rWmpZlbsswm6iKwByRfc5eUHeERRekP+q9VpL7r9iE3akP
    tHYZkbZtl5sKrAc0ZMNnp6f0A3utcMdl+jdz/xSnLRVPLPaxuRStBT31N77++F5PhHiXKY
    MzeFFeTt16dtLqkwiSVu+fU3UzVcP02yPGv9SBPA5lkyXyijaiQiqzA97BtQ
X-ME-Proxy: <xmx:Qg88agTqo9DLh0auKoI03rTUpg3MPfFuEja_V6xOQgCzgLK7PeyN_Q>
    <xmx:Qg88augKMLTI7ZOTu8-gLoECCLAOKg8WIlGV2XdAhsOVT2tGTJFN3Q>
    <xmx:Qg88ap8zUa8s4gio2ECg-SVSlJhcHPdJBeyXRlnqdfRBaM3mB4qdvw>
    <xmx:Qg88alFLkCD73CWKMTuPETUBOZWNFfiS0Qwtddeuv_19JaR-zo2RlQ>
    <xmx:Qg88agGm-bm_4iFtTdDi1smyI5nrNqWGfZw628VJ7XVw_yhDwLrN6xdj>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 24 Jun 2026 13:09:22 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: "Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Derrick Stolee <stolee@gmail.com>,  Elijah Newren
 <newren@gmail.com>,  Kristofer Karlsson <krka@spotify.com>
Subject: Re: [PATCH v2 1/7] Documentation/technical: add
 paint-down-to-common doc
In-Reply-To: <19ed743bd10be5341eee040eb8070876b984773d.1782303254.git.gitgitgadget@gmail.com>
	(Kristofer Karlsson via GitGitGadget's message of "Wed, 24 Jun 2026
	12:14:07 +0000")
References: <pull.2149.git.1781951820.gitgitgadget@gmail.com>
	<pull.2149.v2.git.1782303254.gitgitgadget@gmail.com>
	<19ed743bd10be5341eee040eb8070876b984773d.1782303254.git.gitgitgadget@gmail.com>
Date: Wed, 24 Jun 2026 10:09:21 -0700
Message-ID: <xmqqbjczkgqm.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

"Kristofer Karlsson via GitGitGadget" <gitgitgadget@gmail.com>
writes:

> From: Kristofer Karlsson <krka@spotify.com>
>
> Add a technical document describing the paint_down_to_common()
> algorithm used for merge-base computation, covering the paint
> walk, generation number regions, and termination conditions.
>
> Signed-off-by: Kristofer Karlsson <krka@spotify.com>
> ---
>  Documentation/Makefile                        |   1 +
>  Documentation/technical/meson.build           |   1 +
>  .../technical/paint-down-to-common.adoc       | 114 ++++++++++++++++++
>  commit-reach.c                                |   6 +-
>  4 files changed, 121 insertions(+), 1 deletion(-)
>  create mode 100644 Documentation/technical/paint-down-to-common.adoc

Great write-up that very clearly and concisely explains what goes on
inside the merge-base computation.  Thanks for a pleasant read.
