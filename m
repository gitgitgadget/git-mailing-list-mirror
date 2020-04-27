Return-Path: <SRS0=mOGp=6L=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9DB68C83001
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:46:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 45BA42072D
	for <git@archiver.kernel.org>; Mon, 27 Apr 2020 23:46:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RbenfKqg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726333AbgD0Xq2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 27 Apr 2020 19:46:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726272AbgD0Xq2 (ORCPT
        <rfc822;git@vger.kernel.org>); Mon, 27 Apr 2020 19:46:28 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFEBEC0610D5
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 16:46:27 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id n11so1314871pgl.9
        for <git@vger.kernel.org>; Mon, 27 Apr 2020 16:46:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ET6i6uHTfkHfudWGD+pDe44wT8VNuLl55CfcKq1Le5E=;
        b=RbenfKqgd6r6EUA754wjEG1pM3FmuBBE269/7XrQ4V13Uf/e6NY/nY7WjiqM+C+A8J
         9FNoeJys2gUjrVqzJuTF/2cinMJV0i8e10+LUK1CRU+T4OyUWwtzQ/QY4+WnB+EfRgNK
         QzU/lTx+t8Gtqy/l8LEn6CaVaTATYV4OmDGEjiNW8dwb4jli65GHVhxm0tTMvaE1HksV
         +Gi98dG8x9qbWX/CHeSfXluCqGIMh7Z6s1qzaJn3EAx6VEkYgTywHwb3PLX2eEl2W0n+
         TzihN4XtOJKhj53KDs1ea+vGxcloT0hPJW0UOka77TkDfTKh90J37iSRwMX0RR2rwmjk
         /LKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ET6i6uHTfkHfudWGD+pDe44wT8VNuLl55CfcKq1Le5E=;
        b=GSmtzLQLer1eZEkaX9QtxPPXJCRQnmvWBaRNJkQMeb0cWvl9o6uhekb493IWOIhTSd
         IvKGZYhZi88kGzJkJl6+WSTNKya53u5QrByna1FP1j0i8IDBCbK264Q1fvC4/TbbD7si
         SjVPESJuSvG2rvIMQVdpvxXQZCG79TRuDHNCaWf+rhI7mYW8yF0UdyoGT6LQl06CzwQ1
         VXyTREeJw6Q39V9/qqps4JBBVyJJDyhscwvs1u12fANaKXnNIa2/vUQvsapCp1pe5Erd
         yQ75qqAgDK2W0JV6O6CXjRNxrNYMIPYJcupvtpCA5cPi9KCAqwE7TZBKcm7mEQ33341h
         AXXQ==
X-Gm-Message-State: AGi0PuYInPlUx5M25fEbzlVW6lEB+Oe2D94gdT2JPvvyC/4rYCUOdOuH
        AqDSt/RBvnRTQpftlKpOA3s=
X-Google-Smtp-Source: APiQypIdsSU3kQ4tLggWu7LNXdmR3/8g/OHgsDYO8YOSUOLn/FSel5uHY+TxuoeP8jvD+1ycADkKCg==
X-Received: by 2002:a63:1414:: with SMTP id u20mr8153948pgl.47.1588031187564;
        Mon, 27 Apr 2020 16:46:27 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id c4sm12023721pgg.17.2020.04.27.16.46.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Apr 2020 16:46:26 -0700 (PDT)
Date:   Mon, 27 Apr 2020 16:46:25 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Emily Shaffer <emilyshaffer@google.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] bugreport: drop extraneous includes
Message-ID: <20200427234625.GD36078@google.com>
References: <20200427204859.171084-1-emilyshaffer@google.com>
 <20200427234231.194456-1-emilyshaffer@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200427234231.194456-1-emilyshaffer@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Emily Shaffer wrote:

> In the generic parts of the source files, system headers like <time.h>
> and <stdio.h> are supposed to be included indirectly bt including

s/bt/by/

> "git-compat-util.h", which manages portability issues.
>
> Drop our explicit inclusions and rely on "cache.h", which includes
> "git-compat-util.h".
>
> Signed-off-by: Emily Shaffer <emilyshaffer@google.com>
> ---
>  bugreport.c | 2 --
>  1 file changed, 2 deletions(-)

With that tweak,
Reviewed-by: Jonathan Nieder <jrnieder@gmail.com>

Thanks.
