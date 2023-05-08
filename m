Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C2B5C77B7F
	for <git@archiver.kernel.org>; Mon,  8 May 2023 19:41:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233394AbjEHTlM (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 8 May 2023 15:41:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEHTlK (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 8 May 2023 15:41:10 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A82459EA
        for <git@vger.kernel.org>; Mon,  8 May 2023 12:41:07 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id d9443c01a7336-1aaf21bb427so35369865ad.1
        for <git@vger.kernel.org>; Mon, 08 May 2023 12:41:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683574867; x=1686166867;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=g3ulkEldZw54AX6Ye5oY5fJmLNNTVI3fsv8G+QQzZdY=;
        b=rIfdQTfy9TWMtnroQozJQa4iEAQo94BCzVmKpkBba/i3Xbgu8ov5Y0ZNiyTTfFon95
         FTew+MmAZwuj82yprgCGObXFJhYKHuxWj9gU68HdY0olwPxDjGWVwfP+a5L872rObWZk
         yf669M02q+ePXFLeDWjtURpFoHn3di8giBcdL5wfl+E9PBw7+/30se87eW3z5HuXWdJV
         iXC9FcEIbmrqkxQAB4DqO4eXSZXYlmrjatwCKircliFxsrcAbUTWzfQ1tslpmWe7qToj
         FqLrqA5pmCrX+HFKwQkSnwF3XHxjjDe24Gak3qyACFnn3udrlT4HX2Q/jA8u6qg+yfEx
         9B1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683574867; x=1686166867;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=g3ulkEldZw54AX6Ye5oY5fJmLNNTVI3fsv8G+QQzZdY=;
        b=XeAq33w3xlNENqqD8sCOSUSYR0NxJCxXdqKnnxja4+sjJYPnH4LI2rBs2JLR+bN7o1
         hAMnYqPK5QjGzZ8z2C38ze1RWclInkDe+kn+Ev+u31FcT/wn8Wy/dbPYt21Kc9RoTOyo
         M1CStQ2okL1wrbnwe3EkHQOeGTUeQcih5ve6E4hSQy3jVlzF4zvTR4Vo7e/9re1Chh2D
         5s2LZeUpsLUjnQzJtscAA4Hq2ojRsrOMMMvITD7/t4/OjD3e4SqBpTAQFU1eGRUFgxQp
         oSALfDL2JPSy6lN189+yDi49uvD6OgwDmW1hy5JodqVyOHwDx1DSMjQHU8zgiMhZD2Gj
         Y9Qg==
X-Gm-Message-State: AC+VfDwtba7pj4fND6tncYsOmjRVgWshtE/3yO3hI2vWiYMQaXtaWcd/
        8Q/s7Fro/ow5jOWGO6FwAJA=
X-Google-Smtp-Source: ACHHUZ6/EAj2Mvo466xeSa9pm1p/QeuDQq6IA7Bg1+7/Vjeo8OECeob03MduadlhYY7DJrYzJdu+KA==
X-Received: by 2002:a17:903:185:b0:1aa:db0f:1aba with SMTP id z5-20020a170903018500b001aadb0f1abamr14222942plg.47.1683574866751;
        Mon, 08 May 2023 12:41:06 -0700 (PDT)
Received: from localhost (187.137.203.35.bc.googleusercontent.com. [35.203.137.187])
        by smtp.gmail.com with ESMTPSA id y4-20020a170902b48400b001aaf83873dbsm7609518plr.162.2023.05.08.12.41.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 May 2023 12:41:06 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     "Linus Arver via GitGitGadget" <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Linus Arver <linusa@google.com>
Subject: Re: [PATCH 06/11] doc: trailer: trailer.<token>.cmd: add missing
 verb phrase
References: <pull.1506.git.git.1683566870.gitgitgadget@gmail.com>
        <8e36d1bd1f0c8ca6b1210a537f4bb8403fab7c47.1683566870.git.gitgitgadget@gmail.com>
Date:   Mon, 08 May 2023 12:41:06 -0700
In-Reply-To: <8e36d1bd1f0c8ca6b1210a537f4bb8403fab7c47.1683566870.git.gitgitgadget@gmail.com>
        (Linus Arver via GitGitGadget's message of "Mon, 08 May 2023 17:27:45
        +0000")
Message-ID: <xmqq1qjqobl9.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

"Linus Arver via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Linus Arver <linusa@google.com>
>
> The phrase "is specified" is implied. Make it explicit.

Makes sense.  Calling it "implied" is generous ;-)  Isn't the
original just outright ungrammatical?

>
> Signed-off-by: Linus Arver <linusa@google.com>
> ---
>  Documentation/git-interpret-trailers.txt | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/Documentation/git-interpret-trailers.txt b/Documentation/git-interpret-trailers.txt
> index e80a9cd161b..c4675d9d3bb 100644
> --- a/Documentation/git-interpret-trailers.txt
> +++ b/Documentation/git-interpret-trailers.txt
> @@ -248,10 +248,10 @@ for the same <token>, 'trailer.<token>.cmd' is used and
>  'trailer.<token>.command' is ignored.
>  
>  trailer.<token>.cmd::
> -	This option can be used to specify a shell command that will be called:
> -	once to automatically add a trailer with the specified <token>, and then
> -	each time a '--trailer <token>=<value>' argument to modify the <value> of
> -	the trailer that this option would produce.
> +	This option can be used to specify a shell command that will be called once
> +	to automatically add a trailer with the specified <token>, and then called
> +	each time a '--trailer <token>=<value>' argument is specified to modify the
> +	<value> of the trailer that this option would produce.
>  +
>  When the specified command is first called to add a trailer
>  with the specified <token>, the behavior is as if a special
