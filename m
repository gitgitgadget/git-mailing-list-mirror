Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9A5833CC
	for <git@vger.kernel.org>; Sat, 11 Nov 2023 03:42:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MaDS9Rwg"
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E730E449A
	for <git@vger.kernel.org>; Fri, 10 Nov 2023 19:42:15 -0800 (PST)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-507a5f2193bso2972547e87.1
        for <git@vger.kernel.org>; Fri, 10 Nov 2023 19:42:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1699674134; x=1700278934; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vrO2tgVQ3f8COZCWZrWzGZ4qOKpVFdUTSq3nA5o/N9U=;
        b=MaDS9RwgJe+nCWZAwCKrBzGLNa99J7U0Yf+rOF2Wmm5aM6iTkCxn7ACzNSsTSApeb0
         htzSJ6msSQQexP5/WT2CjNOTuTr7DgmL2qOrzrlXdvgFiIdrL6sXila957oNUVXZQkdZ
         L5ZobeobNeV7dhyRzDUvy4PPgFAA2IADiG/Ij3mN6qnZQZoCB2OeZh4HX3mSF1zTFOp2
         48HOMcjKv4DNMVoKwa5HPkV3fPswK04ZON/360dFh7vM4z6bHPa/DLUECN3Cfh1zQvW6
         F2LTLQatAHKm96A18SAFjvNwxwmCSsB490D3fvi7Fq2Gj+2FtTLKOS51wf+OKqb3XoU+
         hhaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699674134; x=1700278934;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vrO2tgVQ3f8COZCWZrWzGZ4qOKpVFdUTSq3nA5o/N9U=;
        b=QxNndSNXS/qys51nW0ULhmQZL8pNoqt4MyS+BUck3LBbrqdv7mWfr9GxL5KU/v+vIc
         sT9nBekZxv3Zt7ZzjLEem9FdHuZ4sTQot0KRJGGYLpREvzaCNrPP19vjaAMHGpguMGmp
         mdFWwFtqMg8BfI2bmQMWlQ/ecQmhnG+OSLefEMCV8z03qJuMlchFcf/YnoCF1XCVyMoX
         7sCKvaGB2jtaB4+srbMyncxb3IzV0BtotrGVuMmawHrpzhQrOMsDCXxk/1AS4k8LOPoo
         4l7x9b+1bf2IWle1mzFeAEh3YXm70mzRgTIVq/xZTGBjM7XEqSffmalOEH4CkdpxyaF3
         9PHA==
X-Gm-Message-State: AOJu0YzPmIRNtPXrp57AkZeE6JpqgR0MvCm0hJ6fhhBFm9izG0IsId8u
	SARO0fstaX7/MfL4CS2tUpGeXXg2o/RIAZS9qWkqMUMIsjThJQ==
X-Google-Smtp-Source: AGHT+IEPwl3LLe2wCf5NO/dec8dHPh5wHmseWIss7wDy8OI1tSbERWfIoKy065mskRtZxAbAl4CGR/H+4QGHLNHaAFQ=
X-Received: by 2002:ac2:5326:0:b0:503:2879:567 with SMTP id
 f6-20020ac25326000000b0050328790567mr283008lfh.28.1699674133852; Fri, 10 Nov
 2023 19:42:13 -0800 (PST)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <ZUpepnSCSxL8i96b@nand.local> <cover.1699381371.git.me@ttaylorr.com>
In-Reply-To: <cover.1699381371.git.me@ttaylorr.com>
From: Elijah Newren <newren@gmail.com>
Date: Fri, 10 Nov 2023 19:42:01 -0800
Message-ID: <CABPp-BESNRXdhzR0MVCNi-F+02BsW3ukGmAgzEk_5xoErs+Fzg@mail.gmail.com>
Subject: Re: [RFC PATCH 0/3] replay: implement support for writing new objects
 to a pack
To: Taylor Blau <me@ttaylorr.com>
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>, 
	Junio C Hamano <gitster@pobox.com>, Johannes Schindelin <Johannes.Schindelin@gmx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Nov 7, 2023 at 10:22=E2=80=AFAM Taylor Blau <me@ttaylorr.com> wrote=
:
>
> (Based on a combination of Christian's cc/git-replay and my
> tb/merge-tree-write-pack branches).
>
> This RFC demonstrates extending the new `--write-pack` option that
> `merge-tree` recently learned to the `replay` builtin as well.
>
> The approach is as follows:
>
>   - write a pack out after each step in the replay operation, so that
>     subsequent steps may see any new object(s) created during previous
>     steps
>
>   - combine those packs into one before migrating them back into the
>     main object store
>
> This is accomplished with a combination of the bulk-checkin and
> tmp-objdir APIs, with some minor modifications made to when we flush out
> and finalize bulk-checkin transactions.
>
> The benefit to this approach is that we bound the number of inodes
> required per replayed commit to a constant (by default, 3: one for the
> .pack, one for the .idx, and another for the .rev file), instead of
> having each operation take an unbounded number of inodes proportional to
> the number of new objects created during that step. We also only migrate
> a single pack back to the main object store.

Isn't it actually 4?  Since you only put blobs and trees into the bulk
checkin packfiles, the commit object will still be loose.

> In other words, this makes the maximum number of inodes required by
> 'replay' grow proportional to the number of commits being replayed,
> instead of the number of new *objects* created as a result of the replay
> operation.

As per comments on the other series, we actually need 2 packs per
commit (when replaying non-merge commits, we don't have to worry about
recursive merges, so 2*depth is just 2), so this would be 7 inodes per
commit (3 files per pack * 2 packs + 1 loose commit object).

I was curious what the comparative number of loose objects might be if
we didn't use the bulk checking, so:
$ cd linux.git
$ git rev-list --no-merges --count HEAD
1141436
$ time git log --oneline --no-merges --name-only | wc -l
3781628
$ python -c 'print(3781628/1141436)'
3.3130442705504293

So, if repositories are similar to linux, that's a bit over 3 files
modified per commit.  It's a bit harder to count trees, but let's take
a wild guess and say that each file is 7 directories (because I'm too
lazy to do real research and 7 happens to give me nice round numbers
later), so that's up to 7*3 tree objects.  So 3 file objects + 21 tree
objects + 1 commit object =3D 25 loose objects.

So, your scheme certainly seems to reduce number of inodes, but does
it introduce a different scaling issue?  git-gc repacks when there are
>=3D 50 packs, or when there are >=3D 6700 loose objects, suggesting that
if we exceed those numbers, we might start seeing performance suffer.
We would hit 50 packs with a mere 25 commits being replayed, and
wouldn't expect to get to 6700 loose objects until we replayed about
268 commits (6700/25).  Does this mean we are risking worse
performance degradation with this scheme than with just using loose
objects until the end of the operation?
