Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B78A1E0B65
	for <git@vger.kernel.org>; Tue,  5 Nov 2024 21:28:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730842133; cv=none; b=gY3sr//ugAaJR7O7boC45FVV7ncn/6lzObTYJGGXgEp+MkS1P9k0VfatD1lUDqhBZQmYnkZSFff3Zhj2EaDARgtiGqyZkRxVqrOC2PTUzZFDBqv3YQdusrLYRyjyRtCSAZ6SwGNtTi9h31t2do5NSBeQUWBII+yy1NG2NL/I+FU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730842133; c=relaxed/simple;
	bh=2t9O87LhGGeu5WtW2W/q+ksx2rdgi6yG/jr7dMYmct4=;
	h=Date:In-Reply-To:Mime-Version:Message-ID:Subject:From:To:Cc:
	 Content-Type; b=IUx7ErAO4mxoyU91q/WXUNpccdT1Y3qxEV3ManfpbkXRqwpf6Ve9JPgnSA0DTpPpJm93N0TsTsDgKzmldlLlGfH5Ik8J7RidaRXXcmqvbfUQZNlptVAZDjKGbQlgjw6vg+mNxC4t6NS+8hC3zkR1jL657b2rryRvhg7g4e4HO34=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=K2ciLA6t; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jonathantanmy.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2ciLA6t"
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-6eaae8b12bfso25891197b3.3
        for <git@vger.kernel.org>; Tue, 05 Nov 2024 13:28:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1730842131; x=1731446931; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vy4NFUvLBd1CVf9MBYJm/QAUcBZ9w/9lx65FE0r6xHc=;
        b=K2ciLA6tCVBNyQHLSg+wHo3pQ3OSokepTalqWFGcLDE2ZYd8u9Cedg5JQkAb/0IVoZ
         7xIR6vl8+UlubotCECgTNUpJacEDxWlmrk2aymmZaBGTeJrGZAjeEMdwqK21CLWolDsS
         GUVNCDN4sOmzNVU6eMa8xxJAZWdgRUy9wmjV6HwlS6x4RjEXdGSrpTGk+5LxDv9AHgWf
         XDiK4K961CxAkXXB7mODKFA3olrWYYMIuKNbtwlaLa82yrsFugD9Z3evlmrCmsD5691g
         g2UO91lEyFq4ZZdcCDdL7Z7UJbpCTZnlokmVpAHb0ktR0WC8vxKyf5Rlls7xOiKIwXyh
         UMNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1730842131; x=1731446931;
        h=cc:to:from:subject:message-id:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vy4NFUvLBd1CVf9MBYJm/QAUcBZ9w/9lx65FE0r6xHc=;
        b=c0cPkNOmHoReDbJWE4pZjLmCVJcqEoKsJ0dnZCZJIA8eK3WSbAGyynwMgI7blkENFV
         Xbm0WvfzC4YJLEFM2ksaVOqGS/Zw1NrRp1OcxQUFR/2rmW2Kzu1JE4hUbGJFuqBGfqp+
         Rjf6ZIw1s93xLrnMYtTiQ1eiAeWX5QnfKPxNRWoT3kKu9rYt7wIxc+NnnX8DQGSFypqS
         pFfkVnz/ZkrcILDx6HZH07Uh4KvdVNlpH6dbe/QlQHeZpdXEXC4bVdZGfMXV3LcTFbfw
         FFWn7amfjpqOW2KivvrX5Nmay6+WGXf2JoR+vr1yJVn64dVzJw6Vqvypvg/KE23z8GbO
         +9yw==
X-Forwarded-Encrypted: i=1; AJvYcCUVKiPmh3W+5pGxtcm4QpAT8ItGHWp0eVlPpwtIUTRc4X6b/+XZoFuQmhFtN+pTH9UDXuY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwojClk2l6Ju6DkZsTHaEifZtpth30+6QLWYX7DWLHPBMc1/PUu
	SC/sNoNYDSTTS9ShgEupemVGdTyE6l+HgRw6+RqWi6ktDtupUSVnwUIndJzsA4r24GfWzlXR/6R
	uXFytNal5djKukCDRvixmp0dC7DwwtQ==
X-Google-Smtp-Source: AGHT+IFL5CApboo8sBjfwlAujQjgcAhw3mc6EB2DxoWKFKk5S9oYSbHCqHxbGodN5mFhBePlcV3xe8bClTwm9R2R/GYH
X-Received: from jonathantanmy0.svl.corp.google.com ([2620:15c:2d3:204:af5d:b903:295d:2c17])
 (user=jonathantanmy job=sendgmr) by 2002:a5b:7c5:0:b0:e30:dcd4:4bc with SMTP
 id 3f1490d57ef6-e30e5b37923mr13903276.9.1730842131269; Tue, 05 Nov 2024
 13:28:51 -0800 (PST)
Date: Tue,  5 Nov 2024 13:28:49 -0800
In-Reply-To: <xmqqwmhirrvl.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.47.0.277.g8800431eea-goog
Message-ID: <20241105212849.3759572-1-jonathantanmy@google.com>
Subject: Re: What's cooking in git.git (Nov 2024, #03; Mon, 4)
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
>  Needs review.
>  Breaks CI (with a known fix).
>  source: <cover.1730491845.git.jonathantanmy@google.com>

The fixup (in your tree) looks good.

As for review, for what it's worth, Josh Steadmon has written some
comments [1], which I've addressed. Regarding the big-picture issue
as to whether this solution is the best one for the problem we have,
both Han Young [2] and I have verified (with private repos) that this
solution does not have noticeable performance issues (which was a
concern with other solutions) and I think that this solution does well
to preserve the concept that we know which objects are re-fetchable from
the remote (even if we have created them locally) and which are not.

[1] https://lore.kernel.org/git/radxsrv6sjemdzl2mw5zzkieyim6xfikrevwggjmzi774g2sob@4nx7fwcjfk32/
[2] https://lore.kernel.org/git/CAG1j3zGiNMbri8rZNaF0w+yP+6OdMz0T8+8_Wgd1R_p1HzVasg@mail.gmail.com/

> * jt/commit-graph-missing (2024-11-04) 3 commits
>  - SQUASH???
>  - fetch-pack: warn if in commit graph but not obj db
>  - Revert "fetch-pack: add a deref_without_lazy_fetch_extended()"
> 
>  A regression where commit objects missing from a commit-graph can
>  cause an infinite loop when doing a fetch in a partial clone has
>  been fixed.
> 
>  Waiting an ack for CI breakage fix and possibly a reroll.
>  source: <cover.1730409376.git.jonathantanmy@google.com>

Through reading this I've realized that the "warn if" should be "die
if", so I've made a reroll [3].

[3] https://lore.kernel.org/git/cover.1730833754.git.jonathantanmy@google.com/
