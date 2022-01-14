Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52CC0C433EF
	for <git@archiver.kernel.org>; Fri, 14 Jan 2022 23:33:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230104AbiANXdp (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 14 Jan 2022 18:33:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiANXdp (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 14 Jan 2022 18:33:45 -0500
Received: from mail-qv1-xf33.google.com (mail-qv1-xf33.google.com [IPv6:2607:f8b0:4864:20::f33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A32FC061574
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 15:33:45 -0800 (PST)
Received: by mail-qv1-xf33.google.com with SMTP id a8so11657930qvx.2
        for <git@vger.kernel.org>; Fri, 14 Jan 2022 15:33:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=0F7DAHIc469n+3ldp9uAn5IL7ZZw7TUczfqpDse9jwc=;
        b=hkH0sF6MBj2JnaGUzUQxbV+B8hhKySUFT234JFtHLKFe+REyc6CHPQXK2y8mhs/JjI
         XnE0EJFLxlSZnurO6ucd0jpLjDJ9NjTddob4Sh4iaLnOqk8ULvakkrRDPPmHvBrJKgCk
         OdR9p6Q7WweIY89+2e1oJeu48Cwze6AG7GyZNLLSysLiKih0KYrBBFvkuCSyZXtfAeOk
         OFYraBvdUEw3o1qXeIR3ew9xj2iZ2ICa4E0sGtx0btuEi/ryv76ta/fERVBOVyzegnst
         6KAoL+ft7EqCm/iBCoD93K8DU3y7x9gCazurhdWBjM7hihleT/ictPK2iezz9xIPYiBO
         QX6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=0F7DAHIc469n+3ldp9uAn5IL7ZZw7TUczfqpDse9jwc=;
        b=kUaThav0Zq93kVCNk7+AKSp0B3Zqxf/4JfMcMGtwC1OzEEkdTHWlX1J2WmeFfMEn38
         mpV63Tj5tfJkxvd2xvKZQpPCqkj6T/lEhexbyYCXoT7kduNBX6FexS51PMnPyQQ/dZJ+
         Y9Rjdm19zKij+ABndky0jqyX88zHRQpulOJGDE4LpLBA+eX6ofVcgX2hBsBAAHhob5MW
         lAlOfJV44i/gl73SzvTCfiBqQ2n7vFHCQucIiGA5dU3p7KUVZFnGgwJ1BhTSIHnRyFuM
         pPNa3lO+Yy7aFi4DtsZNdPKAsYnY1uj17sUHCRUo5RMq/I/kktzLijZsZ5K2dQ29fnId
         E8Eg==
X-Gm-Message-State: AOAM5320+lt6QaVMPHy3YtNINafvYiAI0Z0CCns7LPIEUiUUxBdMF5oM
        YQSwP18v8XFCfLpRNZEemf+N+2nyTSQ=
X-Google-Smtp-Source: ABdhPJxIHuBtVmfRHuO2M6C4+YMw1z4xpGPm9snNdoD2xJLxK4z3tVF1P+nmiE4Oe/D+REvG4n8O8w==
X-Received: by 2002:a05:6214:1c8b:: with SMTP id ib11mr10579274qvb.131.1642203224210;
        Fri, 14 Jan 2022 15:33:44 -0800 (PST)
Received: from [192.168.1.127] (173-246-5-136.qc.cable.ebox.net. [173.246.5.136])
        by smtp.gmail.com with ESMTPSA id o10sm4938035qtx.33.2022.01.14.15.33.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Jan 2022 15:33:43 -0800 (PST)
Subject: Re: [PATCH 1/1] builtin/pull.c: use config value of autostash
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai <johncai86@gmail.com>, git@vger.kernel.org,
        Tilman Vogel <tilman.vogel@web.de>
References: <20220104214522.10692-1-johncai86@gmail.com>
 <20220104214522.10692-2-johncai86@gmail.com> <xmqqbl0r9l0l.fsf@gitster.g>
 <4fe0e850-1c30-da70-5535-e2a4105ba734@gmail.com> <xmqq35m0el28.fsf@gitster.g>
 <xmqqee5bfaof.fsf@gitster.g> <8d19623b-4b11-8ecc-8f27-17ad4ba4167a@gmail.com>
 <xmqqr19aayxp.fsf@gitster.g>
From:   Philippe Blain <levraiphilippeblain@gmail.com>
Message-ID: <cc3408c6-856a-edd3-9f84-5073ea0fac1a@gmail.com>
Date:   Fri, 14 Jan 2022 18:33:42 -0500
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.11; rv:78.0)
 Gecko/20100101 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <xmqqr19aayxp.fsf@gitster.g>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

Le 2022-01-14 à 14:40, Junio C Hamano a écrit :
> Philippe Blain <levraiphilippeblain@gmail.com> writes:
> 
>> tests. I hoped that John would incorporate my suggestions in a v2, but he
>> seems to be busy, so I'm including an updated patch at the end of this email.
> 
> Was about to say "Will replace the in-tree version with this. Thanks",
> before I realized that your message is "text/plain; format=flawed" X-<.

I'm sorry for that. I was in a rush and *tought* that I had Thunderbird configured
correctly so that pasting the patch would work out. It seems not. I'll
be more careful next time:)

> 
> I think I fixed it up correctly.  I'll pick this version up from the
> list and replace what's in-tree with it.
> 
> Thanks.

Thanks!

Philippe.
