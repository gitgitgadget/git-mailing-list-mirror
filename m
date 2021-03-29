Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE313C433DB
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 22:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8097461969
	for <git@archiver.kernel.org>; Mon, 29 Mar 2021 22:03:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230444AbhC2WCw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 29 Mar 2021 18:02:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbhC2WCV (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 29 Mar 2021 18:02:21 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86049C061574
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 15:02:21 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id h6-20020a0568300346b02901b71a850ab4so13739918ote.6
        for <git@vger.kernel.org>; Mon, 29 Mar 2021 15:02:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=uFksony7Qyr+5u+X0/14dRSRGgUd+fx0Sgn7Q2abP0w=;
        b=pB0A01smC4WEsDo6M6WIqPxqGKCtwonn39NKCtI3FxbWpFwvjp1CE7ddh0YkuZrRIW
         I4XHOsOhKvubkvpkv5qbOAwVq5qnmP0nV6pc98yEJLQf0AwwMA0AnyifbIBteTvL2ysV
         myfEg4Kw0xgPWxcH1JJF8DNqsUJO4az2OujgWz3btZXO+p2lpDj2+YfXBJktULSIQlIW
         cK95rHn8ZhE2K26zGTO+LAtdNis0LrdGKA6OdybSD8T9rbD2CPL5WhG7J2FxSiSPlQSI
         P9K0NYBX5IqTLVuH2WTaSf5o+5jBZsLcgvf49HNrfKnWushCWxzU6DPiCCj9IgVjFW90
         hChA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=uFksony7Qyr+5u+X0/14dRSRGgUd+fx0Sgn7Q2abP0w=;
        b=mvBBrZn7S7p/tfWcxC6cScI0nlxCT3TT/2u91VYlZBNHxd3/89QtNZvGzBxMryKFf2
         8cNMSNykcg9a74+u5ZdXJ2QeHnPc1n/RWCuSJBLx5dmjyacya/Zu/hZLX+fA0QbyLJHm
         BkztPcn6nPHC2TUjBa12q1cYRpjZNqsOK5W7P4NNKN+3+GWLKss7XKRAUIBNdBE7O5ui
         Uc3McwzBdHRBf4C4PQvxQTQMqp+xVcdm/h8jNRqa9I2sP8qdH6bQa0SXVKD3ncuLRoAq
         gobnQj6W8p1RqpYgkA97qg0Jk5QM4bGeHQdlpuJIn1C2d0BTvmDobSNFPGPb+uKQhrWQ
         Oq8g==
X-Gm-Message-State: AOAM532TdZFCppLwciWc/B1dD8rfmSJTtNWZH8OifDWDDr1zjnVLORmC
        8Ob08iTtjKjO4d70fz0wdYUTvLB5ZUkUSn+Yfho=
X-Google-Smtp-Source: ABdhPJwP9T8txmS75/uqcnwOnyGFWtB1MEZygLUnz0HeJY0wvRk4dKElSBH1iXH8QicOBqWstvahntIrRZJ5U2i4g8Y=
X-Received: by 2002:a9d:8d5:: with SMTP id 79mr24831120otf.345.1617055340915;
 Mon, 29 Mar 2021 15:02:20 -0700 (PDT)
MIME-Version: 1.0
References: <pull.883.v3.git.1615912983.gitgitgadget@gmail.com>
 <pull.883.v4.git.1616507069.gitgitgadget@gmail.com> <7ebd9570b1ad81720569a770526651c62c152b9f.1616507069.git.gitgitgadget@gmail.com>
 <87r1k5pcmx.fsf@evledraar.gmail.com> <ca8a96a4-5897-2484-b195-57e5b3820576@gmail.com>
 <874kgzq4qi.fsf@evledraar.gmail.com> <CABPp-BGRwxn73sntpX8Q5aD-O192RZmOOy_jiU3SQp4-erivtg@mail.gmail.com>
 <87eeg0ng78.fsf@evledraar.gmail.com>
In-Reply-To: <87eeg0ng78.fsf@evledraar.gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Mon, 29 Mar 2021 15:02:09 -0700
Message-ID: <CABPp-BF=WQhMMARF0Groump1LSXGHWkV8SXZ-_Fqd=d-8Nn35g@mail.gmail.com>
Subject: Re: [PATCH v4 07/20] test-read-cache: print cache entries with --table
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Derrick Stolee <stolee@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= <pclouds@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        =?UTF-8?Q?Martin_=C3=85gren?= <martin.agren@gmail.com>,
        =?UTF-8?Q?SZEDER_G=C3=A1bor?= <szeder.dev@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

On Sun, Mar 28, 2021 at 8:31 AM =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason
<avarab@gmail.com> wrote:
>
> On Fri, Mar 26 2021, Elijah Newren wrote:
>
[...]
> > You are correct that this will span multiple releases; Stolee already
> > said he was planning to be working on this for most of 2021.  But just
> > because pieces of the code exist and are shipped doesn't mean it'll be
> > announced or supported.  For example, the git-2.30 and git-2.31
> > release notes were completely silent about merge-ort.  It existed in
> > both releases; in fact, the version that ships in git-2.31, could
> > theoretically be used successfully by the vast majority of users for
> > their daily workflow.  (But it does have known shortcomings and test
> > failures so I definitely did *not* want it to be announced at that
> > time.)
>
> Yes, and that's fine. But if you'd been bending over backwards to add
> merge-ort to t/helper/ "because it's not ready yet" or something I'd
> have probably commented to the effect of "can't we just add it as part
> of builtins but not advertise it?" which is what you did :)

Actually, I did add a t/helper/test-fast-rebase.c (which is a few
hundred lines long) as part of the work on merge-ort, because
merge-ort wasn't ready and because rewiring sequencer.c was a huge
amount of work that I didn't want to get distracted by at the time.  I
originally suggested making fast-rebase a non-advertised builtin, but
multiple reviewers suggested the test helper route instead.

=C2=AF\_(=E3=83=84)_/=C2=AF
