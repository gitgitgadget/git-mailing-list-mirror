Return-Path: <SRS0=l3cg=AX=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D829C433DF
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 02:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDFC120748
	for <git@archiver.kernel.org>; Sun, 12 Jul 2020 02:19:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PBO4q/eP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727107AbgGLCN5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 11 Jul 2020 22:13:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726779AbgGLCN4 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 11 Jul 2020 22:13:56 -0400
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com [IPv6:2607:f8b0:4864:20::742])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9685EC08C5DD
        for <git@vger.kernel.org>; Sat, 11 Jul 2020 19:13:56 -0700 (PDT)
Received: by mail-qk1-x742.google.com with SMTP id j80so9122330qke.0
        for <git@vger.kernel.org>; Sat, 11 Jul 2020 19:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=gSiUxMjJrjhiCPXNS/An2M1RjmhLQ4hhq5RZyAy99eU=;
        b=PBO4q/ePG7Dhdq1WG//acYdtehl4hwkZYaLrfie5axA+TInBeaBooxAVKkma03foPd
         pus65kBpkvHTZfqSyEbK5wa3lxH4a9Iru+WKowgKYZIj6Tm7OWPf0MkJGqDZnMpGafFW
         BdE26ypfqyVIFzbNSPg+PrfsfMbNdLduQGLZasr3L3aIWNCTluQzl1T7tHSJInL2ss6A
         UCDz8Nx/YllVg1hW+pFVUbk3+6+3sPOocZo9zBwSJhPtKPLUKzuzfLJL7B6SY+6RjJI4
         JE1IX3PrOLJ0WGHqIvlWOimR6L35f3Z+e4ZK9oSN+lwyX3g9L28SfvjkvweCqSyWMrcg
         Kxmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gSiUxMjJrjhiCPXNS/An2M1RjmhLQ4hhq5RZyAy99eU=;
        b=NesytFvxWVvDkK47CuG73Z6vrlW1+FBUnyjsE5MioIwHAXwWxkmDXamT7/Hpy1LZti
         L5jsqitCSC4tVrovmmtc7dSMBOKmBi1n+DT+VTq07keZNSR5mfHmIuRXh+f5OKRApOMk
         Q/TdEUOnNsrRfcFzBvFZdSXPAxXVh8yX7cZq1/lUCQFCWfGY6E+aCc+YpnEH0I8gVKkj
         z45Xd3hvTJ18J/iEaa0JGk+KwfCMfvMmrws5qvuSejrY/YcOMUfFS/R7Jlxxmba5C6Ed
         8PrOaCYjErqCgWCXdN0BM684jGHc8vBkMn09RjRXSmKnwWIPcmSV07P1JegPwWg93ihQ
         AqlA==
X-Gm-Message-State: AOAM531zVfQcKgiB4YKJ+eJ6t4b3YvBoY9SkCbr+vYf4n2tw2ovnAEge
        AD3qG+r9nRWHCEyniqCxSOkpmihWcjE=
X-Google-Smtp-Source: ABdhPJxzpLT0hXJ2jWBpmBQBjiBJxmyrwUWBPVPAENzT1X1uTSt/dGrtMok0s+QSq/d+jKKq67spDA==
X-Received: by 2002:a37:4b50:: with SMTP id y77mr9580919qka.136.1594520033685;
        Sat, 11 Jul 2020 19:13:53 -0700 (PDT)
Received: from generichostname (CPEc05627352ede-CM185933998587.cpe.net.cable.rogers.com. [174.112.146.193])
        by smtp.gmail.com with ESMTPSA id o21sm13916384qtt.25.2020.07.11.19.13.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2020 19:13:53 -0700 (PDT)
Date:   Sat, 11 Jul 2020 22:13:50 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     "brian m. carlson" <sandals@crustytoothpaste.net>
Cc:     git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH 35/38] t: make SHA1 prerequisite depend on default hash
Message-ID: <20200712021350.GA34873@generichostname>
References: <20200710024728.3100527-1-sandals@crustytoothpaste.net>
 <20200710024728.3100527-36-sandals@crustytoothpaste.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200710024728.3100527-36-sandals@crustytoothpaste.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Brian,

On Fri, Jul 10, 2020 at 02:47:25AM +0000, brian m. carlson wrote:
> diff --git a/t/test-lib.sh b/t/test-lib.sh
> index 307bb2207e..30ab0428fb 100644
> --- a/t/test-lib.sh
> +++ b/t/test-lib.sh
> @@ -1689,7 +1689,8 @@ test_lazy_prereq CURL '
>  # which will not work with other hash algorithms and tests that work but don't
>  # test anything meaningful (e.g. special values which cause short collisions).
>  test_lazy_prereq SHA1 '
> -	test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
> +	test $(git hash-object /dev/null) = e69de29bb2d1d6434b8b29ae775ad8c2e48c5391 &&
> +	([ -z "$GIT_DEFAULT_HASH" ] || [ "$GIT_DEFAULT_HASH" = "sha1" ])

Tiny nitpick that I noticed in passing, is there any reason why we need
a subshell here? If not, I would just switch this to a command group via {}.

-Denton

>  '
>  
>  test_lazy_prereq REBASE_P '
