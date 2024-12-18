Received: from fout-a1-smtp.messagingengine.com (fout-a1-smtp.messagingengine.com [103.168.172.144])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B655191
	for <git@vger.kernel.org>; Wed, 18 Dec 2024 06:00:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=103.168.172.144
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734501658; cv=none; b=ZAzmdUq6ZBDAexLkZ/XAP/qqNTUmPRSjc9QpUN01YNUDWzOgwj50mbHkWxbG5Iuv8hEsVMlOe8LBq9CQqWUnjg33sz7vGKkIKZtSt5ABrbUAhNMMPpsLAZAnAlSYdRUgzltXZUW778BOqmW6ZujmbxhkEAihsnEFYFPtdRmxoDk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734501658; c=relaxed/simple;
	bh=Ateh2H/dPMx+xb/T5Wk5y7hLx/l2LoRC4f72b7gHd+Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=a8roz4Y+1Yr1BVzHbeZO6/YR+hQ0EApnokw/O4NtzJ3goA2gFTqWTAZTSz54TyvbrFk6oX7BzakDKDYn/p/cWq3a8og9jAb2QTiaqa5o0cXLnKxiVmzNBlpc9b6/X7s/DT4RXicxs2qBnTkcQWvRC/DBPI6v/xHHslTfAOKVTlM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im; spf=pass smtp.mailfrom=pks.im; dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b=h2Jja1g4; dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b=xUCeB8is; arc=none smtp.client-ip=103.168.172.144
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=pks.im
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pks.im
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pks.im header.i=@pks.im header.b="h2Jja1g4";
	dkim=pass (2048-bit key) header.d=messagingengine.com header.i=@messagingengine.com header.b="xUCeB8is"
Received: from phl-compute-12.internal (phl-compute-12.phl.internal [10.202.2.52])
	by mailfout.phl.internal (Postfix) with ESMTP id 8C3EE1380293;
	Wed, 18 Dec 2024 01:00:55 -0500 (EST)
Received: from phl-mailfrontend-01 ([10.202.2.162])
  by phl-compute-12.internal (MEProxy); Wed, 18 Dec 2024 01:00:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pks.im; h=cc:cc
	:content-type:content-type:date:date:from:from:in-reply-to
	:in-reply-to:message-id:mime-version:references:reply-to:subject
	:subject:to:to; s=fm1; t=1734501655; x=1734588055; bh=VPgFG7wZMq
	Mu2JfxFRrz25nQ2v8H4+uoYDDaI2RXyzY=; b=h2Jja1g4crNnmaNKihp8vVw37C
	OzJyj9SyiLkujxKP6EfNwwGTdaxopDQ7Rydq4qRkViY6nTnv5pcGwaw9L7OFtPRL
	IRj+83Vwd1dEbniu+TmK5o1wjTFbc5ABVSIDWWQ1//A25PRege7p06duuz1pc/nc
	tJbODr11jrqzeDzNI5FfKLE0abrdQJ57K76bhon6PsM+q9AiQ06SdJpPxigNcR6W
	WgYuAThYSwnaYPQzfqcVA23GBMOGH74GAWTYZQ9mbeLNmyq1NA5mp1j6Kxg0J/rR
	9hCu1l2ivhEBoqtvHdcDKw9H2VysJY8M8gPbE52rZbMVXUzj6KkpcEXAccPA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
	:message-id:mime-version:references:reply-to:subject:subject:to
	:to:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
	1734501655; x=1734588055; bh=VPgFG7wZMqMu2JfxFRrz25nQ2v8H4+uoYDD
	aI2RXyzY=; b=xUCeB8is7HZB35JJrHSPG97PkTSIycH5YrmoOHs6X6tQKVjg8ut
	zVgmrQSQqw0yaig0Hcv6suejovFoMB7Ma/ONVmSP+SmI54E2kNEyskNxLDLQL+hB
	x3pV+xo/WXu6Gca5TYv0MQ6zJZ5EIS0glXEsfmy2SPQ+fs4ehOHs3eAjp56hp/NI
	U6xd1wXdua5i5vBkVXae9V21abBxi+1VihZ7eJyA9fS7xb45hOtIWyb7ZnGUzvP5
	jmg5v7pyjcDhzc/q8da7xL4jg/bO6LnqUp8K7i4ui24SvPLcBuEichWPCPR8zx9J
	owF2deGtocd/FXyRqJX/0gF1Hx9cbC7ZkiQ==
X-ME-Sender: <xms:F2ViZ0sFWKxDBGsIQUFVo3kQCA0GNZ-_JRiCZVqtp2ESsrVN5afhVg>
    <xme:F2ViZxe_Vakm2HKuCOfhC_v_uyktd9MbUbv3VVoQ64z8KLJtc-MYPIfaGtlTfD6lI
    TBUdOvrXrXs-Jbo0w>
X-ME-Received: <xmr:F2ViZ_xexTW_EYI_qsHyHYB7e116Q7RMsGmdpOSTUYbmdZomtAJZjwy4JrfDu6pUoymiw80KtXDrQUHoNfwZUfPBBMB76WR7KqJJNiRsc1ix>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgeefuddrleejgdeffecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpggftfghnshhusghstghrihgsvgdpuffr
    tefokffrpgfnqfghnecuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnth
    hsucdlqddutddtmdenucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecu
    hfhrohhmpefrrghtrhhitghkucfuthgvihhnhhgrrhguthcuoehpshesphhkshdrihhmqe
    enucggtffrrghtthgvrhhnpeevkeekfffhiedtleduiefgjedttedvledvudehgfeugedu
    gffhueekhfejvdektdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehpshesphhkshdrihhmpdhnsggprhgtphhtthhopeefpdhmohguvgepshhm
    thhpohhuthdprhgtphhtthhopehgihhtsehvghgvrhdrkhgvrhhnvghlrdhorhhgpdhrtg
    hpthhtohepghhithhgihhtghgrughgvghtsehgmhgrihhlrdgtohhmpdhrtghpthhtohep
    jhhohhgrnhhnvghsrdhstghhihhnuggvlhhinhesghhmgidruggv
X-ME-Proxy: <xmx:F2ViZ3NFk5UL8lI7rNoKfFgpzrpFLLSk-I6TlAr2VI600RJmgiprMQ>
    <xmx:F2ViZ0-oYfwEa5irZT63aPRdyUWsROUJi98NcovLDpTRVzvgSGm1oA>
    <xmx:F2ViZ_U_hl65JVycmKxUrxngKb4wnqVOgmrbtGhRd2KfCmBocM6DBw>
    <xmx:F2ViZ9fqGLuE8UnhWxCB87CSvI3PqDKcALaKGhop8EDoMwniByvm0w>
    <xmx:F2ViZzbPGOD4R-eASkqzslgKhvoUuUSdvYb-jOPV1EyR60RKP1uZ8cEQ>
Feedback-ID: i197146af:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 18 Dec 2024 01:00:54 -0500 (EST)
Received: 
	by vm-mail (OpenSMTPD) with ESMTPSA id aa993479 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Wed, 18 Dec 2024 05:59:07 +0000 (UTC)
Date: Wed, 18 Dec 2024 07:00:37 +0100
From: Patrick Steinhardt <ps@pks.im>
To: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH] mingw_rename: do support directory renames
Message-ID: <Z2JlBQ4DNf7tsNxV@pks.im>
References: <pull.1839.git.1734439924842.gitgitgadget@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <pull.1839.git.1734439924842.gitgitgadget@gmail.com>

On Tue, Dec 17, 2024 at 12:52:04PM +0000, Johannes Schindelin via GitGitGadget wrote:
> diff --git a/compat/mingw.c b/compat/mingw.c
> index c4320769db6..e8f491d03a7 100644
> --- a/compat/mingw.c
> +++ b/compat/mingw.c
> @@ -2273,7 +2273,7 @@ repeat:
>  
>  		old_handle = CreateFileW(wpold, DELETE,
>  					 FILE_SHARE_WRITE | FILE_SHARE_READ | FILE_SHARE_DELETE,
> -					 NULL, OPEN_EXISTING, FILE_ATTRIBUTE_NORMAL, NULL);
> +					 NULL, OPEN_EXISTING, FILE_FLAG_BACKUP_SEMANTICS, NULL);
>  		if (old_handle == INVALID_HANDLE_VALUE) {
>  			errno = err_win_to_posix(GetLastError());
>  			return -1;

Okay. I saw that FILE_FLAG_BACKUP_SEMANTICS was used in several other
users of `CreateFileW()` in this context, but I couldn't find good
enough information around what it is actually doing anywhere. The
explanation makes sense to me, so thanks for the follow-up fix!

Patrick
