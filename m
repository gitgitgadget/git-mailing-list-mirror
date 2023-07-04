Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EAB9EB64D9
	for <git@archiver.kernel.org>; Tue,  4 Jul 2023 22:24:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231189AbjGDWYZ (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 4 Jul 2023 18:24:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbjGDWYY (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Jul 2023 18:24:24 -0400
Received: from mail-oo1-xc30.google.com (mail-oo1-xc30.google.com [IPv6:2607:f8b0:4864:20::c30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F78DE6D
        for <git@vger.kernel.org>; Tue,  4 Jul 2023 15:24:23 -0700 (PDT)
Received: by mail-oo1-xc30.google.com with SMTP id 006d021491bc7-5636ab8240cso3101193eaf.3
        for <git@vger.kernel.org>; Tue, 04 Jul 2023 15:24:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688509462; x=1691101462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+LkrcKiG0w15d0J0s3t6P0haQOAA3XinryMp4YiJx4U=;
        b=ErXWSHy9YOzMeycu4C4ju7s0PLzRZ54xRCs0NOILfVbINpFJjvIiYWDgNSDBj1vc42
         KLVqMlfahHlPGY/9ixFWwJr+6SCBjsIRexluqr5vPTQYPDS04qq3O4rCFYbLZFfNGsRK
         +FEYJlftzCs1vWgjBg1X3vzEiNOTozJjncufzjn1rGWE6rgN8cVjpp4dI8oWpnQi0EcH
         YuQrB8FNrtGfq6sYPm1MgrTTojD/k2PkCBwteJjb/2F89oPmV9XgxRhV55vO1Ll/31zp
         IoiGAqU/opRHuX2QQNrxnHByVHO8pZLgMh2rzfbuXHai7MbP24oTHrN0tdWNHgTw7ko+
         Hj6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688509462; x=1691101462;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+LkrcKiG0w15d0J0s3t6P0haQOAA3XinryMp4YiJx4U=;
        b=PWZ95LclR9qt9dxbZpvm/oyCF3qukIBPlaLmG+0lBCXXltJMa3wr2HAT2XFold4e9F
         HuwlghIEGaFzrl2qbT2QZdDTd/3gWkxN+XYtaKLwfzrJQhpkTF4AbSFzJJCgJYUgk3e2
         vfCktF+rsoMpjm54t9rESvGXwgqO0LeSgKyZRZ1yKToADb2lL6t4ZZ2ecEdRYQjIbTAa
         /z45m6Nr4DSBQkDXX6W+TnDse6oEPPC3haUp3IU+Swa9L2Uo8J/XM/jGUriml6rr/QhV
         t7UhHWCkwGkY2QuAN/nhYFmEAvRmsMLseDr++c1qCbYKqvcmXTvpa/4NhP06WOpUgarC
         jdoQ==
X-Gm-Message-State: AC+VfDz0pMATIrPZk9GSVU8FhSPcPBnbVenJSFwT1gKVkWESjpfpMjZz
        slDme+jsM9JfVpfh41SRbMTAIhqGA9/tHYbmp2UFKGs2
X-Google-Smtp-Source: ACHHUZ6kWJ+DUOU+V+hkaRmqUiKVSyW4HohfQzDQsX5Cc3IYSz+V50L5ZIISBo2QeJCk0hfzN+5NNwrFiG2o53w3UwE=
X-Received: by 2002:a4a:4582:0:b0:563:4302:c15c with SMTP id
 y124-20020a4a4582000000b005634302c15cmr9029623ooa.1.1688509462201; Tue, 04
 Jul 2023 15:24:22 -0700 (PDT)
MIME-Version: 1.0
References: <20230702200818.1038494-1-alexhenrie24@gmail.com>
 <c3c36f93-3fc5-7f7d-1c24-e6925729cc96@gmail.com> <xmqqv8ez4ajb.fsf@gitster.g>
In-Reply-To: <xmqqv8ez4ajb.fsf@gitster.g>
From:   Alex Henrie <alexhenrie24@gmail.com>
Date:   Tue, 4 Jul 2023 16:24:00 -0600
Message-ID: <CAMMLpeS5QJrFFnN14n33_LiaN9MP5Ea=HV24ZFM30zPnmhoqZw@mail.gmail.com>
Subject: Re: [PATCH 0/2] advise about force-pushing as an alternative to reconciliation
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Phillip Wood <phillip.wood123@gmail.com>, git@vger.kernel.org,
        git@matthieu-moy.fr, christiwald@gmail.com, john@keeping.me.uk,
        philipoakley@iee.email
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jul 4, 2023 at 3:44=E2=80=AFPM Junio C Hamano <gitster@pobox.com> w=
rote:

> > On 02/07/2023 21:08, Alex Henrie wrote:
> >> Many times now, I have seen novices do the following:
> >> 1. Start work on their own personal topic branch
> >> 2. Push the branch to origin
>
> And did this succeed, or did this fail?  I'd assume that it failed,
> because othrewise you would not be rebasing your work done in #1 on
> top of what the central repository has.  Also ...

It succeeded; the new branch was created on origin.

> >> 3. Rebase the branch onto origin/master
>
> ... the user's better have done "git fetch" to update origin/master
> before this step.  And that means this can just be done with "git
> pull --rebase" (or you may already have configured pull to do so).

Yes, the rebase was performed with `git pull -r origin master`. Other
work had been done on master while the topic branch was being worked
on.

> In any case, assuming that this was indeed the intention of the
> user, i.e. the user never wanted to discard the changes made in the
> central repository (presumably by others)...

The user did not want to discard anything from master, but they
absolutely did want to discard the obsolete version of their own
branch, which they made themself.

> >> 4. Try to push again, but Git says they need to pull
>
> ... if this happened, it is because somebody else pushed in the
> meantime, right?  Then ...

No one pushed between steps 3 and 4.

> >> 5. Pull and make a mess trying to reconcile the older topic branch wit=
h
> >>     the rebased topic branch
>
> ... this means that somebody else's work was something that
> overlapped with what you did in #1, and then you do want to clean up
> the mess carefully, so that you do not lose the work by that
> somebody else.  So ...

The conflicts came from trying to reconcile an older version of the
user's work with a rebased version of the user's work. The user
doesn't want to end up with a history that has two commits from the
same author with the same message.

> >> Help avoid this mistake by giving advice that mentions
> >> force-pushing,
>
> ... why would it possibly be a good idea to suggest force pushing,
> which discards other's work?  I do not quite understand.

The user was only trying to overwrite the old version of their own
branch, which no one cares about. This scenario comes up commonly when
using a single shared remote repository, or when using a forked remote
repository and running `git pull -r upstream master` to incorporate
changes from the upstream remote repository.

I hope that's more clear now. Please let me know if it's not.

-Alex
