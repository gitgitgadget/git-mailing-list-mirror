Received: from mail-pf1-f176.google.com (mail-pf1-f176.google.com [209.85.210.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 842353C2797
	for <git@vger.kernel.org>; Mon, 23 Mar 2026 17:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774285666; cv=none; b=ZTh0/TSRfoMEIu1XF7wC/HKhr8VIg6qOqXynlxp2sZ+tNxsG+M77hhjvkR5iNlBnzJ6s0CZfWGlAWtgTwHlp3D5siIWYdLYCXa+9wVcXLkKHHaTQ5DtkBFVBWQxuxZ9X0Vl4BPeHd+yepTaxPi9Eu8Bmg9W4TLFhFRmrgsH7R4I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774285666; c=relaxed/simple;
	bh=im5uIjZ5LvbDY4lo5WJrKhty4IFbJZVvF6aYIKbqlP4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AoiVfPtU6dH2WtAU4axcpBijlxRNySvs2Gx3N2W0gk0wHrVngc6HZMHWJATZqqJLWumTyajhaAb6Wsy3KDJXEy79tYfngAlAGs3vBD1iVRx8/WAZrhBtDHtS1uobTo7nbE5zHYtZUCyM6fQLHGhSQfBAv52SWuwqg9BnYJdgK8s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=N6ZpLbyW; arc=none smtp.client-ip=209.85.210.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N6ZpLbyW"
Received: by mail-pf1-f176.google.com with SMTP id d2e1a72fcca58-82bae83318bso1533385b3a.2
        for <git@vger.kernel.org>; Mon, 23 Mar 2026 10:07:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1774285665; x=1774890465; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ky1NTye1giroj69HQBmsUjQ6Vj6F+n0dOX0M/rPB0EM=;
        b=N6ZpLbyWOMoR6uV84XCRCRumqZll9aKMBnm1dvzLGGjQY6G4r7bf62LUHQ6snbtr23
         BC3Igxi53QMBmVeqQv8NdrrogMRex4o8dnkJRagys7TCW49Phqn09pZwfBdyllTjPNgb
         iYpmZYKprJAAVSj4v6ngB4uuv7odAVPPIQppSkhpQGYJT2s+SEtCB7s7zuG1Il1fbfeP
         PmVyiizENbRoqKBq/Oq5NDYilTGgACCAv8bqsFAqRTZZZSUXUSficz9KhMxKN7tyPhtw
         RQpj94xN0XGHE4I6tcdp+1rh80cTy+Jgn4nbYZCVIMn7LvWhkph6EnTu4xDS5hu//KbQ
         Wpsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774285665; x=1774890465;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Ky1NTye1giroj69HQBmsUjQ6Vj6F+n0dOX0M/rPB0EM=;
        b=UCD7t/ho5oClDS3wzzIxu9hTIueMQBMX4cGF56a8XqX01yoOoR+hsXBYvHJHrH89w/
         yicIMh2Rw3rivivE9vgxJ3+fNCO+oEYDpW6pu7wmZnlS7cLI77y/qKp9Y89YbjpVHJ2x
         GE4/JGeMWWCIRi/m30CnZKeGIZk1ZvImAQA/6atMLiS4yKIpxVa/RY8H+aXh9Yr0uPwT
         k6RNKEb7uhw+jCcoGoKBrgesBla2Qy42dELZChJeuyAIzdHqTeoMoUSasoKymSgLgfSx
         nnnszuDozfKglEgUoEnaVg7/mqczIx5xVCuG/Xc1v/IErjOalI1rAo47aHMbF43friWZ
         VWlw==
X-Gm-Message-State: AOJu0YwN++xkJVz4na6ZmKj2ZL0LLsUJw+Wjc9Qbp3fKrJPKSqdm+mNh
	E7MworLObf7oRNRVlyjVrNLWgr9+Ng4cDS+03XJiIgT0nozhayVbxtU7uzBwjg==
X-Gm-Gg: ATEYQzzi6LnRHgn2sBPUOORTw7sWyvBprlqU116JMl8t/HJkVnB9bFyTdoEP5Yr+sLc
	8UI40qTeyF0wQ1nGLJym2Gmmdo9C1Ul8EoM4JfjSHj5mmuVDPd8Gz1gHhqdTVliXMWllJPsITF2
	OMdTLJoZzzG3YfNj7vg58yBUUUKTS55S9bq8UcZLMZWkoOlx0m/t+qMc4sJ4PyxJBEwAx51Zudi
	Z4X/1uXpneR8Ky99l0AB03zXkcL3c4R2nnUP4QOgR+t8vuF9p9VDp1F9sbcBO9L1UWU6JHPH4MP
	ID6Rvke2kXFh4ItPXMXm8Ep4jr2Oyd+eW9NN945kkLzzcQxTAdtv22mc41UBWWMaxUGpQla3q0X
	Z5c9lADLECQlBGCaXzDm71hNm8Of0f4LBq/sz1WDMfZIm7Nj1uagwMin7IrxDqcxJpJZFwUy+E0
	9u6VSKZ38cZveA9Ju0pjvRwHyzu6h+SlqQgJfmU7slpQ==
X-Received: by 2002:a05:6a00:1d0f:b0:828:d9a1:c604 with SMTP id d2e1a72fcca58-82a8c237a8bmr11137192b3a.12.1774285664599;
        Mon, 23 Mar 2026 10:07:44 -0700 (PDT)
Received: from Shreyansh-PC ([2401:4900:88eb:4aec:ba2b:bc5:2170:ca7b])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82b03bc66b3sm10625817b3a.21.2026.03.23.10.07.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Mar 2026 10:07:44 -0700 (PDT)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood@dunelm.org.uk,
	ps@pks.im
Subject: Re: [PATCH v2 1/3] worktree: remove "the_repository" from is_current_worktree()
Date: Mon, 23 Mar 2026 22:35:32 +0530
Message-ID: <20260323170650.938396-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <532616a4-d410-4a38-8038-1fd22e39217f@gmail.com>
References: <532616a4-d410-4a38-8038-1fd22e39217f@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

> On 23/03/2026 09:41, Shreyansh Paliwal wrote:
> >
> > This may be slightly out of scope for this series. My understanding so far
> > has been that originally wt == NULL is used to represent the 'current worktree',
> > which eventually meant following the process-wide state (the_repository).
> > With the ongoing multi-repository work, the meaning is being changed to be
> > interpreted as 'the worktree associated with the repository that we are working in'.
> > However, in path.c there are some callers of repo_git_pathv() passing wt as 'NULL',
> > I know that there is not involvement of the_repository state but it would be create
> > less confusion if the semantics of worktrees are same everywhere. So if we replace
> > those NULL callers with the current worktree and update the checks of (!wt) to
> > (is_current_worktree(wt)), some tests are failing mostly related to refs of linked
> > worktrees, and I think the error is originating from this,
> >
> >          if (!wt)
> >                  adjust_git_path(repo, buf, gitdir_len);
> >
> > So I am a bit confused to whether wt being NULL here could mean something else
> > behaviour wise ?
>
> That line comes from 543107333b3 (path: worktree_git_path() should not
> use file relocation, 2017-06-22) which explains why we don't adjust the
> patch when wt is non-NULL. worktree_git_path() is called from
> builtin/fsck.c in a loop over all worktrees so changing 'if (!wt)' 'if
> (!wt->is_current)' will change the behavior for the current worktree.
> While it might be nice to clean this up in the future, it is an internal
> helper function so I'm less worried it than if it were a public function.

Hmm, I see. That would end up calling adjust_git_path() for the current worktree
in that list of worktrees, which wasn’t happening before, that makes sense.
Thanks.
