Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64395C32772
	for <git@archiver.kernel.org>; Tue, 23 Aug 2022 18:11:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233188AbiHWSLo (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 23 Aug 2022 14:11:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiHWSLS (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 23 Aug 2022 14:11:18 -0400
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5E0B6A48F
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 09:22:53 -0700 (PDT)
Received: by mail-oi1-x22e.google.com with SMTP id s199so16614957oie.3
        for <git@vger.kernel.org>; Tue, 23 Aug 2022 09:22:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=Mcgxgj5hXnE6uTpWjt7JtPojgbm90i/5V1aYI6o1PpY=;
        b=WQg7R+rl6EKMb/VO0qsSuNspbn+1JwDXLFSCMG3JxYP0igJ/QVvrVHVFOjhxxnvSLo
         N6Rg/24YS3joLrmopEI3ChUTtfgm2pLAwupgqrVlHjov2f/5u7bp+hxxBlWMhdg9K6MV
         HfhsH7Ah+4jbqQiAXwR+XAsrU6M2aX4dUnaUFYhlQNOFEIpp9gj8RUDsHCsdMY49MSNE
         GDXABbH9gkn5bP6oVqrd2aFVyMxWPEab4ZqrpsKRCBuyY/mPyVCxNoX0ki2qV79vi1ql
         ynIzG07lpC3teyOKz8KYuVoCLXzLasYoNZrJMtg1NWXNtzHwUuFyhf7Qd0dPUMVxvyzF
         RX8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=Mcgxgj5hXnE6uTpWjt7JtPojgbm90i/5V1aYI6o1PpY=;
        b=pLZ06zyOatDbRM4YWEHs1w7gmdaIGkdQA9/42uVLN3ptYt4/vf1JWstFIa3Xu7iVg+
         uk5hjhgwsT5zouoPpPc68OIiLeiH0z6gJDpm6E0IEwwMCtLpcVTZW0BmkrPiMjnZUVyB
         nY/NG3LGlfqIdVBs01TDbIIDt8XIUMWqjDMaB3FVBhsFWy8rqbCTotlFE2Hwq8OHLKJp
         7tZ0qjZe6E9m+0aDoS/Ha0XgHsQGV/+PPTyMzWVmD/9MUsp0db86ljcJEg6Zpm8W+QrN
         wyrsxoOQS6v59EqUNU/NLn81TyysXnUp6DXBSUZMYnmhvf1aT4tvpxAkW8lBuynqfRi1
         gaUQ==
X-Gm-Message-State: ACgBeo1Yorm4675xr4UoSDaC9YudYT44l8SVLdEGiI8dZiKhoDu/ntRb
        /AXsiNXi3Abri6S7IxCdZxp4
X-Google-Smtp-Source: AA6agR6/R6j6WV26ifMobA9Du/T477rZdHMA3nxCv7NkN7doeWSjZx76Atcr6bUgf5x+yZLgn4/glA==
X-Received: by 2002:a54:4892:0:b0:344:e0df:df5 with SMTP id r18-20020a544892000000b00344e0df0df5mr1603179oic.234.1661271773176;
        Tue, 23 Aug 2022 09:22:53 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:f1b9:9fd8:f860:8737? ([2600:1700:e72:80a0:f1b9:9fd8:f860:8737])
        by smtp.gmail.com with ESMTPSA id cz31-20020a056870649f00b0011d5228d8e6sm1477669oab.25.2022.08.23.09.22.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 Aug 2022 09:22:52 -0700 (PDT)
Message-ID: <98b4d348-e162-29f0-85e2-e36a9a500792@github.com>
Date:   Tue, 23 Aug 2022 12:22:51 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.12.0
Subject: Re: [PATCH v2 7/7] midx.c: avoid adding preferred objects twice
Content-Language: en-US
To:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Cc:     gitster@pobox.com, Johannes.Schindelin@gmx.de,
        chakrabortyabhradeep79@gmail.com, jonathantanmy@google.com,
        kaartic.sivaraam@gmail.com
References: <cover.1660944574.git.me@ttaylorr.com>
 <cover.1661197803.git.me@ttaylorr.com>
 <887ab9485faa21f5a5cd889d97895ed41013803d.1661197803.git.me@ttaylorr.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <887ab9485faa21f5a5cd889d97895ed41013803d.1661197803.git.me@ttaylorr.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/22/2022 3:50 PM, Taylor Blau wrote:
> The last commit changes the behavior of midx.c's `get_sorted_objects()`
> function to handle the case of writing a MIDX bitmap while reusing an
> existing MIDX and changing the identity of the preferred pack
> separately.
> 
> As part of this change, all objects from the (new) preferred pack are
> added to the fanout table in a separate pass. Since these copies of the
> objects all have their preferred bits set, any duplicates will be
> resolved in their favor.
> 
> Importantly, this includes any copies of those same objects that come
> from the existing MIDX. We know at the time of adding them that they'll
> be redundant if their source pack is the (new) preferred one, so we can
> avoid adding them to the list in this case.

Good call to reduce memory requirements.

> @@ -605,6 +606,15 @@ static void midx_fanout_add_midx_fanout(struct midx_fanout *fanout,
>  	end = ntohl(m->chunk_oid_fanout[cur_fanout]);
>  
>  	for (cur_object = start; cur_object < end; cur_object++) {
> +		if ((preferred_pack > -1) &&
> +		    (preferred_pack == nth_midxed_pack_int_id(m, cur_object))) {

nit: you don't need the extra parentheses here.

Thanks,
-Stolee
