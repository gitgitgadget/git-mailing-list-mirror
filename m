Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 209ECC4332F
	for <git@archiver.kernel.org>; Tue, 13 Dec 2022 15:07:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235775AbiLMPHE (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 13 Dec 2022 10:07:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiLMPHC (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 13 Dec 2022 10:07:02 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D98C7A1BA
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 07:07:01 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id co23so15935930wrb.4
        for <git@vger.kernel.org>; Tue, 13 Dec 2022 07:07:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=q/0N6tDFeomnqCPJNIxYt7r0OTW0C9MHmEPqMxZafr0=;
        b=ECm5BeYZjliDEzska3Qaxe6xZFxfpnhCLvKAKKzruK86IQkwXysw4tyH87W8jvTM/9
         FEcqfgH+uzsYQGHwCdm8gkUEu1VFMXsDg0RFwfOfcgUmK+xvL8ucCGerFOzwfRrUaDiT
         ZPUs7lmKt7VQ4FPC+pGPZ0WEhS6pvKU6i1BZh4Z5AFXUQ8KssvzvzRNN4M6gcsv+D1Uj
         NoJdFr3KDKA3RUJ6Gji0WwafIsxzbPfTXBtzwy+VTMB9yizLrVJxwZmrSsVk1woyD/xt
         5r3Ktlxr7Xik5Y5cSOo4hWCkSFw5FRPl+6VYM3Msfa77yDWO0iSHrkoTl/Kf0kkzubsZ
         p4dA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q/0N6tDFeomnqCPJNIxYt7r0OTW0C9MHmEPqMxZafr0=;
        b=imYxhRVfJZUxCxjUDi2HGqGGhvEK+5bEzz6Hv6YdOYqub8ZO23Ip4M8L2ftH8SXTWs
         4Hw9E/q2H+pfAkEw0PVsFjwq7cLFJYMlEYTWxb/2L+CIPDO4wz+wuFKOja4pQs5n4p7v
         Csrjg0tdltwLeC2ZHUimlG7Z6vpsDVUMfynG1Q4GbmuSyhXv0QgmhSsey7aQScUm1sVg
         AIChaENELhkgey3/6CG9Sr1xW/p9O1Hc12IPvbcid65E6TZNpeBcG5B5CoTpXIVX7LBd
         nIVNHS3st7XxNZrfKDPcr4EXvkyqit5qCOpS1AMkvrM4rce6E07Q2wrxYRGHT//JO9wY
         kpKQ==
X-Gm-Message-State: ANoB5pnMNwIDZreBsqI82D/OsUTaQnUeoIEyZCLBkWXiSUrjt6m+PLs/
        yCIveni/25LjCQaFCNOxv0o=
X-Google-Smtp-Source: AA0mqf67eBKz0BvEzP42gTyFegpsvBV1Vi63VR+d1Mqlh5aUSjwuTgo08Pxud306ceDqDQqqezFwtA==
X-Received: by 2002:a5d:4b0b:0:b0:241:fd7c:4ce4 with SMTP id v11-20020a5d4b0b000000b00241fd7c4ce4mr12491442wrq.21.1670944020051;
        Tue, 13 Dec 2022 07:07:00 -0800 (PST)
Received: from [192.168.1.14] (host-92-2-151-214.as13285.net. [92.2.151.214])
        by smtp.gmail.com with ESMTPSA id v6-20020a5d6786000000b00241da0e018dsm34527wru.29.2022.12.13.07.06.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Dec 2022 07:06:59 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <1ea2be75-f67c-fa99-12ed-139825ec5c29@dunelm.org.uk>
Date:   Tue, 13 Dec 2022 15:06:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 1/1] cat-file: quote-format name in error when using -z
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>,
        Phillip Wood <phillip.wood123@gmail.com>
Cc:     Toon Claes <toon@iotcl.com>, git@vger.kernel.org
References: <20221209150048.2400648-1-toon@iotcl.com>
 <20221209150048.2400648-2-toon@iotcl.com>
 <93d61412-3786-b2b3-3fe8-4574336b08fb@dunelm.org.uk>
 <xmqq5yekyvrh.fsf@gitster.g>
 <ddae1940-f58f-e410-7606-d0bcf8d06cd3@dunelm.org.uk>
 <xmqq8rjdv5um.fsf@gitster.g>
In-Reply-To: <xmqq8rjdv5um.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/12/2022 00:11, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> Without "-z" you cannot pass object names that contain newlines so not
>> quoting the output does not cause a problem. We could start quoting
>> the object name without "-z" but we'd be changing the output without a
>> huge benefit.
> 
> That's fair.  The next question is from a devil's advocate:
> is switching to the full cquote the best thing to do?
> 
> If we were using the full cquote from the very beginning, of course
> it is, simply because that is what is used in all other places in
> Git.  Using the full cquote does mean a LF byte will be protected
> (i.e. instead of shown literally in the middle of other letters
> around LF, "other\nletters around LF" would be shown), but pathnames
> with backslashes and double quotes in them that have been shown
> without problems would be shown differently and will break existing
> parsers, which are written lazily with the assumption that they are
> perfectly happy to be "simple" thans to not having to deal with LF
> (because in their environment a path with LF in it do not matter).
> 
> A bit safer thing to do is to replace LF (and not any other bytes
> that would be quoted with full cquote) in the path given in these
> messages with something else (like NUL to truncate the output
> there).  As these answers are given in order, the object names are
> not absolutely needed to identify and match up the input and the
> output, and properly written parsers would be prepared to see a
> response with an object name that it did not request and handle it
> sanely, such a change may not break such a parser for a path with
> any byte that are modified with full cquote.
> 
> The above is with a devil's adovocate hat on, and I do not care too
> much, as I do not think butchering backslash with full cquote would
> not hurt even existing Windows users (if "HEAD:t\README.txt" named
> the same blob as "HEAD:t/README.txt" on a platform, doubling the
> backslashes in the output would have made quite a lot of damage, but
> I do not think we allow backslashes to name tree paths).

By default quoting also affects names that contain non-ascii characters. 
If we're worried about that we could only quote names that contain LF 
but as you point out the answers are given in order so I don't think 
there should be a problem with calling cquote unconditionally. (As this 
option has only existed for one release I suspect there aren't that many 
users yet as well)

Best Wishes

Phillip

> By the way, there is another use of obj_name in batch_object_write()
> that can show whatever byte in it literally to the output.
> 
> Thanks.
