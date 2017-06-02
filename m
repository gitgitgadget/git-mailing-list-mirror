Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.7 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 0753920D11
	for <e@80x24.org>; Fri,  2 Jun 2017 01:59:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751157AbdFBB7f (ORCPT <rfc822;e@80x24.org>);
        Thu, 1 Jun 2017 21:59:35 -0400
Received: from mail-pf0-f195.google.com ([209.85.192.195]:35783 "EHLO
        mail-pf0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751120AbdFBB7e (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Jun 2017 21:59:34 -0400
Received: by mail-pf0-f195.google.com with SMTP id u26so10224848pfd.2
        for <git@vger.kernel.org>; Thu, 01 Jun 2017 18:59:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=Kciatj8Cac938qIsPJMmW/Kisjc24L9XqYQFeDnns4c=;
        b=k9kDquPF9EqVlkD5ip1BGZibTcvdwNNVX2U8mWJFAKPb9wHwGbpTyFoypBV/Hrdcgf
         ktbFCPWVcZ9ZRPD1G7nn7pAGVAmBUielb5EUoQB+HYi8b93phjgcxj2Gl2y+VHhORVVM
         Wsz5rKZFxTyCP6sWRQkQXVrVDGyB68+mLr9j8Kn3IUzfGhsOtBtv3rNY8z6pvhp33gXJ
         irbQ39HtRO2cVaJa2L6tCcwZkS2O0gjENuZxT+iZ/MtVeAxQ16gIJBfOCeQCQvy9Wpzf
         DDe7Oqn/XWJrOpMPrGpu35cVJeuxK1O6vLMHR7NnJPeaCAaDNgz8Slh/zQnIVElZb5jw
         oUeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=Kciatj8Cac938qIsPJMmW/Kisjc24L9XqYQFeDnns4c=;
        b=rv1d0MxcDZOAgb8//9rAa5kTphzX4PPerMStQ6CdsQbBEO4ucECavC/S5VrvRg9ie3
         x2sa61OPbysYCxjU+LTGEUpJsalDn1bUHkdE7ARwYF4s6R9lDc4BLOBTs/e/G/FRf5Ci
         L/R+tIQ0UOaI6qqS071Kip6YYsoNiAeEi7qWL3+gHyNIht2ZZ3sEHIVCEKKRYc/z4t6P
         LcKkyToLSb6NCyG657DhTHn6ZoDpIQIx6yzOnNvEjbWhnxfU+0ueP6VAAUrPGDarMPqe
         oEwoO4r/KZnLoo+4EsDlq9RzBYEQODXmWS4G6y49uLO9RtL2rY+Nhj+T7pGna1hv0Tba
         UrcQ==
X-Gm-Message-State: AODbwcBJootQRqEDuJiesmvO9GvqdyhkNyDU17jLB0gAoCBGN0rjhRJQ
        ou6uQOLkkDFadA==
X-Received: by 10.98.204.150 with SMTP id j22mr4177409pfk.236.1496368773541;
        Thu, 01 Jun 2017 18:59:33 -0700 (PDT)
Received: from localhost ([2620:0:1000:8622:ec2c:8ebb:3fc7:e0d4])
        by smtp.gmail.com with ESMTPSA id g27sm36814747pfg.63.2017.06.01.18.59.32
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 01 Jun 2017 18:59:33 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jonathan Tan <jonathantanmy@google.com>
Cc:     git@vger.kernel.org, bmwill@google.com, jacob.keller@gmail.com
Subject: Re: [PATCH] send-email: check for repo before invoking hook
References: <CA+P7+xr39qk9qHE0=uU3HZE2wOhU9X7rmENoDfP=bp09j9N9Mg@mail.gmail.com>
        <20170601235055.22621-1-jonathantanmy@google.com>
Date:   Fri, 02 Jun 2017 10:59:32 +0900
In-Reply-To: <20170601235055.22621-1-jonathantanmy@google.com> (Jonathan Tan's
        message of "Thu, 1 Jun 2017 16:50:55 -0700")
Message-ID: <xmqqinkf175n.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks.  

"git show -w" tells readers how this fix is trivially correct ;-)

Will apply.
