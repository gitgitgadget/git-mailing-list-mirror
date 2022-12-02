Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30240C4332F
	for <git@archiver.kernel.org>; Fri,  2 Dec 2022 21:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233987AbiLBVRz (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Dec 2022 16:17:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbiLBVRw (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Dec 2022 16:17:52 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AF7813E09
        for <git@vger.kernel.org>; Fri,  2 Dec 2022 13:17:51 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id a14so1989724pfa.1
        for <git@vger.kernel.org>; Fri, 02 Dec 2022 13:17:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R8n13ZtbThK1XgFVbo7zmvP2/Wd+UuBHpwHAKJNWLAw=;
        b=AVFjTRVwQoXRGHymNJCEfd+Gxv+WbNI+tKrEIJcl/xxRexhqjIH3oFtoB/nFNk9fZ6
         3aZzBGPAorV5e6ZYNZWo/XViUPchyJcVISvAkYQ4EBJDrLEj89fuSPAirlK8HICG9YmU
         bhw6kydDCrTvyCdsgnMSTLBWFrJboM8gG+FcQteN8HSQQiI4eCGpHSqEq72Ky37wCbw0
         qzem0bJo5CTqjSQh2c6E/G+DuA09wZYJpwTmS60WpkfPGo8iWkrf0wxUmoFhFRacHX8Y
         6RBqXONFwatUR9ZqJQY+VX03x4dWY9oFMLZVUa/xeK56eAU/TMTvv7Lx/4L2byrz15X2
         rJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R8n13ZtbThK1XgFVbo7zmvP2/Wd+UuBHpwHAKJNWLAw=;
        b=NjhhVl9LcguTzoo49rqtl9LBoE2zb0az+0S23Tg728aBkJ7awa5l9rPM/0kbCxdBR9
         wDfh+3r1xRWbSiQir8ANaLEnBog+LRZrOBT6IZOexGCL3puRKtKtGw2nMy971h/HEhen
         MQgMwWTu+Uufo8O+5zTFNZQDJQxUylyk4p37fODODuVN5mqa8j02Ag6uVwb4XefjzpzB
         6dDWt19EQb8xyd869VJfm9T2TJYKAVUWXNkw7sUSsJCv44aMtDyrpKJmu+eYsumiT3fq
         rfgrUZJCo6b+zNqW+Oeb2eqQvL2ASBGgS58nrbhE6BegQP8VZOqPYKYO/zFQqK7mirwq
         y0qw==
X-Gm-Message-State: ANoB5pngXN4XPe2co0+tXMaERTeMvoe6zXIpWYs51QiG9EllrNOBU9MH
        8Xn6QxQ5wbiZeKeGYC/8BLIK
X-Google-Smtp-Source: AA0mqf5Rp4lWTzshdHbbzJ/vWYu563mz+KZEaSCU2JNlIVLRIdKtm8aOSU1zAKxq7wxY6uNk9Vqj1g==
X-Received: by 2002:a05:6a00:2c87:b0:562:e790:dfe0 with SMTP id ef7-20020a056a002c8700b00562e790dfe0mr74593719pfb.16.1670015871028;
        Fri, 02 Dec 2022 13:17:51 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id c11-20020a170903234b00b00186c3afb49esm5929284plh.209.2022.12.02.13.17.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 13:17:50 -0800 (PST)
Message-ID: <1b090929-f2da-f075-01d4-458804fc0717@github.com>
Date:   Fri, 2 Dec 2022 13:17:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.5.0
Subject: Re: [PATCH] fsmonitor: eliminate call to deprecated FSEventStream
 function
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Cc:     Jeff Hostetler <git@jeffhostetler.com>,
        Jeff Hostetler via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Stefan Sundin <git@stefansundin.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff Hostetler <jeffhostetler@github.com>,
        Eric DeCosta <edecosta@mathworks.com>
References: <pull.1436.git.1669991072393.gitgitgadget@gmail.com>
 <221202.86o7slfzot.gmgdl@evledraar.gmail.com>
 <3e2bd865-3ca5-b0f7-095e-f8b97ec8822c@jeffhostetler.com>
 <221202.867cz9fwnf.gmgdl@evledraar.gmail.com>
 <4711d955-02b2-f599-7f89-b442dd0b6215@github.com>
 <221202.86359xfs5c.gmgdl@evledraar.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <221202.86359xfs5c.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason wrote:
> Anyway, that larger topic aside. All I'm suggesting here is that the
> proposed patch seems to at least soft-deprecate versions of OSX we
> supported before. Maybe that's fine, but the commit message didn't get
> across whether that was considered, part of the plan etc.

...

> But git gets ported and backported to a long tail of systems way beyond
> that. Eventually we do need to let got, but we've generally drawn the
> line at some fuzzy notion of when users don't care anymore, along with
> whether it's worth the effort to find out.

My point is that such a user for this scenario is so unlikely to exist that
holding up this patch - which provides a real, tangible benefit to
developers *right now* - to implement your suggestion or modify the commit
message is, at best, an unnecessary distraction.

If, somewhere, there is a user that 1) keeps up-to-date with the latest
version of Git, 2) uses FSMonitor, and 3) is working on the sole version of
MacOS that was theoretically compatible with FSMonitor before this change
but now is not, we can accommodate that once such a need is shown to exist.

