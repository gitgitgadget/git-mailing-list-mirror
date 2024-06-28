Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C84C74
	for <git@vger.kernel.org>; Fri, 28 Jun 2024 00:31:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719534691; cv=none; b=d2BomkG5/5BWebjmKSs7SRulk5AowMLgbCAhYRoCpeOyR37tPJEV8cWZdDNeTYBEC6i7F1BXh+VZhDOuh+C6qYZ9C81HuZgC/bYQWejxa0ZiNaAdG+f7Ilrdi4bokwRaC+vAcGXn1lMBmX8I5szj5mkYk2pjWaQikkDC47az3pU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719534691; c=relaxed/simple;
	bh=/AJXcc2zxBMG8NQAp4bSk/PXYtHwJhHx4V2S5n9wJdU=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=CH0L89ptAMphUidvU1lI0Jq7+k/f5juFkHZAKEyx7pMtuABZIYeIK9gRwYnvVKAA6J3lXDtk7V0AIu36IDkURi4RoSAfNKClxdjgExdV18PedjjdcbDQ11uOpJgPaANSgHIdHSVoorYd1Nw1sA0+VO0hCWQTVUZsqlemj4yF2bo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=UnZbnsH0; arc=none smtp.client-ip=209.85.166.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UnZbnsH0"
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-7f38da3800aso1267239f.0
        for <git@vger.kernel.org>; Thu, 27 Jun 2024 17:31:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719534689; x=1720139489; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+6BIfIQRTYGbv+8rraQ3J8kyoy2+pToz9wXh24WPzHg=;
        b=UnZbnsH0dfciKmiRG4VfGRWZHUh271cUzwz89UQXyyW4QKIxjmlFz+b27LbR+Hd5ZS
         K+hNQWF+apf8vlt5hF42aloWwr5hwRErLgRLCIK/Thg9lQtwQ1ln0gXeYlD8U/Y4FVOj
         Xge2kQaGjXLDPjHYX3FYHE6KOtznE7FHp4AjZCg4ONi/8bisgtnNv726NSwEJbeKaH05
         jDambywl/dhu2UueG6NNueysztpLfnrfrlzxSwGGFuYH55/tQO3ofquSP0qpBS/4Vxom
         1ptmNNGGnLCx2mP+Ts19WI21VKWIH7rFWA3EkNRZojC7QF6375HFsEM8/PRIGVnMQ7kW
         XTug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719534689; x=1720139489;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+6BIfIQRTYGbv+8rraQ3J8kyoy2+pToz9wXh24WPzHg=;
        b=Y6xAN+QTKASKKsEV4XVgVslgmNH2CTuUXnGbI4xClnANQxTrRmDRKkrxJ/5JfE802t
         XZFwCt1E1JJZBryfNl/cqArkN7mbQjCbyp1t7hVvEbLSCf1YDz5Boll0MTfVUaO/DkjU
         SGQxRGXIYuWDr1P/WYFa5n8iTlpDWoIJ39tU9L07yTQKFKHieiZ9/9kdcW0kWJNIH/PZ
         uUlx9xXOakpwwdi6BWEZlRpQozkWLbYiYFH+8vRooEtf4ytFcSOaiMVrVErZ2Nq8pS60
         iepnxOQzRRoemJPkPmKYM/ZdPIeizu2/IEw8Y/Vp7MHEPQfZ+G2LiY6KXfLmL8Rm9guv
         tRvw==
X-Gm-Message-State: AOJu0Yw5EXPXQ7nZNmViN5xHh3fxG3qbBEHvVv++lLvM6RsIpI9va9+2
	9FGDV6gwcgqQ4kbvesRXvqPG+E/YIjPDd2q0orlbRuGtztnmwoOyzbz9VLoVSN+66Flo7o+NhYk
	0uzqgmo2m1d9vWWQqqjimDwUXKuY=
X-Google-Smtp-Source: AGHT+IEjHBbqs+aNxFhHs/0TlSpRznjcPiYiQ0BaHeLR9CSzbmVbtlgEKYQN86klJgDben5bbsLRedkbU3nmOrwLgik=
X-Received: by 2002:a6b:4a0a:0:b0:7f6:1e6b:e8db with SMTP id
 ca18e2360f4ac-7f61e6befaamr55495239f.18.1719534689249; Thu, 27 Jun 2024
 17:31:29 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1754.git.1718899877.gitgitgadget@gmail.com>
 <pull.1754.v2.git.1719412192.gitgitgadget@gmail.com> <93d0baed0b0f435e5656cef04cf103b5e2e0f41a.1719412192.git.gitgitgadget@gmail.com>
In-Reply-To: <93d0baed0b0f435e5656cef04cf103b5e2e0f41a.1719412192.git.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Thu, 27 Jun 2024 17:31:18 -0700
Message-ID: <CABPp-BFzxOjGto+1GGk1xq3XX7OQ3mmmRYm0zU+2mCYZ6h_OfQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/5] sparse-checkout: refactor skip worktree retry logic
To: Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, gitster@pobox.com, anh@canva.com, 
	Derrick Stolee <stolee@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Jun 26, 2024 at 7:29=E2=80=AFAM Derrick Stolee via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Derrick Stolee <stolee@gmail.com>
>
[...]
> If users are having trouble with the performance of this operation and
> don't care about paths outside of the sparse-checkout, they can disable
> them using the sparse.expectFilesOutsideOfPatterns config option
> introduced in ecc7c8841d (repo_read_index: add config to expect files
> outside sparse patterns, 2022-02-25).

So, I had some heartburn with this paragraph when reading v1, but
decided to focus on other stuff.  But it still really bugs me while
reading v2.  So...

The purpose for the sparse.expectFilesOutsideOfPatterns option is very
specifically for the virtual-filesystem usecase (Google, specifically)
where sparse files aren't meant to stay sparse but be brought to life
the instant they are accessed (via a specialized filesystem and kernel
modules and whatnot).  Using it for any other reason, such as a
workaround for performance issues here, seems risky to me and I don't
like seeing it suggested.  The "if users...don't care about paths
outside of the sparse-checkout" really doesn't do it justice.  See the
"User-facing issues" section of
https://lore.kernel.org/git/b263cc75b7d4f426fb051d2cae5ae0fabeebb9c9.164209=
2230.git.gitgitgadget@gmail.com/;
we're foisting all those bugs back on users if they don't have such a
specialized filesystem and turn this knob on.  And then we'll get many
bug reports that are close to impossible to track down, and virtually
impossible to fix even if we do track it down.  I had for a while
suggested numerous fixes we needed in order to make
SKIP_WORKTREE-but-actually-present files work better, which required
fixes all over the codebase and which was serving as an impediment
e.g. to Victoria's desired sparse-index changes.  We gave up on those
other efforts long ago in favor of this much cleaner and simpler
solution of just clearing the SKIP_WORKTREE bit if the file wasn't
missing.

Further, I've seen people read git.git commit messages on Stack
Overflow and make suggestions based off them, so I'm a bit worried
this paragraph as worded will end up causing active harm, when I think
it's original intent was merely to provide full context around the
history of the clear_skip_worktree_from_present_files_sparse()
function.  While this bit of information is part of the history of
this function, I'm not sure it's really all that relevant to your
series.

Could we omit this paragraph, or if you want to keep it, reword it in
some way that doesn't make it look like some tradeoff that isn't that
big of a deal for non-specialized-vfs users?
