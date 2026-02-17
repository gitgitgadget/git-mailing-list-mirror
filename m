Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFA93322A28
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 10:12:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323173; cv=none; b=GKd77dykGJeF/R7wfsrdSQASVfK7OFlMKigITFHrV4uSCpK+szWgJcY4YOz/r9iCTGgmOSWV1XMTc9jFqvEBZ91JUXqp6OJ+4Ik57wFLy4kZYuV4Mh9YiBM+EL1n5fRDNmortFkxUnsItCPN/HpDpzD1fZO8Hrdw2FSeFxsAoic=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323173; c=relaxed/simple;
	bh=HQ35OhQzpTINIfiO4lSJxta4eVcU59r59jOnWo7sGzw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KxTDsevhNGgpT9FlT4WGuhwljdB9+WTC/C/E8BFhdZfxErp30TGwKuj/imNET3XDmcZxdRACv3rqqqkCPSpD9pqql3Cuz9oJoWXBdBuAVOz+z+FYuHVMEmyDhJC8Fif6jd4tYlKxZLH/X3MLjvKCwbqOcPtYeZMkUf2VWPweBUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Ile5QZiF; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ile5QZiF"
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-823c56765fdso1989275b3a.1
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 02:12:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771323172; x=1771927972; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=HQ35OhQzpTINIfiO4lSJxta4eVcU59r59jOnWo7sGzw=;
        b=Ile5QZiFKFZkR2csQbrk93ogtpRkc4wArJqKv/PS50MvhoZhxAXfGM+xqidCaLKKHn
         uD+Dn9IdqgxgzRsZD8J/aTOO8AIRaJDUC26gKsJrlPKHT2B/RdDv8neMayZTk6JJz+Wc
         jCd4razlBnq3CgUhg3LeMcrCwi8AAcjV63Doq3NyxhDspoK5TIPNqKxVTAcNxb6hJJ2T
         iw/JIDGjXE/upQZeYNrRv3CRcAg7JqtYmqTKqhFEBOlp/iUTRwQg6S5mlAlXK3p48/HE
         uFSgf66/vuljdW47PSt74vViZsQefdPy5T7IOcNFlx/CYv3kkmocOQX69AoLjlcCwLAn
         Y9IQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771323172; x=1771927972;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=HQ35OhQzpTINIfiO4lSJxta4eVcU59r59jOnWo7sGzw=;
        b=nBsYIz9EVQZSGM7Ey+n3Pl+7GI34o79WHBupXxhD3c8xRLfscpYnyp3+7O1rqTxSWV
         AM56Gdr/GhZOl9PFlWjOKQLNx7NjJSa5GfVV8nz09U4jKVqHhg4kzloFQilTvuzMJp+o
         2ivDZ+hwHuZfQJh3/qN1ACllQEle9wCkIoOjdzQh1Bpp0HRGsMBrOsCu2GhckwfuPg5e
         UY6nr/CNU/MoaJaPPk6r9e3u0HHVcE3IESgMMaaH4XY4TvmWfR0w1S0BwLljO3J+pbqq
         C+GaOBSzdI89s+zAhc+XGkFCG8ZTnJFQ5Gg+DseMG3aDnuVRKAru7+7mpbnHxwfbbZAf
         1+4g==
X-Gm-Message-State: AOJu0YxFPi+HPwvt+XIwUe8d6bjaslTdOGecxWS5jU7b4fwGj5UReonQ
	1WS1pHc1cZYWBctZqMqN4OJOWMCgcpDV5hsY6S8Lvl4MwnIyzshw4xPypUfA0VfOcQk=
X-Gm-Gg: AZuq6aIDPeaAgEXXhDD0WeJEqESI27c/tgG1xIhlRWey/BsAWnU4QWw+v/792smtUDC
	vbjBeOHnMinvxluPjNWbcqD7EE4SAAQj4UKbljOi49lK0KbWlIChWCvYZnZxPjRFAYaNLbS+JpJ
	gnFTcsi9ZbDieCUnzfjooi4jE7B6A3ng4bWZRQiawmNUhzCLuI/eTw6R23LUCIceRcvH/OB+O/M
	M3qfzRPORb2TkEithx5/KtA3gzq+6+alTfmmwzNrnHyd2A4Qt895nzRjsX18qh0BtWzzxuz55YC
	bc2Kemu0HE8lgRiroIs/TudkZmwoLRjvU1w7zjVIyVqHUeQzaQJMHlPVS8MgHKvHWa9fjuJINTS
	8fIkSEiAgf9BDA2cODmw8AlqvYuqvtPS/O9KwbBRnPeux4Zs6gn/UDBi4YCHP4tQngNNA0zVs/6
	4cj0720SipXmoOzeywYNk2E2z+4D277V2vvCxSAoHutkDrZJMruCFqLqxoi0w=
X-Received: by 2002:a05:6a00:1308:b0:781:2291:1045 with SMTP id d2e1a72fcca58-824c94ed816mr11690398b3a.8.1771323171880;
        Tue, 17 Feb 2026 02:12:51 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:8c2a:3e1b:2a7b:dd15])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-824cc22f4d9sm12176813b3a.39.2026.02.17.02.12.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 02:12:51 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	karthik.188@gmail.com
Subject: Re: [PATCH 0/2] worktree_git_path(): remove repository argument
Date: Tue, 17 Feb 2026 15:42:21 +0530
Message-ID: <20260217101242.14688-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <cover.1771258688.git.phillip.wood@dunelm.org.uk>
References: <cover.1771258688.git.phillip.wood@dunelm.org.uk>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 14/02/2026 14:30, Phillip Wood wrote:
> >
> > I think that we should add a new function
> >
> > struct worktree *get_current_worktree(struct repository*);
> >
> > to worktree.c that constructs a struct worktree using repo->gitdir etc.
> > The worktree id is the last path component of repo->gitdir when the
> > repo->gitdir and repo->commondir differ, otherwise it is NULL. Then we
> > can use that function to get the current worktree rather than passing
> > NULL when we call wt_status_check_{rebase,bisect} from
> > wt_status_get_state().
>
> Here's what that looks like, the first patch adds
> get_worktree_from_repository() and uses it to avoid passing a NULL
> worktree to worktree_git_path(). The second patch then removes the
> repository argument from that function and always uses wt->repo instead.
>
> Shreyansh - I think your patches to clean up wt-status.c can probably proceed
> separately to these if you remove the changes to
> wt_status_check_{bisect,rebase}().

Cool. I'll send a revised version on the original thread.

Best,
Shreyansh
