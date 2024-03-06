Received: from mail-lf1-f52.google.com (mail-lf1-f52.google.com [209.85.167.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127A017F5
	for <git@vger.kernel.org>; Wed,  6 Mar 2024 02:57:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709693863; cv=none; b=X/CLhFVvgTtum5MboPcS6Dd7Xz8lU0wGS3o8JY6oeFEh4MskG5/WTRG90Fx4MymrqoP/dQxXzNEII29iAUX3+T/9WR/Y1+EMgSsgm0/HpxiGPDh6v1I86qtWE59OJY70oII9hZaCQozi3Dw1OMcoWsyuwOiV0jy0gIX2z8LtxoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709693863; c=relaxed/simple;
	bh=hBSvVxHfGzlLisincQE4zlS06Rh98W0H6v7zLqsax3Q=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=QZXv7lRP1bjkEbdCfvvAnmtZwolMzUFbWPGPFb7C+9EcnpDS8JWm2a+pn6EesxN1fhvpa9+KIff2PO4tfm+CGt3PqqfuZqc68I6tyvQdExcO9iKIpsfFcunklut5VIB3MOQETnlg5lYnmbh6ByISALMSsyx90DX7NK6aIp1SYA8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=d/uDDPug; arc=none smtp.client-ip=209.85.167.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="d/uDDPug"
Received: by mail-lf1-f52.google.com with SMTP id 2adb3069b0e04-512e4f4e463so7131114e87.1
        for <git@vger.kernel.org>; Tue, 05 Mar 2024 18:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1709693859; x=1710298659; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OKVoxa7AjNeozeZLDsNfpz5rBeEkKtNGTsxBlAaLB/0=;
        b=d/uDDPugOlzQpMkRUK6ylD7oaxvmVZVauIA8hSiVyW/dQ/KAGTzg3TEPWwGz/AfC+z
         zVAyGTT7/Z2t6v5Vz+9gDtejl8q8irZnDqfRcFlB58lXT3bW5FpLh/TlNJ5oqnqlqPaG
         oTiu6T/wAgF+2KTKwfwOC8TiiFP1hne+nP1x+xRZDyF4RiYlXqzfzuXlp7B/DM01LcyV
         fEfmT6ILEC+K3DDlvu72V0qkOeHqfQvWfju3BS52LR27vHEiznyPMH9WQ8UCYCJDIXFS
         YUNNXFGFLXco6wRTGbsEeVH+1HBKNC8OGkoJAT3vhouiEhi2DHRuAuVN4xGaZGgJnphm
         a2Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709693859; x=1710298659;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OKVoxa7AjNeozeZLDsNfpz5rBeEkKtNGTsxBlAaLB/0=;
        b=PPO4S5lmazgAhLQ9mGRKP/lD0xsoV1y13SzuKV5kW8JqaJs0/tNzKYZY/o6H6BJmGU
         I/ikmUH/gNl+rsreb675kIGtWOHsCzDh95nzQaplSTnnTj9zZnCIZj4y1M2nIvbNcRnW
         J17t0GfBcr2I6NRJOxziHk7gbc4EO9jFd1fD9+uhYNA4nePnEEdjHM8dH3tGuKnGliX5
         oauPEBV54mOkSsJKCYuWun8i6rq15G6YjtBSu9+U8kMTlU/a/UKzS30eo1DE1GoUQouB
         bV/0HeX2FZsgy29Z04X76KEd5jCBiJ4YfiLNmLFX/xBquh+bAnCsaITKe6BAPB8dGxb5
         Mz6A==
X-Forwarded-Encrypted: i=1; AJvYcCUxuMA8Qi+PEiKfYOXYkSBRS6LNbsWA4NdlHwq5gQIF1P6I6YtKYNEa0DpNAcHgd95T5bA0uXOVbXjXgAxAlZU5/lk2
X-Gm-Message-State: AOJu0Yypoguw0shr+KYviXCMZLq/jHWoRZzAbX9RkKq/UajRul33xK2N
	Bl23hXLO+GKvdcY3Ne92EvnGGnKFT+G/mgIucAttCcc0iPmiskUcY9fE8BO4yUYcLLszj4idv30
	mLmH55QeCPlRtln4lrYtZaH2BUMU=
X-Google-Smtp-Source: AGHT+IHFLs840MHiNE1PjI/le0lWrcZh/y+ipIxkqYdFbVbPnlrvd2mtzreDKArPGxKD1Z7Ive05MpKhKjcc062y6Vg=
X-Received: by 2002:a05:6512:b83:b0:513:3d35:bef6 with SMTP id
 b3-20020a0565120b8300b005133d35bef6mr3426912lfv.51.1709693858709; Tue, 05 Mar
 2024 18:57:38 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <adb7f680-5bfa-6fa5-6d8a-61323fee7f53@haller-berlin.de>
 <354f9fed-567f-42c8-9da9-148a5e223022@haller-berlin.de> <xmqqsf144pi7.fsf@gitster.g>
In-Reply-To: <xmqqsf144pi7.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Tue, 5 Mar 2024 18:57:26 -0800
Message-ID: <CABPp-BGO2ftEMHJDrf6yg3J4AfpKn=rpf_5Wt_WAS+Hi70KqPQ@mail.gmail.com>
Subject: Re: Should --update-refs exclude refs pointing to the current HEAD?
To: Junio C Hamano <gitster@pobox.com>
Cc: Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org, 
	Derrick Stolee <derrickstolee@github.com>, Phillip Wood <phillip.wood123@gmail.com>, 
	Christian Couder <christian.couder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

[Restoring part of Stefan's earlier message so I can respond to both
that piece, as well as add to the ideas Junio presents.]

Hi,

On Tue, Mar 5, 2024 at 8:22=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Stefan Haller <lists@haller-berlin.de> writes:
>
> >> And I now see that "git replay --contained --onto" has the same proble=
m,
> >> which I find very unfortunate. In my opinion, "contained" should only
> >> include refs that form a stack, but not copies of the current branch.

I wouldn't want to change the default.  Even if we were to add an
option, I'm not entirely sure what it should even implement.  In
addition to Phillip's previous response in the thread, and part of
Junio's response below (which I'll add to):

1) What if there is a branch that is "just a copy" of one of the
branches earlier in the "stack"?  Since it's "just a copy", shouldn't
it be excluded for similar reasons to what you are arguing?  And, if
so, which branch is the copy?

2) Further, a "stack", to me at least, suggests a linear history
without branching (i.e. each commit has at most one parent _and_ at
most one child among the commits in the stack).  I designed `git
replay` to handle diverging histories (i.e. rebasing multiple branches
that _might_ share a subset of common history but none necessarily
need to fully contain the others, though perhaps the branches do share
some other contained branches), and I want it to handle replaying
merges as well.  While `git rebase --update-refs` is absolutely
limited to "stacks", and thus your argument might make sense in the
context of `git rebase`, since you are bringing `git replay` into the
mix, it needs to apply beyond a stack of commits.  It's not clear to
me how to genericize your suggestions to handle cases other than a
simple stack of commits, though.

3) This is mostly covered in (1) and (2), but to be explicit: `git
replay` is completely against the HEAD-is-special assumptions that are
pervasive within `git rebase`, and your problem is entirely phrased as
HEAD-is-special due to your call out of "the current branch".  Is your
argument limited to such special cases?  (If so, it might still be
valid for `git rebase`, of course.)

4) Aren't there easier ways to handle this -- for both rebase and
replay?  I'll suggest some alternatives below...

> >> Both of these cases could be fixed by --update-refs not touching any
> >> refs that point to the current HEAD. I'm having a hard time coming up
> >> with cases where you would ever want those to be updated, in fact.
>
> The point of "update-refs", as I understand it, is that in addition
> to the end point of the history (E in "git rebase --onto N O E"),
> any branch tips that are between O..E can be migrated to point at
> their rewritten counterparts.  So I am not sure how it fundamentally
> solves much by protecting only refs that point at a single commit
> ("the current HEAD" in your statement).
>
> When I want to see how the rebased history would look like without
> touching the original, I often rebase a detached HEAD (i.e. instead
> of the earlier one, use "git rebase --onto N O E^0", or when
> rebasing the current branch, "git rebase [--onto N] O HEAD^0") and
> that would protect the current branch well, but --update-refs of
> course would not work well.  There is no handy place like detached
> HEAD that can be used to save rewritten version of these extra
> branch tips.
>
> If branch tips A, B, and C are involved in the range of commits
> being rewritten, one way to help us in such a situation may be to
> teach "git rebase" to (1) somehow create a new set of proposed-A,
> proposed-B, and proposed-C refs (they do not have to be branches),
> while keeping the original A, B, and C intact, (2) allow us to
> inspect the resulting refs, compare the corresponding ones from
> these two sets, and (3) allow us to promote (possibly a subset of)
> proposed- ones to their counterpart real branches after we inspect
> them.  The latter two do not have to be subcommands of "git rebase"
> but can be separate and new commands.

Here, Junio is suggesting one alternative, and it's already
implemented in `git replay`.  Let me extend upon it and add two other
alternatives as well:

4a) `git replay` does what Junio suggests naturally, since it doesn't
update the refs but instead gives commands which can be fed to `git
update-ref --stdin`.  Thus, users can inspect the output of `git
replay` and only perform the updates they want (by feeding a subset of
the lines to update-ref --stdin).

4b) For `git replay`, --contained is just syntactic sugar -- it isn't
necessary.  git replay will allow you to list multiple branches that
you want replayed, so you can specify which branches are relevant to
you.  (This doesn't help with `git rebase`, because `--update-refs` is
the only way to get additional branches replayed.)

4c) For `git rebase --update-refs`, you can add `--interactive` and
then delete the `update-ref` line(s) corresponding to the refs you
don't want updated.
