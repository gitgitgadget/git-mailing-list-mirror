Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5F504C433EF
	for <git@archiver.kernel.org>; Thu, 24 Feb 2022 18:23:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232818AbiBXSXi (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 24 Feb 2022 13:23:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbiBXSXd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 24 Feb 2022 13:23:33 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D2C11AEEC2
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 10:22:51 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id p9so930483wra.12
        for <git@vger.kernel.org>; Thu, 24 Feb 2022 10:22:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=AIsuYr+8SXzwQADM4ZGskeirHeeM0Tgw0mC3cihwKqY=;
        b=BJwJDUv57Xi/xCjhA/QseDfh3fwHkZu24F0/cZMvy44r0KwzFhZTqpOdExAxv5FJAb
         zE8UCs8z+QrlQaV0B7Q5fTX4G1NGBEEPOqAPRz0fyyN8oFetE5eqkKD0PxnRIajQ/Bev
         UXDxlzxkJtgk7dvqnvdiqJJKeuD7efhIKTP69xAbqmle+Xbnu3J1URBLfzRKHAfBVHj+
         cCqmghTGfLtA43e0G+/pC260G3LLN2njLILI7rm4hyLsawrJrhOtcbr7crwkY/xHrJEi
         RXVfXv3lOYsPF3vjBSvuW43+rp7JWXt7EF941pbpkBdDjxcRqJKg6mx+XftJ4/u/vIzU
         6frA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=AIsuYr+8SXzwQADM4ZGskeirHeeM0Tgw0mC3cihwKqY=;
        b=gH62AYuQOyRkN+jdJfpfW3NijuZPado63gNNXcCkPzkisB5WjJzqKtQRhZ4Kg1TiX1
         BUbClQq/JZJ/+FS4io3s/dlGzcXxogoYzFH5emX8+gtd9uldaqWPE1c238aIZUjUh/Ds
         nSjnya7jNO2AEUFR3LHJhCQPIAFMPrEHmFN9/OXJ/rS6qq1ErhEDCigssXT7gRJibMUB
         ipaHfLEf71tbrgiYAPvHyBMslCWKhat/Umi46pfU/OZKaxOwUodvSlw9X03LMOw0Vyd0
         ofd59b+QJyKcttVRxcvxj3ez9HykbqT792pqsa0pfifJl5Zp04eg+2PygXYJeyRFd/4I
         y+5Q==
X-Gm-Message-State: AOAM5309s/VrUg5fLTwxO7xfn9z4uYeazqrgSpDh4H9DgGEdFVmQEn2c
        Tpm35MWSTBG8Rxx8mpn2asQ=
X-Google-Smtp-Source: ABdhPJyZimyaTQGt7JiPO07j3+ruVFbYHa7qT4GPKDMnK6iHmVo8o3d7lLjhuNNXDH31MRqMa7Ygsw==
X-Received: by 2002:a5d:52c8:0:b0:1ed:e591:be70 with SMTP id r8-20020a5d52c8000000b001ede591be70mr2946053wrv.436.1645726970360;
        Thu, 24 Feb 2022 10:22:50 -0800 (PST)
Received: from [192.168.1.94] (176.248.7.93.rev.sfr.net. [93.7.248.176])
        by smtp.gmail.com with ESMTPSA id k26-20020a05600c1c9a00b0037bdeaf5d30sm116999wms.36.2022.02.24.10.22.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 10:22:50 -0800 (PST)
Message-ID: <27e53150-e1eb-0959-a7b8-cc4e561b9c83@gmail.com>
Date:   Thu, 24 Feb 2022 19:22:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v3 0/3] replace test [-f|-d] with more verbose functions
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     avarab@gmail.com, git.jonathan.bressat@gmail.com,
        git@vger.kernel.org, guillaume.cogoni@gmail.com,
        matthieu.moy@univ-lyon1.fr
References: <xmqqbkz4105s.fsf@gitster.g>
 <20220222215430.605254-1-cogoni.guillaume@gmail.com>
 <xmqq35k9qjeq.fsf@gitster.g>
From:   Cogoni Guillaume <cogoni.guillaume@gmail.com>
In-Reply-To: <xmqq35k9qjeq.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hello,

Thanks everyone for your help and reviews.
See you next time in the mailing list for some new patches or reviews.

Sincerly,

COGONI Guillaume and BRESSAT Jonathan
