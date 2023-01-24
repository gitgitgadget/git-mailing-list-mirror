Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61A65C25B50
	for <git@archiver.kernel.org>; Tue, 24 Jan 2023 03:18:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232496AbjAXDSL (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 22:18:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjAXDSK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 22:18:10 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FCCC2B087
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 19:18:09 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id p25so15297596ljn.12
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 19:18:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmEqyGPkYr5HGr4apunJ0SL8EAOf+YnHZhN5/Gj1fCs=;
        b=Qm3Y9RqWJlirB/V8zcHPhpuduJkjtO5bef77BzTRXmctW4mTSOtA/Fz+LSAX2K8g9T
         CVcVNQPLt7c80RxApOGryoVcOQNxThy3t+iFdGT4FE5fDt/tTrYwa345+XSdss/s8gc5
         ArAP2Lkc2uOY22GxgiHPQSA+ntOtInYGmKaga6sCQkzd0ypgv6sEn+lQ84zVq7j8nH2x
         9Af4WQynTtxb1/7+80Cd+eQSRcsFVwTQ66/ig6/m5fP2Ie5lxoIiruXdEh95ptOvzD8C
         0+DK9vQaZNTP5cfRhNbXzf7AOgCEWj3nABj1vRkqBXH6S5bu6A49K5zLAYg5/rUHTuAD
         0iaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmEqyGPkYr5HGr4apunJ0SL8EAOf+YnHZhN5/Gj1fCs=;
        b=BBQrp6WDF0BNL07RoYKOkud2weiM215AIwVw1P7iOF+CNwvilwbQaiZV33Irvchsas
         P8zb3DocVIu1v0QJHsEdaIRkrfzbAI6Wvh8dHaWZoKVDNHFZIxDNBFTaXlUtAK1aF5mx
         xPWNlTT1NKt2koIL4R2iYYFUpbGy6tseMgjLscZ8eQd0YMCLxGbvcxPIIDb6JO6vlUzL
         xNmvKRb+tBWZ0/dostcFbpVnW2dIeT1Ua5/StaREc2bSL3dmrp/06WQ0d3UirPfcnV8I
         IJJUOy3+fCGxJnt3zKezFd7WCYXu0fGIxVYxPw5rCve438fnzuvZ8UtBSzb4ExSQOlN3
         h76g==
X-Gm-Message-State: AFqh2kqdVgyQ27Kqcg9oYAEG5OCO3IY8SVUme0Aq3RDUtX0BbGFzaxZt
        CDkJK2SyM8YDCIGYE6X+ynjA6iV80PpRy4mWm+09oS4+
X-Google-Smtp-Source: AMrXdXvV9VnljI1F2f6YYRgh6PD2I13/4w9bq/Doujg1lmho5qPE8k2SuorrT7d+sclNv+7mCJoSmKtutvA8n5bPMYM=
X-Received: by 2002:a2e:9d99:0:b0:27f:e221:293c with SMTP id
 c25-20020a2e9d99000000b0027fe221293cmr2498101ljj.163.1674530287523; Mon, 23
 Jan 2023 19:18:07 -0800 (PST)
MIME-Version: 1.0
References: <pull.1367.v3.git.1665269538608.gitgitgadget@gmail.com>
 <pull.1367.v4.git.1667714666810.gitgitgadget@gmail.com> <CAOLTT8TzpfoH7pz7gxgFvNWOaUZUcg1q_Tap+2anwHfAUgDV8Q@mail.gmail.com>
 <CABPp-BHaKH4sOPx2tx7CU+Uymvtu=mU1ZweGBDdWvhb-FgGA_Q@mail.gmail.com>
 <CAOLTT8SCtHD1KeLdRQ9cJNVm-uAae+=ii6L6r4DYDb4Lr4miSQ@mail.gmail.com>
 <CABPp-BF5npQrgoqE7cECJgsNpg7OWmVQrhEd=bm-KcpjsKhkvA@mail.gmail.com> <CAOLTT8S3qaA7E0=qMHOKKs7F3zcNeXnscL-VrP3pVSHmxc7YZw@mail.gmail.com>
In-Reply-To: <CAOLTT8S3qaA7E0=qMHOKKs7F3zcNeXnscL-VrP3pVSHmxc7YZw@mail.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 23 Jan 2023 19:17:00 -0800
Message-ID: <CABPp-BGw2O5o1Erbih3a=cgk_H3=taYwpn5Mpedbx=HB1yxUfw@mail.gmail.com>
Subject: Re: [PATCH v4] sparse-checkout.txt: new document with sparse-checkout directions
To:     ZheNing Hu <adlternative@gmail.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>,
        Matheus Tavares <matheus.bernardino@usp.br>,
        Glen Choo <chooglen@google.com>,
        Martin von Zweigbergk <martinvonz@google.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 23, 2023 at 7:05 AM ZheNing Hu <adlternative@gmail.com> wrote:
>
> Elijah Newren <newren@gmail.com> =E4=BA=8E2023=E5=B9=B41=E6=9C=8820=E6=97=
=A5=E5=91=A8=E4=BA=94 12:30=E5=86=99=E9=81=93=EF=BC=9A
> >
> > On Sat, Jan 14, 2023 at 2:19 AM ZheNing Hu <adlternative@gmail.com> wro=
te:
[...]
> > > Yeah, it seems that git status fetch these .gitigore files.
> > > So what's the wrong here?
> >
> > Nothing; this looks exactly as I'd expect.
> >
> > `git status` is supposed to check whether untracked files are ignored
> > or not, and it needs .gitignore files to do so.  If an entire
> > directory is missing, then it can avoid loading a .gitignore under
> > that directory, but you set up your patterns such that no directory is
> > likely to be excluded.
> >
>
> This may be a bit strange, why doesn't the cone mode have this problem?

I wouldn't classify it as a problem.  But, cone mode technically can
experience the same behavior too, it's just that it should be fairly
rare.  That's because...

In a working tree, if an entire directory is missing, then obviously
there are no files inside that directory.  If there are no files, then
there cannot be any untracked files.  Since there are no untracked
files within that directory, we do not need to find out which of those
0 files within that directory are ignored.  Therefore, we do not need
the .gitignore file(s) underneath that missing directory.  Since in
cone mode you only have the entire directory or none of it, whenever
we are missing a .gitignore file, it is because we are missing the
whole directory and the entire directory will be missing from the
worktree too.  So, we simply don't typically need the .gitignore files
outside the sparse patterns.

If the directory is present, though, then you do need the .gitignore
files so that you can classify untracked files within that directory
into ignored and non-ignored categories.

Since non-cone mode tends to leave the directory around and have some
files in it, you are going to need the .gitignore files for `git
status` to correctly operate.  That seems to me to be pretty intrinsic
to that mode.

Now, cone mode can also experience this behavior by having a directory
present in the worktree which is normally meant to be missing.  This
could happen due to the user manually creating the directory, or could
be done by git if e.g. there are conflicts in directories outside the
sparse cone when merging/rebasing/etc.  Either of those cases would be
rare, but in such a case we would need to download the .gitignore
files within those directories as well.  But, again, that'd make sense
because we want to know which untracked files in the present directory
are ignored when we run `git status`, so we need the .gitignore files.

> > Maybe there are other special cases that one could attempt to handle
> > (e.g. first check if there are any untracked files in a directory and
> > only then check for which are ignored, but that'd probably take some
> > big refactoring of some hairy dir.c code to accomplish something like
> > that, and you'd have to be really careful to not regress the
> > performance of non-sparse cases).  Personally, I don't think it's
> > worth it.  If you really don't like it, I'd suggest choosing any one
> > of the following ways to avoid it:
> >
>
> This "bug" may not be very important, because it has no application
> at present,  scalar also uses cone mode by default.

I don't consider it a bug.  However, you have some statements below
which appear contradictory to me, which may suggest that I'm
misunderstanding what you are saying or misunderstanding the project
setup you have.

> >   * Include the .gitignore files in your sparse-checkout; might as
> > well since you're going to get them anyway.
>
> This can also seem like a pain in the butt because of the extra
> unnecessary .gitigore downloads.

Why are you calling them unnecessary?  Aren't they required for
correct operation of `git status`?

> >   * Set status.showUntrackedFiles to `no` so that .gitignore files are
> > irrelevant
>
> This may also be a temporary rather than a complete solution.

How so?  Do you expect users to override this option?  If so, isn't
that because they are interested in untracked files and likely want to
know which ones are not ignored?  And if so, isn't it then fine that
we download the .gitignore files needed to answer their questions?

> >   * Use cone mode instead of non-cone mode (and yes, restructure your
> > repo if needed)
>
> No, I might think cone mode has some other disadvantages: it includes
> too many files. I would prefer to get the behavior of non-cone mode.

I understand that restructuring a repository might not be enticing for
a variety of reasons, and sometimes is just flat impossible.  That may
well be the case for you, but I just want to point out that your
reason for not choosing this option seems to suggest you didn't
understand the choice as I worded it, because:

Using cone mode does not necessarily imply more files, once you allow
for restructuring the repository.  If you restructure your repository
such that the files you don't want in your sparse-checkout are in a
separate directory, and you then use cone mode to select directories
other than the ones with files you want excluded, then cone mode would
give you the exact same selection of files as non-cone mode.

[...]
> >   * Remove the .gitignore files and commit their deletion.  Just do
> > without them, somehow.
>
> That's not a proper solution absolutely.

Why not?  Above you called the .gitignore files "unnecessary".  If
they are unnecessary, then surely you can just get rid of them?

The point of the .gitignore files is to allow git to classify
untracked files as either ignored or not.  If classifying untracked
files as ignored-or-not is important to you, then `git status` needs
to download these files in order to do that classifying whenever there
are any untracked files.  So, the question for you is whether this
classifying is necessary.  If it's not necessary, then just delete the
files since they serve no other purpose.  If it is necessary, then why
complain that they are downloaded?
