Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82D07C6FA90
	for <git@archiver.kernel.org>; Tue, 27 Sep 2022 09:20:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbiI0JUM (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 27 Sep 2022 05:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231822AbiI0JTw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2022 05:19:52 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C9DACF4A8
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 02:18:48 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id t14so13983538wrx.8
        for <git@vger.kernel.org>; Tue, 27 Sep 2022 02:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date;
        bh=NAXJfeY/lcbLr986IN3dKMS48fjBQPWDKDLjGpjx+gc=;
        b=o9LCqoQrUWFNxMAtEnd7d5RRNMSVdxBjTlWo9QUDpN9TlwZoNr8v7UjNLebEzkBgbH
         VYBuVA6PqpUl2vxqa/IFjf2Zg5uvUe9SafuoU41k26CUn8gVPiwhMJpkDX90cRm49Yxm
         E0Sz345jHgrXIlCE//ZQlpIr3nk91zD25bfbIIdy9f36fyd6GWHNMrop2xzgpavDikvB
         uYUJV0kVpnCQ3lc4zRj9JFwWnGF0CXaSLy1F06a/TYvqDeUKWeKhYHSm3bG/6cW/kEzL
         oxmvW2s/7fqW6Z7Oo375hEoLZzculTMI1Ch3xXL4QWM4C3RydvXJwgrBOqliAW9m7lKC
         s5GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date;
        bh=NAXJfeY/lcbLr986IN3dKMS48fjBQPWDKDLjGpjx+gc=;
        b=xGeIqxTRqo2gxw1dfE9KIYWGKQ9KS+N7ccKY5XSrVJiTNlOvNawUzKX2z7QhIrcyz0
         /UdTrSK7s6alZVvbu26bfU/34LYtLiso2xuc9Enf5BxNSVfBRHhIKTAJKaRRCZ+vRJTL
         Vm+2RdRCvB+ywvA7Fo4wGXbNEgjCngHBRyNcu+/6HbmyFHf/wT1+1LiHzjKEvEZsR85o
         41P5iWzWeiV+V5OwaiBcrwbwKwW/AxWBYCAqVpq+fR2F6zOeYngQoS8eBCuQgShGRBDU
         pSIovHSWzEDYl3TPp8ymEVSbVMWdhCz+hGo54YGY4YIJc5rogpTpOk5YHr0bfi9uvB/3
         leXg==
X-Gm-Message-State: ACrzQf2eXwect8KkqexHWsWcLNImvyxx9dlwece261KUqCUVU/7vfrSN
        5N2/H6rLrjqrPnJVUXGf2WnHU6nANE+ceg==
X-Google-Smtp-Source: AMsMyM4oWkz/h308QGLQqsZuq/v5Sg0VfqiGG7H9g8nbDlrG9F8szLm2ek+QuFj7U79U/JW5wjpgqQ==
X-Received: by 2002:a5d:59c3:0:b0:22a:4463:5a3a with SMTP id v3-20020a5d59c3000000b0022a44635a3amr15485652wry.123.1664270316130;
        Tue, 27 Sep 2022 02:18:36 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id e4-20020a05600c4e4400b003a682354f63sm13929356wmq.11.2022.09.27.02.18.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 02:18:35 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <99c45b89-364f-4f77-7c1b-26231cc7455e@dunelm.org.uk>
Date:   Tue, 27 Sep 2022 10:18:32 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] tmp-objdir: do not opendir() when handling a signal
Content-Language: en-US
To:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     John Cai <johncai86@gmail.com>
References: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com>
In-Reply-To: <pull.1348.git.git.1664236383785.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi John

On 27/09/2022 00:53, John Cai via GitGitGadget wrote:
> From: John Cai <johncai86@gmail.com>
> 
> In the tmp-objdir api, tmp_objdir_create will create a temporary
> directory but also register signal handlers responsible for removing
> the directory's contents and the directory itself. However, the
> function responsible for recursively removing the contents and
> directory, remove_dir_recurse() calls opendir(3) and closedir(3).
> This can be problematic because these functions allocate and free
> memory, which are not async-signal-safe functions. This can lead to
> deadlocks.

> --- a/dir.h
> +++ b/dir.h
> @@ -498,6 +498,9 @@ int get_sparse_checkout_patterns(struct pattern_list *pl);
>   /* Remove the_original_cwd too */
>   #define REMOVE_DIR_PURGE_ORIGINAL_CWD 0x08
>   
> +/* Indicates a signal is being handled */
> +#define REMOVE_DIR_SIGNAL 0x16

This is setting the bits for REMOVE_DIR_KEEP_NESTED_GIT and 
REMOVE_DIR_KEEP_TOPLEVEL is that intentional? (it looks like you've 
doubled 8 to 16 to get the next free bit but used a hex constant, the 
earlier constants use decimal)

Best Wishes

Phillip
