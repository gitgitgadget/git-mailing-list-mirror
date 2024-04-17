Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC08316FF30
	for <git@vger.kernel.org>; Wed, 17 Apr 2024 16:32:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713371568; cv=none; b=K1/oIUdFnyIpQWATbNAwjG4rGtZirosvtVIIUDjAMfKq9tb1K3UH67PuG0b0ggmU3/SrGnNFkmsd6k89zrON0lozV0zFnUIeZqjasuSf4+yO7F6o5ZQwG5KYWwYEQiTjtMOgn+wYS254ObSQZSGmxbzeAjpaxFYT+ts2G2VaHtQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713371568; c=relaxed/simple;
	bh=LGAQOQwxqd/nz45qQ33WWY9WpYKE4pRRmAkX6OxV5yo=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=qzxlG8MhklbzjVo/KqQDJyIa4k2mTJ5oX+BqDjlm5XjsTuU36QOTZnmY956dxWgJ7KhzQV13dE0jb0KP0PrKOS2YJ+yFLWo6YH1pLK8i7vr4c26lDfWZHXETtk1Np2DN2F3L/gdTt+ak8k3MoXy/X64WyysB2G7JzRj0SVestPo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--emrass.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=zvQcqLKS; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--emrass.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="zvQcqLKS"
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-ddaf2f115f2so8314968276.3
        for <git@vger.kernel.org>; Wed, 17 Apr 2024 09:32:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1713371566; x=1713976366; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=LGAQOQwxqd/nz45qQ33WWY9WpYKE4pRRmAkX6OxV5yo=;
        b=zvQcqLKSYmrkO3/G+XXSxIWdswaGVqRk10edrrRlbSCJHdiRzKKqVKa3YxB1CsnPYG
         yvymPcv/GxGKfR6nHDWy+s1kqZxk5gvyS1t6U5POOygZmFTPraYZJ0WE7TnPxF9gSVDc
         zIITdQEMxxFbfAkbBeyaihiJCwmVSS0zP4YC0Jkzv2yKgACcvodqenBPuGPfNPgaWWTc
         cCdaojOtcUhGg3+iyxlNUNNhvdHLA2sLyG/6hh+0/ML0lex1aP7lRsEscKUr07TnPJ00
         rSKpgU8IlooCPCiUwXUv1u/8HQkfatfxWTixU/vJZipyF6z50n2llsG9aNypWPYOgjC4
         9XKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1713371566; x=1713976366;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LGAQOQwxqd/nz45qQ33WWY9WpYKE4pRRmAkX6OxV5yo=;
        b=gM3h5vb1xY84+tbH1gZhenchMk8yRx9STqfR/DSWCZg3yoN5Q8O3o0hDG7z5iaTp3F
         i9R1MYrn13xrHtn+lJjgsXxpc41HVrI2ACJKeGKPzgNmpTFHX1CfZl4Vp0yHGcH2YV/9
         PH4t5mM+cLS3sIsFFrL24MZlychOp+m5gvW7zagUYztJw4hPwu5zqLxvP5te6aeIXaUI
         m9A2mtX9rH/eogRCauBkP9LWpCowY2XeYLW/LJYzqoSqER/HiqiLVk+IYMEiC2m3gBAG
         /4ELA1NP4G4FF6pQK48BhRcl/b+EBHT/8aF0WNCVSzhpleIzSQ4/5yrsu/8JeobYqchm
         F9WQ==
X-Forwarded-Encrypted: i=1; AJvYcCVcfOn15tM0LiWUVlFwUDzhT1VOCyv7aGYV2DBbuji8+8PaVd+mg5Hf6/g2cGmi1y5mRKY/9eraxiz+eEa3SCMKSEty
X-Gm-Message-State: AOJu0YzOTOsVYIpt4WnVGexvZ399HnmWoObqht0eTgO4jIQl+cScMEs6
	OTyJ01QOXQTKV+HYM04Mz9skxfxKC6vCu8pNcnPd7xwUrCyACM0eyIqBec6Yw+i4XQH9eSfrBUK
	XVg==
X-Google-Smtp-Source: AGHT+IG/AIGK2Yyksor6IsX7ioFguguiU4j84CcVGCq7Ch/fspt3Kvsh/7/ZuyDvvUH9h8hJFp9cWXtODK8=
X-Received: from emrass-cog.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:1f8])
 (user=emrass job=sendgmr) by 2002:a25:5f01:0:b0:dce:5218:c89b with SMTP id
 t1-20020a255f01000000b00dce5218c89bmr1207642ybb.5.1713371565739; Wed, 17 Apr
 2024 09:32:45 -0700 (PDT)
Date: Wed, 17 Apr 2024 16:32:44 +0000
In-Reply-To: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <b2ef74c1b0c7482fa880a1519fd6ea1032df7789.1713222673.git.steadmon@google.com>
X-Mailer: git-send-email 2.44.0.683.g7961c838ac-goog
Message-ID: <20240417163244.651791-1-emrass@google.com>
Subject: Re: [RFC PATCH] doc: describe the project's decision-making process
From: Enrico Mrass <emrass@google.com>
To: steadmon@google.com
Cc: avarab@gmail.com, christian.couder@gmail.com, git@vger.kernel.org, 
	gitster@pobox.com, me@ttaylorr.com
Content-Type: text/plain; charset="UTF-8"

Josh Steadmon <steadmon@google.com> writes:

> Document these norms so that newcomers to the project can learn what to
> expect.

As a newcomer (first reply to the list), I highly appreciate the effort. Thank you!

> +After a suitable period of time has passed, the maintainer will judge whether or
> +not consensus has been reached. If so, the consensus decision will be
> +implemented. Otherwise, discussion may continue, or the proposal may be
> +abandoned.

I'd be curious to learn about norms or practices applied when no consensus
could be reached. It seems worth elaborating on that as part of documenting the
decision-making process.

> making bigger-picture decisions (above and beyond individual patches and
> patch series)

I understand how bigger-picture decisions (complex, larger scale architectural
decisions, often involving multiple components, likely requiring a design
discussion / review) are different from individual patches. However, nothing
in the current description strikes me as specific to these larger-scale
decisions. Are there norms / practices that specifically address challenges
around large-scale changes that are worth documenting here, like encouraging
a design for discussion in the first place?
