Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DA9C6FD0
	for <git@vger.kernel.org>; Sun,  3 Mar 2024 07:23:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709450598; cv=none; b=GCN+4+L+Xt32/TekIPk/lFz8w4snDRkxP7RbzZk3TuUDePeNipK0CQSL4aQVcnR/yqygxcDGUm5k3DHo/9mKX825uSrM9ECzJlWxW/OTC3/1uzFz2dBj9QzzOdpco57nzu2Idj6ZtN1qyUs12k90gQsKkLn8H0IUw0l7WB16orU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709450598; c=relaxed/simple;
	bh=gT6+rInX+7iQBJLA62hZkB8y0Zzfeh+cN8nXTlXn9pA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=N7/axVzpagXLc6iwpEb5igqwYR9P4npgi3XgWys9K8cArFozvJma8WfCGMoAW5qCe7A3lGEFysWHdvs+KxwH7ofuqmuhudIeuClEhsg6HYzORLn44ghiuHPgclo2ZAV/+ozcUTwgl8SlqxyiSBlESPJoxL2bxdQS67OHTO6UYbg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=SuNN6Azz; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SuNN6Azz"
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-a2f22bfb4e6so581286366b.0
        for <git@vger.kernel.org>; Sat, 02 Mar 2024 23:23:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709450595; x=1710055395; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=AiwhJC+cqUs1v5n9n5yRPkHyUxcYybTvnUKjSW0qxW0=;
        b=SuNN6Azz3+hW4dwrAqoEgHMujT6xh+CNe5QjkqEeGEs/j5h+PZW8XdeNVY9F63BYts
         U3Kww26iMrIX+gFVJTiusLBGaPAo0F8bXUcm36G+Pt+YOLn0PTavfo20go8sy/AXScxp
         ghtHI+7Ne1i1pNpjzeNJGQdQCmluucTZr1Y8CV/1CawLAuFgs3yWwrYQSMbDHS9EuR7e
         FvKAdf2P+7VpIsyG1Dwn9JLkgy/oADyOjoPcyAIH5iX5wvgX4DQXl82VAY6RcTAtsegU
         teRMhxNjTqem74erAZfwo5q8CqLrDljXrs/t+xaEpoimipOdhOA3RaAP/MA4SD3AoNa8
         XzDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709450595; x=1710055395;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AiwhJC+cqUs1v5n9n5yRPkHyUxcYybTvnUKjSW0qxW0=;
        b=KZhqrIAnWXHfLYrzoUNhIumkw5WWl7zcckiiwcVbfj7/llZ6VhFexiVZ6mGN2rcnI7
         Kunx3YJ0sK8C+NlxPYeyO8GGTPSDT+2EDFOzFzCgaDH5V+LTsIA6tS5kiZhg6uDUEYyj
         W3W+fv+rG2947g2KFj/R2ExUInjpTfZhsTJ0hhdfmEQqarz/w5wwQLcFqGPz54zsIG8Y
         apPAijV9v4K7uugxh8mUpqza39R0deIGZr4Tq1q0vJe8rmF2Eqk4MxcjW+T/MxzKzLHG
         cV1CJOd3bsuh1X6+LcKFiKv1lYe3qef+IFva/NeHElDtcaj2gxbECPf3M3YBOw4Ly470
         i9Ow==
X-Forwarded-Encrypted: i=1; AJvYcCUvAS2s8NvVxxnetZd4DQUBk1N2rgDGqIL15SWbTczl6BtcIgMf2Ioa1qwdAEejp+TMLr9B5KXY1Bob3miLa1JVOfUy
X-Gm-Message-State: AOJu0YwlvrA7vStMf1ISnU0otKLoP0NNTGieHSDZFR5MPqJoM+WCqAyw
	w84HsO/jtYilvZR3eE4yT+AO80bsiIy1KiWi7jVreQXrfRcGmXEgUgh3zWZMXVjgnp+RwedhPsL
	EEGpezM5MGWDzMyaDcesptA72CbM=
X-Google-Smtp-Source: AGHT+IEiL8FTQVHVP/PGYHcgRcRXlPVwOern4sAxnHIr4QyZbKRJktRUtNiEr3ffJDCJqEo7Y9RAv18TSc2/bqirl7g=
X-Received: by 2002:a17:906:27ce:b0:a3f:daf8:bd3b with SMTP id
 k14-20020a17090627ce00b00a3fdaf8bd3bmr3866020ejc.8.1709450595426; Sat, 02 Mar
 2024 23:23:15 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <a7be415d-5005-4fa7-9b2e-1974b7439a81@schinagl.nl>
 <20240302095751.123138-1-karthik.188@gmail.com> <xmqqedcszhty.fsf@gitster.g>
 <CAOLa=ZR6tN8eQhByaUobj3kS9wwYegsOQNT8cjZYA-YATJJt7w@mail.gmail.com> <34bb249d-4a4d-4cc7-b737-bb18398341d0@app.fastmail.com>
In-Reply-To: <34bb249d-4a4d-4cc7-b737-bb18398341d0@app.fastmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Sat, 2 Mar 2024 23:23:03 -0800
Message-ID: <CAPx1GveaNR9ooWqE1VkAuFg5NO4Lwzx7bj-W1mWeHRg-rcg6+w@mail.gmail.com>
Subject: Re: [PATCH 0/2] Support diff.wordDiff config
To: Kristoffer Haugsbakk <code@khaugsbakk.name>
Cc: Karthik Nayak <karthik.188@gmail.com>, oliver@schinagl.nl, git@vger.kernel.org, 
	Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Continuing the digression a bit:

On Sat, Mar 2, 2024 at 11:58=E2=80=AFAM Kristoffer Haugsbakk
<code@khaugsbakk.name> wrote:
> This looks similar to the discussion from a [stash] topic:
>
> =E2=80=A2 Proposed introducing config variables which change how `git sta=
sh
>   push` and `git stash save` behave (what they save)
> =E2=80=A2 Concern about how that could break third-party scripts
[snippage]
> =F0=9F=94=97 [stash]: https://lore.kernel.org/git/xmqq34tnyhhf.fsf@gitste=
r.g/

As I see it, the general issue here is the tension between Git
commands that are used for scripting -- which ideally should
always be plumbing commands -- and those used by end-users.

This tension is relieved somewhat when there *are* separate
plumbing commands, such as `git diff-index` and `git diff-tree`
and so on, or `git rev-list` vs `git log`. Unfortunately there
are some commands, including `git log` itself, that have options
that are missing from the roughly-equivalent plumbing command,
and there are commands (such as `git stash` and `git status`)
that either do not have, or at one time lacked, plumbing command
equivalents or options.

The `git status` command shows one way out of this problem:
we can *add* `--porcelain` options.  Perhaps every command (or
every non-plumbing-only one) should have `--porcelain[=3D<version>]`.

This doesn't fix the situation today, but provides an obvious
future-proofing path.

Chris
