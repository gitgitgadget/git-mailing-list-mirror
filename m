Return-Path: <SRS0=ToNR=6F=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CE5CC2BA19
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 06:16:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E1A62084D
	for <git@archiver.kernel.org>; Tue, 21 Apr 2020 06:16:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KrZgovyj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726018AbgDUGQA (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 21 Apr 2020 02:16:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725902AbgDUGP7 (ORCPT
        <rfc822;git@vger.kernel.org>); Tue, 21 Apr 2020 02:15:59 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2CCFC061A0F
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 23:15:59 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id a5so182583pjh.2
        for <git@vger.kernel.org>; Mon, 20 Apr 2020 23:15:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=1B1NuutHHfT5zlzjLso2zVz8fBzadKQ6tZgoIermTsE=;
        b=KrZgovyjaVq62GdBPo0wkUTsfCDwBiOLpElfLu1+OEReOvFu9hq6fynLzHFYjCD+JG
         EBmOK9yykNwOnA+j7lFpmebSNVcU289DHhuf8+3VBUPlDChXxnZPR9H/+WLXLhDDsVYV
         UXihkmRyVPR5+TF6yQEPWYWgKbRn8FUc/XvDIkxRpXGGqYVJPQAAu0oy+Z/M2Ez1Ae/l
         JmC46h/T1MGsHN/MwHliU7qEHWodOAj+LZYJay1sT+DPmt7SbEw/m1f0TshbC9BPLjD+
         3NOLZhAlYu8z0BrnBGNoJEGZXw8/BglgQRR+o/g5fsLaDNHIIlIjfMGCgY5mWql4wAwq
         2ZNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=1B1NuutHHfT5zlzjLso2zVz8fBzadKQ6tZgoIermTsE=;
        b=XwwCdLHT759FQu6uKMNTS/ekkpzH2rv/76on+QTsX6u4U/LyF7zkB6kjl+PluYXcN1
         LVQemdDexxda5TXog/+OuH3+v0enV3m4hElSnfpWQzAjGiHwh5tvgQLa1eYyAhjKt1yc
         k5puT8xaDjhrYXZiBXSYln/q8YYsTQ7wu7PEic9spMd+e2RH2m2qQ7oeINZQLVTbw2S/
         VLJ1bPj9QSTy76isdzFf2pGCFcZkPdbPHeuYO/NEZKQiVArsXxyY5FTcWIjenA0tVfZK
         hOB/HGiyTlsxmcVHVZl1R/6ZS3wd0967M37hcOrgJSuoWsF67elwXWj821K0emcomJHd
         1W+Q==
X-Gm-Message-State: AGi0PuYFOTc4KFB39znt6JIw3GlzBhj6X3RZLh1RcvXELRApm98vgPLa
        /JIqObprGO3D2qoceOj6nuQ=
X-Google-Smtp-Source: APiQypJDPsVIrzegAgWzqYVLWOCER2kU8ei9jQnVtxDisOb8cMMEKX49t2ZVZQ94FwrtSnNiWl64eQ==
X-Received: by 2002:a17:90a:1911:: with SMTP id 17mr3638174pjg.65.1587449758954;
        Mon, 20 Apr 2020 23:15:58 -0700 (PDT)
Received: from google.com ([2620:15c:2ce:200:cf67:1de0:170f:be65])
        by smtp.gmail.com with ESMTPSA id 13sm1417416pfv.95.2020.04.20.23.15.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2020 23:15:58 -0700 (PDT)
Date:   Mon, 20 Apr 2020 23:15:56 -0700
From:   Jonathan Nieder <jrnieder@gmail.com>
To:     Carlo Marcelo Arenas =?utf-8?B?QmVsw7Nu?= <carenas@gmail.com>
Cc:     git@vger.kernel.org, peff@peff.net
Subject: Re: [PATCH] osxkeychain: restrict queries to requests with a valid
 host
Message-ID: <20200421061556.GD96152@google.com>
References: <20200420224310.9989-1-carenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200420224310.9989-1-carenas@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi!

Carlo Marcelo Arenas Belón wrote:

> make sure that requests to this helper to get credentials return early if
> there is no host ord the host is empty.
>
> Signed-off-by: Carlo Marcelo Arenas Belón <carenas@gmail.com>
> ---
>  contrib/credential/osxkeychain/git-credential-osxkeychain.c | 6 ++++++
>  1 file changed, 6 insertions(+)

We had mentioned while preparing v2.26.2 that after that release
hardening the git side of the credential helper protocol, we should
harden the helper side.  Thanks for getting it started.

[...]
> diff --git a/contrib/credential/osxkeychain/git-credential-osxkeychain.c b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> index bcd3f575a3..2264a88c41 100644
> --- a/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> +++ b/contrib/credential/osxkeychain/git-credential-osxkeychain.c
> @@ -69,6 +69,12 @@ static void find_internet_password(void)
>  	UInt32 len;
>  	SecKeychainItemRef item;
>  
> +	/*
> +	 * Require at valid host to fix CVE-2020-11008
> +	 */
> +	if (!host || !*host)
> +		return;

While we're here, is there any validation we should do for any of the
other parameters to SecKeychainFindInternetPassword (username, path,
port, protocol)?

Also, should we check for duplicate fields as in CVE-2020-5260?

> +
>  	if (SecKeychainFindInternetPassword(KEYCHAIN_ARGS, &len, &buf, &item))
>  		return;

Thanks,
Jonathan
