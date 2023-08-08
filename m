Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7A7FAC001B0
	for <git@archiver.kernel.org>; Tue,  8 Aug 2023 17:04:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233490AbjHHREp (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Aug 2023 13:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229725AbjHHREH (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Aug 2023 13:04:07 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BD2719BF7
        for <git@vger.kernel.org>; Tue,  8 Aug 2023 09:01:49 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4fe0e34f498so9667768e87.2
        for <git@vger.kernel.org>; Tue, 08 Aug 2023 09:01:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691510472; x=1692115272;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=LK4jn8udtEBCjebDvSXSFSjVQGVEdRTxRgh1OAbtlR8=;
        b=KsAuqaRQrI3SR5cKox39RerQuU79M87OKDvEMyovWG9GSgUOBYE6aZiHNWbx0n5dyi
         fawcwhMTr+d9BM76AHEtu+pxE5jFkdqO9m76tqwROPF3GmDQI+OVtWGG84Z1V3oVE3HE
         /k9uy54ZA3U+jfYQKGx6bkP8BPap5/j1Q7XK/h/f8mxUAnAh8vwxB7PYJvDURPGWofOp
         06Jx0cJ5tcdxkWtSO8C2rE0rxWYUibxBNccf9ZCCLdc+i5MT/QVvvzLXOtzsi9yydEhV
         P17TvRYIu9+j9/QDc+bpLwz1XLYx99Umz1rTe6IDUiN/z0X2ZEKeFiLl8Smeig2NWV+N
         O8AA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691510472; x=1692115272;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=LK4jn8udtEBCjebDvSXSFSjVQGVEdRTxRgh1OAbtlR8=;
        b=fWSW16Jbl9U/9R3ToLjkgAubcNs1xNoiMaSm0m8AeICUGiRoh6zmVEl73YWBP0PLfV
         deyJ1FgpKvGzxM0ig2HYFjVnTRCPNT9udNhO/M7ai8zS+G+6Q3eiFA4RXBi05NyHkSRU
         AZwoBCz1ByeITByFdCK0WfyU/57bcX8yK1wVdaN9/pOow23cBxhbiY9m8iWiTtuKcosT
         f0uCbwNxdwHmdlgqxf3+zo7sRCml8aRLuTT53SKW0HXwbINPcn1BWnx9hwapgJ5gxl3J
         U4UUlV4I02mXK1QdWvUiN7LfE+pgTWWDW0SG8ltn68wE3GDfZmhoF9Jm7rbqdY0szgWO
         uWuA==
X-Gm-Message-State: AOJu0Yz1ehREQW67mykGJUVMlAce+hnxpPhZ7PPAj7NJ2jXSz3KQZ1r5
        FxZ1NoU9hiKOB+n8GUQ6o5xZBHN/EW0=
X-Google-Smtp-Source: AGHT+IGRWfqGhy0udkKv0VMnh14eLrEbtpQ/dSVSFD8H6oQ+XKlq6AsvApKUdhIzSy04J2EjBDk9Vw==
X-Received: by 2002:a7b:c394:0:b0:3fc:e1:24b5 with SMTP id s20-20020a7bc394000000b003fc00e124b5mr9071170wmj.23.1691499791426;
        Tue, 08 Aug 2023 06:03:11 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id f17-20020a7bcd11000000b003fc00212c1esm13647869wmj.28.2023.08.08.06.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Aug 2023 06:03:11 -0700 (PDT)
Message-ID: <c1c569a6-5200-2fb8-5fb8-f8d57253fb16@gmail.com>
Date:   Tue, 8 Aug 2023 14:03:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 6/6] maintenance: use random minute in systemd scheduler
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, sandals@crustytoothpaste.net, lenaic@lhuard.fr,
        Derrick Stolee <derrickstolee@github.com>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1567.git.1691434300.gitgitgadget@gmail.com>
 <14e340b75faaa66980479f42fec14c457aea5c74.1691434300.git.gitgitgadget@gmail.com>
 <adc0cf80-c2e3-7af2-6d7f-036b95d27f80@gmail.com>
In-Reply-To: <adc0cf80-c2e3-7af2-6d7f-036b95d27f80@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 08/08/2023 10:53, Phillip Wood wrote:
> Hourly: "Tue..Sun *-*-* 1..23:00:%02d"
> Daily:  "Tue..Sun *-*-* 00:00:%02d"
> Weekly: "Mon      *-*-* 00:00:%02d"

Thinking about it some more, this only fixes the problem if the computer 
is actually on at midnight. If the computer is switched off overnight 
then we still try to start three maintenance jobs at the same time when 
the user turns their computer on on Tuesday morning. We could stop 
marking the hourly job as persistent on the assumption that it will be 
run soon anyway but that does not solve the problem of the daily and 
weekly jobs running concurrently on a Tuesday morning.

Best Wishes

Phillip

