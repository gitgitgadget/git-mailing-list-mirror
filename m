Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25475FA373F
	for <git@archiver.kernel.org>; Mon, 24 Oct 2022 20:17:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234109AbiJXURz (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 24 Oct 2022 16:17:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234077AbiJXURc (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 24 Oct 2022 16:17:32 -0400
Received: from mail-qk1-x72d.google.com (mail-qk1-x72d.google.com [IPv6:2607:f8b0:4864:20::72d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF258BF7D
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:34:34 -0700 (PDT)
Received: by mail-qk1-x72d.google.com with SMTP id 8so6629243qka.1
        for <git@vger.kernel.org>; Mon, 24 Oct 2022 11:34:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:from:to:cc:subject:date:message-id:reply-to;
        bh=AXUK7fd7vExVPLaB2FHsy2ElI7zJ7rxKJQvc/Ff7H+4=;
        b=Xz+O7AvAdaqUTzSLMwyJoNpDB3Etc0EgJWhxCBZAy85Vt9Sytl5FBuJwtQ2iDmYONU
         k1RmTrWrDHYpl05b/hovtPh0VSemfAIqtbMF8Q4B2zEiJG+BpCNSGPhFKBcy7T/QvfXG
         i9v0Ss3lO4M6Mh6rw9mnPk5E6FAIlJQKLTEp4c0+6Tb+Ki4EnbNv3gxVa1GDJgHnpWog
         GnwVPisrgwEIRGU4mGjX5+lI7tYI5JVM/m0/q46LM29d8mgMZAA7chsS48FehOrwd+d6
         CGRnv7OxWb/8sY0eXYve8pJ0/o37TfhjjOPPJosEKk4pormbMT929EWA0JpyemVuSMvz
         oLCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:references:in-reply-to:message-id:date:subject:cc:to
         :from:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AXUK7fd7vExVPLaB2FHsy2ElI7zJ7rxKJQvc/Ff7H+4=;
        b=wri7HeVgwEg3b2V2WXqk55N1WfoPVNUH0p1Zgvq/9pjNS0Jh9qcYwBrqGj3S7TZUyv
         qAml5dy1A5TFruQtRNnUdkh0ypbjZUf42ojcKnvZdrN8mE8CaccfgwaiI3qhJC9nQ9pw
         hjw1OTwVKvQGEVvlGXYJzzGrS7g5urCFJBVQtb3K4CSo/UC3qxxdTcfHrCgIpwMuNY1/
         wj6+LjApADu+qQ/b6BV/HGABn7l54FaPB61g4RdqKHIudXW2BmMV24ePnEQD1DWxc4di
         OAHnm2b1Ug5gFYFh/ngb+Qd54B/XrDoBa5sqaR5oLBeUCFDQKvpUlqm0THUcBIRiioL/
         1bbg==
X-Gm-Message-State: ACrzQf2TTGuFVFlxj49KK6h6F5kbV0VHnPHIfHJrS3AZtY0wzbZG9Qxq
        R7yzvbaer/tpkRBhB94O1vI=
X-Google-Smtp-Source: AMsMyM6EuxCk0c6GJONo8AT661WB1c6r0MLC96R+DCHJ/TBUML9fFtuL+m3qVN0vLreiLsRXc1SeWw==
X-Received: by 2002:a05:620a:29c9:b0:6ee:b283:423d with SMTP id s9-20020a05620a29c900b006eeb283423dmr23972460qkp.151.1666636420654;
        Mon, 24 Oct 2022 11:33:40 -0700 (PDT)
Received: from [192.168.1.171] (pool-71-187-159-144.nwrknj.fios.verizon.net. [71.187.159.144])
        by smtp.gmail.com with ESMTPSA id g21-20020a05620a40d500b006ee8874f5fasm455877qko.53.2022.10.24.11.33.39
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Oct 2022 11:33:39 -0700 (PDT)
From:   John Cai <johncai86@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     John Cai via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH 1/2] fsck: remove the unused BAD_TAG_OBJECT
Date:   Mon, 24 Oct 2022 14:33:39 -0400
X-Mailer: MailMate (1.14r5852)
Message-ID: <4FFF6EB5-B9A3-4E32-840C-3FD6E893F5BF@gmail.com>
In-Reply-To: <xmqq4jvtt7cd.fsf@gitster.g>
References: <pull.1369.git.git.1666623639.gitgitgadget@gmail.com>
 <f32ff5dc4eed5bffe8bb0759c408c3d0861ddb50.1666623639.git.gitgitgadget@gmail.com>
 <xmqqwn8ptb0p.fsf@gitster.g> <xmqq4jvtt7cd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio,

On 24 Oct 2022, at 14:16, Junio C Hamano wrote:

> Junio C Hamano <gitster@pobox.com> writes:
>
>> "John Cai via GitGitGadget" <gitgitgadget@gmail.com> writes:
>>
>>> From: John Cai <johncai86@gmail.com>
>>>
>>> The BAD_TAG_OBJECT msg-id is not being used anymore, so we can remove
>>> it.
>>
>> Do you have a ready reference to the change that made it no longer
>> needed (or stopped detecting the error the message was meant to be
>> issued against)?
>
> 2175a0c6 (fsck: stop checking tag->tagged, 2019-10-18) stopped
> checking the tagged object referred to by a tag object, which the
> error message BAD_TAG_OBJECT was about.  Since then the
> BAD_TAG_OBJECT message is no longer used.

Thanks for doing my work for me :)
