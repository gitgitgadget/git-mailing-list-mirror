Received: from mail-wr1-f43.google.com (mail-wr1-f43.google.com [209.85.221.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60AD41C2AE
	for <git@vger.kernel.org>; Mon,  5 Feb 2024 23:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707177240; cv=none; b=rluYQsxftgSpDjptaOtlaYpc1VcuBgAylvKWHmCKH+OMvm/Hu3xmQXepoyA8lxQxOZh+VX5WvdLG0LF+uVfacmidDGrlwQJJzMOrVWDiBYSNgCmjla67ILK7f3oexaJq5LrPJpeQDVInKLagXGtdA9LBsKx6g8+Lj6xXR2LR6qs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707177240; c=relaxed/simple;
	bh=a1D1PlI0Lcj+SW7c3J/NsmBBUbeJ5W7xLlv+FZ08e4w=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ox0I6WQU8cZCIbRBuSvPAzPONbYwknL6xzp+udxHRbwFSqvMtQeQCIgcdR4Rfpl2KtRrZyYRym7nUV43p5TprrN5z63NSw1Z0GxnOqkB5/81nPzuB78Cwgf96iR7RUuVuZvkd0NtVtZkMR7BJW9xyMDdbw/YgNgMcyZqWmJgslg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=U08O1Abd; arc=none smtp.client-ip=209.85.221.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="U08O1Abd"
Received: by mail-wr1-f43.google.com with SMTP id ffacd0b85a97d-33aeb088324so3710383f8f.2
        for <git@vger.kernel.org>; Mon, 05 Feb 2024 15:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707177228; x=1707782028; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cBAE3CBj4Aneo/OZ1I0TPZuNKlXNHAltpjOoz4vNpv0=;
        b=U08O1AbdSJqk6VACjdyKSPNWi/xKQuzJnsMLEgdDNbxCQ4VHFALmj1ewCWcgH/Uuvk
         JppqmwfJgMEaKNI5RmmyZ7ZkTEaLoTyJQ5hq1glvW+moG87edrsUVmr4Nl0m1dbeienI
         /8XXIt79mY1kG5BKA01uUKMbYBqgosi4JQa4tigIC2Tk7n3shDIB3WHJ36hvHNDnRVAJ
         XTdnbjc1XK29tPfKrntViySWr3u7jhZw5nccnmE1fapPUqWhqK2Zza+0FcJhEVACp9tV
         ZMi9u3TIM2L6CcIMNt9Iuvp3FWrhdaKXLAPzM9qtFwb4BUSYwYVje0wpU6RMwiwStLPa
         8hTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707177228; x=1707782028;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=cBAE3CBj4Aneo/OZ1I0TPZuNKlXNHAltpjOoz4vNpv0=;
        b=aRT10czxs3+5MpsQPp9KWYJnPnBTWuVxzIHtx7sx5RRnE3m6lRwcu/y8Wc73wDSHD0
         LIzLu4BfXYASfVc89aRDjlxHiwTSr4ncyDFeFmayigv8VtYq32TdEYIEye/zJkJHzb3Q
         ALRtbJryuNWbZBHnxJVTAFCfEKN5q4RNMc1RGj4xKkLi4zLrjV7Ii/s1RGUR6M+CMcSD
         YxxeeNIW/mNNUSOfEGQYrfWhdXS4ZwCohoarPIYDai06INkMpGmAzMwJLbucG6kwfcFD
         1+6n+2KdaMRD+cI3Z6/8PT5BwuJh1NLHkWTy/WR+NuMfx/4LbzmzYArUFjLGX4FkWOOR
         fKNQ==
X-Gm-Message-State: AOJu0YwaIcBVv93Ui8CkpX2vkF40t7qzeNA9mSvl/NwYj+ALdcY/RThK
	vHbQGZZWoMDcI1PQ/gfnarvE+F/KzzL9+Y8AzDWwpWGTieKy4snqquDokcmKTAicJ4wpLazfQNU
	MiPoCrSi80PEbv+Xa7mP0ydRSdGjsNUGeQeeOn6Cii9ONtiSoxw==
X-Google-Smtp-Source: AGHT+IFSGZ0J9xFJRsMvD5DzLpWfFUaKRqF1IlUTTAH3kqOMo6hVpIHykNaDd6HNydr3HgSOx7YAspIQHkA1Lm3x63c=
X-Received: by 2002:a5d:6ac5:0:b0:33b:28:1084 with SMTP id u5-20020a5d6ac5000000b0033b00281084mr37944wrw.33.1707177227744;
 Mon, 05 Feb 2024 15:53:47 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <e2eb777bca8ffeec42bdd684837d28dd52cfc9c3.1707136999.git.dsimic@manjaro.org>
In-Reply-To: <e2eb777bca8ffeec42bdd684837d28dd52cfc9c3.1707136999.git.dsimic@manjaro.org>
From: Kyle Lippincott <spectral@google.com>
Date: Mon, 5 Feb 2024 15:53:31 -0800
Message-ID: <CAO_smViHVZRObZjg0tEPXezJZb7wvs9LQdHUFJQTK4-ASCfrmw@mail.gmail.com>
Subject: Re: [PATCH] branch: clarify <oldbranch> and <newbranch> terms further
To: Dragan Simic <dsimic@manjaro.org>
Cc: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 5, 2024 at 4:45=E2=80=AFAM Dragan Simic <dsimic@manjaro.org> wr=
ote:
>
> Clarify further the uses for <oldbranch> and describe the additional use
> for <newbranch>.  Mentioning both renaming and copying in these places mi=
ght
> seem a bit redundant, but it should actually make understanding these ter=
ms
> easier to the readers of the git-branch(1) man page.
>
> Signed-off-by: Dragan Simic <dsimic@manjaro.org>
> ---
>  Documentation/git-branch.txt | 10 ++++++----
>  1 file changed, 6 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-branch.txt b/Documentation/git-branch.txt
> index 0b0844293235..7392c2f0797d 100644
> --- a/Documentation/git-branch.txt
> +++ b/Documentation/git-branch.txt
> @@ -312,12 +312,14 @@ superproject's "origin/main", but tracks the submod=
ule's "origin/main".
>         option is omitted, the current HEAD will be used instead.
>
>  <oldbranch>::
> -       The name of an existing branch.  If this option is omitted,
> -       the name of the current branch will be used instead.
> +       The name of an existing branch to be renamed or copied.
> +       If this option is omitted, the name of the current branch
> +       will be used instead.
>
>  <newbranch>::
> -       The new name for an existing branch. The same restrictions as for
> -       <branchname> apply.
> +       The new name for an existing branch, when renaming a branch,
> +       or the name for a new branch, when copying a branch.  The same
> +       naming restrictions apply as for <branchname>.

The precision here makes me worry that I'm potentially missing
something when reading this, and has made me re-read it multiple times
to try to figure out what it is.

I think this would be cleaner:

The name to give the branch created by the rename or copy operation.
The operation fails if <newbranch> already exists, use --force to ignore
this error. The same naming restrictions apply as for <branchname>.

I'm not super pleased with that second sentence, and maybe we
shouldn't include it here. Maybe it belongs on the documentation for
--move and --copy instead? It's sort of mentioned in the text at the
top describing the -m/-M and -c/-C options, though it's not clear from
that text what actually happens to the existing copy of <newbranch> if
one uses --force. If we could include a better description of what
happens to the existing branch when one uses --force, that'd be nice.

>
>  --sort=3D<key>::
>         Sort based on the key given. Prefix `-` to sort in descending
>
