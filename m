Return-Path: <SRS0=kv1d=5J=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D642BC43331
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 01:15:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A8C0C2070A
	for <git@archiver.kernel.org>; Tue, 24 Mar 2020 01:15:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e4BMdhdH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727067AbgCXBP5 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Mar 2020 21:15:57 -0400
Received: from mail-qt1-f176.google.com ([209.85.160.176]:43614 "EHLO
        mail-qt1-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgCXBP4 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Mar 2020 21:15:56 -0400
Received: by mail-qt1-f176.google.com with SMTP id a5so6493353qtw.10
        for <git@vger.kernel.org>; Mon, 23 Mar 2020 18:15:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=r8AE7UfBZjypjuNnyWcivSk28dPrK5Cs+/CV2zP2FhM=;
        b=e4BMdhdHWSbKh+Q4gsmSAwNjERzm/IvQiXLQSx8EI0mOqwuln4LtdMugoPEPz04S+g
         EZKlLgfwWotM4FcGmNG+ev9GPsCTzhMzHMZ3SnBlxGAXFhf8qsnfsomGhGGhc5PTQU9M
         FyVVc4JhAt1EZlkEitcRTfO/hTR57RdrmZTiBwyXo5svMdSXaO3xWgM0m9yfqOexKLwz
         iIQcjdOPBPtXTjZo0hQKs2NJJXlhstenXsX8nKAmDiSkJCQPT55wtW44gUwlEb0qMAs/
         QoIOQapVMwqJdJsKd/EGN5xmA95Nwv8qx8oWXfinDSrJkM+8lDF823u92cmhxHi+Dk0Q
         ZTXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=r8AE7UfBZjypjuNnyWcivSk28dPrK5Cs+/CV2zP2FhM=;
        b=G4MQHsC5aQhiGfFotL2QcAVKHH+JBKfAMRZDlshDMP7TRO/k8/ZtQjWhHX3P57QCk2
         tqB1UCYB5C0of6+Si+0Rl/ugtxQy/flq8skUKAmfHvjsSPsJDraEGgDH5OUgyIgppShg
         oo25Y/u3Ui8TwfAYWymmcc/29B30src4JfhW5z1beC6MVZT+ORt/8PHn6XRhyC5uJcPK
         TNNo1oco2jT1zIi6h2Bn03xqz6WLvLm+jJxV5ilVvjFlVpQxMvp7JR7O4x2hEYcDmeys
         VmiHEC7+pHYlmDokP/IJ8PoauQmU7K653DGzPu+efdO0EgJy7/Qjvic45z6Bxy2ReAG/
         5BDA==
X-Gm-Message-State: ANhLgQ06ma/WrbWmK/e375J2EmjP2ib/mHRNMvCuxppAzz+8NMxPUauf
        BfTK3VyyFHJxVoHcB5Vn7zI=
X-Google-Smtp-Source: ADFU+vuJnudpuovhYmGEGviOXZLT8DyMyD19/J4SlEODnOc21sgSZvbCIx6D/EeC4nVPBXtzzaZ8mg==
X-Received: by 2002:ac8:4e94:: with SMTP id 20mr18929454qtp.314.1585012555378;
        Mon, 23 Mar 2020 18:15:55 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t123sm12089427qkc.81.2020.03.23.18.15.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Mar 2020 18:15:54 -0700 (PDT)
Subject: Re: Season of Docs?
To:     Taylor Blau <me@ttaylorr.com>, Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, dstolee@microsoft.com
References: <xmqqh7ye3b66.fsf@gitster.c.googlers.com>
 <20200324000859.GA5514@syl.local>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <78623f61-ede6-9f55-5106-1f393b06738a@gmail.com>
Date:   Mon, 23 Mar 2020 21:15:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <20200324000859.GA5514@syl.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 3/23/2020 8:08 PM, Taylor Blau wrote:
> Hi Junio,
> 
> On Mon, Mar 23, 2020 at 04:26:41PM -0700, Junio C Hamano wrote:
>> This is a companion program to GSoC we might want to participate.
>>
>>   https://opensource.googleblog.com/2020/03/announcing-season-of-docs-2020.html
>>   https://developers.google.com/season-of-docs/
>>
>> Many places in our docs clearly show that they were written by
>> developers, which we may want to rectify.
> 
> This is a great idea, and I think it would be good for us to be
> involved. I know that Stolee wanted some help writing documentation
> about partial clones [1]. Maybe that would be a good project for this?

I have a willing volunteer right now. Hopefully we will all see progress
in this direction soon. If that doesn't pan out, then we can bring this
up as a potential area.

Thanks,
-Stolee

