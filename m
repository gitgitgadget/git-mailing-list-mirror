Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC48AC433F5
	for <git@archiver.kernel.org>; Fri,  7 Oct 2022 15:17:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230059AbiJGPRk (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 7 Oct 2022 11:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbiJGPRh (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 7 Oct 2022 11:17:37 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 81DFF9C2DB
        for <git@vger.kernel.org>; Fri,  7 Oct 2022 08:17:36 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id n35-20020a05600c502300b003b4924c6868so4593322wmr.1
        for <git@vger.kernel.org>; Fri, 07 Oct 2022 08:17:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=xWTfmSty2y6xHDpsLaOCMHmZ5jsfnfE05bJOhNDjW3s=;
        b=nTU7WaNQ8l/kv9f/aLriJw2m16TpUKJpNz8szXsAGkFGo3fvfpc5FgeMQn5tRmwLXC
         i0WPOusAnbC6WGP2c/gBhRSx1T2kV4tQ6qpT7CA1veU+UI3mB8EZICI/hfVZHQAqZCqB
         55Hi/flLdDSV1/zxD69YB3GFGO3XAe5nB4LXCCIn1zV6ShDl6yqBW2x3UaA+3m4IfNid
         OKG4JpJjFfB00dxzRs86zMXMLmZbtGeHchwOcG0Jl1bKDww9hl/jOdal9z3nEDqjX5X/
         CUS7RvnsZQCIPEw1KlaGw0lNzbU+8BJ1t+KQ8/jPXAoh5Ux5dY+CR39+Db4f4S6F9ysF
         VXRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xWTfmSty2y6xHDpsLaOCMHmZ5jsfnfE05bJOhNDjW3s=;
        b=2ltzB4mGybr3roTc+9oSVkLmbKGX0HUHfkz3gRCP43B3yfFveWjqeG2Jk2G0uZDto3
         fMGq7UDkAFYQG7rrQPS/6q6e1fk5Yxa5Q5DATVPquk0sd70npWadagGhRHYmo0Di8xqe
         QpTZNbnhPkpqUDgDz75OZ+NXj+pARaeq8vYiddbH+kTYQUh25DTPSoiBs2fv24UrCtO4
         9NIvDxP2B02fRoLGPGMB5ZiAruKRzsDs1c3zcNeSo0T6KhjUFOPxKp8oVpQ8Lbw0jGMi
         VT6mxBBZVTTuW1CiLulzu+RFIzSbs5Tx//YmPfc857cds1HwGaBhfP/gL/MnJ+bdgE6D
         4EoQ==
X-Gm-Message-State: ACrzQf1/jjvbJ3ztOqsjkmXC0Rz316khGa0/15fgmnwsCUEzzDrlppY4
        Kr28veUmGTBhUE/Qx756Ijc=
X-Google-Smtp-Source: AMsMyM6riBOMgKKGSi8AB+o2Vsxj4M5O/MrT874u3t8GIdyaJ0xZ3i8ElKJj6E9L4J5k3NkjuNLqjw==
X-Received: by 2002:a7b:cb91:0:b0:3b4:75b9:5a4b with SMTP id m17-20020a7bcb91000000b003b475b95a4bmr3572672wmi.33.1665155855033;
        Fri, 07 Oct 2022 08:17:35 -0700 (PDT)
Received: from [192.168.1.74] ([31.185.185.144])
        by smtp.gmail.com with ESMTPSA id w9-20020a5d6809000000b0022aeba020casm2303600wru.83.2022.10.07.08.17.34
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 08:17:34 -0700 (PDT)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <69d57d56-2b74-5ee0-a279-de5eb10df7bf@dunelm.org.uk>
Date:   Fri, 7 Oct 2022 16:17:33 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 1/2] git-p4: minor optimization in read_pip_lines
Content-Language: en-US
To:     Daniel Sonbolian via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Daniel Sonbolian <dsal3389@gmail.com>
References: <pull.1355.git.git.1665056747.gitgitgadget@gmail.com>
 <pull.1355.v2.git.git.1665153486.gitgitgadget@gmail.com>
 <dd81a2cadec3e3f131d7b573bf110d4b6cc8f40d.1665153486.git.gitgitgadget@gmail.com>
In-Reply-To: <dd81a2cadec3e3f131d7b573bf110d4b6cc8f40d.1665153486.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Daniel

On 07/10/2022 15:38, Daniel Sonbolian via GitGitGadget wrote:
> From: Daniel Sonbolian <dsal3389@gmail.com>
> 
> checking for an error condition before reading and/or decoding
> lines from the pip stream to avoid unnecessary computation

It would be helpful to say a little more about what the error is you're 
detecting why it is better to detect it earlier. Having looked at the 
changes I'm not really sure what these changes are trying to improve

> Signed-off-by: Daniel Sonbolian <dsal3389@gmail.com>
> ---
>   git-p4.py | 10 +++++++---
>   1 file changed, 7 insertions(+), 3 deletions(-)
> 
> diff --git a/git-p4.py b/git-p4.py
> index d26a980e5ac..097272a5543 100755
> --- a/git-p4.py
> +++ b/git-p4.py
> @@ -399,11 +399,15 @@ def read_pipe_lines(c, raw=False, *k, **kw):
>   
>       p = subprocess.Popen(c, stdout=subprocess.PIPE, *k, **kw)
>       pipe = p.stdout
> +
> +    if p.wait():
> +        die('Command failed: {}'.format(' '.join(c)))

I'm not a python programmer, but the documentation for Popen.wait() says 
that this will wait for the process to finish, so I think calling it 
before reading the lines below is an error.

>       lines = pipe.readlines()
> +    pipe.close()

You're now ignoring the return value of pipe.close() - is that safe?

> +
>       if not raw:
> -        lines = [decode_text_stream(line) for line in lines]
> -    if pipe.close() or p.wait():
> -        die('Command failed: {}'.format(' '.join(c)))
> +        return [decode_text_stream(line) for line in lines]
>       return lines

I'm not really sure what you're tying to achieve here - what was wrong 
with the original code?

Best Wishes

Phillip

