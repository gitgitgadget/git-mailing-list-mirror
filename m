Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D73E6C32771
	for <git@archiver.kernel.org>; Fri, 19 Aug 2022 19:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350378AbiHSTG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 19 Aug 2022 15:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350289AbiHSTG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 19 Aug 2022 15:06:26 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2C8412AD1
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 12:06:25 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id c4so3166112iof.3
        for <git@vger.kernel.org>; Fri, 19 Aug 2022 12:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=4eAjli8GGgDYf4FsFfalNjJo6Nfy29zBu6QnJBEeDMU=;
        b=Cu+o+GBTIDw/CYKJcUqSdlTnm7E5QSjt3liXoYYuza4Kft50ufb72EIpFSoU+DSxvG
         pJa/nLcc5m8nIc/Fb6B/LKnyhKZsplWn/DJBh1it4XCnaGaY2Nk4a20yci4l/FNxFFuk
         vRQsbj72Iibhq5Xit6fR8DT+oHK2aBEVH2wDivH3kRFrcgNq6RXpQEQsKq1jZmbk6O3L
         7+EFrMrY/PS7h8v4nXzl0tWU7WrCvzS8wKgdBrurZvk8NTnNZKK7VQGgyygB55jZekUc
         3p4mt2UuW0tu/A2X7K1Ztsc0sbcWNTNM4uL69JK7oWKjILgnalVO5FSfHzhwKqdRLkT5
         +8lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=4eAjli8GGgDYf4FsFfalNjJo6Nfy29zBu6QnJBEeDMU=;
        b=iqtuVRhJ0HVN1GXfRw6m2T7zFr1UIPndCfaVPdTmijBn1JdLYlHrrQWKsNkosBlX8N
         svIOs5Gau6ezoTGD1dK2Xo82WVNCKSTPmCI+1MgT13ZmG9uZjMjE/b+bVW0g2E9EDRe9
         XjqyFQZtMTeAlw5b9+EWmBmE7aFf6nNJoR9QpE/IOpIq+cplaZeKm28Ieq98zKLVQYp5
         knKmzCEnJblfcC7aVPKaAuCSsYQ49CrgJshSwgaQR/2UJ35Ev6b7AdxBCEUDNrS1ZeQu
         mImWy8gt3yX6bJIhiQmkmtGGu7E2ZFSiN2XedHLeClOHGkFfC2KfYTqaqZQpoMyBf4yb
         222g==
X-Gm-Message-State: ACgBeo1C4yVAULQNbHWyZS8XojULg7tcKbZcOwTGA80vaDWN17qZuFz8
        jHeujnpcwN0O2TuuybA7shK7
X-Google-Smtp-Source: AA6agR4UJQ/ynumuUCXfba8nzI8jvSQS0gtrbhE63df0VRCv7L0E+qrQJPlFrSwybZ7P1DQF03xHjA==
X-Received: by 2002:a05:6638:22c9:b0:341:56cf:c447 with SMTP id j9-20020a05663822c900b0034156cfc447mr3929236jat.244.1660935985290;
        Fri, 19 Aug 2022 12:06:25 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:55ca:650:1968:6180? ([2600:1700:e72:80a0:55ca:650:1968:6180])
        by smtp.gmail.com with ESMTPSA id b20-20020a029a14000000b0033ed273345bsm2047408jal.96.2022.08.19.12.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 Aug 2022 12:06:25 -0700 (PDT)
Message-ID: <5f10be7e-424a-ed3b-bb77-75f1e026b2ae@github.com>
Date:   Fri, 19 Aug 2022 15:06:23 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH 5/6] reftable: drop unused parameter from
 reader_seek_linear()
Content-Language: en-US
To:     Jeff King <peff@peff.net>, git@vger.kernel.org
Cc:     Han-Wen Nienhuys <hanwen@google.com>
References: <Yv9Oay+tNqhLDqVl@coredump.intra.peff.net>
 <Yv9P4O3WCrR9f9o2@coredump.intra.peff.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <Yv9P4O3WCrR9f9o2@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/19/2022 4:54 AM, Jeff King wrote:
> The reader code passes around a "struct reftable_reader" context
> variable. But the seek function doesn't need it; the table iterator we
> already get is sufficient.
> 
> Signed-off-by: Jeff King <peff@peff.net>
> ---
> One could argue that this is a method of a reftable_reader following the
> usual C object-oriented naming conventions, and thus should retain its
> first parameter, even if it isn't directly used.

> -static int reader_seek_linear(struct reftable_reader *r, struct table_iter *ti,
> +static int reader_seek_linear(struct table_iter *ti,
>  			      struct reftable_record *want)

If we wanted to make it seem more like it was a method of something,
it now looks to operate on the table_iter, so the method name could
change to something like "table_seek_linear()" which might satisfy
both goals.

Thanks,
-Stolee
