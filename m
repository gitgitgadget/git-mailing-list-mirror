Return-Path: <SRS0=PlGQ=4G=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6ED0AC34031
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 22:01:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 35B4F207FD
	for <git@archiver.kernel.org>; Tue, 18 Feb 2020 22:01:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XjpJ2ibZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726439AbgBRWBp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 18 Feb 2020 17:01:45 -0500
Received: from mail-oi1-f196.google.com ([209.85.167.196]:43459 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726339AbgBRWBp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 18 Feb 2020 17:01:45 -0500
Received: by mail-oi1-f196.google.com with SMTP id p125so21726350oif.10
        for <git@vger.kernel.org>; Tue, 18 Feb 2020 14:01:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HsJXi7b+eEKZ6eBFcuqCUlK5aP0AkoICF5j4E09RPps=;
        b=XjpJ2ibZ8zwDIjKW/LTT5r2nrk7gkz19kJp5EIcCMRMI2o5jvgvdpBa1tT1IXs/Zm0
         Cwk3y5EmelTLvjL6XoW8hIBYEZjYYHufUbGRT6ViDX0RdcOzZwIDQL7hWeu0zDfuayMs
         hPkcBHkcsrSBrohYgdtfpaH0HHHNHrzV78qJWFtBjKPhLqVDFtwJZbPjYwF+bW6L0Rqu
         YUtu5ohG+PIxwJc8CdeDov8L6APuhiCxggAq+IY5naqJqoW8qC/tcONqXrpUzlDAphO2
         +lY98mGjVCL0fXgBCr10PU4Alm8LRvCKhd7NBxp++X89tHt3oN8GGYEPVDsZ2ylayQc6
         mY9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HsJXi7b+eEKZ6eBFcuqCUlK5aP0AkoICF5j4E09RPps=;
        b=KfcO9xirDk5yQi3eYv4BL37Ppn6g8DmlzX0J8raG42vSc9yNkEu5yT50USBVfAMG9l
         2iJxAJckoIQCC/2Jaef/q83jzUJvtGQHPZa5/bGWa2tzodS+t1N/0AdqYqU7fN45zOYN
         m9bSdagXNkgpox/9oFO1701SN2d41dCsc4ngfmTIBC0iwwTmxOWQhi1BuE1BOPE3Yyz0
         iFGoUA6qBy9eOf9LIxtC0a1/T9OjFLTs7fY4vf1r2yEcD/yO/qunBScRXOOkuEK58rGI
         oVmHEbJKd68HCqXPexUa9a7mTdewk64QxZ9EPbReytFIHF2vcSiX2XvcTtsEuwu614d+
         IRfg==
X-Gm-Message-State: APjAAAW+7UXs7Yw5OjmqU9JM8dtElX8s2Ttu9A2M8G9jNW7bAZHwrNjH
        gDSpaE1Kw8heX07POzW3JO0FLiUYGG4VXblGRjQ=
X-Google-Smtp-Source: APXvYqwKZTsq91Ynl9uSCgXNAGYkBmlFjuQpH600IUWhf97BGqfWGadYLyBtpxCr0SO+7abaMOrV5I8AtA6HVBRyYIU=
X-Received: by 2002:aca:dc45:: with SMTP id t66mr2759780oig.39.1582063304017;
 Tue, 18 Feb 2020 14:01:44 -0800 (PST)
MIME-Version: 1.0
References: <pull.712.git.git.1581959751454.gitgitgadget@gmail.com>
 <pull.712.v2.git.git.1582059331257.gitgitgadget@gmail.com> <xmqqh7znins2.fsf@gitster-ct.c.googlers.com>
In-Reply-To: <xmqqh7znins2.fsf@gitster-ct.c.googlers.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 18 Feb 2020 14:01:32 -0800
Message-ID: <CABPp-BFAa9zwYD0c-2FWXgswDoduvQ=+GiksLC2Ym2E3WOqFsQ@mail.gmail.com>
Subject: Re: [PATCH v2] t3424: new rebase testcase documenting a
 stat-dirty-like failure
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Feb 18, 2020 at 1:33 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> "Elijah Newren via GitGitGadget" <gitgitgadget@gmail.com> writes:
>
> >  t/t3424-rebase-across-mode-change.sh | 48 ++++++++++++++++++++++++++++
>
> t3424 is already taken by en/rebase-backend topic that has been
> cooking for some time by now.  It seems 342? are all taken and the
> next available may be t3433 perhaps (please double check with 'pu')?

Whoops, sorry about that.  Will fix up.
