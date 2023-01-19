Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22CB9C46467
	for <git@archiver.kernel.org>; Thu, 19 Jan 2023 19:44:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230092AbjASToY (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 19 Jan 2023 14:44:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbjASToX (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 19 Jan 2023 14:44:23 -0500
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BAF924615E
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 11:44:19 -0800 (PST)
Received: by mail-pl1-x62a.google.com with SMTP id k18so3291306pll.5
        for <git@vger.kernel.org>; Thu, 19 Jan 2023 11:44:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dZ0prBE9w8sbNY1BVohqqv/Y/3jXB9KQQ+vMu9b86qY=;
        b=I/JFbaGmgNretyK9BOZnveD4AubaiEeVEG6sFj8rl1KXwLhK6oqwASzV1gVc56n091
         IVAcosi0TtAGslrnPwWCMkud/Mms8qVp+6PP15uKy8/wGSE5rSWXwt3MAruBVYnc744s
         EkSx2t9UzEMspw2Ybot44oJ1C0exezmNl6oEOKQpPCbeuAb2IKAUlppaU0QYYGH9C2yI
         t1AeMEWgpkjvI/dBdWfyYtCMHu2kvbwg+GIAQ1yI1MCLR58Yv+TparjgJ2e0gPlExpBd
         jE6Eunc2BIgA7CzayYhKrTV4Z1DmgLWc7F39S3QWjDpsPkZz3D/NhEKOiDV9TpYxTddt
         nRxA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dZ0prBE9w8sbNY1BVohqqv/Y/3jXB9KQQ+vMu9b86qY=;
        b=6p6mrM9sRpUUX9hzrajte1cu9OE42bCn95UYNOwA3zjcHeegaRbHcSFsmmODMQKkd6
         7gZTxBvWq6keq/SiGqoMVvkkpkArNHvamGC6eVnTmdmX7ZghyOt2u8e/qMEXeyBFC9pW
         5fvUjI9ErxyJdRU8et/gRsY9ygr3xBUt5Em7dErsNrJmmlmUI3gMZPwavAPSll/CRDLF
         lN4oyX6Qq8dRmo+Cv9bexr0kR9x4O0up6g/9LyAksvk6fGL7rAtLiyvDXDVDMTWjTZIe
         sTLUCMOUob88mcTIp2tsFP7LfU9r1ZkaasLvQSF9J4ZBHz00/kJEiEbDwSgUk1+wykKo
         ZLDw==
X-Gm-Message-State: AFqh2kpGrodTBa2S1mN67spu0W2671famRosliHKHwlK+fHOkiNwFD9K
        UO5+SAhlUmrzqLDkbVQVsBsEuADQEUicj8U=
X-Google-Smtp-Source: AMrXdXs6TE+L9J2ZYS8MBL4ams1MxHANP3f1L47IQMfVWpNuwq7DwHlxB1u5vPhH3uXHOdzUxe8A4Q==
X-Received: by 2002:a17:902:bb87:b0:194:7532:fb31 with SMTP id m7-20020a170902bb8700b001947532fb31mr12092891pls.62.1674157459301;
        Thu, 19 Jan 2023 11:44:19 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id ix22-20020a170902f81600b001743ba85d39sm25459244plb.110.2023.01.19.11.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 11:44:18 -0800 (PST)
Message-ID: <699c4d66-f159-c745-4287-a7815aa17189@github.com>
Date:   Thu, 19 Jan 2023 11:44:17 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH 6/8] bundle-uri: drop bundle.flag from design doc
Content-Language: en-US
To:     Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com, me@ttaylorr.com, avarab@gmail.com,
        steadmon@google.com, chooglen@google.com,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.1454.git.1673037405.gitgitgadget@gmail.com>
 <afcfd27a883d16009a2c55c3dcfb5ade07132b50.1673037405.git.gitgitgadget@gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <afcfd27a883d16009a2c55c3dcfb5ade07132b50.1673037405.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derrick Stolee via GitGitGadget wrote:
> From: Derrick Stolee <derrickstolee@github.com>
> 
> The Implementation Plan section lists a 'bundle.flag' option that is not
> documented anywhere else. What is documented elsewhere in the document
> and implemented by previous changes is the 'bundle.heuristic' config
> key. For now, a heuristic is required to indicate that a bundle list is
> organized for use during 'git fetch', and it is also sufficient for all
> existing designs.

Good catch, thanks for keeping the documentation consistent!

> 
> Signed-off-by: Derrick Stolee <derrickstolee@github.com>
> ---
>  Documentation/technical/bundle-uri.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/Documentation/technical/bundle-uri.txt b/Documentation/technical/bundle-uri.txt
> index b78d01d9adf..91d3a13e327 100644
> --- a/Documentation/technical/bundle-uri.txt
> +++ b/Documentation/technical/bundle-uri.txt
> @@ -479,14 +479,14 @@ outline for submitting these features:
>     (This choice is an opt-in via a config option and a command-line
>     option.)
>  
> -4. Allow the client to understand the `bundle.flag=forFetch` configuration
> +4. Allow the client to understand the `bundle.heuristic` configuration key
>     and the `bundle.<id>.creationToken` heuristic. When `git clone`
> -   discovers a bundle URI with `bundle.flag=forFetch`, it configures the
> -   client repository to check that bundle URI during later `git fetch <remote>`
> +   discovers a bundle URI with `bundle.heuristic`, it configures the client
> +   repository to check that bundle URI during later `git fetch <remote>`
>     commands.
>  
>  5. Allow clients to discover bundle URIs during `git fetch` and configure
> -   a bundle URI for later fetches if `bundle.flag=forFetch`.
> +   a bundle URI for later fetches if `bundle.heuristic` is set.
>  
>  6. Implement the "inspect headers" heuristic to reduce data downloads when
>     the `bundle.<id>.creationToken` heuristic is not available.

