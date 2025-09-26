Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6ED7E7404E
	for <git@vger.kernel.org>; Fri, 26 Sep 2025 08:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1758875635; cv=none; b=QSB4bIS1LBUAb/MTEr7IVCKkz7sddnbDfVXcRMtFieOTxIArB+OeHBI7pxjpmjXbnkNGo/P2F5RlWrsv3WSOO5GQDK9xLk+Ta5hHVWTMLv58A6CQ0DtHYVrXWwaYxlMm8mSK0F7ngPVfn2VUNz4IsEkVUtZwKpJMMa3LpAS61Tw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1758875635; c=relaxed/simple;
	bh=/4+j5rlSpMrYWidRdwmVhesnS7kusSCowR1MW4FZIkI=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=IbhxTbwV8LuWnegoF8vXRxin4UFZAQZQmHyyCa4ACJsdfwSohvH8FlMhLMQrrUey88Q56fqzLfgRv1C5CLk9KBUUfT+0ZLpCGM0Mj5GvnfvrYhG2DDK3rG2aCdvVnLfKGNmw5yxPBAWm0DAv4KR6OmQa9I/7hrmdl880J29CWuE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=L7/hFuoL; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="L7/hFuoL"
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-62faeed4371so2608602a12.1
        for <git@vger.kernel.org>; Fri, 26 Sep 2025 01:33:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1758875631; x=1759480431; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=/4+j5rlSpMrYWidRdwmVhesnS7kusSCowR1MW4FZIkI=;
        b=L7/hFuoL3JLlHarzVQH+5PmyzOsvr/TTMalkClgnPtbtKHyv4iDj8GXqp06EJ3G9Us
         qZRglvas0sMvttopwzZLT5HpQgSdFqSVCCk3PAg8kZ6MtVjr/sHaqkGHm9MEH+vsGFlF
         CgFTkEuLFxgCVRZUSACKqcU4Dgz7Myd2EVU2uWNnhJLDqtmzgBf9Fcim/GWzIOkTGOyS
         bEs+ghmtwd47r++i98nk7TKBHvWgJdc/a/Tgpt9f4S1RC0vc9slze7bdcKUg18oMFPHd
         FQdv/kPXI03WnS2vsCqdfinPxvqXGMyImIOqQEgOONKhD3XxDUDPrMih4vEDmse2F/NV
         pW8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1758875631; x=1759480431;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/4+j5rlSpMrYWidRdwmVhesnS7kusSCowR1MW4FZIkI=;
        b=xC8soZqRp4dJQsCSpIqkN7Fp14RcRli8iJAYYkBRpOmo47+eR4DoOJiudl11bUWWls
         SdmmO9gbhlF84o3zQukaw4gvisopwFZ0IwiEB3BsuSPcVtDsLTzNysrT/u66Geq8PGor
         n9W/8h1zUMfiNtxD8cRCCm9NLDIftePGpYL72k8p3ncMhEisejYSVNToeAjcBmHVyi2N
         gv8P3ukriFH7739ZJglQ4ogexYI7nS/o/d4pN9iWFlg8VpZsqqrw28mF0a1TwVePgYzw
         9czprfWh0gmEXsRUMJimjCNV1xQc8WIsUPuOSWkwZjavKqb86HvaR9i/E+9sZGf6q8Ec
         Bx6Q==
X-Gm-Message-State: AOJu0Yy9CI8b+Vn1KQvz2z0CefSwuYq3bEsE/hh/UNJygKQ0E6nq7wK6
	hCmqqJ9mWgLs1w/40evgKSL47svezjq8N9WUQSlj9NAeTZU7lAy6aaONulhe9zP+zRsB3C3rPzW
	wt1VdcLEj5QnWSyOyKg5QU3juNrg7vu24l08YET3xZA==
X-Gm-Gg: ASbGnct6jWj0l+r09EQmT+p4Hw72KQRS19VJPohhrgz3tV7zpOge4eRcD0CmFuwXbgc
	x1/HxwDb/K+izmZOQENDPBJneCqJEw4TXYH/x8Hbefhya6vhCVIx0yyAaAnGcNWmMp6POU4Cm1o
	oAewjKoeCkX2PhU+w4vp/arKlw9HAdH8ANZvH+HYyc/iDmjqmsdJQbWVOaYisjSHHPEJUgV6XJs
	xYU4fOhEvpHXOI+RCLbUBHh+H1l8ZgZrLDQ4hn7xTOlzVQbVXlaRj1joqDKAzsG3REPDQU=
X-Google-Smtp-Source: AGHT+IHg47qPQWHQa+tSLZA0gQ2xUW7vRxjCc0X5NAxvHUHKwwHNOS549PX3UNi7T0nv3jpIX69LzydFb+BIlHw4i88=
X-Received: by 2002:aa7:cf8f:0:b0:634:5705:5719 with SMTP id
 4fb4d7f45d1cf-6349f9cbc0cmr5070601a12.5.1758875630674; Fri, 26 Sep 2025
 01:33:50 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: George Ogden <george.ogden.human@gmail.com>
Date: Fri, 26 Sep 2025 10:33:14 +0200
X-Gm-Features: AS18NWAWkkW6qfFeycLFP6TsQUlHHENIu7Q-7yVqKUjh_nJ7YXYLhWNPHi7zsOQ
Message-ID: <CAJ5EAUw_VN4GXiHYJq0et8oZN0L+AHZz+ROLtK3Hxdp3SEL3=g@mail.gmail.com>
Subject: [Feature Request] Support for sharing root-level files across repositories
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello Git developers,

Firstly, apologies if this has already been discussed or if there is a
way to solve this problem that I am not aware of.

Motivation

Git submodules are very useful for sharing directories between
repositories. However, in some workflows, there is a need to share a
single file that must live in the repository root.

A concrete example is .pre-commit-config.yaml. I maintain a standard
template across many repositories. When I add a new hook or update a
version, I have to manually update the file in each repository. I
could use a submodule for this, but submodules always appear in a
subdirectory =E2=80=94 not at the root where tools expect this file.

The same issue arises with other configuration files that need to
reside at the top level of a project (linters, CI configs, licenses,
etc.).

Proposal

It would be helpful if Git provided a way to share a file across
repositories so that it appears at the root of the working tree,
without requiring a separate build step, symlink, or copy operation.

I understand there are alternative approaches (subtrees, packages,
external tooling), but they all involve extra indirection. Having
first-class support within Git for this use case would make it much
simpler and more consistent.

Thanks

Thank you for your work maintaining and evolving Git! I would greatly
appreciate any feedback on whether this idea has been considered
before, and if there are technical reasons it may not fit Git=E2=80=99s mod=
el.

Best regards,
George Ogden
