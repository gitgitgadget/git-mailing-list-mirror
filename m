Received: from mail-vk1-f198.google.com (mail-vk1-f198.google.com [209.85.221.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C95142FE074
	for <git@vger.kernel.org>; Sun, 11 Oct 2026 22:29:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791757773; cv=none; b=UKGdcEb1xRfaK52RixLHQlTfEbkuyis+My5mAHiuH4LveXGfw6p1OAf0x0CY4SZJR5CfWesTvyBgNmhVOMMYHyZkxc45fsBE4+dYl8MPkRb/HccsIZ+gm3w4cfghryIcWPv/CJeYZJ7AU6+SVc2c0KyRUoK6mKxrMnmvq6NbNCU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791757773; c=relaxed/simple;
	bh=bxqMvlJBNtMsuy1st4RL4zlB60ZUp7KD3qucQkHWif0=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LxNcc8bXyuq5x3QPi+Xw0OFV70IsyYPbUg2DNWloMGqtRIdpkBlSW18J6B2SIv0tZa5zDOrA+0YgrzA47IxhuKVGmk15EjWrBZFuYg/Hg237zB61aiO77+QG4zHzS6aYjYEImty3iZVuRcjritKO4Dc/qA9QrNZlr1EGDx440es=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=XBKLYJLL; arc=none smtp.client-ip=209.85.221.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--rmistry.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="XBKLYJLL"
Received: by mail-vk1-f198.google.com with SMTP id 71dfb90a1353d-5e1c96a0d70so620913e0c.0
        for <git@vger.kernel.org>; Sun, 11 Oct 2026 15:29:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1791757770; x=1792362570; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bxqMvlJBNtMsuy1st4RL4zlB60ZUp7KD3qucQkHWif0=;
        b=XBKLYJLLPgRPnNhJSUJW1Tjn5MmiXpyWULAxBI9eq3A0EGu8uD8IqnPZei4pJhx3U6
         gKBLmp+f3BaQN3MXaDTDs7uPmTJBEreXENtka+oJnpBJBvkFrmKJJryawT9yHA5/F5Cn
         HKzr+moLl+kBncirPbIdHzRSk2l6pz3v81SS1kH9g04R8gh4GqgGRaHz2w76f5CnmiIv
         KfcvD1BBmsyg+65lpNGk99y1uuOnBN2rRNqmZT9xtfX628DjgR61oGcpBFM4G2vQ3hZN
         CL2e2HWraxim8kldWyVa7zml/EcPB0DUFyw1f7IkIdXGaNJC7omMBBUVDCeMeW8YYdEv
         n41g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791757770; x=1792362570;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bxqMvlJBNtMsuy1st4RL4zlB60ZUp7KD3qucQkHWif0=;
        b=UYHiFnWXkAv45lxllwxedvsvzQLCnmFRwC73iStwM1LTD+ad2XhltrsYlsyxtQhnhv
         sRbDRG5IsIXPkNyfC+hxj9lP9BcgLt0EUu4pWBCsnfiYnwSLSdvv/ByFBidPkxOZ+KSl
         fgKKPqbM8bsxQ3tONhjK9PF77gErVNnZ8sMtIb+24zyJsrOAN9bWnhiJ4pm5o4qnpVbN
         rX0QSB8tpQ2tJ/BXO/i4hY8dEUN4QtzpAmXEhFpGKNhNrglHDXrBgn+EXocdIGUZ0C0d
         ENf7BK396mb9p1PADeR2CQdaZnLL2ydvm/UWc7kpcScaPEbrYVB7xtGsh2vTDjXhYJ5D
         lKRQ==
X-Forwarded-Encrypted: i=1; AKwUvBxmTNLR6p5vrg/A/xYzMYrNxHoZ0AIFWI5um4jq11LLw80FrqVTvGNyPNLTcmil5ZKc+7k=@vger.kernel.org
X-Gm-Message-State: AFq9FYLjYhij6wjvsvr15JHako49Gbi1DVBiGnfbrINGE/nP3XC/7s+I
	cWYUFu2+UqS9qWXx8DxF7Mb0Q10TJqMUu1WYaE3sRLchrDwFC1fsKGbUzUfZr2td1rpdBO91Svt
	u8QnD5yKMxg==
X-Received: from vstu15.prod.google.com ([2002:a05:6102:374f:b0:7c3:5d0:3029])
 (user=rmistry job=prod-delivery.src-stubby-dispatcher) by 2002:a05:6102:3c91:b0:7c3:9b8d:5124
 with SMTP id ada2fe7eead31-7cb3a0aed1dmr1732871137.18.1791757770257; Sun, 11
 Oct 2026 15:29:30 -0700 (PDT)
Date: Sun, 11 Oct 2026 22:29:29 +0000
In-Reply-To: <xmqqtsmsdpxz.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <pull.2224.git.1789169384240.gitgitgadget@gmail.com>
 <pull.2224.v2.git.1791493644.gitgitgadget@gmail.com> <35e303d65bc378e733b1e9e8d6908a829352e857.1791493644.git.gitgitgadget@gmail.com>
 <xmqqtsmsdpxz.fsf@gitster.g>
X-Mailer: git-send-email 2.56.0.rc0.2.g72a87d1c34
Message-ID: <20261011222929.2957901-1-rmistry@google.com>
Subject: Re: [PATCH v2 2/2] blame: ignore revs in HEAD:.git-blame-ignore-revs
From: Ravi Mistry <rmistry@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Ravi Mistry <rmistry@google.com>, git@vger.kernel.org, 
	Ravi Mistry via GitGitGadget <gitgitgadget@gmail.com>, Abhijeetsingh Meena <abhijeet040403@gmail.com>, 
	Kristoffer Haugsbakk <code@khaugsbakk.name>, Phillip Wood <phillip.wood@dunelm.org.uk>, 
	Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:

> Since the scoreboard is passed around throughout the subsystem and
> has a pointer to the repository it is working with, a new function
> like this one does not have to add new references to the_repository.

Since there is an ongoing effort to reduce uses of the_repository in
the codebase, I went ahead and switched parse_default_ignore_revs_blob()
to use sb->repo in v3.

Thanks!
