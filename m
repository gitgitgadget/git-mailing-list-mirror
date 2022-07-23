Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED92BC433EF
	for <git@archiver.kernel.org>; Sat, 23 Jul 2022 00:25:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232569AbiGWAZr (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 22 Jul 2022 20:25:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbiGWAZq (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 22 Jul 2022 20:25:46 -0400
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67DED1D321
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 17:25:45 -0700 (PDT)
Received: by mail-pf1-x42f.google.com with SMTP id w185so5726414pfb.4
        for <git@vger.kernel.org>; Fri, 22 Jul 2022 17:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=subject:to:references:from:message-id:date:user-agent:mime-version
         :in-reply-to:content-transfer-encoding:content-language;
        bh=auy8JDQGoonLI9PJ1aSQXoEeZisNjI2puMEyRL11sS8=;
        b=a9aBr0ZgXfBHrQkZ9cSqALkjHNxKzlRVsIfe5TDoLkBp4f+3Bl2p0N2PJi7N/7trul
         nSmznY2LsEQx5/HtzsNI9lR9psk+M53oSUirvXEB76qNaHonaMTtJjjMxl+VYQAbgcIe
         yMncaE8iP4c1tzeQkLT5gSmWQQ3/0URcPNCx/AYBgYd2BcaKO8zcn8ud7GUoe5azWWxO
         5y4A5u2BO29RbASGeJ4hIOcooDgqKHdqc5JM07JDCfijhRnfTRKIfBA9D0+WP+C8H1n4
         o/hIwQTs2wPgeD9sKJE2Sgfg85eJcwK1CXcEGNcrOuGyYMmut1ceAKi6vvT1uqOEA7p4
         4bhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-transfer-encoding
         :content-language;
        bh=auy8JDQGoonLI9PJ1aSQXoEeZisNjI2puMEyRL11sS8=;
        b=hJLf1h7p6kvHPpu6C6VzZ9rFyCMUKqabpsJWvG5de+j3Cid5J6CSn1LA4ahKXrxfNi
         +bNXpsrPXS+EjdU1BpjH4A06EsCaTnRgYoDrd3zDAzHJXBTe2hr/puzBpef7RFmg1hj1
         rE7TXtzirt+3VzPtA+YM5S6y/DXggpQmPrHYzKVr1xITfh5dxKezhF4i4rrryKfDujEw
         0246VisfqmWuzwtDhoUeJ34pNVh1ERBJPLoK+GVrcrQckmwYGSvW/Ctc8LJwhe9OxRA1
         LbJiyn8urSNP17qTY/Pgr0uPwPJhm5JSDvmnqQLLeFds2aSFh9oR0Hbs/j04cQOwTyUG
         ytVw==
X-Gm-Message-State: AJIora/fSr+nf/dTKTs2rPacKLgGmFiETq0gZCQBWRl/baOMxh8QGdiw
        rEOFucohxEgXy/oXMk6PN95dok+rk8En2w==
X-Google-Smtp-Source: AGRyM1tL6Pyb60CMcy8hj5ONfD44qlXgwXaUt2EeI6rhPPtcZ7gH/QDaR9oyzz4lL+VFB0JgsfFSbg==
X-Received: by 2002:a65:5b03:0:b0:415:933:d50b with SMTP id y3-20020a655b03000000b004150933d50bmr1942089pgq.13.1658535944382;
        Fri, 22 Jul 2022 17:25:44 -0700 (PDT)
Received: from cosmos.melik.windwireless.net (melik.windwireless.net. [206.63.237.146])
        by smtp.gmail.com with ESMTPSA id g16-20020a635650000000b0040caab35e5bsm3953514pgm.89.2022.07.22.17.25.43
        for <git@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 22 Jul 2022 17:25:43 -0700 (PDT)
Subject: Re: 'git clone,' build makes user non-writable files (should be
 option keep user-writable)
To:     git-l <git@vger.kernel.org>
References: <822787da-bc26-0d72-a5c4-808a3d10126e@gmail.com>
 <YtPtQ6qsIviyTBF2@zbox.drbeat.li>
 <158251f2-9fa4-45b7-4c24-907c94602b6e@gmail.com>
 <CAPx1Gvc6ci1CjhL-zjwqkR=4o2yQTrT0V_Hb9bUBNuaBn47M8A@mail.gmail.com>
From:   David Chmelik <davidnchmelik@gmail.com>
Message-ID: <ccbc1e81-b406-9e73-7aa5-956ffae7074b@gmail.com>
Date:   Fri, 22 Jul 2022 17:25:35 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.9.1
MIME-Version: 1.0
In-Reply-To: <CAPx1Gvc6ci1CjhL-zjwqkR=4o2yQTrT0V_Hb9bUBNuaBn47M8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 7/22/22 10:40 AM, Chris Torek wrote:
> On Fri, Jul 22, 2022 at 6:24 AM David Chmelik <dchmelik@gmail.com 
> <mailto:dchmelik@gmail.com>> wrote:
>
>     Ownership, permissions are different: one can own files yet have zero
>     permission to write/delete and be denied that. ...
>
>
> All true.  But Git has no control over, or affect on these: Git does
> not attempt to affect ownership or permission of any build products
> at all.  Git only attempts to affect the execute permission of
> specific files as directed by the committed file mode (and provided
> `core.filemode` is enabled).
Not even projects' .git* subdirectories?  They typically are/become 
user-non-writable though deletable with several/many confirmations so I 
usually sudo (recommended against).  I'd rather opt-out of .git* 
subdirectories for every clone.

> [...] If you're using Samba/CIFS or other ACL-based file servers [...]
I don't know what those are (other than once tried Samba to transfer 
files between home PCs, not for compiling).
