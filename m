Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 064DAC433FE
	for <git@archiver.kernel.org>; Sat, 16 Apr 2022 02:05:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiDPCHS (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 Apr 2022 22:07:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiDPCGC (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 Apr 2022 22:06:02 -0400
Received: from mail-pj1-x104a.google.com (mail-pj1-x104a.google.com [IPv6:2607:f8b0:4864:20::104a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D155E887B
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 18:55:31 -0700 (PDT)
Received: by mail-pj1-x104a.google.com with SMTP id i8-20020a17090a2a0800b001cb5c76ea21so5270975pjd.2
        for <git@vger.kernel.org>; Fri, 15 Apr 2022 18:55:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=a/bi3bRALCtk6xved8LrMVU+8Lp8kfWt+Co1YXhMvTk=;
        b=V21chf3O7L2CxUYGmvxyWnMnvEgRlh+ZV9kcFf0SjHNapgxOR+gAjsRj8qLxClrZhl
         KLQp8OTeN/ULdJDC89EfBLhvnX03mdWxF9GV/lnwfpxjG9LWgjg4x3RcGDZ0+lDAYDIo
         71ZY4NS+0gDjm53jVhBUcdIp/gHWL+5nI+MBRb3QkYEHG2MBg+FNLTmjehsnWG5COaTp
         bLx+Gsho5e6UmcJNUfUeF8uYWqbcR0O/5747QyC01OaFLfL+/vUN78CqxK2Avu5ylvn3
         gx2TLwudhYifB3a1HH2NUYM+GLuNnZSeFLccrVz8UvROvnRVpB62jopV8pWkwbAW5td2
         RVvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=a/bi3bRALCtk6xved8LrMVU+8Lp8kfWt+Co1YXhMvTk=;
        b=VZlOVTetV7T3fSpOiYsd1w2OgGYh6BLMlhEh1h7F2wwJ1F20etPFQheKZK6tJ5M7B0
         qJOL+zRknuNF6diEYfjEo5VebPGNS8qBCDws+JKmZwyKLPOwDRhSc76sffcnKUtWLD/B
         MMHwOYSYaRxFJYJg9/MbpGqJe9h77TU5YxfmUgkC8IM0EA1W1qytbN5I7Ny07F1Q+TXs
         sK1t3g2j1BFDcry3kpYbSJimgKV/gRjCRxkbG5Qjl20ficMr4cOM4VyJ2NszRs73bBA/
         GOaW4mARf7c7ueqgvryJ/rDWJc2CEgvDKd3gpaeMKPVfEyLnYD9N3n5h13O6ZX4ujjam
         HEiw==
X-Gm-Message-State: AOAM5317iCjzrNh7KX6/C2NnLqzqk09aF+qsDjAXv7daDUzdcVYuYdGC
        4d/rE1H+RWR1pyid13B7A7Xnq/ytbMlj7RvgyFemOQY/+Y9XovDSO9QMBaUlqfBZ7MLqjFDXqp3
        wluwECQiN5pvkIaA0foAm84uTUHTWjyDBepDnjQslMYzTXxkbuHiCEx/sODDqI8M=
X-Google-Smtp-Source: ABdhPJzmxIsMvo0SuNZWfNkP4BtFnGSycHLbUzajn92yyTAv0ygjxWztgSqTgFOYzGkW65lJLRjVb6vUNr4L5Q==
X-Received: from chooglen.c.googlers.com ([fda3:e722:ac3:cc00:24:72f4:c0a8:26d9])
 (user=chooglen job=sendgmr) by 2002:aa7:8d54:0:b0:4e0:bd6:cfb9 with SMTP id
 s20-20020aa78d54000000b004e00bd6cfb9mr1573238pfe.60.1650069721247; Fri, 15
 Apr 2022 17:42:01 -0700 (PDT)
Date:   Fri, 15 Apr 2022 17:41:59 -0700
In-Reply-To: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
Message-Id: <kl6lwnfp7tbc.fsf@chooglen-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
References: <kl6lsfqpygsj.fsf@chooglen-macbookpro.roam.corp.google.com>
Subject: Re: Bare repositories in the working tree are a security risk
From:   Glen Choo <chooglen@google.com>
To:     git@vger.kernel.org
Cc:     Emily Shaffer <emilyshaffer@google.com>, justin@justinsteven.com,
        Taylor Blau <me@ttaylorr.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        "=?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason" <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Junio C Hamano <gitster@pobox.com>,
        "brian m. carlson" <sandals@crustytoothpaste.net>,
        <rsbecker@nexbridge.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


(resending this because I think the original got blocked, and I messed
up the CC list anyway.)

Hi all! Thanks for chiming in.

I'm sorry I wasn't able to participate in a timely manner, and unfortunately
(once again..), I will be out of the office (returning 27 Apr, PDT) and my
colleagues will be keeping tabs on the discussion in my stead (once again..).

Nevertheless, I think the conversation has been pretty fruitful, so I'm
optimistic about next steps. Here's my understanding of the conversation thus
far - do chime in if you feel I'm off base or if I've missed something:

* We all agree that something needs to be done about embedded bare repos. This
  is a pretty good starting point IMO, because we agree that 'do nothing' isn't
  a good response.

* There are use cases for embedded bare repos that don't have great alternatives
  (e.g. libgit2 uses bare repos in its tests). Even if this workflow is frowned
  upon (I personally don't think we should support it), I don't think we're
  ready to categorically declare that Git should ban embedded bare repos
  altogether (e.g. the way we ban .GiT).

* We want additional protection on the client besides `git fsck`; there are 
  a few ways to do this:

  1. Prevent checking out an embedded bare repo.
  2. Detect if the bare repo is embedded and refuse to work with it.
  3. Detect if the bare repo is embedded and do not read its config/hooks, but
     everything else still 'works'.
  4. Don't detect bare repos.
  5. Only detect bare repos that are named `.git` [1].

  (I've responded with my thoughts on each of these approaches in-thread).

With that in mind, here's what I propose we do next:

* Merge the `git fsck` patch [2] if we think that it is useful despite the
  potentially huge number of false positives. That patch needs some fixing; I'll
  make the changes when I'm back.

* I'll experiment with (5), and if it seems promising, I'll propose this as an
  opt-in feature, with the intent of making it opt-out in the future. We'll
  opt-into this at Google to help figure out if this is a good default or not.

* If that direction turns out not to be promising, I'll pursue (1), since that
  is the only option that can be configured per-repo, which should hopefully
  minimize the fallout.

Given that this embedded bare repo problem has been known for a long time, I
don't think we need to rush out a fix, but (especially since I'll be OOO) I'm
more than happy for someone to take my ideas (or any ideas) and run with them.

[1] https://lore.kernel.org/git/kl6l5yn99ahv.fsf@chooglen-macbookpro.roam.corp.google.com/
[2] https://lore.kernel.org/git/20220406232231.47714-1-chooglen@google.com
