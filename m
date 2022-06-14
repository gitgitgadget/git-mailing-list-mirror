Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26C81C433EF
	for <git@archiver.kernel.org>; Tue, 14 Jun 2022 13:32:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233594AbiFNNcc (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 14 Jun 2022 09:32:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343574AbiFNNc2 (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 14 Jun 2022 09:32:28 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4EC0B2B
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 06:32:26 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id h7so6543061ila.10
        for <git@vger.kernel.org>; Tue, 14 Jun 2022 06:32:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7E/4XDLzwd7Jphi2YHXw8iUsrt9Ka/FimZu+7cVEO/8=;
        b=DXsY6GhgoD9nDQl7kTQtPHa8TcmIHBGG/GJVNZwn9yo77Ix0EfPdWyAg8Cwp2S3YyL
         wouRYWWyXhP5xX9UCoxkBKFg6xnuWNDSSznaSXkXLsXL4oaXBNTidYqyGTn/jy0x95JA
         +fyIEitI8bbw9zgWu1wKP2ooykAZUX9VT0SXEnS8XTwSaGZNbS+S0l4CtGJp/sT3dKBi
         WStpLCfoI5gLiLnGg99bmNS31g83FO/i+Uee44pnAnOzzWNNOo6a0K03B7VssTx+7ZGy
         3zRz9WYnDy4aAQke+jHyQQN4m3ndcxMtD1mEB/y6edDmKr6VDAklO3un3RqjjReyCzGN
         ALcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7E/4XDLzwd7Jphi2YHXw8iUsrt9Ka/FimZu+7cVEO/8=;
        b=OT17gjDA4v8D7xfDhCklCdSOBvAit5JMJKm0enk8EMalA0rEvrwj5Acq2uetdqDQp2
         WS1usTbEpIOEMR0lf5sp3Q8VtFklYLXxcWfVFlfdWS09iyz4+7SAl5Ni8QsHB1TL3soM
         wveJl3I6Uosd1UegmppUBvz8K/9JsupMAjxIidw21Rb0aD2Hy6AWeg2ttVOEV/vgAMaX
         EIlPnNMIPPe0yhi6MbB67UPfw6WW8F9tGpZF7ov7tfOlD2n0u5ivRw1CgUGnOybGJsx1
         YR+jZyR7t/Eo6cUGZak6qfXgSitLWoh5nckdHndsFamzqZKZKkIPBUfJ++L8xLrqeQFP
         s8Cg==
X-Gm-Message-State: AJIora+JMjIP+rPxSYbjO/o+K8QIzyMUateJFdW+7Eym/Oib/voIcu/H
        eWNSzwCtk6sg3sUQLHppnQz7
X-Google-Smtp-Source: AGRyM1v1/to8auOMBVTIJgsooFjjM2ReJygAtnAL6ARpM5iGCEz3TVl7a6cI0nz9j1mj+mu0C4NFmw==
X-Received: by 2002:a05:6e02:1aa6:b0:2d1:b452:f143 with SMTP id l6-20020a056e021aa600b002d1b452f143mr3144254ilv.278.1655213546086;
        Tue, 14 Jun 2022 06:32:26 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:508:3b97:7c0b:efc0? ([2600:1700:e72:80a0:508:3b97:7c0b:efc0])
        by smtp.gmail.com with ESMTPSA id p19-20020a027813000000b003316c1a2218sm4850990jac.70.2022.06.14.06.32.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Jun 2022 06:32:25 -0700 (PDT)
Message-ID: <4fc234ab-de06-9e96-daf6-7b3496132541@github.com>
Date:   Tue, 14 Jun 2022 09:32:24 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [PATCH 1/4] branch: add branch_checked_out() helper
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, gitster@pobox.com, johannes.schindelin@gmx.de,
        me@ttaylorr.com, Jeff Hostetler <git@jeffhostetler.com>,
        Phillip Wood <phillip.wood123@gmail.com>,
        Elijah Newren <newren@gmail.com>
References: <pull.1254.git.1654718942.gitgitgadget@gmail.com>
 <dbb7eae390c90d4b710f48d8875bd7db0409aea3.1654718942.git.gitgitgadget@gmail.com>
 <220614.86leu0yur8.gmgdl@evledraar.gmail.com>
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <220614.86leu0yur8.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/13/2022 7:59 PM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Wed, Jun 08 2022, Derrick Stolee via GitGitGadget wrote:
> 
>> From: Derrick Stolee <derrickstolee@github.com>
>> [...]
>> +	path_in_set = strmap_get(&current_checked_out_branches, refname);
>> +	if (path_in_set && path)
>> +		*path = xstrdup(path_in_set);
> 
> Looking at the end state of this series there is nothing that passes a
> null "path" to this function, i.e. it's all &some_variable.
> 
> So just dropping that && seems better from a code understanding &
> analysis perspective.

I don't see the value in making this method more prone to error in
the future, or less flexible to a possible caller that doesn't want
to give a 'path'.
 
> More generally, can't we just expose an API that gives us the strmap
> itself, so that callers don't need to keep any special-behavior in mind?
> I.e. just "make me a strmap of checked out branches".
> 
> Then you can just use strmap_get(), or xstrdup(strmap_get()), and if the
> pattern of "get me the item but duped" is found elsewhere maybe we
> should eventually have a strmap_get_dup() or whatever.
> 
> I.e. just making it: xstrdup(strmap_get(checked_out_branches_strmap(), refname)).

This seems unnecessarily complicated. It also risks someone inserting
key-value pairs in an improper place instead of being contained to
prepare_checked_out_branches().

If your concern is about creating the static current_checked_out_branches,
keep in mind that the callers that call branch_checked_out() in a loop
would need to keep track of that strmap across several other methods.
That additional complexity is much worse than asking for a simple answer
through the black box of branch_checked_out().

Thanks,
-Stolee
