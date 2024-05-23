Received: from mail-oo1-f45.google.com (mail-oo1-f45.google.com [209.85.161.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51DA1852
	for <git@vger.kernel.org>; Thu, 23 May 2024 17:31:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716485478; cv=none; b=Ec9Z9fdAkvVYxbroYXAuaWpr6IHrwt6VhrE8JH2jZ3AxqYPW1ZxfFev7VZCnpbkRrtXSLvDPu0dnQdj9/Y4oDJzOglVO9nNRoVwATQwrqHjcnrY411K4V29VYMW2j72AgcCnM7ITtSFoMZxjHuwhh5sPY0VRkAMtQEe98C5+aNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716485478; c=relaxed/simple;
	bh=zOTMidMK5yHHBAPjt8wSLKwiY+8g/zKwtmMFwPox530=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=q665xSCabGkK1WTSzxKeSLXYcL2jeoI8u77M1v2Ti/uUlE6PxXu0CF37pXfIhStxpetEQoiAeeSjkiEZ1j4CpzAtVuaV/dcqmBIlAdy8R5PNZxTKwQTSJ3cbJDM+QmLIlC26q1YYDkc4be7q3J82CzW25ZfH9xisKrVPUYl4668=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.161.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-oo1-f45.google.com with SMTP id 006d021491bc7-5b277993a48so4528107eaf.1
        for <git@vger.kernel.org>; Thu, 23 May 2024 10:31:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1716485475; x=1717090275;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8seNHPgkLWaPYfsTOO8Z9w5U1owGrxNcjjE28uHwG8M=;
        b=DS+qyLU4+kBeZ8DgK7KeDCQBntJWg9l2+RlV+65qspGt5BD9N7QOny5pX2Icn1xUJx
         viGVwEEp/lZmD5trJyb205pANoH3nE+af5vcogMN7TBrbN6N1O36cDRcJWYZ8juzuOAg
         Qs+Pj+suIRoaXJvzY8VLg7BEw2K7+unOWdHlthS52sYSddemQDMu4LIAart6udm/0GKJ
         vZc6+boz2krOoOk63zJdiz6lOQzFwSRW4NnKQFKFmpUzZkgc+W9EJwXhNB718OHiDY4k
         cYFCHq4/wH3SnAd778/6fLY4aJtRhCUsuYW3wWeke2lHhB6F+q3Xgb2LJiAZ7TJ7R7ML
         C1dQ==
X-Gm-Message-State: AOJu0YzW27N7yg0sfkWnHdH9XJgq/i/HPjx3txfpbJqgpBoelTRAZOkz
	3xOenKCYuOegOFlHe8bYRS3zNU6mnyAWNfTlj3C5Wwiq8iPjrMEQc6pBFyGyeSVtSXuG/eNMWDP
	nf5ycMTui2synoJba9MUT37nmWdY=
X-Google-Smtp-Source: AGHT+IFJA4oo5s3/2q8lekaeMg1Do0U2+96k5JMDHpTwF/wYg7oBRX122ZNqn6yp/rAFKx7QssGBabGbSUBMHNlRkpo=
X-Received: by 2002:a05:6359:5f88:b0:186:7b6:f0e7 with SMTP id
 e5c5f4694b2df-197e565fb9emr13072555d.26.1716485474791; Thu, 23 May 2024
 10:31:14 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <cover.1716451672.git.ps@pks.im> <4e0edda6d3ef48509206d849ceb1f347e51251d9.1716451672.git.ps@pks.im>
In-Reply-To: <4e0edda6d3ef48509206d849ceb1f347e51251d9.1716451672.git.ps@pks.im>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Thu, 23 May 2024 13:31:03 -0400
Message-ID: <CAPig+cSM2mcEByQ=kJz2nFRR6OoatoNnii7Wy3wAiGBHO0LWrg@mail.gmail.com>
Subject: Re: [PATCH 8/9] refs: implement logic to migrate between ref storage formats
To: Patrick Steinhardt <ps@pks.im>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, May 23, 2024 at 4:26=E2=80=AFAM Patrick Steinhardt <ps@pks.im> wrot=
e:
> With the introduction of the new "reftable" backend, users may want to
> migrate repositories between the backends without having to recreate the
> whole repository. Add the logic to do so.
>
> The implementation is generic and works with arbitrary ref storage
> formats because we only use.

ECANNOTPARSE: This sentence seems to be broken grammatically.

> It does have a few limitations though:
>
>   - We do not migrate repositories with worktrees, because worktrees
>     have separate ref storages. It makes the overall affair more complex
>     if we have to migrate multiple storages at once.
>
>   - We do not migrate reflogs, because we have no interfaces to write
>     many reflog entries.
>
>   - We do not lock the repository for concurrent access, and thus
>     concurrent writes may make use end up with weird in-between states.
>     There is no way to fully lock the "files" backend for writes due to
>     its format, and thus we punt on this topic altogether and defer to
>     the user to avoid those from happening.
>
> In other words, this version is a minimum viable product for migrating a
> repository's ref storage format. It works alright for bare repos, which
> typically have neither worktrees nor reflogs.

Worktrees hanging off a bare repository is an explicitly supported
use-case, and there are people who use and promote such an
organization, so I'm not sure if "typically" is accurate these days.
Anyhow, just a minor observation, probably not worth rewording, and
certainly not worth a reroll.

> But it will not work for
> many other repositories without some preparations. These limitations are
> not set into stone though, and ideally we will eventually address them
> over time.
>
> The logic is not yet used by anything, and thus there are no tests for
> it. Those will be added in the next commit.
>
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
