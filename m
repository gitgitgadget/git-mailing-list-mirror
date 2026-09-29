Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 375E93CF97F
	for <git@vger.kernel.org>; Tue, 29 Sep 2026 11:26:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.227.169
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790681194; cv=pass; b=FaWZqXZk7VNHYcMnCzmswxnuZ+Xf9hSPIuR2hgtt29NVL6Z50hP8fVzZZE6L71QM2pkQhW3RDIXYUsIoqpIXr03eJmlDbLEyabumgUm2VWeN9Kckd8MUPP5mJgNN9qOJsBF81Er1ebzHNIp56Nq6sq9ww7by+QHas0J99YhhvMw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790681194; c=relaxed/simple;
	bh=EPU/O7ujAbBCuBEbfdtGtEDjGNZ+FIf8ohl06qnVZ54=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=BRlFnCXsBf4aE27FO7GbGcpGhiEes4ARdtxkZYs0iPoDJKzWtBO1ry1JYoEhHfP7AO4Qx+A+LFcla2aAi7G8paFKYbuikF4v704GqZnU6N4ULrrxxSXbL5BNsydgsC8qwd66eyb1udzqnSKmVmEnSzwU7W1sxMShCwQJTrkBG84=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=pdZfjAok; arc=pass smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdZfjAok"
Received: by mail-pj2-f41.google.com with SMTP id d9443c01a7336-2df9754484aso19898125ad.0
        for <git@vger.kernel.org>; Tue, 29 Sep 2026 04:26:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790681192; cv=none;
        d=google.com; s=arc-20260327;
        b=Ek8IsTe0S+vs/PvlLq1LW4kD+FcF4Nwo6umZ7ak8O8x4383ea4OcbEGpLHETsxUun6
         XvKNQzanb9xLcbPZPXaC2xE8knRex6CNH+sWXd+EwqknFCNqQ9SXW9frPeykSUeCAJBT
         EWvWEbOXp6cbXNxe0wKIhpnRNQbFHC6sPWQAZrmQlKFzm6P5u3bK2JRDrlcC6QUlpLcM
         tjrY5pJJ3Ofjups5TJcSY/ookHQ6Pp6wZu67UEpqz7WN82/okcCuKTwCNyLgew9Mak+h
         TUQLKuoltADB+Vt6Ht7yDHVug8L82miXOoDYqwHh1TnbYqPM0s0I6I51eArq/WUqM6p2
         FWJw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=TnIh6S0awq7YJGBHOiGPrDRrIyQ4CY6l3f05wsoR4MQ=;
        fh=Ox4D5aCb0Wm3NuWmIZhbrD5IUgm6JPtaEE6xbKungY4=;
        b=MgA6wx0FdJ2oCZA4zyNCkEbRfnoHUfsN8bUSeogcugY2SqL5yfbfUyugD0l9bq7FRH
         gKEQIzLQmMJU67PXJaLPTbwVhwcoVB+sjuOn7eiEqA3+X/6xWqLEHi4dPoYndP0xjeh2
         5YKnoa2As/iQUfHN66/WIgt+MIjCuNO7X4BN+cAiUMlTKwY1ByF1Zji6GSLVaZUXKVwb
         OqSuQIaY2bUjM7qxETSV37bcbb/+YjIdUGqE6YFIabPSrwwBtzW8ceRK+xEL8Fa5JVpb
         Ozf6C8LkyrvyMSNyqQp3N/+rmAu6vKyRYtv8Wxn0ibdKGwD+oAgR8labDkbI46gCASTX
         gNdg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790681192; x=1791285992; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=TnIh6S0awq7YJGBHOiGPrDRrIyQ4CY6l3f05wsoR4MQ=;
        b=pdZfjAokzKxlBRAYG6Awhfn7l0QPLOlc0eJCNwS29dKdxsLKnOPE9q0wChoJZAjQhF
         23sUTH5xCFhd2z6XhF54+4LQMF6RRgvZscLZqHFt748mL/ae4CAi5d0yp4qg93e5xx3Q
         AEokRPo036KkqBk94qWnzqEizCd0P/2x0xxXuS3EBAjzDIx/YGRjcbzwuGm7uT6LhMIK
         HvVbQy8YZrHgCE3yY7ABKEmrIGgmAIoIzPbwsKCZ05DUMnS215BFAvKGBWRlSAbJsrGx
         MoSlOkvigZ0M6daR1hBjGOgMEF9iW/ZKTggto1NEjuxGDXrrIHzfSEQqeRC/2cZ2N6dC
         Zv3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790681192; x=1791285992;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=TnIh6S0awq7YJGBHOiGPrDRrIyQ4CY6l3f05wsoR4MQ=;
        b=X6G7KQwKS2XiF5umA5LY8uFaAAg5z4xlajeN6RCKlA5VMOtz/jWFbuhZSQIW2O+VUs
         +C2JQaFZw1TbKih4RkMxyhrX1fsz4e3wHTzSIE2wwDk7nfmrChbHdxf8cmi05EsfFjiJ
         JG+zhKe+AkE0Cc35j4eou48XRNreF9CWNhRwqcfQVp3mVhLO6oMbZLiFpstmoDxQIU7U
         HsR+n0pDQ2R4oN21FSyUgwZPtn1HKaj427iEHkRcQ6HUsMHexuGRi4NLjXR5kEoPRjSC
         As+ZFyKp83oqlvc1NbkIboaPLgCv1kWpJ/zHofbwbX2+M+dYHC78NbNvF+yqiz26e5Nh
         7Yng==
X-Gm-Message-State: AFq9FYJbIG74ugi9AaWGbW0beMPKVMh0EEOSWpQugRaVQmFKPZfImyyb
	B4vuz8dJ+SkX/4uzZcChJG7i87dOQv1m9UiHYcwBlP7DXpUXolc7nY+I1IW/83zUjgiAt+iYVkB
	8gCfuEYN/6WIr2ajmlWU+xptrNh1ZnoB89U0oX4o=
X-Gm-Gg: AYBFou13GS3U632etfqlxIz0/YnazjCjFJ0lWwrx3vWytrhbJN9o4WktogEGWyUJtCi
	4KTNH+OBC/4i9bojh9/JMQgTJNwldTNuLzaSwP4vjP5Wx6UGurfk8vKIw0IWtvHsEXrNirgPzXk
	cl+oi2+AjlRXLhdo1pzO/e6F4W+3uQMURGQQ74tHeZ79GfdyMI4nIJbNdN+wObn8dYURFDvg3UJ
	PYuecfljhS6r75V//qMbCDql8BM/LWsp2MKHo/rkpMc3xwO6HxX3yasbG6NxV5TCOGNHe5d3wE7
	XDTavDJO0zv/4RJZoJN14SqtKfLGjLU0coaQ1GFbOltdvTuAWkAeH6YxwlQu9M/6ePkykrpzObW
	XdW4VRCEW+N4yqAbcWmbbCeSEl17drFYDU8KIK7Qq9s4V4alRE52w+2U6KWTZXU6WdtGO+9fhRQ
	==
X-Received: by 2002:a17:902:c404:b0:2dd:c0ff:e728 with SMTP id
 d9443c01a7336-2df7dfdda93mr123653765ad.58.1790681192451; Tue, 29 Sep 2026
 04:26:32 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
In-Reply-To: <pull.2425.git.git.1790667030497.gitgitgadget@gmail.com>
From: "D. Ben Knoble" <ben.knoble@gmail.com>
Date: Tue, 29 Sep 2026 07:26:20 -0400
X-Gm-Features: AclHuK_J6lW8b6cUS6knnc2Rqa5A45Qve1ukSbL8IRB83U1q84XyvFZ8stnqyM4
Message-ID: <CALnO6CBwWy3aafyDJPKFk5vuWy2EF1n1Oc=W7+RVAE3rxpXwiw@mail.gmail.com>
Subject: Re: [PATCH] branch: let --delete-merged find squash merged branches
To: Harald Nordgren via GitGitGadget <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org, Harald Nordgren <haraldnordgren@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Without looking too much further=E2=80=A6

On Tue, Sep 29, 2026 at 3:33=E2=80=AFAM Harald Nordgren via GitGitGadget
<gitgitgadget@gmail.com> wrote:
>
> From: Harald Nordgren <haraldnordgren@gmail.com>
>
> Branches merged on GitHub with "Squash and merge" or "Rebase and
> merge" are never deleted by "git branch --delete-merged". The upstream
> holds a rewritten copy of their work, so their tips are not reachable
> from it and they look unmerged forever.
>
> Treat such a branch as merged when some upstream commit since the fork
> point contains all of its changes, so that merging the branch into
> that commit would change nothing. Name that commit in the output so
> the user can see where the work went:
>
>     Deleted branch topic (was 1a2b3c4, landed as 9f8e7d6).
>
> The first upstream commit that contains the changes is used, so the
> branch is deleted even if upstream later reverted or reworked them.
> Nothing is lost, since that commit keeps them in the upstream history.
> A branch whose changes only partly landed is kept.
>
> Signed-off-by: Harald Nordgren <haraldnordgren@gmail.com>

=E2=80=A6in the rebase case, I would expect something like git-log's
--cherry-mark option (or really the algorithm behind it, git-cherry,
and git-range-diff) to be useful for identifying rebased branches. But
of course even rebase-merged branches can end up with minor
differences (say, a commit was made upstream before that branch was
rebased with an identical change; no conflict occurs, but the new
commit differs from the old by not having that change).

In the squash case, I suppose the best we can do is check that all our
changes were applied at some point between the merge-base and the tip.
There probably won't be any tree-same commits, though maybe a
(premature?) optimization can return early if the trees match exactly.

It looked like you don't distinguish the 2 cases in the code, and I
think that's reasonable: we wouldn't know a priori whether to check
for a rebased series or a squashed commit, so we'd have to run both
checks, and the latter presumably subsumes the former.

Anyway, I can see how this would all be fairly expensive---on one repo
I work in, git-range-diff can be somewhat slow depending on how many
commits are in the range, I think. I don't know if it's worth trying
to state that for folks, though? If we ever make improvements to
performance, we'd have to remember to remove the "this may be slow"
text.

> After the release of 2.56, I saw people liking the --delete-merged
>    feature, but asking for this. A lot of people, me included prefer
>    squash-merge and it currently doesn't work with --delete-merged.

Btw, I wonder if you can share where you saw this? 2.56 was released
so recently I'm (pleasantly) surprised there's already feedback on
this!

--=20
D. Ben Knoble
