Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80616C636D4
	for <git@archiver.kernel.org>; Mon,  6 Feb 2023 16:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbjBFQ6c (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 6 Feb 2023 11:58:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230328AbjBFQ6b (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 6 Feb 2023 11:58:31 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 368C529155
        for <git@vger.kernel.org>; Mon,  6 Feb 2023 08:58:30 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id a23so8608654pga.13
        for <git@vger.kernel.org>; Mon, 06 Feb 2023 08:58:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C1Ocy5D0S7XHQ3QpJjG3BYbiCAAYoYDhzfobictDdN8=;
        b=OV8tGJFU0FNiumLTLDsNp4u1r5tSGSK46bAoSMGIfJMIrUNB85wlW+DB3qjt0Lxpsh
         HtUkE/WSON6dVIoWQzRXdGMnXFpkWaQ97kZL3Tb1wNPduA71vfsy5Ym9t13VSmPvCOY0
         tx2vtQjrTgo208EYwDJqxGBkP9JIeeuqwRhCNorn4R5Lc4EAp2NGKulLQN7//d+n5B9B
         gwwAWupqwqaDQp+B7XNp7QYDeRKOhkJfEcq5TnNrUKErDgz+ggzPbsxmTf2k75yB3Qkv
         9vBTSIMeLTEoZ0NhSvj5+UufosZcONw5yNpKw6CoOHHLajvv6iXuU+FAGpzAfEHBoZXQ
         XqZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C1Ocy5D0S7XHQ3QpJjG3BYbiCAAYoYDhzfobictDdN8=;
        b=lxLOjWbZh4/skTa81cx0UgYADDyf8QDYyflkWG3kEn69pnnhJA0u0JKEsVo0b+vDJH
         6uM7Y1PXegDSH5/qIMhhUlImFTqtWm37Up/EdZ/VhyimPdN+zItcfR2Z1I4Hxa5hTQzV
         cdH6yIPbtBwIFsRAdGTMYABapv3maBwjVFOJ9cofCaH3UnzVS7EhButEGS4S5QEbCxAN
         ZZRGK2qhNAs2owcGo0kEyhffuiavt62dVSEEyNQ2BuLiSk/Vm/Gi1JCCVX99wf1sU6b9
         gKm1HtP1vFAk35S41eYaCh6g0KK4Y8VCCAgthHmMJIdgvtAC7dVrPTaCxWbJD9hAYOHo
         59WA==
X-Gm-Message-State: AO0yUKUqi1FxSyZoVvGJe1zHA4Rulj3vwUUw1yAIPqNuYLKYbte/o3nS
        WcdawUbQF8Gv0Tkp9VBE9SFT0oe/9Ysclhl9Lw==
X-Google-Smtp-Source: AK7set9W8Br8K65unFiO554YGe05N5eDrRp7YmZo+UcmPXENmYE/zHFDBeJeD7Uj3o8ci8aOA471ig==
X-Received: by 2002:a62:17d4:0:b0:592:5276:95df with SMTP id 203-20020a6217d4000000b00592527695dfmr165702pfx.2.1675702709775;
        Mon, 06 Feb 2023 08:58:29 -0800 (PST)
Received: from [192.168.50.41] (cpe-172-91-184-234.socal.res.rr.com. [172.91.184.234])
        by smtp.gmail.com with ESMTPSA id z186-20020a6265c3000000b005821c109cebsm7276319pfb.199.2023.02.06.08.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 08:58:29 -0800 (PST)
Message-ID: <b8f90d73-8c49-554c-1109-92d8713d1c29@github.com>
Date:   Mon, 6 Feb 2023 08:58:26 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: GSoC 2023
Content-Language: en-US
To:     Christian Couder <christian.couder@gmail.com>,
        Kaartic Sivaraam <kaartic.sivaraam@gmail.com>
Cc:     git <git@vger.kernel.org>, Derrick Stolee <stolee@gmail.com>,
        Hariom verma <hariom18599@gmail.com>
References: <CAP8UFD3jzX5zRRYKS5uES2X9vB4eKJruzT7o6+7KytqLSmmZRg@mail.gmail.com>
 <d8ce0159-c9dc-25c2-4180-70518bb31bfc@gmail.com>
 <CAP8UFD32nDLR8BrhmeTpyraX3QBrc=U1ody+qgyMVY+_-HrASA@mail.gmail.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <CAP8UFD32nDLR8BrhmeTpyraX3QBrc=U1ody+qgyMVY+_-HrASA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Christian Couder wrote:
> I removed the "Reachability bitmap improvements" idea but left the 2 others:
> 
>   - More Sparse Index Integrations (I removed `git mv` in the list of
> commands that need to be improved though)
>   - Unify ref-filter formats with other pretty formats
> 
> On both of them I removed all possible mentors except me though. They
> are welcome to tell me that they should be added back.
> 

After mulling it over, I'd like to sign up as a mentor again this year for
"More Sparse Index Integrations" - feel free to add me back to the
application. AFAIK I'd be solo-mentoring for this project (although I'm
happy to work with a co-mentor if anyone's interested!).

Thanks!
-Victoria
