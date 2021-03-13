Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 517E8C4332E
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 04:04:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B9C564F87
	for <git@archiver.kernel.org>; Sat, 13 Mar 2021 04:04:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231789AbhCMECn (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 12 Mar 2021 23:02:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbhCMECD (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 12 Mar 2021 23:02:03 -0500
Received: from mail-ot1-x32a.google.com (mail-ot1-x32a.google.com [IPv6:2607:f8b0:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2926C061574
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 20:02:03 -0800 (PST)
Received: by mail-ot1-x32a.google.com with SMTP id 31-20020a9d00220000b02901b64b9b50b1so2459913ota.9
        for <git@vger.kernel.org>; Fri, 12 Mar 2021 20:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=xz3McTbPXoaV3X4PfPG2E/6xsFVleI82wYDW+3/2Q6g=;
        b=cO4gPHGfaICofDvDmNyscDOiU9jE+0dcy+shF0DDwdBuygmUp/WM3XIWtSs56cfHEx
         Wb89mDrnSiW9kaw3qha1lqOHw13L1t3ZfYZI0yV3inr5BJDD65leU4tW1g6+zKkEfVZl
         VO3U8MqAFGXEKgxNfiv4T87x/wzavsjz2WO44JCLAG7vwcCtFZq5czPWjzHxRHhTrWtn
         eAXbDdGwOUbaVYEd10A5oHpknqYQePzAu4swvwyO7gw3iCc/aPjb+uLYTTuSIVIp9EvU
         hWeDAWC3W3hLxozTxIjlT/qhP9Y0OwGu8AZXYL1uBG/Ux4Xkg0bUU4Jb7WbQWwTHD3NC
         EkIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=xz3McTbPXoaV3X4PfPG2E/6xsFVleI82wYDW+3/2Q6g=;
        b=cRhQPHeFyDHEMG+dgUxZ2KU7DGUUTTQ7odOkOGHK6A48SBmrZ1Yb/enERvg/c+M4iV
         dN4haFIAsXCCyXt4qdopHXCy8QywR52tetmi9012h2S9+H4jlZzpx5l8X3/Gup4HgYFo
         acyWlIvK9+roCKij30h99u+/DJUQaEFlLe6qymZLeF5mHvsdh6dTrS5JwvQUcennPhw7
         xxcuXNiXU9oisux44cvc5wfvrq5m/MBgSnEtmxwTh+kC22SKN9iUAAC3wnJdPSanlnOC
         gNEqkKXpezERkWwcxv3fWFj1IkQdm6fABcde6mpgGYhPsAH8DHfM5Jt+fQgKkrpSMFn1
         tDhA==
X-Gm-Message-State: AOAM533SEnvH6biL+8jvFNXUzl/vU7GnX1UMcemQKWJUiCr2pmYP8YiS
        0uABCYgolJsSFcchtx3Y9tNKUSc7bvR2QscesRA=
X-Google-Smtp-Source: ABdhPJyXlmyQvAfzhTEhREvT5WGoi1ez7XRYF/4V0t3ki/DChfT+eBXlKzjJ2lqdDrmNjsKqwtevmDwxKh6YEXj1WO8=
X-Received: by 2002:a9d:6308:: with SMTP id q8mr5681121otk.160.1615608122788;
 Fri, 12 Mar 2021 20:02:02 -0800 (PST)
MIME-Version: 1.0
References: <pull.898.v2.git.1615278830804.gitgitgadget@gmail.com>
 <pull.898.v3.git.1615285726482.gitgitgadget@gmail.com> <xmqqpn0456lr.fsf@gitster.g>
In-Reply-To: <xmqqpn0456lr.fsf@gitster.g>
From:   ZheNing Hu <adlternative@gmail.com>
Date:   Sat, 13 Mar 2021 12:01:50 +0800
Message-ID: <CAOLTT8QhgeGim6ujqqyXwQ=bmQtJ43T5i3CPmNMPmBr0amR-HQ@mail.gmail.com>
Subject: Re: [PATCH v3] [GSOC][RFC] format-patch: pass --left-only to range-diff
To:     Junio C Hamano <gitster@pobox.com>
Cc:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        Git List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Denton Liu <liu.denton@gmail.com>,
        Taylor Blau <me@ttaylorr.com>,
        Taylor Blau <ttaylorr@github.com>,
        Eric Sunshine <sunshine@sunshineco.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> =E4=BA=8E2021=E5=B9=B43=E6=9C=8813=E6=97=
=A5=E5=91=A8=E5=85=AD =E4=B8=8A=E5=8D=886:51=E5=86=99=E9=81=93=EF=BC=9A
>
> "ZheNing Hu via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> > From: ZheNing Hu <adlternative@gmail.com>
> >
> > In https://lore.kernel.org/git/YBx5rmVsg1LJhSKN@nand.local/,
> > Taylor Blau proposing `git format-patch --cover-letter
> > --range-diff` may mistakenly place upstream commit in the
> > range-diff output. Teach `format-patch` pass `--left-only`
> > to range-diff,can avoid this kind of mistake.
>
> The above is a bit too dense for average readers to grok.  Even if
> the readers refer to the external reference, it is unclear where the
> "may mistakenly" can come from and why "--left-only" would be
> useful (and our log message should not depend on external material
> so heavily to begin with).
>

You are right, commit information with the original thread link may make
it difficult for readers to read. I will pay attention.

> So let's think aloud to see what use case this may be helpful, and
> how the proposed solution makes the world a better place.
>
> If I understand correctly, the use case this tries to help is this:
>
>  * You had sent the v1 iteration of topic.  It was in the range
>    B1..T1 where B1 is the tip of the integration branch (like
>    'master') from the upstream.
>
>  * To prepare for the v2 iteration, not only you updated individual
>    commits, you rebased the series on a new upstream.  Now the topic
>    is in the range B2..T2, where B2 is the tip of the integration
>    branch from the upstream, and it is very likely that B2 is a
>    descendant of B1.
>
> And you want to find out how your commits in T2 (new iteration)
> compares with those in T1 (old iteration).  Normally,
>
>     $ git range-diff T1...T2
>
> would be the shortest-to-type and correct version but that is
> invalidated because you rebased.
>
>     ---o---B1--b---b---b---B2
>             \               \
>              t---t---T1      s---s---s---T2
>
> You'd have commits B1..T1 on the left hand side of the range-diff,
> while the right hand side has not just B2..T2 but also commits in
> the range B1..B2, too.
>
> By using --left-only (i.e. show only those pair that maps from
> commits in the left range), you can exclude the commits in the
> B1..B2.
>
>     $ git range-diff --left-only T1...T2
>
> I however wonder what --left-only (Suppress commits that are missing
> from the first range) would do to commits in range B2..T2 (they are
> all yours) that are (1) added since the v1 iteration, or (2)
> modified so drastically that no matching commit is found.  With the
> right invocation, of course,
>
>     $ git range-diff B1..T1 B2..T2
>
> you would not have such a problem.  If 2 't's in B1..T1 correspond
> to 2 of the 3 's's in B2..T2, at least the presense of the third 's'
> that did not match would show up in the output, making it clear that
> you have one more commit relative to the earlier iteration.  If use
> of --left-only filters it out, the output may be misleading to the
> readers, no?
>
> I started writing (or "thinking aloud") hoping that I can help
> coming up with a better log message to describe the problem being
> solved, but I ended up with "does this make the system better?"

Junio, thank you for elaborating this issue in detail and clearly.
I probably understand what you mean by "git range-diff B1..T1 B2..T2"
 to correctly output the commits on my two version topic branch, without
including the upstream commits of B1..B2.So we don=E2=80=99t even need to s=
pecify
the `--left-only` to avoid the output of B1...B2, right?

The only thing I can think of now is that if users tend to use T1...T2
to compare
 the differences between the two topics, will the upstream commit in
B1...B2 appear
more abrupt?

Thanks.
