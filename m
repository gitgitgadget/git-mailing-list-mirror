Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D085BC6FA82
	for <git@archiver.kernel.org>; Mon, 19 Sep 2022 23:36:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbiISXge (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 19 Sep 2022 19:36:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbiISXgc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 19 Sep 2022 19:36:32 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A845C237C0
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 16:36:30 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id h194so902326iof.4
        for <git@vger.kernel.org>; Mon, 19 Sep 2022 16:36:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=cH/tdDpu+wVcrcx0lzwZ17W/y3DZ+lCbhk6hVDnwsi8=;
        b=Vl5FgfcOUubASBdaPzhgWUHpWQyPCUE+ndNvDzOWDXJGR8TZWlCy8XXjj/G5BN0nyq
         nsWNfykK15tKU5w4KFmGM5JF35nFH7GYO2MDvKUH0gCSI0xI1K3LocMPBHjH/Im3yA8z
         iXNLlwzxKmg6sDW3HSZEgBUWX5f+En6kO7QSgQi1iStL80VbqMt+EjuVlYfJqo2YPijF
         9Qj8SXGvIM0VmEKG3/tZs+1++hM+BPK1pqIp7jJqFUJRuaZTaycLwoc8E1+FoXfE0gIk
         l09w3o9lWMbQOgOV3rJsOv//pB+4FGjccE0AvLEWd4eNgpKtNQ2INj66gpSyEx2T+SfF
         1bXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=cH/tdDpu+wVcrcx0lzwZ17W/y3DZ+lCbhk6hVDnwsi8=;
        b=MdYwIHUbWPkYbk4IUwNfqo7gRo5eIA4Mebz4YYA6DbAlT/KU9V5jiNHqtuIZmyrpZU
         70mnsXMxRQO2yhazEvmxWsJ49ZV5T50v+927GBRfgkQQMqMlQ8q0k3SNrFa9CKwESQok
         KlyXwQDlmMRPTXFzHbvbfzxr+FXhurfcCDLpxYT4C+tYmxzzlFtdKJrAnYj3g5xiegNS
         mgv9eQn4cICZFBRHwT3GkJZlTloXuD6I5zuIclYCY7ut5RBqlPwCOaxkoCYVjJzz/X4G
         6mea8O+RoXTgwabcM9zULIJtl1kWpmZanPgp/3clC45VPHkQJw3e+AMnqUWS9GIHOZLv
         CTOw==
X-Gm-Message-State: ACrzQf1YDsP0q2D5+uUtgV8w4py7zOCrCqx0k2GrbZAW7JAMJiYZDViv
        C/cR3iMru4EHXitG4q0gzBs=
X-Google-Smtp-Source: AA6agR5P9qp7U+bc3oaqH9Gk30K6bMXeWi1wHDQvoxAmxtSolUF+8tHGvl3UFzVe1zDqfjtk4SK1Dw==
X-Received: by 2002:a05:6638:140a:b0:35a:79fd:d4d9 with SMTP id k10-20020a056638140a00b0035a79fdd4d9mr9326156jad.135.1663630589813;
        Mon, 19 Sep 2022 16:36:29 -0700 (PDT)
Received: from [192.168.86.205] (097-087-102-211.res.spectrum.com. [97.87.102.211])
        by smtp.gmail.com with ESMTPSA id v41-20020a05663835a900b0035a154dbd4fsm33781jal.22.2022.09.19.16.36.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 16:36:29 -0700 (PDT)
Message-ID: <04a08e67-9043-ad15-c9aa-4ecf4ddaf92a@gmail.com>
Date:   Mon, 19 Sep 2022 16:36:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH 0/8] [RFC] Enhance credential helper protocol to include
 auth headers
Content-Language: en-US
To:     Matthew John Cheetham via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Matthew John Cheetham <mjcheetham@github.com>
References: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
From:   Lessley Dennington <lessleydennington@gmail.com>
In-Reply-To: <pull.1352.git.1663097156.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

This is a really exciting idea! Based on your patches, it seems to be a
great opportunity to add extensibility and flexibility to the credential
helper model without huge disruptions to the codebase. Well done!

On 9/13/22 12:25 PM, Matthew John Cheetham via GitGitGadget wrote:
>   3. Teach Git to specify authentication schemes other than Basic in
>      subsequent HTTP requests based on credential helper responses.
> 
This!! Yes!!
> 
> ...
> wwwauth=Bearer realm="login.example", scope="git.readwrite", Basic realm="login.example"
> 
I think sending the fields individually (as you describe in this doc and
implement in your patches) is the right call. In my opinion, it's more
legible, consistent with the remote response, and aligns with your goal of
minimizing authentication-related actions in Git.

Best,

Lessley
