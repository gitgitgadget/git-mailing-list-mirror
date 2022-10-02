Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1A0EC433FE
	for <git@archiver.kernel.org>; Sun,  2 Oct 2022 21:28:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229516AbiJBV2c (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 2 Oct 2022 17:28:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229518AbiJBV2a (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 2 Oct 2022 17:28:30 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D50D367BC
        for <git@vger.kernel.org>; Sun,  2 Oct 2022 14:28:30 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id e18so5941889wmq.3
        for <git@vger.kernel.org>; Sun, 02 Oct 2022 14:28:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject:from:to:cc
         :subject:date;
        bh=jlQR3SAHRfdn0DZED1rBcJS0QhP/bqt++3XlNTL4p2w=;
        b=VSuZMPfserYYh6nvEBuxFNacw6eFZPSRx1jM5P6oLvRyVZij/hlbR0+miTZ9Iqtgqg
         tYjWvSPpPyTjVCh7m5mcP0ysrohRkgcm+At1TXldhq3i3JiCdeGxgz3iIytd+DfFxFs1
         KDBuc5sIF4Od790m06MCU21FBmVkAwCczVPUQ9ZhLDl219mu2CRWeQBZrKb9WpAbBwf+
         THndV4uripalgBx3paqhQxw4qRlcVWOcC63m9NXeMpXxp5rzx64kHHPXf4t/C8nlJHVH
         n4Ex4OWJh2apZRcl/3Plyn8zCQoOF4etG/JqIoVOkYs3XQTRO8b84j7uviI5P3E2OGWh
         eDlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:to:subject
         :x-gm-message-state:from:to:cc:subject:date;
        bh=jlQR3SAHRfdn0DZED1rBcJS0QhP/bqt++3XlNTL4p2w=;
        b=rbig89Q4ZmMu0skwLraVZbB+OEYWbtDoQieSaowdDm8PKFbCTlsT+YdpdaQkkJEDpB
         1tAunFcaB0cVW7g6FIlmByefA1rYcoq6YEryMgrS4r2XSPxwKp256BgnZAXbLwM0XWtt
         gzySwokbO+m1yUmNdWAXsab+3cLiMDd6hnM1FuM/I2NRe9C4tOvEWYqsM2CpOvWh1tk6
         9ntFiECRR3JSIIoL1bzQIF6BzAopBbcpas7KEvh8qnh2Zm8QDNfEkj89xTGfuM+FmoEb
         vNbFbQT3dQZvZ6F/lR+aF52mKE6tFBPbwMSREeVp2xAdxaBfaAlsciuJY6wpwCUpyx+s
         /mow==
X-Gm-Message-State: ACrzQf2hj6Z3/Jd94sjtRsSI7K1jS4YuO90dl9hJKma5kicMF6ZpwRvM
        byxNxlGkMPO7Eh2YnwTJ9U01stBLqmY=
X-Google-Smtp-Source: AMsMyM4JWsBbocslIfk6lQIWN3fcH5HhiCuDJVZOWsqSGl9PHWYI2UtJKzssePsRXZQ2T++N/+czyA==
X-Received: by 2002:a05:600c:1c8e:b0:3b4:9247:7ecc with SMTP id k14-20020a05600c1c8e00b003b492477eccmr5176116wms.40.1664746108514;
        Sun, 02 Oct 2022 14:28:28 -0700 (PDT)
Received: from [192.168.2.52] (5.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.5])
        by smtp.gmail.com with ESMTPSA id l9-20020a056000022900b0022b315b4649sm7889062wrz.26.2022.10.02.14.28.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 02 Oct 2022 14:28:28 -0700 (PDT)
Subject: Re: [PATCH v2] branch: description for non-existent branch errors
To:     Bagas Sanjaya <bagasdotme@gmail.com>, git@vger.kernel.org
References: <c333cc4b-12a1-82b6-0961-1c42080dad15@gmail.com>
 <930ff836-a5c4-0e85-517d-39645f00cd31@gmail.com>
 <f34912ab-5d1b-6dfb-e079-0e7b135ebe14@gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <a1cddefd-d555-05a0-a817-c8b10254fd9f@gmail.com>
Date:   Sun, 2 Oct 2022 23:28:27 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f34912ab-5d1b-6dfb-e079-0e7b135ebe14@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/10/22 14:43, Bagas Sanjaya wrote:
> On 10/1/22 05:47, Rubén Justo wrote:
>> This commit makes the error descriptions for those branch operations
>> with unborn or non-existent branches, more informative.
>>
> 
> s/This commit makes/Make/
> 

Thanks
