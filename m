Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA86DC48BDF
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 05:25:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C680B613CC
	for <git@archiver.kernel.org>; Thu, 24 Jun 2021 05:25:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230091AbhFXF1h (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Jun 2021 01:27:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229448AbhFXF1h (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Jun 2021 01:27:37 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C231C061574
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 22:25:17 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id w13so715483edc.0
        for <git@vger.kernel.org>; Wed, 23 Jun 2021 22:25:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=klerks-biz.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ay3zPdc7IK3tQrKOnRySB4pk4c0XawsU59nNgiyTbes=;
        b=N71Csh0Zlzmk/ZLpHlNU2FOTyy/k1H58tcVsWosADcCeGAZc5KVcqcNUbrkd5fWAdd
         TqhDgoPjjSojHnJns7OUIvNIi4d4TEyNiqT8Jaq47ltMLv0+JjM6Ltb8s6N7JjA6GvVs
         3PqHdXCDfs2n543bxPwQxiWvlJgMB6AeAtNfkCw0t4YD7OP13UzeBb7Yboz79sZ8PGeG
         Sc2WXZ9fW0nRXpZ0AYZoDko6tkaHB9ffQ7E8zhHD6QfPjTmWBx1aeUCfImQfT+j23B8H
         i6C6VPDtIfpyN2q0Z3wD+jmwPeu18UQpkXKJgR7tRDdh5T89G+7G/JmRdiV9yrrvQHPQ
         plsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ay3zPdc7IK3tQrKOnRySB4pk4c0XawsU59nNgiyTbes=;
        b=ET8vRmvn0B5/t/0GlW4fLskLA+G9me3tU3NtJ92/3OXuroKjRO/ijN9jg5Y0z+WHyp
         cYyC4REp3xl3WuIilPDoK34LxuBDRqXBu7xuZKmpcOKpnWogSqbeULXFgO+y13/OUVEf
         xspUyfkm4g4uaSAiVVPkDFe8dsEbuM82NDB/vsBVH+lsFuj50EHhcRpVfAnlY8c9KsdO
         WFYPpaUpgvC/hlBAeMffFulfHjGY6EEZCGOxuHRCELR4HQLk5wGuNG8/zX6x4P23eKVT
         g9CyRHutJq5GI+d2pF8kM5AyXU1Av2htbWf57JDjFrBuMG+kbyQMw3VoZge+48HZDfIF
         y2mA==
X-Gm-Message-State: AOAM531kmTBsqiZa7Jpwe8DWzjjFyTXrwkyhmEdjMcN2zeZj+c68bQcE
        edboJO34kanPBHF5503gecSKvh1eOcQolsjn3bG9CynqW+7k3g==
X-Google-Smtp-Source: ABdhPJxF0bPcXGo6qfd1k1EnNj3mhJFJbIKBOfe3yd6GvJky4lmrxUVDQgE2vPD1fmrLlEAh1QEObd5aW9rOsDs1dSw=
X-Received: by 2002:a05:6402:1d55:: with SMTP id dz21mr4474012edb.338.1624512315925;
 Wed, 23 Jun 2021 22:25:15 -0700 (PDT)
MIME-Version: 1.0
References: <CAPMMpog7bNNPm3suZKu6OppHA+KDYgCfmaxW4HqTAr7_tTVAPQ@mail.gmail.com>
 <nycvar.QRO.7.76.6.2106111122010.57@tvgsbejvaqbjf.bet> <CAPMMpogeWeQujG0UL80REOsaBJipxhQyOpBTuWD9U9_jg=FMMA@mail.gmail.com>
 <81153d02-8e7a-be59-e709-e90cd5906f3a@jeffhostetler.com>
In-Reply-To: <81153d02-8e7a-be59-e709-e90cd5906f3a@jeffhostetler.com>
From:   Tao Klerks <tao@klerks.biz>
Date:   Thu, 24 Jun 2021 07:25:05 +0200
Message-ID: <CAPMMpojKMZmorKPgMASkHsvKcQTaaGyWURsgDS+KTGVeuBh1ww@mail.gmail.com>
Subject: Re: Windows: core.useBuiltinFSMonitor without core.untrackedcache -
 performance hazard?
To:     Jeff Hostetler <git@jeffhostetler.com>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        git <git@vger.kernel.org>,
        Jeff Hostetler <jeffhost@microsoft.com>,
        Derrick Stolee <dstolee@microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Jeff,

On Mon, Jun 21, 2021 at 8:41 PM Jeff Hostetler <git@jeffhostetler.com> wrote:
> We're currently looking at a problem that we believe is in the
> untracked-cache code.  This is causing some of our Scalar tests
> to fail on Windows when the untracked-cache is turned on.  This
> is independent of whether FSMonitor or FSCache is turned on.
> We're still tracking this down.
>
> And yes, the best possible solution is to turn on FSMonitor *and*
> the untracked-cache, so that the "untracked" status code doesn't
> have to do anything.  So I want to look at tracking down the above
> problem before doing anything else.

I got a bit excited about a possible clean path forward to getting
-uall to work well with untracked cache, and submitted a patch along
those lines, but rereading the above I should probably have been a
little more patient.

Is there anything "we" can do to see/understand the
scalar-test-suite-error you describe above, or is this
microsoft-internal?

Thanks
Tao
