Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_RP_MATCHES_RCVD
	shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 489341FAE3
	for <e@80x24.org>; Mon, 12 Mar 2018 18:47:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751450AbeCLSrk (ORCPT <rfc822;e@80x24.org>);
        Mon, 12 Mar 2018 14:47:40 -0400
Received: from mail-pl0-f42.google.com ([209.85.160.42]:46977 "EHLO
        mail-pl0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751248AbeCLSrj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 12 Mar 2018 14:47:39 -0400
Received: by mail-pl0-f42.google.com with SMTP id f5-v6so2266019plj.13
        for <git@vger.kernel.org>; Mon, 12 Mar 2018 11:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=IahPuxbwTSTAkfDK58eSKXekrnLpPJbsliQRjiwY/0M=;
        b=fz3uYgNrNPuZb+WRKwtyiW4KVtkG+XxL/gBp8Dhwx/85UqAhVrmgrAtdSLSSuRViz+
         2rJyZpC8j9T1k4zL52B/GQ2xAk11o7AhCv6rB32AxtflrV223cT7JVJlOW65mFKKO1Uo
         wpQaAYFYrnxMI6iswcUJxVy1Cjm5OaxbAm/Wmsh4y80AaZfh2zPo3zeJjEdSEwgReOP3
         6ntV2pQHTxfMGmsKRM8OYaUKUbAoDpawbTQHSMa0KKORlfL0aqhVwgYNYKDprfuVpaW4
         e+bUthBY28nGPcme9EKPTPPgnA2C0YxhOIF8cxnwylXoylayW35/QwHS2F9HzbYL09wE
         1msQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=IahPuxbwTSTAkfDK58eSKXekrnLpPJbsliQRjiwY/0M=;
        b=aOuBi490gxcVs9gzQWp5GqNZZQPRZnr6LXb06Lh9MYsZCDDZRLJmgnzUfnHtO0RpcM
         tvkp0DbQ4KKfk/yGek7oPojLfwXNmc/hJKzbZ5Xq0JkGvquA4UQb2SoKoHiB0yTzfWMz
         7ca3uoJhW5SwwmbkQpgjg/U4tfR/kLNMJc9X+m1LJb5Rxt/I1RgCNmk3DFqwtFpaW/HX
         j9Dw6y8m80P52QXq2v2ndJFkMTUyVKKVMDj/2YdTj3PU5qeLgus/VW7mMMPXxTDCK94Y
         pMe4Vy1hMPl3DD4eXV6kyYUlyLuHLSRdzwjrZw5EaJyfnKRqscdvkzWuhQwJTQWEkVaM
         UE/g==
X-Gm-Message-State: AElRT7G8AT6fsHjuAzXjMj8dnX4J98LxwZmXw8gnTrhb+IILIycBHWUh
        RunTLpuSTbWBbC2bVG7iYvM=
X-Google-Smtp-Source: AG47ELvG5UcZ8ABUzazKPF5hBa0zvV3xw2zQqwJk1IJmnQPn4U/7ypgDzE/pvSIWZVlmQDXWZcF+SQ==
X-Received: by 2002:a17:902:7604:: with SMTP id k4-v6mr4441134pll.292.1520880459018;
        Mon, 12 Mar 2018 11:47:39 -0700 (PDT)
Received: from aiede.svl.corp.google.com ([2620:0:100e:422:4187:1d6c:d3d6:9ce6])
        by smtp.gmail.com with ESMTPSA id w23sm21435731pfk.10.2018.03.12.11.47.38
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 12 Mar 2018 11:47:38 -0700 (PDT)
Date:   Mon, 12 Mar 2018 11:47:34 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Elijah Newren <newren@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>
Subject: Re: Opinions on changing add/add conflict resolution?
Message-ID: <20180312184734.GA58506@aiede.svl.corp.google.com>
References: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CABPp-BEXcvgxcn4-OrDhjUpuOsGCJwE_XT+0eYOK4Ad_O5maOg@mail.gmail.com>
User-Agent: Mutt/1.9.2 (2017-12-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Elijah Newren wrote:

> Hi everyone,
>
> I'd like to change add/add conflict resolution.  Currently when such a
> conflict occurs (say at ${path}), git unconditionally does a two-way
> merge of the two files and sticks the result in the working tree at
> ${path}.
>
> I would like to make it instead first check whether the two files are
> similar; if they are, then do the two-way merge, but if they're not,
> then instead write the two files out to separate paths (${path}~HEAD
> and ${path}~$MERGE, while making sure that ${path} is removed from the
> working copy).
>
> Thoughts?

My immediate reaction is that it seems inconsistent with the rest of
merge behavior.  Why would add/add behave this way but edit/edit not
behave this way?

Would this behavior be configurable or unconditional?  I suspect I
would want it turned off in my own use.

On the other hand, in the case of wild difference between the two
files, skipping the two-way merge and just writing one of the versions
to the worktree (like we do for binary files) sounds like something I
would like in my own use.

Can you add something more about the motivation to the commit message?
E.g. is this about performance, interaction with some tools, to
support some particular workflow, etc?

Thanks and hope that helps,
Jonathan

> I have a patch series[1] with more details and other changes, but
> wanted to especially get feedback on this issue even from folks that
> didn't have enough time to read the patches or even the cover letter.
>
> Thanks,
> Elijah
>
> [1] https://public-inbox.org/git/20180305171125.22331-1-newren@gmail.com/
