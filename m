Return-Path: <SRS0=1KXq=52=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99887C2D0EC
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 22:13:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6DC782084D
	for <git@archiver.kernel.org>; Fri, 10 Apr 2020 22:13:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l/A0uhNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726827AbgDJWN0 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 10 Apr 2020 18:13:26 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:33249 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726687AbgDJWNZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Apr 2020 18:13:25 -0400
Received: by mail-ot1-f66.google.com with SMTP id 103so3210491otv.0
        for <git@vger.kernel.org>; Fri, 10 Apr 2020 15:13:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gIcsZHC1GhJQBDIeGmuXuMjbN45/FWBlZKzQA2jGKFg=;
        b=l/A0uhNrTta2f2xeCaEkCAk0TGgwuZrD+n1W6ietqQPWWulEbaMOSfYki0x0ii0jhc
         CeAmgNMQUvwjZxZlFFbH7lXu6fUMzu0wNLeFVxhK42r+iPfyusYkFZVo5hmwiNnE5FoH
         2q8gFSOT37nLBuvXpN2mBhzS2KJCSLIew9TIZRZUbla0uHgriK1MzKxZY3e30be0Sg+K
         zonqfAfD17WO6CsO8XytTwyOn/4mBUIUIYtzWfvDh/2N8uBrRxPJejWcxTwW6HZsv1kX
         jnJ+JHfnje1paBnQSUBDaJw+LmtHYbu1huTH7ZS+0Ero32ABq+NTY+8HDGTgIhfbZtHA
         bfEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gIcsZHC1GhJQBDIeGmuXuMjbN45/FWBlZKzQA2jGKFg=;
        b=T545p4aphBfAMC2eV8w5t05jIwrmqXm40FaPyDmJS0ybLjs7lnmEY2UHJXdFsgacNE
         Z+y9tQ+H4kBLxFqRZHkVzC0Q9TPp24nfNQi1kokYNfwe8mUsQK8fLl8//NyPE5Apali9
         lRdl0LcFkqoqz7VsmlmqxBXGrBxpaaE2o8xoaZIo2Uumfx4VvYtLpe3Ox/QyUl81oKxz
         iLIAypBEpIhwZpp0Zs2pTzl3bdjXlQ28+pGutX21mIRRJl7iWdTbXzJdmVQE69kjMKFn
         krHxdgFi4tt2ybJdkswbm4fYrPSQ3FrIhsAoBKSjgINw5IUnpeGZNJapJnJ8YSJ53Bw/
         +n/Q==
X-Gm-Message-State: AGi0PuY1X/FHRGG07AbWGcLVYGvZXOx7rN4uXgT5PibOfn+yPIVQegoj
        p/HVMY4M+kLXWll9OA8SvalKHVGsQn6lzcNLf1k=
X-Google-Smtp-Source: APiQypL/mZ3On7x18byQRRUxJ3XWMbJOkN7pLWpK8qoUdI99Jbdj8ciXl5qPQsntwldi+z80kl1txAayVqEP+a7LdiM=
X-Received: by 2002:a9d:5e0d:: with SMTP id d13mr5904641oti.162.1586556804989;
 Fri, 10 Apr 2020 15:13:24 -0700 (PDT)
MIME-Version: 1.0
References: <pull.757.git.git.1586474800276.gitgitgadget@gmail.com>
 <pull.757.v2.git.git.1586541094.gitgitgadget@gmail.com> <xmqqpncfhy3g.fsf@gitster.c.googlers.com>
 <xmqqd08fhvx5.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqd08fhvx5.fsf@gitster.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Fri, 10 Apr 2020 15:13:13 -0700
Message-ID: <CABPp-BEQdK8PagqCrKCvkzaWvSQVfW9g9_RbFCNP3r3qeChbzQ@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] rebase -i: mark commits that begin empty in todo editor
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jonathan Tan <jonathantanmy@google.com>,
        Git Mailing List <git@vger.kernel.org>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Bryan Turner <bturner@atlassian.com>,
        Sami Boukortt <sami@boukortt.com>,
        Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Apr 10, 2020 at 2:29 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Junio C Hamano <gitster@pobox.com> writes:
>
> > So I am OK to rebase the other topic to v2.26.0; would that help?  I
> > already saw there was some entanglement with the other topic in one
> > of the patches in this series, so...
>
> So I've done such a rebasing and queued the result to 'pu'.
> jt/rebase-allow-duplicate used to be directly on v2.25.0 but now it
> is on top of 'master'==9fadedd6, and these three patches are queued
> directly on top of that.  Hopefully I can push out the result of
> today's integration with other topics in an hour or so.
>
> Thanks.

Thanks, but wouldn't I want to base his patch on top of mine rather
than vice versa?  (Since mine might be labelled bugfix, and his is a
new feature?)
