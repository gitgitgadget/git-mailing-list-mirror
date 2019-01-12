Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C872C211B4
	for <e@80x24.org>; Sat, 12 Jan 2019 03:02:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726496AbfALDCt (ORCPT <rfc822;e@80x24.org>);
        Fri, 11 Jan 2019 22:02:49 -0500
Received: from mail-wm1-f68.google.com ([209.85.128.68]:51373 "EHLO
        mail-wm1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbfALDCt (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Jan 2019 22:02:49 -0500
Received: by mail-wm1-f68.google.com with SMTP id b11so4100677wmj.1
        for <git@vger.kernel.org>; Fri, 11 Jan 2019 19:02:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=hdf/HbqKFtqmGxVE249PoUWPWZfKnXcu67xcWX7hNrI=;
        b=a07nnEj9ihLAg/YPQgV5FqBPVR6rJToxGcXAxOzr9J6HcI7OBpFjH1REtp1UJPv5ua
         FDohCqACnfcJEYr7JysMMRuv34gwXPyn3B/ptWqWRu/AFbGNpuiZu6u+8HLdvtSampmv
         QAzDwk01xBRIT0X1eNgaWKPSQPJeDqI5aNH/uQm4wkj1lO8M2ZJWKZbc+7voz02tglTJ
         FcScOT2fKWtZvjeSbIyFVsthlenWBM4AthT4tnVEuu+Yp9ctiYMTkY/fccl4gBXKPvAJ
         xuuCOWzcydxqa2JnWPGS/9murGdszxxhpFo2LQYUS+IkbBLyscvHSdqWMcg6pjZijpTm
         8CAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=hdf/HbqKFtqmGxVE249PoUWPWZfKnXcu67xcWX7hNrI=;
        b=P7N2eWNhZIlQaAO/xsEgQzGjxEsAI8JcgGG5qN1R9zDKXt3QZr4sBnIwYDb5ravH4P
         HHuRcpmQ2CxrNuFxWHB2l3rtFFBJa4pUKmOhGQfZ4Hz/ney+IN5Dom9FHnoPOvKfU94S
         I9RnwWs/FU+cAg1+oziC0l/UOst9Jx0gzkGnKVevQHrpbZ/mH17Cm4boWWa4XFc8yfG0
         GzoL8h9ZiXit0MLg/Groc7O75wK0YntotbXnjKH0i8jTg9gbrSB/HLevRNeEjLROVoMg
         OowRDZbCwNuU3cQ9nKaOVJRP3PEpPV5bW6Jc7WQrvueJ0JoVyiLRz9AdPxcDWfNvlHR4
         CohA==
X-Gm-Message-State: AJcUukdqPA5vI1+9SSTkTlSTZ9BC/4D+WNy5uLH/KlwWvBr6KD25YNBJ
        j1MTSA+wB2ogSIW7f53gL4E=
X-Google-Smtp-Source: ALg8bN7FPQc5m2M5hidB31j6ZQEEDxdlAz4qr0Fx4cJs+tGEKvU0AAsol7wltLJ3g9FN88aqTCzYwg==
X-Received: by 2002:a1c:dc86:: with SMTP id t128mr4549141wmg.42.1547262167493;
        Fri, 11 Jan 2019 19:02:47 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id 129sm30668649wmd.18.2019.01.11.19.02.46
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 11 Jan 2019 19:02:46 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH 1/6] get_super_prefix(): copy getenv() result
References: <20190111221414.GA31335@sigill.intra.peff.net>
        <20190111221500.GA10188@sigill.intra.peff.net>
Date:   Fri, 11 Jan 2019 19:02:46 -0800
In-Reply-To: <20190111221500.GA10188@sigill.intra.peff.net> (Jeff King's
        message of "Fri, 11 Jan 2019 17:15:00 -0500")
Message-ID: <xmqqwonawpbd.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Jeff King <peff@peff.net> writes:

> The return value of getenv() is not guaranteed to remain valid across
> multiple calls (nor across calls to setenv()). Since this function
> caches the result for the length of the program, we must make a copy to
> ensure that it is still valid when we need it.
>
> Reported-by: Yngve N. Pettersen <yngve@vivaldi.com>
> Signed-off-by: Jeff King <peff@peff.net>
> ---

Makes sense.  Thanks.
