Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19852C05027
	for <git@archiver.kernel.org>; Mon, 23 Jan 2023 15:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232881AbjAWP4R (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 23 Jan 2023 10:56:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232970AbjAWP4P (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 23 Jan 2023 10:56:15 -0500
Received: from mail-vs1-xe30.google.com (mail-vs1-xe30.google.com [IPv6:2607:f8b0:4864:20::e30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C3243C34
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:56:12 -0800 (PST)
Received: by mail-vs1-xe30.google.com with SMTP id k4so13371970vsc.4
        for <git@vger.kernel.org>; Mon, 23 Jan 2023 07:56:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bZo37c3pTyd5UI6GJWOOZGWs2dS+xF+fIhcOuV6PWxw=;
        b=WDZdv2LxRS8b6HEdbIzVFVJao/0qDQfjHKkecqw5JdlovK8+sZ6sg6pWIoxFizyHKp
         +Zk1WgOySRltLNRf/brLXfzchE6L8On0Q3zHb0ko9vH5o6gwtz62sJpwALTM9ja/9/iw
         DIFJ0O0JPAAQuKBVzS7rGqhEqomYjSSDXiNe97sldV+ht8Y4ZHmB+/6vp9e0xZUJLjdc
         6jWitHudI3AayacpEjoTujC2vCrG+jfLwDdb/L4CCqb8eLr6awcGHJARPspAh/WKswVZ
         c3bQvlg6yERw60p239IGfh8dtf8Z7cmRhQs9AejY+Hd7DFNkTcnoIMEA0K+IeJ1/Hoc6
         J1vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bZo37c3pTyd5UI6GJWOOZGWs2dS+xF+fIhcOuV6PWxw=;
        b=KjJhOUsiVENqROirM4G2EkSMN/4+PL/81488i/sQ91LKM466wd/cm7t3iO6M8SmWmh
         /QZaCRBH1S0c2LaBqVIMeC1bERi72+qcnguJ3HvaMmor3qrlMmjpHzi/5CTTvAlni76E
         fS9o8QuOjjTKG7JsBDWfjZ9mX3KyA6AQO9R9LdvIgPp03lKizNpQr9q/zs7LavGNDQ6a
         xSAJ2znbxzj0DIcKdGjp+KBq3mXIautcePaVdo0/QuS1PDHi8vpvieMW2BosJy5zZtUJ
         9GLdG8KqlkLykUJUhsZfxSgA1wZhYbFg81NJLRvQZffHvWJUMXWs7FulyUoB4ly+PleF
         50UQ==
X-Gm-Message-State: AFqh2koSkEP8vAqNpitKb5inxKqOSHToYD8eZGmRj/o4rb7GL5h4x0/G
        jAhynVQoqLSu90GLWra391UM
X-Google-Smtp-Source: AMrXdXuWlTJW9uq6J/LN0pSQktBjs6qM1o5fErK89PvNHv45n9d132W5bSUdJnVIV7kpEozgjF+3Yw==
X-Received: by 2002:a05:6102:3d8e:b0:3d2:4b17:34a0 with SMTP id h14-20020a0561023d8e00b003d24b1734a0mr13968291vsv.15.1674489371067;
        Mon, 23 Jan 2023 07:56:11 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:dc71:f436:bb74:17c2? ([2600:1700:e72:80a0:dc71:f436:bb74:17c2])
        by smtp.gmail.com with ESMTPSA id x4-20020a05620a258400b006fca1691425sm31890704qko.63.2023.01.23.07.56.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 23 Jan 2023 07:56:10 -0800 (PST)
Message-ID: <1d9748df-4f54-908d-75cf-49ff1d154fcb@github.com>
Date:   Mon, 23 Jan 2023 10:56:05 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 0/9] rebase: fix several code/testing/documentation
 issues around flag incompatibilities
To:     Elijah Newren via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Elijah Newren <newren@gmail.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        =?UTF-8?Q?Martin_=c3=85gren?= <martin.agren@gmail.com>,
        Phillip Wood <phillip.wood123@gmail.com>
References: <pull.1466.v3.git.1674266126.gitgitgadget@gmail.com>
 <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <pull.1466.v4.git.1674367961.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/22/2023 1:12 AM, Elijah Newren via GitGitGadget wrote:
> We had a report about --update-refs being ignored when --whitespace=fix was
> passed, confusing an end user. These were already marked as incompatible in
> the manual, but the code didn't check for the incompatibility and provide an
> error to the user.
> 
> Folks brought up other flags tangentially when reviewing an earlier round of
> this series, and I found we had more that were missing checks, and that we
> were missing some testcases, and that the documentation was wrong on some of
> the relevant options. So, I ended up getting lots of little fixes to
> straighten these all out.

Wow, this really expanded since I last looked at it. Thanks for taking on all
of that extra work! (That was not my intention when recommending that you take
over the fix.)
 
> Changes since v3:
> 
>  * Corrected the code surrounding --[no-]reapply-cherry-picks, and extended
>    the testcases (Thanks to Phillip for pointing out my error)
>  * I went ahead and implemented the better error message when the merge
>    backend is triggered solely via config options.

I really appreciate this extra attention to detail. I'm also really happy with
how you implemented it, using different variables to signal how the option was
specified (and using -1 for "unset" in both cases).

While I had not been following version 2 or 3, I read this version in its
entirety and everything looked good to me. These improvements to our docs,
tests, and implementation will be felt by users.

Thanks!
-Stolee
