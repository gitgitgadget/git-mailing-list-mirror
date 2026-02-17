Received: from mail-pj1-f67.google.com (mail-pj1-f67.google.com [209.85.216.67])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72A07281532
	for <git@vger.kernel.org>; Tue, 17 Feb 2026 10:20:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.67
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1771323601; cv=none; b=h/yAhlJpKh6DaUptC3pcCD2xXQqvRsAmjxl3RfOGCQYOa7xaL/4IkSs28CDPNZin7iN1qt08E871ynqUTvfnpWrE137AmEiIQEUv3WJew6MkeDygdBLcCEkA771+FxKldFbHfXnc7j9kSwejx3pIOz2phKaVAly2Sho8bP7euxA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1771323601; c=relaxed/simple;
	bh=S/M87E94hR+2j8o0YlXhrc9JiEwU4xxXXyp0Knp1HTk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=C1mWKqrLrAmrAhwqaTgLsnnJFDZ8sjxVepf8syiX7yXyterrHaPb+bBfWkm0yLevLAT91KvcXZy1qHTuaG9wfXFrFJFj2NPyxawWib/srmldayhoUWKmdkPgNTPZhwdOrunSojsCgWocxBEYsGoYpjs8QpPtuewumpIose3EhcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=C+DNu2Tb; arc=none smtp.client-ip=209.85.216.67
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C+DNu2Tb"
Received: by mail-pj1-f67.google.com with SMTP id 98e67ed59e1d1-35305538592so2878228a91.0
        for <git@vger.kernel.org>; Tue, 17 Feb 2026 02:20:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1771323599; x=1771928399; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YtC2S5ddCuijpdDWHhzx6KkEdfenaYaJRL8xgSWuUaM=;
        b=C+DNu2TbsEDG9U+KLTEKz2s1M4321B8DLrq/gwi336Icr7qSQk8NPDjWjsbLrQ1l6A
         WumvlyoL8DMzANxhbOAbuLLAer5+mJx2dGcnfSeBDLs5o945oX5v6wrl68oqwSkNsKcm
         LgYDtDj7pzP+xGOGWymvgGfQeQsgFVRMoR8xTZ1f4AoBYgcvEY0BhQQ/QFpugvNQ4Aaw
         Sky1CPIkaApAqqEkszMl8GMMus2w83aRou5boouFS5MhxZBKZF/Y9xwCl9pLLbexzI0u
         dtEPYdnbVd2c9DDUNYFeGrE0RBqXD4yggoWXSWhBil+eVZ8SUblcE6WqHJMNf6q+EfwU
         8GVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1771323599; x=1771928399;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=YtC2S5ddCuijpdDWHhzx6KkEdfenaYaJRL8xgSWuUaM=;
        b=BdJTzOpDuAe/uaj8LMwEe8S2MVPF8Pn/bAmfETNuZTIiBBGD2UP+/fZa/cfy1ddOrK
         2Yrx+VjesP4SXsOsmFuiXxgPUGXXJzt60sEZReZyUfIqbS7djPPLpGGjOqtuVZZhl/zX
         v3E4OxqLCx8nPueyDCcdVCZ26/p2LZvB9U0SZOzlJiOYZk3pFR3fxdyH2ULNkj4iBmi9
         ZVkyaeWdyAMtSDbmEVECTAbkJZ4pkJBNhlERhJp6A9Ccf3WnMUXChQyDNOD7jyoPEbfH
         nOPxKctIAwEQcZVPyAx2A9tsLVneJHauv6O7jI5TbdeCTO4fCW+mhoJ2Gd2QJAOOPWZL
         bTKQ==
X-Gm-Message-State: AOJu0YxrduodNPvkdWwYIpVmT5eh1NVX3WHfUopUg1rjC7F6uF2jxNAl
	FnOQZVj87moAIAEjKzW8NE2kwtxbV+n/WSEJtpnZxdlTj4t/r0JMiEgCckJFWyBrFRPswA==
X-Gm-Gg: AZuq6aJrlBc0pQeLQdEJT+NZTJCj8juVMi3Utg7hMK0YPD2AwKBR8PYgvatbMitDkWl
	hFJLDKjkELpXmjZoqoieSKyxEwr0J0JMWbjQ9rqrlq6WdtK0RjAGVIynyLNo53NaoUCyVS7+bJP
	YAj0vkVCgzXp+88ERZqrzuVw3UD05SgFknG1QwBJJ1DQ0PEH1FZ1tb17AvRT045lYZhGTJJLnDi
	I6Z/4sY4N5MqONK11yE233TNS9e31SoGwDfHsfWAOz2ylcqX5wjOyncgLR9PgZoqU2HueGjnRkN
	arfRhQdacw8Zx3Y6NCek3BbNZtVZzpn/0lcnP7eGh0B5eVSXHhpOetIucz8w9U0WaUlYgB+OjZr
	YpHQu9jaXijXLE6MJprPKkU/M61SglL15zGxdVNOyopTfIszeS8/EiOvLTGBkDE5mgSfDQrLe7E
	3pDG9Ez6rhxlYSJneGitzm5Yih7OKmqBT1yWpDUIjPonQavNXDtm1JyFeDSBg=
X-Received: by 2002:a17:90b:2250:b0:352:ccae:fe65 with SMTP id 98e67ed59e1d1-35844819dd5mr9928040a91.4.1771323599453;
        Tue, 17 Feb 2026 02:19:59 -0800 (PST)
Received: from Shreyansh-PC.domain.name ([2401:4900:1cd6:375b:8c2a:3e1b:2a7b:dd15])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3567e7d95d8sm20595571a91.2.2026.02.17.02.19.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 17 Feb 2026 02:19:59 -0800 (PST)
From: Shreyansh Paliwal <shreyanshpaliwalcmsmn@gmail.com>
To: git@vger.kernel.org
Cc: phillip.wood123@gmail.com,
	gitster@pobox.com,
	karthik.188@gmail.com
Subject: Re: [PATCH 1/2] wt-status: avoid passing NULL worktree
Date: Tue, 17 Feb 2026 15:48:38 +0530
Message-ID: <20260217101950.15731-1-shreyanshpaliwalcmsmn@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <89c78ce2-1783-416d-9ae5-ef51f6bde58d@gmail.com>
References: <89c78ce2-1783-416d-9ae5-ef51f6bde58d@gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

> On 16/02/2026 16:18, Phillip Wood wrote:
> >
> > +struct worktree *get_worktree_from_repository(struct repository *repo)
> > +{
> > +	struct worktree *wt = xcalloc(1, sizeof(*wt));
> > +	char *gitdir = absolute_pathdup(repo->gitdir);
> > +	char *commondir = absolute_pathdup(repo->commondir);
> > +
> > +	wt->repo = repo;
> > +	if (repo->worktree)
> > +		wt->path = absolute_pathdup(repo->worktree);
> > +	wt->is_bare = !!repo->worktree;
> > +	if (fspathcmp(gitdir, commondir))
> > +		wt->id = xstrdup(find_last_dir_sep(commondir) + 1);
>
> Oops s/commondir/gitdir/ - I'll wait to see if there are any other
> comments before re-rolling (perhaps with a test that runs git status on
> a rebase in a linked worktree)
>
> Thanks
>
> Phillip

I wanted to just check for my understanding: the NULL usage of worktree in
get_worktree_git_dir() caller, repo_git_pathv() callers and inside function
add_reflogs_to_pending() is intentionally left unchanged for now,
and is meant for a follow-up once this gets gets finalized.
or it is out of scope wrt this cleanup?

Best,
Shreyansh
