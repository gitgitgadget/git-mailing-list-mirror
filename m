Received: from mail-4316.protonmail.ch (mail-4316.protonmail.ch [185.70.43.16])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C067B3FC2
	for <git@vger.kernel.org>; Sat, 30 Nov 2024 00:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.70.43.16
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732925326; cv=none; b=nm4SxX5mBZAtKpZaq2bXddzQ19KiXgStMJdeJ0mrXF46WuRgq1wtBPR1nnTsZhFqlpLYWh1SBi6tNnrbOml8CsRXt1q4+lHuAzynRshDy2G7v1QmjERWWuuDMp1b1YbMcGP7T7HpuO4aFOXOKAsAqxEnamysuFl8j9pc0Fp3ZsU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732925326; c=relaxed/simple;
	bh=Hq/QRVhThAxf0Gq/eFSUqiA7382d6B1V4py14MyXSsk=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MsMOv/qeBeZSllkWLYd79tM8/D93FCXzkC8qh2KB/eWiCAeFavIl61gbxKHaZBbZl4/k6wCV8cbtx4JJnrVM6RScsG9HvyUjdqulqupFPrpoCETxINAr5cSa3XhYp85dvsofElwEcOZ8wn0OtyIXhCmXpNbvEs9eZxqdl5lUQ4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me; spf=pass smtp.mailfrom=pm.me; dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b=XpzW5xGQ; arc=none smtp.client-ip=185.70.43.16
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.b="XpzW5xGQ"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1732925323; x=1733184523;
	bh=75BVrF2TLXsOkX3tuWDeVOjPzpUFfHWaCJcnRh1Sdns=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector:List-Unsubscribe:List-Unsubscribe-Post;
	b=XpzW5xGQfbmJ+cu1C2/0y7iRANlc9YWNehyPV3Vma5zhS4BcswI0x1JfgFORnk5Yk
	 HPV9DYNkZ8P9xWhNqzTpcelb8qtK2uhsaLPoFX1UrlMStiPyGFO2SqbzX7fGOW3e1X
	 yAj0iZePxZL+aYomtwrT8Vdq2ZCHmOgZ2Dx7ILAocbmRAuhMEOZcyJPrTSREdCUs1I
	 Uk1IJGuXr49IwpAqkXWE266SiuUYfgNAHQDqSNKehxhFEB8hSxBCB4LHqcL/I6tyHC
	 0ywiXA8EtP+aFFlFusAI/J1DQYZP8c91VgZW044YIDA1DNNUt7aOiGhDgRmxvQjGIN
	 zrB8QxsBS7WTA==
Date: Sat, 30 Nov 2024 00:08:39 +0000
To: rsbecker@nexbridge.com, git@vger.kernel.org
From: Caleb White <cdwhite3@pm.me>
Cc: 'shejialuo' <shejialuo@gmail.com>, 'Junio C Hamano' <gitster@pobox.com>
Subject: Re: [PATCH v2 0/3] Ensure unique worktree ids across repositories
Message-ID: <D5Z2R71VW1JF.1FZE1Z0V8H6Q7@pm.me>
In-Reply-To: <00c801db42b8$a03539a0$e09face0$@nexbridge.com>
References: <20241129-wt_unique_ids-v2-0-ff444e9e625a@pm.me> <00c401db42b1$99c4d5a0$cd4e80e0$@nexbridge.com> <D5Z1L479JERN.80KZ7NA9BWNJ@pm.me> <00c501db42b4$ea97e050$bfc7a0f0$@nexbridge.com> <D5Z1X36NVZ28.1FPA05CU9GFRL@pm.me> <00c801db42b8$a03539a0$e09face0$@nexbridge.com>
Feedback-ID: 31210263:user:proton
X-Pm-Message-ID: 73d7b92c2ff1194601b73f228b68a23a0b6ce9ff
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

On Fri Nov 29, 2024 at 5:44 PM CST, rsbecker wrote:
> On November 29, 2024 6:29 PM, Caleb White wrote:
>>On Fri Nov 29, 2024 at 5:17 PM CST, rsbecker wrote:
>>> On November 29, 2024 6:14 PM, Caleb White writes:
>>>>On Fri Nov 29, 2024 at 4:54 PM CST, rsbecker wrote:
>>>>> General comment on this series: Is there a mechanism of preserving
>>>>> existing functionality for those of us who have existing scripts
>>>>> that depend on the existing branch and worktree naming?
>>>>
>>>>Existing worktrees will continue to work as they do now. The only
>>>>change is the worktree id for new worktrees. However, there's not an
>>>>option to preserve the existing behavior for new worktrees (nor do I th=
ink there
>>should be).
>>>
>>> I do not agree. Companies that have existing scripts should have some
>>> way to preserve their investment. Just saying "No more worktrees for
>>> you" is not really considerate.
>>
>>How exactly are your scripts depending on the worktree id? There are very=
 few
>>reasons a script might need to know the worktree id, and I suspect that t=
here's
>>some confusion here. The worktree name is still used with the `git worktr=
ee`
>>commands, so there no change on that front.
>
> The graphic describing this showed the id in addition to the worktree nam=
e.
> During cleanup detection, the directory of the worktree is significant. I=
f that
> Observation is wrong, I retract all this.

So here's the graphic again:

    foo/
    =E2=94=9C=E2=94=80=E2=94=80 .git/worktrees/develop-5445874156/
    =E2=94=94=E2=94=80=E2=94=80 develop/

Here, the `develop` directory is the worktree directory (this can be
located anywhere), and the `develop-5445874156` is the worktree id.
However, the worktree id can already be something like `develop1`
or something else entirely if the `develop` directory was renamed in the
past. Again, there are very few things a script should need to know the
worktree id for.

If the `develop` directory is deleted, cleanup detection is handled
by the `git worktree prune` command, which will remove worktrees under
`.git/worktrees/*` that are no longer valid. This happens automatically
after the expiry time or it can be executed manually. Of course,
executing `git worktree remove develop` will also remove the worktree
and its associated worktree id.

Best,

Caleb

