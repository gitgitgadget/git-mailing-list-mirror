Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 192C1C6FA8E
	for <git@archiver.kernel.org>; Thu,  2 Mar 2023 10:19:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229991AbjCBKTs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Mar 2023 05:19:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjCBKTr (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Mar 2023 05:19:47 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3065A126C1
        for <git@vger.kernel.org>; Thu,  2 Mar 2023 02:19:41 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id r18so15998625wrx.1
        for <git@vger.kernel.org>; Thu, 02 Mar 2023 02:19:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677752379;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=k5y8YvT39xQviXlnFjueGizfx13GUCyCcej4AQijRGI=;
        b=LuvyF1GtjJQ5jD+yPlM5WjEk9/UymfoLA/yaWibvm16qwA6SY4blzoCKsdzApwLGdw
         J4BuiiZ3RxCq749bHlvaoyNZJHkysGqy+3LOgV6WUewC4EavbRWEvv3ZULWHejvtnVlZ
         jos/tiHRwYhpSOCvvwVAgw+dL7/Rp3J9Lg1XCLpBTG6EGgdUMR7Bz/AW5aQXncEqMWMD
         86pAyGQmIQiracy6GVeIGHDQct9Mt0v7lYRbfYA/6utwTEsWdlmT3DbNCbYcYL/iV0ZD
         bsucLeDLaDvqhRUseGSUiW4DyWlpqWGvokP0KJ2y4gpL0HaAfLIPY+M+paz9RKCM4xC0
         Ammg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677752379;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=k5y8YvT39xQviXlnFjueGizfx13GUCyCcej4AQijRGI=;
        b=1OI6MT9WaTm552H4Yf8EY53k9+yqs2kC8wOcZtBKmbJvrR0j7ekQzg98JNbrJ4T5V/
         DFEgUVGEYrQxWQLraBlUR3KtponvY7Rzs6eZ5xBbsoOi1quWYz0xh2rynJJbKf0nMAyi
         fbZfNOqofB3Ue3bPSQcTOY4tLuopg2bY9OYtW5JMMndFmW1P/yl2Xq23puWeUmVQplA4
         /SM0Iqx50gG1mBvikWLoTz2p7+evGwBMxPeZyH4hsciCOXpi0TzojvAAYWvpwrosytiQ
         z7r+ia2zHaeYwlSWJXqRhgs/NMdQ91NN4eVXQzHFlRsi0+TetRgBqRn2VPh0Fta7d72n
         +c+Q==
X-Gm-Message-State: AO0yUKVhUiYpoK+C5GxdQMSL5yHTQwuj3+vy58Nq731b7A+FXJoIFg7X
        UNsb7NI2DjMxLYNif9HPWW0xGEWJ3T4=
X-Google-Smtp-Source: AK7set9l8UnWCBGOePC2bv0I48sv4SX48sr0ZnO6Ji1/0ayRqufbKodIpU1s/NQTtNdYTJT7R7klhw==
X-Received: by 2002:a5d:400d:0:b0:2c7:6cd3:638a with SMTP id n13-20020a5d400d000000b002c76cd3638amr6472467wrp.65.1677752379717;
        Thu, 02 Mar 2023 02:19:39 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id k21-20020a7bc415000000b003e206cc7237sm2392395wmi.24.2023.03.02.02.19.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Mar 2023 02:19:39 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <374f83c2-7bf0-38be-26ae-de28340c37d2@dunelm.org.uk>
Date:   Thu, 2 Mar 2023 10:19:33 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: When exactly should REBASE_HEAD exist?
Content-Language: en-US
To:     Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
References: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
In-Reply-To: <961e68d7-5f43-c385-10fa-455b8e2f32d0@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan

On 28/02/2023 12:55, Stefan Haller wrote:
> As far as I can tell, REBASE_HEAD always points to the last commit that
> was attempted to be applied in a rebase, not matter whether that attempt
> was successful or not. In other words, when you break in a rebase with
> "edit" or "break", REBASE_HEAD is the same as HEAD 

As you said at the beginning REBASE_HEAD points to the commit that we're 
trying to pick, so it will only be the same as HEAD if the pick was 
successful and it was not rebased onto a new parent. I think it is 
useful to have REBASE_HEAD set when editing a commit as I find it is 
sometimes useful to look at the original commit. I don't think we do (or 
should) set it when rebase stops for a "break" command or a failed 
"exec" command.

>(except when you
> break before the first commit, in that case REBASE_HEAD is unset).
> 
> I wonder whether it would make sense to set REBASE_HEAD only when
> applying a patch failed. That seems to be the main use case of it.

As I mentioned above, I think having it available when editing a commit 
us useful.

> The reason why I am asking this is: I'm using lazygit, which, during
> interactive rebases, shows a combined view of the real commits that were
> already applied, and the remaining commits that are yet to be applied
> (it gets these by parsing rebase-merge/git-rebase-todo); something like
> this, when I set the 2nd commit to "edit":
> 
>    pick   4th commit
>    pick   3rd commit
>           2nd commit  <-- YOU ARE HERE
>           1st commit
> 
> This is great, but assuming that the 2nd commit conflicted, currently
> the display looks like this:
> 
>    pick   4th commit
>    pick   3rd commit
>           1st commit  <-- YOU ARE HERE
> 
> I would like to extend this to also show a "fake entry" for the commit
> that conflicted, if there is one. REBASE_HEAD is perfect for this,
> except that I need a way to distinguish whether it was applied already
> or not.

Can you check the index for conflicts when the rebase stops?

Best Wishes

Phillip

> I currently do that by comparing it against HEAD, and only showing it
> when they are different. That doesn't always work though, e.g. when I
> amend the current "edit" commit.
> 
> Any better suggestions how to work around this?
> 
> -Stefan
> 
