Return-Path: <SRS0=9JxE=D5=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15E8CC388F7
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 23:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B118B208B3
	for <git@archiver.kernel.org>; Thu, 22 Oct 2020 23:14:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QWVEjS6k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S373277AbgJVXOM (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 22 Oct 2020 19:14:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2504396AbgJVXOL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 22 Oct 2020 19:14:11 -0400
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com [IPv6:2607:f8b0:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81D89C0613CE
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 16:14:11 -0700 (PDT)
Received: by mail-pf1-x442.google.com with SMTP id j18so2270439pfa.0
        for <git@vger.kernel.org>; Thu, 22 Oct 2020 16:14:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=b5YYTnnYaYSW6pDpQdmgyaTba6NF6d0Sah3Fv+AxQS8=;
        b=QWVEjS6kKJN7Lv3rmBDCCkfxeogpV2CWopYT+9wGz99ADHqAL8ln5mSMOkHUKBrBpR
         J97SFdi3xMyAuFMSd2+UNWeUNGHWbBfcV75zbB7zKiBGXDEDzCxxQaadcdygl/RdXbra
         tFm92YzBZXWkCzJ6A7qQL2SbseysZLwxqKMlxgLAEdnop3RFLcdvpwDEqPx0dB6/3hUr
         qi3UXgL7mhk7tD3dwsnyHqLGDOuJ6B85ix3Vfl9Y4nCuLkpi5B/MfteH68f/PL4VNmv9
         azANajmaDlNeDhrR+LLEQxJbfSNDR6FwBNKBjW5bJ5+L+IgUW4eyd/80ptdZdqFuhGlj
         tfRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=b5YYTnnYaYSW6pDpQdmgyaTba6NF6d0Sah3Fv+AxQS8=;
        b=Xxrezosf8YxEPyiIIS3I7f+gFsIVJI84NG4E3lqImeO7St5+XGLWJM/UkEt1Red6EW
         DpoWyuIdA9UGP+58EpwM60NlU8Y6OwJNpvHQd/C1W6sxTJyVbOCW6siiAx4egvtZR5Q/
         DBpTn2aJjvR5ndoAMQMppFevBZlzr4b/ozvZnTDrQ/7PACr033hx3vctZuiTqXq0zvW7
         f4Myy85FXNtI05Uxg0Z6jF0vv3zmNR2/EMsz4y7ldfhKTex7oK+piKGQ8rL7eHU9BP+n
         rjPYxyUErRWBWXdTBEVvKSqnDn7OI91ogq1S+BS0BmyZWZ6riA2uJVYkWomuCPjKGTJw
         C/LQ==
X-Gm-Message-State: AOAM5329yeN3zSouIsf8UJ/TQ+d/fiEn8jkzgZ4xISOllbI8WQdmbZcq
        SR0wi7gFcnrLs5JIMBaW+RlEl0jF+gy5Ew==
X-Google-Smtp-Source: ABdhPJz1k5Q3oHgcEa+sYyEOtU1K5Sg5QKBOI6m7vzlWklPfxOHuNisy3TUPo1etolqKYn8RwHbbpg==
X-Received: by 2002:a62:144d:0:b029:157:7e01:94a5 with SMTP id 74-20020a62144d0000b02901577e0194a5mr4883800pfu.56.1603408450918;
        Thu, 22 Oct 2020 16:14:10 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:0:1ea0:b8ff:fe77:f690])
        by smtp.gmail.com with ESMTPSA id t13sm3552775pfc.1.2020.10.22.16.14.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Oct 2020 16:14:10 -0700 (PDT)
Date:   Thu, 22 Oct 2020 16:14:05 -0700
From:   Emily Shaffer <emilyshaffer@google.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [PATCH 1/2] MyFirstContribution: clarify asciidoc dependency
Message-ID: <20201022231405.GF2774782@google.com>
References: <20201016205232.2546562-1-emilyshaffer@google.com>
 <20201016205232.2546562-2-emilyshaffer@google.com>
 <xmqqo8l1amtq.fsf@gitster.c.googlers.com>
 <20201016215235.GA2208862@nand.local>
 <xmqq362dait4.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqq362dait4.fsf@gitster.c.googlers.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Oct 16, 2020 at 03:48:39PM -0700, Junio C Hamano wrote:
> 
> Taylor Blau <me@ttaylorr.com> writes:
> 
> > On Fri, Oct 16, 2020 at 02:21:53PM -0700, Junio C Hamano wrote:
> >> As this is only moving the existing note around in the
> >> documentation, it is not making things any worse, so I am OK to take
> >> the patch as-is, but if somebody (it is fine if it were done by you,
> >> Emily) can double check "apt-get install asciidoc" on a vanilla box
> >> does bring in what we need, that would be quite good.  FWIW, we
> >> write in our top-level INSTALL file that we require asciidox/xmlto
> >> toolchain (the latter is needed if you format for manpage, i.e. if
> >> you do "git subcmd --help").
> >
> > I was curious myself, and surprised to learn that 'apt-get install
> > asciidoc' installs more than 2GB of dependencies. Yikes. Unsurprisingly,
> > somewhere in those 2GB we manage to fit in everything that seems to
> > matter, since:
> >
> >   $ cat /etc/os-release | grep PRETTY
> >   PRETTY_NAME="Debian GNU/Linux 9 (stretch)"
> >   $ apt-get update && apt-get install asciidoc
> >   $ cd copy-of-git
> >   $ make -C doc
> >
> > ...works just fine.
> 
> OK, that makes me feel even better.

Thanks for checking it, Taylor.
 - Emily
