Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F19FFC48BE5
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 15:16:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC2BD60BD3
	for <git@archiver.kernel.org>; Tue, 22 Jun 2021 15:16:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbhFVPSt (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 22 Jun 2021 11:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230047AbhFVPSs (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 22 Jun 2021 11:18:48 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DEECC061574
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 08:16:32 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id v5so2120558ilo.5
        for <git@vger.kernel.org>; Tue, 22 Jun 2021 08:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=pTgPFyZ9QjzazD2dZfEkgmR5tsDRM+Jn4cap96sH0hQ=;
        b=tuBAiUxkGZnbpVC5tKppXS449PLkiJWUpo/QWbNcoPwiAnuIEXnXG5uD3cWSCt96y1
         4aLkwXKMxdzheFmdQOMeBSB53r6OGawaiuqZci0iw0qHBFs5vMsuhorMMlSRFyp0uu8U
         5Z00DDlkzAURb8zEFgHHyme4hUzt2H9/erM8cs2VRCrZ54lkmi1paiN3Wt+gzQ65rXYe
         KRggEwcAWINIR5Ek1deZ3UquRflvMOkWrOrQVHuVF7GQ/BPyrA02HkH5ZmW9eelfawA2
         YHMvHgpTW4cktDl2UmHIRij/49ehXDV6ZaOgu44hFWbhzBFPPx7emFhMNNmLCjBjbvTh
         OjxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=pTgPFyZ9QjzazD2dZfEkgmR5tsDRM+Jn4cap96sH0hQ=;
        b=e5qwo0pVITLIEbkcXZKx5XK/LRg74zh/uvy8ghi8XE1x4ALH6HdrLJOsV5gjCj5Mg6
         MsjO4Us4G/zbWsubpAkKNi5ad+M3cuTEa2euqmuqrzoc1Owq0QiIsmh7LcNaAYHMcD5U
         pJGnUEpy72rnBdBqVEB2R3BJGesvvHXcDwCqkALu6ANJBraRYHOUuFIbDbdgy8LKju+y
         H/cu348/DQ+45QOzfHs2RLHrl5Mr48Tiy7TKDb7SDS1z8O1K0Pfo5mE5O+qqb5iJbLaB
         smMV4zbnBJvjfKvt7Q/kfCnTUDQrvAz1z834Oki6Fg+FxxTYlRwqCUu8iPzQvdJ5GRKp
         wmTw==
X-Gm-Message-State: AOAM530aurT93qSeE5LUsLgNXLyqmxWVpgqq+qecY0DDH06J1EDGpyVN
        TZcjAQe/RX00sVn4QGjFAm5gjw==
X-Google-Smtp-Source: ABdhPJwQARlImy0/7OUgbpFnUBFmn00AkyxXfBRlwLWLGzoFakxRzzPzcgZHu54qSsLkUsbWRWgV6w==
X-Received: by 2002:a92:c563:: with SMTP id b3mr3014723ilj.275.1624374991954;
        Tue, 22 Jun 2021 08:16:31 -0700 (PDT)
Received: from localhost ([2600:1700:d843:8f:f6bb:34fc:22a7:6a3])
        by smtp.gmail.com with ESMTPSA id t15sm7792618ile.28.2021.06.22.08.16.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Jun 2021 08:16:31 -0700 (PDT)
Date:   Tue, 22 Jun 2021 11:16:30 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        Denton Liu <liu.denton@gmail.com>,
        Felipe Contreras <felipe.contreras@gmail.com>,
        Kristof Provost <Kristof@provost-engineering.be>
Subject: Re: [PATCH 0/3] Makefile: "make tags" fixes & cleanup
Message-ID: <YNH+zsXDnRsT3uvZ@nand.local>
References: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cover-0.3-00000000000-20210622T141844Z-avarab@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Jun 22, 2021 at 04:21:24PM +0200, Ævar Arnfjörð Bjarmason wrote:
> A small series to fix the various "tags" targets, i.e. "make tags TAGS
> cscope". We'll now properly detect their dependencies, so we don't
> needlessly run them every time. I have this as part of my standard
> "make git" command, so doing nothing when we have nothing to do is
> preferrable, especially when my editor will eagerly reload the TAGS
> file every time it changes.

:-). Very nice.

> As noted in 3/3 this is better on top of my just-submitted
> .DELETE_ON_ERROR change[1], but will also work independently of that
> patch/series.

I took a look at this and [1], and I agree that 3/3 is probably better
applied after [1], since it doesn't leave any gap between the existing
behavior of ">$@+ && mv $@+ $@" and ">$@" with .DELETE_ON_ERROR.

But I don't feel strongly about the order in which the two are applied.
Your 3/3 without [1] isn't wrong, it just leaves us the opportunity to
permanently leave around a broken tags file permanently, whereas having
[1] applied ahead of time means that the broken tags file is only
visible racily.

I reviewed these patches carefully, and they look good to me. I'm
delighted that `make tags` is no longer PHONY.

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
