Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4C46EC433EF
	for <git@archiver.kernel.org>; Tue,  7 Dec 2021 16:18:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbhLGQVk (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 7 Dec 2021 11:21:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234804AbhLGQVf (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 7 Dec 2021 11:21:35 -0500
Received: from mail-oi1-x22a.google.com (mail-oi1-x22a.google.com [IPv6:2607:f8b0:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0D9CC061756
        for <git@vger.kernel.org>; Tue,  7 Dec 2021 08:18:04 -0800 (PST)
Received: by mail-oi1-x22a.google.com with SMTP id m6so28612941oim.2
        for <git@vger.kernel.org>; Tue, 07 Dec 2021 08:18:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=JwlTUVJlQp3B9Kbg26nvH1PtAjW/9uyXYILNQ1ogw6M=;
        b=aXAcIOD2KP/7azEGJK7Di+9HnZTfxHZP+0oGmFTw8fGbnG+wBt2BgW64erSM25pm2N
         IUh/eMFi6jnRHW4sJrSF5blERnFgxvPDyd4wEhglNkUfzKEykzd2wGkHzxmspboMwcNV
         DSHmOX7TfKGIc1qRrC2NLwzusmb7Lqe2LKMsex/Snktn3+fykn13pOvBmXIJ4ZU5GJjc
         y1r5Yy1T31PV3HHmNslqffBxqUyJzsjGrtEc1coZWxKlN9TVCJWC25Ec9naSJL0CR/g2
         3DJ9P4chVDp7kcYLxRLpdF3TUSXnhbZibQ6/A44G0WX0iDuoj457bppozOlNY3l1UhlH
         7lhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=JwlTUVJlQp3B9Kbg26nvH1PtAjW/9uyXYILNQ1ogw6M=;
        b=4ttWwVxyQbc0droeIMPVuuqJ7bD/vW+ObHewPaPsKULNabz1urekdjcPz+s/1E0Om6
         N2nM7a4HvPyQiBXDez5puLuPYxNXkNmm3ikZAqlLtzaaDPp+rELQMBrEYWT3nMDnh21w
         mqJHj/XAuGEGGgrKhQid32E70u0evWOeHCXG+WgXyJb6D3PLpd8N4tE+8tdUrNayftoj
         qDy3XRCKaXWY1F+RGQDH6qjcen2hU0OOML1PGR/RSHA0I9fE15nYYRI+n4CoWad5Zv77
         c/LNSDK7sjolpUlHTb79gz3BZvtgzc0cAFeQcTWHl7a2HwA6gmvpx4gp9E3v8w1ZseqS
         MuGA==
X-Gm-Message-State: AOAM531bOXH+PmN2KqpJYGgZ9q0L/Q8jcR7wKEaqcPQI7DzM2XCEf369
        klSB+MH8syHW1DXiH5bD1Sg=
X-Google-Smtp-Source: ABdhPJyzcLbi8UvjylLJXLreG2k3kQTFiJTR0HhIeoHfwj5V0N1ZJ0MhrEqUNzqN7t8ykjvoPOgSRA==
X-Received: by 2002:a05:6808:120b:: with SMTP id a11mr6159819oil.128.1638893884279;
        Tue, 07 Dec 2021 08:18:04 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:1d54:16a5:5c65:4b5? ([2600:1700:e72:80a0:1d54:16a5:5c65:4b5])
        by smtp.gmail.com with ESMTPSA id c8sm6738otk.40.2021.12.07.08.18.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Dec 2021 08:18:03 -0800 (PST)
Message-ID: <8594ac5f-8c09-6959-2bc7-208f6d888b4b@gmail.com>
Date:   Tue, 7 Dec 2021 11:18:02 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH v4 0/5] unpack large objects in stream
Content-Language: en-US
To:     Han Xin <chiyutianyi@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>,
        Jiang Xin <zhiyou.jx@alibaba-inc.com>,
        Philip Oakley <philipoakley@iee.email>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Han Xin <hanxin.hx@alibaba-inc.com>
References: <20211122033220.32883-1-chiyutianyi@gmail.com>
 <20211203093530.93589-1-chiyutianyi@gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <20211203093530.93589-1-chiyutianyi@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/3/2021 4:35 AM, Han Xin wrote:
> From: Han Xin <hanxin.hx@alibaba-inc.com>
> 
> Changes since v3:
> * Add "size" to "struct input_stream" which used by following commits.
> 
> * Increase the buffer size of "struct input_zstream_data" from 4096 to
>   8192, which is consistent with the "fixed_buf" in the "index-pack.c".
> 
> * Refactor "read stream in a loop in write_loose_object()" which
>   introduced a performance problem reported by Derrick Stolee[1].

Thank you for finding the issue. It seems simple enough to add that size
information and regain the performance back to nearly no overhead. Your
hyperfine statistics are within noise, which is great. Thanks!

-Stolee
