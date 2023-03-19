Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F85BC7618A
	for <git@archiver.kernel.org>; Sun, 19 Mar 2023 14:50:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230336AbjCSOuN (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 19 Mar 2023 10:50:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230150AbjCSOuL (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 19 Mar 2023 10:50:11 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5F2814E8E
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 07:50:09 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id p34so947026wms.3
        for <git@vger.kernel.org>; Sun, 19 Mar 2023 07:50:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679237408;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=jdSaYtzwf0ZCXDXROd9Rv/YiMu4FEAJwDh6C8sjz2v4=;
        b=o+df1QbqTLIFrmtSjWk7+nk6OTvbNPcv133fPqQg11gh0cfiWAeCmYCU9HGeUJ5dDC
         bVnvJsmzt1Wi4JWTQ9Zoz1NPgKdOnj5BCVS5PeX1B0Z6rXgAZz+nTUFfFL3FeFTC8wgL
         hCnhSWpDaJEfqb6/KEodkjykEFh4Wu12evmWjGn299DKsnnP8SBkzx0hwBiadjAcLx0a
         UbzGnUMcQQaKiPAQ3QoP0Mxh5Q1VZMdUKCCYS7axtoepAHmUoIdgEZBvSslPyhyKYeJG
         WlapmOke293mOHRwN42rgHQLtVyzTfh5PjmkfuhUUpDGCtG6S1BKFrxswEG9U0gkwchr
         wz8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679237408;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jdSaYtzwf0ZCXDXROd9Rv/YiMu4FEAJwDh6C8sjz2v4=;
        b=vuA8o7ChedonBu+rX3wbGb4dwsKTOzZY27E0+uC727CqgkR2JvhjWN8V1hYA6vuIC2
         fJ7E6D9RTxmqQZ6G3af144Et5LGU3e9lK5dsYWlAG81UfcLPfeJS5qInQ5HDD2JMfcxo
         iXwlPngDYHnSl5AWwV84kIwY4qCDNS0/TcUQvePbLVVNSW9E2hZQI/BjvoI4uOWFIePJ
         TL1fu38sqisJLm1XAxBMUGggE0r1buJxdIzLCYILGPpCpPrbtf8tkCUbJHiBFFJP/XEW
         n4mGDvqPhwN+YUT0dwwQ1FbvhQ79bXD5+sRgVQMI299cU/pj/ndnpVs7ECaslwn15rCY
         u2ew==
X-Gm-Message-State: AO0yUKUqyox2ciYn+subOD8MQwxj4pK73zjdoO8ujqkC2u4o6rXoJYfc
        kNptr64WhHmf7xEjxSgrUuNt88V1TC0=
X-Google-Smtp-Source: AK7set9WEGp7PJG/DeBodCUU1VIY+XSvO2n8WgDDBM2AvGwPA1XkdxWIEtKLAf9+Mu0qoWwY6cMuWA==
X-Received: by 2002:a05:600c:2215:b0:3ed:f5f3:5e64 with SMTP id z21-20020a05600c221500b003edf5f35e64mr141452wml.16.1679237408157;
        Sun, 19 Mar 2023 07:50:08 -0700 (PDT)
Received: from [192.168.1.212] ([90.253.29.198])
        by smtp.gmail.com with ESMTPSA id ay38-20020a05600c1e2600b003df7b40f99fsm13647962wmb.11.2023.03.19.07.50.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 07:50:07 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <0eb3ed02-139a-b114-939a-d2ad286af743@dunelm.org.uk>
Date:   Sun, 19 Mar 2023 14:50:03 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: When exactly should REBASE_HEAD exist?
Content-Language: en-US
To:     Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
 <374f83c2-7bf0-38be-26ae-de28340c37d2@dunelm.org.uk>
 <f28bb5a7-ec68-dce2-9b63-7bfb5330c33e@haller-berlin.de>
 <db9f3be7-097f-006e-927a-91be7a50360c@dunelm.org.uk>
 <3ab454f1-2bb5-d990-4cc4-4e2fde2ba294@haller-berlin.de>
 <97eec89b-6a10-434a-a9aa-54c266da7fb1@haller-berlin.de>
 <18763465-de3b-7e64-129b-1f9337ea1924@dunelm.org.uk>
 <4d13d02a-ddaf-7b8f-7a27-c7a030816523@haller-berlin.de>
 <722659e9-02ac-a9d2-b0fd-b9a2a3d85753@dunelm.org.uk>
 <805626af-b147-d3cf-5257-a5b90b7cf1d9@haller-berlin.de>
 <f7577c57-f70d-cca3-3f25-18525d40d79b@dunelm.org.uk>
In-Reply-To: <f7577c57-f70d-cca3-3f25-18525d40d79b@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan

On 16/03/2023 17:46, Phillip Wood wrote:
> Hi Stefan
> 
> On 10/03/2023 17:42, Stefan Haller wrote:
>> I tried the algorithm now and seems to do exactly what I want, so thanks
>> for the help with this, I'm happy now.
> 
> I'm glad you've got something working
> 
>> There's a slight correction though: if a command is rescheduled, then
>> git appears to re-append the last successful command to the end of the
>> "done" file (it's in there twice now). So I have to check the > 
>> second-to-last command of "done" against the first command of
>> "git-rebase-todo" to find out if a command was rescheduled.
> 
> Oh, sorry I'd misremembered how it works. I think it is actually a bug 
> that we write the last successful command to "done" again when 
> rescheduling but it sounds like you have a reliable work-around.

Hmm, I think it is a bit complicated to do this reliably as if "pick B" 
has conflicts and git-rebase-todo contains

	exec make test

and done contains

	pick A
	exec make test
	pick B

it looks like "exec make test" has been rescheduled when in fact "pick 
B" failed with conflicts. If you look at the last three lines of "done" 
you can distinguish the two cases but it is a bit of a faff. I've 
submitted a bugfix at 
https://lore.kernel.org/git/pull.1492.git.1679237337683.gitgitgadget@gmail.com

Best Wishes

Phillip

> Best Wishes
> 
> Phillip
> 
>> -Stefan
