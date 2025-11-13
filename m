Received: from mail-lf1-f45.google.com (mail-lf1-f45.google.com [209.85.167.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19B792F99A5
	for <git@vger.kernel.org>; Thu, 13 Nov 2025 20:34:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763066090; cv=none; b=ZMT9ALVXQqvkaUk+n9YqqtSZtTeQ1H1iq2KSmSQ0tNvbRtUT/5LGpKPX6Lo3zwE85zOFRNuLPdN36hrLkNDzFsj9rF4U48Sn9u7YR5BpJbDV8IF5F/lP9cl6Z79Uqk2vJw33e/daomq1zUsHJFykD3Fz0SgN8GGAYf1aM+eCpT4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763066090; c=relaxed/simple;
	bh=xdWaLfbGvAx+xxEAhpDj4p8XTk4Wjjdd2WzcyU1FHVk=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=rgz3p213iIBl9udXQ7NSTwalSz7wmcKnKwkSksNTtN5YtHFw753XW5NKyuXJo/6vzyNPxApPpXU5ZAKxUNIrrElev0S07a6q9wNyB+6J1DZ6qallVG+A2R8beb9oKCdMdXvBD1a9nXZjLVr9r5itinm1kO7vhjXxufGmkJ+AbXY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UCPbqMjG; arc=none smtp.client-ip=209.85.167.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UCPbqMjG"
Received: by mail-lf1-f45.google.com with SMTP id 2adb3069b0e04-594476f218fso981120e87.1
        for <git@vger.kernel.org>; Thu, 13 Nov 2025 12:34:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763066087; x=1763670887; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xdWaLfbGvAx+xxEAhpDj4p8XTk4Wjjdd2WzcyU1FHVk=;
        b=UCPbqMjGNv/B3gMBxpP3xTtJWabiXOVZmEoQPVooWvogVYY6Q+nHMOQll6CksGsjLf
         mYKqgwKeG98TBzw5kY0FUYmApEvPtEocTnk7qxMAqmdX+8MU7UXm8wlr6aR+D37vxOIf
         5gvX7P9TrKe9BrYayn/cpLS8ahQYTZGRxfCiCNrgNj1swsnzC1MBQIZMvjGmda8Xhqs9
         eeRPIhb2xvWspY09AwnRC+bv9CWmgEnmJ1XZm78ASuxLWbmBIVtCVH3SuN6kZw5so6I2
         PRU+58MpkEH16Mz/0RXwq/WygA/2zzYGMgoIeYzOnIOCMzDJATsV+YwFqjCks+uq+lCA
         0nvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763066087; x=1763670887;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=xdWaLfbGvAx+xxEAhpDj4p8XTk4Wjjdd2WzcyU1FHVk=;
        b=CxnoXoR7YSKSwMAtTIeym7nOn1W/tPYbROdT+y7PeQmaXi960m710TDUArQR30tImp
         qgYdTrHkKMvjBAyjJXuGPk4lSZwWlcsMGSqqR/HOGKLGwwhbVtllXh99AEtxigqvXplH
         tUTBQp/ERX0RLI3s4VySOI1nMHsdGOEqbDJ6JoGukLK+hq3yHlf5HXuh4B05Rwv2LmR7
         YlJsRlgqpH+BN+uWub0bayYLylJvuH0XaOo1j4JZAXt9sHAlkbQXc6SXiFRxmoccAWxa
         QL6tQvWwh7bX+HH76S+yXWvqArSdZvU5W60Giqp62SY6JWnud2VVDm4PUafJ6+808GDP
         ohow==
X-Forwarded-Encrypted: i=1; AJvYcCW033dvp4rUJSY5yQmwabN/Xhb/A1ObpVXwj6vNlI4k3OgVAe28BSQKm6Gfm92BRGU1RBk=@vger.kernel.org
X-Gm-Message-State: AOJu0YyW1Q9fOMMvjC7UdWo+5H62fIPKZEobVtngiYoybBYvwyF8xjQp
	KPS4FF+a1Q7rXjjwwWGseTry+PfBJURB/xrujwnYDvRXm4x0pE1be4LtX9bMFdk/mavaM9oZfZX
	M6LtglMOCBFU79FAioSUJukcvtP26vaE=
X-Gm-Gg: ASbGnct8Gw3pvxlwCLRvyUII/PuSBjhRUxadHusUGfMu4t6wz7yn8w1CWAndJhFe/Eu
	7DPoi5VKH/CE2hjB9PJjkKGg6cWApV5GAS/VYUztb7YbFVXe3CVBQXkxKvxxi5D2FAuWqltykpO
	Nw8L7ecJ9doSjBiAiEjEad/8rGyE4ufbKaXRMURiFmyBvXCm0Lii5zvNppRI1GvmIZApBKy8ad+
	C+tbREsOmzow7K+VysoH2kDJYlTo79a+imrvcz0lir5ihayCYRrH1gpTrakZV6ALH8AxeK+
X-Google-Smtp-Source: AGHT+IG7Y6j67GnzSY6njzYGpevReR+TmN36hHj4mqJ+s8WRi+0TCi2C4y8U2Fy/ALGJ9p3S4HYpzPBKIaNWFg5n9HM=
X-Received: by 2002:a05:6512:1327:b0:595:7b24:d353 with SMTP id
 2adb3069b0e04-59584195bacmr226507e87.2.1763066086989; Thu, 13 Nov 2025
 12:34:46 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <xmqqo6pde90w.fsf@gitster.g> <D50AB3E0-E41C-49CD-9407-AB60331A6A43@gmail.com>
 <xmqqa50v4x8n.fsf@gitster.g> <150f3442-93a6-4469-9c25-5bca24accc80@app.fastmail.com>
 <xmqqfrakyj0w.fsf@gitster.g> <2474339d-67bc-4a68-9f26-fe7edd172ec4@app.fastmail.com>
 <xmqqa50rqcy1.fsf@gitster.g> <xmqqo6p6q32v.fsf@gitster.g> <2265ecb5-b0ba-4a28-904f-186ef5318562@app.fastmail.com>
 <160ef4a8-8e9c-4034-9607-2f268fdbf29d@app.fastmail.com>
In-Reply-To: <160ef4a8-8e9c-4034-9607-2f268fdbf29d@app.fastmail.com>
From: Chris Torek <chris.torek@gmail.com>
Date: Thu, 13 Nov 2025 12:34:35 -0800
X-Gm-Features: AWmQ_blQVIVtgQwLZA83nQ7IwUxkJXZy--cFK5bOu1nWqsgWPLXQMJnJL7Y9WGA
Message-ID: <CAPx1Gvcf5=nBg9=AakfF=2tXVakBfddt7vTj+Wy9-497OcjviQ@mail.gmail.com>
Subject: Re: [PATCH v6] doc: add an explanation of Git's data model
To: Julia Evans <julia@jvns.ca>
Cc: Junio C Hamano <gitster@pobox.com>, "D. Ben Knoble" <ben.knoble@gmail.com>, 
	Julia Evans <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Kristoffer Haugsbakk <kristofferhaugsbakk@fastmail.com>, Patrick Steinhardt <ps@pks.im>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 13, 2025 at 12:19=E2=80=AFPM Julia Evans <julia@jvns.ca> wrote:
> To immediately contradict myself a bit: after sending this I thought to
> look through Mark Dominus's great blog posts about Git to see if
> he has anything to say about this, and I came across this article:
> https://blog.plover.com/prog/git/branches.html, called "I wish people
> would stop insisting that Git branches are nothing but refs".
>
> It reminded me that of course in Git the word "branch" often is used
> to mean "a sequence of commits" ...

Yes, this is the crux of the issue: The word "branch" is ambiguous.

In Git, the *branch name* is the `refs/heads/whatever` name, and
we also have remote-tracking branch names under `refs/remotes/`.
The *branch*, however, is some ill-defined set of commits starting
from the specific commit identified by a branch name *or* any other
unique identifier, and then working backwards for some unspecified
number of steps with unspecified constraints.

Sometimes the bare term "branch" means one or another of
these various things, and sometimes it's meant to encompass
all of them...

Chris
