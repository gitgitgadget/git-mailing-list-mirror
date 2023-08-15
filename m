Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E818C04A6A
	for <git@archiver.kernel.org>; Tue, 15 Aug 2023 09:18:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235962AbjHOJSY (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Aug 2023 05:18:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236122AbjHOJQp (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Aug 2023 05:16:45 -0400
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DCB11999
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 02:16:40 -0700 (PDT)
Received: by mail-wm1-x32e.google.com with SMTP id 5b1f17b1804b1-3fe1e1142caso51195205e9.0
        for <git@vger.kernel.org>; Tue, 15 Aug 2023 02:16:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1692090999; x=1692695799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fKLyuuL9EyqLUuGVX0c/N4vnCIsIBFT9wst61QxO2q8=;
        b=kPZVHmUrpE7k0ETLHb/ZjEY5qcdlTwzVNc+HTQiTvEc2hX9N2wtt/X22T+gUI76fcm
         C3l02A+mn91xSGYR6M37wurAMofdxL1enK6KOgwHLqvBZunj/6hcfN+k1Mwz1Y/2B18y
         8BUv9XovIFz/JJ7S1KJqwiSQ3/WbFyQH2ExoIRxf/my/N0aHGsB9wGK2EexLDa+PAr7h
         SgvSUpF7CYr/mAQnvhG8PWct8tGVINOcN8N5EJPHd4vgyt+sCrcBdA0fTVyJD9XcrI1p
         N2DZ93GLu4buq7F2bMNIqeQOwiKBKeXS1wtkHcsZuNHHjZwZomtN+AiwiPub47QfUtRU
         Ns2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692090999; x=1692695799;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fKLyuuL9EyqLUuGVX0c/N4vnCIsIBFT9wst61QxO2q8=;
        b=hGVW5AOdPfQazZWqBycNsxZpyEvLjC+H42tzevFVLKu9mfI6PSkC1BrfiJddUrB4sW
         xGF5CqYFWQ8PzRirzmAPgTj8S7dC0sB9NQfDqc680BG1h3v1lVhw+S1+Or3+8V1qcpXS
         VOEZCR1mim/6jBvm493TpSPhWrsFvQ6k56HQlOXRlqM2HPXYCg31GVTDFCgu9f/UDnQe
         lW8qs9krb8EsFNYo26IVwv70Ij5nKzR8ZhkQFxzk4GzrJ+k4QjLxnRzgr3Lo7+kGu1lD
         hAxCrPIheEFzI0e0AdHhUMdnE+ND5MR/N81m+8CWjLsOm+HErT8OeBdn5yrBrFi+2lFI
         TH2A==
X-Gm-Message-State: AOJu0YzqT6Acd3meSjBWD6+QTVY+jPZQl7lZ/xJ+j+J8ATtQ4qsdjRX+
        16G9Ka12CrIgO929iyAD/vs=
X-Google-Smtp-Source: AGHT+IFUJNjvLKbX5A9/8heSAKQqzEBmm47YclN+5i5d+VjQEAeavtW+ZHZx+5I2u2y3Zno1qwzbWg==
X-Received: by 2002:a05:600c:220a:b0:3f9:b8df:26ae with SMTP id z10-20020a05600c220a00b003f9b8df26aemr9428131wml.34.1692090999094;
        Tue, 15 Aug 2023 02:16:39 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id k5-20020a7bc405000000b003fbdbd0a7desm19934561wmi.27.2023.08.15.02.16.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Aug 2023 02:16:38 -0700 (PDT)
Message-ID: <8adfe4d7-f3ac-6aae-6193-4cd0ac18aaba@gmail.com>
Date:   Tue, 15 Aug 2023 10:16:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v1 1/1] git stash needing mkdir deletes untracked file
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     tboegi@web.de, git@vger.kernel.org, friebetill@gmail.com
References: <5260C6A0-C53C-4F6D-B899-6AD8601F8458@gmail.com>
 <20230808172624.14205-1-tboegi@web.de>
 <6e40eb0b-2331-1e39-bee0-c9720c24d1c8@gmail.com> <xmqqo7jgkk7s.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqo7jgkk7s.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 09/08/2023 21:57, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
>
> If "silent and unconditional removal" bothers us, I wonder if it is
> a lot better approach to error out and have the user sort out the
> mess, which is what we usually 

Yes I think that would be a better approach.

Best Wishes

Phillip

> do when it gets tempting to "move it
> away with an arbitrary rename" like this patch tries to do.  I
> dunno.
> 
> Thanks.
> 
> 
> 

