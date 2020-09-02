Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0AC11C433E2
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 18:17:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D71C0207EA
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 18:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727998AbgIBSRX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 14:17:23 -0400
Received: from mail-ej1-f53.google.com ([209.85.218.53]:40860 "EHLO
        mail-ej1-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726247AbgIBSRV (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 14:17:21 -0400
Received: by mail-ej1-f53.google.com with SMTP id z22so11403ejl.7
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 11:17:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lkUruX/rao3bbZu0vPDvnLSvvFpssYpwSQoEFJUwZUg=;
        b=Z2XqZwT3Btol/Nd+sTfV9mqq1cfZSSmoVR6JmbPJYMopxlVpUFk3Ul6H/TUYPLUK7v
         TnRryeYwtoKD6b1OoEfYPvUTPEy7KD6KpOnEDlC9ahtBYbUu5G5kb4jDMwRynEnAufDz
         cQr/4F3lliWj1xEWxE6f6YyPz4Nfsp3XI0+J0NTQjzgNAT/Sdx8o+o8gKbdT9HUZOopJ
         L+WjGqYhNB62PkPt5+xFbgipyD3gUapGnfUsDeo9IJ6509ebzAJlZCBxM+/ipCMANcA1
         IRcBlVU3IUJ891e5Cq1Ma0+Ufz8Fq4U6qqzPQTUxDF0AEiD9hajpszSRpsuPppeG+QBB
         vmHg==
X-Gm-Message-State: AOAM532ZHvXeuTtXap2gVNgiZcM83n9YAA1EwxdnXoGUNy9kDxoFZIJy
        hzvSQCYawxmC8QynpCM7Y+8AnbCSIdNTwvHJxm7N19V7R2k=
X-Google-Smtp-Source: ABdhPJxKdxG3owv6VPeQs8iDIxvjDgL8/68VGeDOxOIHf8Og/b1p+ltdW1eR7GuwGo+jL10dktt9JNy2aw2N5n9Bazc=
X-Received: by 2002:a17:906:454a:: with SMTP id s10mr1286237ejq.138.1599070639612;
 Wed, 02 Sep 2020 11:17:19 -0700 (PDT)
MIME-Version: 1.0
References: <xmqqblipchk6.fsf@gitster.c.googlers.com> <CAPig+cTUhLoPvs+ygnc0Y4Ez3M3tfGncPzON0ejb=xEOMBixHQ@mail.gmail.com>
 <xmqq7dtcceka.fsf@gitster.c.googlers.com> <CAPig+cTGspJAGxRu+vqdko1ntkBonVaoStYde3+P5UxPxrCs7g@mail.gmail.com>
 <xmqqwo1caw2y.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqqwo1caw2y.fsf@gitster.c.googlers.com>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Wed, 2 Sep 2020 14:17:08 -0400
Message-ID: <CAPig+cRn3e=A4Bd5h7+y9NgOws7Pif86vdW8M1RwQaP_q-Es5Q@mail.gmail.com>
Subject: Re: What's cooking in git.git (Sep 2020, #01; Tue, 1)
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Git List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Sep 2, 2020 at 2:10 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > The current implementation also helps out when the main worktree (or
> > bare repository) is moved.
>
> That is why I wrote "secondary worktrees" initially and then dropped
> "secondary" from the description ;-)

I understand now. Perhaps it's just me, but when I see the term
"worktree", I automatically think "linked worktre" (what you call
"secondary"), and don't usually think of the main worktree. But this
also fixes the problem when a bare repository is moved. So...

> Well given that the primary reason why I add these blub in What's
> cooking is to draft the release notes for upcoming release, my
> preference is to give "we help these cases" than giving overly large
> promises to our users.

Okay. In that case, perhaps a slight modification of your wording would work?

    "git worktree" gained a "repair" subcommand to help users recover
    after moving the worktrees or repository manually without telling
    Git.  Also, "git init --separate-git-dir" no longer corrupts
    administrative data related to linked worktrees.
