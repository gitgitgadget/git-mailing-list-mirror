Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28E4A15749A
	for <git@vger.kernel.org>; Wed, 28 Aug 2024 20:29:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724876947; cv=none; b=Q0+XMbRRBR06txpKoWrh/l1Fg+QEXcplPMEuM0F2KIfcDTBNrkyPkQF0qXxqmT4Zh5yAhOxxqbz/VfpNBT1txEEE8FgzunkXLswyrCWIjl/Lnpn+m8fkHKO+Tl+pEeg0s9i34zvTiOGWv7RNDMWGnZBqWsrmLxCMdZyonO7qa24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724876947; c=relaxed/simple;
	bh=FErcBGz7RH9PHvMTqKMWQxrQLCu30KU0O8NYlyau0Xc=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=G25YQQRMn3M/mziqJy4SUwmqJ0CH3btKxhfPBNeHSsYV1MM9k6Vr2e68NP43tM9JPQu4gCqTNS7b6QSfm4RXzpiJWaev6PDQwplx6ZQ01tu1Jc2jZ+fiPWz7dMbnDXsPPOGjoYycpVQo+NDZs7MDj4M8AKLw0/Eoy3F2kNzFGoM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qztYVG0J; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--calvinwan.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qztYVG0J"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e1651bac405so12922018276.3
        for <git@vger.kernel.org>; Wed, 28 Aug 2024 13:29:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1724876945; x=1725481745; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=rccJejMKW8bw7pAe9cqeu12esUsYSViRMxEp8yn3Jdc=;
        b=qztYVG0JF8P/SiIu6a87RECk0xuzg7pHRPaR+BNI5I3Xchm7zbd6zWWkJdazME37Ya
         pcdcYKDRg++bWI1ZWcR+Bdnag1qEeYNWOCCqd53ZSoAQEARq//HESBF8pwOUWr8V1Em5
         sRLZkkQcXAXsUSUM23C9Yy1sFD6DlkO9uifTujfolkIYkD+jpc8rvmklHZr6SN2kR8cd
         wIjLTCsX9kshq9Bu86Zy31qC+R8AbswUNxm7qpeomerX98yquCdewuryVX2nU7142QsN
         Tv0nMcke+TJESn9T31auMjZpV3ThKsLSjoOaxYI7je4zDnR48DUzBc4aqtCvcavaTlYO
         jQdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724876945; x=1725481745;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=rccJejMKW8bw7pAe9cqeu12esUsYSViRMxEp8yn3Jdc=;
        b=cVIKZYEN2ltpjWo66Ug86O2EFpCHCW7djYxahvGfmWliJrr/kaIiafZQZRqYdRY4jN
         1Pbkog2PLbWco+dJwo6ZSM6FN41v8m3AW7+6X7WeSjamvN6x90o6GPPNv68B7C3HI3f2
         +TPgiKECBGENZFKSn4kis59UWufEMAl2QJBD2BFhushSzI+0zEvHapVTXPafreLoNXoR
         Q7oowyujnR9+/bzQTspCso71atfRylOj1VEgekeNwB7RXfGhx3my2Xvp2LMpSvc4xdu4
         5hRJ1FVu8Iyh07LSTQCBFPgamvuLwDN+QoGEeMrXIdfw/vCt7XZh//ryn0SU81CeRnfl
         Qe9Q==
X-Forwarded-Encrypted: i=1; AJvYcCUVp1ln7CtqJy+z6qX5ubvxQ+6czw+Lyj1SYRqOXnH5h+gJkXCIv5plwus/b0QFv8oU0zI=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxs03bLfdQnYLnrMVsandDkt3Z1bpZTAnzZqsWCoJPS0m1yKdUT
	CcphaymyMUbCHkmkWpTg/gew4hBvsTPy62dHJhOQmg2fmilbxpms0ljTL3G4tEml7X76vJlVldt
	i8Mjd7Ld6aE1OTQ==
X-Google-Smtp-Source: AGHT+IET6MpVVeR30l8j3mFykPsoZhNy9KR8pwAT7O4Usd6o/hTZkE/zdbAlmW1dBga0zNiVxAi2fS+zHl+UDX4=
X-Received: from barleywine.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:3bd4])
 (user=calvinwan job=sendgmr) by 2002:a25:dc47:0:b0:e0e:8b26:484e with SMTP id
 3f1490d57ef6-e1a5ae02a95mr587276.8.1724876944923; Wed, 28 Aug 2024 13:29:04
 -0700 (PDT)
Date: Wed, 28 Aug 2024 20:29:02 +0000
In-Reply-To: <920db3a2912c609d4ac1fca2fc6b137513c8eceb.1724656120.git.ps@pks.im>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.46.0.295.g3b9ea8a38a-goog
Message-ID: <20240828202902.4156688-1-calvinwan@google.com>
Subject: Re: [PATCH 15/22] negotiator/skipping: fix leaking commit entries
From: Calvin Wan <calvinwan@google.com>
To: Patrick Steinhardt <ps@pks.im>
Cc: Calvin Wan <calvinwan@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Patrick Steinhardt <ps@pks.im> writes:
> When releasing the skipping negotiator we free its priority queue, but
> not the contained entries. Fix this to plug a memory leak.
> 
> Signed-off-by: Patrick Steinhardt <ps@pks.im>
> ---
>  negotiator/skipping.c                | 7 +++++--
>  t/t5552-skipping-fetch-negotiator.sh | 2 ++
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/negotiator/skipping.c b/negotiator/skipping.c
> index f65d47858b4..b738fe4faef 100644
> --- a/negotiator/skipping.c
> +++ b/negotiator/skipping.c
> @@ -247,8 +247,11 @@ static int ack(struct fetch_negotiator *n, struct commit *c)
>  
>  static void release(struct fetch_negotiator *n)
>  {
> -	clear_prio_queue(&((struct data *)n->data)->rev_list);
> -	FREE_AND_NULL(n->data);
> +	struct data *data = n->data;
> +	for (int i = 0; i < data->rev_list.nr; i++)
> +		free(data->rev_list.array[i].data);
> +	clear_prio_queue(&data->rev_list);
> +	FREE_AND_NULL(data);
>  }
>  

It seems unintuitive that clear_prio_queue() doesn't also free the data
underneath and that a caller would have to know to free that as well to
avoid leaking memory. Would it make more sense to add this change to
clear_prio_queue() instead? Patch 14 has that pattern already.

Thanks again for the cleanups -- I'm tempted to take a stab at some of
the other memory leaks you mentioned during our biweekly hackathon. All
of the other patches look reasonable to me.
