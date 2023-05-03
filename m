Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99380C77B78
	for <git@archiver.kernel.org>; Wed,  3 May 2023 00:35:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjECAfx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 20:35:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjECAfv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 20:35:51 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A13230FD
        for <git@vger.kernel.org>; Tue,  2 May 2023 17:35:49 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id 38308e7fff4ca-2a7b02615f1so46353941fa.0
        for <git@vger.kernel.org>; Tue, 02 May 2023 17:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683074148; x=1685666148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OXNzQNrS62YCaXCzfVaAAK4jAhnl9ghj7wSj3wYC2gY=;
        b=AFveZRrBYlc/nxsVbM9uh8W6bXNAcsWYiY3QmlE+Nveh+IV0cMaLsLwJC/LgCXdZUf
         /ZvEWfR1HuNR6PsjOtwqwvo34vUatBg+4+QHJBWKsG0akmNK2puJQNWjCkyxT12dtibl
         O2SXdfxMtELYzLqD76AlhfQdjN+aXDUeYlsF18bTKU6JEwjw0WSWNpQXv1ee02K5OXLJ
         xHE5ezl2hkemVVtVbnf2Ltef5hcoUaPrLGElTRKvo+uhHnDuoB+UmLXXZtaYwIVrwgLd
         czgSXSZhhP1I1zCZAKWb2FFRl/xrG1uQkgg/YNYz9s/HnrlUzdO20o9QKFJJ+LqBaWzQ
         07bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683074148; x=1685666148;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=OXNzQNrS62YCaXCzfVaAAK4jAhnl9ghj7wSj3wYC2gY=;
        b=jJwv6m/QeYIojCekIByoK3W7vuo8udQz8jL2yaq59dyHwGClpI2RbU1SuUA2f+VSB3
         VuSYLTCjEmZvRANhO7wIrTuHbrScZrqqfW0dhi/jJLCsZXoCsdKI4crTS5HHYNQCEXrP
         APP6duCs+iGxZWwh2O95wNDE5EazG0ihPDE6YxmT+7qQ0Xpb1PtzQft1+HqcmQ5TB+m3
         hg9lgizJjnbH2I7E8+2EFZK/LLbSVaYSe+qIRmZmrvR0kOvL7L2dhOg683KQ7Vigf07H
         vwX/kvdXA+Db2xsIv29rGUH6x7IpN5nEuI2frKR75eF/KEgUfWdWcoDUsGTkLLzcorIe
         VEtQ==
X-Gm-Message-State: AC+VfDzoUJ+NVlv1+JixFvguRFMfJXlPBbCzR1KSTytJHIkOjk8Z3h6U
        oI0STY/E0SXPXFiiChW6WInwKaAhk3Ho/8GTkWc=
X-Google-Smtp-Source: ACHHUZ4HOsGJ5qsrJE6c+L7zDfz3bIc8IrHJRT3EKCDu1OhLORZfzrE3tltvkuOHjiLRxiIAaSgfo/oHAVZtHzSH5Fw=
X-Received: by 2002:a2e:b168:0:b0:2ac:689e:241b with SMTP id
 a8-20020a2eb168000000b002ac689e241bmr514118ljm.47.1683074147627; Tue, 02 May
 2023 17:35:47 -0700 (PDT)
MIME-Version: 1.0
References: <pull.1527.git.1683008869804.gitgitgadget@gmail.com>
 <CABPp-BH8A=CnO3_UWXDegb87VTNEX8s+=CefB90m1_vjBZ_+Fw@mail.gmail.com> <xmqq1qjy1xv2.fsf@gitster.g>
In-Reply-To: <xmqq1qjy1xv2.fsf@gitster.g>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 2 May 2023 17:34:00 -0700
Message-ID: <CABPp-BEd_53EfEfFfWf8zEt0K7Mp4iMzN=q6smK4_08xfj6Tiw@mail.gmail.com>
Subject: Re: [PATCH] RFC: switch: allow same-commit switch during merge if
 conflicts resolved
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Tao Klerks via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Tao Klerks <tao@klerks.biz>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 2, 2023 at 9:50=E2=80=AFAM Junio C Hamano <gitster@pobox.com> w=
rote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > By the way, it was a problem that git-checkout wasn't updated to have
> > the same safety that git-switch has.  We should fix that.  (It's on my
> > todo list, along with adding other
> > prevent-erroneous-command-while-in-middle-of-other-operation cases.)
>
> Yes.
>
> > I'm worried this is likely to lead us into confusing UI mismatches,
> > and makes it harder to understand the appropriate rules of what can
> > and cannot be done.  A very simple "no switching branches in the
> > middle of operations" is a very simple rule, and saves users from lots
> > of headaches.
> >
> > Granted, expert users may understand that with the commit being the
> > same, there is no issue.  But expert users can use `git update-ref` to
> > tweak HEAD, or edit .git/HEAD directly, and accept the consequences.
> > Why do we need to confuse the UI for the sake of expert users who
> > already have an escape hatch?
> >
> > More importantly, though...
> >
> >> Change the behavior of "git switch" and "git checkout" to no longer de=
lete
> >> merge metadata, nor prohibit the switch, if a merge is in progress and=
 the
> >> commit being switched to is the same commit the HEAD was previously se=
t to.
> >
> > Even if there are conflicts?  For rebases, cherry-picks, ams, and
> > reverts too?  (Does allowing this during rebases and whatnot mean that
> > --abort becomes really funny?  Does it mean that some commits are
> > applied to one branch, and all commits are applied to another?  What
> > about autostashes?  Does it interact weirdly with --update-refs?
> > etc.)
> >
> > I think this change is premature unless it discusses all these cases,
>
> It is pretty much what I wanted to say about why we haven't done
> this in <https://lore.kernel.org/git/xmqqpm7k6ojz.fsf@gitster.g/>,
> so it makes two of us ;-).  I didn't look at Tao's RFC patch but if
> the way it determines "we are in a middle of conflicted merge and
> we'll allow switching to the same commit only in this case" were
> "the index has an unmerged entry", then it is an overly broad test
> and the consequences of allowing the switch for these other merge-y
> operations that are ongoing must be evaluated.

He does tie it specifically to "is-this-a-merge-operation" (and
actually doesn't check for conflicts at all since there are existing
checks he leaves untouched).  That certainly prevents some problems,
but doesn't address my concerns.

I think the usecase Tao presents has multiple simple workarounds, and
I'm worried that the particular proposal might paint us into a corner.

Personally, I think that before we consider a
merge-specific-if-no-conflicts exception, someone should evaluate all
the cases where exceptions could or should be allowed, get a
documented story about them, and then if a consistent-ish UI is
possible then propose patches to start taking us down this path.
