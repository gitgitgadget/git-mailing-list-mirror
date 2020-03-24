Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DDCAC43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 16:16:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5514020774
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 16:16:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="N/EZgbUH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728706AbgCXQQw (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 12:16:52 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:34560 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727444AbgCXQQw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 12:16:52 -0400
Received: by mail-ot1-f67.google.com with SMTP id j16so17589363otl.1
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 09:16:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aLvMNL+AuZ6locqt39tmyvIp1igxcvbrFtwgBKKUpTU=;
        b=N/EZgbUHfrIadJ3pHVp3aEzJczuN5nYGbzaicHDcMBoBfbc76KYCkc8fopBBeUGB22
         1TNjeHv+arRzEjMzN3GkwSvOoVeatMm9dEkLvvzVM1TtMuiqd1m8ejR8YJlKBTSVfEWO
         VRh+/AN9IeP2BmlcqJoqQWeZgl6bX+i7zqJlkrvQM0KUO0kSsa2ELBgF5F3J3ATKmZeP
         DXzeBHUpRlXfIkMhIkoDkkc8krmEWUU1YPTz2EzTon/ftkmxlATun2hCL6VNYISAzOZb
         4qp4I/4lg2eFrsyv4sSrRbskG5t0KYclNsh8PNGthsF+8tPY3swAZWSSTtTdVUFw6/6t
         b9Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aLvMNL+AuZ6locqt39tmyvIp1igxcvbrFtwgBKKUpTU=;
        b=U+1/GXd4az7KW5l3F6cinV3/bAqB7oIrjUYqZpKf9bicc1kNBIXFCmxruxATarn7Ft
         b/eqMx/ik8ZXLszhT2rpoGUTz8zlYJYHw2AWstWL/LU1zT9sDxFYx/KXrktmtXbIn7Fu
         wKrp7FhrTViTft+MZxjz0ONiJq4Xrd2Onn5a5yJzaUeChhJFZTMYCXXCc2n5Cb/DBfOt
         YSRvC4hhsyN795Td2JOxRYVmbg4MLtQfuFn02cPAmkN5WBWnTiexX79MnT23PLn4THLu
         4NColTsJH6pX5NHxN23WkgkJHmQCqKouHb1gUiaPK/fpRIf/Kud0917NnIhpUb1+MzYS
         IIwA==
X-Gm-Message-State: ANhLgQ3e/OumBmQajVIBl5KFzxoHkJETyicalYeD6rhR5gp5SFSDI7Ij
        V2EdOrtVhLzjw8vRveQ8S2dXxBNlOCzCUle/Dok=
X-Google-Smtp-Source: ADFU+vvqSY9DbHzn1WF1MJTeox/Vh+2XYT6sThuavnhHIa78fk2OdvCcWJvBdaDfMOhkbQK50OYMJNTjzLfAwtmarO8=
X-Received: by 2002:a05:6830:2428:: with SMTP id k8mr2784557ots.345.1585066609318;
 Tue, 24 Mar 2020 09:16:49 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <0b9b4c4b414a571877163667694afa3053bf8890.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BHbrGGjV_22kwTERn19RaWk73_Y6tzWnjwO9u4isCRpVg@mail.gmail.com> <59c04216-8dd9-cbbf-a869-a65ed8ca6e0a@gmail.com>
In-Reply-To: <59c04216-8dd9-cbbf-a869-a65ed8ca6e0a@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 24 Mar 2020 09:16:38 -0700
Message-ID: <CABPp-BFf-A_a=_02gP_=kBFmQmpM8udFZyrq17Co_u+QWURFKw@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] grep: honor sparse checkout patterns
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Matheus Tavares <matheus.bernardino@usp.br>,
        Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 24, 2020 at 8:12 AM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 3/24/2020 3:15 AM, Elijah Newren wrote:
> > Hi Matheus,
> >
> > On Mon, Mar 23, 2020 at 11:12 PM Matheus Tavares
...
> >> Something I'm not entirely sure in this patch is how we implement the
> >> mechanism to honor sparsity for the `git grep <commit-ish>` case (which
> >> is treated in the grep_tree() function). Currently, the patch looks for
> >> an index entry that matches the path, and then checks its skip_worktree
> >
> > As you discuss below, checking the index is both wrong _and_ costly.
>
> I'm not sure why checking the index is _wrong_, but I agree about the
> performance cost.

Let's say there are two directories, dir1 and dir2.  Over time, there
have existed a total of six files:
   dir1/{a,b,c}
   dir2/{d,e,f}
At the current time, there are only four files in the index:
   dir1/{a,b}
   dir2/{d,e}
And the user has done a `git sparse-checkout set dir2` and then at
some point later run `git grep OTHERCOMMIT foobar`.  What happens?

Well, since we're in a sparse checkout, we should only search the
relevant paths within OTHERCOMMIT for "foobar".  Let's say we attempt
to figure out the "relevant paths" using the index.  We can tell that
dir1/a and dir2/a are marked as SKIP_WORKTREE so we don't search them.
dir1/c is untracked -- what do we do with it?  Include it?  Exclude
it?  Carrying on with the other files, dir2/d and dir2/e are tracked
and !SKIP_WORKTREE so we search them.  dir2/f is untracked -- what do
we do with it?  Include it?  Exclude it?

We're left without the necessary information to tell whether we should
search OTHERCOMMIT's dir1/c and dir2/f if we consult the index.  Any
decision we make is going to be wrong for one of the two paths.

If we instead do not attempt to consult the index (which corresponds
to a version close to HEAD) in order to ask questions about the
completely different OTHERCOMMIT, but instead use the sparsity
patterns to query whether those files/directories are interesting,
then we get the right answer.  The index can only be consulted for the
right answer in the case of --cached; in all other cases (including
OTHERCOMMIT == HEAD), we should use the sparsity patterns.  In fact,
we could also use the sparsity patterns in the case of --cached, it's
just that for that one particular case consulting the index will also
give the right answer.
