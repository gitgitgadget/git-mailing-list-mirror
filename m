Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2F9C5C433EF
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 20:02:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1267E6117A
	for <git@archiver.kernel.org>; Wed, 10 Nov 2021 20:02:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231472AbhKJUEw (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 10 Nov 2021 15:04:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230345AbhKJUEv (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 10 Nov 2021 15:04:51 -0500
Received: from mail-oi1-x22e.google.com (mail-oi1-x22e.google.com [IPv6:2607:f8b0:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93BAEC061764
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 12:02:03 -0800 (PST)
Received: by mail-oi1-x22e.google.com with SMTP id q25so1786269oiw.0
        for <git@vger.kernel.org>; Wed, 10 Nov 2021 12:02:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=h0TBvQpC/fRVBJMB3E9jk03Eyv67GsYfTEpOFhbOh90=;
        b=mk5npYfiLwMX54OqJstoIHAA5dT6MipQ4WceqMnHOxz1XIotbSSx6j/VT9/+ElfxXM
         hxtrZzdEW86GwNAAdGsz7Ska9nl817uu4sPJYdjxuguSctgd7HMytDcfupw8PY3Ba7lH
         j9tOPvLjn1xCX/hChr497vff3o0qfXtw7tGLfl3bXCKjlgIOmOcsT+yGwlhiX8D547zn
         6YbJY+9ky6YHwdDYjjVVxQG5gjd78Hs2wOwi0xASLsBYbvFxsxod8rObU40pwFO0aJQe
         96roSAiTKQDEe8wSJl8Z4vtiB351wAb8s+K4R7bQLcDYpVgbPLZi7KuUT58fR1ehMVoO
         htFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=h0TBvQpC/fRVBJMB3E9jk03Eyv67GsYfTEpOFhbOh90=;
        b=ZNbYiJIiJF3thh8TKu3UMzAzFeqR5LIY/5GZc1skywX7xAXmUZ/Xuq8af/x+UemgaZ
         0v4dQN2WBsotYuC/1E6H8WWmbeZkp35erLTft1rbFNkef+3jOoFCBbwyGh/Oumg7HLib
         B7T5plRR79q69efWszFJuEul9+yDTJmWtfYk+0ieM/VXrZCJQI5Zw6Ni8QIvnb4SVxr8
         M3DWDK8S9WmOIgaAt7/edV5ObVU5Jd4PnNyqdiZdUMrvzuYexgNZhPK7MjdNrQfksEb1
         9pratcfoucroZIfooH5YEvNTCGO171Gjm3NSBylLbkT15HC1wvVJAYoOOmI2tyh/TZA+
         VHsA==
X-Gm-Message-State: AOAM531IsKiiqb0pdGZkL2R295tIy5bL8cEtKf1cVYDMmNPYaVU55/Hd
        nLXuwU7WcCavfI/bOaiUp/s=
X-Google-Smtp-Source: ABdhPJxD2fnV+AoLqUzTKJMriTXNxjd+EUu/imc5UdNpkI8SgiP9RUSI8wrmH3LgsgdIFYOD0o40Ng==
X-Received: by 2002:a05:6808:180c:: with SMTP id bh12mr1557978oib.152.1636574522803;
        Wed, 10 Nov 2021 12:02:02 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:64b8:5437:e398:f201? ([2600:1700:e72:80a0:64b8:5437:e398:f201])
        by smtp.gmail.com with ESMTPSA id f16sm173157ots.71.2021.11.10.12.02.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 Nov 2021 12:02:02 -0800 (PST)
Message-ID: <d4564a73-792c-4ad5-03da-e64d1571d092@gmail.com>
Date:   Wed, 10 Nov 2021 15:01:58 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.3.0
Subject: Re: [PATCH] maintenance: disable cron on macOS
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, lenaic@lhuard.fr,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1075.git.1636569360002.gitgitgadget@gmail.com>
 <xmqqh7cjyeqb.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqqh7cjyeqb.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/2021 2:47 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:
> 
>>     This one is really tricky because we can't notice anything is wrong
>>     without running git maintenance start or git maintenance stop
>>     interactively on macOS. The tests pass just fine because the UI alert
>>     gets automatically ignored during the test suite.
>>     
>>     This is a bit of a half-fix: it avoids the UI alert, but has a corner
>>     case of not un-doing the cron schedule if a user manages to select it
>>     (under suitable permissions such that it succeeds). For the purpose of
>>     the timing of the release, I think this is an appropriate hedge.
> 
> Reverting the "git maintainance run --scheduler=<scheduler>" topic
> altogether to give us time to stop and think may be another obvious
> option, but it probably is OK to tell macOS users that they may have
> cron but Git won't work with their cron with this patch.
> 
> In any case, let's leave it (slightly) broken for macOS folks by
> applying this quickfix.

I agree that we don't need to revert the topic.

> I was puzzled by the lack of a call to validate_scheduler() at the
> very beginning of resolve_scheduler(), by the way.  Or even earlier
> during the verification of the command line options.  I wonder if
> on macOS, --scheduler=nosuch and --scheduler=cron should behave the
> same way, both saying "unrecognized", instead of saying that only to
> the former and "not available" to the latter.

It's a bit strange, but the crux is that selecting --scheduler=X
makes the 'X' scheduler pass through the 'enable' path, while the
rest of the "available" schedulers goes through the 'disable' path.

This UI prompt occurs because we are trying to 'disable' cron
before enabling launchctl.

I think the biggest issue is how macOS uses non-standard ways of
requesting user permissions, because if 'crontab' simply exited
with a non-zero status, there would be no work to do here. Because
of that, I think we will always need to tiptoe around cron on macOS.

Thanks,
-Stolee
