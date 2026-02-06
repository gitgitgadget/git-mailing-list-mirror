Received: from mail-pf1-f195.google.com (mail-pf1-f195.google.com [209.85.210.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE6C52BD5BF
	for <git@vger.kernel.org>; Fri,  6 Feb 2026 17:08:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1770397682; cv=none; b=OHKV1dSMmD2L/qqjhsVH5KsxhLOcofp4Cx1b4T8GK4//P5wYLWQPHT4ewz2OVGcQ33OKKtJ9L5cIvKWC0PDZV5lCJox755Qdqujo4xP/regvNw5NvbT7bzRDbWWIx19DKX2dDABg9N0L9kD8CsbrFuAfxYYExfMWsc3MUZ8s8vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1770397682; c=relaxed/simple;
	bh=ATyXm6vZQm+aS5z0noihAJpSQjIhJVG8EBNvitnsdUs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cO2lY8thRdka2DoQNn4LT6UlgDIZpD32PJ94nYtooxt7UCCu1CREjFA5TEvgZm2iJfMGsPtdbJUCs1TdlCwS/sTqj8SPY6RChZBsV+APS/NwJ84g4w8nxqwM7+gxjyahNF/e3ZpI+af6mgI99pl9yWVddLK5zkG6SQqP/A/fnaY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FOAzlDTX; arc=none smtp.client-ip=209.85.210.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FOAzlDTX"
Received: by mail-pf1-f195.google.com with SMTP id d2e1a72fcca58-82310b74496so1227164b3a.3
        for <git@vger.kernel.org>; Fri, 06 Feb 2026 09:08:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1770397681; x=1771002481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=koMziJMV3QHiHoc1BjAIvZzJ0AYiPmmGw0oi8rpG0Fs=;
        b=FOAzlDTXqjGBsUMjHGLEsmkUvohOT6gB2t35dD7FJu/5RsVuKdINnFFSk9EKRTs1lZ
         9l/kpXX+G+3luit3XnSvXyR5U/JX0IXa3G7iT0p8yfVxi+yIj5Dzm79XDui778Qgtmsx
         TtVo6UI6AfskeXCYtXQVQnTLmrkAVHg6d7QbeiDtMAG+qJUheaASQ5td6laxUXneyJ3O
         EVTdq/DQHX22s9avhfdKG0hvqmbLneoY4s1z6ILIyAk7Y6AE4QM5RRFz1UYFdJboR4ak
         6mJ7ospatbT65jtFr22/gzSGS19P1tFWpZhySbQWO/JJyir2C5FbXymw24kRdh4Xn1Sa
         VZ3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770397681; x=1771002481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=koMziJMV3QHiHoc1BjAIvZzJ0AYiPmmGw0oi8rpG0Fs=;
        b=JUoJk1UZg31AEXFrAVWHQ6qgpOVVAsskMTmPrbwkITqHjbZRhMSsc3lWL6lVrQqB9Q
         LlEnxmyZinsPJbcxqtn7EoqpBMntwLgwr3YUtoh8DLpswsx1V9StYpzgig67UUaOLBwJ
         GJEmB19dFSixy/+E9sZoXghzVw4477MuY99kC/SMNb5JuLWCEt7JNEL3we0gQv8k9sxJ
         0QXphoFJNkaWrEwvViatdnvP1uGIpMNKEYbjmCkyAhoHZTVwy0n7+OQ2KsIHjv9HaedH
         mm8W/0gL3U5YSnQUOa3AEmIasNI7NYNpPfOnRL24L6mUQno18zk2UIgFWNQPGJ7nPg4q
         p4ZA==
X-Gm-Message-State: AOJu0YzHfZzT0srAEn9J2jKL8y7Xk2XrZHBpHkVdJSZV9tCTjW9MMCfx
	SaiDxqkS6CA3CemJMY+3SWRQNxSsXW2hyL+35YC1onHn+kQR8XMU98SKQsyLA9VC
X-Gm-Gg: AZuq6aJBjnapWKOIfb0P/071/mK5maFE+H+0cWE10Mi5DED1rd95875r9WVHIZ+giox
	1jD2JRqMj06E/WsKMxHQWI5mV3B3AtH1U3WDPfjEDCMqZVa6LOkfVy1M9coCU3/IrRgVS1lIgP2
	7SUBHcUPaAhwZGJw2WViRX2eknLRMF59KRt2NxLw4VOX2O7v9zXSO3aN/ehjp+/WPLtkV1NFydc
	hf3XftcQGQCIHlDxnJh25NxaZo4C/79fstS1DKWb0EoPj6yrRThlYEqKVZH0Dj+8jWumDbjQRn2
	HaDDunwaANWJYuR0BNRBWvV54PRy8l8LWZUkyYhtVaDulJhWJOGi+RRPUJcZaNsPQmvjNjIg5S9
	4JsoweiJVeWYHO/6VGBeIpxRPa3UHiZlbh/nzLv9gPze7qIWk3MP2iHl8Kpc215JVSN+963X9b0
	TvY1pWPyS6/eMqrB9q4QkETOCPs5AWWkoiWTRGeMyDr6QDfxs=
X-Received: by 2002:a05:6a00:349b:b0:81e:b2ba:5b3a with SMTP id d2e1a72fcca58-8244160a918mr3212038b3a.8.1770397680912;
        Fri, 06 Feb 2026 09:08:00 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:312c:74da:52a9:996e:3fee])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82441674f53sm2679371b3a.1.2026.02.06.09.07.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Feb 2026 09:08:00 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	karthik.188@gmail.com,
	phillip.wood123@gmail.com
Subject: Re: [PATCH V2 2/3] wt-status: pass struct repository and wt_status through function parameters
Date: Fri,  6 Feb 2026 22:36:54 +0530
Message-ID: <20260206170747.1231093-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.52.0
In-Reply-To: <997a4a47-2d00-418f-b0a6-3e4dc2f45bbb@gmail.com>
References: <997a4a47-2d00-418f-b0a6-3e4dc2f45bbb@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 06/02/2026 12:57, Shreyansh Paliwal wrote:
> > I tried this out below, and it showed no fails in tests.
> > After this we can just directly replace all the_repository with 'r' or 's->repo'
> > without the hassle of checking the worktree is defined or not.
> 
> As we're trying to remove uses of "the_repository" I think you should 
> use "wt->repo" where we know always "wt != NULL". There are not many 
> callers of these functions so is easy to do necessary analysis (see below).
> 
> > diff --git a/branch.c b/branch.c
> > index 243db7d0fc..0a0097dd85 100644
> > --- a/branch.c
> > +++ b/branch.c
> > @@ -412,7 +412,7 @@ static void prepare_checked_out_branches(void)
> >   			free(old);
> >   		}
> >   
> > -		if (wt_status_check_rebase(wt, &state) &&
> > +		if (wt_status_check_rebase(the_repository, wt, &state) &&
> 
> As I said yesterday we know "wt != NULL" here so it is fine to use 
> "wt->repo" rather than introduce a new use of "the_repository", you just 
> need to explain that in the commit message.
> 
> >   		    (state.rebase_in_progress || state.rebase_interactive_in_progress) &&
> >   		    state.branch) {
> >   			struct strbuf ref = STRBUF_INIT;
> > @@ -425,7 +425,7 @@ static void prepare_checked_out_branches(void)
> >   		}
> >   		wt_status_state_free_buffers(&state);
> >   
> > -		if (wt_status_check_bisect(wt, &state) &&
> > +		if (wt_status_check_bisect(the_repository, wt, &state) &&
> 
> The same is true here.
> 
> >   		    state.bisecting_from) {
> >   			struct strbuf ref = STRBUF_INIT;
> >   			strbuf_addf(&ref, "refs/heads/%s", state.bisecting_from);
> > diff --git a/worktree.c b/worktree.c
> > index 9308389cb6..86eff384ae 100644
> > --- a/worktree.c
> > +++ b/worktree.c
> > @@ -443,7 +443,7 @@ int is_worktree_being_rebased(const struct worktree *wt,
> >   	int found_rebase;
> >   
> >   	memset(&state, 0, sizeof(state));
> > -	found_rebase = wt_status_check_rebase(wt, &state) &&
> > +	found_rebase = wt_status_check_rebase(the_repository, wt, &state) &&
> 
> This function is called from 
> builtin/branch.c:reject_rebase_or_bisect_branch() with "wt != NULL". It 
> is also called from worktree.c:is_shared_symref() which dereferences wt 
> before calling this function so we can assume "wt != NULL" there as 
> well. That means we can use "wt->repo" here.
> 
> >   		       (state.rebase_in_progress ||
> >   			state.rebase_interactive_in_progress) &&
> >   		       state.branch &&
> > @@ -460,7 +460,7 @@ int is_worktree_being_bisected(const struct worktree *wt,
> >   	int found_bisect;
> >   
> >   	memset(&state, 0, sizeof(state));
> > -	found_bisect = wt_status_check_bisect(wt, &state) &&
> > +	found_bisect = wt_status_check_bisect(the_repository, wt, &state) &&
> 
> The same analysis for is_worktree_being_rebased() applies here.
> 
> The changes to get_branch() below look sensible

Thank you for explaining this and for each case.
I have understood where wt->repo can be used safely.
Will make changes and send a v3.
Hopefully that will be good to go :)

Best,
Shreyansh
