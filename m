Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB80015B125
	for <git@vger.kernel.org>; Fri,  6 Sep 2024 23:24:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725665077; cv=none; b=PifDER25f1wKgIlzPibTTXbtqDjN+lg+FARPSTzPgilZovCN5Hpmo9S8dsafAin8m7KseJ/WNGxv6hJAIMyEAvgyATsYdlkCRfFjNrAAyhRQLfcY/JQBORnLyKRwHm7DOqzZacak16Z585p0Ud0rE0NHLdZ/jrtOa2SdWIZhEB0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725665077; c=relaxed/simple;
	bh=Uyu7FsT6u5zPC7c7a+Mq7TIlgO1xCa7+F4oPxsn+Nw8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=B2ZOT6rUcq9RvjXoXl4Snj/SJBWYbNvBQ1nnFqGSnDu2D0eSkdEPwE9mUPhu7Rl3SbIt/G+uERjheCHsBBzNkpxB2EQtSoZbEC1woNkdXgLc3xOdhuD56mvYisohldtJf443u+Z66DsIQvaIzFUa6KV/M2U0CDV7kROyDuUEw9Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com; spf=pass smtp.mailfrom=gmail.com; arc=none smtp.client-ip=209.85.219.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=sunshineco.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-e1a8984d3adso183301276.0
        for <git@vger.kernel.org>; Fri, 06 Sep 2024 16:24:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725665074; x=1726269874;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Uyu7FsT6u5zPC7c7a+Mq7TIlgO1xCa7+F4oPxsn+Nw8=;
        b=a37sdXzKjcrw+awKn+IRxTzkFziFDxIp1gcYmSV+N81o68pIRm7FQDaXt49HGz1wyO
         SzMeGuyARUbJt6bM5XZd4n7tXeDxJNolsQ8VRReienKNz/tuR+XyIS5jTrpvR1vBY0Zu
         wbTOmLsi0Piw8z725mD80djWxPxJO/yKzK4J5PFc4g6hWJO9mjkIZHPwA6PTgXVp9R6u
         AzHLB6N5NonkQtl18+f+9Pre19PGNcjkE135P7i+e1GTkIb9wZgK3VmrOtzVeL7PnOaU
         n0kUG9bnbMgjg2ACWtiSi276s4wkUKCUgCrIY/2gbiEeWKoUSt+gP9y8vx3ZMsCv+A20
         l0OA==
X-Gm-Message-State: AOJu0YzvY1u11jNEgcHWPpnWQatA4lktqd7FZL5x0r9sUNYTyQiwQsPL
	IGRIUaqYmCUSkn4ngP0gtMl30o+XE4JLoMuEFRtfsNjKL44QLHD8t/+59niy++uQN0QP2iXoR7z
	9ujYzJ/lutpiVU0q/sPcng/98mc0=
X-Google-Smtp-Source: AGHT+IEskLsLkX65U1WKrN3gaOEhv+GwHj1pqMIKsE3HdgbgwEc3gHt5rl0qLkTGyxrSzRcE/TuKOVP0JAY7dWz9PqA=
X-Received: by 2002:a05:6902:2488:b0:e1a:65d3:fcc5 with SMTP id
 3f1490d57ef6-e1d34a4673dmr2168657276.11.1725665073848; Fri, 06 Sep 2024
 16:24:33 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240906221853.257984-1-calvinwan@google.com> <20240906222116.270196-4-calvinwan@google.com>
In-Reply-To: <20240906222116.270196-4-calvinwan@google.com>
From: Eric Sunshine <sunshine@sunshineco.com>
Date: Fri, 6 Sep 2024 19:24:22 -0400
Message-ID: <CAPig+cRKbvWT3Bx65-ULAYRSrrKTCL0C7r6xpNSdN5JjLBPjCQ@mail.gmail.com>
Subject: Re: [PATCH v3 4/6] config: add git_configset_alloc() and git_configset_clear_and_free()
To: Calvin Wan <calvinwan@google.com>
Cc: git@vger.kernel.org, Josh Steadmon <steadmon@google.com>, spectral@google.com, 
	emilyshaffer@google.com, emrass@google.com, rsbecker@nexbridge.com, 
	gitster@pobox.com, mh@glandium.org, sandals@crustytoothpaste.net, 
	Jason@zx2c4.com, dsimic@manjaro.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Fri, Sep 6, 2024 at 6:21=E2=80=AFPM Calvin Wan <calvinwan@google.com> wr=
ote:
> From: Josh Steadmon <steadmon@google.com>
>
> Add git_configset_alloc() and git_configset_clear_and_free() functions
> so that callers can manage config_set structs on the heap. This also
> allows non-C external consumers to treat config_sets as opaque structs.
>
> Co-authored-by: Calvin Wan <calvinwan@google.com>
> Signed-off-by: Calvin Wan <calvinwan@google.com>

Almost all these patches suffer from some sort of missing Josh
trailer, so I'll stop mentioning it now.

> diff --git a/config.h b/config.h
> @@ -472,6 +472,11 @@ struct config_set {
> +/**
> + * Alloc a config_set
> + */
> +struct config_set *git_configset_alloc(void);

Should this documentation string mention that git_configset_alloc()
does _not_ initialize the configset? Alternatively, should this
function also initialize it as a convenience (and mention so in the
documentation)?
