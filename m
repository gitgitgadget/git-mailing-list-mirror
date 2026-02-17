Received: from mail-pf1-f173.google.com (mail-pf1-f173.google.com [209.85.210.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFAF82DF136
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 16:46:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771346788; cv=none; b=Iwm8yF+f1wlOhg3pd7A6jhlRNZX882xa2qI9IzGudEKT1Zh49NUffEHEFfMzf/2fTiqC09LHn4gn7bwhCwhn4C9hht3P6IUdwXvMIT82uAmpQ4u7nRNMajAruvG42KqjURYoY3vculCG97ajdHRttF/RBSQqMnrtmLDOKv3QLx8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771346788; c=relaxed/simple;
	bh=mzoObMQg/4XM8oydRfpea/Y4kf5AMmS+wrVnf0pLmQA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=RLnwWY4GYM8CE+fzv7W2oNOC590x+XmacqfSs7QQ/rTlxWrMcnkmIVX7aiVw/R4CV3yx4V2prQtFu2yrNizuq6eVwvrglhXkt2NZWbHA0sQ9vx9zaOmfjF4s99lwIxv3gbk8s8tq//DvRLfyZIHYIB9/RqOd5JSMPMM/r/6vMsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=egE/S2U1; arc=none smtp.client-ip=209.85.210.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="egE/S2U1"
Received: by mail-pf1-f173.google.com with SMTP id d2e1a72fcca58-824a6f2d816so2101231b3a.3
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 08:46:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771346787; x=1771951587; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mzoObMQg/4XM8oydRfpea/Y4kf5AMmS+wrVnf0pLmQA=;
        b=egE/S2U1/06s2NATXbFMETIbmd+pQHuX0CZs41MCKo+7wtNQAvVJEoAwH9jSSqvrYm
         613QCLn06XkrD2h9Kbn+5jpGG+kIeRKnXJ0PsBZ6//cJ3mPqDbVADo+qpm7pyuAgzr29
         M82rkBb3lLmMgi4ow+z1DuxCN3WiPlqOd5lcuLq7RLJJ4hZdhSJpbo1EPQNrFPyNprRl
         I9/Cl9eju0A7ErihSmuGLXFpiXSK+ZijX8sJuUnHPK+3AK9QG/MobZjHP4+H3b8P+kER
         nzdyPZRXc9yzGRZMzzMY4LAYssBXlwF1XKC0Yuh+wdo0PIMCKtN73ivmLB5nwJGyLTpM
         QMmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771346787; x=1771951587;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=mzoObMQg/4XM8oydRfpea/Y4kf5AMmS+wrVnf0pLmQA=;
        b=a+by98Y02Ob/oXpVcwSDLnLgmH/8mKwHBlbPdDmkxdJBB9bdRkQY6fLSSbwegYqpb7
         pSCGa2j21NdGN4TtQiqYACkHJ6bESdKYhZcqr0Wo4ENxiIjcjhuzUH2bcFShXMhh2xzF
         RerWhwBEXlwjVpYoRN+186xJbUPAy4MVnr5uzQmhep5SLruV82tgpZskrRbfnzagfXAg
         6vQ1fny0ZV6Urqe/BrrNZG8Au+Cx42R+tgomfIs0xBr1X37NobR0gFR/HRXBXu09MfKq
         6hhl0Hhn4cB5qe8xrfJXmO16CCLjUjLwTpiZv1zE/WTIAthKkLscH/Z9FkXc5q7/Rbil
         UBxQ==
X-Gm-Message-State: AOJu0YyO9l5gDcFWPiPwADVKVYssUa5hExLMMzMaNkWlMJuhu7cDbToB
	dpS1vg69OpWeRbYl5fdXQx6HeJ0y1dj8zKWirpo48+pdwWFFp+7lVB+qNrQV3iP8Ekc=
X-Gm-Gg: AZuq6aLzICuHKNiW4/xK4OBYXwy8lMvwWtdCHbW01PeU8mAywCHFSIuq1J3IZq5wubL
	0eqJcXOiIfiMAP8tYfsuk4FEeHeDekd/ZCmQsLfp4a+vYmQqV0MHntZvWMqKM8t0YaN5R+UdYvP
	uusj2TreMgIFQ0ciQa9pYoM/mhp3/eQ9jH9RQwp/nAa8wJEecxn+rrPDnTQPGqLaPpTTtIEgLOa
	rcJGBukyAnQ5Jy14NLfphV0J93xyfz0Lir0vZUjxa1YiELvo6Z7j7q99X57cJH+zG5Q/2m436Ws
	SlNMdCzzUbt+/KiJko/+f2JFIaj6AXnctIGHUZbWuywiPLM1Rel5WX5Vy3i2NvQ2a3JNdxrV3Hs
	Xy4hLIoNegzR2zoShYxnbGyDsueU5kABAL6eG644JpprPsB/m+mBw5v0OD01fWN5KhtZZWwG/KW
	fZ50Ymy3ZQ8OBzKQ/4IplxMkLH+YqsKUszf5Z3d8mwRDksldq1NuArGVgU62fWUoTCtycN
X-Received: by 2002:a05:6a21:6494:b0:38d:ea8a:3dbd with SMTP id adf61e73a8af0-3946c9402e7mr13027246637.73.1771346786809;
        Tue, 17 Feb 2026 08:46:26 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:a392:d36:fa44:db83])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35662e53936sm23253251a91.1.2026.02.17.08.46.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 08:46:26 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	karthik.188@gmail.com
Subject: Re: [PATCH 0/2] worktree_git_path(): remove repository argument
Date: Tue, 17 Feb 2026 22:15:49 +0530
Message-ID: <20260217164615.55916-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <d7fe45b3-4a75-4a28-aa0e-74619fbe6a2f@gmail.com>
References: <d7fe45b3-4a75-4a28-aa0e-74619fbe6a2f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=y
Content-Transfer-Encoding: 8bit

> On 17/02/2026 10:12, Shreyansh Paliwal wrote:
> >> On 14/02/2026 14:30, Phillip Wood wrote:
> >>>
> >>> I think that we should add a new function
> >>>
> >>> struct worktree *get_current_worktree(struct repository*);
> >>>
> >>> to worktree.c that constructs a struct worktree using repo->gitdir etc.
> >>> The worktree id is the last path component of repo->gitdir when the
> >>> repo->gitdir and repo->commondir differ, otherwise it is NULL. Then we
> >>> can use that function to get the current worktree rather than passing
> >>> NULL when we call wt_status_check_{rebase,bisect} from
> >>> wt_status_get_state().
> >>
> >> Here's what that looks like, the first patch adds
> >> get_worktree_from_repository() and uses it to avoid passing a NULL
> >> worktree to worktree_git_path(). The second patch then removes the
> >> repository argument from that function and always uses wt->repo instead.
> >>
> >> Shreyansh - I think your patches to clean up wt-status.c can probably proceed
> >> separately to these if you remove the changes to
> >> wt_status_check_{bisect,rebase}().
> >
> > Cool. I'll send a revised version on the original thread.
>
> Great, I hope I'm not stepping on your toes posting these patches. By
> the time I'd worked out what was needed and checked all the callers were
> passing a non-NULL worktree argument I had the code changes and commit
> messages so I thought I'd post them.

Not at all, I’m glad you posted them. They clarified the right direction
and are logically more fit.
I got to learn a lot about the worktree API while working on this,
so that was very helpful. Thanks :)

Best,
Shreyansh
