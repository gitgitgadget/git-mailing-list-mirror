Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B4D5C77B72
	for <git@archiver.kernel.org>; Thu,  6 Apr 2023 09:51:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236270AbjDFJvv (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 6 Apr 2023 05:51:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237058AbjDFJvW (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 6 Apr 2023 05:51:22 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09B3D83E1
        for <git@vger.kernel.org>; Thu,  6 Apr 2023 02:49:57 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id l15-20020a05600c4f0f00b003ef6d684102so19906993wmq.3
        for <git@vger.kernel.org>; Thu, 06 Apr 2023 02:49:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680774572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=3x0v+EPVVxJNENcZ7Oa6uvR8mSPLi3ZjSS3tir3v7Fw=;
        b=b86qT0qRwSnZerdf5oE5MTGxMn1bRIw51KwtDLq4awQGUqYF1ZWqxCCob6/WpWGNp9
         XSSkszGqDneawdBOI8i4Qzk6CaUob8z0W6dfRLSuMrjU8OfGBXiAs7VuomRJv+kN6t2H
         0KYPcTD3OJmaZDrBar2P5/ZZVDc/DxJzAU71zu59m5rHiF7ftiE+jfhMefaLmesWP3qG
         ZPLz6p6rZcKUyWIIlQZ6zKg2jEY87N0aHksaGAyo2y24nDd+EW2Uof1p1gzhVS8lYFv7
         z/LPQ5mPtfN694tH2fQcLUfSdNBOq4wc+fQVkGZOjRLIHOMw8M0NvmFW7eo3qg76L+rF
         lY0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680774572;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3x0v+EPVVxJNENcZ7Oa6uvR8mSPLi3ZjSS3tir3v7Fw=;
        b=rHbnyCWRwrPqc/jgZ1+r0R0SwK7t0UvFgVQiJtLM4V7GZsUtQNnNXwrIJHkTEJSA3J
         GHaIA3853grPCDU+Nz7SVbAZEOoSwDK49hhpBIpsLGVDXFunobQipO4jLWKE79wVzst9
         67OzoS7q/arMlYUl0iyVy4sIwBIIMeHO/ztPTo83+lMNdVTzX3ApSLPdC3vFk+Fvxjiz
         lEa41T99wzB7+Z1xSrS/C9yv2vuFWd0/HOcAfr0EBzRIvFk4HZ9z1luOV53da79Krpvw
         bscuvA3Jjc4nTGCBEP871JQLCkjtbw8ME13p8LaGFKoJK54ZOvHrUWPKwTMeHc6k4sU5
         ngfg==
X-Gm-Message-State: AAQBX9f1H1/wk/2VuNFbv05G+F1uPWj3/5i+DnZXinNOi7fZwKZWi2Ey
        5lSSAOw8ik8pStOuvJsCWXdBWMtMNkM=
X-Google-Smtp-Source: AKy350bp0tNU7SquliLcU8I5QjSa8JShxGT1EcKdZi2o/LQhaku6HcvnIAqGNe92Pf4keRIKHPXnig==
X-Received: by 2002:a05:600c:25a:b0:3ed:237f:3da with SMTP id 26-20020a05600c025a00b003ed237f03damr7492220wmj.22.1680774572556;
        Thu, 06 Apr 2023 02:49:32 -0700 (PDT)
Received: from [192.168.1.195] ([90.253.53.152])
        by smtp.googlemail.com with ESMTPSA id t16-20020a05600c451000b003ef66c89af0sm8192516wmo.0.2023.04.06.02.49.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 02:49:32 -0700 (PDT)
Message-ID: <51aca4bd-0f2b-0689-4b51-260349cc4151@gmail.com>
Date:   Thu, 6 Apr 2023 10:49:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: Possible bug in git-rebase man page
To:     Stefan Haller <lists@haller-berlin.de>, git@vger.kernel.org
Cc:     johannes.schindelin@gmx.de
References: <db535468-c991-df18-61bd-ec312fdb5ca0@haller-berlin.de>
Content-Language: en-US
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <db535468-c991-df18-61bd-ec312fdb5ca0@haller-berlin.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Stefan

On 05/04/2023 18:36, Stefan Haller wrote:
> The git-rebase documentation has an example for a git-rebase-todo file
> when --rebase-merges is used; one of the lines in that file is
> 
>    reset refactor-button # Use the Button class for all buttons
> 
>  From reading the code that parses the file, this doesn't seem to be a
> valid line; as far as I can see, comments are not supported for reset or
> label. The label is the entire rest of the line after the command.
> 
> Just wanted to confirm that I'm not missing anything.

You're right that comments are not supported for labels, but for the 
reset command do_reset() ignores everything after the label so it does 
effectively support comments. I've got some patches to support comments 
on other commands which I'll hopefully submit before too long.

Best Wishes

Phillip

> -Stefan
> 

