Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94003EB64DC
	for <git@archiver.kernel.org>; Fri, 21 Jul 2023 13:08:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjGUNIt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 21 Jul 2023 09:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbjGUNIs (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 21 Jul 2023 09:08:48 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B633E68
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 06:08:46 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2b74310566cso28820321fa.2
        for <git@vger.kernel.org>; Fri, 21 Jul 2023 06:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689944925; x=1690549725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=gtaHrN4Zav/77GoKQhJrIk3glWvW2vHcWMHwsmzJRZU=;
        b=CltB095b8g3qArWIn0SLnmpQUWGy6IZGugut+Yzkt/hf86Wmd8EJ7EZPD5TVvWqRct
         0xI4tB3v9wUF9KtG9p/s1as/dutkZqPuufwYtXzGItu9rvRczlshXA5wCqeq6EstxhZp
         lSMmFtp+ypI8SRx9VGRG8Nu+0x6u3CT7v4Pn1zmDpS2t72sNcPF7pwNMkZb5vfyEGDLh
         Z6aJHsetCpTjRZ2kn5702aHfxFZ4Y+9CqYTFBCf5Gjo/4w02jqyIaoNU5Q8uXXMV1xoS
         BE23e4fOf9Y8Gkwk5wC9mhD06Rvq/cnu8HtzTIK76uwyt6mrnneCqFpuqPWeiQUMfAWF
         Wn9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689944925; x=1690549725;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gtaHrN4Zav/77GoKQhJrIk3glWvW2vHcWMHwsmzJRZU=;
        b=EtUEmNUpxH6619U8OTyOBCjaAERvQRthNSKW3W0J/fT88FBH7zPL7WH1VEa4f724nF
         e/dsoM1YH3HhyFvbK3NwEhzUyp6zEWEvfEBrlziUQ8cB4wpyT9nASJ2rmuKsOLnDFHTn
         9QkHcTuu0buNYD7vlF8ndusAgyKQOdTrjP8NKZlxV7oUOaNp/2T9H8p2tFXrKd/6Bwvb
         eadSzxvNuJoZRNNhglg+A5AK8QOG0mU+s7h7bt134UVV0+AOJw+3z5wckZ5x/TWZw+qN
         Hx4R3AI8/i6K76Y+RYbd0i6/frj9eLFpac+78KIpQ7ItBxomrKIZLMvFmcuwQofA9KJz
         sTkw==
X-Gm-Message-State: ABy/qLbDWK8D8vToG1HxLY+GSrnr+VZubHUZyZscXa8KQjMM8V3r1bJs
        YRTSkA4mSV05yysqqSWtgSfrulxCM7m56A==
X-Google-Smtp-Source: APBJJlF78gM1pT4m7ziPr5knraEKzS9EhiafOS5I0NK8YW4hpAYpZ25e0Z9r74UQVKWR5A1GDQwafg==
X-Received: by 2002:a2e:b61a:0:b0:2b6:e2cd:20f5 with SMTP id r26-20020a2eb61a000000b002b6e2cd20f5mr1676928ljn.9.1689944924528;
        Fri, 21 Jul 2023 06:08:44 -0700 (PDT)
Received: from [192.168.1.195] ([90.242.235.211])
        by smtp.googlemail.com with ESMTPSA id e18-20020a5d65d2000000b00314172ba213sm4128803wrw.108.2023.07.21.06.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jul 2023 06:08:44 -0700 (PDT)
Message-ID: <d6e54535-79a3-2d2c-3152-4cabc5bbd9b8@gmail.com>
Date:   Fri, 21 Jul 2023 14:08:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] sequencer: finish parsing the todo list despite an
 invalid first line
To:     phillip.wood@dunelm.org.uk, Alex Henrie <alexhenrie24@gmail.com>
Cc:     git@vger.kernel.org, alban.gruin@gmail.com, gitster@pobox.com
References: <20230719144339.447852-1-alexhenrie24@gmail.com>
 <395274b4-37a9-8c95-203f-94178c99772a@gmail.com>
 <CAMMLpeSN_M1HW1D3HyuY+S+GwUrQ_4dP9qoSQ72hbQv3pwK5kg@mail.gmail.com>
 <c7b7f078-6561-5081-9c23-0cec65b71c97@gmail.com>
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <c7b7f078-6561-5081-9c23-0cec65b71c97@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 21/07/2023 10:31, Phillip Wood wrote:
> That's fine but the commit message should explain that decision and 
> clarify why ddb81e5072 caused the regression

Maybe something like

Before the todo list is edited it is rewritten to shorten the OIDs of
the commits being picked and to append advice about editing the
list. The exact advice depends on whether the todo list is being
edited for the first time or not. After the todo list has been edited
it is rewritten to lengthen the OIDs of the commits being picked and to
remove the advice. If the edited list cannot be parsed then this last
step is skipped.

Prior to db81e50724 (rebase-interactive: use todo_list_write_to_file()
in edit_todo_list(), 2019-03-05) if the existing todo list could not
be parsed then the initial rewrite was skipped as well. This had the
unfortunate consequence that if the list could not be parsed after the
initial edit the advice given to the user was wrong when they
re-edited the list. This change relied on
todo_list_parse_insn_buffer() returning the whole todo list even when
it cannot be parsed. Unfortunately if the list starts with a "fixup"
command then it will be truncated and the remaining lines are
lost. Fix this by continuing to parse after an initial "fixup" commit
as we do when we see any other invalid line.

Best Wishes

Phillip

