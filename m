Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com [209.85.208.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E4551E907D
	for <git@vger.kernel.org>; Tue, 15 Oct 2024 10:59:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728989999; cv=none; b=UZV6uXB2Fvm2Y4ecQ69OeO/eVriXf/HUkXWGFkwwy9Vx1YbYVu8dYCNg6Pb4tj2Jryvgx39EABx0TpsOaYRpf5AUhU1tlmIOps02yAAYHKpLb5vye2yYD0DqZ3vHXqwDy9yC2nQvGeMDHX9XeqgN5r49sXn02Rtz8EALGNzySm4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728989999; c=relaxed/simple;
	bh=GJXiYHqq5/AWqL+eXnKnxlc8aufidyzT6DJrwr7XVnw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=T+DkrDKXLaPXJViI+iG9MJa3J7gIFf6I5CC1rMvq/Z/AVxWKt3i5L41dxOImFVK9gOS7y+/dbtAUpo8pJR5BdC7uL3+tq7z8Lg0GVSmXXJQt0Pgju/ALmqkgebyhn4B2/aLZJ9dM3Fz/SmslC1gjlXMV+1AEfBxgb0nQ186A5i0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=FBKQ2Lq8; arc=none smtp.client-ip=209.85.208.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FBKQ2Lq8"
Received: by mail-ed1-f52.google.com with SMTP id 4fb4d7f45d1cf-5c973697b52so2998587a12.0
        for <git@vger.kernel.org>; Tue, 15 Oct 2024 03:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1728989996; x=1729594796; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GJXiYHqq5/AWqL+eXnKnxlc8aufidyzT6DJrwr7XVnw=;
        b=FBKQ2Lq8G8zwB18OWIkb6n4+CKxD8QOmJEnHee4HQuXVwN4MF11KM/mgO7wGDD3GD6
         klMsPVB9322RzMn36D08b/kP3hZIxE6U3EOI5KHQ+gqgKxRxFTblEjlpJt3RPvryziE9
         vkAoCbg9ySJRR4f0gFiU186kSCSZ5M423ybWokr55lWyg3o4gxHup4o9hgUrbmcwBSL7
         TW0o/H3k1LPPfBEVfXZnBmkO3af1OmYFTAUXhWSSLgNifk1MmlD2EBgg/PYQm1kKQfI1
         IMxguPqNzScHrKZ6P2q8XDhjedTpoTZlfQGjYcysMmyYA3cyXehgy5mje4HfILLMX806
         wPjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728989996; x=1729594796;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GJXiYHqq5/AWqL+eXnKnxlc8aufidyzT6DJrwr7XVnw=;
        b=Hy0Ji85EVaDvqbg7ig0/8D+YkechkueXRs4EyDnCckgUfwuaJJUSPewFHjITq8NxU6
         NBGytuNTGwhDdpbtH/gM3sMaE7wQY5h8LP0ip+DndFcSPNJMFyNLs3LYsRHG2Hd/E7ss
         Oli6kPhjByBNoYO5z1UT88aqbomaS5G319gIq7LpBni6QApMj/tN9jFLBt4Vy3/pxkto
         K6XfnVOn0sNqehKsy4M9jtmlDwEp6pYeWajAH0ZuPBKP5WqK5xTvLLPvLpEwfnyr6mC2
         aS+d343/KuP3rSFtT0/PUUYmRWX6eF+JbyvviSOF5xoAL8FwD6ecQY/c+gRJsZv+cRGk
         sayw==
X-Gm-Message-State: AOJu0Yw3u2CU5iEtQ77f79NmaK/8v9X9WKkh1weeWNtnU2nT8AgTdxn7
	LFi49dROyZ4EeWXziGepYvTUPYkBODro1fo84ivt50cE4E/od6I1r2syEeBrofEwKVh0K9GF9hq
	3hri1ug8Ui2y5HPt09JBggpQmgUnBujkts1c=
X-Google-Smtp-Source: AGHT+IHuwC62y/eHOj6v27qNyKHn9oC4U7c0leTmqm2gPUIqm2j0Ut9CiRV9vN6dAzATef1EQl+qDqwUujG+3d35sEk=
X-Received: by 2002:a17:907:3f15:b0:a9a:76d:e86c with SMTP id
 a640c23a62f3a-a9a076dec5dmr707160766b.49.1728989995972; Tue, 15 Oct 2024
 03:59:55 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Prince Roshan <princekrroshan01@gmail.com>
Date: Tue, 15 Oct 2024 16:29:44 +0530
Message-ID: <CAP3G6frW_B2pBN0S4H5fsJZgoGtPxC1+_dAzNRhQ9z8ERWZSVg@mail.gmail.com>
Subject: Feature Proposal: Adding Command for Configuration Diff Between Commits
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Git Community,

I wanted to propose a new feature for Git that I believe would be
beneficial for repository maintainers and developers alike. What do
you think of adding a command like git config diff commit1 commit2 to
show the configuration differences between two commits?

This command could display differences in repository configurations
(such as .git/config or submodule configuration) across two specific
commits. I see this being particularly useful in scenarios like:

When a submodule is added or updated between two commits, helping to
easily track and compare the submodule's configuration changes.
Identifying configuration changes (e.g., repository settings) made
between different commits without having to manually examine each
commit=E2=80=99s changes.
Comparing various configuration-related changes in large repositories.

For example, when managing repositories with submodules, this feature
could quickly highlight differences in submodule references, paths, or
URLs, saving time and providing better traceability.

I believe adding such functionality would enhance Git's usability in
managing complex repository structures and configurations.

Looking forward to hearing your feedback and thoughts on this proposal.

Best regards,
Prince Roshan
princekrroshan01@gmail.com
