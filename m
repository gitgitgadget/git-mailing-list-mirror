Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BD13EC4332F
	for <git@archiver.kernel.org>; Fri,  4 Nov 2022 22:01:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230000AbiKDWBA (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 4 Nov 2022 18:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiKDWA5 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 4 Nov 2022 18:00:57 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EFB3A1B3
        for <git@vger.kernel.org>; Fri,  4 Nov 2022 15:00:56 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id n191so4839350iod.13
        for <git@vger.kernel.org>; Fri, 04 Nov 2022 15:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=0+DEqqiLvRiobzaQNc5fls/EBYSXgTptcoMvi+NpnKc=;
        b=DrA0rGc46rZxWH3+J8Vzo6OYkr+Fmn/iwIaJak01uFpAVvkJIwfNjWdkeXcGh6m6UF
         d0Ztmqf+pol5dF34a2bw8GS3LOCHB12AwhzXEGC+4FXZSMAFJOkzEZ8Hvn+7+kv7gX6r
         lYJmoDcTViyazjhvMEL1cVoepRuZMOJoY9hwH84He5DXmzyFNnQ+rZK4nmDIQtFec4ii
         x7VsH2F1DlGH/Jg12Sdne8kjc5iKFZrEEwkU1WWxHVcHR3UDSnpocD9AT7fPbigkZWhz
         cHFaAaB/dL0dqpp+PgIc6P3LeFtON7CHjqq9lRS2KmkX3lswJqw3qQTfKSOEVrDT+Uv1
         Nwhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+DEqqiLvRiobzaQNc5fls/EBYSXgTptcoMvi+NpnKc=;
        b=i3EHFZDvS+d6nYzzAjomYwm6gPsZrZW9Fmu/GAD82SymUMwEK2yahVUmJK2reMAK+u
         Rr1IaQFpNi0dRbK2pXFgj8/6JET5QdWjBaKfQH82tQ1ULiPyS6S2lruNWRcP2w/BWiHL
         PBaKvY4q4eZQgNnFgdrKIsFMxYoc6FL0uQRGM8GBe6jEBWxHKt91LMbkaRj25RGi5ixx
         QlRahVWR++T8j7Y90ZKMbD2z5XwSSKWP42GjHk7rfHVImDQ7dDI3zvRwsa7qGTjQiR/b
         G7BEvT7FEcK09CgO5h4OZziQD9tvk8xx/mn0wQ0ZKbZRJr7PF83yEpIifkDKlEU9//zz
         G1Kw==
X-Gm-Message-State: ACrzQf3ivM1jyanctITQP9tfjYeGNo7vyfKbE3559/exeadRVyASaQkT
        T26m0VBrO+ZFlGAEaWIGnuRjDw==
X-Google-Smtp-Source: AMsMyM75Rty+T1JvDqhV3FZ+7yTCar9LREZMy4AOEj/7E9EnedHUcK4ocLXSsGtNjoDjJ7PcaOnsfQ==
X-Received: by 2002:a05:6638:1394:b0:374:798:98a1 with SMTP id w20-20020a056638139400b00374079898a1mr21738440jad.61.1667599255412;
        Fri, 04 Nov 2022 15:00:55 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id s13-20020a0566022bcd00b006bbea9f45cesm82197iov.38.2022.11.04.15.00.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 15:00:54 -0700 (PDT)
Date:   Fri, 4 Nov 2022 18:00:54 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Debra Obondo via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Martin =?utf-8?B?w4VncmVu?= <martin.agren@gmail.com>,
        Debra Obondo <debraobondo@gmail.com>
Subject: Re: [PATCH v3] t7001-mv.sh: modernizing test script using functions
Message-ID: <Y2WLlv1waMA9L8S/@nand.local>
References: <pull.1372.v2.git.git.1667500788132.gitgitgadget@gmail.com>
 <pull.1372.v3.git.git.1667574352244.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <pull.1372.v3.git.git.1667574352244.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Debra,

On Fri, Nov 04, 2022 at 03:05:52PM +0000, Debra Obondo via GitGitGadget wrote:
>  t/t7001-mv.sh | 62 +++++++++++++++++++++++++--------------------------
>  1 file changed, 31 insertions(+), 31 deletions(-)

This round looks great. Will queue, thanks.

Thanks,
Taylor
