Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7EFC4743C
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:12:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 59E77611C1
	for <git@archiver.kernel.org>; Mon, 21 Jun 2021 22:12:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231669AbhFUWOb (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 21 Jun 2021 18:14:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhFUWOa (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 Jun 2021 18:14:30 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAB6FC061574
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:12:15 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id m137so21589664oig.6
        for <git@vger.kernel.org>; Mon, 21 Jun 2021 15:12:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=8uoHNJaGjzCspcnPGVNCEm9GMwVvISZrfC+oEjexG2A=;
        b=TvLFYypUP7D9NMVJnmelntBJFytzVbop1PuZA5zyQOg7E8wVy/zg8txGmLImBgr26K
         g8Lfn/uZt1e5wm7VnKvd5Py4HfmJEj0wVRR8S6whtmgVA4IqgsdrniNitxpuw8i6BlCk
         H+wq6hkacK8i1TeMRv3ZJ6qT4pOULqjMvX8wz8MmTStzadzZ10UWnjByLOGieg3jpHNf
         xD8QYBTbdVF3r9ZcsD7qpjY8QY+CoC7lrQlR0MrIf8kmOMO1jHoqyF4dnOc+A85+E7fq
         c7PJ1MFfS1nmuRlU9Ctf5rKpsLYsAj8dtKXd48s3XQuOx40YR7L0g1kruwBtPHysSOhp
         IOpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=8uoHNJaGjzCspcnPGVNCEm9GMwVvISZrfC+oEjexG2A=;
        b=VqqsIxJSpBff1dl5W2ar6WtjIRzEv4rLQSV57cd43b8wjBcmFMIgbPZAfWrmns+VOd
         dpBvtxxUbtJXjsBrWf9kBtwt3kwstqkVFkppmZ0P3b31cYErK5W+qNsOqmqcj/agjcur
         Q1YTMQUAVFIDoHv2BX55Angn8Iggc/zMiJZ8qOCY4PJpB9Q3zh4I+8W/MWdyRsU83RmF
         3WfKxE91JgU/LWsymvl2dnWssztUymFzlrnq2Ri1kkBppSycr2ymdJZ1l90JdjiDgglV
         sisnR/XITHx6xheipEOmDdEYuOay3+Z7bL5IJJUgsFfyays+1eIdaO+BUpojK/zCkAoQ
         c3Dg==
X-Gm-Message-State: AOAM531rwfIUHMQJkT/bwlTDIQwARLzq5IKVyFTQs/BOM5AfePIsTZD8
        f1GDzDFEh7wSaWPlAvVQYsM=
X-Google-Smtp-Source: ABdhPJx6pEmxg+4Hv7Wgv4wO/5+a/WO8QTOn0c57/4pZf+1U875K24X185w4tHQrP18kejolJ7rw5A==
X-Received: by 2002:aca:e107:: with SMTP id y7mr519276oig.11.1624313535071;
        Mon, 21 Jun 2021 15:12:15 -0700 (PDT)
Received: from localhost (fixed-187-188-155-231.totalplay.net. [187.188.155.231])
        by smtp.gmail.com with ESMTPSA id z5sm4229717oth.6.2021.06.21.15.12.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Jun 2021 15:12:14 -0700 (PDT)
Date:   Mon, 21 Jun 2021 17:12:13 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Alex Henrie <alexhenrie24@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        =?UTF-8?B?VsOtdCBPbmRydWNo?= <vondruch@redhat.com>,
        Jacob Keller <jacob.keller@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
Message-ID: <60d10ebd99d86_113139208cd@natae.notmuch>
In-Reply-To: <CAMMLpeRnUC+nOek=Kz6bj0_R6EUaDr=7ObKF01V641_ByOmk6A@mail.gmail.com>
References: <20210621175234.1079004-1-felipe.contreras@gmail.com>
 <20210621175234.1079004-3-felipe.contreras@gmail.com>
 <CAMMLpeR2Y_EGwqGJzghSQ1DzpYQyWr6ENmGCvPRdhhYFkTW4yw@mail.gmail.com>
 <60d0df99d91e1_108e902085e@natae.notmuch>
 <CAMMLpeRnUC+nOek=Kz6bj0_R6EUaDr=7ObKF01V641_ByOmk6A@mail.gmail.com>
Subject: Re: [PATCH 2/2] pull: improve default warning
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Alex Henrie wrote:
> On Mon, Jun 21, 2021 at 12:51 PM Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
> >
> > Alex Henrie wrote:
> > > On Mon, Jun 21, 2021 at 11:52 AM Felipe Contreras
> > > <felipe.contreras@gmail.com> wrote:
> > > >
> > > > +                "If unsure, run \"git pull --no-rebase\".\n"
> > >
> > > I don't think the message should recommend merging over rebasing;
> >
> > This is the default strategy.
> 
> Yes, but it shouldn't be,

Feel free to propose a patch to change that, in the meantime this is the
default.

> and we shouldn't make the problem worse by encouraging people to
> default to merging without thinking.

We are not.

> > > The eventual goal is to get rid of the default here and make the user
> > > make an educated choice, which does imply some work on the user's
> > > part, but it avoids the massive headaches created by users merging
> > > without understanding what they're doing.
> >
> > Indeed, but any minute change in git's UI is a gargantuan task that
> > takes several years--or even decades--to accomplish, if it ever happens.
> > I started this patch in 2013, and here we are.
> 
> Although what needs to be done had been envisioned by some as early as
> 2013, the warning has only been around since Git 2.27 (released in
> June 2020), and it was only restricted to pulls where fast-forwarding
> is impossible in Git 2.31 (released in March 2021). The good news is
> that (unless I'm mistaken) there are no more changes that need to be
> made prior to changing the message from from "advise" to "die".

There is *a lot* that needs to be done.

 1. Update the documentation
 2. Add a --merge option (instead of the ackward --no-rebase)
 3. Fix all the wrong behavior with --ff, --no-ff, and -ff-only
 4. Add a pull.mode configuration
 5. Add a configuration for the mode in which we want to die
 6. Fix inconsistencies in the UI

Only *then* can we even begin to throw a warning stating that the
default behavior might change in the future, and how to try the new
behavior.

> All that needs to be done is to set a date to make the switch.

No, there's a lot more.

> For comparison, users were given from Git 1.8 to Git 2.0 (October 2012
> to May 2014, 1 year and 7 months) to acclimate when push.default
> changed from "matching" to "simple".

We haven't told the users the default mode is going to change for a
single day. We don't have a configuration to tell them to turn on to
enable the new mode, nor do we have a configuration to tell them to
enable to stay in the old mode.

There's no configuration in git 2.32 that is equivalent to what I
proposed with pull.mode=fast-forward?


In the meantime there's no reason to have subpar documentation.

-- 
Felipe Contreras
