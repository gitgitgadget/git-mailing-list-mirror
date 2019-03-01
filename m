Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.7 required=3.0 tests=AWL,BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,USER_IN_DEF_DKIM_WL
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B3E2820248
	for <e@80x24.org>; Fri,  1 Mar 2019 00:17:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732069AbfCAARF (ORCPT <rfc822;e@80x24.org>);
        Thu, 28 Feb 2019 19:17:05 -0500
Received: from mail-oi1-f202.google.com ([209.85.167.202]:55494 "EHLO
        mail-oi1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731073AbfCAARF (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 28 Feb 2019 19:17:05 -0500
Received: by mail-oi1-f202.google.com with SMTP id i67so7354672oia.22
        for <git@vger.kernel.org>; Thu, 28 Feb 2019 16:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=BByY4nZjDDRj4g89y/Ngq6olh6GctFoAGfUV4W4s504=;
        b=aaTAVk7aHZNkcY/C8ucaoAxkMX/QqEJ1sQQd2y1bGjY4GstEG0LjBiCBbnn1xf95at
         HIH7ygyaTrwOpG+ikME7+EZlRnFyZYtjg99qyiV/t2ovLt+TnhGgh79B2dY2qfkf3kWp
         C+Yo8QM/6bdB++RyGHOhRXR5Mm0PUlctzIt55q2a4+jU7v0paBQP9jkEL9Ks7NdqEcyI
         RQ3UKmXLHt3232PEk0h5E9qShJEz1g+IIuWZmlQ8E3e7E0z6E1091jeih0VA+REs2dZD
         2MjiTaP7IN5ocAWwtcm6SjFlIsG/218TSjvpESuj460Rb6JsFjQbaEvSrT8/cHJ2HzVm
         YtYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=BByY4nZjDDRj4g89y/Ngq6olh6GctFoAGfUV4W4s504=;
        b=FhAhnm0KVfiWd4xmH/Y4IKirAHy45eMIaOw5L6KFUBWyGNmhE5BZyvQ37Ai+nLROBD
         yZwz8fDLZYsEZcnq6L4amyYHSbmyC/xKKSLZnr4TNCiRHS/A1LMHovkUPSnbHLBLDCsO
         WHg+36ZxBvZ8LXPta+zk2YEaf/LVnptWMZb/ybvVTEgDGYlnLCcI1Fyv8Fk/DnhCmfou
         mpG22jCSH2x5Rxs9qcxTl70G4Mqt7Sen9rKbAz5wMcHQObZ+ywjl2zighiFcCkvuHcQN
         vbHgv/zXlNEr8NDW76khVQeUoQG4f6qZZ9z49o2x+hkVsJWPO5q1PLYeEK97zipK3pwV
         bAog==
X-Gm-Message-State: APjAAAUjh4DddNk9A91i9R02etRFfRtJLFp6krtgwCZSDmqFf3o/E7Ue
        XkOlunE7rE8KIoQ/s8kwXvL43618ErqWH8ai1hnp
X-Google-Smtp-Source: APXvYqwe3mdIyJvosMgORU1GA9exOZfUwdjGDe6+exmwFrDhmpfSgF+DxpPz8mGavPa4edrl8mml3HjWbn4aXgDQKsBm
X-Received: by 2002:a9d:5c0a:: with SMTP id o10mr1402223otk.15.1551399424523;
 Thu, 28 Feb 2019 16:17:04 -0800 (PST)
Date:   Thu, 28 Feb 2019 16:17:01 -0800
In-Reply-To: <20190301000954.GA47591@google.com>
Message-Id: <20190301001701.5739-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <20190301000954.GA47591@google.com>
X-Mailer: git-send-email 2.19.0.271.gfe8321ec05.dirty
Subject: Re: [WIP 7/7] upload-pack: send part of packfile response as uri
From:   Jonathan Tan <jonathantanmy@google.com>
To:     steadmon@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, gitster@pobox.com,
        peff@peff.net, christian.couder@gmail.com, avarab@gmail.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> So we process the packfile URIs one by one as we receive them from the
> server? If we expect these packfiles to be large (otherwise why are we
> bothering to offload them to the CDN), is there a risk that the
> connection to the server might time out while we're downloading from the
> CDN?

You're right that this is undesirable - this is one of the things that I
will fix, as I mention in the cover letter ("starting CDN downloads...")
[1].

> Please take a look. Feel free to comment on anything, but I prefer
> comments on the major things first (e.g. my usage of a separate process
> (http-fetch) to fetch packfiles, since as far as I know, Git doesn't
> link to libcurl; any of the design decisions I described above). I know
> that there are some implementation details that could be improved (e.g.
> parallelization of the CDN downloads, starting CDN downloads *after*
> closing the first HTTP request, holding on to the .keep locks until
> after the refs are set), but will work on those once the overall design
> is more or less finalized.

[1] https://public-inbox.org/git/20190301000954.GA47591@google.com/
