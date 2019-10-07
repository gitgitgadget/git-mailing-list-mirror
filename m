Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 146B01F4BE
	for <e@80x24.org>; Mon,  7 Oct 2019 18:10:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729339AbfJGSKJ (ORCPT <rfc822;e@80x24.org>);
        Mon, 7 Oct 2019 14:10:09 -0400
Received: from mail-pg1-f194.google.com ([209.85.215.194]:41470 "EHLO
        mail-pg1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728031AbfJGSKI (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Oct 2019 14:10:08 -0400
Received: by mail-pg1-f194.google.com with SMTP id t3so2850901pga.8
        for <git@vger.kernel.org>; Mon, 07 Oct 2019 11:10:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=rY1ysKe53zvaTslI+FwyZkMGlND8KIS5y1lXuUVYq7g=;
        b=HMdcZI/f6EIcOFHCF5j8PDvt+GcaSvmy5j6EkPP+BNsLTuyz+S/3plwRrm1e2MViBB
         ObK5a5wfeA1xrbGAzBMi2hW7ppJpvBJ0KuIC4irpSBK+kmHUzXuZcdRASrzRe7GB/Qck
         wRIAVRcNxmGWdfgwMzEqkA8xHWtxFxhF355eGGPk+p4T1KPu3yA4ZXLmDMW1h1li+m2A
         hNwfzFs5zg1SrimXRIu+/jFpE7KKonCwwazXY+c4f1Z2yRSxCuZvj40z1ZpNwaSnniHa
         J4nA13ndEnIBRu95RQ6izfpMxBz3fvj8RytHP2NlCieZJpXtlGsC5ffjFMgpNrFylfDq
         0Ftg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rY1ysKe53zvaTslI+FwyZkMGlND8KIS5y1lXuUVYq7g=;
        b=OAH+IiSPtPxb0Chb0V6TgEJFyNFmCVtlwbHiqvUhkj4kUoZJNqdabJu6VvwpvgUI7x
         CMP1uI4qpUwBaUpPEcVJSxtR3cQzihC0TvVWVE+qQ8nKVKfeyZRGLnKEnlN5YQ7BLJd4
         VIy02pFa5741JQ6FHF9Vl/16mn9pKz9JPOarPSqRR9kERhYycYJEW1lQ2UPrcajb8ily
         cHci80j7k1DHc3lAZeTAY2srScl1jX1etPuh4GbzzQfLLiH5NuytVmgCP+wiJfCnymal
         ls/uV7XWiWru1gHKWGvq+DHWS3dbpAjN/g1/3QxBKivbigzkh1MrNDchVrDMZyj+XhmM
         mVqw==
X-Gm-Message-State: APjAAAVFiz/ZcR1DYiWUxENtPPYxNt2rd+Az8nTE51d8gOS486YF8amz
        YaaRKloPeytrzQgekA2xKuY=
X-Google-Smtp-Source: APXvYqxgZkAHbCubOVoUz6mY68w4x9ilXJFbor8k3G0pREA3fmurzBX32tPrwm7sc0D36vJWiY+0Jw==
X-Received: by 2002:a17:90a:340d:: with SMTP id o13mr627160pjb.19.1570471807804;
        Mon, 07 Oct 2019 11:10:07 -0700 (PDT)
Received: from GVFSs-MBP.guest.corp.microsoft.com ([2001:4898:80e8:b:5d37:a2d6:1242:f34f])
        by smtp.gmail.com with ESMTPSA id e192sm17589861pfh.83.2019.10.07.11.10.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Oct 2019 11:10:07 -0700 (PDT)
Subject: Re: [PATCH 1/1] fsmonitor: don't fill bitmap with entries to be
 removed
To:     Junio C Hamano <gitster@pobox.com>,
        William Baker via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, stolee@gmail.com, Johannes.Schindelin@gmx.de,
        jeffhost@microsoft.com, William Baker <William.Baker@microsoft.com>
References: <pull.372.git.gitgitgadget@gmail.com>
 <ce9bf4237e69fcaf2b3e8b50bb88ff61c3b0f710.1570132194.git.gitgitgadget@gmail.com>
 <xmqq7e5l9zb1.fsf@gitster-ct.c.googlers.com>
From:   William Baker <williamtbakeremail@gmail.com>
Message-ID: <0de8e44f-53b8-e530-6e75-f696ffa889ce@gmail.com>
Date:   Mon, 7 Oct 2019 11:10:05 -0700
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.13; rv:68.0)
 Gecko/20100101 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <xmqq7e5l9zb1.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/3/19 4:36 PM, Junio C Hamano wrote:

>> +	if (pos >= istate->cache_nr)
>> +		BUG("fsmonitor_dirty has more entries than the index (%"PRIuMAX" >= %"PRIuMAX")",
>> +		    (uintmax_t)pos, (uintmax_t)istate->cache_nr);
> 
> This is how we show size_t values without using "%z" that we avoid,
> but are "pos" and 'cache_nr" size_t or ssize_t?  I thought they are
> plain boring unsigned, so shouldn't we use the plain boring "%u"
> without casting?
> 
> The same comment applies to other uses of uintmax_t cast in this
> patch.
> 

Thanks for catching this.  I will update these BUGs in the next
patch to avoid casting.

>> +# Use test files that start with 'z' so that the entries being added
>> +# and removed appear at the end of the index.
> 
> In other words, future developers are warned against adding entries
> to and leaving them in the index that sort later than z100 in new
> tests they add before this point.  Is the above wording clear enough
> to tell them that, I wonder?
> 

You're understanding is correct, and I agree this comment could be
clearer.  I will fix this up in v2.

Thanks for the feedback!
William
