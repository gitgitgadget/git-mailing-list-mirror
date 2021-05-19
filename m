Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10386C433B4
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:08:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E71E06135C
	for <git@archiver.kernel.org>; Wed, 19 May 2021 19:08:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231889AbhESTJc (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 15:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231974AbhESTJc (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 15:09:32 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 000E4C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 12:08:10 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id q15so10114976pgg.12
        for <git@vger.kernel.org>; Wed, 19 May 2021 12:08:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=riPNMzgx4RZsCaCRex1sDuQG3dubTpn1CO6kT+jLFSs=;
        b=AU5W9nMcBZiLPcVxdBBXu/Vob1a407v1imrgCd/WatB7H4drGwZlcToknKxfAlU7rQ
         1kH2Rq2KH+5m1Tn+6x8Ylvl8Je1RAsrJU24ccxn9YMJp6KZFW98qHMbUi3N5g51zpc9s
         iBW585HISEBbWMnvIj1J4kc+4k/0NvZC9fFrYkayK0M8mZI4Iq4SSqyEztqyxo5Qqn0m
         JKZjh/eAKGhoWKsvobfAQWmj+GmXl2aEDp6KAW2piwRoM1jaljJdGCX8hkcOGprAECZR
         CuDwyoLOxKLaVxPu9OE6Rqgqir9AdXTCT0MCNuYvMCFFAevy6p5GUWYrm1AurzxHS3Kq
         aKDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=riPNMzgx4RZsCaCRex1sDuQG3dubTpn1CO6kT+jLFSs=;
        b=EfVJp91SB4VqhXuaAcO8Dd+rVKwvRd7YSWuSBGYwioi36BpXWRJr7B1w8NR7QQ8pCw
         05Mh2IGVdyIy8cGb+NufeX0P0rlFNvNaWw4Z7hCoVYlS5UnTMg156ODo0apfZumaIjwa
         uxuKj4hcaNl1XsjfD0xzegE3fFjbKHjsGyqkVgl0BPXupiun/uc+gDMqSbkL2RZ1Z1HA
         Xj5xI82ZbtF3lZYoE0LMCp4/Pu6zfK+500pQ3HWZB8xEF3do7KfsMN1c0fgTBXFCWIHT
         QBjWqPyTTerFjr1HAl4f554CDMyojHRqmJqiQUTaCmk80FdYQHw7z2/40edPGxhhHz/S
         MSuw==
X-Gm-Message-State: AOAM532tiQTYNuhgsyrk2L8IhYY6bpDX+10H+18CSJM6anohenBnRSrE
        wjm/2zD7YFwF6XdL01XodZYQEH+rSBQ=
X-Google-Smtp-Source: ABdhPJzXIBKwDiCk7/jk4tC68+F0kqGQ6zITlyJvg91U+xAbkPnxXZYR/snr1ar4NkX6EUup3fh2Rw==
X-Received: by 2002:aa7:9d86:0:b029:2dc:9acd:620d with SMTP id f6-20020aa79d860000b02902dc9acd620dmr658665pfq.30.1621451290507;
        Wed, 19 May 2021 12:08:10 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:4edd:d685:2ff9:b567])
        by smtp.gmail.com with ESMTPSA id z12sm148996pfk.45.2021.05.19.12.08.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 12:08:09 -0700 (PDT)
Date:   Wed, 19 May 2021 12:08:07 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     Git List <git@vger.kernel.org>,
        Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>
Subject: Re: Should we do something with #git-devel on Freenode?
Message-ID: <YKViF9OVLeA95JPH@google.com>
References: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Emily Shaffer wrote[0]:

> Seems like there's been some kerfuffle with Freenode staff and new
> ownership[1][2][3]. What does this mean for Git project? I think #git
> on Freenode isn't maintained by Git developers directly, right?

https://gitirc.eu/ involved a lot of work by Jan Krüger (thanks!), so
cc-ing him since he likely knows who else is active there.

[...]
>                                                             We do
> theoretically keep up #git-devel on Freenode, though it's largely
> silent. Should we be worrying? Migrating?

The main practical struggle on #git-devel has been spam.  I don't know
that any particular IRC network is better at spam prevention than
others.

It looks like most of the Freenode admins have moved to
https://libera.chat/, so that would be a close equivalent.  Another
alternative is OFTC <https://www.oftc.net/>, which is used by
irc.debian.org, for example.

There are also other real-time chat programs such as Zulip (open
source, used in Outreachy), Discord (used by LLVM), and Slack (used by
Chromium); each has its benefits and flaws.

Thanks,
Jonathan

[0] https://lore.kernel.org/git/CAJoAoZ=e62sceNpcR5L5zjsj177uczTnXjcAg+BbOoOkeH8vXQ@mail.gmail.com/
> [1] https://boingboing.net/2021/05/19/freenode-irc-staff-quit-after-new-owner-seizes-control.html
> [2] https://gist.github.com/joepie91/df80d8d36cd9d1bde46ba018af497409
> [3] https://fuchsnet.ch/freenode-resign-letter.txt
