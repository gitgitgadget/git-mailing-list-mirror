Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C84ACC433B4
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:25:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9776D6144B
	for <git@archiver.kernel.org>; Wed, 21 Apr 2021 14:25:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235973AbhDUO0A (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 21 Apr 2021 10:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235791AbhDUOZ6 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 21 Apr 2021 10:25:58 -0400
Received: from mail-il1-x132.google.com (mail-il1-x132.google.com [IPv6:2607:f8b0:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3B61C06174A
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:25:23 -0700 (PDT)
Received: by mail-il1-x132.google.com with SMTP id r5so26888184ilb.2
        for <git@vger.kernel.org>; Wed, 21 Apr 2021 07:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=oA+L4hCj/sn+H0hIX/l0VAtPY8hklRy08wxc/kGfGnw=;
        b=LRk40dgZxDdocu6ty1mLyDrhbGRLBv+RsSNqvIJwnrR9GDZJXtypZb4wQnPVVxswxV
         8cshTqKvArw4l/Q+WD73nCjsIcTPvlI91T5wxYXmA+gteoeJC85q/U8cuP0F+wuvq1rO
         x2/UeEIAnYGSbEz306xbZuPUZxa2BMNuVonArfXChh2vS+SXLk7+VkzwS/tWoB25HrTn
         SO3i11ePIY6tXNjhKXDKNFVwLj5PjtHWgo7R/r5s7ApNxx7P1lEok+I57qf8He0Y3u4D
         yERB3Xmc8vU3wVfplLIaj7GzUBqxg4P4eHbsoLbxrcgsZNHwLwpRkdpS/dFfzdXKPDQ0
         LqZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=oA+L4hCj/sn+H0hIX/l0VAtPY8hklRy08wxc/kGfGnw=;
        b=lZ259jqKhKUlUUt+c2dAfYfqs3eoi8YiQObvLwjWG9b6YiWgrjn8KRIHdICCWZDTXD
         sirFMTrjU6diLZHasOfChe8L+n5dfYoHN7G5uK65PxfxOrweFpvx3oTaYoIFmjJXnyPW
         l30zafgtUrLgmXKpJ1SqCkU7CiRjiAtbSvEwCrkqp8j3LSZjhNkboBM4ISpZQjHVLx+T
         kIkGfOUsHue3WlKYOL+8sVGPcAIcnc7LwtBXlY+YvrlATg/nQmIBAPabZoR16ACcaHUv
         2eEQ1LihIKcRbhzL1irQnnbYlY3n0bvSVo/xLYyBx3VPugagAE/aO6aafElcYdWAcOCi
         re4g==
X-Gm-Message-State: AOAM5335mdmoCMAQcLMNtVxYr/wfeyRdBKAmaVUTl23pLIPb/OIpId5Z
        ysV03ESxhtxoCLUmYTBvb93Vl0t9rjlkYhsm
X-Google-Smtp-Source: ABdhPJyF7mQRSq6xyo+m+8OIUzpymXslRvYmoffjQ2uOBzkVzZJnO2BBpQ2rHZAt3yTvySLyolJesw==
X-Received: by 2002:a05:6e02:12a7:: with SMTP id f7mr27944200ilr.181.1619015123017;
        Wed, 21 Apr 2021 07:25:23 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:aa83:842a:cad4:8d29])
        by smtp.gmail.com with ESMTPSA id q1sm1064943ilj.4.2021.04.21.07.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Apr 2021 07:25:22 -0700 (PDT)
Date:   Wed, 21 Apr 2021 10:25:20 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Hongyi Zhao <hongyi.zhao@gmail.com>
Cc:     Git List <git@vger.kernel.org>
Subject: Re: The meaning of the '+' before the submodule hash.
Message-ID: <YIA10O/BVrP3z/LK@nand.local>
References: <CAGP6PO+6MA9J1LRgGn4rcz8DBcW-hht92p-ahFaM9g6tcNFh-Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAGP6PO+6MA9J1LRgGn4rcz8DBcW-hht92p-ahFaM9g6tcNFh-Q@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Apr 21, 2021 at 10:19:25PM +0800, Hongyi Zhao wrote:
> What's the meaning of the '+' sign at the beginning? Why do some
> submodules have this symbol, but some submodules don't?

There are three symbols, 'U', '-', and '+'. From the documentation [1],
they mean:

    Each SHA-1 will possibly be prefixed with `-` if the submodule is not
    initialized, `+` if the currently checked out submodule commit does not
    match the SHA-1 found in the index of the containing repository and `U`
    if the submodule has merge conflicts.

[1]: https://git-scm.com/docs/git-submodule#Documentation/git-submodule.txt-status--cached--recursive--ltpathgt82308203

Thanks,
Taylor
