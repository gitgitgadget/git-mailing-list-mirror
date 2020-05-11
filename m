Return-Path: <SRS0=tgTL=6Z=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D140C47255
	for <git@archiver.kernel.org>; Mon, 11 May 2020 23:26:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFFED20675
	for <git@archiver.kernel.org>; Mon, 11 May 2020 23:26:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y7e9qpA/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725895AbgEKX0f (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 May 2020 19:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725836AbgEKX0e (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 11 May 2020 19:26:34 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 323F5C061A0C
        for <git@vger.kernel.org>; Mon, 11 May 2020 16:26:33 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id 7so7913831pjo.0
        for <git@vger.kernel.org>; Mon, 11 May 2020 16:26:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=J1mVxJTDvUAKms9ZsFf7foYNDkJmkUm/YY6KqkYQwAM=;
        b=Y7e9qpA/iAN1Utr6cp9mFLjt8G5GDPuiNkfoWUWHsIIRgCs4X155NOsQnXzMikJiDS
         Ow5a8IaoF4PGVBJO3VdWObrXqVGxxXDWB3dSEq0ThhVX2ftvUk222ldA7uZqGgyET+Zq
         7L/GNY+gxZJD0pzhf4GdHOFJuTa+Dc8op5iS6HQlY5g/hM0DHTI7YylPY+1Bgr1oELyw
         vVo75reCMsyJ1gy0DxMWFonZN2mIU57WE1H770U1gawvKQiE1PHcBC8wIWQhgfu/92ce
         aEqzXzrGa1kQ2VgAqCIiWoO+GaofUJJD35QH1NT4px55OTVCNFTLrSeiBmKVpHC5hrEB
         9JZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=J1mVxJTDvUAKms9ZsFf7foYNDkJmkUm/YY6KqkYQwAM=;
        b=iKCWF88PqWTQyGil4fL5aJPukb84LEdOEpzjE8it+VKDVm9rVMd4cQ2LqdTeyal3uT
         8Qz4LhkeYiM7GlkUoXwXyQhZMJ9sinUaW88DcXOjkqTnMEZWig79atls/0q1XvinmISz
         gL7jlFJZPQ2MDLIeaU7zoFdZIy/SOHDRE9kewVXG8cVnPRAJCanWpW8/rM4asR6ZIXuR
         1357AXH8T6Xeery7twg6TBLqqdh5pQ9R3GNH2/61XksTngosufCVggYXvgrJcg19FduF
         pRB0fJWKu5vLM5jZmKZCbsB5CpwueoS7P2qzwY5AM3rcyz2MURCTmyq71JH6vNdz/OFX
         Opng==
X-Gm-Message-State: AGi0Pubvd1mjl8Hw6Ax87EM1EEx0e7X1D+WBbRWCTlqVM5F0p88FIEAE
        KHfS88jklv2ATc5fyjk3WKQ=
X-Google-Smtp-Source: APiQypJTbFA6XwjFtJPNy4HTzjsJ/+hs8qAbDI6bCOdLnoidsxgfGGjBifF742MeW6jrk97dpNk3Ag==
X-Received: by 2002:a17:902:c113:: with SMTP id 19mr17038782pli.95.1589239592347;
        Mon, 11 May 2020 16:26:32 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id fu12sm11058034pjb.20.2020.05.11.16.26.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 11 May 2020 16:26:31 -0700 (PDT)
Date:   Mon, 11 May 2020 16:26:29 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        =?utf-8?B?xJBvw6BuIFRy4bqnbiBDw7RuZw==?= Danh 
        <congdanhqx@gmail.com>
Subject: Re: [PATCH v5] bugreport: collect list of populated hooks
Message-ID: <20200511232629.GB141481@google.com>
References: <20200508005357.223058-1-emilyshaffer@google.com>
 <20200511221430.174122-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200511221430.174122-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

Emily Shaffer wrote:

> Occasionally a failure a user is seeing may be related to a specific
> hook which is being run, perhaps without the user realizing. While the
> contents of hooks can be sensitive - containing user data or process
> information specific to the user's organization - simply knowing that a
> hook is being run at a certain stage can help us to understand whether
> something is going wrong.
>
> Without a definitive list of hook names within the code, we compile our
> own list from the documentation. This is likely prone to bitrot, but
> designing a single source of truth for acceptable hooks is too much
> overhead for this small change to the bugreport tool.
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  Documentation/git-bugreport.txt |  1 +
>  bugreport.c                     | 52 +++++++++++++++++++++++++++++++++
>  t/t0091-bugreport.sh            | 15 ++++++++++
>  3 files changed, 68 insertions(+)

Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
