Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.3 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 386C8C5519F
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 13:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BD31922272
	for <git@archiver.kernel.org>; Fri, 20 Nov 2020 13:23:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="otcnZj2B"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727857AbgKTNXL (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 20 Nov 2020 08:23:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727657AbgKTNXL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 20 Nov 2020 08:23:11 -0500
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9B8AC0613CF
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 05:23:10 -0800 (PST)
Received: by mail-ot1-x343.google.com with SMTP id l36so8677888ota.4
        for <git@vger.kernel.org>; Fri, 20 Nov 2020 05:23:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Wafw/SbG86BjZbdHYglKLb9I8PymWA90SvaLL9cy08w=;
        b=otcnZj2BVOmS86WpniLFzFTSctSpL00btGYir5Jg3ifncD4n/PgdjquOcDpSgfsdfQ
         zudPICknfRqBqqUBoLMjiEfrvfFFmigRl9XCI46VcmG1MucB7JsWifQl0NP77qX6SPTL
         yCdJE+hNVRyjtDvHt+eWXxc8hOr93V+E8Thh8v65ddX+cQmjC3QoPggDKqGWhd93cxMn
         QEkeJX9W3etLNuqEmYVYDsrZk3rCIRU0CXp8R5bOZ+w9lx8r9kTkhRb+ptQOJf8qv8pP
         Oo/XmbYCP+swUl/RpTgcQ9dyLwwVbXehOJnmN80QHu9Me3FQR5q1iL1VJlJqD34xvlFV
         s0SQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Wafw/SbG86BjZbdHYglKLb9I8PymWA90SvaLL9cy08w=;
        b=rQPiuq3KdaKAl+RE6CbGq6bdswMWiJcRdx47f+TcXoqedotO24RWr8jVMc4qBjgVuc
         qYf4HHfQFBK1M0xfaEOpf1PAqCQ4GqvCYckupXcHJa2il7lWfDl6orXlCXug9r5BusDx
         0XC4Q8shDRsq7allbQ2/4uqjBA5UNqbhAQtEJ8BmYGWe4zwoadM4nCia7ibMHXVM6gPa
         /KltvRxX0YldpWetqknX6xFPPgpiVYL1mtDAVXPVm/Vi0chLmcKDkt4Avuv/2+na6zH6
         vVcspgKS2ldN0LEJVZ7ALwZYIT+xIDPLW1NFSukfuxpOtZRMsflh/Nu84EzRD+rHOhrn
         LCBw==
X-Gm-Message-State: AOAM531WntnswuDzJmDAcnHxW3Cw6VPZPFW54tQAeU70b/Hd8pXf3QkQ
        i6SFQod90jHOfWVOkbXQcFY=
X-Google-Smtp-Source: ABdhPJx5Noduyb92vbnwoQ4AEsNuDBdbPfSIyKPP+QS2UlGxKHX+S3L+IUEEJlc/aePfTRSzwS7Vpg==
X-Received: by 2002:a9d:694e:: with SMTP id p14mr12439342oto.254.1605878589976;
        Fri, 20 Nov 2020 05:23:09 -0800 (PST)
Received: from ?IPv6:2600:1700:e72:80a0:605d:243e:92dd:9289? ([2600:1700:e72:80a0:605d:243e:92dd:9289])
        by smtp.gmail.com with UTF8SMTPSA id t25sm1384287otj.13.2020.11.20.05.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 20 Nov 2020 05:23:09 -0800 (PST)
Subject: Re: [PATCH 0/7] config: add --literal-value option
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
        Emily Shaffer <emilyshaffer@google.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>,
        Derrick Stolee <derrickstolee@github.com>
References: <pull.796.git.1605801143.gitgitgadget@gmail.com>
 <87k0ugp3mg.fsf@evledraar.gmail.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <e7973fe1-eb64-2f5a-ecb3-fadf2ba9764d@gmail.com>
Date:   Fri, 20 Nov 2020 08:23:07 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:83.0) Gecko/20100101
 Thunderbird/83.0
MIME-Version: 1.0
In-Reply-To: <87k0ugp3mg.fsf@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/20/2020 8:19 AM, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Nov 19 2020, Derrick Stolee via GitGitGadget wrote:
> 
>> As reported [1], 'git maintenance unregister' fails when a repository is
>> located in a directory with regex glob characters.
> 
> Just as bikeshedding on the name: Did you consider something
> thematically similar to the corresponding git-grep option,
> i.e. --fixed-string[s]. I see -F is also free in git-config(1).

I definitely wanted to be specific about "value" in the name,
since some options include regexes on the key as well. I'm open
to new ideas, and combining your idea with mine would introduce
"--fixed-value". Thoughts?

Thanks,
-Stolee
