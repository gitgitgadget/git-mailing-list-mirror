Received: from mail-oa1-f46.google.com (mail-oa1-f46.google.com [209.85.160.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 30A39E555
	for <git@vger.kernel.org>; Fri, 16 Jan 2026 07:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1768546873; cv=none; b=RDFr9Ga/PyBozSwc0M01kMiPkGWfrXRaVNKvMLWo/HOgiYl2YM5nT0USvsC/WYgBDupwbDPE2GnXQq/QStmOnoYUev/YQn7YgpPmCZOGUdXhv80IGB9uh7M7X51bhZiFq/tvlCyzz1HUWd+XYybCXsYl3Ht+a3aI358oNyYeODE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1768546873; c=relaxed/simple;
	bh=dOzCF6LabzYfRJvMgNlgL1bChP2XPKmIGng+RKyVNNU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=sBpeKpodZ/KqhA2cOEbtkD++TCBDc9KRLVXZdE+HkJlfzgGoK7JFPRCzWuT/K8R6YyciVbne9elzB4JMHaJ9WeP6pa7iO7Qlz6PkH7XUlTY7VaTXU/M0jOd+J6nu2iz3WMQof5Ptg3bkReFS2xfnhamBPKdAYFRQayEjQ3PEF4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=I9qIbpMX; arc=none smtp.client-ip=209.85.160.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="I9qIbpMX"
Received: by mail-oa1-f46.google.com with SMTP id 586e51a60fabf-40439fb8584so939842fac.0
        for <git@vger.kernel.org>; Thu, 15 Jan 2026 23:01:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1768546871; x=1769151671; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=78x8FxD3eubeW4MSDIZmNh8pMUGpW6rQMnVEYSf3Ry8=;
        b=I9qIbpMXXjd5HFiBMj+NEHxpdF8wQskP+dgjRF1Fe+HwT2uUS8EThf9eFQj49/P6Qy
         NahqIwW0T2JiNnz4+AUDfgnRajvWVfscK3OGrmgaLxFrjG0rIY+r0W18l9va2EaW5Y4Z
         Vy+EJcy4H4xyos01rddP5R6QkEUwTRpAMG602pBuhKKPdAhEvkAOofH4hDLI6DbCtnri
         A+xH4BxEXXgi879VHhQ2BZMaS1yCfP28qGt+vE70BlnLKJxfTTcW9/UV5/bZh4S4xEE4
         80emDKIlg0+Bn1KDr27IrnJrEZXIjm/q8e8CTORBS41Pcy/eXdpkFv6flr4IsjbgG6bg
         E/lA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1768546871; x=1769151671;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=78x8FxD3eubeW4MSDIZmNh8pMUGpW6rQMnVEYSf3Ry8=;
        b=tsGshFuYYiD2EwJr+GvAVpo9aXLQ9iPHNx0BmcQBDSII3H4uXJrbnlVi6ZWwfoIKDQ
         qcsX+RNuweqUj6g0XFPw41DLab6+kX6HF0/cUvj/DLL1RShRpJW8n09UbpYOm6xSGKKo
         j5ajjMZfTJ2ESOJOwzXFf47cCcIz/9m0pGmBgaZSF+NTiv1GVc8SN8b1RKFWH7vtxqGd
         6pmPQokgYu3xCh4mlmMJgH1LDXUxVpHN+liY38EMnq1acEpq7bJ1aHM0xXj17YQEE/50
         XUokAyJu9zpX22sMwbA/969jBYTrPfb2CzyaYU/K2AKKJZHQFGnDcW10nsT9cOGrBRCz
         BuKw==
X-Gm-Message-State: AOJu0Ywpjxc+MpXPTEAQLFns7CCAVyEvVdzC9y0tH6o1YiyW5ulYJ3in
	D9b3Mkag9SilmUeCiHohfGrKIkJuVj1AO3VY5tHDlzcW5cuz8raRpo+wyvODzxAeoVchY6NdPii
	2OAqYr1NFDXNn9alRCcwe4ZC/ok0D1Tmmf7ob
X-Gm-Gg: AY/fxX4ZWHZDDq0Xb7rFfy8b37Z+McF7Acr8KUBVJtV3UrrdLklqgPnHpDkvIsid7eP
	UX+K2b5mYz55Vi1j7aazEKCSm37YT3XNoTJYcKZpoQ9yLZzCihYhe0W+HGra1ZWCHNBnsm9VT3q
	zlSyJKko8TxRPadpnZ+1cujMF9TFfHNBKzt6PdVykSg7hO0PcytxJQMlWfpJwl3F8jbqX5uQwcY
	ix6x6zGR5Bqg/PFH5AbzwmhGKdG7OK3hD8cLAqYCs7P1cnsvDahs7z7sWYQYLOl6Mrc0GPva/wv
	eud76jghQD9GZDVrq3ycEXRGxwsi
X-Received: by 2002:a4a:db4d:0:b0:65d:1636:5439 with SMTP id
 006d021491bc7-6610e6806bbmr2753980eaf.40.1768546870594; Thu, 15 Jan 2026
 23:01:10 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqldhybtqs.fsf@gitster.g>
In-Reply-To: <xmqqldhybtqs.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 15 Jan 2026 23:00:59 -0800
X-Gm-Features: AZwV_QjCyU2whmaDhfmXucl4YYRjLr88f_P2jUry1eb9uAjKDILkXjmQ9lLunjQ
Message-ID: <CABPp-BFGPs1ziDFZhbrk25fj5froGPCi92yxGOr9dpgMujKU1Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Jan 2026, #05)
To: Junio C Hamano <gitster@pobox.com>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Jan 15, 2026 at 10:59=E2=80=AFAM Junio C Hamano <gitster@pobox.com>=
 wrote:

> * ac/sparse-checkout-string-list-cleanup (2026-01-15) 1 commit
>  - sparse-checkout: optimize string_list construction
>
>  Code clean-up.
>
>  Will merge to 'next'.
>  source: <20260115130935.93526-1-amishhhaaaa@gmail.com>

Shouldn't it restore the string_list_remove_duplicates() calls first?
(See 20260115200903.GB1053259@coredump.intra.peff.net and
fc14e0e5-93bc-4805-a20d-d2aa4eb87ddb@web.de )

> * pw/replay-drop-empty (2025-12-18) 2 commits
>  - replay: drop commits that become empty
>  - Merge branch 'ps/history' into pw/replay-drop-empty
>  (this branch uses ps/history.)
>
>  "git replay" is taught to drop commits that become empty (not the
>  ones that are empty in the original).
>
>  On hold, until the base topic gains consensus and stabilizes.
>  source: <375adc4e941f3bb22a2b12ee26a083951ed724dd.1766076625.git.phillip=
.wood@dunelm.org.uk>

I think the base topic has done so now (as I'll note below), so this
should be ready to advance.

> * ps/history (2026-01-13) 9 commits
>  - builtin/history: implement "reword" subcommand
>  - builtin: add new "history" command
>  - wt-status: provide function to expose status for trees
>  - replay: support updating detached HEAD
>  - replay: support empty commit ranges
>  - replay: small set of cleanups
>  - builtin/replay: move core logic into "libgit.a"
>  - builtin/replay: extract core logic to replay revisions
>  - Merge branch 'kh/replay-invalid-onto-advance' into ps/history
>  (this branch is used by pw/replay-drop-empty.)
>
>  "git history" history rewriting UI.
>
>  Will merge to 'next'?
>  source: <20260113-b4-pks-history-builtin-v11-0-e74ebfa2652d@pks.im>

Yes, I think it's ready.
