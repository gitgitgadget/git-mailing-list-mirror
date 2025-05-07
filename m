Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B83B620296E
	for <git@vger.kernel.org>; Wed,  7 May 2025 19:48:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746647324; cv=none; b=risy1TyWneaW3vpjyLWQn2zxIWWH33NXx2ok1YUWEF6Au+lfmbEYRI7dF/clkeR8GcdoQUegd0qpkg3RSRfCi5pzAYsxen+SBTypRF4Li/bRiLVrPcU/SHQCwpfkSfN4jcP9lM/o8Aubbj8C+fLEwCapeIN19rN56STZFdrG3No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746647324; c=relaxed/simple;
	bh=oIICLo5FRIva3N2aGyF/PLYpmlWDJ/ClOJE7CG4Y9Hs=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type; b=EGiite1ccu5wC6IyAlXgU1MMXsTPa/NaoMsu6PSmExw1FS0XW9bvWCabV8EpDHYHYDFiauBp5Qob6QJpmi6uPneBQrf1ShaoCIIj10lfOnCjJudrkrh2AvlIcAWyPn+LCn8vbx1ns6/f0vE2O29YlHB9eK5Zfdhd9q4+v1wEcms=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=JPEUUSw1; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JPEUUSw1"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-af52a624283so325396a12.0
        for <git@vger.kernel.org>; Wed, 07 May 2025 12:48:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746647321; x=1747252121; darn=vger.kernel.org;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cIU7kpPxyQJHzMF2cNsncaKFxyRnwB/mPtnzYYDpzd0=;
        b=JPEUUSw16V2Wr82g69DPH9ynSTInZhoipI9htBLeUE5XfSmV576FW5WXYv/hn65Uaz
         F1p6C3Kt1TbkBGm7ehtdSwpvHP43r/Fw3G2quKXQJt7gHqewFqm1XmMnsbVc6rY2RHeM
         oArzbiyvp8DRkVOpfGLz7z4Oz1SOqK+H6tX3ENmKW3mXVaycCJtBhd06ttiPr9Mw8Tj8
         B1GBxX5VAVjCEomU5TGFxKJbz6zTquyqcXcXrxdrlxflMlRBjlpHXLQx5U4xgbCoNd/5
         lwjOcsSkJcivGlXp/nZai+B5XC3jydUbm3rNcLsGxPMxe7knXTT3En7JUqLcBoRYEDWL
         o+Pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746647321; x=1747252121;
        h=content-transfer-encoding:to:subject:message-id:date:from
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cIU7kpPxyQJHzMF2cNsncaKFxyRnwB/mPtnzYYDpzd0=;
        b=WvrFVUiqML6e2m2iS78v9zn8URalli+FMlBYe2ZGd4oo3TQa4Lhzu9JHa48djU0uy8
         lRapR98PTpYLmRqDds0f3C9sfk12ibCq30Iap+vdozPAF+vehYpXu8E7LYtdCIOK/Ga6
         ijDlHdGCpujjuvyztI+NXga4mCuuKJdXjqKhX3zU95a9KXeVC33lEeoAiGDkfSStjdBX
         qMv8laie38EAuo5CaaoGrr77MmJFiiYTmoC3za6FyjEk9uus1MQkvuu0It0HBN0oo9LA
         7zoF2qofqH24U+AP0PyZS4FdtGfo0q8j6paYZ5i/YSY/J+sr6EYIpZm2zNFDp+KJ0bS9
         zfWg==
X-Gm-Message-State: AOJu0YytrHsVvBhwb3VKwLSOZvSCGazsJuv0ao1b7weY5lTlIFOQf2/u
	53Vy8nADnEpkRBDfzfFq1o2cROlgCRcEdc0yFQBGv3CmvmaXg5mhYz8Gi5g7RtGUyiMA00bQFal
	j2uvXQ7dhX0POq3Y7f3xNdhHGXB0ljExB
X-Gm-Gg: ASbGncvNLZAfNH+ntGW/15DTdGEVEnH3fEpM6zFZXQnRvcmZWvY/D49JrCIzeIfaueO
	YxKbSDr+AP4FHOwBmJM8B3AQVfwslU3qQYzG5NhrjTW1rTe6saq3A+MJd3ITfn45T5THsKYRi1b
	W//S9rVEStiHhi5J7RNxzTBw==
X-Google-Smtp-Source: AGHT+IGa32hJYMSMurOckG92OaRMB01TAvIivSlXMJ2F3qFdQXTOvpMEUy4hmhI2fpQvtEfLmpY3gl4OjrvQQurFSr0=
X-Received: by 2002:a17:90b:1a8d:b0:2fa:17e4:b1cf with SMTP id
 98e67ed59e1d1-30adbefcbf3mr1087627a91.2.1746647321408; Wed, 07 May 2025
 12:48:41 -0700 (PDT)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: Britton Kerin <britton.kerin@gmail.com>
Date: Wed, 7 May 2025 11:48:29 -0800
X-Gm-Features: ATxdqUEK8w-SopUa4-VdN6xu-vp1GUMtJsKOs8bpAiwVeDS_45SqJyaI34Ci9-E
Message-ID: <CAC4O8c-964C15ceOHYbk0=_DwpWfpbHgrvP46DoUeUtBbab1-g@mail.gmail.com>
Subject: Re: easily use meld 3-pane view to review merge commits?
To: git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Sun, May 4, 2025 at 1:00=E2=80=AFAM Johannes Sixt <j6t@kdbg.org> wrote:
>
> Am 03.05.25 um 23:55 schrieb Britton Kerin:
> > I like how git-mergetool can use meld with 3 pane view to see merge con=
flicts:
> >
> >   git mergetool --tool=3Dmeld
> >
> > I'd like to use the same sort of view to see already-committed merges,
> > but I didn't find an easy way to do it.  It seems like git-diff,
> > git-difftool and git-show are oriented entirely towards diff or 2-pane
> > view rather than diff3/3-pane that git-mergetool uses.  Did I miss the
> > existing functionality somehow?
>
> I see a conceptual inconsistency with the desire to use a 3-pane view
> with a merge commit.
>
> When merge conflicts are to be resolved, you have exactly 4 versions of
> a file to work with: base, ours, theirs, and the merge result. (Meld
> does not show the base and uses only 3 panes.) For this reason, it makes
> sense to have 3 panes in a merge tool, perhaps a forth for the merge
> base. That's it. You never need to have more than that.

At least meld via git-difftool (e.g. via git `mergetool --tool=3Dmeld` defa=
ults to
showing $LOCAL, $BASE, and $REMOTE.  I think this is the right default,
but others prefer to see $MERGED from the start.  It's this configuration
with BASE that has an obvious symmetric arrangement for review of an
existing commit, and it's LOCAL, MERGED (the final form), and REMOTE.

> With a merge commit, you can have: the merge result, the first parent,
> and the second parent... and the third parent, the fourth parent, etc.
> You can have any number of versions to deal with.
>
> How does that fit into the picture? Can meld (or any other merge tool)
> have any number of panes and still work in a reasonable way? Why should

Not that I know of.

> 2-parent merge commits be special-cased?

> That was the devil's advocate speaking. 2-parent merge commits are
> common enough that some merge tool support could make sense, but we
> should be aware that there is a conceptual hurdle.

Agreed.  Of course all merges can be decomposed into successive 2-parent
merges, and I suspect there are a lot of other paranoid people like myself
who always do it that way in large part because it's much easier to see wha=
t
happened after the fact that with octopus merges.

As I said I agree that wedging this into git-difftool isn't necessarily a g=
ood
idea, but it would be nice if it was available somewhere.  What I have
now as an answer to

https://stackoverflow.com/questions/79599180/show-a-git-merge-commit-in-thr=
ee-panel-form-in-meld

is enough for me but obviously needs more work (to handle trees, various
diff3 renderers, etc.) but if that straightforward work got done would it b=
e
a worthwhile addition to the toolbox?

Britton
