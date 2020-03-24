Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A0A29C10DCE
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 22:55:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C1B320722
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 22:55:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=usp-br.20150623.gappssmtp.com header.i=@usp-br.20150623.gappssmtp.com header.b="1HjXGtQt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727444AbgCXWzn (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 Mar 2020 18:55:43 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:46350 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727250AbgCXWzm (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 Mar 2020 18:55:42 -0400
Received: by mail-lj1-f195.google.com with SMTP id v16so420217ljk.13
        for <git@vger.kernel.org>; Tue, 24 Mar 2020 15:55:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=usp-br.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kThpI+cLTo+wa+6jMiZ/wALY0vGcYIdaLJDrPcR1hDo=;
        b=1HjXGtQtliLJWea8Gj8GRpJdjw2HEbexweWwj+Q7r2JeundUkB/YouRzr+y4CoQsRc
         QutQHi/E4g9rYyIWgTGbDFo7JzepqDeR+kK8P3/dcYIpEoiMWRv0gtWmcYjYGGnA5XmJ
         uOm+bOAIVVCXBlOrAbg9k7JVRBMFf/La3Cnw9QbOTaUlfW0Eh0X9oiZDph1Y4o1ivebR
         /DNjDzhH/3IVGhLyGBVwVjn9Z8wwAzPUNB0c/MOEltetTGW443tFrVGmNX+94cpx81zq
         SgpnqW5o3E2u9/HD8MW0ZX7mz73ExvYE+zmET6JUSK+g+h8yxfFp9/+O+ZAipvcENwB/
         pc/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kThpI+cLTo+wa+6jMiZ/wALY0vGcYIdaLJDrPcR1hDo=;
        b=tYdR0TWVlSeV/iCO4cbi6xoDE+64wuyE3wk6qBN26UTBmRYDKO3+3vxMT6BtWRiNDY
         3C/soSE5BiwAbps19VV5G9rlNRlAQhR36F2+3GpexevYJacW93wSVeFFiNJpa2HKIobT
         hpfuXo2W3VWlFKsjD+3WK7yqx8snYa0TQUeoWxsrnhGwb+7VEVX3hybJq84pSUX+B46Y
         MOHixthdc1Bv6kzqbNyuEqw0adws/ljumqTDL/V7npJO8L5bmNcHRLDc6f2LvQvGRMVf
         jaajmjOR+Jl1Qt/VIfSbqw9omokK10K21xDzlKelP+6XUdBMed5sW+RUtKND7sfgIvaG
         9EQw==
X-Gm-Message-State: AGi0PuYgfz5M31hDpEEq50zNMcPsiTX4xJgdE56wirvKeMwR6eDURNQD
        bJS7BA7zEKoMvsuBkkrDJs/V57AL/hhaZwbeyqMS/y26efY=
X-Google-Smtp-Source: ADFU+vuNrH2AjbmC81Jr78lbf94w1n3lKSu9XBNixNsfQJMulU4tkHf3cMWgrlAsX35bcMtEkLu4y8t6nBuZcippz4s=
X-Received: by 2002:a2e:964e:: with SMTP id z14mr65221ljh.44.1585090538965;
 Tue, 24 Mar 2020 15:55:38 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1585027716.git.matheus.bernardino@usp.br>
 <0b9b4c4b414a571877163667694afa3053bf8890.1585027716.git.matheus.bernardino@usp.br>
 <CABPp-BHbrGGjV_22kwTERn19RaWk73_Y6tzWnjwO9u4isCRpVg@mail.gmail.com>
In-Reply-To: <CABPp-BHbrGGjV_22kwTERn19RaWk73_Y6tzWnjwO9u4isCRpVg@mail.gmail.com>
From:   Matheus Tavares Bernardino <matheus.bernardino@usp.br>
Date:   Tue, 24 Mar 2020 19:55:27 -0300
Message-ID: <CAHd-oW7yfD74ymARoOHXUqB==RcS36S-8D4M8ysAoVcC6GBR9A@mail.gmail.com>
Subject: Re: [RFC PATCH 2/3] grep: honor sparse checkout patterns
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Derrick Stolee <dstolee@microsoft.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        Stefan Beller <stefanbeller@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 24, 2020 at 4:15 AM Elijah Newren <newren@gmail.com> wrote:
>
> On Mon, Mar 23, 2020 at 11:12 PM Matheus Tavares
> <matheus.bernardino@usp.br> wrote:
> >
> > Something I'm not entirely sure in this patch is how we implement the
> > mechanism to honor sparsity for the `git grep <commit-ish>` case (which
> > is treated in the grep_tree() function). Currently, the patch looks for
> > an index entry that matches the path, and then checks its skip_worktree
>
> As you discuss below, checking the index is both wrong _and_ costly.
> You should use the sparsity patterns; Stolee did a lot of work to make
> those correspond to simple hashes you could check to determine whether
> to even walk into a subdirectory.  So, O(1).  Yeah, that's "only" cone
> mode but the non-cone sparsity patterns were a performance nightmare
> waiting to rear its ugly head.  We should just try to encourage
> everyone to move to cone mode, or accept the slowness they get without
> it.

OK, makes sense. And your reply to Stolee, later in this thread, made
it clearer for me why checking the index is not only costly but also
wrong. Thanks for the great explanation! I will use the sparsity
patterns directly, in the next iteration.

> > diff --git a/builtin/grep.c b/builtin/grep.c
> > index 99e2685090..52ec72a036 100644
> > --- a/builtin/grep.c
> > +++ b/builtin/grep.c
> > @@ -388,7 +388,7 @@ static int grep_cache(struct grep_opt *opt,
> >                       const struct pathspec *pathspec, int cached);
> >  static int grep_tree(struct grep_opt *opt, const struct pathspec *pathspec,
> >                      struct tree_desc *tree, struct strbuf *base, int tn_len,
> > -                    int check_attr);
> > +                    int from_commit);
>
> I'm not familiar with grep.c and have to admit I don't know what
> "check_attr" means. Slightly surprised to see you replace it, but
> maybe reading the rest will explain...
...
>>                 if (S_ISREG(entry.mode)) {
>>                         hit |= grep_oid(opt, &entry.oid, base->buf, tn_len,
>> -                                        check_attr ? base->buf + tn_len : NULL);
>> +                                       from_commit ? base->buf + tn_len : NULL);
>
> Sadly, this doesn't help me understand check_attr or from_commit.
> Could you clue me in a bit?

Sure! The grep machinery can optionally look the .gitattributes file,
to see if a given path has a "diff" attribute assigned to it. This
attribute points to a diff driver in .gitconfig, which can specify
many things, such as whether the path should be treated as a binary or
not. The "check_attr" flag passed to grep_tree() tells the grep
machinery if it should perform this attribute lookup for the paths in
the given tree.

I decided to replace it with "from_commit" because the only times we
want an attribute lookup when grepping a tree, is when it comes from a
commit. I.e., when the tree is the root. (The reasoning goes in the
same lines as for why we only check sparsity patterns in git-grep for
commit-ish objects: we cannot check pattern matching for trees which
we are not sure to be rooted). Since "knowing if the tree is a root or
not" is useful in grep_tree() for both sparsity checks and attribute
checks, I thought we could use a single "from_commit" variable instead
of "check_attr" and "check_sparsity", which would always have matching
values. But on second thought, I could maybe rename the variable to
something as "is_root_tree" or add a comment explaining the usage of
"from_commit".

(I'm not a big fan of "is_root_tree", thought, because we could give a
root tree to grep_tree() but not really know it.)

> > diff --git a/t/t7817-grep-sparse-checkout.sh b/t/t7817-grep-sparse-checkout.sh
> > new file mode 100755
> > index 0000000000..fccf44e829
> > --- /dev/null
> > +++ b/t/t7817-grep-sparse-checkout.sh
...
> > +test_expect_success 'setup' '
> > +       echo "text" >a &&
> > +       echo "text" >b &&
> > +       mkdir dir &&
> > +       echo "text" >dir/c &&
> > +       git add a b dir &&
> > +       git commit -m "initial commit" &&
> > +       git tag -am t-commit t-commit HEAD &&
> > +       tree=$(git rev-parse HEAD^{tree}) &&
> > +       git tag -am t-tree t-tree $tree &&
> > +       cat >.git/info/sparse-checkout <<-EOF &&
> > +       /*
> > +       !/b
> > +       !/dir
> > +       EOF
> > +       git sparse-checkout init &&
>
> Using `git sparse-checkout init` but then manually writing to
> .git/info/sparse-checkout?  Seems like it'd make more sense to use
> `git sparse-checkout set` than writing the patterns directly yourself.
> Also, would prefer to have the examples use cone mode (even if you
> have to add subdirectories), as it makes the testcase a bit easier to
> read and more performant, though neither is a big deal.

OK, I will make use of the builtin here. I will also use the cone mode
(and leave one test without it, as Stolee suggested later in this
thread).

> > +test_expect_success 'grep <tree-ish> should search outside sparse checkout' '
>
> I think the test is fine but the title seems misleading.  "outside"
> and "inside" aren't defined because <tree-ish> isn't known to be
> rooted, meaning we have no way to apply the sparsity patterns.  So
> perhaps just 'grep <tree-ish> should ignore sparsity patterns'?

Right! "should ignore sparsity patterns" is a much better name, thanks.

Thanks a lot for the thoughtful review and comments!
