Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E333C7EE24
	for <git@archiver.kernel.org>; Fri,  2 Jun 2023 09:57:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235096AbjFBJ5r (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 2 Jun 2023 05:57:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233994AbjFBJ5q (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Jun 2023 05:57:46 -0400
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C50CC0
        for <git@vger.kernel.org>; Fri,  2 Jun 2023 02:57:45 -0700 (PDT)
Received: by mail-wr1-x42f.google.com with SMTP id ffacd0b85a97d-30aef0499b6so1673900f8f.1
        for <git@vger.kernel.org>; Fri, 02 Jun 2023 02:57:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685699863; x=1688291863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=50XeSYM7+ammbid6KiGl+I/Lq0WR3NwR7k8KIqx4/GQ=;
        b=mI1ds975Ep9/LSf9GINFcHaEOPm8mHjgbEYiauzM+DUNXkyYWNS2QEZBBbuEZE0dyE
         rVVgYhq/YuQkDB6RI246D6JLlt6qqhuUzPVvDB26+y0Ahj042+4mJH7fTSUs3T0D5zbj
         Ah/YmAS8TveMHvUUH5hWYtJ5ec8mrHKAsSX+hWcIsY3kNQiW8oxVxNpIjzuBEiFc0znk
         BZkEaro9D7hPYxvmVPKHk6UBozPKXG7OOv6V2z39Tp5SfTbUg7oaZHGIZQ0jtg7ZIlfS
         RgLocvM5+F26jt6wMsK5GHlSiV3KdwKwKvtvnmpAFqlehcpaHQe2XkjhowyDZCOdj7YY
         ReUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685699863; x=1688291863;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=50XeSYM7+ammbid6KiGl+I/Lq0WR3NwR7k8KIqx4/GQ=;
        b=YCTUHgU3W8/odhQYYHD+lkPUF4NJhwyuMGy3NV6GbBWrCm8kUfoaxHbKHPyr4DFjlb
         YzzHek/+PpGI/Mdxb2HMFVGmruCH5963ccYtyaxlRExAOMHg2GpjF4gssWJikCJ6WDRS
         lAeIbNzE0owphOTf0seYS/YB8bVU2lzs5PAqho3lwee66+lVWuRcsvWzRYztwdxZCz08
         3CTDM7Bl2SmjJo3sodFFDKD7KzL0My3+Jw4B93StFBIpO0iLPxyhJxMJTbgDYLiGLmdW
         7JeV6cHLbsLNWfYiXtGGHbaomvyZLontO2WFcE9uoHae1KespHRGSIWBOqMzDQoztBED
         YIFQ==
X-Gm-Message-State: AC+VfDyWSAiADbfl3rFmpa8iSUA662i4Ux4tWpLGNZ8IUnPalVfLtnEg
        X4lxLiTGHE6YQlj2NTZ++DFrm4xmMCg=
X-Google-Smtp-Source: ACHHUZ6WOG+ADbO1GzTiUHKdbvwgfH+Hfo5cPwGtU6yg17R8e2KcfZuasqlQ82hRrosc46AvVdgZ3A==
X-Received: by 2002:a05:6000:12cc:b0:307:9d2a:fd35 with SMTP id l12-20020a05600012cc00b003079d2afd35mr4327558wrx.53.1685699863426;
        Fri, 02 Jun 2023 02:57:43 -0700 (PDT)
Received: from [192.168.1.195] ([90.255.142.254])
        by smtp.googlemail.com with ESMTPSA id e30-20020a5d595e000000b003064088a94fsm1200277wri.16.2023.06.02.02.57.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 02:57:43 -0700 (PDT)
Message-ID: <6716d478-08a5-b9ef-f1a3-792f591506da@gmail.com>
Date:   Fri, 2 Jun 2023 10:57:42 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Automatically re-running commands during an interactive rebase or
 post commit
Content-Language: en-US
To:     Elijah Newren <newren@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     Paul Jolly <paul@myitcv.io>, git@vger.kernel.org
References: <CACoUkn7TmZ=trtDKcQm0SG5qCqK=-+YxrDV-7xYnLH_XK7K7og@mail.gmail.com>
 <CACoUkn6F_=JR5SYBWL2sVDxDVAZbxcV5Ruif6wLba-_q_QNiZg@mail.gmail.com>
 <198eea19-fc40-de0c-8854-3cdc94925f32@gmail.com>
 <CACoUkn4TOGi7xojSatEowF0CcFJHJof+F5XR-QtPTL5iznZDKw@mail.gmail.com>
 <cc93b0ed-1167-a017-2138-181a490d26e2@gmail.com>
 <CABPp-BEAnB-6ogcohMWMmktr9SrwMtM0-dw1pypcJedcMMcsCg@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CABPp-BEAnB-6ogcohMWMmktr9SrwMtM0-dw1pypcJedcMMcsCg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Elijah

On 31/05/2023 05:14, Elijah Newren wrote:
 >
> ... lots of helpful comments ...
> 
> Anyway, if you want a low-level do-a-merge thing, use `git merge-tree`.

Thanks for taking the time to explain that, I hadn't really paid 
attention to the changes to "git merge-tree" it looks nice - I should 
switch a couple of scripts I've got from using "git merge-recursive" 
over to that.

Best Wishes

Phillip
