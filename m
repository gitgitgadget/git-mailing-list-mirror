Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D8F713D89B
	for <git@vger.kernel.org>; Wed, 26 Jun 2024 12:18:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719404287; cv=none; b=cB31qhFJJk3FmG8N4ZDcqReGn08ZqRZ2jRYDRKRmQFtjkz6oa1ez2hkCAxtpoGniwp7QrBKcQ/EGtJxyKkJj16eeE2Qyzlt/JiEBEVLK6/f1znUMSQYM5OkLWBunydm/we/TvwrNoAGhev1BK+eEKT9q+XO4ceHQ/lntWeV6p9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719404287; c=relaxed/simple;
	bh=wphTVrJhWO3MJWr2vMGTdZWtf0OiV7VjXhqOM1f1feM=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Hv7n87foI7/Fg1NuvmIfz0RMcSqmFoC/jSK53yVWcVr513x5E9zO4DDN6d5VI4fsSlMytxGbJ389CV2MWszahf2RjNaDHM6nWL1abN33uQS/Kc9c6mtMEZaSmniJX4n89Kyk7x+ltsnakeGNt9IWrT9g7PCg8F4qYU51/TvHAMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KJF29jX3; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KJF29jX3"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-2c80637ee79so4675851a91.0
        for <git@vger.kernel.org>; Wed, 26 Jun 2024 05:18:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719404286; x=1720009086; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SlTt5Yc/mnTG73OZ2FrscXg/g9E3LuAh2yxKUqT8WdE=;
        b=KJF29jX3IaZ+l/gQPVe97qWk+8UumrF8wu7bkcC/moGPHDIm3zSHcOiblStvh5CCek
         Vtr19IoB1CajXnLFcu2iZ80HiRI8rHihpPrtwbT3jKIFbHmrobgo3X8LXc+3vKeHsP43
         9TpO96PsEnYtHiR1kLMHEhj1pqacqUyZoqSWYJ5qj5w/m14T0b07tV07uKKVeUliDLG1
         69umeclEtu+rv78ZKsmui4AiMsRo/90VQ7zCYfhldbFIJpwWtw38z7cuiuBn4vSnv8Og
         ZG2Iy9F3EH9LpXkbiqsIvYEwwa/jK3HSU+aUwNhANOjZyjqiysb1CnNMToCglJcxAx6N
         ZKvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719404286; x=1720009086;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SlTt5Yc/mnTG73OZ2FrscXg/g9E3LuAh2yxKUqT8WdE=;
        b=q0WGRUkN7gViqihDH0FsZQ4wZ5HOD9//GCLEeHWTmhqgwYEGDPTMH9wUg7h6hv16ua
         4m0HtX2nCz+V/7mQlK4F4m+uLYTQLy9MvGbzeNuENxsBkCRbxY+H7A0C2bjAQHPwmAWS
         aH+IlxgwqSctyXtYK17yxZIyg7G4YuUKnB+2q4BX06hENaJIrE+NL+gbZhjQyLiIlrQu
         iLjCzzLRnRV5/lTNlBVvHWRILL8toBTOwdQ4128ybqszEcl4gD45KIKzuydcnuvWhaMC
         1Wa6jT9fcdgP01XNGp51RNhI6OOqieQ10bBcF/kQCJKudqmYVFw9fTs4flUzE9lCeL/D
         SqTw==
X-Gm-Message-State: AOJu0YyWJ2AEZa1pSKdclRo1F/fU3v3MNbyctqz8FXvRFTEupjbyhspM
	WeeL+xDR48m2kq1N4NQzPgN0EhYlVpFBpulPzvocfvi5ur0rPmRqKRSKWeQtrPcMrTM/mLKqWIb
	ZIstCyyN/VgOOKvZr8B7i63lkIy4=
X-Google-Smtp-Source: AGHT+IHTJKFw3J4CtKsCZiWdBnXW+wKDC1f1RXJZR5ltc6GxXTSLgrPlH/Ngha2W3EUFgEZLsvxdz5iZqg5Z9hnFQKU=
X-Received: by 2002:a17:90a:9417:b0:2c8:e654:66a3 with SMTP id
 98e67ed59e1d1-2c8e65467dfmr556462a91.9.1719404285517; Wed, 26 Jun 2024
 05:18:05 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAO8o=D5womGcsVsGT4h2=3qry05mMrd9dFDkZHrLtPCDw0+2Tg@mail.gmail.com>
 <xmqqo77p8kct.fsf@gitster.g>
In-Reply-To: <xmqqo77p8kct.fsf@gitster.g>
From: Noam Yorav-Raphael <noamraph@gmail.com>
Date: Wed, 26 Jun 2024 15:17:54 +0300
Message-ID: <CAO8o=D5T8geKY98ep6YX+Pa-HVLNXtWznEFxEjTkW3Z+JCxJ_w@mail.gmail.com>
Subject: Re: Regarding howto/revert-a-faulty-merge.txt - another way to revert
 a merge
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jun 25, 2024 at 12:03=E2=80=AFPM Junio C Hamano <gitster@pobox.com>=
 wrote:
>
> These, we definitely do not want them [*].
>  * We do not want the squashed CBA!!! revert or ABC reapply, both of
>    which are large balls of wax that interferes with bisectability.

> So if you want to avoid "we can forget that we have reverted"
> problem, not reverting the revert, but rebuilding the entire chain,
> is a better approach that gives you cleanest history to work with,
> and that is what we already offer as an alternative of "reverting a
> revert", not "squashed revert and squashed reapply on the side
> branch".

If you don't mind rebasing the branch, what you're suggesting is fine.
However, if it's a long-running branch, with multiple people working
on it, rebasing is not an option. In that case, I think that my
suggestion makes a lot of sense. A good idea would be to add the
"large balls of wax" commits to a `.git-blame-ignore-revs` (or
whatever you choose to call it) file.

Cheers,
Noam
