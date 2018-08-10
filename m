Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,USER_IN_DEF_DKIM_WL shortcircuit=no
	autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C17021F404
	for <e@80x24.org>; Fri, 10 Aug 2018 21:52:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727296AbeHKAYQ (ORCPT <rfc822;e@80x24.org>);
        Fri, 10 Aug 2018 20:24:16 -0400
Received: from mail-yw1-f67.google.com ([209.85.161.67]:41645 "EHLO
        mail-yw1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725754AbeHKAYQ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 10 Aug 2018 20:24:16 -0400
Received: by mail-yw1-f67.google.com with SMTP id q129-v6so9672736ywg.8
        for <git@vger.kernel.org>; Fri, 10 Aug 2018 14:52:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=k6trs+Ff+HWvwy2m553Oo3ZXYQZ1J8juDBUlyypdqjc=;
        b=RRthCECnpSswtLyQ4UZBwW/MTm8pNa+aHASTJs8sEbpiGvHjV04mw2QIIItX6wchei
         R0KuTEkXW6wXtgSZDdw3iM0E/gj4Jpbks7P4xBIPR4e6+a8vUh1YGSAl56xWmjIBWXyK
         /+zkECAd2Ql/5faxiT/7pegz9chavqb/lKFAQ/I2HwuAFRlpN9/cP4zHdgUB2SnWcl8S
         6/3EHOKys9MqcmzlNqnAO2mh7fMnnBoQNsKWHEj3u6gHg1B4YEMhufwIfb3Z2bsFaXLD
         5NV7365IwHIFZNGxG/WFVf/D2kLmBiooq8Ie0dh7pKdRl83T6tmQ+k0YEB8ETTdu9Jt7
         NTuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=k6trs+Ff+HWvwy2m553Oo3ZXYQZ1J8juDBUlyypdqjc=;
        b=tvpmFv2bM2jtVBqoRFwfj/WJ4zq/Sora8IO7IzyT6bWAhdnbAQtA0p9DjHpF88cQe7
         +rmCGpI2k/hEClDqCE9+RF5W9JnfwyekhQnZp/pox8kT8ASRRk22Td+/VbFOiki+nmv6
         rl+xXGHTa8/klABm9mG1wvyHcDjUwDQdkGYs8NMmjG69fOo6GE5xajyFAjas+/G0ns3b
         tmtcxZm3R5Ab79Hiser33gQ1lij96t4FVwZwQYOltYPvkt+4Ud8HaclmPRZ6cWMBfKtm
         Eo5QjCNQy59F7EWg302ip+rTbCzuWhS3muJlH417SiCrtdHeuF7Adl6JD+/78xMRSjka
         GaQQ==
X-Gm-Message-State: AOUpUlGY+5hJKDGUdExFB8oj6ojEDPupwPaNFFBSmsizcpRYEKurY1Jb
        jN9AqdVT2ZJooxGO/gJRmGN0VGbGjaHE8DbjCxEntL793oc=
X-Google-Smtp-Source: AA+uWPy8xXqRQ/qFjr5+LK8xb1YTGr5exdGUukwAItcYQqNYC6+SGqaWWBP98z/W7610y2++pldryrCdjXZ33NiJ0po=
X-Received: by 2002:a0d:c944:: with SMTP id l65-v6mr4560185ywd.414.1533937953885;
 Fri, 10 Aug 2018 14:52:33 -0700 (PDT)
MIME-Version: 1.0
References: <20180803222322.261813-1-sbeller@google.com> <20180803222322.261813-7-sbeller@google.com>
 <20180810214703.GB211322@google.com>
In-Reply-To: <20180810214703.GB211322@google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Fri, 10 Aug 2018 14:52:22 -0700
Message-ID: <CAGZ79kb+QyCuBw+e8ShU3Ts9GL+bhzb=i2F+5B0jb9eWk5Sj1w@mail.gmail.com>
Subject: Re: [PATCH 6/7] submodule--helper: replace connect-gitdir-workingtree
 by ensure-core-worktree
To:     Brandon Williams <bmwill@google.com>
Cc:     git <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > +             cfg_file = xstrfmt("%s/config", subrepo.gitdir);
>
> As I mentioned here:
> https://public-inbox.org/git/20180807230637.247200-1-bmwill@google.com/T/#t
>
> This lines should probably be more like:
>
>   cfg_file = repo_git_path(&subrepo, "config");
>

Why? You did not mention the benefits for writing it this way
here or on the reference. Care to elaborate?
