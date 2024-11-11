Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3E8E1C9EB5
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 23:53:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731369223; cv=none; b=Emgqchur/uLthyxJZUAkANV+r0srVGmMFAYuG9ukIwrZzQ87lNw/1oMZ9Px2zGH/H3e+n9rcIQQHdShFAa9NsaA+NxmRZEKUG+xtrdUZIIBvSTEClZIjCdZDp9CnYh/iDYLuE+HtSkcRZiRZoXe42+XRHzWmsTvabOH8N6mIR+c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731369223; c=relaxed/simple;
	bh=Ex7LuMCB3iMBujf1niUkEV+KbRKSLGH4KeUZUTvBPYM=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=D1YBVduGUVYa8Q+yN7BTQ6BNlyFjBq3Qb0Ki9L9sGZu3UQfPaAnmGadpBkGG8y9g5P/BZGyVWpS02uvWQ6FgZ/YAQKDA1Xgpnx1vCbpId/vOQBPR+Kg/TnJ4QVotYeYqTHw6lo8tYMHqg5d+8Wjxkeghvq0lJGLCAfJvZkqIgQg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=ve4Ko8RQ; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ve4Ko8RQ"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-e29205f6063so8016478276.1
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 15:53:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1731369220; x=1731974020; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=FDpT2FDjz9ZdkNnol/oCgX//6HAnwMZHgKxMZMKy9cM=;
        b=ve4Ko8RQDo2xrSCBMmmdcJNg3byWKo0SU3+32L3B6ahLZTjDzqnSSHXwCLsLJTminp
         bdohdRvckCYu2IeMRPpWylguIVAWBPpqE0tM9+zKuioqlZg+zKB1iy6tO2cprnDvAmuE
         Yd+LuxpnUK/NHuGd2nTonVZu7XJBeJZl5Mlov9Hl7GID+8dRqQwJBpBitBzutlFBzZhT
         tsC68KmV86MwB+w5O8jCvpUGNRMGz848cncsARLulx5+Pfhan6Eh9QykRIlxC9s+POsV
         oxzp64z4Orz8Ppe4NUEG+f2YZP6WKBnPgeeysZnJhqJfKnSFxtIQkGljAy3Lk/DLAD0t
         CeSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731369220; x=1731974020;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FDpT2FDjz9ZdkNnol/oCgX//6HAnwMZHgKxMZMKy9cM=;
        b=aSCvCNnaBSln1uH0p8FYJFyAqXI73Vabhw9VniqT9Zz8bZR4cc1CVnWCs8WDWkYdmV
         S8hYKVMex/Gq7SCzXNQqTeorbwb2IaVzaWv7hsqIJBjq9eBJ2fxVO93GQEFgiIFs+ZZB
         TdluNnc57blWeO6AWzdM4/ylCo/y41ttNpDJWOrYXFxXYe16G2KPR0cBselSXdbgnPaB
         lZeDKmv2my/lXyXP4KOt8OKYVuagvgRs/tA2y7wQtDvZpidYnQcIRw1pF3Zwu8CegRHh
         Cuvkk1lYLzm844tKZ3d0tGwMAcNHNotH8G14oTjcaWVkUaMKfHBXvtEMATPPk8EYGrpf
         Vr6Q==
X-Forwarded-Encrypted: i=1; AJvYcCVRmFUx4XUkXXTbGtbw5RuJ2QCCTh6pk3MDAcAGlNIk7las6G7//a+e9M4cECIHpcaUgEs=@vger.kernel.org
X-Gm-Message-State: AOJu0YyBEhfGSimAP3MzAN15qWEkvdRbHR7Nygy8bxCH+o5b7nMFXi+e
	7v0P6Vo7K8C51ZYOyc8iavzQnj9+INv6AUCDi/l7oJdrE+CBhEZgdPgSNjWvFRJ4Qg4jnLY3BwC
	HzRVq7Y/OCYupxfMCiQAdRQtDpzYfyw==
X-Google-Smtp-Source: AGHT+IH6Oi2Y8d+IQIo6AU9pMYDZi2LvrW9TCBzBeDyei9hK9DE9LdmA0U/h445NiqKKCEYDmEYwHGVqOrRq3BBb+pJN
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:6b4a:26b6:5856:4314])
 (user=jonathantanmy job=sendgmr) by 2002:a25:d8d1:0:b0:e29:1893:f461 with
 SMTP id 3f1490d57ef6-e337f78051fmr45153276.0.1731369219807; Mon, 11 Nov 2024
 15:53:39 -0800 (PST)
Date: Mon, 11 Nov 2024 15:53:37 -0800
In-Reply-To: <xmqqbjyqnoe7.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241111235337.1691851-1-jonathantanmy@google.com>
Subject: Re: What's cooking in git.git (Nov 2024, #04; Fri, 8)
From: Jonathan Tan <jonathantanmy@google.com>
To: Junio C Hamano <gitster@pobox.com>
Cc: Jonathan Tan <jonathantanmy@google.com>, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Junio C Hamano <gitster@pobox.com> writes:
> * jt/repack-local-promisor (2024-11-03) 5 commits
>  - fixup! index-pack: repack local links into promisor packs
>  - index-pack: repack local links into promisor packs
>  - t5300: move --window clamp test next to unclamped
>  - t0410: use from-scratch server
>  - t0410: make test description clearer
> 
>  "git gc" discards any objects that are outside promisor packs that
>  are referred to by an object in a promisor pack, and we do not
>  refetch them from the promisor at runtime, resulting an unusable
>  repository.  Work it around by including these objects in the
>  referring promisor pack at the receiving end of the fetch.
> 
>  Will merge to 'next' when the CI breakage fixup is addressed.
>  Breaks CI (with a known fix).
>  source: <cover.1730491845.git.jonathantanmy@google.com>

The fixup in your source tree looks good (verified at
https://github.com/jonathantanmy/git/actions/runs/11787543288).
 
