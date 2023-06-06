Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5533C7EE24
	for <git@archiver.kernel.org>; Tue,  6 Jun 2023 16:16:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233481AbjFFQQC (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 6 Jun 2023 12:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237260AbjFFQP5 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Jun 2023 12:15:57 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF1FA10EB
        for <git@vger.kernel.org>; Tue,  6 Jun 2023 09:15:32 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-543a6cc5f15so2534636a12.2
        for <git@vger.kernel.org>; Tue, 06 Jun 2023 09:15:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1686068129; x=1688660129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CM51PnGHbM6O4zXARjlI0P4T1Mtxz1lICh2vFvzXrk0=;
        b=MOVDmV2uqR6XZVKJYbVTzsO9RWGDlCPEFiOSATzyB/duI0aJDlYaOnfRhH44VBKAYA
         qV9pWhSSB+1JkPGmWzZzd9imP9CiNskqS8iz7IVQnkcM7Sa7ltBvQWOQoRvs00/ZlT6e
         oISq1O2AxtWLVbDfN5bvSZFrwFum+J5ugEyl3I4hY/20g7PPgiTJ0tDiToc336Cl40hv
         9jQFYTJkKZdF8MPPz+onK3MyeM3rlvbtJDA+gFgLhCyN1Yy2nXivKvFngoOkJ3u16c4g
         hoi2MyoJUxffi355qaKiMSJ/MkI6acTdQRUzN6X6Lz0/YlSP1p0FRpPjHiVEdgJHDpug
         yrgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686068129; x=1688660129;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CM51PnGHbM6O4zXARjlI0P4T1Mtxz1lICh2vFvzXrk0=;
        b=iU1ym/96g/ASV3zCNIPP/T9hqADO3ZW0QBg2cZPqvJZdrptdmn9fM/OTzlXjYh7Bdy
         BUBwHmgNXv7t3Lc3dSSbvZYh+ZIs5PU8OyauY+WRw941QwtgvaNPnUI4qLiYXqVi6QH/
         /omTUZt7KZq6mrPgp1QB9KWfkH6apGrFOA8ajO6s/FlOcs3oF85KT5eyGLWVP0C6VSLB
         pbZhela7yGVzTA6M9bI/BqbiAke2gYe0HaDo4brLu5R1pYl74OWX3kmZxOKwhHS4KDKt
         /kCAdoT5xhiXnx93DFT29Mifo1P0GGj5bdef0z8woGmFE8Vp2dYj0f6Lbijy0rFHah4D
         amow==
X-Gm-Message-State: AC+VfDz0YfcA/SL//2johPuaqnzyV2b2KtdvriLqgLmqIN4Eh4Yv9Vt5
        ffr2sbETdRdzRumknNI52khbo+himx6CSxPoRw==
X-Google-Smtp-Source: ACHHUZ7M5rhEaJaPZaJi01Q2MlyflMlhUZSsu2QwfmBqtmkPbkpxLrgY7ZZf/airT05Ka79LGbwrUQ==
X-Received: by 2002:a17:902:7d8b:b0:1ab:11c8:777a with SMTP id a11-20020a1709027d8b00b001ab11c8777amr2453515plm.13.1686068128845;
        Tue, 06 Jun 2023 09:15:28 -0700 (PDT)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id k4-20020a170902760400b001b02df0ddbbsm8731821pll.275.2023.06.06.09.15.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Jun 2023 09:15:28 -0700 (PDT)
Message-ID: <805d9010-bcf3-a58d-18ce-a32cc4b04fcf@github.com>
Date:   Tue, 6 Jun 2023 09:15:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.11.2
Subject: Re: [PATCH v3 0/3] Create stronger guard rails on replace refs
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     me@ttaylorr.com, newren@gmail.com, gitster@pobox.com,
        Jeff King <peff@peff.net>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1537.v2.git.1685716157.gitgitgadget@gmail.com>
 <pull.1537.v3.git.1686057877.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <pull.1537.v3.git.1686057877.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> Updates in v3
> =============
> 
> Thanks for the review on v2!
> 
>  * The removal of the global from environment.c is delayed to patch 3
>    because config.c still assigns the value in patch 2.
>  * The comment for the member in the repo_settings struct is modified for
>    better grammar.
> 

The changes in this version were small (and easy to review via range-diff);
everything looks good to me. Thanks for the updates!

