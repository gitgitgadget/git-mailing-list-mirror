Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 829BFC636CC
	for <git@archiver.kernel.org>; Mon, 20 Feb 2023 10:04:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjBTKEF (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 20 Feb 2023 05:04:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjBTKEE (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 20 Feb 2023 05:04:04 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4969C1714A
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 02:03:19 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id r7so325217wrz.6
        for <git@vger.kernel.org>; Mon, 20 Feb 2023 02:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=IRFinD+chYQYj7gNRgNhvPnLPI79BosDfwI3pUf+an4=;
        b=VUWHNpxAEx9zdotylzrbX9TsUTLVgckaN5ZtZP9h5m5Y/b2kUVfl+6kV9Um5Lz+PLq
         YTl4hIYy/WevZF4SuN2z80vugvfc9pzmylzC/jtEjVninIaoo86yhcBsdj6R0t9Ac2vh
         PIF0A5MHgDaafB+3hGFv5/mpYGCtXJMRzhJHhIYDTJe5QBnsnwgwI+9jLxR/lUJBdkRc
         4sNxJGT8HQjGeiroOcYG084ASfCKoadLANib+Eq6iQiEXrJQyKUsCjyQGC6MdD7k7Y/T
         koyFu5ylMyAsDDUAUlgKs1yDGJwL2brkgot7QFSixm3Vw13C/T/MJ23MhaPOAVJMS8eE
         3lFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IRFinD+chYQYj7gNRgNhvPnLPI79BosDfwI3pUf+an4=;
        b=ILEDAfSdnjp3ivVkQHxqPVjpzwvDMM2oSexe944uvFudI++8ZM7WCZ4f/GzxD7DAzK
         SiVi8O8/kzen6ZKK8FdwLvUdCp2iesu/9Xi7BiiwbfST/jxoV9IfdcPukJeMMagFOndW
         nTHXkiPW2y58+H1BIXpuV9ObadpAovOA9hdVnE494xe7Y6IET1DSN9P7LhPXvvLQNiAr
         wLOdaY87n8YwEfqDYQLKRaJ4AKHb/QQvXrXqGGA7KqbUmo8IXe1AIyzAV44PRBtxxLQD
         l5IyoKg2aIEUxU8bDXqJZtgGRZaCNDrWRNIl5PndcOoN0EGWLJ4E4hZZ3A36yUiWin6z
         Vu9Q==
X-Gm-Message-State: AO0yUKXTymk+yFCa9ZTRW6PX1aTTyIhizFspeOqSGe7Rob93Ck7L8j4f
        WELmxxy2bn1fD+aFb4ZdXVc=
X-Google-Smtp-Source: AK7set+0xAJu2iGAR2W+IIPsc7zPfvmZnRiqrq5bS2tnntUjDS8O40WfZ17BKK5HlhJ0IZJ/b8LtNQ==
X-Received: by 2002:a5d:6a04:0:b0:2c3:db98:3e87 with SMTP id m4-20020a5d6a04000000b002c3db983e87mr1073226wru.20.1676887396156;
        Mon, 20 Feb 2023 02:03:16 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id o18-20020a5d4752000000b002c3f9404c45sm52293wrs.7.2023.02.20.02.03.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Feb 2023 02:03:15 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <7a39050a-c857-a536-9637-04189c029eec@dunelm.org.uk>
Date:   Mon, 20 Feb 2023 10:03:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: check labels and refs when parsing todo list
Content-Language: en-US
To:     Derrick Stolee <derrickstolee@github.com>,
        Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <pull.1482.git.1676644675638.gitgitgadget@gmail.com>
 <0578e154-4c28-ffd9-03fc-5f9f5939cd17@github.com>
 <5a2a62cc-134c-adb0-7cab-c08c16c2dfdf@dunelm.org.uk>
In-Reply-To: <5a2a62cc-134c-adb0-7cab-c08c16c2dfdf@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 20/02/2023 09:24, Phillip Wood wrote:
> Thanks for you're thoughtful comments and suggestions

Hmm, perhaps I'm not quite as awake as I thought I was. I meant "your 
thoughtful comments" of course.

Best Wishes

Phillip
