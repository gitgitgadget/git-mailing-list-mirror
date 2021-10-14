Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F2ED7C433F5
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 01:25:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9EC561175
	for <git@archiver.kernel.org>; Thu, 14 Oct 2021 01:25:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229846AbhJNB1P (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Oct 2021 21:27:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbhJNB1O (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Oct 2021 21:27:14 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EF84C061746
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 18:25:10 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id s19-20020a63e813000000b00287d976d152so2505459pgh.3
        for <git@vger.kernel.org>; Wed, 13 Oct 2021 18:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=aTYNV+NVseaoOA1BNehmH+tBj6SHVfL5lflMYQqqcJ8=;
        b=Q/mQ9xEbDkiRGmStavIMm+Xk2G1RVKnFPI37rrGNEE3wuIbCmT3MZzkzz4jUQeMjaV
         0sO+iEVTEKpK+EyeM2c4/fSOfZ5ZchzfZcI10PGWmfQv6v5vdItm7+fk/zl4WSVZ5D0s
         UtPB35GX1dEOcPUva1BQI5loVSQOSbeYkpPdCw++LeKtCpb7QSfwEs1QLUdXKjVMPEZF
         8S2ibYKTByG/mbKzfQcDBAvhABRB6rAS0rBco9UkYQu6kz1M1H7TDc0ya5zEgMHW+Njq
         cFFrnVfDhnUMxpC8jV604hkQpEMFAm4mauS+wKR42hKplGRqQjxGhyKtMy8rlUEoTj0v
         ksWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=aTYNV+NVseaoOA1BNehmH+tBj6SHVfL5lflMYQqqcJ8=;
        b=xqnMmecCp5LOa8g6Ntn+CxwaPHJZuoLSc4hqvXZiK0jlaeab0R6oo05kLtOYgHWx1O
         mge+jgl8JW6mWoiA71WH5K52ouGH+Z6Da8Yg5+XGfql9wrsCCyMdUNLjXTMm3tnc6kv/
         R6l8ZUJ/TbEHsOnto3tzL5rfIubllZE0nmhBkvu2eJZCSe1a8xg7xKXHZxpPn5QamydC
         xoH6iCLrgfmqPBOb5ClLPAtnTL109o5ikzfwygMN94xi9+VAiVVtZwKBO1ZMUSUD9CLV
         Ub4hgUuAmkeh7mn/w10iNKmWPgc7SG70MPu158tvefkl12FiD2KibqRgWE/pFKHOnAhv
         ds7w==
X-Gm-Message-State: AOAM532lSpdTgrMRmHJZAk+bQDOllJBXQyfC06OI+A5fdk1WkvjM/6JT
        2j5mOoAEcpYM1S2OzbJ5cu+nHaTieDwE0g==
X-Google-Smtp-Source: ABdhPJw45tdTkNisSfHfsddFVOAjxNjlrT16ojXK9+NODRNKnnV42RJoaUK32OeetpAzYD07E1Qy/GfoYiFdyw==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:a63:9353:: with SMTP id
 w19mr2041903pgm.379.1634174709880; Wed, 13 Oct 2021 18:25:09 -0700 (PDT)
Date:   Wed, 13 Oct 2021 18:25:02 -0700
In-Reply-To: <xmqqmtncebtb.fsf@gitster.g>
Message-Id: <kl6lmtnc1jpt.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <pull.1103.git.git.1633633635.gitgitgadget@gmail.com>
 <20211013193127.76537-1-chooglen@google.com> <xmqqtuhkfzw8.fsf@gitster.g>
 <kl6ltuhk1tdg.fsf@chooglen-macbookpro.roam.corp.google.com> <xmqqmtncebtb.fsf@gitster.g>
Subject: Re: [PATCH v2 0/3] remote: replace static variables with struct remote_state
From:   Glen Choo <chooglen@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> IOW, we need to start somewhere to clean things up, so either we
> teach multi-repository support to remote.c from day one, or we pass
> a repository as a separate and redundant parameter, with the
> intention to later clean up.

I authored this topic with the assumption that passing a 'redundant'
context object was the path forward, not something to clean up. I think
this explains most of the divergence in opinion.

> ...I suspect that this piece is isolated
> enough that it is simpler to use as a starting point, and then the
> callers into remote.c API can then be cleaned up, gradually extending
> the circle.

Agree that this piece is a good place to start such work.

> I do not think it is meant to be internal to begin with.  If we
> declare, after careful consideration, that an in-core branch object
> given by remote.c API always belongs to one and only one repository,
> then following the branch->repository pointer should be the
> documented and kosher way to find out the repository by anybody who
> is given the branch object.

In the specific case of an in-core object that can refer only to one
repository, I think this is a fairly straightforward way of maintaining
referential integrity. However I don't think that the approach of
"contained object pointing to container" generalizes well - if I were
passed a struct remote_state and I needed to access its repository
later, is the ideal interface a backpointer, or is there a deeper
problem with how things are structured?

IOW, whether or not we should use the backpointer seems to depend on the
specifics of each use case. It might be productive to decide on
guidelines, especially with regards to repository.

> ...A function that takes repo and branch
> to pretend as if it can work with an inconsistent pair is an
> invidation for the interface misuse.

Fair.

>> objects). I do not think we are in the same position with struct branch;
>> struct branch seems sufficiently separated to me.
>
> Sufficiently separated in the sense that you take a branch from the
> parent repository and throwing it at a function with a pointer to an
> in-core repository for a submodule would make some sort of sense?  

I meant "sufficiently separated" in the sense that a struct branch is
meaningful to callers, even in the absence of a repository. Even in the
case where we *might* care about the repository e.g. getting a default
for remote_for_branch(), there are callers that make do with just
branch->remote_name.

This was meant to contrast to ref_store, which relies on its specific
repository for much of its internals and is difficult to separate. I am
worried about the knock-on effects of taking a _relatively_ clean
abstraction layer in struct branch and tying it back to the repository
layer.

That said, you have rightly noted that we should not pretend that a
branch from repo A can be thrown together with a pointer to repo B in
any kind of meaningful way (or at least, not yet). A backpointer can
prevent this.

I'm not fully convinced either way so I'll take time to mull over it; I
would also like to start on the right foot with this subsystem.
