Return-Path: <SRS0=JCNZ=6S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 513DFC3A5A9
	for <git@archiver.kernel.org>; Mon,  4 May 2020 18:03:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31362205ED
	for <git@archiver.kernel.org>; Mon,  4 May 2020 18:03:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cBmVzMRC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731542AbgEDSDe (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 4 May 2020 14:03:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731532AbgEDSDd (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 4 May 2020 14:03:33 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FC6DC061A0E
        for <git@vger.kernel.org>; Mon,  4 May 2020 11:03:33 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id y3so220149wrt.1
        for <git@vger.kernel.org>; Mon, 04 May 2020 11:03:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=j2vs5vTqV0kYghYVLFUDoFOBLuEvVi64mCkOWIcbayk=;
        b=cBmVzMRCW3rdUYmsNamWkP1BiYzN1/0MuiYbmJW0fCYXyAsnrl94ELA2ZBTu37Roe/
         zqHScHkpAHSw3CDRlYROL8hVnuOzAJ5NE68u37w1Y4PjsYb3QtgWPOMMmY7+X0zvGaZ8
         0zTwUbb3MqU3j2QdLdlNgSKOWIBlN+7ZmQWGRAcRrtG7+fAZhLPNTtw6eN3CLMQCgwin
         MnRBeLKN/rVIvmaxbRRrjT/213D6e2aMdeQwddK0zdq6/f3JWJ2M/YAU7NjoaASGAt4p
         RklPRJEPA6JfUdqZwTi4qzw3NWhGrFQaFaOUQZnFjob0qhuqRn/bYhLv/oRGqBiKidKY
         XvDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=j2vs5vTqV0kYghYVLFUDoFOBLuEvVi64mCkOWIcbayk=;
        b=QOyU6Whl04SOlDuVXC1JqNEwMu2t76vecQXnjKB5nM7YI+DkuDOtiw8Oowx/jIHvhA
         twEKeUwVBNUmWdAV2kRz3N2/ikyVjOOJO/quB89K0msrK4LEieIORz+ENq47he+IRwzH
         v99To+O4Nj7VvlwfvBu3SjFPGi8hUExaVJL2D/NgvFEkp88QZu8qRD7vOf2Z23YSt9vS
         esGPaSnKxksJX5fZMpsu+WyoHkhWtlMvi9pQ5NWtNVXJqCEkrrhqq2t3BQZBsm15x77A
         zk5QiCho6ZY9by5U9qKF9eVygrXnCcp4AOG0EY/+M4zHtQ7fbxvyUVjQnZU/IGezQt3J
         j8ag==
X-Gm-Message-State: AGi0PuaShLlj4Yq1EHzhgRkiMIIV1FdFoyouAlKjUNbTucfF8ew76/ps
        yPBmGARyYzEnRD1mRUUCFu+Kr6IDEPlk5hmKFjCyMw==
X-Google-Smtp-Source: APiQypLTFGRPNkUh5p33yYyyX0kNNDcv5jbg2+s9hNHNwr00XwCPbIm+5Jpr6D97V1Cuf3MFz55+Ike0bFfW9nh2Xfo=
X-Received: by 2002:a5d:5404:: with SMTP id g4mr514575wrv.310.1588615411485;
 Mon, 04 May 2020 11:03:31 -0700 (PDT)
MIME-Version: 1.0
References: <pull.539.v9.git.1587417295.gitgitgadget@gmail.com>
 <pull.539.v10.git.1588018418.gitgitgadget@gmail.com> <45fd65f72e097dcabba6ea15b1d54c85e7271593.1588018418.git.gitgitgadget@gmail.com>
 <20200430211714.GE77802@google.com>
In-Reply-To: <20200430211714.GE77802@google.com>
From:   Han-Wen Nienhuys <hanwen@google.com>
Date:   Mon, 4 May 2020 20:03:19 +0200
Message-ID: <CAFQ2z_M_hG8zD9R41DLqB3X_Me42F_Ron_87eqCnaGd8K17POQ@mail.gmail.com>
Subject: Re: [PATCH v10 02/12] Iterate over the "refs/" namespace in for_each_[raw]ref
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Han-Wen Nienhuys via GitGitGadget <gitgitgadget@gmail.com>,
        git <git@vger.kernel.org>, Han-Wen Nienhuys <hanwenn@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Apr 30, 2020 at 11:17 PM Emily Shaffer <emilyshaffer@google.com> wr=
ote:
>
> On Mon, Apr 27, 2020 at 08:13:28PM +0000, Han-Wen Nienhuys via GitGitGadg=
et wrote:
> >
> >
> > This happens implicitly in the files/packed ref backend; making it
> > explicit simplifies adding alternate ref storage backends, such as
> > reftable.
>
> As an outsider to this part of the codebase, a little more explanation
> could be handy in the commit message. I found the backends you mentioned
> in refs, and it seems like they're the only two, but it's not obvious
> how this delta is related to those backends. Furthermore, grepping looks
> like this function whose behavior is changing is being called from
> somewhere else, with no change to that function (and it looks like the
> callsite's callback doesn't check whether a ref begins with refs/ or
> not).
>
> All this to say - it's hard to convince myself this is a safe change,
> and I'd really like to read more to understand why you made it.

I'll be the first to admit that I'm on shaky ground here. However,
given that the test suite passes, if this is breaking some behavior,
it's probably not very well tested behavior.

Here is what I know:

Git stores refs in multiple places:
- normal refs, packed: .git/packed-refs
- normal refs, loose: under refs/*/
- special refs: HEAD, ORIG_HEAD, REBASE_HEAD.

Currently, the special refs can only be read with refs_read_raw_ref().
If you iterate over the refs in the files/packed backend, you can
never find HEAD, ORIG_HEAD etc.

Reftable does not have different classes of ref storage, so this means
that the whole space of refs (including HEAD) is managed by the
reftable backend, and if you iterate over the refs, reftable will also
produce HEAD. This is not spelled out in the spec, but JGit actually
stores HEAD in reftable too, and we want to be interoperable.

Without this patch, commands like "git show-ref" will produce an entry
"HEAD", which is a regression.

With this patch, the default iteration is limited to the "refs/"
prefix, so we don't produce HEAD in the reftable backend by default.

Now, I have several questions:

* how does this interact with worktrees? It seems that there is a
special worktree namespace?
* if you are doing a rebase, and have unreachable objects in
ORIG_HEAD, REBASE_HEAD, how does git-gc ensure that these objects stay
alive? I'd think that you need to iterate over all entries (including
REBASE_HEAD and friends), but I haven't been able to understand how
that works.

--=20
Han-Wen Nienhuys - Google Munich
I work 80%. Don't expect answers from me on Fridays.
--

Google Germany GmbH, Erika-Mann-Strasse 33, 80636 Munich

Registergericht und -nummer: Hamburg, HRB 86891

Sitz der Gesellschaft: Hamburg

Gesch=C3=A4ftsf=C3=BChrer: Paul Manicle, Halimah DeLaine Prado
