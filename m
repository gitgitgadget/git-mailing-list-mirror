Return-Path: <SRS0=g1uB=DW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E35ADC433E7
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:42:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6D6822076D
	for <git@archiver.kernel.org>; Thu, 15 Oct 2020 13:42:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T63Rfy1p"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729976AbgJONm1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 15 Oct 2020 09:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726925AbgJONm0 (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 15 Oct 2020 09:42:26 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EF71C061755
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:42:26 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id h5so3536411wrv.7
        for <git@vger.kernel.org>; Thu, 15 Oct 2020 06:42:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=y6leYLbCt/T4KhTXScg9KzmES08JakpA4ctYu91VFqI=;
        b=T63Rfy1pkqDpp3eoevETOQCjt0/ZAyz+Tj/7a8U19rjjO5ZXWXL5KUwFDZC5RymPkA
         bQ31/08GeiXILrSkkEB4FBjkM3gggdz9xHhXWPy1mYxKMym5SaIbvh/8HquB7cgmyFok
         1YX+gnKRCaxwKdbHw4q1DtuAR+9XWbfwu1fVpnhBRbRAtSgONRV7SAiIdQucYcW5sgtd
         B1AKo9oRFYmaLEiaME4FHWvo/+JKxDY4Ji/65Ld9tjvuvh8eHUdaSY0cnMs5OJNrtdUE
         Adz7CvMucn9ICLNz6ODmFDYRHWbZHhOGRHSUjAFlp6m76k/oVCGsX0+1+nyvOs72ot/e
         Hdjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:cc:references:from
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=y6leYLbCt/T4KhTXScg9KzmES08JakpA4ctYu91VFqI=;
        b=dXZ7YvtyJHLcbQhlPrtrWSnw0TGmPXh5hOSZr6OxJxfPceEeBlcCkgam76ArZmgJW5
         TDNMOWq8d/B425grCHR+juQ/6y0b5fKgJmcyqs5xKGQfrVGe91/4u92GslOqxVKOxYRM
         Gc+QTQ+s9umvo0swNiJjnk4oC//lSDJKkD1gO9YNCrzwp7LY0ymHEJGlnETKva9CP3XC
         NSsRl7Y8FBazUM5tnEUmDtCgUukOrT0+P2MX38ZDqfv473imIw6CTpPDW86zkBH7RERi
         S+bLl2iUezwBMUSw7/rIHOrbOfceUIde2JQOHE0uMRN2HTFpSlcXt5yz1UDfgXyWcBSF
         1i6g==
X-Gm-Message-State: AOAM530+5B0epqEvNjx4Xi4rgnYvvXXdVKtYxjDZvlo/EDgaXGAWGPkV
        BEAr4FT7yxRU+W9mdmS/yQQ=
X-Google-Smtp-Source: ABdhPJx66qRlGBOmcP+YZHtv8kdfOHh9rHyonzX6rFXXXu88FXqGA56IWrkk4zuu9aFjl7SDAqdO/g==
X-Received: by 2002:a5d:6a43:: with SMTP id t3mr4588963wrw.426.1602769345447;
        Thu, 15 Oct 2020 06:42:25 -0700 (PDT)
Received: from [192.168.1.240] (48.45.90.146.dyn.plus.net. [146.90.45.48])
        by smtp.gmail.com with ESMTPSA id t10sm4349837wmf.46.2020.10.15.06.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Oct 2020 06:42:24 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/3] Make test selection easier by specifying description
 substrings instead of just numeric counters
To:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        phillip.wood@dunelm.org.uk
Cc:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Elijah Newren <newren@gmail.com>
References: <pull.878.git.git.1602545164.gitgitgadget@gmail.com>
 <fba0a914-1818-8a24-41b0-35740a7c2d2d@gmail.com>
 <nycvar.QRO.7.76.6.2010151347240.56@tvgsbejvaqbjf.bet>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <4890563a-4860-5958-8984-2d784b2a481a@gmail.com>
Date:   Thu, 15 Oct 2020 14:42:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <nycvar.QRO.7.76.6.2010151347240.56@tvgsbejvaqbjf.bet>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 15/10/2020 12:48, Johannes Schindelin wrote:
> Hi,
> 
> On Tue, 13 Oct 2020, Phillip Wood wrote:
> 
>> I'm worryingly excited by this series
> 
> FWIW I am in the same boat.

I'm glad it's not just me!

>> On 13/10/2020 00:26, Elijah Newren via GitGitGadget wrote:
>>> This patch series enables me to change
>>>
>>>    ./t9999-my-test.sh --run=1-3,5,17,19
>>>
>>> into
>>>
>>>    ./t9999-my-test.sh --run=setup,rename,symlink
>>>
>>> and have it pick out tests with "setup", "rename", or "symlink" in their
>>> description and run those. Saves me a lot of time, especially since numbers
>>> for tests aren't readily accessible. The easiest way for me to get the
>>> numbers corresponding to the tests I want to run, is to run all the tests
>>> and look at the output to match up the descriptions with their numbers --
>>> thus defeating the point of selecting just a subset of the tests to run in
>>> the first place.
>>
>> Yes it's a real pain to have to run all the tests to find the numbers of the
>> ones you actually wanted to run. I like patch 3 as well, without it if you're
>> only running a couple of tests it can be hard to find then amongst all the
>> skipped tests. I had a quick read of the patches and they looked fine to me.
> 
> I learned the trick to run with `--run=0` just to figure out the numbers
> in a recent Outreachy project, I think it was Slavica who taught me.

That's a handy tip, thanks (though hopefully I soon wont need to use it)

Phillip

> But yes, without patch 3, the output looks awfully verbose and you have to
> scroll back an insane amount of lines for long test scripts.
> 
> Giddy,
> Dscho
> 
