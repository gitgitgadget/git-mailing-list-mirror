Received: from mail-io1-f47.google.com (mail-io1-f47.google.com [209.85.166.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD44C26E648
	for <git@vger.kernel.org>; Tue, 18 Feb 2025 16:47:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1739897224; cv=none; b=je24KH/JyQIfnE579vDGyhbmSSoSka+L8uZEggL6XLZOryRwvdX2iq8YiRLQrPGM6edQgyRGgfOpKIBVHB7FObW1HVzF9CeXivExFNhqSODBpam54sm/8TYkjYCrBqF2ql3Mqh2BiqqCkqQWE2ssvYRq9KYBQCjBd5fsI4EODHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1739897224; c=relaxed/simple;
	bh=7B6huKVgFd1eDXMIUnyV3D8NG/24bTjsGtLP6GaEL5A=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=YKU+HBbhRzfSjJYVdHftQu4zsGkPSRL9YrzKPmp6AwAc7E0XTw3JgGQBwq35VEgNvg0InC2tHAk/wGkpvcEXTf4KdnQvB8GK4+/O58COKo/gzTksGsj503DobD9GnxhXhu9CGtk7nK6dTmIQkaMPl3Jk90fnRQNTYPrI22D/gGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=CTNw/nSW; arc=none smtp.client-ip=209.85.166.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="CTNw/nSW"
Received: by mail-io1-f47.google.com with SMTP id ca18e2360f4ac-8553e7d9459so144926139f.2
        for <git@vger.kernel.org>; Tue, 18 Feb 2025 08:47:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1739897222; x=1740502022; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBmrRmar+2TM81P0M35U0RmuvgAbiLNqK3IQBhK9kQ4=;
        b=CTNw/nSWz9NCFKJfRCnIkCgeG4hIGotojduU+20BhtxY2XZ7+U1JH93lO1gJUvCh3y
         tbXjW2kMamNOTadvT9vS284bF2vnpMuQBtsyz8mPR6vZ5jNOgHT/BIZyKC+rmIIpF5ci
         nqY+MnoZEzVPWPLfiivxaU5Y4Jl9TbavMviqLxXqC9m5DLjOlwjnjX7rBo0xL2ReSiN2
         2rukYm7yaDXqUEERQSLJcbSrAATdqBS4Ca6VaghDxqWLrlEQclJPY/eDNPCVRhhQid07
         cK9bKE+/dp8CidQgppIxmru70Po5CI6J8QEfVyyNqyIhutBpxebfXLbqCSwFnKrR9B1b
         561A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1739897222; x=1740502022;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=IBmrRmar+2TM81P0M35U0RmuvgAbiLNqK3IQBhK9kQ4=;
        b=VXz4KuPCt0pT+bBMP6PJx0s3cxr/ySkWLQnqKL21zYFOCaXjubDIl4ALxEkMxj5hja
         vUtjykbgotk50GIA1uBiS7RBGxWis5rDknVu3Zy+bzius7xxRiOXA6OztUQ6qNIQf6Na
         0kQ1y8UDQ8b8YbDSKV4gyHw4uh1fqs08OOfs2fCRHNkDJwO25moTKrUlVcCSYV+VsmLO
         KAODoj2AE70tM/eQdWhSSL7iCLBpb6C5XWMWTVg2llQ5uizL/rWHzsF2Tdw3vVmLnJmK
         wLfcezZb6BbXh1Tt02dIvERo9R4ZT5TiNep3sSWcnzHOBBEaQheKjNKolBDK8G+zcy5z
         hBLw==
X-Gm-Message-State: AOJu0YybiMWCOsNJKY6uAjulCke/hrkydkN6KAZfHLHd5WdUI7AkjHy9
	XqQwSgBJxdA+yYU6eiO8cFoJ0kPK3AStA8dtTjqZYWg7VwDrPKjcQuK2INqYlt92o1UrVDlroEo
	njWZFxsRCEa/bI4bMg9RsOAKdCuSgkg==
X-Gm-Gg: ASbGncsmceMMywpszSJoYP/Fi1wBbfErqPTgHMSqcl0tBlimLSsVDTjul6/stq9SMB7
	fXTntCrlRwNinfBsMRxv6AohinPt9e72PzzrhGBUR5Wzd5fRQUdAJlY29SH6zxCEv9uJV+FE+rL
	AYD3cJzKSBrf6qSMQ4WqdpRmHCiiLd2Q==
X-Google-Smtp-Source: AGHT+IH+sQGnPV7JYPARJzSSPLbKYiCaNI2Rtsj50tCBaJnGxelUToPBoXsTPecm9cE/BBxL05u6mpOc+wsmMEKAXUo=
X-Received: by 2002:a05:6602:6d16:b0:855:a283:8231 with SMTP id
 ca18e2360f4ac-855b396aaa5mr11701639f.1.1739897221916; Tue, 18 Feb 2025
 08:47:01 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1862.git.1739723829.gitgitgadget@gmail.com> <pull.1862.v2.git.1739895879.gitgitgadget@gmail.com>
In-Reply-To: <pull.1862.v2.git.1739895879.gitgitgadget@gmail.com>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 18 Feb 2025 08:46:50 -0800
X-Gm-Features: AWEUYZloDbkfDSHrDAKkg4n7KtDSzyaT1E17AQ5k9xq9eO6vK-DzRKCF369jj8E
Message-ID: <CABPp-BE3NtP463P4R+stzcQ_MufjobL-CX-rB=0m5gC0DzA9ww@mail.gmail.com>
Subject: Re: [PATCH v2 0/5] merge-tree --stdin: flush stdout
To: Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Phillip Wood <phillip.wood123@gmail.com>, 
	Phillip Wood <phillip.wood@dunelm.org.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Feb 18, 2025 at 8:24=E2=80=AFAM Phillip Wood via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> Thanks to Elijah for his comments on V1. I've updated the commit message =
of
> patch 2 as he suggested. The rest of the patches are unchanged.
>
> V1 Cover Letter:
>
> I tried to squash some fixup commits with "git merge-tree --stdin" and fo=
und
> that my script deadlocked because the output of "git merge-tree" is not
> flushed after each merge. The first patch fixes that and the rest are
> cleanups I noticed while reading the code and documentation. This series =
is
> based on maint.
>
> Phillip Wood (5):
>   merge-tree --stdin: flush stdout to avoid deadlock
>   merge-tree: remove redundant code
>   merge-tree: only use basic merge config
>   merge-tree: improve docs for --stdin
>   merge-tree: fix link formatting in html docs
>
>  Documentation/git-merge-tree.txt | 11 ++++++++---
>  builtin/merge-tree.c             | 11 +++++------
>  2 files changed, 13 insertions(+), 9 deletions(-)
>
>
> base-commit: f93ff170b93a1782659637824b25923245ac9dd1
> Published-As: https://github.com/gitgitgadget/git/releases/tag/pr-1862%2F=
phillipwood%2Fmerge-tree-flush-v2
> Fetch-It-Via: git fetch https://github.com/gitgitgadget/git pr-1862/phill=
ipwood/merge-tree-flush-v2
> Pull-Request: https://github.com/gitgitgadget/git/pull/1862
>
> Range-diff vs v1:
>
>  1:  3b317978509 =3D 1:  3b317978509 merge-tree --stdin: flush stdout to =
avoid deadlock
>  2:  16fec87766f ! 2:  63b09dbe1b7 merge-tree: remove redundant code
>      @@ Commit message
>
>           real_merge() only ever returns "0" or "1" as it dies if the mer=
ge status
>           is less than zero. Therefore the check for "result < 0" is redu=
ndant and
>      -    the result variable is not needed.
>      +    the result variable is not needed. The return value of real_mer=
ge() is
>      +    ignored because exit status of "git merge-tree --stdin" is "0" =
for both
>      +    successful and conflicted merges (the status of each merge is w=
ritten to
>      +    stdout). The return type of real_merge() is not changed as it i=
s used
>      +    for the program's exit status when "--stdin" is not given.
>
>           Signed-off-by: Phillip Wood <phillip.wood@dunelm.org.uk>
>
>  3:  bf1dc603a15 =3D 3:  f95a15a4203 merge-tree: only use basic merge con=
fig
>  4:  4c416850634 =3D 4:  1645b0e747e merge-tree: improve docs for --stdin
>  5:  89722894c87 =3D 5:  a0179820092 merge-tree: fix link formatting in h=
tml docs

This round looks good to me; thanks.
