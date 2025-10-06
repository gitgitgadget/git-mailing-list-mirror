Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 701708F49
	for <git@vger.kernel.org>; Mon,  6 Oct 2025 21:54:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759787647; cv=none; b=dCkWYaEaRJpWSnv6kJHuyh8E1edtSiRO8RTM4FKkQKjdsbwRaxDiGo+V2E/+JSW8X1HhsUYg/U7yV2I17nQJueX8VsZrSHKwyaV01V9SyX4xtHDPaSah9xqrCt+vwKo1Ne0Wmflb/YDYWXzvz6WLPOsBFP2w8xufvzc29rF8iUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759787647; c=relaxed/simple;
	bh=JKnaPvK2qH26OGco3FsagtGv9Qs9aTUtEVtScuGMom4=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=NLh4aClodsBj6qGYIUIM1cwZQESAHM1k+ZvuylTL8hywMU7QviAET3zRdPAnuH2hTF+zFS9hRLBe0XnwDnpSuctquODTxMx1xUTjENHDiCr37Jk0N8k3ZLF4mHMIefDbuyj0J7pEB+khxAy9U+Lb/7UqRqnEyeRSeTU6UVnTdvs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WznEZJQV; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WznEZJQV"
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-afcb7ae31caso1019577766b.3
        for <git@vger.kernel.org>; Mon, 06 Oct 2025 14:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1759787644; x=1760392444; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jQn3NBCyAGuV0LGI0Q3gxqc6hNcuo29Cxcq7rr1Z6U0=;
        b=WznEZJQVSNQttFtDKrTvUqt8KGu1x4ovsPHB7PRvmpn7Av6wTyW8XLkNbbNzS6GVN+
         WCnD1A5LhwovbvsVOfQYCRBFU+/0BEivQCnVGB9aayf67KKRSZNLbIaqgcgcYNIbjQo6
         cP5B3XRFLZe0NV9ZmMMeWcoxKv7vKubdyJJhxDta+Lq1hl1mNHBGMgSewS+9gk6f20QA
         CZ1TBMhIwIunuGdtDzt2GjMh7dToCv0uvH76vMJjMoNM4nHD8/h31jgywtXGTxsgAMcT
         uOg2sZIhQ5lHFs/uinBWhQKBb0Ori/OG5/6lwgFJQHOUq2sYIg7WloTi1sTZf8QRJ5go
         USGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759787644; x=1760392444;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jQn3NBCyAGuV0LGI0Q3gxqc6hNcuo29Cxcq7rr1Z6U0=;
        b=XKt9qFrI7iH+tMW7GCD6N73078DjszsWMf1jRlnkETkZ/E98GmKJWgSark1IqrDUkX
         FAE4ZDzJ0zE8bVhF1hptQYng32GAcN9PzpEN32Lw6RAlGMcDZpD5KxMGwc7HUM+FlpKx
         0qJKbr8LxIB7LeKn2ZpadREkTYwUqR9c48WNSAm3AyTmlVGLMUHhtz+NTWicytXhUGUt
         KDD9dfEHO7LZmz2HrNoAhrvwJEBtt6Ipb2YSBvQPFWy3v13JG0g879nXYYrMZa28kDHT
         MgijyyDxjJUNgOa2SyEljYpRGH1FZLj0iv6vUmaQzv/4gn5tpGeEYSnr7+3AWF9W59/d
         h6qw==
X-Gm-Message-State: AOJu0Yz9sU4SbGDfEGjjZyA09zjs4G5RxmourhfGDQRaJgkG3yH6J/3k
	zHR/FnZAv/4EJzUp9TRmjzD4bgnGeuxvb/RKMTRDh5b6n8uJ7jt/5/H/PCugerJHoHtxrJo6ALF
	szbP8IZy/HppW3ZKMEfNSJujf1TsrtP4=
X-Gm-Gg: ASbGnct2E5HSYjtJLS4wbj3DCvTtlXwKFkdsW7xegBwrvaYiLt5Bs5iX3sLrIZqSIFR
	7C4YfSEvgdtoxDWrorkGFcRGwPcB3qAP/nXLerDh0PWkbIC6l0wMezIY31B9wR7fEEkUuHaIRAm
	t525FzMCL11wpuHt40ZkZ5cae8iadBIeNPChx6W9pU1mLcbwF+YjIz8axoBj3dD07WcXgq0IQKv
	eKhMQzh7hkKxCjAj0WyPF1ro7T9nQc5L+YWUxhtSAysoNOsXKThRRwa1eIIW3BwXA==
X-Google-Smtp-Source: AGHT+IGoR/Y7isoyD1GRfbwjMMqpRfglZT6x9V+l3HDJdngbaS0/VWG+gnO6XKRN8EWg8B9l2kPxvmEzSZQqM8xoJ1w=
X-Received: by 2002:a17:906:f590:b0:b45:2612:255c with SMTP id
 a640c23a62f3a-b49c2052ccemr1672422266b.28.1759787643480; Mon, 06 Oct 2025
 14:54:03 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1964.v4.git.1759262314.gitgitgadget@gmail.com> <pull.1964.v5.git.1759777131.gitgitgadget@gmail.com>
In-Reply-To: <pull.1964.v5.git.1759777131.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Mon, 6 Oct 2025 17:53:52 -0400
X-Gm-Features: AS18NWDm9W2P2NBO47F9UmcMfJRHYHy-CRIJQ7HLFcbfJLDQAPy4kCsS8NWVTvw
Message-ID: <CALnO6CDqjcN2YarVYj53_AoLhEeXpwJKhGe5Lk77e7my2XR4-w@mail.gmail.com>
Subject: Re: [PATCH v5 0/5] doc: git-push: clarify DESCRIPTION section
To: Julia Evans via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, =?UTF-8?Q?Jean=2DNo=C3=ABl_AVILA?= <jn.avila@free.fr>, 
	Julia Evans <julia@jvns.ca>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Oct 6, 2025 at 2:58=E2=80=AFPM Julia Evans via GitGitGadget
<gitgitgadget@gmail.com> wrote:
> changes in v5:
>
>  * remove a bad example of git branch --track, from Junio's review
>  * fix some formatting issues, from Jean-No=C3=ABl's review
>
> Julia Evans (5):
>   doc: git-push: clarify intro
>   doc: add an UPSTREAM BRANCHES section to pull/push/fetch
>   doc: git-push: clarify "where to push"
>   doc: git-push: clarify "what to push"
>   doc: git-push: Add explanation of `git push origin main`
>
>  Documentation/git-push.adoc     | 46 +++++++++++++++++++--------------
>  Documentation/urls-remotes.adoc | 42 ++++++++++++++++++++++++++++++
>  2 files changed, 68 insertions(+), 20 deletions(-)
>
>
> base-commit: c44beea485f0f2feaf460e2ac87fdd5608d63cf0
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1964%2F=
jvns%2Fclarify-push-v5
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1964/jvns/=
clarify-push-v5
> Pull-Request: https://github.com/gitgitgadget/git/pull/1964
>
> Range-diff vs v4:

No complaints from me, and range-diff looks good.

Thanks again!
