Return-Path: <SRS0=75zt=3F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 304E3C33CB1
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:18:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EF5DD206D5
	for <git@archiver.kernel.org>; Thu, 16 Jan 2020 16:18:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="P7rjt5un"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726923AbgAPQSm (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:18:42 -0500
Received: from mail-oi1-f194.google.com ([209.85.167.194]:42396 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726151AbgAPQSm (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Jan 2020 11:18:42 -0500
Received: by mail-oi1-f194.google.com with SMTP id 18so19346425oin.9
        for <git@vger.kernel.org>; Thu, 16 Jan 2020 08:18:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1KDwkOMZCtfdFoRJpqJuPv0L35iTUJYL1nGHqPIbfsc=;
        b=P7rjt5unOenzGHhbNbgmfKyIyigvqspah74BSmuuQiHi7Tti1elc2CD+23PbIPmn6V
         Vp+ZXe8+ypdJRR6dvXaxWAuY5Jxv/Pz3Aby8vAzIJMem0RYqJjAdSxxBj3ARujprHpAa
         P0HAx1uPTw6m6e7Kqb08EbcuDLvVNnK8cmf22m90Zzu/PKz/ZNd/QAn+c/UI/iWYulU0
         z36BVgq+jejYbxrWnlfcXiiwFsL7NIJqkz89nfUQ9XRIpy5U+7AAbmFnUMBYwFpDusyT
         32KYSK0aYikVu7B0n+cmspZkjqMgNM8pbUAwSAOq1Knse8WraHa+y90yAt7wWT+HfApf
         K0RQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1KDwkOMZCtfdFoRJpqJuPv0L35iTUJYL1nGHqPIbfsc=;
        b=YAFRV+bs1dBctvVx2e3OBQwL9dQnTUQZ4Ym9Jp7iJEjpjjjCLleumJNHBz8iktFaIN
         Z8OQR6AJ/9HcGqWF3/hnkyLlg1Z8Pldf4xiZ0YBfOax5XwZY7pw4aQ29SWn3/1WNDo3a
         7S8G2VVij4WOD7kWxEQ+2jscQcuZTGcpeXbB8wrkxoq68byGTLWp+eaNo3OVCYNJNBkx
         08a3UQlt7PCc0I+jiJeFAz2fJmO1O8mlmSo6UlPZ3VsCaN6F4NDLX4UpCo4VoQfjnfUf
         HtGZ0SwEC6BqYgCkWZHc54gvxRysL++Mm0d24ib6cfwJHugtSKVNgmxVay3Db6woXdHK
         oUfA==
X-Gm-Message-State: APjAAAUNN524OvTnUxvfjY2eHipVTLISieTspoVaWPRwxLv/LqzV44LL
        nDGw5CaIgwEdxtcQrWSncgdA9hy+ryirCJZ+Hfg=
X-Google-Smtp-Source: APXvYqzzXKvmJoOkhLVlNJ5kf4zOw7bSEMp09NozwVmEHJlw9WyFcUmryQUYBLYc11HKGRmX4PlcId5+kUQfaI7nZQI=
X-Received: by 2002:a05:6808:b18:: with SMTP id s24mr4493848oij.31.1579191521651;
 Thu, 16 Jan 2020 08:18:41 -0800 (PST)
MIME-Version: 1.0
References: <pull.679.v2.git.git.1577126999.gitgitgadget@gmail.com>
 <pull.679.v3.git.git.1577217299.gitgitgadget@gmail.com> <044853fd612ee8cf6928bb7c4ebb1eacaa172aa3.1577217299.git.gitgitgadget@gmail.com>
 <20200110231436.GA24315@google.com> <CABPp-BEGwJ=0+6TMYXvMzpds0h6bz4gZA8Pi95SH9M4CKBtfOw@mail.gmail.com>
 <052fdedc-2beb-91ab-c5c3-53fb99e64810@gmail.com> <nycvar.QRO.7.76.6.2001120942460.46@tvgsbejvaqbjf.bet>
 <CABPp-BGqWDo0vkY_zBZ6n+2T92W2iR90=41oJO_Ae1yZP8NO0A@mail.gmail.com>
 <20200116075810.GB242359@google.com> <20200116080624.GA253496@google.com>
In-Reply-To: <20200116080624.GA253496@google.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Thu, 16 Jan 2020 08:18:30 -0800
Message-ID: <CABPp-BHODjbN3-snoFt4LDHGnoxhpDCQHhGVZp14gP1RZFp=hQ@mail.gmail.com>
Subject: Re: [PATCH v3 15/15] rebase: change the default backend from "am" to "merge"
To:     Jonathan Nieder <jrnieder@gmail.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Denton Liu <liu.denton@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Pavel Roskin <plroskin@gmail.com>,
        Alban Gruin <alban.gruin@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Thu, Jan 16, 2020 at 12:06 AM Jonathan Nieder <jrnieder@gmail.com> wrote:
>
> which makes all the difference.  Another example is to compute ctags:
>
>         #!/bin/sh
>
>         ~/bin/hook_ctags.sh >/dev/null 2>&1 &

Thought about this ctags case a bit more.  In contrast to the
deployment cases you brought up (which appear to be protected by a
branch check anyway), doesn't this one argue more that post-commit
should be run for all rebase types?  Sure, it'd take more computation
time, but if a user runs "git pull --rebase" and then is frustrated
that all their tags are extremely out of date then they may be kind of
frustrated.

Of course, arguing against myself, we could always tell them to just
implement a post-rewrite hook.

> Here's a fun one that updates a timesheet:
> https://github.com/GokhanArik/git-hooks-timesheet

So...cherry-picking commits will pad your timesheet with duplicate
work on the same topic (because cherry-pick calls sequencer which
calls "git commit"), and so will interactive-based rebases, but
rebase-am (the default rebase in the past) wouldn't.  Fun indeed...

Wouldn't such users view removing the post-commit hook from sequencer
as "harmful to their productivity"?  And shouldn't we add the
post-commit hook to rebase-am in order to "increase their
productivity"?  ;-)

> Sorry for the noise,

No, these were great examples; thanks for pointing them out.  My
commentary about the timesheet is the only thing that is noise here.
:-)
