Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A9DEC678DB
	for <git@archiver.kernel.org>; Sat,  4 Mar 2023 11:47:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjCDLp3 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 4 Mar 2023 06:45:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCDLp2 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 4 Mar 2023 06:45:28 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652921A95A
        for <git@vger.kernel.org>; Sat,  4 Mar 2023 03:45:27 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id x11so844045pln.12
        for <git@vger.kernel.org>; Sat, 04 Mar 2023 03:45:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=sduaXnNVwv0jPrPjyJXUl/Z42QGuRHDYnsXaXH5THtM=;
        b=VWx5qWDKA8BPZZi2oTZ2c3joU6+tJ+du02UKiuGKl5sU8zT84xmn4DwuCmo3UFm5uc
         I3tEukpVdZahQKGwIWT2KFu8TOPWRxkL+dvzsyeJJaXqwuc0u2ZXYgOnpvJUSpCAz4lz
         /RKs2umn3GQJRI5SnemKv4XWZGFaGMzGGjLbhprmZMRKy8uNPJCFkUgcw6nS6elYC1x+
         5Y0UoM7Ee/3UwPxiqFDwJ6ZS4sdejiRuwvriXEHTJmUmbrqs+T46CvLMnHl42HIua2ok
         jjAwhJIZ1xxU/K4UbFLSn//9ccFaeTaw7ngsFY0yG44GvnYpeM9Lydl5Nx5A86K4lK69
         c+4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=sduaXnNVwv0jPrPjyJXUl/Z42QGuRHDYnsXaXH5THtM=;
        b=nCISCjoJRWQINMT+RrWCy4GAtlPpQiTJp9mtFXpAi4OtcPC4okW+5e+6HoU/hF/8vw
         xtxiQO51lxZWGl3geLKJwl+EsZLsj/NlnkKI3jxoeOFeKeE6Jmnz5zdrnK/bY6cpL7q3
         C4atsJELBJOI4yMmLQnWCsvOM4jb9oEQ7q9hARuoFayeYvXy4ikP/9cn8dEKjh/1gJyH
         vv0PDFz+7479ME9auAgLHkJ8AjVqmzzNVQvujsdHuhN9VyB98cyOuK7r+2aH75K4lDgl
         qtmsyrUQNMclZ6qzwRQGVloUM3q0DGqaHPTwnvT9nDTFzhb0Nxl7kznf8coaAzN2JHmy
         gffg==
X-Gm-Message-State: AO0yUKWAiCN3yvuhHFIyvvgB3O/aox+Di8vfPv2ycbuKcQ+uh4D41ocY
        iaWmB7u71dzj2U6F0f3tDF5+nTmv99XpdutsAm5UYVZU
X-Google-Smtp-Source: AK7set+CiWcyRWfrZCqEifNwPoDcHcKs4B30lyin4sVOZi8Psv0x9pwC08kCmuUUXeV++FuulMa8NNF/dQVVvYdFJqE=
X-Received: by 2002:a17:90a:7064:b0:230:3b84:9169 with SMTP id
 f91-20020a17090a706400b002303b849169mr1721720pjk.2.1677930326769; Sat, 04 Mar
 2023 03:45:26 -0800 (PST)
MIME-Version: 1.0
References: <20230303145311.513960-1-eantoranz@gmail.com> <xmqqcz5phjgz.fsf@gitster.g>
In-Reply-To: <xmqqcz5phjgz.fsf@gitster.g>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Sat, 4 Mar 2023 12:45:14 +0100
Message-ID: <CAOc6etb9pCXx9S5jxk8Yex++_iai21THU74qdXmOm1XxjHx8Lw@mail.gmail.com>
Subject: Re: [RFC PATCH] sequencer - tipped merge strategy
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Mar 3, 2023 at 5:45=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:
> > With this patch, we leverage the original merge commit to handle the mo=
st
> > obvious case:
> > - HEAD tree has to match the tree of the first parent of the original m=
erge
> >   commit.
> > - MERGE_HEAD tree has to match the tree of the second parent of the ori=
ginal
> >   merge commit.
> > - At least one tree in the merge bases of HEAD/MERGE_HEAD has to match
> >   a tree in the merge bases of the parent commits of the original merge
> >   commit.
>
> The first two conditions look a bit too restrictive for the purpose
> of reusing previous conflict resolution, while I am not sure ...
>
> > If all of those conditions are met, we can safely use the tree of the
> > original merge commit as the resulting tree of this merge that is being
> > attempted at the time.
>
> ...if the "at least one" in the last condition is a safe and
> sensible loosening; if it introduces a mismerge by ignoring bases
> that are different from the original, then it is a bit too bold to
> declare that we can safely use the tree of the original.
>
I think the conditions hold _but_ I will think it through or perhaps
create a few scenarios that we could talk about. Will come back to it
in a few days.

I agree that the current restrictions make it too narrow. Very
restricted scenarios would match at the moment. I will start working
on making this a little bit more accepting to widen the scope.

> What was the motivating usecase behind this new feature?  Was it
> more about reusing the structural merge conflict resolution, or
> about the textual merge conflict resolution?  For the latter, after
> doing the usual three-way file-level merge and seeing a conflicted
> textual merge, requiring the match of the blob objects for only these
> conflicted paths and taking the previous merge result may give you a
> safe way to raising the chance to find more reusable merges.

Usercase can be at the moment trying to rebase (with merges) on top of
an exact base copy. In cases like this, git just crashes on merge
commits. An easy example:

git checkout v2.38.0
git commit --amend --no-edit
git rebase --rebase-merges --onto HEAD v2.38.0 v2.39.0

>
> > +static void load_tree_oids(struct oid_array *oids, struct commit_list =
*bases)
> > +{
> > +     struct commit_list *i;
> > +     for (i =3D bases; i; i =3D i->next)
>
> Using 'i' for a pointer looks novel.  Don't.
>

Thanks for the comments on code. At least it doesn't sound like I
messed up big time.... so far.

>
> I somehow thought that reverting the trashed working tree and the
> index to their original state was not the responsibility for a merge
> strategy but for the caller?  Shouldn't this restoration be on the
> caller's side?
>
> Oh, has this code even touched anything in the working tree and the
> index at this point?  It looks more like everything we did above in
> order to punt by returning 2 was to see if the condition for us to
> reuse the resulting tree holds and nothing else.
>
> Ah, "restore()" is misnamed, perhaps?  I thought it was about "oh,
> we made a mess and need to go back to the state that was given to us
> before failing", but is this the real "ok, the condition holds and
> we can just reuse the tree from the previous merge"?  Then it makes
> sense for the code to attempt to check out that tree and return 2
> when it fails.  Only the function name was misleading.
>

calling _git restore_ to do that hence _restore_ :-) But it's ok. I
can give it a better name.
