Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC1BEC433FE
	for <git@archiver.kernel.org>; Thu,  3 Nov 2022 00:21:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbiKCAVQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Nov 2022 20:21:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231174AbiKCAVN (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Nov 2022 20:21:13 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83AC6AE5B
        for <git@vger.kernel.org>; Wed,  2 Nov 2022 17:21:09 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id 63so156133iov.8
        for <git@vger.kernel.org>; Wed, 02 Nov 2022 17:21:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=786P54xbiLPivRnh9qISHYrek0aT7gP6OBfnjYhWBZ4=;
        b=d6JMkv2nSN+YCZMu27qitTK12R2s5O5OT89rEQHNM7+jXki4KhCqtgZbvIgH6GBUXT
         DxnLj19PRFeyhFnwi19xSedg4LbYSVpnOMxV6qwmHEcha/RZgSEaFewDcEBFksDVwHHZ
         QbzJxfuKSM3/3iU9qblSuzLy8NpBXb09TUSuTeBs83H1+wk6LldN1nwKDACMebWNz39H
         yVSIDtRpHstxm++0W1FeoKn6nCytcWMUk8yyqUyC/acBd6pAQAYlk4AIOTa+5fQVA8DJ
         carkMnWF2t3Mg4NNaZlMxbyODYPS8KOc2dVJSbZfWVxHsuJdDtrXlyDnnKnmJ3MYPW9l
         sesg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=786P54xbiLPivRnh9qISHYrek0aT7gP6OBfnjYhWBZ4=;
        b=HooEJZKeVfbKmFgVcmv/hkBbgfThYhyV0FJTZkio/gX4h3G/+1JWtzHDAI7Q+PxZdy
         BXexXNYBIelKCfn13kpzlkhf2jXqr6j3yiKsyfcq44NEmkYXiZyXtG/G+JtLUX8iGsJi
         3oHiK7jsGpXv5FULSPhM6Qu75wbCO2BXRrUi5lGi+VgR9BKM3F1yF4KgcB62o2zMXht/
         t2Vz4lmaLgnA0FNWHOwRREp908Mtda4QGe9qJe0LwBScDGarKo5LOlFVnBdrCVyF4GJS
         1lFs6X+OA2JPVHaWSSn8AUEGdBCfKXiuFpzy1/ofHlDPodLvnqwKYWyNs/kr8Dw7rlpE
         Uo8A==
X-Gm-Message-State: ACrzQf2d+m5Se1B7VGc3RPCjGHjRme8qk9RsT9LA/VNyrtUEtPbu1AZo
        MoOy5wkzBe3ymIRGFHFDEwAGjw==
X-Google-Smtp-Source: AMsMyM4Vuj3jwN/hLcUAmXZKyCUC9uxh5EjZNBP7AGQwhdetPEUb+CzLuUkEfc4xM3EexF3VzPU8pQ==
X-Received: by 2002:a05:6638:2508:b0:374:fad7:e2bc with SMTP id v8-20020a056638250800b00374fad7e2bcmr17208008jat.54.1667434868903;
        Wed, 02 Nov 2022 17:21:08 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id j22-20020a05663822d600b00363e61908bfsm5406155jat.10.2022.11.02.17.21.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 17:21:08 -0700 (PDT)
Date:   Wed, 2 Nov 2022 20:21:07 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        man dog <dogman888888@gmail.com>
Subject: Re: [PATCH 2/3] line-log: free the diff queues' arrays when
 processing merge commits
Message-ID: <Y2MJc6wIQIlK44a1@nand.local>
References: <Y2BElOFGJ8JinYxC@nand.local>
 <20221102220142.574890-1-szeder.dev@gmail.com>
 <20221102220142.574890-3-szeder.dev@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221102220142.574890-3-szeder.dev@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 02, 2022 at 11:01:41PM +0100, SZEDER Gábor wrote:
> ---
>  line-log.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)

Looking good.

Thanks,
Taylor
