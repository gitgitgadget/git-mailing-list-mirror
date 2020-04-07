Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67E7EC2BA1A
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 00:50:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 362E820768
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 00:50:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EXyJHibl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726331AbgDGAuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:50:08 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37860 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDGAuI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Apr 2020 20:50:08 -0400
Received: by mail-pj1-f65.google.com with SMTP id k3so12527pjj.2
        for <git@vger.kernel.org>; Mon, 06 Apr 2020 17:50:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=rx1sdqSFGbsyiE2w2VZPbQn/KlMbppLrWzgvh8UOJ8M=;
        b=EXyJHiblC4lbgjGQnPIXfpby0UidTCoGEJ0179obucSPYNUEu/veWVva0UEw+dbdcS
         WxokozP01VVNf9WRSo3pZ4Mc7fdET81LaIE0kKvWmVKcNBmT52TtP78r0vAsnY74plKC
         heMZs363l9g70FYLQBaPTaaWMFOFSKNujL5mESr69QHUvObLfLDhYrReaJ7IoTdFY0rC
         qZOkMoVc2N6Dt9CbPPiqjIQm9e/L3J+oBzqVljuaane3Nud4SEfdQdv1RAVMgXTnef8g
         8u6XyyuMowc81O0reiLRJ2cmRpqW6RChbUjiES64/c5g9O/BTj8g4OI6CsvnIHzh0R2O
         Lv5g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=rx1sdqSFGbsyiE2w2VZPbQn/KlMbppLrWzgvh8UOJ8M=;
        b=hPG7mEFeyAjWqcwJiBoEH2t0UBZgdkr6J3muaAieSaJ3ygbt8IBH7hCeO2zROB+w0c
         GYutMK/rOqQ7sU/IiV8kgqbrJyWa7hPm3JosOK0u0ZREoa1vO/2F7L+bTzMSZFVbwXG7
         1kKZSsEg1ksMJ37dXgCTuRoQjhYF/+db5S+0p/qJl3yR4HCCf03XaO68Tw5Bxm1Lf0EQ
         wvxaRZ849d/Rc4+EvmN/BwrrADWLlv1G8+ongAwSlYV8tlk8E+8Ggb//uchaO9cZaWf5
         YwPeTCKIGDOgdRa4eC5u4/FvxQ2mZpuGNfvLMW2/rQHqZrdKKDxAw98Smd9XvP7obj+J
         aQkw==
X-Gm-Message-State: AGi0PuYaIB/lF5APWS0tjDP+zZbOL5d8aQ00cd0S8RfY45DWRr0irUzB
        Y21hrmkuqkc1+8clPzmobMBz9gqER70=
X-Google-Smtp-Source: APiQypKsdgg3G8TfEXDRjLktmFqfUPVD4tgkTEcMIt2LavB3UfdkQK8cNk9+TOh0HcUxZvPz+FIRbw==
X-Received: by 2002:a17:90a:a40d:: with SMTP id y13mr2136229pjp.82.1586220607211;
        Mon, 06 Apr 2020 17:50:07 -0700 (PDT)
Received: from localhost ([2402:800:6375:207b:be21:746a:7a56:9d4d])
        by smtp.gmail.com with ESMTPSA id z63sm11883425pgd.12.2020.04.06.17.50.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2020 17:50:06 -0700 (PDT)
Date:   Tue, 7 Apr 2020 07:50:04 +0700
From:   Danh Doan <congdanhqx@gmail.com>
To:     Derrick Stolee <stolee@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, peff@peff.net, jrnieder@google.com,
        Derrick Stolee <dstolee@microsoft.com>
Subject: Re: [PATCH 00/15] [RFC] Maintenance jobs and job runner
Message-ID: <20200407005004.GB2568@danh.dev>
References: <pull.597.git.1585946894.gitgitgadget@gmail.com>
 <xmqqv9mgxn7u.fsf@gitster.c.googlers.com>
 <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cc9df614-2736-7cdd-006f-59878ee551c8@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 2020-04-03 20:16:21-0400, Derrick Stolee <stolee@gmail.com> wrote:
> On 4/3/2020 5:40 PM, Junio C Hamano wrote:
> > "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> > 
> >>  * git run-job <job-name>: This builtin will run a single instance of a
> >>    maintenance job.
> >>    
> >>  * git job-runner [--repo=<path>]: This builtin will run an infinite loop
> >>    that executes git run-job as a subcommand.
> > 
> > What does this have to do with "git", though?  IOW, why does this
> > have to be part of Git, so that those who would benefit from having
> > a mechanism that makes it easy to run regular maintenance tasks but
> > are not Git users (or those that want to do such maintenance tasks
> > that are not necessarily tied to "git") must use "git" to do so?

I also agree with Junio,
I don't think Git should be responsible to be a scheduler.
It's the job of either tranditional crontab, at on *nix, or scheduler
on Windows.

> That's a reasonable reaction. The short version of my reasoning is that
> many many people _use_ Git but are not Git experts. While a Git expert
> could find the right set of commands to run and at what frequency to
> keep their repo clean, most users do not want to spend time learning
> these commands. It's also worth our time as contributors to select what

And now, people will need to learn _both_ Git existing maintainance
command, and new scheduler (Do I understand it right?, I haven't go
through all patches)

Yes, it could be a setup it once and forget, but,
if there's a problem with their local repo, they will scratch
their head to understand what wrong with them.

It's easier to destroy their repo, and it's harder to know what
operation is running in their computer.

-- 
Danh
