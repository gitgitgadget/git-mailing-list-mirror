Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DD9731F461
	for <e@80x24.org>; Thu, 20 Jun 2019 14:58:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbfFTO63 (ORCPT <rfc822;e@80x24.org>);
        Thu, 20 Jun 2019 10:58:29 -0400
Received: from mail-io1-f65.google.com ([209.85.166.65]:45682 "EHLO
        mail-io1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726530AbfFTO62 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 20 Jun 2019 10:58:28 -0400
Received: by mail-io1-f65.google.com with SMTP id e3so617025ioc.12
        for <git@vger.kernel.org>; Thu, 20 Jun 2019 07:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=tc+PAwnYiGFpOcM5Z8bHdm/3ooNvaFJnFjTeBKVJiUs=;
        b=FfsH8yK1N78ooeP/CKyeyi1f9v4PhwmqkHv5NmYNfQM+nBnQCiqTJdMbfdUglJhB8H
         nYvCM3+Had45kkHOXKQClT5aC3kcqaBhaNoiYsA1aEKPdQxiakSu5KTDBliMWysJ01cO
         kxf/isr+mG+gBZJbHtVelej7jTzzkgujtzVSrWUm1isCG/R7ikBR0lHeVKXdPR5oeOlA
         NIZsqgyW/sJzMTFKlcCvcHwvGkvgPSnFwhn/vCVKtt+tArxApmGiAh82XU8IJfYCwY/b
         cgL4bg+JN33bs7p2gvB2iv2oUm/caEZY6WZqgpyFdMxcwa8GrY810tF21GEduHSl/EoI
         TbqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=tc+PAwnYiGFpOcM5Z8bHdm/3ooNvaFJnFjTeBKVJiUs=;
        b=to4yB5HFdnQqWoCHD3Zru1PkPfVNYNLhIpr4gGEHcetK9Mw7KEQuMC2CCG2Buznc6h
         1Rc7P5NJvVCs2qK3FZmMHM+URg30MVG6YubkrLdFenpZCz7EVndPIMFgp0O2Sw7Yf0yG
         xgSMauglAy1EmZUtlR3opFwjVnh3nRA8l44pdeTclsk7sCgXjo5BDciJPEvP2uY49c47
         tVuusmohfqGnAzHNhzhixqsp/aVMWuXu5msJD5IYCeVx7pU8/tyJ3fZzcTJ6nMb5qDip
         ARtqKg0P6bmHh5YNcu20kkD4+mEzhGa7ixo8ipSmRexrP4Mh6SQvgwqkPOwhFP4tnVWV
         2G9g==
X-Gm-Message-State: APjAAAVxm45FhgASFnSdTSsFKnd+YTmXNBkusKIBJx1BAWFXdFiZFw/l
        thYQWP6m9D+ENrb6QoZNs8vzS9H+ZZhoOjV23kOyjA==
X-Google-Smtp-Source: APXvYqwwf7RTdFbg/8ZTyegqzXHe6901sNg2tXoMuVQcFL45nZEpPHvKPzvHuHF53B1Mby5yN71l8GB/0sc48L41+v0=
X-Received: by 2002:a02:3c07:: with SMTP id m7mr72067669jaa.64.1561042707977;
 Thu, 20 Jun 2019 07:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20190620095523.10003-1-pclouds@gmail.com> <20190620095523.10003-5-pclouds@gmail.com>
 <e232fbc4-06ec-d4ed-826a-3bcbc923cafe@gmail.com>
In-Reply-To: <e232fbc4-06ec-d4ed-826a-3bcbc923cafe@gmail.com>
From:   Duy Nguyen <pclouds@gmail.com>
Date:   Thu, 20 Jun 2019 21:58:01 +0700
Message-ID: <CACsJy8BcXU_BfHhkwnK4MA2nQ0ZyBnHN8zMoV+5aK5G+w+uOPg@mail.gmail.com>
Subject: Re: [PATCH 4/4] restore: add --intent-to-add (restoring worktree only)
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jun 20, 2019 at 9:34 PM Derrick Stolee <stolee@gmail.com> wrote:
>
> On 6/20/2019 5:55 AM, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
> > "git restore --source" (without --staged) could create new files
> > (i.e. not present in index) on worktree to match the given source. But
> > the new files are not tracked, so both "git diff" and "git diff
> > <source>" ignore new files. "git commit -a" will not recreate a commit
> > exactly as the given source either.
> >
> > Add --intent-to-add to help track new files in this case, which is the
> > default on the least surprise principle.
>
> I was unfamiliar with this behavior, but did check the 'restore' command
> myself and saw that it would register the file as untracked. I agree that
> could be confusing for a user, so adding it to the staging environment
> makes this more in-line with `git checkout <rev> -- <path>`.

It's actually not the same as "git checkout <rev>" which would restore
<path> in both index and worktree, while "git restore" (no --staged)
only touches worktree . Try "git diff --cached" and "git diff" in both
cases, you'll see the differences.

Or in other words, "git commit" (no -a) after "git checkout" records
the version of <path> from <rev>, while "git commit" after "git
restore" will commit whatever you have before git-restore. "git commit
-a" behaves the same way for both (though it drops <path> without this
patch).

> > @@ -392,6 +393,69 @@ static int checkout_worktree(const struct checkout=
_opts *opts)
> >       return errs;
> >  }
> >
> > +/*
> > + * Input condition: r->index contains the file list matching worktree.
> > + *
> > + * r->index is reloaded with $GIT_DIR/index. Files that exist in the
> > + * current worktree but not in $GIT_DIR/index are added back as
> > + * intent-to-add.
> > + */
>
> Reading this code (and being unfamiliar with the cache array) I thought
> it might accidentally add untracked files from the working directory into
> the index. A local test verified that was not the case. Is that worth
> adding to your test below?

It never occured to me because r->index (before this function) should
be the same as <rev>, more or less. But yeah, adding a garbage file
and checking that it remains garbage is a good idea. I'll rename it
"untracked" though to be clear.
--=20
Duy
