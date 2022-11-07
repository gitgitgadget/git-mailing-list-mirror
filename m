Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87766C4332F
	for <git@archiver.kernel.org>; Mon,  7 Nov 2022 19:23:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbiKGTXm (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 7 Nov 2022 14:23:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232313AbiKGTXj (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 7 Nov 2022 14:23:39 -0500
Received: from mail-qt1-x831.google.com (mail-qt1-x831.google.com [IPv6:2607:f8b0:4864:20::831])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD12610FE1
        for <git@vger.kernel.org>; Mon,  7 Nov 2022 11:23:38 -0800 (PST)
Received: by mail-qt1-x831.google.com with SMTP id z6so7483921qtv.5
        for <git@vger.kernel.org>; Mon, 07 Nov 2022 11:23:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9f61kLguaPGBqBiJzsQvFkrEejA8CUGixQ/Yb+s9Grs=;
        b=UPCrFEtdrc8PGA4DzI8qFFfRYR05vlbwN+6oPLQJPI2CN8WYll+iSO5yiyVpiEqJP2
         pDJ+xcY8RX/ABw/9OC0H5Yvbvcd5US+b0amzbEvv9seZWlomhHqLvGBjRdJ9HPf4sBPg
         FWR1QHpMUSVVOviNqdqmyl+F/mqQeWJL5rbyNbrjQY4kim4cJNZS+FW9AUihOEwxKPyI
         Q2V1Ws3HFrVprioRvVJqNyNOl++LmVbpzdHWPBoy1T8TB9u7aASwlzbeBw0YQjw1wqc5
         yPbcsutTi3Y9Hmr9sCtlbU9RYdl5bhR+j84c9/hnG3NOvyZfNdCq3eMautti81Jv25of
         FQyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9f61kLguaPGBqBiJzsQvFkrEejA8CUGixQ/Yb+s9Grs=;
        b=jJlNLOViOsQBOYWa5gDyNUYHJJPCjPVwATWI/g7Vmotb0+4yZyoshVVasxuEQSYp8f
         U45m4ZVNOEkaQZSwkD3uvs+K3SvKceaKmqLNypkZO/sVFgKxvhi0GVRAXWWwXizi2+yQ
         eP49l023DdVB37oWP7DQFkCZFQubRYl3TCf0MJ0PGc8SGbF8C1BD2dF6hC9NiZNl/Zg2
         fWfkrJvkSHjvAWzLUyZO7/BQLqRgkjeOv1cVIXM02Cmt9nKl/zb4NZIZicB6pcJSnqZ7
         2yZ70wk7amP6tuSv3bbVYxTuhiScOcjUMOHgzAn7JbLmha1mwxlI4qQg3v0+yEAUvWLc
         1cfw==
X-Gm-Message-State: ACrzQf3RRCCyEV+Tdm74ZztF8VSSNqdxJXQ/aR3CVqRPvdOQ40oL8Fr2
        PsZr/wjQ1NMpqDBEWwQeMwrtjZEITQpX
X-Google-Smtp-Source: AMsMyM7YiW2tmXw6PTc44eIhSjN9ic3JatDuWitFdgAQdLbXXaiakhysCEOR8Nrzqi0kjM23hn36YA==
X-Received: by 2002:ac8:5fcd:0:b0:3a5:62d3:bcc6 with SMTP id k13-20020ac85fcd000000b003a562d3bcc6mr15200578qta.130.1667849017861;
        Mon, 07 Nov 2022 11:23:37 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:d948:f30c:63de:b667? ([2600:1700:e72:80a0:d948:f30c:63de:b667])
        by smtp.gmail.com with ESMTPSA id ey26-20020a05622a4c1a00b003a4ec43f2b5sm6572056qtb.72.2022.11.07.11.23.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 11:23:37 -0800 (PST)
Message-ID: <b6068839-f4aa-3f79-192c-07e3bdfb6afb@github.com>
Date:   Mon, 7 Nov 2022 14:23:36 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.1
Subject: Re: [PATCH v3 00/11] Enhance credential helper protocol to include
 auth headers
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Lessley Dennington <lessleydennington@gmail.com>,
        Matthew John Cheetham <mjcheetham@outlook.com>,
        M Hickford <mirth.hickford@gmail.com>,
        Jeff Hostetler <git@jeffhostetler.com>,
        Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.v2.git.1666372083.gitgitgadget@gmail.com>
 <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1352.v3.git.1667426969.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/2/22 6:09 PM, Matthew John Cheetham via GitGitGadget wrote:
> Following from my original RFC submission [0], this submission is considered
> ready for full review. This patch series is now based on top of current
> master (9c32cfb49c60fa8173b9666db02efe3b45a8522f) that includes my now
> separately submitted patches [1] to fix up the other credential helpers'
> behaviour.

> Updates in v3
> =============
> 
>  * Split final patch that added the test-http-server in to several, easier
>    to review patches.
> 
>  * Updated wording in git-credential.txt to clarify which side of the
>    credential helper protocol is sending/receiving the new wwwauth and
>    authtype attributes.

You also updated some commit messages based on v2 feedback. Thanks!

The commit splitting you did in this version is greatly appreciated.
I found this version to be in good shape. It's a solid foundation to
build upon (if any future work is necessary).

Thanks,
-Stolee
