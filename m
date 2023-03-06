Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC2ADC678DB
	for <git@archiver.kernel.org>; Mon,  6 Mar 2023 03:31:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229579AbjCFDbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 5 Mar 2023 22:31:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjCFDbW (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 5 Mar 2023 22:31:22 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBEDCEF9C
        for <git@vger.kernel.org>; Sun,  5 Mar 2023 19:31:17 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id g3so33088076eda.1
        for <git@vger.kernel.org>; Sun, 05 Mar 2023 19:31:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678073476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5Wc0LLD8O1lubJRjV5TyJEDsFyYo7grq/fFPeSXGMUA=;
        b=K5kZF005/GVlXHYryMN1168C48pkpZ+sipI7TrCOoflAZWV+p8Csy5THAGE1OY2TkD
         X12OirDTz5yr8MDuC/tuFo3BQQ8/STezilNQChwX9kKBi2dsTS21BMo99Iofct1ZgybJ
         GPtM0FFO1DCmrLBkHrPX6NekuWHc6mJldtW7MNN11RqSIyUWjM1bqgw9MQPHjKsj6mef
         j8dw+oa89lOHNmNMmuTSObvOOB8rLJHjjHvYq/t/aeo2ETqs2f6siznPkEZE7dbA+HSO
         fEh1sRJDovecFnM7+OVgb48tg1hRGY3AG7C3KdGCjd3o2wlguP7Vls6sNNp0xK+HS44K
         4OSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678073476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Wc0LLD8O1lubJRjV5TyJEDsFyYo7grq/fFPeSXGMUA=;
        b=X/bRk6m5Camh9AblSL1n390dNh5Qcwwn9PernRB7dR0+8409yBjbWG3g2Y6Go9jVF/
         PsUdKpyK6u1JxQ57MVn+GZo1YYd83rhyRr4hvaKSgcQgClypsOI/zP4S7kzGhpQHdi2q
         EqpLpMIJzh3lFVqnSntGLh3LlKgYsVWtOPa1Byhst2sdHKRalAc5bEToC18tLZDbWCNr
         kfdcaxBUk1KvKd7fAH2goDwrp3dL9/HzA/C+PXlax1maSX8hwmZ5JXjuPm8X9NBHcb67
         M6tG9jG3ruRaFzEtwALxcdPvr3iuL51G9tiESHN72zxW/dWXyDvUOk9CP13oyQuxTFJD
         u5Rw==
X-Gm-Message-State: AO0yUKXLKJNVcap0yi394fP7Bud0CiwXdOUVfCEDnM7kFRrXLrwgVe8L
        uvMrbunByjh+/GS1BPMUVFqLAFE0PsJtStcY3os=
X-Google-Smtp-Source: AK7set+obVoG80UN9gZkoiY+Mqy88l1ypc0ottmv/IbEcPuT74L5PeqtbD7VqBN1ya65b3EZN0bDJ25k7K0Jn5QESnU=
X-Received: by 2002:a50:8758:0:b0:4ab:49b9:686d with SMTP id
 24-20020a508758000000b004ab49b9686dmr4969959edv.1.1678073476153; Sun, 05 Mar
 2023 19:31:16 -0800 (PST)
MIME-Version: 1.0
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
 <374f83c2-7bf0-38be-26ae-de28340c37d2@dunelm.org.uk> <f28bb5a7-ec68-dce2-9b63-7bfb5330c33e@haller-berlin.de>
 <c237c1e3-5cd0-503d-ff4b-96f645a659f3@haller-berlin.de> <CAPx1Gvdik+QhTw8U1vd0cW1yZ9GbgDpmW7apxnXdY=E0okLpTQ@mail.gmail.com>
 <347052f1-dd7d-dc72-6171-a858eea94747@haller-berlin.de>
In-Reply-To: <347052f1-dd7d-dc72-6171-a858eea94747@haller-berlin.de>
From:   Chris Torek <chris.torek@gmail.com>
Date:   Sun, 5 Mar 2023 19:31:04 -0800
Message-ID: <CAPx1Gvc+rBMe1bsg8XW_DyPUN9aJu9tQyhMLP0Zu-aeWCkzSGw@mail.gmail.com>
Subject: Re: When exactly should REBASE_HEAD exist?
To:     Stefan Haller <lists@haller-berlin.de>
Cc:     phillip.wood@dunelm.org.uk, git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Mar 4, 2023 at 12:36=E2=80=AFAM Stefan Haller <lists@haller-berlin.=
de> wrote:
> From what I can see, the current behavior of the .git/rebase-merge/amend
> file was done in 2.12, that would be more than good enough for me. Did I
> miss any changes to the behavior since then?

Probably not - but `git status` remains the right place to decode the
information, since it will be updated appropriately whenever this changes.

> I'm surprised to hear that worktrees play a role in this. Do you have
> more details about this?

$ git worktree add foo
$ cd ../foo
$ git rebase -i HEAD~2

puts the rebase-todo file into
`.git/worktrees/foo/rebase-merge/git-rebase-todo`;
all the status files will likewise be in the `.git/worktrees/foo/`
directory.

>> It would be best if `git status`
>> reported all of this information directly ...

> Yes, that would be nice, but based on what state would it provide this
> information? Are you suggesting that some new file should be added to
> .git/rebase-merge/ to keep track of it (more reliably than the amend
> file does today), or could the information be derived somehow from what
> exists already?

I don't know which parts are reliably derive-able today, but to
the extent that `git status` *can't* provide the necessary information,
I'd call that a bug in `gitt status`, to be fixed by saving that informatio=
n
somewhere. Until it exists, there's nothing you can do, but if and when
(a) it does exist and (b) `git status` provides it, it won't matter
whether it's in some added worktree, or moves around or changes
form: you'll get it in a reliable fashion.

In other words, this is not helpful *yet*. :-)

Chris
