Return-Path: <SRS0=YoUm=65=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 214C4C433DF
	for <git@archiver.kernel.org>; Fri, 15 May 2020 11:05:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFC8820758
	for <git@archiver.kernel.org>; Fri, 15 May 2020 11:05:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="j3w0PK/m"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726170AbgEOLFC (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 15 May 2020 07:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725995AbgEOLFB (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 15 May 2020 07:05:01 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F6C9C061A0C
        for <git@vger.kernel.org>; Fri, 15 May 2020 04:05:01 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id e16so3031340wra.7
        for <git@vger.kernel.org>; Fri, 15 May 2020 04:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+9A600kl6kw8b40XqlIt3NJP3bIEDlpx2dVBV9j28aw=;
        b=j3w0PK/mrmrIBK+/9seW9VYiM35rLyCCkiJAT2aFGYKLdwSnRs+HcOuXeXZ9kUey/i
         qVPhxyuMOHLE2OUAqQSHzbJrc6YyJH7z5QKsCy4iCAi0EjozLjtWAZRMakFpcpXKMyDY
         DeRjTVFDKWnWcdW2sYfT9oQJL1kIJr6UALyTKbvyeail2PKLawJnpAADldwez8NPn89F
         bM+8ivac9sWdQ/50uYQGjN/vNXgN0Kq9W6orwaw4/NHlUR5owP7MMnxGCGdTXzBxujOR
         d8wfH/JmFfrk5W527ktFIBvUY3aa96qx0wAlxTh0cBC/oxDWyn6RGluZDFjTF5jLGYYT
         YZdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+9A600kl6kw8b40XqlIt3NJP3bIEDlpx2dVBV9j28aw=;
        b=pwz2zk2jvL4mWU81QpoPtnwKCDJjIRlDBhRh77Bev7fN+AFTPUs0R7Zv2dViWxe7tI
         F4WVTQ8dX8PtD8commpgUPrP8xpGEdq9x8wpp9B9fPjsvbXm9KcHeFYfCi33Q5rSaMNV
         bBjeYv25iIcvwngnDFJKQuC2sKqoVotM/ZpaDSo+uAIMCyo6xnrJ7b9EEaqSE1woJKDo
         enQ+xHIZduEZHkpdIEPIs81GqklpsqvP1tGpkXZNNqZ2SP7+VXz7pUF44xWkYdscRGrM
         8XSmso2B0NS92Fp681nIANfXdx2YO/Nr8I27YR284eYnDpNgPXwgRVWVndSIHIpWMeQt
         EloQ==
X-Gm-Message-State: AOAM532h2OjoVf5UQjUAsbTAMMhVmUjDNutHOeM7gpInEBMkhWt3XF4f
        GHIsDRuPWQC7sUhsN5Dm+68tzNmmzLUgxQ==
X-Google-Smtp-Source: ABdhPJz+c+vwHJtjcrcPfTuXgCss6BTqwTQriPLsvwHnywGTXssiWJcRd6aaGinXJQhNnTr9amqPtQ==
X-Received: by 2002:a5d:6750:: with SMTP id l16mr3677966wrw.295.1589540699607;
        Fri, 15 May 2020 04:04:59 -0700 (PDT)
Received: from [192.168.1.21] (xdsl-31-164-191-108.adslplus.ch. [31.164.191.108])
        by smtp.gmail.com with ESMTPSA id s8sm2724940wrt.69.2020.05.15.04.04.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 15 May 2020 04:04:58 -0700 (PDT)
Subject: Re: [PATCH] submodule--helper.c: add only-active to foreach
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "Guillaume G. via GitGitGadget" <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.631.git.1589099162707.gitgitgadget@gmail.com>
 <xmqq8shxc7ct.fsf@gitster.c.googlers.com>
 <cf25c55e-e0c8-6374-3adf-84f4314869e9@gmail.com>
 <xmqqwo5fvoe1.fsf@gitster.c.googlers.com>
 <83b37142-f6f0-2f5d-e92c-de3891e8fe18@gmail.com>
 <xmqqwo5fshe0.fsf@gitster.c.googlers.com>
From:   Guillaume Galeazzi <guillaume.galeazzi@gmail.com>
Message-ID: <37d9ea7b-8edc-e7e6-4f79-045d616de3e2@gmail.com>
Date:   Fri, 15 May 2020 13:04:56 +0200
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <xmqqwo5fshe0.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 13.05.2020 à 22:35, Junio C Hamano a écrit :
 > Guillaume Galeazzi <guillaume.galeazzi@gmail.com> writes:
 >
 > I already said I was *not* suggesting a concrete syntax.  The more
 > important point was to make us realize that we need to think outside
 > of "active-only" and make sure we can support other kinds of selection
 > criteria for submodules.

Ok get it now. So after looking a bit, another trait that could be
interesting filtering on is remote tracking branch. A v2 with filtering 
based on active (or not), populated (or not), and tracked remote branch 
is ready on my side. It also include the rename of the struct member 
only_active to active_only. Let me know when I can /submit.

 > So spelling out "--no-blah" to mean "not with blah" is probably a
 > good thing to do (especially if readers do not mind being English
 > centric).
 >

Great, it make it a bit simpler to code, thanks for the tips.
