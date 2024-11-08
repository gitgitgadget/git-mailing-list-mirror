Received: from mail-il1-f173.google.com (mail-il1-f173.google.com [209.85.166.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2EE721B438
	for <git@vger.kernel.org>; Fri,  8 Nov 2024 15:53:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731081219; cv=none; b=HVphLUvCAbd0ouuSYjwpHqGW3Z+2paQWtoOcAmFG3eHyBlaLrGGkoPyU02t1dmpab00GLnPry/SyCw9mhXXB2a+JMDAQZDYWMgQm3r3wnFy3fHgumavrx5ZfJ5Xxu7eQUUQy2dyXK5WA1NX3d3YR7AyGlm75aSNB8FwAvzwJZoo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731081219; c=relaxed/simple;
	bh=mPshKwAPjlTvkJZFMfWrFlexc2uaFtfJ4Z1KkQv2+ck=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=u9SJeMXsM810fPh3azNWDStYQMMZ1EaqaN2RtDUK/d9fhp2juGUtSWumqfWN0k6Awv4BigIfTQsCQClzCzQ5xeGdIm8xgRKbbVTobeeVi7uC47bqS4WM4vICWRmFPp9uk36CLK1ljGbJN7qDPzPev8nInP/3MM9HPJ3kKD4gDRw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VZszfPMl; arc=none smtp.client-ip=209.85.166.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VZszfPMl"
Received: by mail-il1-f173.google.com with SMTP id e9e14a558f8ab-3a6bf539cabso8173585ab.3
        for <git@vger.kernel.org>; Fri, 08 Nov 2024 07:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731081217; x=1731686017; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8RdhfVvcchGaXoRuIjkdC1qMflYeWf/KcHPZdmLpiIQ=;
        b=VZszfPMlV6pcpe7zqWqm/O+SL+FiLc+NWNzEAhf78jY97RPN1N6jjLZEDnYAnahMMA
         07ZSm8TZmBGnjh7EQTXylBiqOCvroaHS2LbqBBDeBHKjJwKjov1ZdxdNwE6aRUffqv/P
         kf9sQSTExavVs7DP14t1DoRZ7YhMYmPsw1JZjuu/ksjy/n19IHHflCarx4aSBvU4d63u
         h10o4NkbUAU/oRPgdviOZ5AiqTklWH/iEdXpYXI5HefRl8oKHZjql4ttaoTax5t0lcKW
         XTdAO4b4PhINMggN9hLgrqqQTBctOcmrjJaVLj9JmSUhZI3EsTLI4yYS7At1WbsJMLAF
         Pc/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731081217; x=1731686017;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8RdhfVvcchGaXoRuIjkdC1qMflYeWf/KcHPZdmLpiIQ=;
        b=jU785s9Y/ElL2rHyvxP79LjygdVxzNRJPKJwCCY1Dun9O7ZjV3/FqSAL/LMN+dSoc7
         lEjuTx6u7yidbaFpXMHneharhpCmPeOss2sBlR0Zi38ZRClKJyuGI0Lt4okYK55pKZRI
         o/7Iijh2DMn6BI/jML1QKMWdzLpz16w2ridsU5vCHu/VCyK+swATSLy6Xv7WBKTuD+LI
         dYYHjWT9QfmFMJB73j0efOp/RM1n4VmqongNy95SH70Vs9xFz5c9CYxed8zKtE0SmpTN
         2YcqkuKKrwRX97kVpJCOCiwL1bFEEh8O+Yi69OZFH0wgOuJqiyBwGOAXqtfzjKC33PYd
         KPNQ==
X-Forwarded-Encrypted: i=1; AJvYcCV6AS26sjPbwqjeZUNXzV6dkjao6/zMsg1/I8/ucKzzCJyfrf5vP9Dz13lII4H2tThq5dQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YwfpBCBw/r+5JOFrn/H+IPDuRpj4VPJbOhqKkm1737mYsKKWqhI
	G1w/wGWJUrzfJYaIY03cwkCMif7o8dEp0MQzZtuo7t889pjBQ3IcDx2KwK/quWu1M+FXsXJ86Sh
	0ZtMKzGiuhcFRQdXwdbKCuEZiTp0=
X-Google-Smtp-Source: AGHT+IFirqx2QOLNGP/4As7VsBE2c/Mssk7LKkk6kVpSyXDMD6ea7XCEu4qzYGCHcmQPUWUnw/ybdvfj1csovsEWN8E=
X-Received: by 2002:a05:6e02:1806:b0:3a6:ab82:db5e with SMTP id
 e9e14a558f8ab-3a6f1a4c4c6mr42557265ab.22.1731081216845; Fri, 08 Nov 2024
 07:53:36 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1734.git.1731000007391.gitgitgadget@gmail.com> <abc2453b-f7df-4601-8834-595881f9ceca@kdbg.org>
In-Reply-To: <abc2453b-f7df-4601-8834-595881f9ceca@kdbg.org>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 8 Nov 2024 07:53:25 -0800
Message-ID: <CABPp-BFCe6wSQDGJ-Bo4+u1OE9Py2mYroX9qsvxFXJ_kePmTfg@mail.gmail.com>
Subject: Re: [PATCH] range-diff: optionally include merge commits' diffs in
 the analysis
To: Johannes Sixt <j6t@kdbg.org>
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>, git@vger.kernel.org, 
	Philippe Blain <levraiphilippeblain@gmail.com>, 
	Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Thu, Nov 7, 2024 at 10:54=E2=80=AFPM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 07.11.24 um 18:20 schrieb Johannes Schindelin via GitGitGadget:
> > +--diff-merges=3D<format>::
> > +     Instead of ignoring merge commits, generate diffs for them using =
the
> > +     corresponding `--diff-merges=3D<format>` option of linkgit:git-lo=
g[1],
> > +     and include them in the comparison.
> > ++
> > +Note: Some of the formats supported by linkgit:git-log[1] make less se=
nse in
> > +the context of the `range-diff` command than other formats, so choose =
wisely!
>
> Can we please be a bit more specific which options are usable or which
> are not usable? Perhaps you even mean to say that 'first-parent' is the
> only one that makes sense? At a minimum, we should mention that it is
> the one that makes most sense (if that is the case).

Here's my guesses I mostly typed up last night before getting tired
and going to bed:

separate: makes no sense; showing two diffs for each merge and then
trying to diff the two sets of two diffs seems crazy, especially since
the whole point of rebasing is usually to change the first parent
somewhere in the ancestry; that'll cascade up and cause the diffs to
the second parents to differ wildly and make this format uselessly
noisy in general.

combined: much better than separate, but probably still quite noisy and
confusing, especially since combined-diff and range-diff are both
complicated in that they have two diffs each, and combining the two
means you have a diff of a dual diff.  I suspect that might be hard for use=
rs to
process.

dense-combined: much better than combined, you at least have the diff
down to the smallest relevant pieces.  You may still deal with the
diff of a dual diff problem.

first-parent: useful, but only when keeping the series of patches largely
intact and transplanting them; any insertion, deletion, or
modification of intermediate patches will result in those
modifications being shown
not just for the patch in question but rolled up into the merge commit
and shown there as well, making the diff for the merge very noisy
(possibly to the point of uselessness).  When
keeping the series of patches intact and transplanting them, though,
likely a useful mode.

remerge-diff: generally useful, even if you insert, delete, or modify
intermediate patches while rebasing.  Since it also shows how conflict
resolutions are done, you'd see how conflicts are resolved
differently.  Actually, that might be one drawback to this method;
since conflict markers try to provide labels involving a short commit
ID and the commit message, and those short commit IDs will differ,
this mode would just end up showing how the two merges had different
parents, which you already know.  We could probably make this option
much more useful by surpressing the conflict labels, or at least the
short commit ID parts of those labels.  If we do that, and take
Johannes' nice fix he sent to the list separately, then I suspect this
mode is generally the most useful one to use with range-diff.
