Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C75EC4360C
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 23:42:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D3FE123619
	for <git@archiver.kernel.org>; Wed, 20 Jan 2021 23:42:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732309AbhATWbw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 20 Jan 2021 17:31:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727081AbhATVxS (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 20 Jan 2021 16:53:18 -0500
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17F6C061575
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 13:52:37 -0800 (PST)
Received: by mail-qt1-x82e.google.com with SMTP id j26so148577qtq.8
        for <git@vger.kernel.org>; Wed, 20 Jan 2021 13:52:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=2JQE1dRupAJgMJ65Y+QbJ2r/bi+0nKHwk3ao0XD3EFQ=;
        b=K5/CFIFXosfZ31vFxsy5dPX1UwD/kBG1q+t18HMw08Q/xMeFyw6LFTQfdhlUQiUcW+
         3GCJgpqDQYVLuMrwLX1fuJfkrwpvfw/P+e6OEcasJK/INmhL3scrTlquPfWv6DU8ercU
         dAdA32WeCQyktoLS9OtZ61KnpJLNB7QBd6XVkj3Pqc86IUyZnZpO9/qd/xJh3B8YS1ZQ
         DTMAvSx2TRnuK2w6F+74btxYQ6OMkFlCOKkx0cd8HDtZBCHHGOyDLfCGqViIwRa8nYQv
         ZKzBupORClsWp2etObc/uR2ZcQFDH0Wz5w5fqSn/KcngM7t2ZqJCOre1R4IreGNGknu0
         8Izg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=2JQE1dRupAJgMJ65Y+QbJ2r/bi+0nKHwk3ao0XD3EFQ=;
        b=oPEX3ra/TG9998n2HJQRhquHa8muAbEF4KAPivoAHKASjas7u1HLoleYBhWI77ScIC
         U4Q9/LTLbxvkUdIVI1pIi8B810NJKnpkiUbNmHYjLjcdwbhyUdgkqneDjDo+HDBVRHlE
         qxJNzgH5ofY3BNrgY+BRNG4zQslw0WssLSnfJY3NebC7JD99z2Jab3oCmjKyZvjyhGxb
         vUNi+a5aBH97uhCHec4H+6/k6piiJnxeESVNkF45aXKID4MrYMPvmzPhNJ6S+WZ87yvV
         hz3Y+hu2+2EAuaQ0NgcEGqKECDncUP/iXjVxv1tjBFkln+zEbkNk9zTsAhtz6uLjT+TD
         80XA==
X-Gm-Message-State: AOAM532GeeveRtUlcKWozWHgidYF/rqaRmTjZFVxSe48XzXuY5DZRMc/
        zqnBIZNmlwAjM9ZxsSntFY5JYA==
X-Google-Smtp-Source: ABdhPJwxLz6eQapma2t8DyJ1sWnlnIdA0Tvb9RMkFqg7luL++hFzZgr82DPMNG+qupyD+nKTmTTgdA==
X-Received: by 2002:ac8:6ec5:: with SMTP id f5mr10981475qtv.56.1611179557019;
        Wed, 20 Jan 2021 13:52:37 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:7d49:7932:5c79:ddd4])
        by smtp.gmail.com with ESMTPSA id x134sm2329991qka.1.2021.01.20.13.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Jan 2021 13:52:36 -0800 (PST)
Date:   Wed, 20 Jan 2021 16:52:34 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jacob Vosmaer <jacob@gitlab.com>
Cc:     Jeff King <peff@peff.net>, Taylor Blau <me@ttaylorr.com>,
        Git Mailing List <git@vger.kernel.org>, avarab@gmail.com
Subject: Re: [PATCH v2 1/1] builtin/pack-objects.c: avoid iterating all refs
Message-ID: <YAimIr9j7SsmJJ55@nand.local>
References: <20210120124514.49737-1-jacob@gitlab.com>
 <20210120124514.49737-2-jacob@gitlab.com>
 <YAhC8Gsp4H17e28n@nand.local>
 <YAhXw9Gvn5Pyvacq@coredump.intra.peff.net>
 <YAhYHUcdynbWyhwo@nand.local>
 <YAiIbEAZSlL7B+am@coredump.intra.peff.net>
 <CADMWQoPrKBjLM5ABhhhCibEyJVOXQxsNkncSU6dmwjynQ1oCcQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CADMWQoPrKBjLM5ABhhhCibEyJVOXQxsNkncSU6dmwjynQ1oCcQ@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Jan 20, 2021 at 10:46:29PM +0100, Jacob Vosmaer wrote:
> On Wed, Jan 20, 2021 at 8:45 PM Jeff King <peff@peff.net> wrote:
>
> > I also rage-replaced peel_ref() with a function taking an oid so we
> > never have to do that digging again. Posted separately in its own
> > thread.
>
> That sounds like a good solution. Where does that leave my patch? Do I
> need to wait for that new commit somehow? I don't know how that works,
> "contributing to Git" wise.

Peff noted in the patch to nuke "peel_ref()" that merging his and then
yours will cause a merge conflict, but it is trivial to resolve. So, I'd
expect that Junio will pick up both and resolve the merge conflict when
queuing.

Or, in other words, I don't think there's anything left on your part
;-). Thanks for providing your patches; there was a nice digression and
I'm quite happy with where we ended up.

Thanks,
Taylor
