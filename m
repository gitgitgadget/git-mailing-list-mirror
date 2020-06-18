Return-Path: <SRS0=1Nmv=77=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C71B5C433DF
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 08:44:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CD002089D
	for <git@archiver.kernel.org>; Thu, 18 Jun 2020 08:44:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XnNMbaER"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728786AbgFRIoy (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 18 Jun 2020 04:44:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728600AbgFRIox (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 18 Jun 2020 04:44:53 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 501E3C06174E
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 01:44:51 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id y1so3778636qtv.12
        for <git@vger.kernel.org>; Thu, 18 Jun 2020 01:44:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=+YyZ9r/hBFItZdLCPapAuLuePLc8CNdQEsHrGgIUsNs=;
        b=XnNMbaER9tQlID4pngwiFhfN8Q3TjiZW1ePb+9jDkXIgzeJhFJ8AdTuSe/pd9bIJY1
         DIgkU5CKhEClH2mTalOlhJ5WhgvCMFkLS23sTAncKhuyfkEVl0bSq4b4yPfqGKkxKo77
         wQ18zpw62WuEuiBg060VWm9B8B5zTm2Bz0yXNVt89ceMaWxtshb7ncV6v94EkI2YVdaE
         QeRqQHlRRqHjwu6M6rWpCUIo5MB3u73mue4rx6cWGvUSbXxPTRSPCjCRv+H8sY86NZG3
         GCE5SMW2Swzau3prCYBhsjj1EsMnX9jmzgV13/0a83nNxC+KPt13APje8XwUq4JYcEV3
         6ugg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=+YyZ9r/hBFItZdLCPapAuLuePLc8CNdQEsHrGgIUsNs=;
        b=Gg030uaX0+RMt78WyHjNaLQ3Yj/j2lxvurG15ZLHiLpmgQECvH7AjdMEy5hHU99zhz
         kug9n9ysOz8OWjifhinME2QWR7v6tKJFn0VW9YqkJNdptl+Zu59UEv4KblDZlA8drEJa
         B8Jk6tPauYsmJEsPlQ096UN90WkidRGABb3oNSTrcruX16rEXJ2F6OhBHZxLTxMVfJ2Y
         OUGDNIXKXVG1FUFDyqux98vBeER/MDE+QO9mN0izbe/uuz3/+2JizwZ+zFQOjxZnHIBd
         Sj+G0uLWNYQfbP5qwytIyOX1q7AQ76WW6a4ma0R1E7zS49iwWVjP1A1ffy2ZZ6BfpTlk
         z2pA==
X-Gm-Message-State: AOAM5311PCw0MYjP9DKUfDTZb/O9XXXGZxOOKeoxx6n3HZJquKIjdPFN
        zWvBmklJYLiF0dDscnK2GW5zN1GnJrI=
X-Google-Smtp-Source: ABdhPJw7urIuxoYz58SejPyLOOBhmuSwnx/qEDKinMqothMuFwDBP6Q3zWtGRd+RjH/WDslc3nkrMQ==
X-Received: by 2002:ac8:1181:: with SMTP id d1mr3398693qtj.290.1592469889814;
        Thu, 18 Jun 2020 01:44:49 -0700 (PDT)
Received: from generichostname (CPE18593399858a-CM185933998587.cpe.net.cable.rogers.com. [174.112.65.113])
        by smtp.gmail.com with ESMTPSA id y40sm931936qtc.29.2020.06.18.01.44.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 01:44:49 -0700 (PDT)
Date:   Thu, 18 Jun 2020 04:44:45 -0400
From:   Denton Liu <liu.denton@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: What's cooking in git.git (Jun 2020, #03; Wed, 17)
Message-ID: <20200618084445.GA1424302@generichostname>
References: <xmqqpn9wq3tl.fsf@gitster.c.googlers.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <xmqqpn9wq3tl.fsf@gitster.c.googlers.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On Wed, Jun 17, 2020 at 11:35:18PM -0700, Junio C Hamano wrote:
> * dl/test-must-fail-fixes-5 (2020-06-12) 4 commits
>  - lib-submodule-update: use callbacks in test_submodule_switch_common()
>  - lib-submodule-update: prepend "git" to $command
>  - lib-submodule-update: consolidate --recurse-submodules
>  - lib-submodule-update: add space after function name
> 
>  The effort to avoid using test_must_fail on non-git command continues.
> 
>  Ready???

I have a reroll with the change that you asked for and also some
additional documentation (the original patch was a little lacking).
Also, I think it'd be a good idea for Peff to take a look at it first.

Thanks,

Denton
