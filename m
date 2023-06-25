Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BD84EB64DC
	for <git@archiver.kernel.org>; Sun, 25 Jun 2023 12:10:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231960AbjFYMKr (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 25 Jun 2023 08:10:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231152AbjFYMKp (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 25 Jun 2023 08:10:45 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84972115
        for <git@vger.kernel.org>; Sun, 25 Jun 2023 05:10:44 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id af79cd13be357-765a7768f1dso2626185a.0
        for <git@vger.kernel.org>; Sun, 25 Jun 2023 05:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687695043; x=1690287043;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s5DSpxWx90iF7bW4nr3B3HKc5YypYiivjFJ/D1ZCYE4=;
        b=dwp8mEmD5RG5bA1zevvPWqA48WKCBnQvdotqF9lS51FZx9xzNuPw0vCpXlmVC/PAbV
         mtyhw2j0HvRI9oqu9YTdp4ZmRJjm6EIRaCJpO8GxdJ3A7mwh6h9p+UF0RORjfreFD5G/
         GzKqKP92VlMAw4PF0d6X07tBZX/cQPlii5LcaMh0eCidENHOdVICmwT6l8TFhd22OxIZ
         c00KihsnIf689xDMigShZjMLlbnEHq0L77advjbBBcN+hc0YzTasoFvkor5HZtiGsy/K
         Pw88woLryD9b+vHWk8isBglh31QgxyQcbsr43F/HNMUtnjok1cddBYXDZnFGuz1bjoZG
         vNOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687695043; x=1690287043;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s5DSpxWx90iF7bW4nr3B3HKc5YypYiivjFJ/D1ZCYE4=;
        b=ko4X3yeV/xWikdsPrnBmJP9VSoJ7yVKZEp2r1j7C2L6GfnpFnBZi1TW+R8IPJgMgRd
         ai9lxGBRFASojMQlAl5d3ufyOt4uMubJIZZ1JR6Kbcv2SMH9ZQr7hRedei1fmJ1LPtjv
         LDgAPUmdhEnKDHvuVR7ONXg0KMxMQOD9JtAmyEFphers52Qmti7EzsMC51F6j5JIHoiu
         eQhHZz40pFkagx4w/9EhZBlxfK/SiaxDWGwriEQ5Se0AvUUefe/TqHSBxjbYFUGmSX0j
         /4MfvKZK7eMGMmAUFAkMTP3HVTcAx1CIkuKTc+zjpRChTE6y9M8jqBk7KgyGiQFD97ep
         xmrg==
X-Gm-Message-State: AC+VfDym3FhbvDQA62qnB7xYU7O9Uxi8aEuEFe4r/CS+ANjUiRMVJlzi
        UKA561j65aCM2+7PW9zDzp++h9w77UB2qA==
X-Google-Smtp-Source: ACHHUZ4ItH6I7raPzrKAdUcQQUE29Yvyjb0YQx+88VzopLs5FuJ/qxLY+xGroTD4M3wUvFPZ8DS7Sw==
X-Received: by 2002:a05:620a:24c1:b0:75b:23a0:dec5 with SMTP id m1-20020a05620a24c100b0075b23a0dec5mr33495711qkn.67.1687695043597;
        Sun, 25 Jun 2023 05:10:43 -0700 (PDT)
Received: from ?IPV6:2600:4040:266e:4d00::387? ([2600:4040:266e:4d00::387])
        by smtp.gmail.com with ESMTPSA id c25-20020a05620a11b900b007607324644asm1578165qkk.118.2023.06.25.05.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Jun 2023 05:10:43 -0700 (PDT)
Message-ID: <16959998-cb50-6f7d-370f-22c7293c89c2@gmail.com>
Date:   Sun, 25 Jun 2023 08:10:42 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v0 0/4] Remove obsolete Cygwin support from git-gui
Content-Language: en-US
From:   Mark Levedahl <mlevedahl@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, adam@dinwoodie.org, me@yadavpratyush.com,
        johannes.schindelin@gmx.de
References: <20230624212347.179656-1-mlevedahl@gmail.com>
 <xmqq8rc8781p.fsf@gitster.g> <e04e28e2-2308-1db8-9462-5f81aeff1155@gmail.com>
In-Reply-To: <e04e28e2-2308-1db8-9462-5f81aeff1155@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On 6/25/23 07:26, Mark Levedahl wrote:
>
> On 6/24/23 19:30, Junio C Hamano wrote: git-gui has three independent 
> functions (is_Cygwin, is_Windows, and is_MaxOSX), each determine if 
> running on that platform, and "generic Unix/Linux" can be considered 
> the result if all three functions return false. In Pratyush's tree, 
> those three functions essentially are:
>
> is_Cygwin: $::tcl_platform(os) startswith("CYGWIN")
>
> is_MaxOSX: [tk windowingsystem] == "AQUA"
>
> is_Windows: $::tcl_platform(platform) == "Windows"
>
> It turns out, only one of the . is ever true, and none are true on 
> Linux. So, the if/else tree above is not confused by Windows / Cygwin.
>
> But, different Tcl/Tk signatures as platforms evolve could cause 
> problems. A better design might be to just have a $HOSTTYPE variable 
> set once, perhaps in startup, perhaps even by the makefile, to assure 
> exactly one hosttype is ever active and make this clear to others. 
> Normal configuration checking in the makefile could have uncovered 
> this whole problem in 2012. But, this is a possible cleanup topic for 
> another day.
>
> So, the code under the is_Windows and is_Cygwin branches of the 
> if/else trees are now completely independent, and the is_Windows 
> branch is never entered on Cygwin.
>
>
> Thank you,
>
> Mark
>
A follow up - I have Cygwin in a Windows VM on my laptop, no G4W, no Mac ...


Cygwin gives:   $::tcl_platform(os) = CYGWIN_NT-10.0-22621
                 $::tcl_platform(platform) = unix
                 tk windowingsystem = x11

Linux gives     $::tcl_platform(os) = Linux
                 $::tcl_platform(platform) = unix
                 tk windowingsystem = x11

So, neither Cygwin nor Linux trigger the checks for is_Windows or is_MacOSX


