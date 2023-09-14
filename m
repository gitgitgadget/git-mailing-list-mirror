Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9E6CEEAA41
	for <git@archiver.kernel.org>; Thu, 14 Sep 2023 13:50:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239107AbjINNuI (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 14 Sep 2023 09:50:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239028AbjINNuH (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 14 Sep 2023 09:50:07 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D1BE1AE
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 06:50:03 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-403012f27e1so10195725e9.1
        for <git@vger.kernel.org>; Thu, 14 Sep 2023 06:50:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1694699402; x=1695304202; darn=vger.kernel.org;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=fDRJRYkvnvoapyG5v4iyxbL2A6GwUZRwgOgNwDsuR6Y=;
        b=NntZjFDILSNnoeih3cWYFSHyQ6dFsAGSaUT7U7LLbyniDjGzZiFy3LxiJfkDR3G/Il
         Ny+Ogrel3MkOQSo6SJPRTz4HUJZOVLrhqLFwBqj2f3S5wLVYz4axGyW1d0z13OHBrHEo
         X6cXaibAVP52QRTpUVqVjXDQ9dInqkqO2af6qPjQMOZVxYIcaNrjzrCs4Yn0uW0YPQ2j
         oQ6JZoXutUuhwpgfYrArTYaFjZG7gY+aNhKpIcV1gX6ZhroKcwW4fF5qmGW2MV+DIfat
         l0WNBylk0Uxz3WTZGbBRaElageAxvfENbEkOYnheTvDjZY4LK/LtfuYyvZU/e3KlX+3K
         gB0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1694699402; x=1695304202;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=fDRJRYkvnvoapyG5v4iyxbL2A6GwUZRwgOgNwDsuR6Y=;
        b=R+ypGDSnHSlizFbsD+2M9cd+8EZK8+C29t1KNxchA1UJvr6xKqNzqbazuT9APyJcvR
         RAE1MvWPAXOAsaUyNsN/li5ucOid0nxEXjqIreacwgtkaefSRbIKCVQlEZ0jlr/oSpzD
         dHVDFn2xNYT6aagLrQPx7id2XXQ4xpPYQx4AWCb8PumkD9hN3OTmt9AjSJZwHUosdrvw
         KbKcDShUxWt05HcV0UlZgyx75Lv8UtqJHLZu2MDtLYKlJW7MRFGYL6SFcClPmksX5mdA
         02Z8o4NjEBwh947N9VTjAiWngoyhJErJ/Rbsli1H5zu1qW8QD1jaNww29YN/py94ASWy
         fZlw==
X-Gm-Message-State: AOJu0Yzey14BQNeL1xNOHLmDGq8jfFlG+7FCXr/eZYxzoYrr++o+L46D
        xBBgl2bNrWDDRdfLjSriKjo=
X-Google-Smtp-Source: AGHT+IE1AZcFg+3rUPSHTZFgjgwOaIj/DL04raeItd0NHHUGYLasaU5dyt2cqn5T85yMagyhWuussw==
X-Received: by 2002:a7b:c8d1:0:b0:401:bd2e:49fc with SMTP id f17-20020a7bc8d1000000b00401bd2e49fcmr4614747wml.24.1694699401619;
        Thu, 14 Sep 2023 06:50:01 -0700 (PDT)
Received: from [192.168.1.101] ([90.242.223.1])
        by smtp.googlemail.com with ESMTPSA id 16-20020a05600c029000b003fee8793911sm2021431wmk.44.2023.09.14.06.50.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Sep 2023 06:50:01 -0700 (PDT)
Message-ID: <f7f29dc3-c5cb-4522-95db-1bf13bd1e416@gmail.com>
Date:   Thu, 14 Sep 2023 14:50:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] rebase -i: ignore signals when forking subprocesses
Content-Language: en-US
To:     Jeff King <peff@peff.net>, phillip.wood@dunelm.org.uk
Cc:     Phillip Wood via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Junio C Hamano <gitster@pobox.com>
References: <pull.1581.git.1694080982621.gitgitgadget@gmail.com>
 <20230907210638.GB941945@coredump.intra.peff.net>
 <9ba22d4b-3cbe-4d4a-8dba-bc3781e82222@gmail.com>
 <20230914095601.GE2254894@coredump.intra.peff.net>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <20230914095601.GE2254894@coredump.intra.peff.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/09/2023 10:56, Jeff King wrote:
> On Fri, Sep 08, 2023 at 10:59:06AM +0100, Phillip Wood wrote:
> 
>> Do we want a whole new session? As I understand it to launch a foreground
>> job shells put the child in its own process group and then call tcsetpgrp()
>> to change the foreground process group of the controlling terminal to that
>> of the child. I agree that would be a better way of doing things on unix.
> 
> One thing I am not clear on is the convention on who does the process
> group and controlling terminal setup. Should Git do it to say "I am
> handing off control of the terminal to the editor that I am spawning"?
> Or should the editor say "I am an editor which has a user interface that
> takes over the terminal; I will control it while I am running".

As I understand it the editor has a controlling terminal (assuming there 
is a controlling terminal associated with the editor's session id), not 
the other way round. If the editor is launched in the background then it 
will receive SIGTTIN when it tries to read from it's controlling 
terminal which stops the process unless the process installs a signal 
handler.

> The latter makes much more sense to me, as Git cannot know how the
> editor plans to behave. But as I understand it, this kind of job control
> stuff is implemented by the calling shell, which does the tcsetpgrp()
> call.

Yes, my understanding is that the shell puts all the processes in a 
pipeline in the same process group and calls tcsetpgrp() if it wants 
that job to be run in the foreground.

> So I dunno. It sounds to me like the "right" thing here is making Git
> more shell-like in handing control to a program (like the editor) that
> we expect to be in the foreground of the terminal. As opposed to the
> "ignore SIGINT temporarily" thing which feels more like band-aid. But
> I'm wary of getting into a rabbit hole of portability headaches and
> weird corners of Unix terminal-handling conventions.

I'm wary of that too, it has the potential to end up adding a lot of 
fiddly code checking if git is in the foreground or background and 
propagating SIGTSTP and friends up to the shell. In any case we'd need 
the "ignore SIGINT" thing for windows anyway. Ignoring SIGINT and 
SIGQUIT in the parent is what system(3) does. As long as git exits 
promptly when the interrupted child is killed I think that is 
reasonable. Would you be happier if we re-raised the signal once we have 
cleaned up any state that needs to be written before exiting?

Best Wishes

Phillip

