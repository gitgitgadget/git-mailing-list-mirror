Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91C3E1A38C4
	for <git@vger.kernel.org>; Mon, 11 Nov 2024 16:51:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.166.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731343886; cv=none; b=RGc1QH0WJV8uq6KcQ1c4xabAFmNGpXFIdg2exsYXl/OlNr6Fg1itJ0bN+qtJPwJhRrF9ak6bU1WihpP3IeU9+ZToBor3txgS+LTKInZ1C0oFXuzyQZlrL+Wfs/9xwys1JO/PT6F0nIxli3FG51chNX07nadTs21Sfgcqw1EHRxg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731343886; c=relaxed/simple;
	bh=18PlKADVFalgjr7hcRbgs9LXom3PisWOWp7QG6EERIE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=ajMhY4VGia20q5Mgh2sk7dDIVWxd8TcGFOqpCFRN0aAPEKbgU8sOsHyvr7hnMO5uE1LbEmFhsxI8ZAH93nPFLTZHMRteHOoadb8PZLzyLdyo60Dol+lcM0dMjBvpDaV3Xpc6EQqlfpGGZrtOqR3QWxQOyRgyFeHQ2NEdA6MU5Uo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JO54/qSN; arc=none smtp.client-ip=209.85.166.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JO54/qSN"
Received: by mail-io1-f45.google.com with SMTP id ca18e2360f4ac-83aff992087so161241239f.3
        for <git@vger.kernel.org>; Mon, 11 Nov 2024 08:51:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1731343884; x=1731948684; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LffgT/0zB3FCtFr+4kEzRMQoJcKdiiuwbacLUIrhYtQ=;
        b=JO54/qSNHKLLhwqdESoXWCZcYjr9/Xt5NUyE+8APZwWMxNALh2mejEiD8oXaV094aN
         nr+njfYZC1X4UOYaC0/iz6TEvzRJRueCwINzV/CNH49eLrzEYoSYIZG73My986m8pkiP
         k7AHQRuz7796CsHoSX1oBnWJUC+BcqjYnjgZtDoaNyMsruVlgqY/lLtMO/N4OCovbNKB
         7iyoBxXZ2qsJ3jsRFy1hsmhquePbEW+d+8IPm15k8fqidRfrAm/q9DuCSm+pqAdjmVh4
         CAnHz4DARV3sNKr7mULRgt4PH1fdeyciUBwVRIm67fInp0EHaXbt3JcCflwuSHvGIG06
         eXBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1731343884; x=1731948684;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LffgT/0zB3FCtFr+4kEzRMQoJcKdiiuwbacLUIrhYtQ=;
        b=h69+pgYHJhhs/iS9YPa8QIvJK65gpdpym7OQjQmAqc4yO6Xf5ete99Fe3d2R+Uj799
         gWzv/1/fJts8D6lXpPiy42hSitFP9pZbs8DVne7966DDOKjLHEBpg6xwPLNFp9Hxr9eE
         PDG9eHnFP5HYgqE7VBBmSfDw979Rt4i7bSP736HkuJVVMGhxhN93EWvra5U2gwgtFV+a
         //rdAKYpZKPZ5DhFjnUEL7wMOmMVeoImZIPpRJyMWlr7P7TMXZ5nnQ381ithG2x7yh1U
         YDsbZf0sevffXQTAAKLuuiYtxnpOtL4hsTH/tpEjyRQm1Kzi9HX54o6dpWbssb1bxYon
         Fe/Q==
X-Forwarded-Encrypted: i=1; AJvYcCVTKVIKSqi+NTOgeoAf9PzaRCG6/s4BJ5qoaAyu4q6nj8c4IMs6WSAi37AhA7IHVudV43o=@vger.kernel.org
X-Gm-Message-State: AOJu0YykGd9ba7/O8A7yYMC0HejG33fa+bA3kp3SFc7bw2ra4HJOl25K
	ciKaSOvpiGjeVd/VqjV8p642x5f6FUJeYANyzMK04oNqgzO1zjSBQm3WDSCE2nfTkQNpJ3arXI1
	MpElSzaOx2/BggSHBjBD2lzseGiA=
X-Google-Smtp-Source: AGHT+IHlv+R+iC+HlpPpbvrW2O+mw8TPTxMPQbBH5aj44jfQymh/LINqNj8vbOI6+gf5UGgmcSaieNfxQhKFjeXecZs=
X-Received: by 2002:a05:6602:150f:b0:83a:b43b:da89 with SMTP id
 ca18e2360f4ac-83e03344380mr1459096139f.10.1731343883562; Mon, 11 Nov 2024
 08:51:23 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <pull.1734.git.1731000007391.gitgitgadget@gmail.com>
 <pull.1734.v2.git.1731073383564.gitgitgadget@gmail.com> <xmqqv7wuk3lx.fsf@gitster.g>
In-Reply-To: <xmqqv7wuk3lx.fsf@gitster.g>
From: Elijah Newren <newren@gmail.com>
Date: Mon, 11 Nov 2024 08:51:12 -0800
Message-ID: <CABPp-BFXZ+aaTWGAUhJxh2YYZ131BNYFCyLNVbjntBmStUu0SA@mail.gmail.com>
Subject: Re: [PATCH v2] range-diff: optionally include merge commits' diffs in
 the analysis
To: Junio C Hamano <gitster@pobox.com>
Cc: Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>, git@vger.kernel.org, 
	Philippe Blain <levraiphilippeblain@gmail.com>, Johannes Sixt <j6t@kdbg.org>, 
	Johannes Schindelin <johannes.schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, Nov 10, 2024 at 4:37=E2=80=AFPM Junio C Hamano <gitster@pobox.com> =
wrote:
>
> "Johannes Schindelin via GitGitGadget" <gitgitgadget@gmail.com>
> writes:
>
[...]
> > +--diff-merges=3D<format>::
> > +     Instead of ignoring merge commits, generate diffs for them using =
the
> > +     corresponding `--diff-merges=3D<format>` option of linkgit:git-lo=
g[1],
> > +     and include them in the comparison.
> > ++
> > +Note: In the common case, the `first-parent` mode will be the most nat=
ural one
> > +to use, as it is consistent with the idea that a merge is kind of a "m=
eta
> > +patch", comprising all the merged commits' patches into a single one.
>
> I'll let you and Elijah figure out the best phrasing around here,
> including whether we recommend only first-parent or give other
> options.

I'd probably suggest:

Note: When trying to see how users adjusted the contents of a merge
commit, `remerge-diff` is a natural choice.  When viewing merges as a
"meta patch", comprising a squash of all the merged commits' patches
into a single one (similar to `git log --first-parent -p`),
`first-parent` is a natural choice.

> For me personally, I find that use of `first-parent` here is
> consistent with the mindset of those users who prefer to read "git
> log --first-parent -p", and to a smaller degree, those who use
> squash merges.  To them, a merge is merely bringing in lots of
> changes into the mainline as a single unit, and other than that
> these lots of changes are broken out for finer grained inspection
> if/when they wanted to, they prefer to treat the changes brought in
> by merges just like a single-parent commit.  And from that point of
> view, (1) reordering the changes inside the side branch is
> immaterial for the purpose of talking about the result, the net
> effect the merged topic makes to the mainline, and (2) dropping or
> adding new changes to the side branch is treated just like a newer
> iteration of a single parent commit having fewer or more changes.
> So it is very natural that first-parent helps to make the world view
> very simplistic, and more readable range-diff is all about how you
> can present the two iterations in a simple and flattened form.
>
> There _may_ need a tweak of the matching algorithm to allow the
> "same" merge on both sides to match, even if they diverge a lot,
> though.  A range-diff that pairs a merge in the previous iteration
> with a single patch in the updated iteration may be hard to read.

Sounds like you are arguing that there is an angle/usecase from which
`first-parent` makes sense, namely the viewpoint that "a merge is
merely bringing in lots of changes into the mainline as a single unit"
as you put it.  What was surprising to me, though, is that it's a
completely different usecase than the one that was brought up in the
commit message for this feature, namely "so-called 'evil merges' are
sometimes necessary and need to be reviewed too".

If you want to review "evilness" or the differences between the
changes that `git merge` would make and what got recorded in the
commit, then `first-parent` is not that great an approximation of what
you are looking for, BUT it happens to work beautifully in common
cases where you are merely transplanting commits due to the fact that
the huge amounts of extras being put into the diff happen to be equal
on the two sides, so they cancel out and leave you with the "evilness"
you are interested in.  But if you stray from that common case (by
e.g. inserting, removing, or modifying commits while rebasing) and are
still interested in "evilness", your approximation quickly drops from
accurately pulling out just the bits you are interested in towards
being completely swamped by the noise.

My concern with the commit message and patch as they stand, is that I
feel the `first-parent` mode is being recommended as a solution for a
certain usecase where it is really only an approximation that luckily
is highly accurate in special but common scenarios while being very
inaccurate in others.  I think that will lead to users getting
negatively surprised when they move outside those common cases.
