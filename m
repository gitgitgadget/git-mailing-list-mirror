Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BF37ECAAD8
	for <git@archiver.kernel.org>; Fri, 16 Sep 2022 23:11:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiIPXL2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 16 Sep 2022 19:11:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229777AbiIPXL0 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 16 Sep 2022 19:11:26 -0400
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAFDD7A53C
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 16:11:25 -0700 (PDT)
Received: by mail-pf1-x432.google.com with SMTP id w2so12334655pfb.0
        for <git@vger.kernel.org>; Fri, 16 Sep 2022 16:11:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=gtLdNYOjCZdlODNtXqxh6/9uiA2nA94II/FYAGm6oWk=;
        b=fLhJM61L3VMVRQzHsYATcIQYw0sjgjVHYyptwnQPNq+kaS0a4svbQ5sJQj1PNSzt8F
         VKwfWMtlt9CaJOOuxl4iur02mvQDFVAuC1fnYGbINJ2LbZCAwnoZpH6M8ABS/4CrOQCC
         e5RtVc8hjhj0yzo8Y5cdSwPdjh3Zno70Qt4GeIXW2s9a6i8bUiaPY3rHjUy8X0okTZ+Y
         lB59hbURrQgQE5VYsFsZfe6BF21XUp+CrVSzrsY24WbQ8kcAxNutSk+xTvGb2/yLskK9
         cmRMUKEBsyDFJMDEoETOWnrUwqzqm2yATY8hjl4RIKNXZVWuaGhyCewacgEDykaW1MQs
         vIwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gtLdNYOjCZdlODNtXqxh6/9uiA2nA94II/FYAGm6oWk=;
        b=EWtmUQ4AnAwN9Qf1YP9pOlN6tfUtKOB8WwyLYjOdpXhLTpq93+9dQ4rwZPSIH3xM2b
         J389ymjiE+lXV+hz2KnFppKlF2q/eh4FXXaH8lk82v/gXQln9tBZcM5zJlBl429UYYlk
         PiuiZiEGG5QlidyPTpqn7tYIUbVZjUQF09RnNcrpuCHtku6ZnnGySthRKgpgfaafwMmL
         AmfBmEQ1iAu3ngDMu5rNiZun8PWE8EzS+DD0iruAi2XMrUaPcRBAkzvw+eYjCXjfKH4y
         bF/SZW9KzWGOGgK1J2Nq71D4U5vuPKtBSeBlDWGMgQ7/k/cIq6p5NqCI22lNCihsvuho
         VeIQ==
X-Gm-Message-State: ACrzQf1EiMsqoN16EX9u8awORqZ8M/DC6M9i8Q4hmni9oh5nzHolZnjX
        DdNUrCSOa7Vlts1Rtl6/7ddhuAxEPe03
X-Google-Smtp-Source: AMsMyM4TaKTrFgA433koh/217N5VWWJHwZeI4SaTcE5PJijlNy6jFkUejSG8DQVwfIQtD2zF1+v+bA==
X-Received: by 2002:a05:6a02:28b:b0:439:19d6:fad5 with SMTP id bk11-20020a056a02028b00b0043919d6fad5mr6688051pgb.591.1663369885328;
        Fri, 16 Sep 2022 16:11:25 -0700 (PDT)
Received: from [192.168.0.104] (cpe-172-249-73-112.socal.res.rr.com. [172.249.73.112])
        by smtp.gmail.com with ESMTPSA id i21-20020a17090ad35500b002005c3d4d4fsm2011726pjx.19.2022.09.16.16.11.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Sep 2022 16:11:24 -0700 (PDT)
Message-ID: <5d02d3b8-dc79-a2d8-f5e1-129d2228ff23@github.com>
Date:   Fri, 16 Sep 2022 16:11:23 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.13.0
Subject: Re: [BUG] Non-portable Construct Introduced in diagnose.c (dirent) at
 v2.38.0-rc0
Content-Language: en-US
To:     rsbecker@nexbridge.com, 'Git Mailing List' <git@vger.kernel.org>
References: <011001d8ca20$bc4d81f0$34e885d0$@nexbridge.com>
From:   Victoria Dye <vdye@github.com>
In-Reply-To: <011001d8ca20$bc4d81f0$34e885d0$@nexbridge.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

rsbecker@nexbridge.com wrote:
> The dirent d_type field is not available on every system. This was
> introduced at 2.38.0-rc0 in diagnose.c
> 
> diagnose.c, line 79: error(1565): struct "dirent" has no field "d_type"
> 
>   		    e->d_type == DT_DIR && strlen(e->d_name) == 2 &&
> 
> (3 more issues in diagnose exist of this form).
> 
> The code should use the  NO_D_TYPE_IN_DIRENT knob to detect whether this is
> an existing field as defined in cache.h.

Apologies for missing that, I'll try to send a patch fixing it either later
today or sometime Monday.

Thanks,
-Victoria

> 
> This change breaks the build on NonStop systems (at least). I'm sorry I
> missed this during review.
> 
> Randall
> 
> --
> Brief whoami: NonStop&UNIX developer since approximately
> UNIX(421664400)
> NonStop(211288444200000000)
> -- In real life, I talk too much.
> 
> 
> 

