Return-Path: <SRS0=fhRL=6M=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 745E3C83000
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 20:41:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45E4C2085B
	for <git@archiver.kernel.org>; Tue, 28 Apr 2020 20:41:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RD2g8im5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726419AbgD1Ul5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 28 Apr 2020 16:41:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726180AbgD1Ul4 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 28 Apr 2020 16:41:56 -0400
Received: from mail-ua1-x942.google.com (mail-ua1-x942.google.com [IPv6:2607:f8b0:4864:20::942])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5F21C03C1AB
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 13:41:56 -0700 (PDT)
Received: by mail-ua1-x942.google.com with SMTP id z16so22882146uae.11
        for <git@vger.kernel.org>; Tue, 28 Apr 2020 13:41:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vna5WhIxbhKZus4RlDZuBYnqCrcLuW8KZI4O9y5zbsI=;
        b=RD2g8im5KdTPTbw5lWqR92T+HUeKUprZtA8WTwOUzh7SxhmDIYlqHbWggVCF+ThDEP
         x47iISbqHPAisd8HHtGp2wdpCmxCSKocW0m5/Vd9ZED+M/PnYY22fslSq1B29OswXmPu
         J5v59nHuaR+THhtql1RQOQJqULCB5/tZXQGyWIkIlUmCHGJkvy2PBxbU3BsylFGeTx3i
         i2azaLosxSFMZt9sOqAYfXDagQ3KEtrlfTNaDpmsHxnm1GyQ//QgbzIf/QoYEYBUr34V
         eIGarQ2ON7s3YG6soWoi8cdeEOnE5y10+x7IwLc7TWT/U51GdI7RqgQvCo/dqFjQClOg
         uVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vna5WhIxbhKZus4RlDZuBYnqCrcLuW8KZI4O9y5zbsI=;
        b=BLvlpOyfTa8mIWnS4Q1GP1aG6bp2XUoGWy49nW2faxhV4rqbkeOxdwsrm+tA5jWxb1
         0DnM4xygIGsx3RUgdzW3zVOyiuLO1MAbF8dRqVCKiKWWt4Kd+aCiZSGCO+Sm2kXkSBN6
         IMRRulxe+EnBlD8a0KZweAXxB8DuhbaK9sUIYO6wjiVzGJZXp3ii4ek5PX7+hayCsCZg
         FGUV859OarX/ge9tpjZFa+k8IzznDBjZjehGX0bsnJeDBpvyLrhy/WNwpxQuxn6QoTU4
         3pPbqFEJg8QTFmtKyOsxjPFmit3Ra4YVquy9TfK9kXcoVHgWs7G3f+Kfc2E722rCM3i8
         qlHQ==
X-Gm-Message-State: AGi0PuZhC+tJkTzJOv82BiA6tOB5VPe9OTDPF9Y28SZIFnxbFwpyK5zO
        CX4mTH9QY/E8QJ7LNgWI6deYog098tcm3ivVrdM=
X-Google-Smtp-Source: APiQypIKF+W3SYV9ry3zb8CijadDz4hW/CnugYDLd4hpl1V66MP1Ut3uWHwwe9JW8CJ55EhBY5Z7GwHEZ5h7+ASjHsQ=
X-Received: by 2002:a67:67c4:: with SMTP id b187mr613289vsc.5.1588106515877;
 Tue, 28 Apr 2020 13:41:55 -0700 (PDT)
MIME-Version: 1.0
References: <20200425022045.1089291-1-jacob.e.keller@intel.com>
 <20200425022045.1089291-6-jacob.e.keller@intel.com> <xmqqv9lk5wqy.fsf@gitster.c.googlers.com>
 <CA+P7+xpEMb-A1cOkOxdWf0pM=5o8Cyn9=5HLZPtFNMcLUaypsg@mail.gmail.com>
 <xmqqo8rb4lyj.fsf@gitster.c.googlers.com> <CA+P7+xoBnS8huHiU+QM8x6LRiSDRYVVS2pduv6i_qrwb1ZS7fg@mail.gmail.com>
 <xmqqsggn32i7.fsf@gitster.c.googlers.com> <CA+P7+xoSdDjbSAKeCsPz97Rc=ykpuTb2pNKazsCNcau2SBquMA@mail.gmail.com>
 <xmqq8sif2zfr.fsf@gitster.c.googlers.com>
In-Reply-To: <xmqq8sif2zfr.fsf@gitster.c.googlers.com>
From:   Jacob Keller <jacob.keller@gmail.com>
Date:   Tue, 28 Apr 2020 13:41:44 -0700
Message-ID: <CA+P7+xpD7LaYMnoi6L-Z7e9w0j0+ppDCw6fGBzSMfxerw0HrUA@mail.gmail.com>
Subject: Re: [PATCH 05/11] completion: add test showing subpar completion for
 git switch --orphan
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jacob Keller <jacob.e.keller@intel.com>,
        Git mailing list <git@vger.kernel.org>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Apr 28, 2020 at 12:16 PM Junio C Hamano <gitster@pobox.com> wrote:
>
> Jacob Keller <jacob.keller@gmail.com> writes:
> > With this series, that's handled by just checking for "-c/-C" on the
> > command line and enabling all references. There's no positional checks
> > done, so every word can complete to a reference.
> >
> > I don't know offhand how to add completion which depends on the
> > position of the word we're completing, so I'd have to investigate how
> > to make that happen.
>
> I see.  Even though I say "(3) all branches" is a reasonable
> behaviour, too, if the starting point has to be more (i.e. including
> tags), that would not help the issue you have here.  It may not be
> too bad if we offered all refs (including tags, which may not be a
> good idea) in that case.  I dunno.
>
> Thanks.
>

Basically, when creating a branch, you often do "git switch -c
branch-name start-point"

branch-name would be the new branch name you want, and I think we
should complete local branches for this, but start-point can be any
reference, i.e. a tag, a local branch, or a remote reference.

I assumed completion would be most useful to complete the start-point,
and so I opted to lean towards fixing completion for -c/-C to complete
all references. However, I don't think the branch name should
necessarily complete from all references and it would make sense to
complete that portion only by local branch names.

I'm just not sure how best to implement that in our completion logic,
and I would rather ensure that start-point completes properly, if we
have to choose.

Thanks,
Jake
