Return-Path: <SRS0=KdtI=BW=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	NORMAL_HTTP_TO_IP,NUMERIC_HTTP_ADDR,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 822FAC433DF
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 15:35:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5CED3207DA
	for <git@archiver.kernel.org>; Wed, 12 Aug 2020 15:35:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XT4IUePn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726540AbgHLPfv (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgHLPfv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 12 Aug 2020 11:35:51 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0FD6C061383
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 08:35:50 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id a15so2436146wrh.10
        for <git@vger.kernel.org>; Wed, 12 Aug 2020 08:35:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=reply-to:subject:to:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=+C/F+HEgbtgnqJgSkZKFZ4xPHKD8zB826MejW4BW7zs=;
        b=XT4IUePnVcK32CJre5MJebyGG9QV/KNc2s2mQ6sMucWInnkSIHg40ItllpfAdNGpVj
         qlDWBq35KpcYAn33Cboudt/eB86JQO0ODrMhghTrsiRsX2q+oO3T9JK01yL/ZdJ+oMIJ
         bQpKHt5Q679bK5WS78u5f5hwVaCQcj4jgH+7kywq9ZOGNS5Zfrkao9Omjm3bQQ92dayx
         P0Bd7JoALHTI7jyBl3xC7JB4xSi9/07J6r7293+RyPcOE24qG5JQigGp/yOQprIQy6nc
         IwzU7SsHvMlJ5SgNYzIYo1jmGu3yoroqPmmtBMt1IIfb32GG7usngRlaS5x6QiUNtJLq
         rKVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:reply-to:subject:to:references:from:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=+C/F+HEgbtgnqJgSkZKFZ4xPHKD8zB826MejW4BW7zs=;
        b=f8Gn4JoUJ0dV6HBWEJcsmNebOP9h+henw7cKonf08E5X8LfLQNOS1CdUtpQO8lmgSZ
         rtW6DT0m0aVOo6Oz74Mbkc2VXHGnZDbLOWq3DQ8nOkkJOu9g3Ur8I+Wr0Ng8kLPpjxFQ
         j1wi2e3T03YGxN3fQuT3v8DT9N4nv6uPmtQV608REEPu5jzOcNka28OFcYOQ7JqeNdxs
         S8gGoaA1b6VpahW3Y4li3eYyupAva1WmVz6zMR+B0b7CGJKdtSUa4Bx1lVwbW4+yZp7W
         9DOxGXd8XzMyXp0u02zSX0iyHMTAl1zQ4rpkFEXiilmPkA6Q1jdofyt0AVIt/eBInE4a
         0rfQ==
X-Gm-Message-State: AOAM533KVp2GGZyNAbwIsIZb/HEKONYfQyXK11Mp1a7ehes3pC5exZj/
        IbhyoxO1lx0KiPBy3pdhDPlkYyES
X-Google-Smtp-Source: ABdhPJwa+gRKE6eBlTLeaLVJZhBfgAioJKfLU93Hh+/x1GuXCSQkW6K7lYO+kFmqv9V/I7EsOC/vTg==
X-Received: by 2002:adf:c789:: with SMTP id l9mr200425wrg.41.1597246549365;
        Wed, 12 Aug 2020 08:35:49 -0700 (PDT)
Received: from [192.168.1.240] (192.252.189.80.dyn.plus.net. [80.189.252.192])
        by smtp.gmail.com with ESMTPSA id q7sm4565157wra.56.2020.08.12.08.35.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Aug 2020 08:35:48 -0700 (PDT)
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Does git-apply --recount search a extra line?
To:     Kyohei Kadota <lufia@lufia.org>, Git List <git@vger.kernel.org>
References: <CAFMepc=iqyHG7V4LPcyZ-fmmWp176YpW_88joLtYxQrpsM5UFA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
Message-ID: <86d2176b-afa7-6c39-7d1c-489895ca1fab@gmail.com>
Date:   Wed, 12 Aug 2020 16:35:47 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <CAFMepc=iqyHG7V4LPcyZ-fmmWp176YpW_88joLtYxQrpsM5UFA@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB-large
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Kyohei

On 11/08/2020 07:16, Kyohei Kadota wrote:
> I just found a strange error in git-apply --recount.
> 
> ======= output ========
> % git --git-dir= apply --check --recount -p1 -v <patch.diff
> Checking patch main...
> error: while searching for:
>      mountfs\
>      configdist\
>      confignet\
>      mountdist\
>      fmtventi\
>      download\
>      copydist\
>      bootsetup finish stop\
>      stopether stopppp\
> -- /n/sources/plan9/sys/lib/dist/pc/plan9.ini.cd    Wed Apr 13 21:19:21 2011

There's no "diff ..." header which git inserts before every file between 
the two files in the patch so when it is recounting it treats the "--- 
/n/sources..." as a continuation of the current hunk

Best Wishes

Phillip

> error: patch failed: main:8
> error: main: patch does not apply
> 
> ======== patch.diff ========
> diff -Nru /n/sources/plan9/sys/lib/dist/pc/inst/main /sys/lib/dist/pc/inst/main
> --- /n/sources/plan9/sys/lib/dist/pc/inst/main    Fri Apr  1 15:10:39 2005
> +++ /main    Sun Sep 18 00:00:00 2011
> @@ -8,9 +8,9 @@
>       mountfs\
>       configdist\
>       confignet\
> +    download\
>       mountdist\
>       fmtventi\
> -    download\
>       copydist\
>       bootsetup finish stop\
>       stopether stopppp\
> --- /n/sources/plan9/sys/lib/dist/pc/plan9.ini.cd    Wed Apr 13 21:19:21 2011
> +++ /plan9.ini.cd    Tue Nov  1 00:00:00 2011
> @@ -5,6 +5,7 @@
>   dmamode=ask
>   adisk=/dev/sdD0/cdboot
>   cdboot=yes
> +installurl=http://148.251.6.120/plan9/download
>   # console=0
>   # baud=9600
> 
> ======== main ========
> #!/bin/rc
> 
> # must be topologically sorted (by prereq)
> tasks=(\
>      configfs\
>      partdisk prepdisk\
>      fmtfossil\
>      mountfs\
>      configdist\
>      confignet\
>      mountdist\
>      fmtventi\
>      download\
>      copydist\
>      bootsetup finish stop\
>      stopether stopppp\
> )
> #    startether startppp stopether stopppp download\
> 
> ======== plan9.ini.cd ========
> partition=new
> mouseport=ask
> monitor=ask
> vgasize=ask
> dmamode=ask
> adisk=/dev/sdD0/cdboot
> cdboot=yes
> # console=0
> # baud=9600
> 
> [install]
> nobootprompt=local!/boot/bzroot
> bootfile=sdD0!cdboot!9pcflop.gz
> 
