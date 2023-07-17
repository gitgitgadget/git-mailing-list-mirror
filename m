Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56AF3C0015E
	for <git@archiver.kernel.org>; Mon, 17 Jul 2023 15:39:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230422AbjGQPjO (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 17 Jul 2023 11:39:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230523AbjGQPjJ (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 17 Jul 2023 11:39:09 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F4219136
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 08:39:05 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3fbc656873eso48227245e9.1
        for <git@vger.kernel.org>; Mon, 17 Jul 2023 08:39:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1689608344; x=1692200344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=y/YCLObLPnJgTJJFQkGLcFQfhnl4zxUkGlTEkSlk68g=;
        b=V9AFrn/Q8H6buwJXnfebPbcvnS6U0l7MSWO9/D77CVU/UDhfNmY5eWJpB3eop8YMTk
         wwyULPMZk3F6feqKFKa8WY0sp5gHm0ZrQWI3LvoyIZQ+eA2jnQgMnvd0UMOLyLPUlT+w
         kcxLHGu6X0gKMPAVJhw9ks9tssAespRLOoAQRyOfr6Qi3IRALWr7DAKCnxeXQazhXXdn
         Pe3abyeRp/lOgfMSey/yN+uq27BgyPIV1Kkk89jYh/DY+JqLW7a4bwRWs39OY2C979qz
         Mf86ZJNs8ain1WLn6F0kV1WZeB9WM8yG4D1WP/qxc142/1F325r+hCaDNyuWSrxX9+XW
         ymQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689608344; x=1692200344;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y/YCLObLPnJgTJJFQkGLcFQfhnl4zxUkGlTEkSlk68g=;
        b=XCGmGwKJyGllNDZh3akk7SOwrTkQ/QOwCQDBl7jGDeqNvrU6i/EUIPg2Typ+oT2V+d
         Hac/NaIFjxwab0qg8OefNOXndnHZ4vV8oWxPrxpfsAw/EAk/nszQLIlpI3pOzhiLD/Q/
         oToBiQ5Oecp1QnSETyvchZWB0mF8HUbUad55Xlk1M0tb3F7nokJW3p98/nYBFT7X6Vc0
         8tS5ckBHaqRZpAqsitay7ljZ3xQzM5mP1nbn70Rl6I5aSiZmVU8X5o8ZagmLn9IXOWyQ
         PU9T/NRDJK8F8nQ1rYIIjkawtGfeRfVHjocQkLUIrj+WBCYTQ8vJcD06CU8YlT8YsQOg
         aMEg==
X-Gm-Message-State: ABy/qLaI1dydT4Thn70OcbqlxfQmQpF0x3BH8J1cBWjZH0b4nHikR8+Z
        im51ljNMo/u5mcQtpwIsaE0=
X-Google-Smtp-Source: APBJJlHomQkMFPGi06GGv/G9EMPTnoPTHEPnJuR025PN+8UCehRiU23xzDIHCqX5KFuTpEZfYnF26A==
X-Received: by 2002:adf:dd88:0:b0:314:2e09:f3ce with SMTP id x8-20020adfdd88000000b003142e09f3cemr12923515wrl.8.1689608344208;
        Mon, 17 Jul 2023 08:39:04 -0700 (PDT)
Received: from [192.168.1.212] ([90.242.235.211])
        by smtp.gmail.com with ESMTPSA id q15-20020adffecf000000b003142439c7bcsm19521969wrs.80.2023.07.17.08.39.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 17 Jul 2023 08:39:03 -0700 (PDT)
Message-ID: <b2812b85-b92e-89a4-e3e9-2c952d53c3ff@gmail.com>
Date:   Mon, 17 Jul 2023 16:39:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 2/6] rebase -i: remove patch file after conflict
 resolution
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Glen Choo <chooglen@google.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Stefan Haller <lists@haller-berlin.de>,
        Phillip Wood <phillip.wood@dunelm.org.uk>
References: <pull.1492.git.1679237337683.gitgitgadget@gmail.com>
 <pull.1492.v2.git.1682089074.gitgitgadget@gmail.com>
 <227aea031b588977f22f3f97faee981d79ade05c.1682089074.git.gitgitgadget@gmail.com>
 <kl6lsfakr2sr.fsf@chooglen-macbookpro.roam.corp.google.com>
 <55dd6194-25e5-1a66-9c39-27cb19bfbb3c@gmail.com> <xmqq4jm6qvvd.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqq4jm6qvvd.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/07/2023 17:51, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> On 21/06/2023 21:14, Glen Choo wrote:
>>> "Phillip Wood via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>>
>>>> @@ -3490,7 +3495,6 @@ static int make_patch(struct repository *r,
>>>>    		return -1;
>>>>    	res |= write_rebase_head(&commit->object.oid);
>>>>    -	strbuf_addf(&buf, "%s/patch", get_dir(opts));
>>>>    	memset(&log_tree_opt, 0, sizeof(log_tree_opt));
>>>>    	repo_init_revisions(r, &log_tree_opt, NULL);
>>>>    	log_tree_opt.abbrev = 0;
>>> I was checking to see if we could remove buf or whether we are
>>> reusing
>>> it for unrelated reasons (which is a common Git-ism). We can't remove it
>>> because we reuse it, however...
>>
>> I had a look at that and we're using it to construct a path that we
>> should obtain by calling rebase_path_message() - I'll add a fix when I
>> re-roll.
> 
> Wow, a patch from April commented in June and responded in July ;-).
> 
> I'll salvage the topic from the "will discard" bin and mark it again
> as "Expecting a reroll" in my draft of the next "What's cooking"
> report.

Thanks, sorry it has taken so long, I've been struggling to find time to 
work on this but hopefully will have a new version ready in the next 
couple of weeks

Best Wishes

Phillip

> Thanks.
