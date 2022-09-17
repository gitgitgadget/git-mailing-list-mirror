Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7B57ECAAD3
	for <git@archiver.kernel.org>; Sat, 17 Sep 2022 03:45:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbiIQDp1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 23:45:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiIQDpZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 23:45:25 -0400
Received: from mail-qv1-xf29.google.com (mail-qv1-xf29.google.com [IPv6:2607:f8b0:4864:20::f29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE7C37C313
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 20:45:23 -0700 (PDT)
Received: by mail-qv1-xf29.google.com with SMTP id s13so18044532qvq.10
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 20:45:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Vltu6eaLYkEYfnAh7jkFUOfMNDeeh7vSyGY58N+WP88=;
        b=N9Hg6xVnqkB3iQUuPkxTa1xQ/Vt4yCpYXsvhfUVOkDOk3ATshG+7Y53rUHUnq2XinG
         RcGmKepsARo35OkRHW9OUwaFkLFjKmEL/WHGiV1BkWhLQw/0aUol9m0fMhrO43L6bz8Q
         2OVZ5F28GbDOtviLPeW3JY3O6QhBspCqoDnlLAfTF9NmRck2GXQ4isUXe/DV1Co5y5eF
         IUJMuD+xl/KsQ6YTBuRS1IITAf+42ZYUQ8LfkadCMbBgdO4ugFLjm28V6Tv4YFUiHw1D
         bfuZEOlN1PNjzsGBRMmeD8oF3oYY+OshOaJsmliECZZz3GaIIIDaH7QHq3JoiO3lrhoO
         HvdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Vltu6eaLYkEYfnAh7jkFUOfMNDeeh7vSyGY58N+WP88=;
        b=BnyDj+9aBGWTLwJLojN//I9lZgixICnpZDFHC3bBDvItlf43G7TkNuTQMB0I1hhnWZ
         r9LNVXJmjeVVF1uUmk721LMzbhuU8QLHsX6CCBEoUm9rsF3FTWhDkQxUQzNqy1PtMHa2
         9WBHjRzBzVtklvTFSA6xG9MCaBEu0nq3Jm4/cvD69xWaKac/iB59DZZG5u9XSnX+Btei
         omFdcgabGnjftAbAYOB1yOw9l/6aYpkcE2cWMiAnL5qheboYkZIn2Kf10h+262IXjlfm
         P+JRoa2iVzZuPfWstTy8CExU3a9xKFnUShnMoepxlnquKQawhL2K+EIczlU92jQS7zRy
         TSLA==
X-Gm-Message-State: ACrzQf3rqGr+T9Fz6/4r6MxdJQ8uSpKO7tiLliarrUmKzGm+NHmhfE+r
        uM1UUtPHuY7CRUpE07j6XAE=
X-Google-Smtp-Source: AMsMyM5qmulhIRPsRnnX8PJNOSpP2TuRZbPQwh6QApBDm/CM2oeKZooOdaO7PEZdWyz3aTgaT+cErg==
X-Received: by 2002:a05:6214:2486:b0:4a5:8b:9ba0 with SMTP id gi6-20020a056214248600b004a5008b9ba0mr7248274qvb.70.1663386322854;
        Fri, 16 Sep 2022 20:45:22 -0700 (PDT)
Received: from ?IPV6:2600:1700:5a60:7720:391f:afa1:7d4f:f031? ([2600:1700:5a60:7720:391f:afa1:7d4f:f031])
        by smtp.gmail.com with ESMTPSA id c8-20020ac84e08000000b0035ba366cc90sm6040082qtw.15.2022.09.16.20.45.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 20:45:22 -0700 (PDT)
Message-ID: <f665e45f-1f7b-f92f-0512-60c83bf2864a@gmail.com>
Date:   Fri, 16 Sep 2022 20:45:20 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v5 1/3] builtin/grep.c: add --sparse option
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Victoria Dye <vdye@github.com>,
        Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>
References: <20220817075633.217934-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-1-shaoxuan.yuan02@gmail.com>
 <20220908001854.206789-2-shaoxuan.yuan02@gmail.com>
 <CABPp-BF-z72=hY_Jf8h3g95s+wwZOsV_S=+dDNs_AVskQxoaTw@mail.gmail.com>
From:   Shaoxuan Yuan <shaoxuan.yuan02@gmail.com>
In-Reply-To: <CABPp-BF-z72=hY_Jf8h3g95s+wwZOsV_S=+dDNs_AVskQxoaTw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 9/13/2022 11:08 PM, Elijah Newren wrote:

...

I think we are now at a point to make this UI decision, which may not be
easily (and should not be?) reverted once it's made in this patch.

So, is "--sparse" we want for "grep", even for "rm", "add", or "mv"?

Love to hear from other contributors :)

Thanks,
Shaoxuan
