Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.2 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD717C2B9F4
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 00:42:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A63FE6194B
	for <git@archiver.kernel.org>; Sat, 26 Jun 2021 00:42:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbhFZAoe (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 25 Jun 2021 20:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbhFZAoe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 25 Jun 2021 20:44:34 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B08B8C061574
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 17:42:12 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id m15-20020a17090a5a4fb029016f385ffad0so6542356pji.0
        for <git@vger.kernel.org>; Fri, 25 Jun 2021 17:42:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=KRw/j+1AYbecrM728masS+HftmN+gyfvQctshoDsnx8=;
        b=JS3Xn9R/MZ7sg/hguKveZIp9RV27cs8Wv6yopa+/q3OlTUD0suUA1rc/3l4enGllfZ
         okbyuTzmlk8uqgsbRFb6QmSAi2glCYR5pgP7EccqnR1IA9LojFN7+qHY71TR7N0spvWm
         SQh4LbVsYsVF0pLckyTAMfcJI9e3rZOZw7PKB+T43Jl67owSvtSRAlJ09wzmL0qOQllo
         Lbf3HOej/lXOeT47MaG/Kf3Nbim00Kr7VUcfVGjnV2MTjXQjdqsnKkVxfinz40Z32ntQ
         QYjQlhHT2mpgAg3mTiXqW1s4dHnhSGOhm2rLxDlqjBs9Jw9gQlEFTvMydME08CNecV2b
         cPTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=KRw/j+1AYbecrM728masS+HftmN+gyfvQctshoDsnx8=;
        b=Ztb1LJ+G0GdznUgQgUBxEXDmOeXOsEIh3aSNY/aBLX2HNyFEdU+BAT4+CxSQqJ9V0J
         eisdvgDdEipCzv5fhsTXQTp9Pzr8aGlNWoPuNRzYoiOerJwT2XE6ROq9+fvNE4jnCHMA
         dhxgT7p2Rl2YpvDw5mUO1Z/VO8U4ffQZ2Y4SecmITgi6WJJVRnE058NKH8GGsz8r7hO+
         RyBBopNuvXK40v8B2EVVTF51damtO/Js9Fym5098/jbE8hMD/orHWIu7eqn9r8OLGW1S
         GGB6/qfV8UMWNpO8il+toUOeIOIwv7utycB4w1Pm5o9BKWPEUveiLxZLGHJ9al7gVKtu
         RxSA==
X-Gm-Message-State: AOAM530yziIy+WZrxTvMymjd9iNZ5b6MPrcspDKe6SiyP+Nk9/zrzMwd
        A9nUxZZQ2mc31DFXb4jQa5M=
X-Google-Smtp-Source: ABdhPJzrEa0/nWhJ26TzWTaV/iloB4894Y/iYACAmWaWmBPHVqoSuISwNYMTOCl3VjTGRhA4YOiwow==
X-Received: by 2002:a17:902:bd03:b029:11c:d504:c1ce with SMTP id p3-20020a170902bd03b029011cd504c1cemr11459896pls.7.1624668132237;
        Fri, 25 Jun 2021 17:42:12 -0700 (PDT)
Received: from [192.168.43.80] (subs09a-223-255-225-78.three.co.id. [223.255.225.78])
        by smtp.gmail.com with ESMTPSA id t18sm6554817pgv.51.2021.06.25.17.42.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Jun 2021 17:42:11 -0700 (PDT)
Subject: Re: [PATCH v5 02/15] [GSOC] ref-filter: add %(raw) atom
To:     ZheNing Hu via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Christian Couder <christian.couder@gmail.com>,
        Hariom Verma <hariom18599@gmail.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        ZheNing Hu <adlternative@gmail.com>
References: <pull.980.v4.git.1624332054.gitgitgadget@gmail.com>
 <pull.980.v5.git.1624636945.gitgitgadget@gmail.com>
 <4e473838b9d2651a8e4be27332697c2ba354db5a.1624636945.git.gitgitgadget@gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
Message-ID: <946c95bc-d57a-5b55-0dcf-5c4d6f980396@gmail.com>
Date:   Sat, 26 Jun 2021 07:42:07 +0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.11.0
MIME-Version: 1.0
In-Reply-To: <4e473838b9d2651a8e4be27332697c2ba354db5a.1624636945.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/06/21 23.02, ZheNing Hu via GitGitGadget wrote:
> Note that `--format=%(raw)` cannot be used with `--python`, `--shell`,
> `--tcl`, and `--perl` because if the binary raw data is passed to a
> variable in such languages, these may not support arbitrary binary data
> in their string variable type.
> 

Commit message looks OK, but...

> +Note that `--format=%(raw)` can not be used with `--python`, `--shell`, `--tcl`,
> +`--perl` because the host language may not support arbitrary binary data in the
> +variables of its string type.
> +

Seems like out of sync between commit message and the docs change above. 
Did you mean the (unsupported) host languages are Python, BASH script, 
TCL/TK, and Perl respectively? If so, the docs should say:

"Note that `--format=%(raw) can not be used with `--python`, `--shell`, 
`-tcl`, and `--perl` because such languages may not support arbitrary 
binary data in their string variable type."

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
