Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 402EE1F406
	for <e@80x24.org>; Sun, 13 May 2018 23:33:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751210AbeEMXdS (ORCPT <rfc822;e@80x24.org>);
        Sun, 13 May 2018 19:33:18 -0400
Received: from mail-wr0-f195.google.com ([209.85.128.195]:34979 "EHLO
        mail-wr0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751022AbeEMXdR (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 13 May 2018 19:33:17 -0400
Received: by mail-wr0-f195.google.com with SMTP id i14-v6so10391204wre.2
        for <git@vger.kernel.org>; Sun, 13 May 2018 16:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=lrTkWwARBeNUQqMth0RXrKZSz6sVwlDV1F0bVP9+WE0=;
        b=e+NMWOSKQD8nVbxuX4ehPYOBVWMXyRV3hplPnB8keqy1LibtFo/9j8sCffCkRO6Fuu
         3MZ+YW/r01Oib0v0G0BI7FySX4ND/76BQ/Pdife1fEqtjyiZ6iCYsDjR5oXPejlONBYs
         qOSfADYfn05JNbmshqpF4iF/2aeUlo4wSbfnrGVu482KI34wbLZ5FSfypCKeMR9JicQC
         VgbfYswQHrGMfgOkOnrvIBw7EvYhG8kcGK9l5G/wonybUq6TSTClMYUbGfQJjz9KJELA
         gEXvNY2gMSbUl2/iyYcxV5veNTeopg0pq0iB6D9JGU2/yVWqjzw1lj+52X1RYltWGOLJ
         3f8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=lrTkWwARBeNUQqMth0RXrKZSz6sVwlDV1F0bVP9+WE0=;
        b=S1Tbf1aMcuucZtfCZlncN0xFaW6H8ILfn4tjYZN9NBwDSh7ZhBQCrMu/IT+4MqEogb
         /fHE05+7AjpoORGOzR1OVri0dNi28/Djyb6+POfjpBEwSMDA8oxEyhGlOv2feeKhBp9p
         5ju0kdSUc4hVrbuW1bpVUBBxzzDYX/W7zlod9GhT+pIqzKrmjvu0GFoI61GPYD6bOqAF
         EtkM4CgCy1cdwmFAtHCs8Z7jA6fukJbkut7vmyV7y0diafYiBP1FkCtsm4LXRI/tbr9T
         FHNq/cgB3qVHY74pPwOxy1MJdeTKLnFRRV0pVq7Euys16hNaXSK6rCmCCKwfgSyiPkvJ
         kMGQ==
X-Gm-Message-State: ALKqPwd9mIPUfSuhDVyQ4Ph1/ohq0fJR7whSZPrLEBvfroqbvFaR7NiS
        JKxEwLsZxqBzKuBN29wa4Uc=
X-Google-Smtp-Source: AB8JxZr2u+5qn91b1puipTxtsotHkTPNjO3kUX5hy2ZKsz9t7F313hpx8nSX75zDO6/osbX/RQDR4A==
X-Received: by 2002:adf:8827:: with SMTP id d36-v6mr5125985wrd.41.1526254395556;
        Sun, 13 May 2018 16:33:15 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id z7-v6sm11912741wrg.56.2018.05.13.16.33.14
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 13 May 2018 16:33:14 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 01/14] commit-slab.h: code split
References: <20180512080028.29611-1-pclouds@gmail.com>
        <20180513055208.17952-1-pclouds@gmail.com>
        <20180513055208.17952-2-pclouds@gmail.com>
Date:   Mon, 14 May 2018 08:33:14 +0900
In-Reply-To: <20180513055208.17952-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sun, 13 May 2018 07:51:55 +0200")
Message-ID: <xmqqefifdtc5.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Nguyễn Thái Ngọc Duy  <pclouds@gmail.com> writes:

> The struct declaration and implementation macros are moved to
> commit-slab-hdr.h and commit-slab-impl.h respectively. This right now
> is not needed for current users but if we share a commit-slab for
> multiple files, we need something better than the current structure.

"something better" needs to be replaced with something better for it
to be worth being there.  In other words, say why you want to avoid
including the part you moved to *-impl.h everywhere.

I also think you want to rename s/-hdr.h/-decl.h/ or something to
avoid sounding silly by repeating "header" twice in the name.

> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  commit-slab-hdr.h  |  30 ++++++++++++
>  commit-slab-impl.h |  91 +++++++++++++++++++++++++++++++++++
>  commit-slab.h      | 115 +++------------------------------------------
>  3 files changed, 127 insertions(+), 109 deletions(-)
>  create mode 100644 commit-slab-hdr.h
>  create mode 100644 commit-slab-impl.h

"git blame" tells me that the new two files consist mostly of the
material from commit-slab.h moved verbatim, which is assuring ;-).
