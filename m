Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB2203FEF
	for <git@vger.kernel.org>; Mon,  2 Feb 2026 19:02:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770058933; cv=none; b=VNSvYucnu5WKOrmrfhUN3gdTBQR9ixPfu0cqpB5CQWfJb83zoziOK8euZVqIAOO2aqA4uSPoNc4t5PxR7xo8U9qR5rzXxeLmZBvP0RlwxhnxAOrrsn+DmlP3Lfq1TcWUrX2muBAv4XhHH3xqb1PAsGDJ+emu5ocg/I/AIouZaNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770058933; c=relaxed/simple;
	bh=ko93TfYSFl4+AIW5a7NV3Umqf4n0uHklXY4wwP7l5e0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hLJyLTzH9QHS9Ra5WJYLh0ewWLJnLPyUL6Q4ogQCjqTkyZ308NYzZxguJS2J+L3EDYPj4bnR7rMPcK4X/b3PKMwugbbOOVQQlKe4JbLfcztLtoCZVimK+vfvfv0IXVQaUH8fTQ6BRNL1RQoRmRLkpjYfSGwPgnpaTea+JsWLyHA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OC2fo7GB; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OC2fo7GB"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-81f5381d168so4861284b3a.2
        for <git@vger.kernel.org>; Mon, 02 Feb 2026 11:02:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770058931; x=1770663731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6mGODtFCSiyNAFEPo67Sc40ielzPWaSHwsh6Qfep+KQ=;
        b=OC2fo7GB25smtQGsRcsLZTGXuKF/uRUsC+XjUCSI2YPWXJ+0kluiWvrs/igvfpa77+
         IYJV3rj70W21dySJDvbrbs4nq7cUdnc5q83xU9Cv7U54gc874BfK0RwdAR5E53Ag3H0p
         lhmEs/vCohsc1OlEJ+bFzgwqVtTTKDaArhq/rIMkiBYPNkUaOXJVjsDzLjYuzHZ4CiBL
         PAjTwTKzAk1utArtqf2/pN5AnwqjCaBb06TCmKbRUvDT0ycZliC015BwAfzoyC/w0QEO
         HhqRIhEX+qbSyo7aL2fEoCnVUCNNVbZoK5k5qWcsjnVdSCegMbOtL7xpbX7zIIQXH0em
         panA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770058931; x=1770663731;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=6mGODtFCSiyNAFEPo67Sc40ielzPWaSHwsh6Qfep+KQ=;
        b=wbzurkukwb8yA6fvAii3t+CNx1aQRu+Edm3HZhjsdWmiMV32ykBKcqcZHt5Esi3niC
         4LTYwhSP346OqrOl5VV39dt/pGHbVX4h40lvdMART+lBOk6Ky7+V0UCYUIlJmVv9mGKt
         E8/YWssfF6adIUQ5eTl0tPu6wps7mv9bQDgt92pFh++E9t2Qo2HtQPsKP8QnlqaEG6HA
         I+QoLiIVjleZIjo4f3uyZNoeUjyWhSER35bSm7jgzIa7CzdHbODPv9l0tvhctYOrDYYV
         nUednFuWstwV3hW8YvOiuI/ZYvwP6JMWp6Byg9Fh02qH6UTUGQcXGdz0TGEV8RwZLZ4s
         PBBA==
X-Gm-Message-State: AOJu0YxQuqrVC7+8DZQEIj0bcbtnPkBZyeopFAIllP9+JPTI2uNmnPho
	7u9xEfWT3TVvwomdXRp9c5J64u9RoCTjV6oTXIOO7797YIrXklouQ6yDULxz8A==
X-Gm-Gg: AZuq6aI0uPm4fM3HlBCu8VHYcWHhgudlPwJClEP17iNWDTQsurWcG3PfJ/INb5F8OEr
	oX8gZx+frp4SmykchZJL4Cqq9gDMvQ5982T2eptxkhS3l8zc1xXuUoPS1ZCCLuuL5gk1BJVP2U6
	CXoyAp5dLn6S4ceWC5uZZ1oohzg5ZwwXqVnNBdExihdFa49DkgBlGTSLsx0zmNc5WELcS9e/juG
	r8H5zY7k9bIKfdlGMpqZvwWkqTBCtu1oQ6VKXrsGZBVNxIRcsRgzQDUVvsmPd4VzXk//tODoqVn
	5M0tuRHSR6qIZLVPIxTup7kk4E3ZckQqUkE82Gu0oNhtO/gxxTH5dCQ5/WSvSBIsjkEUfF6zj9b
	Bb+sgVTkZjuYT4g8V4K/kcLaoZ4qlHjzBV7prNZxFT0zHZ2nGyYnmZkBvJAOaxqQTAEPlIYdky3
	Eokr1QCWx6mFfQ4O9DRF1Cj/H1A+47gamWaCoLjp6ZCiLE8w==
X-Received: by 2002:a05:6a00:22c7:b0:81f:ac80:499a with SMTP id d2e1a72fcca58-823ab67903amr11685343b3a.20.1770058930931;
        Mon, 02 Feb 2026 11:02:10 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:da6f:d14f:dda8:8d6c])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82379c22466sm16794301b3a.50.2026.02.02.11.02.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Feb 2026 11:02:10 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com
Subject: Re: [PATCH 1/3] wt-status: replace uses of the_repository with local repository instances
Date: Tue,  3 Feb 2026 00:27:14 +0530
Message-ID: <20260202190155.79896-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <CAOLa=ZRv4xsy0adY_BcXQkypsgYkLNM6x5LhJGX+B+=aKCwmgg@mail.gmail.com>
References: <CAOLa=ZRv4xsy0adY_BcXQkypsgYkLNM6x5LhJGX+B+=aKCwmgg@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> > Many instances of the_repository are used in wt-status.c even when a
> > local repository is already available via struct wt_status or struct
> > worktree.
> >
> 
> One missing information is why is it safe to make this change? If is a
> repository field, is it holding the same information, is it always
> defined?

Yes I should have included explanation as well.
I have explained below, let me know if this thought process
is valid or not.

The replacement of all the_repository with s->repo in this patch are mostly
to cases where a repository instance is already available via struct wt_status.

In the current flow, all functions operating on struct wt_status *s
are called via commit.c. There, status_init_config() calls
wt_status_prepare(), which initializes the struct wt_status and
assigns s->repo from the repository instance passed in by the caller.
As a result, s->repo is guaranteed to be initialized whenever these
functions are invoked.

And commit.c itself still relies on the_repository, within wt-status.c,
the local repository pointer refers to the same underlying
repository object that the_repository would have pointed to, indirectly
until we make commit.c also free of the_repository.

> > diff --git a/wt-status.c b/wt-status.c
> > index e12adb26b9..9f4d8fda7f 100644
> > --- a/wt-status.c
> > +++ b/wt-status.c
> > @@ -150,11 +150,11 @@ void wt_status_prepare(struct repository *r, struct wt_status *s)
> >	s->show_untracked_files = SHOW_NORMAL_UNTRACKED_FILES;
> >	s->use_color = GIT_COLOR_UNKNOWN;
> >	s->relative_paths = 1;
> > -	s->branch = refs_resolve_refdup(get_main_ref_store(the_repository),
> > +	s->branch = refs_resolve_refdup(get_main_ref_store(s->repo),
> >					"HEAD", 0, NULL, NULL);
> 
> Wouldn't it make more sense to use the function argument 'r' here?

In wt_status_prepare(), s->repo is initialized to r at the top of
the function, so both refer to the same repository instance. However,
using r directly is more explicit and avoids indirect use.
will change this in V2.

> > @@ -1723,18 +1723,18 @@ int wt_status_check_rebase(const struct worktree *wt,
> >  {
> >	struct stat st;
> >
> > -	if (!stat(worktree_git_path(the_repository, wt, "rebase-apply"), &st)) {
> > -		if (!stat(worktree_git_path(the_repository, wt, "rebase-apply/applying"), &st)) {
> > +	if (!stat(worktree_git_path(wt->repo, wt, "rebase-apply"), &st)) {
> > +		if (!stat(worktree_git_path(wt->repo, wt, "rebase-apply/applying"), &st)) {
> 
> In the same file we make a call 'wt_status_check_rebase(NULL, state)',
> so wouldn't this break?

Yes my bad, it would throw a segfault error.
I think the best way to handle this is to explicitly check for the
wt to be valid like this,

    if (wt==NULL)
        return 0;

Falling back to the_repository in this case, would probably
defeat the purpose.
