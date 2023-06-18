Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 479A5EB64D7
	for <git@archiver.kernel.org>; Sun, 18 Jun 2023 10:57:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229669AbjFRK5I (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 18 Jun 2023 06:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjFRK5H (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 18 Jun 2023 06:57:07 -0400
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E629AEE
        for <git@vger.kernel.org>; Sun, 18 Jun 2023 03:57:05 -0700 (PDT)
Received: by mail-wm1-x32d.google.com with SMTP id 5b1f17b1804b1-3f8d258f203so17707745e9.1
        for <git@vger.kernel.org>; Sun, 18 Jun 2023 03:57:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687085824; x=1689677824;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gY2BUjJFRZBo8lvwCqQQEoJvN0AdIO0OMF57J7BOwFk=;
        b=kRdt73NaL16SZilFGxw5wF8BzUhJ2rM3pMvBIdP5RHQ4ejVtxTwh5cm/+g7lY6/dLn
         6myFWlAqm5M5PNoCAfRaZ2qPmhrba2Px6EHtDTqAKBgWe+4/7hVE1tgHKafz84tR833b
         zmO338/XO/0l60BkGqZiw40YCQmNpM3AwK1jk9jvqvHNPE4u0LTBNxnaLdTcsrjP3Ybc
         RMyceIJyfNusPguEtULha16yXBoag2I42u183Du78/v/CupASH9aFokiotsFEURZ55tm
         /JLKFgWAh/9iwWcv5chkQRYcyN72n3dm94Qga1e1KUCodNCNccLdrUX77wG5eL5Dk060
         sE/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687085824; x=1689677824;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gY2BUjJFRZBo8lvwCqQQEoJvN0AdIO0OMF57J7BOwFk=;
        b=S3r8r/BCwfNkgxRVo/wP0rTZqu5sSkqsWfBULnX0hgcxQKtCXTvPn+b8ZndDmN1l0v
         NLCKsgssUCoSA0rs+YEMzJ90AGGGxkWfKx3HfTx48xrc6Yj5f5fTxeVGHhOvXuUeEyzC
         /AxAAzB/Z7mTvsbBcgn1VWmuXsB5IIBkPopc9BHgVYI+f4gOqPCrb8hYPWah2Q9Z7yvL
         0Yjd7BJPL+HTkny5ZwTmE/pfbOleChFi73AT64gCY6G/efsyQarLyfLckvH4H9PzT72r
         HwvM3Fcwet0wfITlh22gitQnVZNypnoEGqbDZBXrwdF89vZasnQto8fj2V9b9x3Mu4mv
         lmLw==
X-Gm-Message-State: AC+VfDwETMq3PzhmQt+E+mQff1NizlpofI75qeTC8g02sdHBfHfuSnbE
        +oos5Ngc/RiLCbIHRzUwNO8=
X-Google-Smtp-Source: ACHHUZ6k5on+SPhdvIEoKuOUB+B/loq1llEm7ks0v8IMrxoyvrDbw9dEvn+NVIklsMtCK/ID4lX3eQ==
X-Received: by 2002:a05:600c:3797:b0:3f8:f749:efae with SMTP id o23-20020a05600c379700b003f8f749efaemr4382827wmr.33.1687085824116;
        Sun, 18 Jun 2023 03:57:04 -0700 (PDT)
Received: from ?IPV6:2a00:a041:18a2:9200:1f6:9537:e509:fc57? ([2a00:a041:18a2:9200:1f6:9537:e509:fc57])
        by smtp.gmail.com with ESMTPSA id t13-20020a1c770d000000b003f93c450657sm845888wmi.38.2023.06.18.03.57.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 03:57:03 -0700 (PDT)
Message-ID: <8c3ca631-a33a-a64c-5152-249f6182a5c7@gmail.com>
Date:   Sun, 18 Jun 2023 13:57:02 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.8.0
Subject: Re: [PATCH] Add 'preserve' subcommand to 'git stash'
Content-Language: en-US
To:     Oswald Buddenhagen <oswald.buddenhagen@gmx.de>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Nadav Goldstein via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
References: <pull.1528.git.git.1686913210137.gitgitgadget@gmail.com>
 <xmqqjzw3qry6.fsf@gitster.g> <ZIzALOe8GBsNGIhR@ugly>
 <xmqqv8fnrwtt.fsf@gitster.g> <ZI1xLwemOs9Vxorf@ugly>
 <xmqqwn02qqp4.fsf@gitster.g> <f6a510f8-f569-6b1e-a74d-cdd103b39c10@gmail.com>
 <ZI7SzSuT26XXKzah@ugly>
From:   Nadav Goldstein <nadav.goldstein96@gmail.com>
In-Reply-To: <ZI7SzSuT26XXKzah@ugly>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

I see your point, but commits force me to detail the changes (and I know 
it's good practice).

I just want to give the user another option rather than committing their 
changes.


If we talking about commits, why use stash at all? why not just commit, 
push it/create and switch branch, and go back?


I know my argument is not so smart, but I just want to highlight that 
everything can be done with commits, as this what makes git so powerful :)


Thanks for you reply!

Nadav


On 18/06/2023 12:47, Oswald Buddenhagen wrote:
> On Sun, Jun 18, 2023 at 12:05:21PM +0300, Nadav Goldstein wrote:
>> Let me try to explain my motivation:
>> I heavily use stash to set quick points in my code so I could go back 
>> to them (during thought process), and I want to store my changes 
>> quickly and continue from there.
>>
> so why are you (ab-)using stash for that, rather than just committing 
> each time, and later cleaning it by using `reset [--mixed]` and 
> re-committing (or using `rebase --interactive`)? the reflog holds 
> information about "lost" commits (the stash is just a somewhat special 
> reflog, too).
>
> regards,
> ossi
>
>
