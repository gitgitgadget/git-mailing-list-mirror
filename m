Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0ADC433EF
	for <git@archiver.kernel.org>; Tue, 11 Jan 2022 03:00:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234101AbiAKDAS (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 Jan 2022 22:00:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231590AbiAKDAR (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 Jan 2022 22:00:17 -0500
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3505FC06173F
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 19:00:17 -0800 (PST)
Received: by mail-io1-xd36.google.com with SMTP id w9so7446507iol.13
        for <git@vger.kernel.org>; Mon, 10 Jan 2022 19:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=uMKtizPD73rotkRlfLAMU8TEyvZ5W60ZVWXWLApodEA=;
        b=KAUEC0HUl84SUv3mso2kixGT7McP5ToHhwa58p4nekwZtR0OCD1lavNTeA9MZKiIpt
         UbaUG2QUV4UkNIW9uB+mCNj6ucRXGq5QumSIan5Ujf/L/3vlbj9WswoEOiwTV4bMf/HG
         dgkN3lx1nJsi6iiFDF8fg28mSjiDdGBbP7j+MJhDf5sfcbIJyx6qe5axOisG4z6X01mp
         RKBi6Wwxx3S7s17t4YDG4iSe2pxQwsR1KWa+isaqrN7KyiH8nKckwiAkKNwOo7CGtdDe
         3S911w5p6jlreKYpkNm9EagLImY+3o7qaMH/9kGBPi1WX8ROp8hZnKJ9cXVPH6M0gtIH
         JkJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uMKtizPD73rotkRlfLAMU8TEyvZ5W60ZVWXWLApodEA=;
        b=HHF/qeDCOG/tB0DWpPRcN/EaX0aKsMyeOIHFbOUXsZJ/PPr9w/xUuaLyBGmavxZE1I
         6PtrE+KhxPi2F4IZUEGwK3rbz20d5l9sjY8xySOR1KZWdNkSPyHL0Xbmd+LwAK91KypT
         2nsEoM0/fZKWmQ0EpI/mKP4Np4DTyGrhX1Fq2n30qtycv/UXIwv3oa2MRdTLPh1UI+vO
         HYjMBXnIrnnRwdcI23ChYImfdvR6AUJO6s6NOQilNgHzUxUwSlbD9bdUAH47YW0ohphT
         eY7sKAo28GewG1h7evNR/nQoz+wAXkA0WoN612VmsPC41coTRdPZfLCXwmYpKAgzCSLV
         esOg==
X-Gm-Message-State: AOAM533pXBSPp78i3q09Qm77Ee35EZjjZYllTQWPqAUEC8h4dKlmwk5z
        6rLbCzl0Tkw/nfA4ZKmLMqnpsBrwm8/akA==
X-Google-Smtp-Source: ABdhPJzyewO7JbjjN7wzYObcaXgX4X0QhVjoOFnNdE+aQF1iwn41TCuoeUqczKTVXk5flzlf+8oK7g==
X-Received: by 2002:a05:6638:ca1:: with SMTP id x1mr1381892jad.15.1641870016406;
        Mon, 10 Jan 2022 19:00:16 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id x15sm5195175ilv.22.2022.01.10.19.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Jan 2022 19:00:16 -0800 (PST)
Date:   Mon, 10 Jan 2022 22:00:15 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     rsbecker@nexbridge.com
Cc:     'Taylor Blau' <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: [BUG] Re: Git 2.35.0-rc0
Message-ID: <Ydzyv8ZCEpDDRBXT@nand.local>
References: <00fd01d80691$c87e3ad0$597ab070$@nexbridge.com>
 <Ydzw+RqR6IfbT/oM@nand.local>
 <010b01d80697$0c848770$258d9650$@nexbridge.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <010b01d80697$0c848770$258d9650$@nexbridge.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Jan 10, 2022 at 09:57:57PM -0500, rsbecker@nexbridge.com wrote:
> > If your system doesn't have a modern-ish zlib, you may try building with that
> > knob, or upgrading your system's copy of zlib. And if NonStop doesn't have a
> > modern zlib available at all, we should modify the NonStop section of
> > config.mak.uname.
>
> There is no provision in reftable/block.c to avoid using uncompress2,
> so the knob will not help. Our zlibc is not that recent (as in it does
> not have uncompress2) and we cannot make the 2.35.0 timeframe to
> upgrade it. The current zlib seems to require gcc and is very
> difficult to port at this stage. This is a blocker situation.

NO_UNCOMPRESS2 does not avoid calling uncompress2, but instead compiles
a copy-and-pasted implementation in compat/ so that the function is
available.

Looking through it, I can't imagine that it wouldn't compile just fine
even on NonStop.

Have you tried building with NO_UNCOMPRESS2?

Thanks,
Taylor
