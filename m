Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	T_DKIM_INVALID shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 398911F51C
	for <e@80x24.org>; Mon, 21 May 2018 05:11:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1750829AbeEUFLL (ORCPT <rfc822;e@80x24.org>);
        Mon, 21 May 2018 01:11:11 -0400
Received: from mail-wr0-f196.google.com ([209.85.128.196]:45172 "EHLO
        mail-wr0-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750703AbeEUFLK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 21 May 2018 01:11:10 -0400
Received: by mail-wr0-f196.google.com with SMTP id w3-v6so6935874wrl.12
        for <git@vger.kernel.org>; Sun, 20 May 2018 22:11:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=Q9SuEK/BOrJ//HauZrtpX/zDdMd6kqes+2MXIar9Iu0=;
        b=JC3sDLaKNoET4OlBfw4As15DSQNwAT2ow+EmewG6aotJwGhty9faZBkFA9wwt3LJSA
         ECJzmoPFqFsiitOXwPWWXnQegzSiR6ZXnnmjvMZrZqWPidlauj88X9AqDM0bVg0YSMo4
         1XA2oXI9nyaHRc9ilp2MTC3jm3FkVFK0EB7fTBokC9w1cy8VGWupljTQcvozQEEgP9lL
         FQIQIk69QWl+yQcHDu66dLqtDwWf01A6yymQcKipdReOiK1AJQwVllVXO/UpZLoytpzl
         R8omV+JBwd6dHz+W/bHdENXZSGlf7a2BINeuPKu/lPfiRHlx0VDE9USKsO0R99TjxwkT
         6c+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=Q9SuEK/BOrJ//HauZrtpX/zDdMd6kqes+2MXIar9Iu0=;
        b=ZB3VJ2YlfUuJzYXUMGD7cqNa0sv+hWk94HVPoPLzHEyh9kh5sMDI1XJXO6ivGih4Nh
         FUZdFuoS/dEd5f4e132JysJpdX0Dtrs64NNUmq+VP81vSwvZth/mHyW0iSmzAATdLuah
         v6TsXoJ3flQwLW1lrpzL+/DBU2jnSyawyUBx2L2TcE85h6O2tS31x44L2IQVhFM+bsdG
         kguBdwYbENfSWWnLO0+yYiFrc/bOC+J6XkkY9yJOA6NGTy/4jAxGX2QdHqOQctiN77ER
         9+ZLFrLqxxhTqdnWPIWWhwW5uzLmmK+yFQwDj0sYoJ4NJAz5IK2P/udoAMJqWV6uQ/8m
         ZrPQ==
X-Gm-Message-State: ALKqPwfAGLPbGKkMo4Laq5u1AZin9SvI1zmeVS6UoqxGEFOmqcj19PS0
        XkHKhXVu/cWC2yg1U7h+yPktdKrI
X-Google-Smtp-Source: AB8JxZpcAdq1ytBR51y4OOuzP1W5Z50M39+jtghxfT1Wnu7v5XHku5ajMhFd84E9zxh3u1hmovDIvw==
X-Received: by 2002:adf:9187:: with SMTP id 7-v6mr2070510wri.222.1526879468868;
        Sun, 20 May 2018 22:11:08 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id 44-v6sm29400961wrv.47.2018.05.20.22.11.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 20 May 2018 22:11:07 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH v3 01/15] commit-slab.h: code split
References: <20180513055208.17952-1-pclouds@gmail.com>
        <20180519052831.12603-1-pclouds@gmail.com>
        <20180519052831.12603-2-pclouds@gmail.com>
Date:   Mon, 21 May 2018 14:11:07 +0900
In-Reply-To: <20180519052831.12603-2-pclouds@gmail.com> (=?utf-8?B?Ik5n?=
 =?utf-8?B?dXnhu4VuIFRow6FpIE5n4buNYw==?=
        Duy"'s message of "Sat, 19 May 2018 07:28:17 +0200")
Message-ID: <xmqqr2m51tlg.fsf@gitster-ct.c.googlers.com>
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
> commit-slab-hdr.h and commit-slab-impl.h respectively.

s/hdr/decl/;

>
> This right now is not needed for current users but if we make a public
> commit-slab type, we may want to avoid including the slab
> implementation in a header file which gets replicated in every c file
> that includes it.

s/c file/C file/; 

Also s/may want to/need to/; after all this is not about avoid
bloating the header and slowing down compilation.  Rather, the
duplicated implementation will cause linkage failures so we want
only a single implementation that is referenced from many places.

> ---

Missing sign off.

>  commit-slab-decl.h |  30 ++++++++++++
>  commit-slab-impl.h |  91 +++++++++++++++++++++++++++++++++++
>  commit-slab.h      | 115 +++------------------------------------------
>  3 files changed, 127 insertions(+), 109 deletions(-)
>  create mode 100644 commit-slab-decl.h
>  create mode 100644 commit-slab-impl.h

Other than that, looking good.
