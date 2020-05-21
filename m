Return-Path: <SRS0=Ny9l=7D=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2A03C433E0
	for <git@archiver.kernel.org>; Thu, 21 May 2020 02:46:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BA1020709
	for <git@archiver.kernel.org>; Thu, 21 May 2020 02:46:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SB7vOQyw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727798AbgEUCqC (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 May 2020 22:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726979AbgEUCqC (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 May 2020 22:46:02 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 156E6C061A0E
        for <git@vger.kernel.org>; Wed, 20 May 2020 19:46:02 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id f15so2203689plr.3
        for <git@vger.kernel.org>; Wed, 20 May 2020 19:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=hJy07yY570G8dpsNfGemM/HBL6iFyoVlV658cz1eeX8=;
        b=SB7vOQywS54MB6jIE6WFv+ZutCPmOgYfRyTnhSqonvxeOf+nfkGMwvclKdx+H4Gaaa
         rnCt4inAHIB3e4GI42QJJH7ZgWYfz41Mlnmq2BKvj6pgcnkWqiyaTCi0iSRSXHUBE3Eo
         W1dki0P+aKNxXrT/26t3FwzHU6gQIDnKipXf9NTCrbBe4+289q5gcYaQYXy3e1z7lgiJ
         YIU65lQVZQ32ZyX02DXqUoJRuKtg/ejLAJ8NPblcAh/KxfowvYTLVb/0wiEdD2RvaEpd
         g2LyD7iCn6vZHSqY47uxYFXYS8Bk2XMUWJ/t1u6wqZ8ycsQUknCbkK58ASJ/LqwIHYiD
         WSmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=hJy07yY570G8dpsNfGemM/HBL6iFyoVlV658cz1eeX8=;
        b=mvVbDywcFFHsfqmHtQ3QY0Xhkxj6mgrLNMDGwWuD2XyTWnuQIXwvG94a/PJbUK2XjE
         OG9zWxRv6p8Jo3BKUgzEFtLhWrllf+u9mSnVRq1Y/ITyjvg1L4BNaxWDSoB1kKVGsuYV
         DRP3Ql0fZ+Y+ZDB6PBqfzmnLnbs3iFGT3hv7QPRa2kxH78/fmK+EM02t2DFVI/gumDu1
         Ae8gjY2Rev4VAAnsnhs/MoQxF5o1CgV15d2npxP6R3RzYm8q98r7SSjlhZ0PEcwU79dn
         ULuwcoK56a0jdVldYq1O/1UCyJ4yo95fylLEwQDtH470hG8rqcdDu2V1FPmOnn7hn4Z/
         bpKQ==
X-Gm-Message-State: AOAM533sV3oK0rJxeoJdW7R6Ngfxjvdxg/PATPXXcHxvHwbEWeOAqN/l
        1bybmUmCtakruiaQkqRjzhc=
X-Google-Smtp-Source: ABdhPJz5Jqhnzy9becRi0f7C9SqKKmohIztpKVKWXDIADl5f5yh/IGsTdmOPS+eYI2QyjzBdO4m09g==
X-Received: by 2002:a17:90a:8404:: with SMTP id j4mr8294443pjn.12.1590029161271;
        Wed, 20 May 2020 19:46:01 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id i12sm2963184pjk.37.2020.05.20.19.45.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 19:46:00 -0700 (PDT)
Date:   Wed, 20 May 2020 19:45:58 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
        git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        bwilliams.eng@gmail.com
Subject: Re: connect: don't request v2 when pushing (Re: Protocol v2 in v2.27)
Message-ID: <20200521024558.GA102425@google.com>
References: <xmqqsgfuv2ko.fsf@gitster.c.googlers.com>
 <20200520193156.GA4700@coredump.intra.peff.net>
 <xmqq5zcquz4t.fsf_-_@gitster.c.googlers.com>
 <20200520220023.GB3648@google.com>
 <xmqqlflmtaxq.fsf@gitster.c.googlers.com>
 <20200521021533.GC3648@google.com>
 <20200521023554.GE20332@Carlos-MBP>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200521023554.GE20332@Carlos-MBP>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Carlo Marcelo Arenas Belón wrote:

> Sorry to hijack the thread, but hopefully this is not completely offtopic
> either, regarding v2 support.

Changing subject line.

> Is 1aa8dded3a (connect: don't request v2 when pushing, 2018-03-15) still
> relevant?

Can you elaborate a bit?  Are you asking whether we should revert that
patch for git 2.28?  Protocol v2 for push still does not exist, but we
have plans to introduce it soon (reusing more code from v0 push, so
this would hopefully have fewer teething pains than v2 for fetch).

Thanks,
Jonathan
