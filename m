Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E36711F462
	for <e@80x24.org>; Thu,  6 Jun 2019 18:29:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730647AbfFFS3w (ORCPT <rfc822;e@80x24.org>);
        Thu, 6 Jun 2019 14:29:52 -0400
Received: from mail-lj1-f195.google.com ([209.85.208.195]:38314 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729591AbfFFS3w (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Jun 2019 14:29:52 -0400
Received: by mail-lj1-f195.google.com with SMTP id o13so2989437lji.5
        for <git@vger.kernel.org>; Thu, 06 Jun 2019 11:29:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kaFhqS1zhdpFa36ITxbpafv/5DR+uDOs4gey98wHNy4=;
        b=fIAy8DBitCECgPs8qTQ3cR9q/r8XOoY8fqyXw1QaWQ8HHyugo5Ghc2dgcALBio8Pgp
         5foKzr1Ac0xyiieIm729T14nreEqLwBco65GEfucXBju+tear4HAXJQWwiqJiLWMqqPv
         9h4VxHXk8SjA9qwerf560QS8CC9AGwxdUP+JjZ+wQmDjQNx7/rjJK0jH0LBm7qopB7O4
         AzufUs/51GUcQxV5c8g77fx0ikPVuBwuVCDB2uWPy66jXaahIevYuAuVllMZzC5CaUit
         5gSDV06NimDkxvZ9ZHXqOTkrhakTiZVltzO5XexDPkRJNh0VR7FAczlKRIpztFq7kJ7c
         guIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kaFhqS1zhdpFa36ITxbpafv/5DR+uDOs4gey98wHNy4=;
        b=YUcD/jpyD3uIJFVmbO2RtfbZL2yPlKrS+Op177yyAv8NTddtmE7O3pgleFLcDERXKr
         167YSIKhgaIrQeueYPfee7lN8vQOrHJ4SRZnuemGUl3HaqvxCnZbB2Yx2k9Q1b7u/cRn
         0YQWbMT2P3X8Fqio7zLP/qP1h9i/wH2CTuF/zVFcNwuWs0xn75KVrIble/Jmv5g7p7v2
         NMPDUf9LuKHtvsweoAVopyghtDiic/UEcZ6bXQ1jgSFho7aH20xeb7Rkwtw9aswV5sex
         6bT2a8HEjc84YQU3wpeDZoQrFK1Ak+mtyHyVVSgFbjl0xKDwmUpevRYQja86d3M3Ba0G
         RrgQ==
X-Gm-Message-State: APjAAAWhieUZQPy/PKwQ7B+/oksLZUs89URhcqjGUdFBEIP5KpRKI4W/
        ooKJIS/QZqjpp+E4jAxW+ZGXU0weWBe+Yso39XE=
X-Google-Smtp-Source: APXvYqzByCuWcr4z3y36eK0pNLOZfgYQ5ButLJBjhaDRYtHD/f2PW9tDy8eDfie0vt0p2M9a5c/diFsk20XcdZ/M4Ao=
X-Received: by 2002:a2e:8909:: with SMTP id d9mr24541880lji.93.1559845790956;
 Thu, 06 Jun 2019 11:29:50 -0700 (PDT)
MIME-Version: 1.0
References: <20190603224814.GA15851@gmail.com> <20190605202019.GA84760@D-10-18-172-221.dhcp4.washington.edu>
In-Reply-To: <20190605202019.GA84760@D-10-18-172-221.dhcp4.washington.edu>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 6 Jun 2019 20:29:40 +0200
Message-ID: <CANiq72=9N_VmV=FVLw64Xhn0AGboTbud3be5fVTxapGyxTZ=rA@mail.gmail.com>
Subject: Re: [PATCH] clang-format: use git grep to generate the ForEachMacros list
To:     Taylor Blau <me@ttaylorr.com>
Cc:     Git mailing list <git@vger.kernel.org>,
        Brandon Williams <bmwill@google.com>,
        Jonathan Nieder <jrnieder@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>,
        Stephan Beyer <s-beyer@gmx.net>,
        Patryk Obara <patryk.obara@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jun 5, 2019 at 10:20 PM Taylor Blau <me@ttaylorr.com> wrote:
>
> Hi Miguel,
>
> On Tue, Jun 04, 2019 at 12:48:14AM +0200, Miguel Ojeda wrote:
> > The ForEachMacros list can reasonably be generated grepping
> > the C source code for macros with 'for_each' in their name.
> >
> > Taken almost verbatim from the .clang-format file in the Linux kernel.
> >
> > Signed-off-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
>
> Thanks for CC-ing me on this. I suspect that it was because I show up
> somewhere recently in the blame for 'git grep' (I believe I worked on
> adding `-o` about a year ago).

Yeah, I just picked a few names that were related to the file form the
log, since I was unable to locate a MAINTAINERS file or something like
that. :-)

Thanks for taking a look -- also to Johannes!

Cheers,
Miguel
