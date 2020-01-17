Return-Path: <SRS0=B37d=3G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DEEAC33CAF
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 00:52:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E6CF20684
	for <git@archiver.kernel.org>; Fri, 17 Jan 2020 00:52:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="u3i3bRWv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733214AbgAQAwG (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 19:52:06 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:44407 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729937AbgAQAwG (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 19:52:06 -0500
Received: by mail-ot1-f68.google.com with SMTP id h9so21118578otj.11
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 16:52:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0XGcLGX0Sb0ukD8DAjGBXIGKPSQe9tV5hmP2f/1V0C8=;
        b=u3i3bRWvg7OqhYf4MRbSJAs+Owi49juIbdklVY7YZOnKBBXPu+W4mQZ2z8hwv0M3ai
         a4WVeTe92Ir6kugSdI+HiEVVvEo8xKuYNF4dSulxxru6BWJin71uoEp3MgDqhPuv5YTM
         2tIv5qaKIolfnMVS7d4IIQpuYY09AUhWhts9WTmeCvIbRKWdqSZ9rHeTHoTDcsxh6pB7
         nKX7Lkwn29HU27o8uwOyNHd8tKpoQNNQvjbPBYPYdMzBZi7uc1WWK5tI3rId9nUVViAq
         Ow9LwXaVxSF2+zaOdz9XZZ+ZwIc+6CS6JHg5bS6TaNen+WV0qS4yCoziRSm6JlNwUHAP
         /NDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0XGcLGX0Sb0ukD8DAjGBXIGKPSQe9tV5hmP2f/1V0C8=;
        b=ZcnEqERqRNpSBI29pXCdtMh9yaRP4yDI3LPJPmPYeFsfq5St8xJU+Rk3M0yE4SIUqO
         kiYeYHZ3jD3ZfrfommfJ5K6SqJ27KudSieNTKQ0gl+FQNnVrBlcW2W1xlfsXIQ5XvyLo
         1OGgsntIPXdVuAcK8RS4RGlGn9tR38faCBZppAQuVqnEsvh2bw4fmg7DMUob0VcOqKpz
         qfUXSGiCnYCl9tvXpxzQHZOxQwesd6NPg4AuR44K4uwCW7kM9dIWtSfjzfEBww+k5C9C
         /0oWp+HDvH49uAZ0Ewl9uMCc6y1zkWTrtmOWqleNQTsJET6XD8/n/T4ZDPKPBoaS/2SR
         HX4g==
X-Gm-Message-State: APjAAAWcI4tIXZkDtkTBYqi+ApyrMFsPpVF+UvyA2RQ+k5fMh5P6PrsJ
        c6W1CspFhWJ8Hb1h9bjPeR3cK7IDqGV8O4aBrFU=
X-Google-Smtp-Source: APXvYqxXLZntiFolo2qCdZ5Bzc6d4+tG10mefHB2ypor6VER6pePqhq9XEIsco9YdDL9Kq3ms8MCdeCBMyUbfQpGlGw=
X-Received: by 2002:a9d:6f07:: with SMTP id n7mr4286635otq.112.1579222325166;
 Thu, 16 Jan 2020 16:52:05 -0800 (PST)
MIME-Version: 1.0
References: <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com>
 <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com>
 <20200110231436.GA24315@google.com> <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com>
 <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com> <nycvar.QRO.7.76.6.2001120942460.46@tvgsbejvaqbjf.bet>
 <CABPp-BGqWDo0vkY_zBZ6n+2T92W2iR90=41oJO_Ae1yZP8NO0A@mail.gmail.com>
 <20200116075810.GB242359@google.com> <20200116080624.GA253496@google.com>
 <CABPp-BHODjbN3-snoFt4LDHGnoxhpDCQHhGVZp14gP1RZFp=hQ@mail.gmail.com>
 <20200116203521.GA71299@google.com> <CABPp-BHiYDLRgPX4A1-8f-zgfsDqf6PkToStaV3ukC5Dsq=3-w@mail.gmail.com>
 <xmqqzhendlvj.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqzhendlvj.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 16 Jan 2020 16:51:54 -0800
Message-ID: <CABPp-BG2EXNrzs6YM_8-HrKFfSZY4R3LdH0=CS90dWfvPXbYqA@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] rebase: change the default backend from "am" to "merge"
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Jan 16, 2020 at 3:25 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Elijah Newren <newren@gmail.com> writes:
>
> > Why?  "Commands which create no more than one commit (git-commit,
> > git-merge, maybe single-commit git-revert or git-cherry-pick) call
> > post-commit, commands which create several commits derived from others
> > (git-am, git-rebase, git-cherry-pick, sometimes git-revert ) call
> > post-rewrite instead for performance reasons"
>
> Sounds totally wrong.  post-rewrite is about carrying forward data
> that used to be associated with commit X to new commit Y when Y was
> created by "rewriting" X (i.e. after Y gets created X no longer has
> any purpose other than as a historical curiosity).  There is nothing
> "for performance reasons" here.  There should be nothing for "git
> revert" to do with post-rewrite (because the resulting commit is not
> even a rewrite of the commit that was reverted), and "git
> cherry-pick" is not even a rewrite operation (it is to duplicate an
> existing commit into another unrelated context, without discarding
> the original commit).

Yep, it was totally wrong; Jonathan clued me in later in the thread.

> I am a bit confused...

No, it was I who was confused.
