Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-11.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,T_DKIMWL_WL_MED,
	USER_IN_DEF_DKIM_WL shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 466F11F488
	for <e@80x24.org>; Tue,  7 May 2019 18:34:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727256AbfEGSey (ORCPT <rfc822;e@80x24.org>);
        Tue, 7 May 2019 14:34:54 -0400
Received: from mail-qk1-f202.google.com ([209.85.222.202]:34459 "EHLO
        mail-qk1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726321AbfEGSey (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 May 2019 14:34:54 -0400
Received: by mail-qk1-f202.google.com with SMTP id s70so19117870qka.1
        for <git@vger.kernel.org>; Tue, 07 May 2019 11:34:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=YrFD3OrQ6cAnaaqjYyZ5QCo4nHVk1be3R5GT8orKqvo=;
        b=RQxyJ/OcLvwXASkrynHq1qxkV3H5pUpSddhD3Fw9HF/iYe/E6SZ0GLZVoSmA3D36ur
         IWhOguRaU4sFfs+SLkxQB4QCEX6IoX1Me5r6i/4iRdZOSpfGtXjj17SJaUDbEeAGQZQN
         5iPG6v0pPgKtHwZev5Ppktvn09YH1vWkopz+mGx3KN5U61+fuqtcZR6yJAnWeymKoln3
         3LUqUVOx3+5H5o7XCM9Y/+775DwKyO+lKO4/UJDKssfStKChBl1aAT++ncsPfSENbKB9
         l7Vr8+u82Gs2wJcnC5y3U3cAeUztOVKtPXucHSa73tMCNtfiKdpu0xhpIg0IprhXNsnz
         0xew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=YrFD3OrQ6cAnaaqjYyZ5QCo4nHVk1be3R5GT8orKqvo=;
        b=LSmHy4T1dIk1k3sYXVMxar5iYmOx30peYCX9wA6B6mtkzPwsRHH53rGkSa1Da0Emgi
         1pPehPjXbuaAQyaUqVGyxtZZkCLZk00M7bymttJ95ah9NVC2wC/aSbS9pDF86oZOtirm
         ANxNpSyPfSu9T2Nr4AUtovyPCwd3PjfyfJaXRNsCbgyJ7Mqv4AOL48NSuEJwBomjbtMg
         0BsVrsM9Z0y6YPd7k+8F1CXJ5DHtdUv43kQGQOCDGWSFvL9DAB5u1fxBnyICvU+a9vbm
         DyFvqPAakhQI8JDEKYLiY6bgP+kuyxP++pwNk3MfmZkwhdU8gS+eSKiIkWdofanrwoYw
         CN2Q==
X-Gm-Message-State: APjAAAUW4jWqk9QvyCBE9Kyz26Gq9HWFEOg3CT4D0z9MN3wED/CuJb5q
        8pOWpGhfjGfZk7w6rkIe0gdmSgWzDlKV+Xe53yWx
X-Google-Smtp-Source: APXvYqxOP2jK5/6gV1apmzrBlNN0nx9KzkLvp7dRHY1RaczuJWHLd9Og9axuy7pDw0bQdx4fq30IX/BUUpoVNdj7G1/+
X-Received: by 2002:a37:8405:: with SMTP id g5mr19564983qkd.197.1557254093460;
 Tue, 07 May 2019 11:34:53 -0700 (PDT)
Date:   Tue,  7 May 2019 11:34:50 -0700
In-Reply-To: <CAMfpvh+jbPcU2waU5n6nToxGEsC29WGOFPLR+ibXbhXL6WBb6w@mail.gmail.com>
Message-Id: <20190507183450.50568-1-jonathantanmy@google.com>
Mime-Version: 1.0
References: <CAMfpvh+jbPcU2waU5n6nToxGEsC29WGOFPLR+ibXbhXL6WBb6w@mail.gmail.com>
X-Mailer: git-send-email 2.21.0.1020.gf2820cf01a-goog
Subject: Re: Proposal: object negotiation for partial clones
From:   Jonathan Tan <jonathantanmy@google.com>
To:     matvore@google.com
Cc:     jonathantanmy@google.com, git@vger.kernel.org, jrn@google.com
Content-Type: text/plain; charset="UTF-8"
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

> > My main question is: we can get the same list of objects (in the form of
> > tree objects) if we fetch with "blob:none" filter. Admittedly, we will
> > get extra data (file names, etc.) - if the extra bandwidth saving is
> > necessary, this should be called out. (And some of the savings will be
> > offset by the fact that we will actually need some of those tree
> > objects.)
> That's a very good point. The data the first request gives us is
> basically the tree objects minus file names and modes. So I think a
> better feature to implement would be combining of multiple filters.
> That way, the client can combine "tree:<some small number>" and
> "blob:none" and basically get an "enumeration" of available objects.

To get an enumeration of available objects, don't you need to use only
"blob:none"? Combining filters (once that's implemented) will get all
objects only up to a certain depth.

Combining "tree:<n>" and "blob:none" would allow us to reduce the number
of trees transmitted, but I would imagine that the savings would be
significant only for very large repositories. Do you have a specific use
case in mind that isn't solved by "blob:none"?
