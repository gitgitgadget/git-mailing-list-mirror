Return-Path: <SRS0=eUpu=4B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4976C2BA83
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 17:12:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A7DEE217F4
	for <git@archiver.kernel.org>; Thu, 13 Feb 2020 17:12:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VLBD0QpG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728186AbgBMRM4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Feb 2020 12:12:56 -0500
Received: from mail-pj1-f65.google.com ([209.85.216.65]:38526 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727658AbgBMRM4 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Feb 2020 12:12:56 -0500
Received: by mail-pj1-f65.google.com with SMTP id j17so2688899pjz.3
        for <git@vger.kernel.org>; Thu, 13 Feb 2020 09:12:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rdJdD1KYJsosbhk0ADHwLPp0q98KkTZYg1loCThNSl8=;
        b=VLBD0QpGAFkaqWzfNCuDaap5fLtZL3VevyH/AE2l+yJwnIu7pwfwpsy3BAL7dYFJst
         F+aaG5OifYOyicu7fTT3RM6K0lNgmcMfu99S3sauFtQjDdSWAPhWwES8WMZKBroONvhB
         EeVc7lH7mHrXt6MGJa0+spO/ADHu6j1YXsy5mxBVStGgYteqfIv3PQsfJE/EhsqvojWZ
         MdcsSh+xkkhbRaR6RAo82kYLAgcOI3kHmU1+u8YcCBfbHLxnYQhGSWZJGGgiMu5NAdev
         ArMw4lW4ypmQT8xw2c1i96nh5/ljDZFPvxkKIznH4EPhouhzbBo3LmoUcajljzFB7/kS
         TX0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rdJdD1KYJsosbhk0ADHwLPp0q98KkTZYg1loCThNSl8=;
        b=b+cUSDMqH2Kmq/mYx7cw8wWU0QzoGroWUFZVh1L/5fOMUIc7vc0Oe8Q/D5L+7MDrvj
         vkOtPug4DrWeNvvYaf/gdLoy9NsLcYaWZaDpyObX1MByOFb9P1GszjBgn+Nyj2pMW9dH
         4ZAhNZ6R1O5DDOuAWzexBSo2fkVf6klB6dn88mS7mq2VqAX/M6885tkDhvB4hwdZRK63
         2aliq2gpXYvETCOfowDxFYBmmd9nzPvWco4oA0vt3YiJCHFx4HZrl2iVPP3+F1+d4Hut
         yT/m3CT0/wO+enbKu4nBf05YGLBS6D9YfPYs0+zGJzVIkrx6fO6Qi/JAxTPKwkgSyQ0M
         VJTA==
X-Gm-Message-State: APjAAAU8/o2+LE5R5D+77++OKUzITNAGyS9Y+9UjSRVl/3fRBCDTs2TT
        BXbb97gi/H6J0CMEuZG9PwujlzQKPKn9m5uQ54grhitG0Uk=
X-Google-Smtp-Source: APXvYqw/jLWQC6ClZ1b1O5nVPuxSk1MIf3HYwIlCL0qfLGIU8N8S/cd/WfTOogvjIrLOpJc94QTVlFTHTMa+o3HwLq4=
X-Received: by 2002:a17:90a:c385:: with SMTP id h5mr6238825pjt.122.1581613974573;
 Thu, 13 Feb 2020 09:12:54 -0800 (PST)
MIME-Version: 1.0
References: <20200212235033.782656-1-eantoranz@gmail.com> <CAOc6etbkMJf9qSNMU4fD4KeHE6NuMRUuQf_cBos_oxuYwaaeAA@mail.gmail.com>
 <xmqqblq3t6w1.fsf@gitster-ct.c.googlers.com> <CAOc6etYA79mTHB595cCVphmYmFECYvgPgV09SNo-pdEPEVD37w@mail.gmail.com>
 <xmqqr1yys9ze.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqr1yys9ze.fsf@gitster-ct.c.googlers.com>
From:   Edmundo Carmona Antoranz <eantoranz@gmail.com>
Date:   Thu, 13 Feb 2020 11:12:43 -0600
Message-ID: <CAOc6etYQPi6ghjVGdUc8Mk6oD946-YL35rJ3f9wKFSy74F450A@mail.gmail.com>
Subject: Re: [PATCH] [RFC PATCH] stash save/push: add --index-only option
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Thu, Feb 13, 2020 at 10:55 AM Junio C Hamano <gitster@pobox.com> wrote:
> IIUC, the simplest workflow using the new feature may go like this:
>
>         $ edit file ;# edit a bit
>         $ git add file
>         $ edit file ;# even even more
>         $ git stash --cached
>
> After all of the above is done, "git stash list" may show that there
> is a single stash that records the changes you made to the file
> right after you added it, without your further changes (because you
> are taking what is in the index).  Your working tree has all the
> changes you made to file, both before and after "git add", and your
> index is clean.
>
> After you got yourself into this state where your index is clean,
> your working tree file has all changes, and your stash entry has
> only the earlier half of the change, what are you going to do with
> that stash entry?  If we learn the answer to that question, perhaps
> we may find (or we may even have) a better or easier way to achieve
> whatever you were planning to do with that stash entry by some other
> means---it might not even involve "git stash"---but without knowing
> that, we cannot tell if the new feature is a good idea.

Actually, let this conversation burn in /dev/null. What I want to
achieve (stash only some changes and not all of them) can be done by
using git stash push providing pathspec.

>
> Thanks.

Thank you!
