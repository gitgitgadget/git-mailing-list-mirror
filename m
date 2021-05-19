Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 69FDDC433ED
	for <git@archiver.kernel.org>; Wed, 19 May 2021 14:30:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 450696135A
	for <git@archiver.kernel.org>; Wed, 19 May 2021 14:30:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347541AbhESObx (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 19 May 2021 10:31:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41406 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242007AbhESObw (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 19 May 2021 10:31:52 -0400
Received: from mail-qk1-x72b.google.com (mail-qk1-x72b.google.com [IPv6:2607:f8b0:4864:20::72b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 62B28C06175F
        for <git@vger.kernel.org>; Wed, 19 May 2021 07:30:32 -0700 (PDT)
Received: by mail-qk1-x72b.google.com with SMTP id k127so12876128qkc.6
        for <git@vger.kernel.org>; Wed, 19 May 2021 07:30:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=5KKcJpekzEr3YiAshr3LdiJAZI68kHobFkJAonL4Zk8=;
        b=bT0wyB55RWwoB9ZfKLgZ2xCx11P2QF1LfVLQ4wac4orO/wLPUWVYj3OZGxYDg/XBIu
         Xr7nT5nlSBn6uLsldWZK6I5b44Eunmk8q8bxuVer+kTaBWr1p4RVwvGlSyfdNYmfnygj
         /mdsTTEHL/+NQQbVnokGJ/MbmmETPhmel3umILm0FrHtU9B59Qjku8/3vZFNg50q1tqz
         05z43qPAHVLOodXIwy3dpkkcC5Ql/ukd944QxA5nFPatbK+/UXmVXGG8seJKAThay7yF
         hxoqKNS87amlpB/nz3b2ljuXLgVCt4uTLaAqww4V3k9Z00vmAV+VhmGOwENik7WSoAGo
         SxZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=5KKcJpekzEr3YiAshr3LdiJAZI68kHobFkJAonL4Zk8=;
        b=tZH0o9Wm0KJMUPBPnAmL/YeEBu4zYyBSzvMPfDFNUuooMz4XNkKi6G1Gj/6ZCknIU8
         v4oreESfU8e0iDIl7kmAUVfHE+WWQqsvYftZn/PRhvI2cfCp3n8nU7JlUqVhnl7yryrA
         l4zrddkrGCrkWMwY1qSxI1sxfKpW1i1PdtocSJe9r7UvycXskFTp0HvMPitkU6l8ecDW
         0JRZvD0fZvRw88dzEjlMHp6csuVweI9bJYjF29kiPwJ8oU160izRRsgMEQRWR7EJVePm
         /OgqPJxsslXlIgbnlnDaAZ7MsiR1fki5x9zw60/1aqEn4+uQAyK0Z1DzN8D3ZtFtI224
         MZ+A==
X-Gm-Message-State: AOAM533s4xjZEeM8ZdhG3DbDSR+RFhJgSV1AnoACCj2eut6E4D5LIl3P
        U7xPioORx93p3VaUOtXBTQ0clg==
X-Google-Smtp-Source: ABdhPJyBX2RqKEVbxlavPe4wSFsVxRrnM4olKXo1uWdbjviroFkhakzdJeKZ4bU8w0rnPwAExvWl/A==
X-Received: by 2002:a05:620a:526:: with SMTP id h6mr12607923qkh.145.1621434631525;
        Wed, 19 May 2021 07:30:31 -0700 (PDT)
Received: from localhost ([2605:9480:22e:ff10:22d:3fed:300:d76f])
        by smtp.gmail.com with ESMTPSA id w9sm11274184qtt.59.2021.05.19.07.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 May 2021 07:30:31 -0700 (PDT)
Date:   Wed, 19 May 2021 10:30:29 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, Greg Pflaum <greg.pflaum@pnp-hcl.com>
Subject: Re: [PATCH] clone: clean up directory after transport_fetch_refs()
 failure
Message-ID: <YKUhBdO1KSiLwqOZ@nand.local>
References: <YKTzu96fN7XlpDoG@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YKTzu96fN7XlpDoG@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, May 19, 2021 at 07:17:15AM -0400, Jeff King wrote:
> One obvious option to fix this is to reorder the end of the function to
> set the flag first, before cleanup code, and put the label between them.
>
> But we can observe another small bug: the error return from
> transport_fetch_refs() is generally "-1", and we propagate that to the
> return value of cmd_clone(), which ultimately becomes the exit code of
> the process. And we try to avoid transmitting negative values via exit
> codes (only the low 8 bits are passed along as an unsigned value, though
> in practice for "-1" this at least retains the property that it's
> non-zero).
>
> Instead, let's just die(). That makes us consistent with rest of the
> code in the function. It does add a new "fatal:" line to the output, but
> I'd argue that's a good thing:

This reasoning makes sense to me, and thanks for cleaning this up.

    Reviewed-by: Taylor Blau <me@ttaylorr.com>

Thanks,
Taylor
