Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47A0278F26
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768580890; cv=none; b=CEQfWu4fCLSJMEXhOBGlYsT3rPGBQWmbo6MTi9BWourkb5it7RCx0avGR8CNmSURsgyM0rhm6y0K3IbfpPq9jLudeuO93VNiAYJd+Tf2v94A1faG7Fj1Bestjxg0wu9hHUhQVO4pu5oUx+eVOMFBgmfG2VfbYvV1vyVWCWZPJIU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768580890; c=relaxed/simple;
	bh=RwJskpkRQoaOAbpAFQe5Erpdtk4ALHkkC0kOeVawdNA=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UJUg+NXkODfuUUQBf3sRAbyrhVOYqzd8O3g+RelRGSsrfgbpEIHc1rafe/jUtmTZ4gqhkvWJtjtc6wxh0k3afMTGPJRREwzZLifsFR4uYjaTvsCSA62GmEI+oOBc2Z7/A1kMtBGB3l+SqlfWjk5KvDpMAZx2wXwnY24LLSPgQBg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=g1iXB9IN; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g1iXB9IN"
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b876798b97eso372067966b.1
        for <git@vger.kernel.org>; Fri, 16 Jan 2026 08:28:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768580888; x=1769185688; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=HZMORUUD30lxPTP2v1EDOmiC5c7nXI6tTOEx2Ts/btM=;
        b=g1iXB9INcps/Kc6SGDEAICaXE1rQXbL0CChV70fk+MoCJmU95D4YC7z5VSnFnnxqMA
         cpWMzJ5ciC3gr49I/A17E/NSVUe2YxyOqLuQHw337rx/fR1wKbbsjTQiWTD+ddl277eh
         VvyhZ6crpIUp8A3HNgKkapZg39ZTHHDkrh3CIbktJATcrr3eUbpwY+QziMtAgPnw7Eyc
         /Z/rPEpl4ebZJ6AdW10Sa0qot9VxKLUPclZjpBgrNt7XGX54K/Be4mQojPzgH28Gzr+k
         Tk8AEd3u2iJFb5/jZwBSGM9iFYU+LLKGUuPX+++M/28rzgqIA3e8+aD8EEt8IJsPpI3b
         6Pww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768580888; x=1769185688;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HZMORUUD30lxPTP2v1EDOmiC5c7nXI6tTOEx2Ts/btM=;
        b=NBu5YX+d4rPCbppebac8sOSJJK5N1AnLCUpwyRbglgFhPeqDQ2Cro0YtnTLn+/f8JX
         aotY/GhhILXcp/95AupennnFwPPLRyzqjtOGVsKmw5zEUEeEsWbBFEiAD3eA8U41K8X/
         D9hgpu3Oqg0tgWfRM1ZxkuaBq/Xo8dGR6GUvTChpGmTVAqFRwl8JKGVOso25EqlO4rc6
         GBuyc3nCcmhsoBmYMnSX0pl97ffOZWwcxOEjNB/yy3rgmfoiATUZW8CiG743oAzfwPo/
         729DN/WKNerS4w/I+LJkZxpTFN53utLmVZDcal++E2wcpR1yqF4R8Nt2hpgpg7Qk9soM
         76NQ==
X-Gm-Message-State: AOJu0YxdnaXJ8+ll5FliHy4zJR0NgLUm8tDn1G8dCERHqCkIoNH0BuGT
	rhrohV5iM0dXTPl4KcUc9BeZNrRa7g34k+UON68bMmLINlezOSdLwVHI
X-Gm-Gg: AY/fxX6SAuKX/fK1lxZTAgE4wPaAApWCSFlbw4Af3VoNYHj+gcO1+ZQseO64xxjeqet
	aCXWeDEzY9wa23NOMydEJYZg+wz1i4oGGDvCFjo7g9PXtg3rRcofJZqF5smpoOyMd+o6BduyJPr
	r9VNtZoR3nth9o1NXx6F0wb7bVBMoiVISyCIDGgAv0DFeGiT5UiyKosqQ+AVxJ7v+ElhPwgNBbK
	zR6gAwEdMfJ78MxM/q53x78Rkt68xY3n244sYwxXnyJKwCTSzOCYJIUsz2RmQbJ/b3cQJT6AIv8
	LQ/N34e7G4TzOztsNqhnPjqgBEl2iqdIWernaruC5qRfr5y4MIZHJpCXnCdBmrocFWf61WcNNr7
	8hUpMWiLUzf2OZE2qAziqIfosHbU4zyEAyMS/vM73vbLIYKrzTDndIjMQw8SszgoGK3l7kbDX9L
	w7bQuIu4aLpcHYDXFWGtoo7ku2o1rmkd06zan/TsVTVusiPw4fMV/j2n7apDqH/nX4imgIvJbc
X-Received: by 2002:a17:906:4793:b0:b84:2070:201c with SMTP id a640c23a62f3a-b879324ad10mr317442166b.54.1768580887256;
        Fri, 16 Jan 2026 08:28:07 -0800 (PST)
Received: from localhost (20014C4D24DD3900A135D2EE9B3C72E7.dsl.pool.telekom.hu. [2001:4c4d:24dd:3900:a135:d2ee:9b3c:72e7])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b87959c9a08sm281851766b.37.2026.01.16.08.28.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Jan 2026 08:28:06 -0800 (PST)
Date: Fri, 16 Jan 2026 17:28:06 +0100
From: SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org, "D. Ben Knoble" <ben.knoble@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Sergey Organov <sorganov@gmail.com>,
	=?utf-8?Q?Jean-No=C3=ABl?= AVILA <jn.avila@free.fr>,
	Martin von Zweigbergk <martinvonz@gmail.com>,
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>,
	Elijah Newren <newren@gmail.com>,
	Karthik Nayak <karthik.188@gmail.com>,
	Phillip Wood <phillip.wood123@gmail.com>,
	Matthias Beyer <mail@beyermatthias.de>
Subject: Re: [PATCH v11 8/8] builtin/history: implement "reword" subcommand
Message-ID: <aWpnFqTmWB9XIWUW@szeder.dev>
References: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>
 <20260113-b4-pks-history-builtin-v11-8-e74ebfa2652d@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260113-b4-pks-history-builtin-v11-8-e74ebfa2652d@pks.im>

On Tue, Jan 13, 2026 at 10:54:39AM +0100, Patrick Steinhardt wrote:
> Implement a new "reword" subcommand for git-history(1). This subcommand
> is similar to the user performing an interactive rebase with a single
> commit changed to use the "reword" instruction.
> 
> The "reword" subcommand is built on top of the replay subsystem
> instead of the sequencer. This leads to some major differences compared
> to git-rebase(1):
> 
>   - We do not check out the commit that is to be reworded and instead
>     perform the operation in-memory. This has the obvious benefit of
>     being significantly faster compared to git-rebase(1), but even more
>     importantly it allows the user to rewrite history even if there are
>     local changes in the working tree or in the index.

In an earlier round I pointed out some of the differences between the
'reword' instruction of 'git rebase' and 'git history rebase',
including some drawbacks of the latter.  It's disheartening to see
that you only picked those differences that are in favor of your 'git
history' command, but neglected its drawbacks.

Please strive for less biased and more objective commit messages.

>   - We do not execute any hooks, even though we leave some room for
>     changing this in the future.
> 
>   - By default, all local branches that contain the commit will be
>     rewritten. This especially helps with workflows that use stacked
>     branches.

Please don't just state that all local branches containing the
modified commit are rewritten, but justify why it behaves that way.

Git's porcelain commands operate on the current branch, unless the
user specifies a different branch or an option like '--all' or
'--branches'.  The default chosen here is inconsistent with the rest
of Git.

This is a bad default for any future subcommands implementing common
history rewriting operations that can cause conflicts.

Users must remember to specify a non-default '--ref-action' if they
don't want this behavior.  If they forget to do so and don't notice
it, the old commits will be gc-ed away.  Therefore, I consider this
to be a dangerous default that can lead to data loss.

I firmly believe that operating on all local branches must always be
the result of an explicit user action.


