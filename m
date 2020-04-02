Return-Path: <SRS0=dTtN=5S=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FCDAC43331
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 17:52:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7429C2077D
	for <git@archiver.kernel.org>; Thu,  2 Apr 2020 17:52:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IPt3lZyb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388754AbgDBRw4 (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Apr 2020 13:52:56 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:47048 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388745AbgDBRwz (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Apr 2020 13:52:55 -0400
Received: by mail-ot1-f66.google.com with SMTP id 111so4315721oth.13
        for <git@vger.kernel.org>; Thu, 02 Apr 2020 10:52:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=UKLYQ0M5q3Zgsg2MnoVyrZ1UkiJE2nZARgIX+81Fo+I=;
        b=IPt3lZybP7Ly99cjeJo6tYTp3Nn16nWiyJALFUqfnLYBNsayeIGdpMtKWpDKFAGTqz
         3WAldzxQzuRSgN31e0G85y5GKwoq767T7rWYKNERbtpHBMmWJ9heU533mTOWkDWUUaU+
         Vj28hdNj/uohYU57lOH4mp6YkiWFseZlQ9HSTBqbeH64EeSBtgLfR89N0IU1yjdiUgLp
         8hVZxoYClHg/btE0FnJAwMDaIc4nivZhuwguFRsie7stgmFC7j9CrDPFkEfpkRgubE/L
         WU4q9EcwskvGu6Ld+Vo5rGK4u7UGgpwjRHydbzA1BcebgwsU+2AIJxrGk9KYycpLKZUe
         T76g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=UKLYQ0M5q3Zgsg2MnoVyrZ1UkiJE2nZARgIX+81Fo+I=;
        b=YXc0UpNvHuctCwzX2Oc823ftm4MnFyKyDlmD9lXOaLmjTdrjTbtLZ8rwOZ+z5De678
         1bLl0Oz7mmADxNDvewAkBDjB4/LEia4OUc6S9QrPYxHOsXxpJMRYKshCRnW0Fm7KQciw
         5fH/wTBkVlBYc4K9pk2qOhcR6rFXTfGyFOvq0tqJluSJpW79QpNHxV+VxwF24saFKvM3
         EoZXCOeGpxm4AuSbJEXOSxD4TZFWrKFPsoF8AMwUNgGEOWoKpZTH7iN/45gA7WnbC10C
         UDI75MFgtOlTbc6PmAFfw92Fh/DstG56qRF/Md7XmS5EdY0UJUYGRVff80x+EPQlYzLD
         ZWfQ==
X-Gm-Message-State: AGi0PuYogj1B5ioWoUhpxgRqNhQ8dx4rF+xbNLQYR7BtrwHJNCdqejTI
        VjLkj9UqQ1u3jUo5SAuP/dA=
X-Google-Smtp-Source: APiQypJl0GS/pIeOucinLhDdsIaU51TWmmsOMs+nHMdCajeRKASeXoGa81TY7u8ACss6/heqNk8TeA==
X-Received: by 2002:a4a:d1a4:: with SMTP id z4mr3752373oor.52.1585849974971;
        Thu, 02 Apr 2020 10:52:54 -0700 (PDT)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id x80sm1512988oix.56.2020.04.02.10.52.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Apr 2020 10:52:54 -0700 (PDT)
Subject: Re: [PATCH] clone: document partial clone section
To:     Junio C Hamano <gitster@pobox.com>,
        Teng Long via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, Teng Long <dyroneteng@gmail.com>
References: <pull.745.git.git.1585792946341.gitgitgadget@gmail.com>
 <xmqqa73t4wmk.fsf@gitster.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <120c8b18-6707-ce8e-7905-8f9565094034@gmail.com>
Date:   Thu, 2 Apr 2020 13:52:53 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:75.0) Gecko/20100101
 Thunderbird/75.0
MIME-Version: 1.0
In-Reply-To: <xmqqa73t4wmk.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 4/2/2020 1:37 PM, Junio C Hamano wrote:
>> `git log -p -- <path>` will download blobs to
>> +generate the patch output and git log --raw will download all blobs
>> +that changed at recent commits in order to compute renames.
> I do not know anybody sane uses '--raw' these days, but a better
> way to describe this may be

Ha. This was my fault for recommending it. The point was that some
diff options require blob contents even if it doesn't seem obvious.
Yes, "-p" will get contents to show the in-file diff, but --raw
will calculate renames so it can show the rename in the output.

When I use '--raw' what I really care about is '--name-only' but
does that compute renames?

As you mention, '--summary' would suffice for the point as it
checks for renames.

Thanks,
-Stolee
