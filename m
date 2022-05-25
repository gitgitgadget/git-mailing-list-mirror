Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0D429C4332F
	for <git@archiver.kernel.org>; Wed, 25 May 2022 00:14:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242834AbiEYAID (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 24 May 2022 20:08:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230022AbiEYAIC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 24 May 2022 20:08:02 -0400
Received: from mail-oi1-x232.google.com (mail-oi1-x232.google.com [IPv6:2607:f8b0:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01FE96C0C4
        for <git@vger.kernel.org>; Tue, 24 May 2022 17:08:00 -0700 (PDT)
Received: by mail-oi1-x232.google.com with SMTP id q8so23269102oif.13
        for <git@vger.kernel.org>; Tue, 24 May 2022 17:08:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=DvQtZ2XGUahVn0OmCgLQuom82YhA4is7N8udSsK/hOY=;
        b=5TK4L4dthRH7fDG54I5o89vT5UGHUHJ+Eu6VwTDe/NFSKlqoTSBvyeUtyfbtheDHsX
         vdRXQPxrDY1WQ+1lKey43/jNAgZ4XfVc7JSuNy5uTfRg0SjWrKHkjmKb0FqGSji1mgg0
         EBUtg4lfdxMyawFz6MVEDdsQW+ToZiFJcj1yzQ9eOpLA51ECA1USoy/Y3jKM9zvUbIsk
         oVfTwAFZxaSMC9nX5aRCSHhf+iHTuIBVW1sQ1Dwhu9WBf/K4iEPb2NaK1W7iCFIzErSh
         oHdVBIlbtTYEvnufDmeglU89SU3GcS+fVb9llkDg0enMmLoon60vBIzVaR60intV/F4I
         4iBQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=DvQtZ2XGUahVn0OmCgLQuom82YhA4is7N8udSsK/hOY=;
        b=NDntV4lZ1kuS8H2GPpcN9smTuLRMD1lORuNWzYRmcZKmudCXmQNXC64RsNx0ylH+jg
         JyU0R314390+zX+nVNSMbcb1oR6nrihTdD3ojrmXqFg5sw/0ILYQUpvqGEnU3Ica1i2F
         AApz/b5izi2cuKTLLuXLpD9+wR09UUOvuHy1WTQUI/OaUhhrAEvEPH7uXE3A0s49vvAL
         FsvHRGK3Oxtq9d0gep1M+ViRKPctTTreWrknAuJo/s6ftR96LkRUOyudeCrNyEcdTCPt
         f4iFZdS+xqh0IecFZLvk55XQ/+AJQRqRZ7KdnfzqXHB3ZNLy04VG7eTovo0VKEgNs5sH
         SALg==
X-Gm-Message-State: AOAM531M50LX6B57pLMDQRql1G9eE0J/Sk+0E+7j13HxTWJGyu0yxNmy
        vZQZcICx60YHo194iFfS11SKuA==
X-Google-Smtp-Source: ABdhPJzwgXowSFPsxzCEGc05XVojN2MEeQu0L88WoVrE6R3xhlMpeM75hx69ilflzrY5P0h+GLApFQ==
X-Received: by 2002:a05:6808:1703:b0:2f9:cd2d:41c5 with SMTP id bc3-20020a056808170300b002f9cd2d41c5mr3891951oib.77.1653437278889;
        Tue, 24 May 2022 17:07:58 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id l7-20020a4ab2c7000000b0035ef3da8387sm5976570ooo.4.2022.05.24.17.07.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 24 May 2022 17:07:57 -0700 (PDT)
Date:   Tue, 24 May 2022 20:07:55 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     rsbecker@nexbridge.com
Cc:     'Taylor Blau' <me@ttaylorr.com>,
        'Jonathan Nieder' <jrnieder@gmail.com>, git@vger.kernel.org,
        avarab@gmail.com, derrickstolee@github.com, gitster@pobox.com,
        larsxschneider@gmail.com, tytso@mit.edu
Subject: Re: [PATCH v5 02/17] pack-mtimes: support reading .mtimes files
Message-ID: <Yo1zW7ntTuNakpOD@nand.local>
References: <cover.1638224692.git.me@ttaylorr.com>
 <cover.1653088640.git.me@ttaylorr.com>
 <91a9d21b0b7d99023083c0bbb6f91ccdc1782736.1653088640.git.me@ttaylorr.com>
 <Yo0ysWZKFJoiCSqv@google.com>
 <015d01d86fa6$a10519f0$e30f4dd0$@nexbridge.com>
 <Yo1bUbys+Fz7g+6h@nand.local>
 <016e01d86fc5$64ecf180$2ec6d480$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <016e01d86fc5$64ecf180$2ec6d480$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, May 24, 2022 at 07:24:14PM -0400, rsbecker@nexbridge.com wrote:
> On May 24, 2022 6:25 PM ,Taylor Blau write:
> >On Tue, May 24, 2022 at 03:44:00PM -0400, rsbecker@nexbridge.com wrote:
> >> I am again concerned about 32-bit time_t assumptions. time_t is 32-bit
> >> on some platforms, signed/unsigned, and sometimes 64-bit. We are
> >> talking about potentially long-persistent files, as I understand this
> >> series, so we should not be limiting times to end at 2038. That's only
> >> 16 years off and I would wager that many clones that exist today will exist then.
> >
> >Note that we're using unsigned fields here, so we have until 2106 (see my earlier
> >response on this in https://lore.kernel.org/git/YdiXecK6fAKl8++G@nand.local/).
>
> I appreciate that, but 32-bit time_t is still signed on many
> platforms, so when cast, it still might, at some point in another
> series, cause issues. Please be cautious. I expect that this is the
> particular hill on which I will die. 😉
> --Randall

Yes, definitely. There is only one spot that we turn the result of
nth_packed_mtime() into a time_t, and that's in
add_object_in_unpacked_pack(). The code there is something like:

    time_t mtime;
    if (pack->is_cruft)
      mtime = nth_packed_mtime(pack, object_pos);
    else
      mtime = pack->mtime;

    ...

    add_cruft_object_entry(oid, ..., mtime);

...and the reason mtime is a time_t is because that's the type of
pack->mtime.

And we quickly convert that back to a uint32_t in
add_cruft_object_entry(). If time_t is signed, then we'll truncate any
values beyond 2106, and pre-epoch values will become large positive
values. That means our error is one-sided in the favorable direction,
i.e., that we'll keep objects around for longer instead of pruning
something that we shouldn't have.

Thanks,
Taylor
