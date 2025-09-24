Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com [209.85.208.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66B6F3093BF
	for <git@vger.kernel.org>; Wed, 24 Sep 2025 15:01:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758726093; cv=none; b=iUHJ/rckNFXx/p7khf8Mlu8iA40u35RS5HH+8tA8ky4UGnftznUsuStrX35cV7FG9hx+1A3jori9U5SDtaANb09bZzitp1H7xHIuwNi8Z8fy6dj2FCevKwkj8mSyoie0hJTbC83f5AN50xXH/nIsA8a8VW1MfIiJ7wfp+JtJ5mM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758726093; c=relaxed/simple;
	bh=+O1saP9iyrgpfkvR6c3L6Zj/Eq2hgunMoWIbkOEvI4Y=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=a1EP3z0J8jmjERB7nbgegYrEvDflTwhTLJrQM5VpuFN235CX8MnsRpMgVNyrfAMuc+ToVnEPdvya48KEcirOEItmo2hftjFE7Wmnh3LeaHyLawmQ5TyRu9WOKvX/Z1T9oMGXKy5MSbPdCIAs8gAReUwbKW7tdixhsxjmVoLhmEs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZxZEUD2f; arc=none smtp.client-ip=209.85.208.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZxZEUD2f"
Received: by mail-lj1-f176.google.com with SMTP id 38308e7fff4ca-3515a0bca13so12619111fa.1
        for <git@vger.kernel.org>; Wed, 24 Sep 2025 08:01:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758726089; x=1759330889; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=7KuOe6x3rPspRnrU9VyXvsx2dsjWn6uqORZ4RebtyXY=;
        b=ZxZEUD2fnttEdRM2yBG+lsDgzyyHJQHQytqN0YVzjrOHSKzD1EOazwJTavCWGgG9EE
         +Lj9pO7beHvJIz0dZcDf4TkozTVKi/a6Q/PJhkoQal/GtqU5VXNhGN2K5rUQEgijuc9v
         vFyZgLwe9NWC5nFT31VK5gSLV1Net5itxMt0SaXW+GjJ3GVG4d9frlfhszocoyNP2Bet
         MaazagqXWO8hLrN1phmxIDl/jBNqf1KEZD46vf9j7adcrtLRxeWLUcZOrCaZi7r6/wV0
         hraFzLl2O7GyKqKE7oD/FjzgeqV6cv/HuLCNQ5/Fm9jyWlV3AOyP4KrnP0RHibGqJ20g
         c5/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758726089; x=1759330889;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=7KuOe6x3rPspRnrU9VyXvsx2dsjWn6uqORZ4RebtyXY=;
        b=opPtfV6VPjDawowvqMXUseJEbkzLk9i2v9SA4Sw2rt+jI1pkkTBghFjw6ochfozy5a
         pfu/BBN8n5Dshw6t/8sm8e+HVjmnXqzdo/PEPzSxoDe6ZP+ptkcs6K/i641AxVjO9Mny
         Y+0huYIGPSPMLOT1nCCkNgeoiW/eWreCCNFuyb7v0jJOSoLmLX25PeUePjE4YQAm2lNX
         XrtxQnhKfxT8iGM6obhPI/AILfVjACeLGndjxT9Sr3U3LXQ5Pl9jIhClkq406AXBMRun
         83TsBGwYWeuOsPMYeEtW9SnT0s9PhkXoJTwe7MR5uBFBJzFihEsvqIkDXlo6jXECBPsH
         K7ug==
X-Forwarded-Encrypted: i=1; AJvYcCUnf9hrZOudv10vXMgiDdUfkhjBv8kJFIJCQxwWpzBrBWag3jMsQmudpsSCh9bvMrAfCOE=@vger.kernel.org
X-Gm-Message-State: AOJu0Yx5MdYebVJKMdHhmwKQSe7O9zyVBtnwpWAXy3pkbhBmt2GZjwEv
	gSRiG7wDOQTOGWq6pSsZ3xdZfJxvlpia+rH7mUhPG8oLO9iKRVhXMEKFj6IrRiVq4vKKSwWOAab
	jGwh/tomWodoDFL5n2n9EIGZ7biAaEV8=
X-Gm-Gg: ASbGncsuj1A8TdgiolKKgc5KYb6CaVm3UTWhWRltUGvaIF6b4nJDBUgR9FQmpQtnErK
	ybhUBUg+cCw+rX4/AFgPevMrggVHdlyhDWyX02ACC0MyC7i19rSZuQNF55OnqF/cRx7agUJ5o59
	070LGueIruP0fixUZfwAt72rAxE1OOfJ5c1rE0fQ0dm/rjv7n/aRSG78YPYLjUIZzt0xiOmQBeb
	l4Vv5zHUOIqE6aaUjY=
X-Google-Smtp-Source: AGHT+IEMoILp3CRHFxT6BmppKTqn5xqgapqvJjlqjk0WyfiHIkb8PdgkP9gj2DfduWA3X1U2U2KswCbSaOSCLxzC+wQ=
X-Received: by 2002:a05:651c:19a1:b0:36b:9ecc:cb5a with SMTP id
 38308e7fff4ca-36e6bbf7a1cmr9440011fa.22.1758726089026; Wed, 24 Sep 2025
 08:01:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2048.v4.git.git.1758570701.gitgitgadget@gmail.com>
 <pull.2048.v5.git.git.1758662670.gitgitgadget@gmail.com> <7b0856108a29f42e5a4d3faf7489d5522b683f71.1758662670.git.gitgitgadget@gmail.com>
 <0bb4f30b-6737-43a2-9aeb-3903c0dc5ce6@gmail.com>
In-Reply-To: <0bb4f30b-6737-43a2-9aeb-3903c0dc5ce6@gmail.com>
From: Ezekiel Newren <ezekielnewren@gmail.com>
Date: Wed, 24 Sep 2025 09:01:17 -0600
X-Gm-Features: AS18NWAyaKpm-YCgzg0UdgvUCahm8hR7bcD3Ecv587QNg3NVJTYs42N0Bwz736M
Message-ID: <CAH=ZcbCf7bUTL=BwCD8B6-AVHZg+K3JafvksLQWUx2D-XR58wA@mail.gmail.com>
Subject: Re: [PATCH v5 10/13] xdiff: delete rchg aliasing
To: Phillip Wood <phillip.wood123@gmail.com>
Cc: Ezekiel Newren via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Elijah Newren <newren@gmail.com>, Ben Knoble <ben.knoble@gmail.com>, Jeff King <peff@peff.net>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Sep 24, 2025 at 4:21=E2=80=AFAM Phillip Wood <phillip.wood123@gmail=
.com> wrote:
>
> On 23/09/2025 22:24, Ezekiel Newren via GitGitGadget wrote:
> > From: Ezekiel Newren <ezekielnewren@gmail.com>
>
> The commit message should explain why this change is being made

Reasons to delete local variable aliasing:
  * Usage tracking: Tools are better able to follow the usage.
  * Refactor churn: Later commits will refactor rchg.
  * No additional meaning: The local variables express the same meaning
    as the struct field itself.

Would that suffice?
