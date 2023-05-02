Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD82C77B73
	for <git@archiver.kernel.org>; Tue,  2 May 2023 21:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbjEBVEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 2 May 2023 17:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjEBVDw (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 2 May 2023 17:03:52 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE182113
        for <git@vger.kernel.org>; Tue,  2 May 2023 14:03:41 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id 2adb3069b0e04-4edcc885d8fso5197793e87.1
        for <git@vger.kernel.org>; Tue, 02 May 2023 14:03:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683061420; x=1685653420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kZbLOseZAAv+WZbCnUmFKPjlAbAz2BWbDaUt9vZ0h20=;
        b=WbRArG2YXbtthilHuIdMu3y69WHKPTvjbEr9QCnxlfIusGyp2hT2UXxr+o6GrmGZrD
         LMqJMhEQa5eLzEp1Fli/YsZ6OekFJ2Qt/qqXgvEXmWlkm5IZGVvV8p4FofT274lG2sLc
         a8tDc7FW0QSO2JucJ7olfzvAy+34UMXb/YNl8/U30eueu1v21MVEsgEYPDcVt4zZs2ih
         7H2OLheCXp9M4eMKn3YQq5ouO49R9WvudUNFe5tEWlcZckQTuDJo9TijTAyJ8GnvgTGm
         pN+/Umxpop8diiBkW01JZJNzO9JdoHc60b0o9ImY8AFt9u0kdDk09MOAsI5YbbJz+Bi5
         3H+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683061420; x=1685653420;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kZbLOseZAAv+WZbCnUmFKPjlAbAz2BWbDaUt9vZ0h20=;
        b=jNOhuiX7TWO+TSxiqlipNyRSpDqiFS6HuL4suPSwIX8X2+u8fPWNmfevgDh06k6zdt
         lUYkgq4PHbD4KsaBY3fS+I+L0QpqrICkplC3sQDcYiDZdhNkWlN5hAKtY/i1VuWg9A5h
         7MBCCR4Foonj5JHLXp2aykDRlX4fpMHpvsqRxc+L1oF8xecEpWU+dTKiGw3hmIzcvtK0
         0Pphu15ZYxhIGE6kph3R8fAfX6MC2JhBLo7AygdF1ZxOIgdPMxJVpVPpPlIJ6/LVxS9D
         5hsO1qFXhiYTon8gdpULo+HRgqIekNFZr0NnhEvRIKdsJKENQWeeFlzBxbNUKHu5o6vE
         eXeQ==
X-Gm-Message-State: AC+VfDz/9ZhguRrkA2cvPvbihtWAugiYsNJyAz5FiTGU2YwE8onIUcM5
        7xRJ+U2Cui9xZV5214fmjKk=
X-Google-Smtp-Source: ACHHUZ4VYT/sPjYzD6Hkqrnu1s7uwrbOw205rdu4fS+6nqEcXYQwa0dZgUVfVUhdcYx6ukjnEyIksQ==
X-Received: by 2002:a19:c512:0:b0:4ec:9cca:999e with SMTP id w18-20020a19c512000000b004ec9cca999emr322342lfe.32.1683061419578;
        Tue, 02 May 2023 14:03:39 -0700 (PDT)
Received: from [10.2.18.49] ([195.246.120.77])
        by smtp.gmail.com with ESMTPSA id z22-20020ac24196000000b004ec508e3a9bsm5490540lfh.276.2023.05.02.14.03.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 14:03:38 -0700 (PDT)
Message-ID: <73ead9f4-4e12-09c6-8abb-e338f71efceb@gmail.com>
Date:   Tue, 2 May 2023 23:03:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/6] t: fix unused files, part 2
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        =?UTF-8?Q?=c3=98ystein_Walle?= <oystwa@gmail.com>
References: <20230403223338.468025-1-rybak.a.v@gmail.com>
 <20230417191044.909094-1-rybak.a.v@gmail.com> <xmqq8re74t3j.fsf@gitster.g>
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <xmqq8re74t3j.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 01/05/2023 23:52, Junio C Hamano wrote:
> Andrei Rybak <rybak.a.v@gmail.com> writes:
> 
>> Creation of files from redirecting output of Git commands in tests has been
>> removed for files which aren't being used for assertions.  CC'ed are authors of
>> the affected tests.
>>
>> v1 cover letter:
>>    https://lore.kernel.org/git/20230401212858.266508-1-rybak.a.v@gmail.com/
>> v2 cover letter:
>>    https://lore.kernel.org/git/20230403223338.468025-1-rybak.a.v@gmail.com/
> 
> This round has not seen any further comments; shall we consider it
> pretty much done and ready to move to 'next' by now?

In general, I'm OK with the series as is.

While answering Ævar's questions to some of the patches in v2, I
went quite deep in trying to investigate what is and isn't important
to validate/assert in particular tests, but I haven't come up with
a good way to include this information in commit messages for this
series.

Notes per patch:

   - 1/6 for t0300 is just an explanation about why one out of three
     cases in one test does not check stdout (and doesn't need to).
     https://lore.kernel.org/git/db2de983-9b1f-5efb-0fdc-cc704e6b875b@gmail.com/

   - 3/6 for t1300 lead to a separate series
     https://lore.kernel.org/git/20230423134649.431783-1-rybak.a.v@gmail.com/

   - 4/6 for t1450 had an idea for a test 'fresh repository has no
     dangling objects'.  I'm doubtful about usefulness of such a test,
     so hasn't sent it as a patch yet.
     https://lore.kernel.org/git/35bc2dc5-d5cb-3492-ff94-41b93b7563d4@gmail.com/

   - 6/6 for t2019 -- a dive into how output of "git checkout" is tested
     https://lore.kernel.org/git/4ef5464b-31dd-3c3e-05be-9891162e4f05@gmail.com/#t

Patches 2/6 and 5/6 are different from others, because they fix
more obvious issues.

> Thanks.

