Received: from fhigh-b8-smtp.messagingengine.com (fhigh-b8-smtp.messagingengine.com [202.12.124.159])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85A46486409
	for <git@vger.kernel.org>; Fri, 11 Sep 2026 21:39:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=202.12.124.159
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789162758; cv=none; b=MAZJkBeRcxWzgCLH+PeiMiuzeDqfbv8U9e0iCDKztTXwnDID7XSGk395ipj6OR5e0HshjeIdlwE2XZok5XbxdQMhmZ/vzg4E8bXGAuhmPMr1Qejz1C98fxiBM0RtAks9VPPcLWQgneqguH2Ou3/VcyqzcuPZ25XLB8nRHxZcKmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789162758; c=relaxed/simple;
	bh=esbFdzPIf6OYVCaEnE7FO3lJXXakLNYWcsBqutUDhJs=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=Sfu8nvHpF62Jlgfto3jOYb8XvXkgW3ySw20LaHZURMCDhT9LDsVUjl5GVlz0jqqiMhylHePgMd6ewEueJFs5meF38HEGRYmTwtUMi42U6k4RnNgkMEPSlvxKdV+bw4GS8PkNIdBTg0LT5WAnYnH9m4TRFyZXbc63sk8k5jVWuFk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b=aOIF3tNJ; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=hr9A2sOd; arc=none smtp.client-ip=202.12.124.159
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pobox.com header.i=@pobox.com header.b="aOIF3tNJ";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="hr9A2sOd"
Received: from phl-compute-02.internal (phl-compute-02.internal [10.202.2.42])
	by mailfhigh.stl.internal (Postfix) with ESMTP id 9972C7A00F7;
	Fri, 11 Sep 2026 17:39:16 -0400 (EDT)
Received: from phl-frontend-01 ([10.202.2.160])
  by phl-compute-02.internal (MEProxy); Fri, 11 Sep 2026 17:39:16 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pobox.com; h=cc
	:cc:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm3; t=1789162756; x=1789249156; bh=2x+FU7AVnq
	HqJgWyD6VuzV8bu7gUYFNqHlPiketheM8=; b=aOIF3tNJWVShhaQG9XYTeghTS7
	LZcdjmqfLmNBqoPIl0FUe+ivsfla7QVxt5mOdpD/mmMPvDkb4V8GcVikDioX1CHh
	2wzk8NEpU6A3497jZ652jlo+F8Uf25iTj5/+S4qO/pAxEBRceIYnG6CzSvV8eCWX
	abcZqbVO9CV8eMAXqyyHnd29s04cGV92rr1970ndrUrAgkEBvVIJgNzLrndrDzdR
	N2FqUeaj8UHAgYnVWOS8Y78vOrCwjRfYkZPT6ivcWaK3j/il2Tj1c+NxBPA94z5T
	MWuifIacpc5sbABMwNzRJRYhrnqZ+4hib7srybdGhpQlysFUIZKmxbpe2Ebg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1789162756; x=1789249156; bh=2x+FU7AVnqHqJgWyD6VuzV8bu7gUYFNqHlP
	iketheM8=; b=hr9A2sOdJQBATwmtomdjSjaeSujRb6A6lDTxSLATf7FhYCpquae
	StD4F6Oc1ltYtLis8FBuiJm1IBrM+Qdqrspz3jeRcMp6RYzsx995l6HmhV85SiHU
	ieu0dsjgmslB4Da/+lTteAINV5v2tMHRrTaKBgg9G5LwExRzniUVd9FNZ+kA2dIE
	tV7o8AXIDpvzX8maOYeYJybN38620kdVkMuivhc8fU72EiZqwzTP+Cfi0Xb2ig/m
	UaIX/kRDuR1JpjLMNu6dq5wAy0YgyrdxGzNqJgGRfhwI0o8MwH1Ekv6KpIjUQbL+
	qr6a1MPuq/vNOC3Ajz0caRTV1GNQI/cer6w==
X-ME-Sender: <xms:A3WkahEblTNeFHJpxlMghp5wvBZLLqPamUS2_ux5sQ5fVLyxvGSfHw>
    <xme:A3WkanA6KS3ql03jloI_CeutR2xcUQBj6Er35gQ76hQCLJyuB1D5FPrKC4kS_miNa
    S3ksnOTbE4KT4qs0pgobGVM8s392NDMzLRcmxbr2AbmuukGrVm3MEQ>
X-ME-Received: <xmr:A3WkahVWA4wT4A3ZBSCxrcp3oG3pZheBwQJqdjG5PZnFCbYFJEUTENp0vZ_BeBA12t-zUaFdTSNVNPvlRvxfmiYj4THWUVyU_qZR>
X-ME-Proxy-Cause: dmFkZTGOEUSE96qeJ0fhh9ExKF1q7zWRpy+fWesniCTNvIml1aOmETvBwu6+pUdPmva8fm
    4rNNiLLxRdcji2IWaBiJcOO0HEXQpEkkTovDMM3LcEGD/+fODvq39JH6RURNXfj347nCrm
    GKVKWVmM+jYUzZ316gJsl+MNrGOyZkPbwc7b0qeAvQqGgSlj3tT/rlCouS714ME1lHjP3n
    IN7h1qKKOdlHl6xIsMa03uUWrF0BSu9tUs/GIXO7xamQeE9B9vr3y6wQqIcbWdE5JOC1v9
    UwxEVYwnDlj9H7DzTEbX+LMsnsom+wv6l2g2wfUpY12qmoJSdUyZayPVXgFwsaiRfEPgTJ
    ZMbeI8k5CDiTAWVzHT+K3YkG1UI43kVeYgh9nGe4bNzBzabw2FGwoqxVkqC2pE28LTusXg
    K9Gof1NCkbH7CjFLVCtwngNpYGCzIYovYh603MOcHhwNwh84sz5vs7XAsl7XQHRvVeuEVN
    jiGj7gBWJwF7t4k8IW4KNTMVTK0vHJoZwKwsHNye3dMJqB5f5e69uomFsOCnOvFmQ2gC9m
    N2kORQxDc48EoTDwzMFIS0DviYKGY729bPq3HtsHGQJnK3sFY6TwZlxRG2X6jCHNaZ/bkv
    dXYwx8/AHdGxfqXtQkLDJdI4gjgYt6cKRg0x2o7ntCmxsJlwUErHKFiMj9xA
X-ME-Proxy: <xmx:A3Wkarrka4BRasQDoCnqzbgcOYVR9S5xTigLrUMol__Lj3DFZcIecg>
    <xmx:A3WkatTawTgNyboFZpwKruEtnKen50y7jRpdZ8gvucBH0x_FdDBGqA>
    <xmx:A3Wkal2f_XZajwUmf747Ef1es3w_9vOqyF7jmpZP3HjSYKLSakolqQ>
    <xmx:A3WkapAmc6o54ABHk9X05uUhtQdcRnLWKUqYpORHPD3gNT7EAYIo9w>
    <xmx:BHWkahT3obfWeDfnncCxTPIhCboR2SdJsdNmSRLL7_eW4asSK13WaWqX>
Feedback-ID: if26b431b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 11 Sep 2026 17:39:15 -0400 (EDT)
From: Junio C Hamano <gitster@pobox.com>
To: Karthik Nayak <karthik.188@gmail.com>
Cc: git@vger.kernel.org,  ps@pks.im,  jltobler@gmail.com,
  kristofferhaugsbakk@fastmail.com,  Phillip Wood
 <phillip.wood@dunelm.org.uk>
Subject: Re: [PATCH v10 4/4] hook: introduce the receive-report hook
In-Reply-To: <20260910-758-introduce-hook-v10-4-06f9c506631c@gmail.com>
	(Karthik Nayak's message of "Thu, 10 Sep 2026 23:54:09 +0200")
References: <20260910-758-introduce-hook-v10-0-06f9c506631c@gmail.com>
	<20260910-758-introduce-hook-v10-4-06f9c506631c@gmail.com>
Date: Fri, 11 Sep 2026 14:39:13 -0700
Message-ID: <xmqq33vfa2ny.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain

Karthik Nayak <karthik.188@gmail.com> writes:

> +static void override_cmds_error(struct command *commands, const char *err)
> +{
> +	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
> +		if (cmd->error_string_owned)
> +			FREE_AND_NULL(cmd->error_string_owned);
> +		cmd->error_string = err;
> +	}
> +}

This is my fault, but like free(), FREE_AND_NULL() can safely be
called on a variable that already is NULL so we may want to fix up
after the dust settles, perhaps?

 builtin/receive-pack.c      | 3 +--
 tools/coccinelle/free.cocci | 6 ++++++
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git c/builtin/receive-pack.c w/builtin/receive-pack.c
index 9ac7717096..1d5b050beb 100644
--- c/builtin/receive-pack.c
+++ w/builtin/receive-pack.c
@@ -2452,8 +2452,7 @@ static void update_shallow_info(struct command *commands,
 static void override_cmds_error(struct command *commands, const char *err)
 {
 	for (struct command *cmd = commands; cmd; cmd = cmd->next) {
-		if (cmd->error_string_owned)
-			FREE_AND_NULL(cmd->error_string_owned);
+		FREE_AND_NULL(cmd->error_string_owned);
 		cmd->error_string = err;
 	}
 }
diff --git c/tools/coccinelle/free.cocci w/tools/coccinelle/free.cocci
index 03799e1908..c95ffa2a07 100644
--- c/tools/coccinelle/free.cocci
+++ w/tools/coccinelle/free.cocci
@@ -43,3 +43,9 @@ statement S;
   S
   commit_list_free(E);
 - }
+@@
+expression E;
+@@
+- if (E)
+-  FREE_AND_NULL(E);
++ FREE_AND_NULL(E);
