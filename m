Received: from mail.envs.net (mail.envs.net [5.199.136.28])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F309155336
	for <git@vger.kernel.org>; Tue, 11 Feb 2025 01:13:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=5.199.136.28
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739236429; cv=none; b=pawDtM+BKrWQQkmH+JQR3Bw8viY1rkFWg8gA4Nx8ELElVjdsNiE79CLmHd4USQ3E8mmOd9vNYRnBnI2xY6mItCKOQl4MxRktF/HxZHlYTXFJgyaJ+3p/jzEfKgSm79PKxLeGhrvoonhHGez0zY5tNpkWbmkGzlROStjKSCLJuc0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739236429; c=relaxed/simple;
	bh=DdO28ngjOx3YREJ7PqxmElC2FHeCQehhFJ7T5wvWrbo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=baf7n4bHrj/an3NehRGrulaell3JlHuRMr6ZH5kJUPY7u5RAQbMOkKlDZJ4zgq5wgMiPF5qAQ0bkFIzl3QQ47eFATP0VpyTNGH/v1EBQ8uUayJPO+ibzkFRxp2UPNE/ILJu0Jawr0Cd3oV5L7pyMxcpaEEBJJf0wRem86W/pfeI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net; spf=pass smtp.mailfrom=envs.net; arc=none smtp.client-ip=5.199.136.28
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=envs.net
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=envs.net
Received: from localhost (mail.envs.net [127.0.0.1])
	by mail.envs.net (Postfix) with ESMTP id 82FA738A3EBD;
	Tue, 11 Feb 2025 01:13:41 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.envs.net
Received: from mail.envs.net ([127.0.0.1])
	by localhost (mail.envs.net [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id zqPtIM7YQwUX; Tue, 11 Feb 2025 01:13:39 +0000 (UTC)
Received: from xtex1.localnet (unknown [120.230.227.202])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.envs.net (Postfix) with ESMTPSA;
	Tue, 11 Feb 2025 01:13:39 +0000 (UTC)
From: Bingwu Zhang <xtex@envs.net>
To: Junio C Hamano <gitster@pobox.com>, apenwarr@gmail.com
Cc: git@vger.kernel.org
Subject:
 Re: [PATCH] contrib/subtree: verify HEAD is valid before adding a subtree
Date: Tue, 11 Feb 2025 09:13:26 +0800
Message-ID: <12606159.O9o76ZdvQC@xtex1>
In-Reply-To: <xmqq8qqddarl.fsf@gitster.g>
References:
 <20250210021128.31083-2-xtex@envs.net> <xmqq8qqddarl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="utf-8"

On Tuesday, February 11, 2025 12:28:46=E2=80=AFAM GMT+8 Junio C Hamano wrot=
e:
> In short, "is not" -> "may not be", perhaps?

Yes, thank you!

> And if we want to treat an unborn HEAD equivalent to an empty tree,
> then dying upon seeing "show-ref" fail would not be a good solution
> to the problem, no?  Shouldn't the updated logic to deal with an
> unborn HEAD be more like "if we see that the HEAD is unborn, then we
> are happy iff the index is empty; if HEAD already points at a
> commit, then we are happy iff the working tree has no changes
> relative to it"?

I did consider treating an unborn HEAD as a empty tree and test if index is=
=20
empty. However I searched and failed to find out a git subcommand to do tha=
t=20
test (:
Do you have any suggestions?

=2D-=20
Bingwu Zhang
xtex @ Tue, 11 Feb 2025 01:10:17 +0000



