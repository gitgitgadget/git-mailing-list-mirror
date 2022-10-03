Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51D87C433FE
	for <git@archiver.kernel.org>; Mon,  3 Oct 2022 13:07:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJCNHl (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 3 Oct 2022 09:07:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229446AbiJCNHj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 3 Oct 2022 09:07:39 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF38E31EC4
        for <git@vger.kernel.org>; Mon,  3 Oct 2022 06:07:38 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id e11-20020a17090a77cb00b00205edbfd646so15262342pjs.1
        for <git@vger.kernel.org>; Mon, 03 Oct 2022 06:07:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=SdDy0hQPU/ODc0S8y4JrE3dtFFfapnmDg7IeDkvhQyo=;
        b=hyxK+Y/QiZvdTQEW/pHPMEvqc7uLyc9f0bXnfecWjjBuKBrgpINVBpM4fl+UA4g8FW
         Zx2boF0ST45LQ0kYqeU4SHc9srQGvYKJqmB88GEyNAhNt+PLEXl4h2QVbeFaJN8z9YUJ
         TSwGlM4P+DI+k7vQn/LAlDGXkuKf9XY1MUIo9V1IP4gIuxl7McJNZ9/4eqw4YapPVHyj
         2McVwMYWpY9EZ//Cfl355znrMW+//OKrwoJy6BwORLkTB64XNWiGqPw8nO8tkORV452Z
         xD539XFIcHNEIE2BtDcl1UBBHN5bD0FKKRDUuInhLxMwDwxBp1mKHALIog01KCRnqb2i
         ehmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=SdDy0hQPU/ODc0S8y4JrE3dtFFfapnmDg7IeDkvhQyo=;
        b=xjVprvffoxWi9c7xz8U6lwqEqUVmzU2Ex4Jzofr27GDo5+bgtzhYiAAGeoaD2e/Ue+
         1rHD1hrEcy7SDfStEQ0m3oM/PjA53YyGnYQ2/ks43i1enDKqHjRgKIaRRmL21b3gr37F
         VcjUJDQ+CLpxfO0bTZvlSP//PEdWqaOwWJU4nQ4umyYh3fu3aTQtaM0wwgveiKcDfshs
         noNHqhKu4f0p6a7szvMRehs2wMNPE9pAbh0Eb2I9lwR+xNso6CRTxEfXqDtFdvTDiXg5
         wU8oVQ4kUyGLdMoU5aC6ZESrSaPE35JnpOUYnCtRVbNmHoZwpjv10ZiQF6BlLZp+5KL0
         keEw==
X-Gm-Message-State: ACrzQf2k9jBgfBs7k40mZ87PqzHXwzfqK785ruciaPlGKCqVwZLchRyP
        bNzHYp+zwA70A+q106GZThY=
X-Google-Smtp-Source: AMsMyM49WtWZc0uACKZh6Upcn3DKzDvm92rtd4gQ+dz9RCt2GVWOWlco9b1f7k3TFIc/1yL11J8y/Q==
X-Received: by 2002:a17:903:2286:b0:178:349b:d21c with SMTP id b6-20020a170903228600b00178349bd21cmr21985669plh.71.1664802458388;
        Mon, 03 Oct 2022 06:07:38 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-71.three.co.id. [223.255.225.71])
        by smtp.gmail.com with ESMTPSA id j16-20020a170902da9000b00176c6738d13sm7201817plx.169.2022.10.03.06.07.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 06:07:37 -0700 (PDT)
Message-ID: <da2c8d2f-eefa-1681-b1f2-93c7865c300c@gmail.com>
Date:   Mon, 3 Oct 2022 20:07:33 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] git-reflog.txt: add an EXAMPLES section
Content-Language: en-US
To:     Elia Pinto <gitter.spiros@gmail.com>, git@vger.kernel.org
References: <20221003084654.183966-1-gitter.spiros@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20221003084654.183966-1-gitter.spiros@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/3/22 15:46, Elia Pinto wrote:
> This commit adds an "EXAMPLES" section to the git reflog man page.
> This new section currently provides examples of using git reflog
> with branches, for which doubts often exist. In this commit we also
> add a "SEE ALSO" section which refers to further information
> on git commands or documentation referenced in the git reflog man page.
> 

Better say "Add git-reflog usage examples to the man page."
Also, shouldn't "SEE ALSO" additions be split from this patch?

-- 
An old man doll... just what I always wanted! - Clara
