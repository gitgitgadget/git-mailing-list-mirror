Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 019F5C636D3
	for <git@archiver.kernel.org>; Mon, 30 Jan 2023 18:58:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236967AbjA3S66 (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 30 Jan 2023 13:58:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229982AbjA3S65 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 30 Jan 2023 13:58:57 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41E143757F
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 10:58:56 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id m11so12015805pji.0
        for <git@vger.kernel.org>; Mon, 30 Jan 2023 10:58:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nkHha8UTGYmT2CG5ArSoE+VtCKYZXZ8OPVwHO8Fa93Y=;
        b=X5YVB24jzMgWjKvyxXKEuUL1xm+3EC1Jyo8/xONxQRWmVqYyDuxv15zkcs2dZLW66/
         JcjFGnFA1GmhXvzk1D34pSE/yQsFo2oC7A2GHUhae/rjsqlJHF0htZJxtd0dvtCcOAtY
         X+Vogw/9ZbPV0Th7y6wWhCis9tVBu2pB7wWQY4TPiCMkEd12fQYD/2b/XfQnrYKBtoLA
         ihpboMBNHyCu/C2gaNNNHIepQIOLXk4fmbyTGYbBlOODGZmI0xDV/BHUAVUyIbxTV9jA
         +m5Gaju1wCxFk1+9qZfJYjhamlLUI2MsqVxpdMTjssFBpkwd+FNhULJcwVjfzm2Z+tFx
         vIZg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:user-agent:message-id:in-reply-to:date:references
         :subject:cc:to:from:sender:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=nkHha8UTGYmT2CG5ArSoE+VtCKYZXZ8OPVwHO8Fa93Y=;
        b=BWfZgDNZAfO0A84mSNQUaHO2OJJGFCH1Mt+wpxGRFLpHV+rXgpRb4+OXOMrpkm5Qz5
         dv9QeSilcqLbh2jMhznJ7Jxcn8modsXrLoS6Da9Z5YNnHIAQcu76NaYukhSC55e0/XU2
         7DIg9Hiwb7yKnCMUu2y7q6tTHV0pDadCM451gepCchRGTYYoHRxWT+wC6ZtXeAqs9uPg
         mSdvNIBkvnmNxi3Oxqlr88MVY9dboBE5uou5h+UaSMDWP1KuB7izk/J9DjxDAgORqV9U
         Gkp9iYVMxHAYl3VqjNL+WxrkvU/coTOJvgYQoMEzTWKdnp0offGD0eAHp53/ObXo7qsx
         VIVQ==
X-Gm-Message-State: AO0yUKVkJyUbL0+Dfti+MRAfaLfBkh/etyrD8vYSYokyM5edGUWLLnAw
        VmN5FVSb3Vsx9wV7VaOQdyGQqSYUnkA=
X-Google-Smtp-Source: AK7set8X0lqRQX3hnupPb1XBu/u6te7Z0dOSYkzdluPtcEF2hfGf2XRGu/TfMe8iIyRYay3KA6odVw==
X-Received: by 2002:a17:903:24c:b0:196:3db5:c08b with SMTP id j12-20020a170903024c00b001963db5c08bmr21085784plh.69.1675105135667;
        Mon, 30 Jan 2023 10:58:55 -0800 (PST)
Received: from localhost (137.22.168.34.bc.googleusercontent.com. [34.168.22.137])
        by smtp.gmail.com with ESMTPSA id m6-20020a170902db8600b001947738ec7fsm8134155pld.158.2023.01.30.10.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:58:55 -0800 (PST)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     Victoria Dye <vdye@github.com>
Cc:     Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 3/3] scalar: only warn when background maintenance fails
References: <pull.1473.git.1674849963.gitgitgadget@gmail.com>
        <d75780e0567b5f765816ab7522afe550ebaa3521.1674849963.git.gitgitgadget@gmail.com>
        <xmqqleln90ka.fsf@gitster.g>
        <4913381a-769f-aba0-c04d-559d103e8396@github.com>
        <xmqq357v8poc.fsf@gitster.g>
        <b63611dc-a889-8900-403a-ec7c42a89705@github.com>
        <db04e31d-681f-5809-f51a-37b9c734b45a@github.com>
Date:   Mon, 30 Jan 2023 10:58:55 -0800
In-Reply-To: <db04e31d-681f-5809-f51a-37b9c734b45a@github.com> (Victoria Dye's
        message of "Mon, 30 Jan 2023 09:42:55 -0800")
Message-ID: <xmqqy1pj3l3k.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Victoria Dye <vdye@github.com> writes:

> I'm also still worried about cluttering scalar's UX with options that toggle
> use of its internally-configured options and features. One of the big
> selling points for including scalar in the upstream project ([2], [3]) was
> its ability to "intelligently" configure all of the settings a user would
> need to optimize a large repository *without* a user needing to know what
> any of those options are/what they mean. These settings are inherently
> subject to change (due to use of experimental features); exposing a feature
> toggle entrenches that setting permanently within scalar and makes a user
> aware of implementation details that were intended to be hidden. At a high
> level, it pushes scalar towards simply being an "opinionated" 'git
> config'-configurator, which was a model I explicitly tried to move away from
> while upstreaming last year.  

I personally do not think "opinionated configurator" is a bad model
at all.  And "this does not seem to work here, so let's silently
disable it, as the user does not want to hear about minute details"
is a valid opinion to have for such a tool.

I too share the aversion to command line option for this one.
Disabled periodic task support is most likely system-wide, and
passing --no-whatever every time you touch a new repository on the
same system does not make much sense.

Thanks.
