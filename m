Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23852C77B61
	for <git@archiver.kernel.org>; Thu, 13 Apr 2023 13:44:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231408AbjDMNoj (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Apr 2023 09:44:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230312AbjDMNoZ (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Apr 2023 09:44:25 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A4D9038
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 06:43:10 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54c12009c30so389677457b3.9
        for <git@vger.kernel.org>; Thu, 13 Apr 2023 06:43:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1681393388; x=1683985388;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SWOKs8JBquIOK+prcMURfs4d/oG7SIt5TFwQ6os/QL4=;
        b=fu+lYiyckmBTJpJx9Ac92t/rYk+RB2w4/ozna0paQoc3V6DEqUwb9v2uLMEedmvMX0
         RMrY9/wLpNWJTZsCqL6CcVM+4WM0HeNYx55NNgdS0Ws+/ZK4dOpT2+Dn5Z11PFNLmfbT
         CnLVcsSbwPhB2EQDa5i+bNiiJLTz+DPZVVeefmOP9y3Fr1c0OapoOg8h4l70+74Noyv+
         KIZQcOmPmkddOTGyWYs4Qprgf54tJsEL+In1+ZBs8G9MhXHQgDzJVz6u0F4nkyrs0yWR
         uHqKab/ivF/zVyQo5GUjhW2ZKhNBhQQNXajXL7eTGP0kIkwrc5prmcWuNcYgJWa9Mwfq
         FxoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681393388; x=1683985388;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SWOKs8JBquIOK+prcMURfs4d/oG7SIt5TFwQ6os/QL4=;
        b=dxISJF5/sz61RphbX2+OoN98HZu5U4loQ5axGGzhdiGhPZt+nvzygjwpljZz9xMWVN
         wvAfrrJCiOFLzoi9kqiyUsGvxiBXauruXhMz5TZVbJzLBMNm/dF/BVubamfGLc1biBG5
         bh1nSOpU5CVL1Vk6g+LRwxJYyvzAbzn5Oe7hW2kRkgbNokUdoRwJeenY+coaf1PwzR3M
         g4SlimQBXowplUHOAwrj2P/FY91AHgdKj87I0ZQedw25bC4qnRbgH/pVbSsVJtDGjKr+
         Idukp/YvcJh2o4nPSCdXdmthnPRFEzoMPlMVF0lztLwLwoa+YlT0szIJpYbNJwjxR8TF
         PVeQ==
X-Gm-Message-State: AAQBX9cdwnT0SXqi/3BLovthsYOitP7tyg1T9csnd+UXwwwuaVRo7VUa
        02kq8Er8pgF9VO1rIrRClDGS
X-Google-Smtp-Source: AKy350bYw6lveIf1IY+RNHk9PvVwwg/W1raVG/EJVR2Kpx7sN9E5bxdklS9snVGDgvFUOIFHVSMaKg==
X-Received: by 2002:a0d:cb86:0:b0:54f:8e9e:fed9 with SMTP id n128-20020a0dcb86000000b0054f8e9efed9mr1721679ywd.27.1681393387834;
        Thu, 13 Apr 2023 06:43:07 -0700 (PDT)
Received: from [192.168.1.110] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id bj2-20020a05690c044200b0054f83731ad2sm478178ywb.0.2023.04.13.06.43.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 06:43:07 -0700 (PDT)
Message-ID: <bdd76013-8cb8-ceaa-7ea0-55de3e1fbad4@github.com>
Date:   Thu, 13 Apr 2023 09:43:07 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: criteria for linking to binaries from git-scm.com?
Content-Language: en-US
To:     "brian m. carlson" <sandals@crustytoothpaste.net>,
        Jeff King <peff@peff.net>, git@vger.kernel.org
References: <20230412080019.GA2172825@coredump.intra.peff.net>
 <ZDdMKNJ/4njF0Jdp@tapette.crustytoothpaste.net>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <ZDdMKNJ/4njF0Jdp@tapette.crustytoothpaste.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/12/2023 8:26 PM, brian m. carlson wrote:
> On 2023-04-12 at 08:00:19, Jeff King wrote:
>> There's an interesting question raised in an issue in the git-scm.com
>> repo that I think would benefit from input from community folks here.
>>
>> The link is:
>>
>>   https://github.com/git/git-scm.com/issues/1774#issuecomment-1504829495
>>
>> but the tl;dr is:
>>
>>   From a supply chain perspective, what are our criteria for linking to
>>   a third party's pre-built binaries from git-scm.com?
> 
> I think we should ideally suggest distribution binaries where those are
> autobuilt and the distributor is complying with the license.  For macOS,
> Apple is providing their own binaries, and if people want more
> up-to-date versions, we could suggest Homebrew.  For Linux and BSD
> systems, that would be pointing people to their OS distributor.

And on this note, https://git-scm.com/download/mac lists

  Binary installer
  Tim Harper provides an installer for Git. The latest version is
  2.33.0, which was released over 1 year ago, on 2021-08-30.

Perhaps it is time to drop this reference?

Thanks,
-Stolee
