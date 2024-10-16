Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com [209.85.219.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B45CA18CBF2
	for <git@vger.kernel.org>; Wed, 16 Oct 2024 20:36:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729110997; cv=none; b=nYVZkwW5k3e42I0c4m/A2JmSeuBaxaFa7C63wcI6YtEZH3c6Tjy7RYC//jYOmXQM8RwqIW4EKR7z94FslfbDUl/X/S9kJkuj3kmgAQ5kFc/PoTtqjxIxYHP57pim5Glf5PnMbIGwZDHi+kIWceHV00M2epcM4U5r9U/gniAnNXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729110997; c=relaxed/simple;
	bh=rijqGDEZJ5Ksx1zOgle1SaD+4w5iGta2eiVE8IrEBJU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=kkJuXPO6DwMCLnIAU90kPenTVyMnAGiNsd81AdJdv2vreNQ0P1HRtVmcrjt9j6VH/FPnvgJBrB2O3uJ7BvtUaooUlKG9Pw4zGT/eB4Dmz/TVGQgqgxeQtxoY0Y4fbykhuCDLetgjsdzcMMEO8luFhdDUG8a27iOn9KhPc1TvEMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com; spf=pass smtp.mailfrom=ttaylorr.com; dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b=wAXQ64DM; arc=none smtp.client-ip=209.85.219.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ttaylorr.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ttaylorr-com.20230601.gappssmtp.com header.i=@ttaylorr-com.20230601.gappssmtp.com header.b="wAXQ64DM"
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-e29756dc019so210250276.3
        for <git@vger.kernel.org>; Wed, 16 Oct 2024 13:36:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20230601.gappssmtp.com; s=20230601; t=1729110994; x=1729715794; darn=vger.kernel.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EHiZ+D5gMvmLoq4xmme7DBnJRRCsEpHCfusm6W85DX4=;
        b=wAXQ64DMUF0nc/EGT3kdJYTzHYGl4jXIkgaG+vgbofGKVoz10J+hDSN9VGLP7tmIpy
         DvzgG9vDZb7fTCn8NKtTdEU5gky5yzr9WdqU40OWcNnL32EBOJXeKHHuKVZLsMbKIRQi
         32GKpIRIyO8Qeof3v5jeuQ7ZQMLGfFZui6hgSLq0yUU0QUUg6LpJO8lc8RWbwAo+Rvvx
         zWnOoMw2EgTyWruRDAlAidITGNpwqgK059tbDTNgui6htB/Mlgzow9IBMOsV0iOgbZSf
         AoAP9NOUfk0NhlG3sDcg+cNHIv6mvKZ1kasSEn9VBMuXkYX0vZ1TiXrfuj2PqIN6a1N9
         bzXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1729110994; x=1729715794;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EHiZ+D5gMvmLoq4xmme7DBnJRRCsEpHCfusm6W85DX4=;
        b=oZ8r7ptAr1EKlitXhRGocpy7EYRhUFgaRvhkkyX1z0YM3SJyjhhqHAxQf7lfTgQlja
         NZL5ACg5LAGn/7jOsomKO2lF5jbkcEth9zZnMm1/yYZOijMCvZdX6e+zF7CzsgP5cDch
         EuSWunMsv8rgl1EshKWQ6Z/x+kXncZqbPN7095819cJvDWoqc5XXSgqrY7z31mQj8ovK
         NDycRHVC/BwF7ZF2cAdrU34U8IIlnfhS6ftO6mJIqfxJVF3Y4WicwvZcYTNtLK8TzfcY
         qhb5mtSkkt2V1fcBnrgvL5/DRu+VQAolKdZuVzpoq+u+88grX262TG//ZVRmZwj913eA
         3bEA==
X-Forwarded-Encrypted: i=1; AJvYcCX7nyIDKRMv6tZ3Ta0oX6L3gmJZbKrfsq3BmUjHey4zRT2t8KrlXNebsIcPSPszL/CbERA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxh+vzr0QEMG3nIKU2azR5rzoaaEz4LcoHBAaBsyoyz6MkmKhoc
	Um8XNdquc6yOw9Y25wylz7BAf8TrkxUszRc2nuWbzaUrCO3ED7WEIx4BkcGJGh0=
X-Google-Smtp-Source: AGHT+IE7q28cKe3NS3dSJ10vxoJZydTtC5AKYAo21irgCy2siHN1PPL4T7fN1dThwSLkzga3doOCYA==
X-Received: by 2002:a05:690c:6c82:b0:6dd:d06a:b840 with SMTP id 00721157ae682-6e3d41e504cmr62230747b3.39.1729110994570;
        Wed, 16 Oct 2024 13:36:34 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-6e3c5cbdde0sm8472907b3.97.2024.10.16.13.36.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Oct 2024 13:36:33 -0700 (PDT)
Date: Wed, 16 Oct 2024 16:36:31 -0400
From: Taylor Blau <me@ttaylorr.com>
To: phillip.wood@dunelm.org.uk
Cc: Eric Sunshine <sunshine@sunshineco.com>,
	David Moberg <kaddkaka@gmail.com>, Elijah Newren <newren@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
Subject: Re: git rebase exec make -C in worktree confuses repo root dir
Message-ID: <ZxAjz28QLwWlDVg1@nand.local>
References: <CAL2+Miudq0UXAb=R24v+ftZVkHy2We1CFsFAt__tCYMWtCfOow@mail.gmail.com>
 <Zw2K5xJAOGWitfXr@nand.local>
 <CAPig+cQZoO8tMZ1Gip-at8-9n_tk4axctkX=WbaO1==JRru39A@mail.gmail.com>
 <CAL2+MivOu=_HYg+2KoMKMUtz+=q2jv-K9u9Zxrhe3OuHLCmwFA@mail.gmail.com>
 <CAPig+cQ6=HDD447xTHQ84hmsF3SMbC5nH_PXf3rZWvTWmp18ug@mail.gmail.com>
 <1dc91aa7-04da-4023-bbd5-5b12539477ba@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1dc91aa7-04da-4023-bbd5-5b12539477ba@gmail.com>

On Wed, Oct 16, 2024 at 10:15:49AM +0100, Phillip Wood wrote:
> On 15/10/2024 21:01, Eric Sunshine wrote:
> > On Tue, Oct 15, 2024 at 2:55 PM David Moberg <kaddkaka@gmail.com> wrote:
> > > Den tis 15 okt. 2024 kl 09:11 skrev Eric Sunshine <sunshine@sunshineco.com>:
> > > > This looks like unintentional behavior; probably a bug. It seems to be
> > > > triggered by `git rebase -i` setting GIT_DIR. Here's an even simpler
> > > > reproduction recipe:
> > > >
> > > >      % git init foo
> > > >      % cd foo
> > > >      % mkdir dir
> > > >      % echo foo >dir/file
> > > >      % git add dir/file
> > > >      % git commit -m foo
> > > >      % git worktree add ../bar
> > > >      % cd ../bar
> > > >      % git -C dir rev-parse --show-toplevel
> > > >      /.../bar
> > > >      % GIT_DIR=../../foo/.git/worktrees/bar \
> > > >          git -C dir rev-parse --show-toplevel
> > > >      /.../bar/dir
> > > >
> > > > The `git rev-parse --show-toplevel` invocation with GIT_DIR set is
> > > > incorrectly returning `/.../bar/dir` rather than `/.../bar`.
> > >
> > > Thanks, that is indeed a much smaller example and it seems to exhibit
> > > the same issue. Can we figure out how to fix it?
> >
> > Someone is going to have to dig into the code, but my Git time is very
> > limited right now, so perhaps someone else can do the digging.
>
> I'm about to go off the list until the 29th so I wont be working on it soon
> either but I think the problem is that git sets $GIT_DIR when it is run from
> a linked worktree. I've reproduced the commit message from ff5b7913f0a
> (sequencer, stash: fix running from worktree subdir, 2022-01-26) below which
> I think explains the problem we're seeing here. Unfortunately the approach
> of setting $GIT_WORK_TREE used in that commit won't work for exec commands
> as they may be run in a different worktree. Naively I feel that if
> setup_git_directory() has found ".git" then any git subprocesses run in the
> worktree should also be able to find ".git" and so it should not be setting
> $GIT_DIR but there maybe there is some subtlety I'm missing

Let's see if that commit's author Elijah (CC'd) has any other thoughts.

Thanks,
Taylor
