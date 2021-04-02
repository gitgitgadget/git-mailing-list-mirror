Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF60AC433B4
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:07:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 97187610CC
	for <git@archiver.kernel.org>; Fri,  2 Apr 2021 21:07:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231443AbhDBVHQ (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Apr 2021 17:07:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231406AbhDBVHP (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Apr 2021 17:07:15 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF68C0613E6
        for <git@vger.kernel.org>; Fri,  2 Apr 2021 14:07:13 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id i81so6015404oif.6
        for <git@vger.kernel.org>; Fri, 02 Apr 2021 14:07:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:from:to:cc:references:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=6N+P2BoJP9k4fVcSuuNpNh6JU7Xvxwbh6/9frYPv/RY=;
        b=C8GczqIdcyV6J+PkcxANjZ7S2rqzk9bam8wqFTJ5urwFbn3q0vqy7qdc7WpmToCwDD
         DUJO/OJSSsH3HDcTmrzCePmbz6BMCx5tzv1MVu/zHpG/ugoFBUgA4tjZgiezA7iOUFKL
         H387gPTCmSy+YV16Tgs9EPXr+UapShRuoU/NUfBiDmGiM25BqC9ZvimJj58GS5QIzoUM
         2i+f/PvlJ503x8+ChddQLY1Eo+KHxWNNgTqCkVYwZF/1zOvO5chiCbFlORRonqwQ+Ddg
         ZSFCM6p2H6WgvZoBruhdEk1yPJhj+xHB6SB5tMdhSd1GjEs2pPzYH2rEoF+Xd1nzkU+F
         zg7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:from:to:cc:references:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=6N+P2BoJP9k4fVcSuuNpNh6JU7Xvxwbh6/9frYPv/RY=;
        b=UytR7yB3JnIDEDIozmPqn0urOH7Et3ZK0/fmi3sju384vXcYK6i/sHD8qDbcWYZb49
         D4h/fcpPjtnXyvV7Gl319B9YwZFHdH+oLIZl79ZsSSJzHZBc/3zMkbnqjAI01gi+MkNs
         DsaGSqPAbObTGhPOGm1/hEVimhB1m3Q8wVsZSs8aocTiyI3AK2a7gx394Kl4XmDK5rvO
         FboWbwc1MpNDwbeuHnwDShJHrgOd1WshGvUPiUpystqdiTPxch97uKDFxhsV965mXQY9
         9VHHNR/xfFbk/TAeqCbMnIS+Y/iReFtxBiX3jSqqsCqsGrGOtobjOJtKghqC+G8FDWfu
         XM4A==
X-Gm-Message-State: AOAM531DK9pyC1gETqtrwuJD/8eqK7zoJq/Cp2zola5lYS+yaV4B61S3
        cta9MnGYDPDSClJXZ0uKpDHmu1BU3KEdyQ==
X-Google-Smtp-Source: ABdhPJzv1tQv+rD5XPBSr3DbE5r86bl6SHiXHtelnyc8ZyoQHJwH5RLnkSgI52ueQc1dzoWgKjNbZQ==
X-Received: by 2002:aca:4188:: with SMTP id o130mr10906920oia.101.1617397631171;
        Fri, 02 Apr 2021 14:07:11 -0700 (PDT)
Received: from ?IPv6:2600:1700:e72:80a0:d5a8:1a30:4466:1b29? ([2600:1700:e72:80a0:d5a8:1a30:4466:1b29])
        by smtp.gmail.com with ESMTPSA id u194sm1870528oia.27.2021.04.02.14.07.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Apr 2021 14:07:10 -0700 (PDT)
Subject: Re: should git maintenance prefetch be taught to honor remote.fetch
 refspec?
From:   Derrick Stolee <stolee@gmail.com>
To:     Tom Saeger <tom.saeger@oracle.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <20210401184914.qmr7jhjbhp2mt3h6@dhcp-10-154-148-175.vpn.oracle.com>
 <d246df21-fdaa-a391-847a-e03e8e664af1@gmail.com> <xmqq8s613gqa.fsf@gitster.g>
 <3bfd9a88-10f9-df71-bf96-f9c5654e48eb@gmail.com>
 <20210402182716.trbaflsjcvouff2y@brm-x62-17.us.oracle.com>
 <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com>
Message-ID: <a4cf3e48-aed5-ba1f-298d-1f2cc2359be2@gmail.com>
Date:   Fri, 2 Apr 2021 17:07:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.0
MIME-Version: 1.0
In-Reply-To: <41dc2961-7ba5-a882-3416-45631e2cbb33@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/2/2021 4:43 PM, Derrick Stolee wrote:
> On 4/2/2021 2:27 PM, Tom Saeger wrote:
>> generally isn't it still changing the right-hand side of refspec?
>>
>> replacing ":refs/" with ":refs/prefetch/"
> 
> Right, this substring replacement might be easiest to achieve. The
> 'struct refspec' doesn't make it incredibly easy. Perhaps skipping
> the refspec parsing and just doing that substring swap directly from
> the config value might be the best approach.
> 
>> This would still work for refspecs with negative patterns right?
> 
> One of the issues is that negative patterns have no ":refs/"
> substring.
> 
> The other issue is that exact matches (no "*") have an exact
> string in the destination, too, so replacing the _entire_
> destination with "refs/prefetch/<remote>/*" breaks the refspec.
> I think the substring approach will still work here.

I updated my branch with the substring approach, which is
probably the better solution. Please give it a try. I don't
expect that change to help the FreeBSD build, but we will see.
 
> [1] https://github.com/gitgitgadget/git/pull/924
> [2] https://github.com/gitgitgadget/git/pull/924/checks?check_run_id=2256079534

Thanks,
-Stolee
