Received: from mail-lf1-f54.google.com (mail-lf1-f54.google.com [209.85.167.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 72F133BF689
	for <git@vger.kernel.org>; Thu,  4 Jun 2026 05:23:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=209.85.167.54
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780550605; cv=pass; b=jICvVdpTwhvNvTmqhJSm8JAT9f+lB9aMnDJ2VgwIkL04/hKeAqmSBFkd/ktEY5CLR+0NHOybFzc8v30NfR5FN9mHkrmk7rKwp4eCPGCEjr+oOH/iyHp4AIcHnDVA46npNKqGHHM9o5WkbuR5Ljmq/M70OQ1UbWsleu8kykaePzo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780550605; c=relaxed/simple;
	bh=MU161OtGK2mYPAZv/cA1b6+ITAf7AGEEpiZDQ//p6fg=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=XTrxtUHHmhXxJfZWYRJaxgZi0g03DAwVy0bs8OHBW2viGzWZn1ym8WrjM4w85AzBzMiiUV4Z64M2FUua6Mi5VZ47yjcXC5NRM6iD1xCaOQtA+jJ+j/ubHfJfp8UIt96Xuf0gbmdh6Ytkqlvfo0hOYdCuGRdbELxNTTP2vyA2lqY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=BJYWQEJR; arc=pass smtp.client-ip=209.85.167.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BJYWQEJR"
Received: by mail-lf1-f54.google.com with SMTP id 2adb3069b0e04-5aa68e66128so258735e87.2
        for <git@vger.kernel.org>; Wed, 03 Jun 2026 22:23:24 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1780550603; cv=none;
        d=google.com; s=arc-20240605;
        b=BcxD6SDIO/BX/gHz6eXZdd6rZ78rlL8LVI2Xxrwlirops/z/HkQjTNbrju7LGNAK9d
         Sa3o1QmvGYyICqkWKT7e3YO0MF92CkfyVsr58d9DasYS7FZiQf9ixHwiYS3TMrP4nFuD
         polLDbi8okgLsOry8HDPiD3SpAg8gzDeOxINqvce5x1l7W3LWdZ0AkmlMCO0znwWkZ1w
         iM1O6q2xl3XWNKGxp8LiFH5vh5MRy/e1GJ47/cYV0p1qj3SFfYtuJ6IJNVsXfbAQueVx
         5fFGV4/4ffISi3epQ3H17O/a0RDvTenNTIDLfyePsDZMJD7o4mCA+VDROV+bKGSZbf7Q
         /9+Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20240605;
        h=to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=MU161OtGK2mYPAZv/cA1b6+ITAf7AGEEpiZDQ//p6fg=;
        fh=DJHZ7itWveYVdfezJsKgr6XLEjDMbfeXEew73fqN9oM=;
        b=JWIyEqVDgi4HV7si3nUoHcwOprMnQN3/ra4/BxJepFmQ4DfPCGrAwwUzGcUyjMDE7K
         j2q8AOoM8kAPAJBMAnbZRgMi5Y6zKwZKEENeTik5WGB94B1jsXDfOvPs+KGT18h+K0oS
         dbIzXvhPmbZ+B8hpSGDJS2AeTfrwYwSdYUlAL1ZEr9uPVyObFUMlbpR60FoAd4rVVlLZ
         5XhhEea0ztDjyAH0qpcDIKBeCM5pP7xrfq+aRtGsHQOYnc8w8SfGNQg2rOEJ54i7bA0y
         XQ1Z54Khyhkg8Jl/sEGqk6KXfrsZ6lhy8DL9yn1NYlUdG9E+peSNGW9lCNC8fX4bqUYf
         2LFg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1780550603; x=1781155403; darn=vger.kernel.org;
        h=to:subject:message-id:date:from:mime-version:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MU161OtGK2mYPAZv/cA1b6+ITAf7AGEEpiZDQ//p6fg=;
        b=BJYWQEJR2YxGgNZttF+U+qiRjxsvDij6n+ie0mX06uNyEiY8ctrsE+tnnBj9ncSMbD
         B3bjWYlzChdJCks5HmdpovdquRdLpX5mEJ90tLpnCN/kcFGWqFOrXJWmGVoRHJHQuioK
         EMMxYlZ6znNs/6Nk4TqMPASZYsaWZ7jNhMIu91/Dcsl+6KzdaiSL2oHcrChbSksxl+bz
         HjMywM2Phd3szE0WG8T5Sq0B7ACYmR24AM2n1zpgNF0ZbcshjDldkdmYP4SWAobm58wV
         J4qXHtg37NeGIP+X9aXjORywhvu3cSZ5KRhcFS1R2pp1RR2BGgA9MiZfEHc4spznqbLB
         AMcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1780550603; x=1781155403;
        h=to:subject:message-id:date:from:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MU161OtGK2mYPAZv/cA1b6+ITAf7AGEEpiZDQ//p6fg=;
        b=XD7E88ecz/ryEpaLJ9QbLB1P91J+qYPhmbesmwV6z8BsKl+Mwpr00g2vQ9LChzvaHe
         1cLd6KvKeSUD6515gm1vrqNlgb0rWTTHRc71JS2W5/rkIIxz+AbYADZUFhTjqr8Zha6j
         juoMsK5xeXnNqS4idweACkGYgclvSrv9RUwcZR4XfrJQv8xcZqN9oY7aSs8360bK4L26
         ibnGWYKK2h+Wv9su15mhxZ8EDKLFEd5TDY5YxMwOUjZ9KD4/g+8oq+o24ck0ZDlRUgRN
         FwOUn3A/klQTWwen7V/VuTtHkOqvMWQoY0gO6JvK2HoOi7muvGxLUylc5cUAVN6TAajt
         INjQ==
X-Gm-Message-State: AOJu0Yx+YTzYI5tMrzWhWz+/go2s+iVE0fAU2UuUZXrKvBAk3Y+ZxN6L
	b87UWLE8l2CGrOa3xnSghGFFdMN9rK/9SgPoy3PLRXm/v+Yt69p1gfrarWtn0XAtvEtUc9Esi/O
	bhqAyXgvkAckbm6J0x2+7ZEALybxbb4CmaraM
X-Gm-Gg: Acq92OFRr+hcAxVgkrWHcWCCIlDfE857NK2L62QLJONAu8zZB3qyLv1sDb8cgh0Kp8d
	fDxwLROzqJOi+99vYamsotag+xW4f0jtsKFVYev8MbIKJo4DkiPfXJ9qK9HPNU30lDgQf/hYUdR
	kaw4BdiBuMARaYvSmYi6ZnAI8hKl1kUx5IEh1BQ3uV3+Inrusj5E3UJV/EmZpiJyrq88ttmNySY
	nMht9rqKhjFOtldfUDkKF+TK3ycDLHXqEjDRCi2EX+47K0i4yDD5+TVkVaUa/eXpPJil8r8LgBb
	eIQuyTkH+hDGF/36LqYVfY22mJgBAOvNhW3xWRwBNxPdXeKsJMts4i6DGmVvVt/D0SjMyQ19wEl
	rP5/l2lQdIMl+KOeRUvCwztcNFqJxXl4pN/g4sFoemAlgx7k=
X-Received: by 2002:a05:6512:1286:b0:5a2:c0ab:b57f with SMTP id
 2adb3069b0e04-5aa7c065a33mr2052341e87.14.1780550602314; Wed, 03 Jun 2026
 22:23:22 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: K Jayatheerth <jayatheerthkulkarni2005@gmail.com>
Date: Thu, 4 Jun 2026 10:53:09 +0530
X-Gm-Features: AVHnY4JCvqOYV6tZ8vQSH_ByptBB_Gt_seJXwSWQfsLxqaWNpM45lTrikKXf0HM
Message-ID: <CA+rGoLee083Whzi3b9CP3Hxrq_cz58enN67ZQq5r0koczKeU1A@mail.gmail.com>
Subject: [GSoC] [Blog] week 1: Improving the new git repo command
To: GIT Mailing-list <git@vger.kernel.org>, Justin Tobler <jltobler@gmail.com>, 
	Lucas Seiki Oshiro <lucasseikioshiro@gmail.com>
Content-Type: text/plain; charset="UTF-8"

Hey everyone,

My Week 1 GSoC blog is live!
https://jayatheerth.com/blogs/gsoc/week-1-path-foundation

Feel free to give it a read and share any feedback ; )

Regards,
- K Jayatheerth
