Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BA28C433F5
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 06:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21F7160E78
	for <git@archiver.kernel.org>; Mon, 11 Oct 2021 06:43:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234270AbhJKGpj (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 02:45:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229797AbhJKGpi (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 02:45:38 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 377E3C061570
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 23:43:39 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id s11so9900960pgr.11
        for <git@vger.kernel.org>; Sun, 10 Oct 2021 23:43:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=fLBTqMcrGIeWOCmrBAb5MjCaY7gLuLLfk0blPwf9Qbs=;
        b=cXYDbd/7cYn03/Q/pUOIkiuLAkMLF4tx+K+0eMu+McJrqWBHKKr9k4XAA2r4hzJVLy
         hz2HmFK+HTib5RcPsd8PdiAF32sMDJVPblJBBSZ99AUcmlW8IwC0Jw2xNGA07I1Zom0x
         poeq4Jr1PltVqp+5py9KXV53AtDQ13aFt6FhX5rLNehN8oJEO2HetemKFq1DMyUE308e
         NX8vRoB58wdzjzt8zZxbL5oSm33iXPLbXWaKtEOdukO/jG+vMfhbS9NmiAJcUPWZ9Vla
         Mpmg4l266pPnNLES7emqiWNWpvEmzYjWQPsWXlKPXCRH7xjGpep3vpBGqBimkH6zKOLf
         3afA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=fLBTqMcrGIeWOCmrBAb5MjCaY7gLuLLfk0blPwf9Qbs=;
        b=1YRH4gutUQgM9yj5msvszT4gdyjrg3yi3+bekVJ2mzWNjCQU/wB7pRKx1pEqNrY8C8
         9oxsO+IBe/bIgJ5DLOALrer0jvu49efaOZaDFQyLSh8++ayIvXeNEviLO6xMpNyP8c2C
         1Hr79vTNf3Xv6ON/Fx2xJ9I2a4ghd2KAGmOPvyf9vlCEvMbzA0O6RFZmS6fk6jzhjSmj
         IjRvNa6Z0k/sPQwh3Y4KozohgAlyX50scsYUZtgbypCwFh7jHa2JT484swpFPuvSwXYO
         OlGMj23fnwyrwLrOjV/ZOvZbZ+rgzkhMo8FCPR9VcVjhxwexZhy6/J8xSYRfNMYKfvSk
         aLyQ==
X-Gm-Message-State: AOAM531No5r5tgGAEymeiznvnT3ha9B23HSHd1UfO+H27jZ5SyxsQFpW
        0AvV7j0Ay+QHqmPVjk+8uM4=
X-Google-Smtp-Source: ABdhPJzQwoW6CJgVnuQcvBpDp7QnPtUSji19mOYveVFeI9EHaGa8EBsXyx8tE2uBLisaMmn8nDiJcQ==
X-Received: by 2002:a63:2c02:: with SMTP id s2mr16820968pgs.205.1633934618655;
        Sun, 10 Oct 2021 23:43:38 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-65.three.co.id. [180.214.232.65])
        by smtp.gmail.com with ESMTPSA id x13sm7010439pgt.80.2021.10.10.23.43.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 10 Oct 2021 23:43:38 -0700 (PDT)
Message-ID: <38ba34f9-47e5-8059-7c16-6cf159c849ad@gmail.com>
Date:   Mon, 11 Oct 2021 13:43:35 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: git archive -o something.tar.zst but file info just says "POSIX
 tar archive"
Content-Language: en-US
To:     =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder.dev@gmail.com>
Cc:     Git Users <git@vger.kernel.org>
References: <e50a85f1-7be2-dab9-a453-fb93bdb71f3c@gmail.com>
 <20211010114025.GA571180@szeder.dev>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <20211010114025.GA571180@szeder.dev>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/10/21 18.40, SZEDER Gábor wrote:
>    $ git archive -h |grep -e ' -l'
>        -l, --list            list supported archive formats
>    $ git archive -l
>    tar
>    tgz
>    tar.gz
>    zip
> 
> Does it list zstd among the supported formats on your machine?
> 

Oh, I forgot to add `tar.tar.zst` config option.

Now `git archive -l` lists:

tar
tgz
tar.gz
tar.zst
tar.bz2
tar.xz
zip

and the corresponding .gitconfig are:

tar.tar.zst.command=zstd -c
tar.tar.bz2.command=bzip2 -c
tar.tar.xz.command=xz -c

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
