Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8F27C0015E
	for <git@archiver.kernel.org>; Fri, 11 Aug 2023 15:08:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234414AbjHKPIW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Aug 2023 11:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjHKPIV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Aug 2023 11:08:21 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290ED171F
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 08:08:19 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-3fe4b45a336so18239025e9.1
        for <git@vger.kernel.org>; Fri, 11 Aug 2023 08:08:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1691766497; x=1692371297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=pzGNsBRTkcJ2hd5qJorJFIjkKO75XGyzW9MxRz6t1DY=;
        b=rYuuGD7DKB62K8KZCJKPbLvAl9NzUHNE94Elld/6e3434uCtpixr0HZnmr8DfGL1Yq
         eXAD8QGXKeMgvZdPocy6IX+sOBVh+0msJ5xvQSAwpc2FyfsjNygu+kPKIzBslqpbmb/U
         b1J4BlDpHjUEacYUEmwkvQeHMTk8hIVM6KPJRiUtMV1GUBS0iJ6bIQ4twL4KLJ4LaNCD
         17UZVtaAgzM3i9vdw0jtXy6IiyeXbG8H0IIx/BDL0MuQrxZ2a5GK1OA86DwjX8pLx2Mf
         Hn85wxbo26Stwd0SyrLzF5fvR8BmBejzCx8U7JhU5avPBNl+StLHu1v8YCkpSTh6g6s5
         dDjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1691766497; x=1692371297;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pzGNsBRTkcJ2hd5qJorJFIjkKO75XGyzW9MxRz6t1DY=;
        b=HPLlj0wHS0TgytKeGu2km8ce3X4fawipHEM/Vpr3D4wLvYTYxvaVCu95tyolC5fGRn
         ZIQuXNH1fsIyXz9nbqIqcYCh+NErp5ixeeK6W5fBOCb0m6oUC24GEuNsaFCU1mjzRBQ4
         T0yUOZPYb3vXpJm+aQLp2wJgZS1AVf8jThymQZzppV5dqitGsFBpXqmr0gHcGyqlb87T
         wAer/gucWPtEBsSpzyAKDdayEDlXV97kWHhQjAGJoA2pt5zGmB8JoeaGbQ4+MhZ0qfOX
         O1Y5aAOYEdxJXCrq5T33a25IOSNHCr1ddl8rAXoj2aH1Pzn1F7ZcEk6PNj3Dwp2MGmfU
         3wKQ==
X-Gm-Message-State: AOJu0YzVCayiL3p78+LiZpJ8d6JXFEIoH3Ix7A95P5PZqt+KzEn7hg/e
        yvRRDXs9k46DlI28IgCWRZc=
X-Google-Smtp-Source: AGHT+IFjnc/V2AUzmp9zA9BFEPqY02aP2HPtk+iKqG9jgCWoiudeDtMFR6XfbqGISJ/yi1hj0Jhj1w==
X-Received: by 2002:adf:fcd1:0:b0:319:5bde:df70 with SMTP id f17-20020adffcd1000000b003195bdedf70mr1543988wrs.42.1691766497564;
        Fri, 11 Aug 2023 08:08:17 -0700 (PDT)
Received: from [192.168.1.116] ([90.242.223.1])
        by smtp.gmail.com with ESMTPSA id l13-20020adfe9cd000000b0031934b035d2sm4908224wrn.52.2023.08.11.08.08.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Aug 2023 08:08:17 -0700 (PDT)
Message-ID: <b9f8c965-731d-84eb-f60e-fbed418f9ca2@gmail.com>
Date:   Fri, 11 Aug 2023 16:08:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v3 2/2] doc: revert: add discussion
Content-Language: en-GB-large
To:     Linus Arver <linusa@google.com>,
        Oswald Buddenhagen <oswald.buddenhagen@gmx.de>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>
References: <20230428083528.1699221-1-oswald.buddenhagen@gmx.de>
 <20230809171531.2564807-1-oswald.buddenhagen@gmx.de>
 <20230809171531.2564807-2-oswald.buddenhagen@gmx.de>
 <owly8raih8ho.fsf@fine.c.googlers.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <owly8raih8ho.fsf@fine.c.googlers.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/08/2023 22:50, Linus Arver wrote:
> Oswald Buddenhagen <oswald.buddenhagen@gmx.de> writes:
>> +DISCUSSION
>> +----------
>> +
>> +While git creates a basic commit message automatically, you really
>> +should not leave it at that. In particular, it is _strongly_
>> +recommended to explain why the original commit is being reverted.
>> +Repeatedly reverting reversions yields increasingly unwieldy
>> +commit subjects; latest when you arrive at 'Reapply "Reapply
>> +"<original subject>""' you should get creative.
> 
> The word "latest" here sounds odd. Ditto for "get creative". How about
> the following rewording?
> 
>      While git creates a basic commit message automatically, it is
>      _strongly_ recommended to explain why the original commit is being
>      reverted. In addition, repeatedly reverting the same commit will
>      result in increasingly unwieldy subject lines, for example 'Reapply
>      "Reapply "<original subject>""'. Please consider rewording such
>      subject lines to reflect the reason why the original commit is being
>      reapplied again.

That's a good suggestion, I think having the example will help readers 
understand the issue being described.

Best Wishes

Phillip
