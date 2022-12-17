Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB27EC4332F
	for <git@archiver.kernel.org>; Sat, 17 Dec 2022 10:44:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229554AbiLQKoS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 17 Dec 2022 05:44:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLQKoR (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 17 Dec 2022 05:44:17 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 191902E6
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 02:44:16 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id c65-20020a1c3544000000b003cfffd00fc0so5696266wma.1
        for <git@vger.kernel.org>; Sat, 17 Dec 2022 02:44:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :from:to:cc:subject:date:message-id:reply-to;
        bh=t1Rvq/H1ySYoRvCLU8NypXIQUkvG0PzLfXdDDv0qmF0=;
        b=ONx7bTpIRCwWmL9qMBzMHPMUEV2VirBt32btETVp2R9w41gEYZhos6fBYnY1zTQRYt
         IEdTcntAmUFkkPSnlVhBegwITaNvAEEVFtBPs+sqnnPjGketcUrVS8fI2+1X8avy1GEw
         b4xZItwI+j6Vzo8gtBQgIgUWDlEB34sayeVOz6Kn6XJNEwEtUoFxpsecSDJr9vaBdofI
         YymDfjrFP2fIpWKud8QVov9DKo3xJeAuxQ02Xq6t6EXvtijepu9UFl4jxaAY7L8pQUBd
         SEivm3nrH6TrlfXDnQA50vgoAltjqOsBY42sHULAdGDC2MuaNsLsn8WAX1vRCuQyYLc7
         c49Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:subject:reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=t1Rvq/H1ySYoRvCLU8NypXIQUkvG0PzLfXdDDv0qmF0=;
        b=2cg+fDBOX+96470HGADNdUtf0WOBdg5Q+CJiIRDhmbXZay0UViN3BfnCAWGOqro+sH
         xgupPdJMf8/yOZRc4inZanwviWbiyd3H3e0Nj3AR6RAbZ5VZK7IjduLGQ/S04/WapNK3
         t/+gOVhWsDL3TlMpweoo94EHMHrHSxGrZITccUi7ZL02GdH4j8Wgo3lj2o6pjLwIdBYa
         2guo3q7kEIHhuws9QihY9m5oJjq/usk6jKOLLE9TJPzDY0SVz6DqGnRi9510zOkhSwuD
         BlOCha3xWsN6rKdeZ9SwVP304HBum7JiLykMwJLAE8B5OIapDI0DaelD31fNT9sq49V9
         GH5g==
X-Gm-Message-State: ANoB5plhIaxuH9zq4z/atWmDRXdQgM0PZH1IL01b225QSgu9gfCn/M0B
        WPjbNB1pa+K2sQ5g4awj/T0=
X-Google-Smtp-Source: AA0mqf6de8ULmcj8uKwGIPGHyATYPRmc7le3/znq29oo949xzKjN5U3atauy5QT616zAex9N1fPi5g==
X-Received: by 2002:a05:600c:3584:b0:3d1:bf7c:391c with SMTP id p4-20020a05600c358400b003d1bf7c391cmr26689668wmq.4.1671273854502;
        Sat, 17 Dec 2022 02:44:14 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id 189-20020a1c02c6000000b003cfd58409desm12705691wmc.13.2022.12.17.02.44.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 17 Dec 2022 02:44:14 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <6c8e8271-432f-38e3-e70e-1445f874afc6@dunelm.org.uk>
Date:   Sat, 17 Dec 2022 10:44:13 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Strange "git stash pop" conflict (one chunk out of many)
To:     Ulrich Windl <Ulrich.Windl@rz.uni-regensburg.de>,
        git@vger.kernel.org
References: <639B074B020000A100050792@gwsmtp.uni-regensburg.de>
Content-Language: en-US
In-Reply-To: <639B074B020000A100050792@gwsmtp.uni-regensburg.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ulrich

On 15/12/2022 11:38, Ulrich Windl wrote:
> Hi!
> 
> This is for a somewhat older git-2.26.2:
> I had added interactively some changes  using edit of a few junks (I tried to structure my big hacking into logical junks when committing).
> To test whether the partial commit would be consistent, I did a "git stash -k" before committing, and after committing I did a "git stash pop" to continue hacking.
> 
> Unfortunately I had a "Merge conflict". Looking at it, it is rather "interesting", however (meaning: I don't understand it).
> Here is how the conflict looks (to me both variants seem identical):

Yes, it does look "interesting". Did you make any changes between 
running "git stash -k" and "git stash pop"? I did wonder if there had 
been some whitespace changes where spaces were replaced with tabs or 
vice-versa ("git stash" uses "git apply" to create the stash so if you 
have apply.whitespace set to "fix" the stashed changes will not 
necessarily match those in the working copy) but diffing the two sides 
of the conflict does not show any changes.

Best Wishes

Phillip

>          # pre-allocate translations and accesskeys
> <<<<<<< Updated upstream
>          foreach my $attr (LD_SEARCH_ATTR) {
>              $attr{$attr} = [translate_attr($attr), undef];
>              $attr{$attr}->[1] = add_access_key($aks, 0, $attr{$attr}->[0]);
>          }
>          foreach my $attr (LD_SEARCH_ATTR) {
> =======
>          foreach my $attr (LD_SEARCH_ATTR) {
>              $attr{$attr} = [translate_attr($attr), undef];
>              $attr{$attr}->[1] = add_access_key($aks, 0, $attr{$attr}->[0]);
>          }
>          foreach my $attr (LD_SEARCH_ATTR) {
>>>>>>>> Stashed changes
>              @n = (P_P_SRCH_ATTR . $attr, @{$attr{$attr}});
> 
> (the other conflict junks look reasonable)
> 
> Regards,
> Ulrich
> 
> 
> 
> 
