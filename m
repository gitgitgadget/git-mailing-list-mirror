Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 034FEC433DB
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 00:34:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A9D8E64E4A
	for <git@archiver.kernel.org>; Tue, 23 Feb 2021 00:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230498AbhBWAeh (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 22 Feb 2021 19:34:37 -0500
Received: from mail-ed1-f44.google.com ([209.85.208.44]:37196 "EHLO
        mail-ed1-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230125AbhBWAeg (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 22 Feb 2021 19:34:36 -0500
Received: by mail-ed1-f44.google.com with SMTP id h25so10468310eds.4
        for <git@vger.kernel.org>; Mon, 22 Feb 2021 16:34:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=jcwoJvOuoSuxkD7a7EkI54R5Ph56izBKPKYky4R+hKM=;
        b=YWyu0EdQ9Kqe4svieGTCMftJRC9EUQfLuLhL/kwoMRdatBQJcPpj/Lid+1HRgInZEe
         +jMIdFBllLhcxfmDxfh6n8bZxt8hA8Yvjw5f2VmtS/WwellZUJTdVh+na0UQ9xqiTFRa
         sUPge4yHHEBo5HjBdtUbR7bYtx+cOGCKIZOp023YwvJC1DiC9qvoNap9XFy64DFqT1PD
         /+6b15UASYA+BfJJtTyzceyLJzbE14H/loiUhsWeVvebJfKlgdghp4U6pdRSOpr4cs0N
         K759sn6drbhvrmJJRLArLbzrx0AjBYixQdw88vNQG3NlfOOhMIUUv+EBCtVkY5bGZSiH
         0T0Q==
X-Gm-Message-State: AOAM531RfFHkPI6PP238TpfTZULNVBT4TBaTh/4XfcEv/1lW2QYGUFpK
        knE2YpID+7KNZqVwspBiSrtKpjYCVUU6I+/61EE=
X-Google-Smtp-Source: ABdhPJw2bZLmb+1uMMWAgnzbu1vzXVmyRdvlHK8z5g37kByOhi8qlGlaoTG0m2dkBfKjtA1Ys9I5HAfcxSiwTteWOsM=
X-Received: by 2002:aa7:c944:: with SMTP id h4mr25177826edt.233.1614040433252;
 Mon, 22 Feb 2021 16:33:53 -0800 (PST)
MIME-Version: 1.0
References: <jwvwnwqrqwd.fsf-monnier+gmane.comp.version-control.git@gnu.org>
 <CABPp-BE1QXA0ohB9D-tqKpzDTok0BMsGQjotmcqMxfs9AL5noA@mail.gmail.com>
 <CAPig+cRzXd+zd+xVisaW+HToSaGzAE28acGmxwRxNU4bczHXbw@mail.gmail.com>
 <87wnv688u4.fsf@evledraar.gmail.com> <CAPig+cQ9oqMWjBkyRt-SQFuyfAGkMu1J-U6ZCCJqeL0a_3ynkw@mail.gmail.com>
 <87ft1o8mi0.fsf@evledraar.gmail.com> <CAPig+cSkL+5otKUWwm=CLaRR+j71wW61U7LWtmuUHO+7bZaY_g@mail.gmail.com>
 <xmqqmtvv64dp.fsf@gitster.g>
In-Reply-To: <xmqqmtvv64dp.fsf@gitster.g>
From:   Eric Sunshine <sunshine@sunshineco.com>
Date:   Mon, 22 Feb 2021 19:33:38 -0500
Message-ID: <CAPig+cQ5aLEzpUwFAkofd86HjJsJnJ-DtRKkrrkF0EdjHnJm4g@mail.gmail.com>
Subject: Re: New orphan worktree?
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Stefan Monnier <monnier@iro.umontreal.ca>,
        Git Mailing List <git@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Feb 22, 2021 at 6:59 PM Junio C Hamano <gitster@pobox.com> wrote:
> Eric Sunshine <sunshine@sunshineco.com> writes:
> > When I was pondering the issue before writing my original response,
> > two thoughts came to mind. (1) "git worktree add --force --orphan
> > <branch>" would be one way to make your case work; (2) given how
> > infrequently --orphan is used, we just punt and require people to
> > first use "git branch -D <branch>" if necessary (which has been the
> > status-quo for git-branch and git-switch).
>
> FWIW, as I personally view that branch -d/-D, checkout -b/-B, and
> switch -c/-C were all mistakes (they should have been -d, -b and -c
> with and without --force, respectively), I find the combination of
> "--force --orphan" a reasonable way forward.

I'm also leaning toward `git worktree add --force --orphan <branch>`
as a way forward. Indeed, `git worktree add --force -b <branch>` is a
sensible extension even without --orphan being part of the equation,
and it's easy to frame -B in documentation as equivalent to `--force
-b`.
