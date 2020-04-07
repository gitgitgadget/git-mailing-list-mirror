Return-Path: <SRS0=6awY=5X=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E221C2BA2B
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DE9D82074F
	for <git@archiver.kernel.org>; Tue,  7 Apr 2020 15:17:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="uBvKUHC1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729097AbgDGPRm (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Apr 2020 11:17:42 -0400
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44513 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728943AbgDGPRl (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Apr 2020 11:17:41 -0400
Received: by mail-ot1-f65.google.com with SMTP id a49so3445192otc.11
        for <git@vger.kernel.org>; Tue, 07 Apr 2020 08:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4B6fiiDJxxL2LpBTkQFmQvZCpZ5GXZsNMB4AxzaGUT0=;
        b=uBvKUHC1makN90nY+s+/rW+dD1odVQJH5uyHzi206D8x45TD7JScA3QeRvjRsIVq5N
         RLJwidM8QHzW8Ey23IeSTwlerQLw/Gtv3tsxmlXD8hIqs+Wbn3LFQwydomrtH1pWUx+j
         Uad25Xc8C2SyRPNiiHDVAgZ+jNJ0+Wt4SRdYU+9s9JFKzNtV9vtWXv7tgX0PRdX8SEGA
         9wtHkpFrFNOtedDgt4TfUqCM9vm90UJh4qCbpnW2fjoTnfx0uM0GBzeojayvoN5bIfzV
         QZ0XLM9hGT0LkCR4eIAjDDRxNjllLiRsc1+uLunF5RdIGpA1bM89PxsB+CAE+4Fj2UV1
         0MyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4B6fiiDJxxL2LpBTkQFmQvZCpZ5GXZsNMB4AxzaGUT0=;
        b=PZKbV9Fk4MFuGiZIwNZ/ux0JmLV1kUDTtUziPMNRjjocWxeQSg6753dYdzIiRxgfHH
         npKlCsmHSkVW/vtgSKcV/it7gWv7s1oPCoC2ZzNdTEbsWAAwTcsHIYCieUXnfS4gIEu2
         iKA/dLgm9CJ7flxcXmNTlAsLHdE3XFHFF12sd9ptNGsHptu/MuForaB1GtgpY0H3sNnf
         f5j6Rpd4un4ZwRDuqncn1lGDyvI/S6UoIe4k9u5J/3rvA02NiWgPfbOzqamaolo8xuxb
         TovfX7o5RvNrZ0hkMMy9WwQPsKeaCnsn1gjs88ZD5xasCKOLxYbNM4vgYpBuAZyz0xXQ
         EZyQ==
X-Gm-Message-State: AGi0PuZd5tHg0y3nbdWDwBiM92NIxXwBi3u84yIfvLfsQMIwNgjWwLSg
        1u9RH95zSzRxu+2eUmNXVSv0yR+eHDSAXIiXmaw=
X-Google-Smtp-Source: APiQypIo22007YbFPc+pcUv58bVp+PgvTugWM8bFMfVIpf+SQujgBfvyEt8xR6wSDpqXKtX3k3AMDxIU8T0uxCxLwsE=
X-Received: by 2002:a05:6830:2428:: with SMTP id k8mr2049894ots.345.1586272660432;
 Tue, 07 Apr 2020 08:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200407141125.30872-1-phillip.wood123@gmail.com>
In-Reply-To: <20200407141125.30872-1-phillip.wood123@gmail.com>
From:   Elijah Newren <newren@gmail.com>
Date:   Tue, 7 Apr 2020 08:17:29 -0700
Message-ID: <CABPp-BF5Z8zJLZ3e4G8bDUJjheP4D4-aLoLcpqWuJC+OqLTpDg@mail.gmail.com>
Subject: Re: [PATCH 0/6] fixup ra/rebase-i-more-options
To:     Phillip Wood <phillip.wood@dunelm.org.uk>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>,
        Rohit Ashiwal <rohit.ashiwal265@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip,

On Tue, Apr 7, 2020 at 7:11 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>
> From: Phillip Wood <phillip.wood@dunelm.org.uk>
>
> The tests for ra/rebase-i-more-options were not as comprehensive as
> they could have been and some of the tests that we did have didn't do
> a good job of testing what they purported to. This series cleans up
> the tests and fixes a couple of bugs (thanks to Jonathan Nieder for
> reporting one of them). The bug fix reworks the code to try and make
> it clearer.
>
> I've opted to add some cleanup commits on top of Rohit's work rather
> than reworking his patches. These are based on top of 4d924528d8
> ("Revert "Merge branch 'ra/rebase-i-more-options'"", 2020-01-12) there
> are some conflicts when merging into pu. I had a quick look at the
> conflicts and they appeared to be relatively straight forward to
> resolve. If that impression is wrong let me know and I can rebase onto
> master or try doing the merge myself and pushing it to github.
>
> Phillip Wood (6):
>   Revert "Revert "Merge branch 'ra/rebase-i-more-options'""
>   t3433: remove loops from tests
>   t3433: only compare commit dates
>   rebase -i: fix --committer-date-is-author-date
>   Revert "sequencer: allow callers of read_author_script() to ignore
>     fields"
>   t3433: improve coverage
>
>  Documentation/git-rebase.txt            |  27 +++-
>  builtin/rebase.c                        |  49 ++++--
>  sequencer.c                             | 109 ++++++++++++-
>  sequencer.h                             |   2 +
>  t/t3422-rebase-incompatible-options.sh  |   2 -
>  t/t3433-rebase-options-compatibility.sh | 201 ++++++++++++++++++++++++
>  7 files changed, 368 insertions(+), 25 deletions(-)
>  create mode 100755 t/t3433-rebase-options-compatibility.sh
>
> --
> 2.26.0

Thanks for working on this!  I took a look over the series and noted a
few minor issues and questions, but it mostly looked good to me.

Elijah
