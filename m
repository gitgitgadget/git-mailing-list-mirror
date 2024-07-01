Received: from mail-yw1-f179.google.com (mail-yw1-f179.google.com [209.85.128.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C36A9133987
	for <git@vger.kernel.org>; Mon,  1 Jul 2024 22:26:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719872797; cv=none; b=Yi/HCald5UgDZXb0Vlvs9VX3g6MCGWqRLXWkAWoi6bbWhvTvN11zQb1HHo9poG3DO5OLdjQ84lVBz48wHPduc8FO/KmHLwB7kZLJ2SO1OcC6Rguy+dH2disKU8LWZ/F2q40j4lgeiy6VYyQ1m6sdMMnk2Mkue27lIwdO0yuPyug=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719872797; c=relaxed/simple;
	bh=vs0OQz+idCQQDqE/cG4ahIHwyJyWeeM0kF8B2Oyl7/8=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=PXDAdqpvVZmphlbavbWW4F3F2B0Xbhum7EsmsyjEN8S1STsdW+Fnt5US2Nr+ph4SOglTqDmY0TpqQ0wVthzqZG2DFKxg6llGl1sxZ6R+TYHtGzVnUeB4C7ZqTcGyHNq4ZYRNhbHkeJRobTEKfvr8nJ0+kPir27jhdPdFGXonr9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KkZV36qA; arc=none smtp.client-ip=209.85.128.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KkZV36qA"
Received: by mail-yw1-f179.google.com with SMTP id 00721157ae682-64b5617ba47so28341437b3.3
        for <git@vger.kernel.org>; Mon, 01 Jul 2024 15:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1719872795; x=1720477595; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fOxxX49QFnrwpun1DUTLoVrJWTCAUeN4kwJfsyoRhy8=;
        b=KkZV36qA4NK8/Piv791BFC2MNpzkURE7tDNJBFNmGhTEm3nqyAr4zIAadUk6J70lOh
         UWuIgt86e0+8ek9jZofyPmmKpKlDrATVS5wm61VwmKtKscd3dpuDAXI01LIKWWwllVf3
         ewzGaVfXOS4Vaa0UGYVUBUGWWmTU3nFJJOL9/Q8OAoZvDw6dVqI8BIToO8nPMmt3fiVL
         097H7wzQSiRcbIfwvflCPWBGl/YJ+7i32y3G6WYvY3UEN50JrNMYHnTVZeE8a52GEXh2
         dOorWwotkQquuJBclrS29pWa7w5FGn5T9+YTn1scr0ue1VUeA7n3ErG7TNwqgHBeENfn
         F18g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1719872795; x=1720477595;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=fOxxX49QFnrwpun1DUTLoVrJWTCAUeN4kwJfsyoRhy8=;
        b=XQDX66NDH6yql3VcMHjqQSEJVKG6p7MDh9PEXMGdmI/1iTatcghVVIIMUXqkm5cMV1
         uWuKcxDJISeIYYNwx6F7wUKFXkDRtPP9zy98sxA9gupYBdoO7MTya1+siqg11fqeqbaE
         HCfqlBRkZd+0Y/HlTXcByeX1JNJM5+ji0ttGtWyGfUCUImhgmIBpUUZwbFPfy3bXD92v
         iEQSH5Eh+GID4qo9GCi3eKEdo84ShkbvhFlnKOcVCr9+cMCNqBwQdbKhrG0Sab12FvcM
         NOCPRmZbPi6rUIIynuMvUyEFV9x7Sd3J2kt6E/D/uXlUymo/9dpMBjinilzZodE5bRF7
         XMxQ==
X-Gm-Message-State: AOJu0YzNRQLUtnQ85vrO8O0auDsiOUouVLX0MqRdaooZnJLH5xqUkQhF
	6raUsVduSrNZ/4MnJHdL34mGW8ONdxlRNfLGS1Y7pyEyvj073PjlIRYxeobGCB51g9zvSakkoqA
	0dmwbr/bKoAAcpcp/BXAZC9z3cmpWH/lHOxI=
X-Google-Smtp-Source: AGHT+IEnmssEwAEQ9uxGb3hJxquIUs9MdsPOJSfPRpi1zOA+VoeWxW9YuBGSjj25uWs3r4xoxfXqnfoJllpFyN3/YxY=
X-Received: by 2002:a81:9c0c:0:b0:63b:ca6d:7bb8 with SMTP id
 00721157ae682-64c71145749mr50679057b3.11.1719872794714; Mon, 01 Jul 2024
 15:26:34 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <CAChcVu=Kwqj7JhXqQW6Ni9+3TdSfdmHfSTJQWm1_uO2kczSm8g@mail.gmail.com>
 <xmqqle2lyvdd.fsf@gitster.g> <CAChcVu=bWR_DvR==b7L0tn8PmK+9KOWWw+e7RtjMhywMv3W+qA@mail.gmail.com>
 <xmqqbk3hx9ik.fsf@gitster.g>
In-Reply-To: <xmqqbk3hx9ik.fsf@gitster.g>
From: Pavel Rappo <pavel.rappo@gmail.com>
Date: Mon, 1 Jul 2024 23:26:23 +0100
Message-ID: <CAChcVukZbVVE0jHGJt44w8D5Pi60+wYXn6Wz3gs+kGd3xmaw8A@mail.gmail.com>
Subject: Re: Determining if a merge was produced automatically
To: Junio C Hamano <gitster@pobox.com>
Cc: Git mailing list <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Mon, Jul 1, 2024 at 7:16=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Pavel Rappo <pavel.rappo@gmail.com> writes:
>
> > it for such merge commits produced automatically because of the
> > assumption that nothing bad can happen there.
>
> I do not think that assumption holds in the first place, though.  A
> typical and often cited example is when one side changed a helper
> function's behaviour while the other side added new callers to the
> helper function, still assuming the original behaviour.  In such a
> case there may not even be an textual conflict but the end results
> may be broken, and if the breakage is subtle, it may take weeks or
> months before somebody notices such a semantic mismerge.

Junio, I'm under no illusion that Git can resolve semantic conflicts,
such as the one you described. When I said "nothing bad can happen" I
didn't mean broken code, I meant unreviewed, possibly malicious
changes making their way into the target branch.

Suppose, we have the master branch and a PR against that branch. If a
new commit is pushed into the PR branch, we want it to be reviewed,
unless that commit is a merge from master to the PR branch. In that
case, we try to replicate the merge to see if it yields the same
result. If the result is the same, we will not require re-review.

Why do we not require a re-review in that case? Because when a PR is
integrated, it is merged with the master anyway. That merge is
unsupervised and unreviewed. If we flip sides, it means that we may
want to not require a review for merging from master to the PR. It's
this sense that "nothing bad can happen".

> But there, you'd need more than "both are cleanly auto-merged"; more
> like "both may have conflicted but they are resolved the same way"
> is what you are interested, no?  Since at that point, your primary
> interest shouldn't be "does it cleanly auto-merge?" but "do these
> two merges do the same thing?", determining if a merge was created
> automatically becomes a problem you do not need to solve, or solving
> it would not further your true goal.

Automatic merge is just a merge made by git merge or another command
that I expect authors to use for occasional merge from master into
their PRs. It's not a special merge. It's just a reference merge.

Sorry, I'm not good at writing text. I really hope this email
clarifies my use case and what I am trying to do about it.

> If you have two integration branches A and B, and a topic branch T
> first gets merged to A and then after proving its worth it gets
> merged down to B, I wonder if you can verify somebody's merge of B
> into T by comparing the result with your "verification merge", which
> you preform locally and on a throw-away branch by using "git rebase
> --rebase-merges" or some mechanism, to replay the original merge of
> T into A on top of B (before the merge of T you are verifying).

That sounds like my first idea with extra steps; not sure.

-Pavel
