Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1997EB64DD
	for <git@archiver.kernel.org>; Mon, 14 Aug 2023 19:21:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231523AbjHNTVA (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Aug 2023 15:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232238AbjHNTUz (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Aug 2023 15:20:55 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C92FE1702
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 12:20:49 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-589f7a48307so13599317b3.1
        for <git@vger.kernel.org>; Mon, 14 Aug 2023 12:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google; t=1692040849; x=1692645649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MBivuSGGjmwCT4E9L/m1Sed8QmEMFgjfrPsS4jYqNTg=;
        b=WV5uewKF/udzGDq4R0hQKZOI8qvWD7DphwD29U0mxJS2qLfLCCrUXYk7Wgu8NrU4te
         UQzu7FNZAWE4tmFCJixDz9rGHteMjIrqrvPjilLc0Qx2oHNldRoXVMGr2sv/tu/nyto5
         6Uen6qGUSmhzRbAsftR/JCNet3Awl0ee8ILc1/iQ+zSi1aGaaXAVYL5I0S6MDL4jysoJ
         KYvrpF1bHeWlA5DFOqK1ehLEczjixriZOuNVAy/1S50TjYaBSnNUOJulbBUwC9f39pO2
         toH5CKY8LDodXFCR99msH7PLaqo4VLCiG9qDdyNZTL1hIGO7tz5fkuVvr9sYmGLwkpVF
         9hAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1692040849; x=1692645649;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MBivuSGGjmwCT4E9L/m1Sed8QmEMFgjfrPsS4jYqNTg=;
        b=lCeClrMQ7vsTgLL6xKL1iBxyUt9ZktUOGwPwXTGd+9VK3C4WGKiE5CFAZQgOWxMoVa
         KgiX3/XI9EeMICRnIEC92Czt5NMslpbs4Wjo/kHPO9eZsO2CA9kjLeK2mGA0Mgy5QaCm
         hfbrpDH2nB8y7+DmTzn3KVuxcKl9JfPSRMXsvtOAwWaQBDK62Fhb0buGraSBmIikajXr
         lQ2M08ueNB0WxB0rkBZO7zjYPQiWvjuKwWMnMUbnA1JjucLQAWt11+mhqqKIxxxOYAvc
         RIzJOKtnihH2Ae5f37QvRsfohgwQFyAk+/+9EJV7rW9O7zHOxKaGT1WbMUS/Ps5XBbFK
         KuKg==
X-Gm-Message-State: AOJu0Ywp6Yf127kc7StBN50jcnMzQCgxpMhWadK/pcK4lAu8eNRhVKgg
        LU+LvX7ewDmk2ATlMK94tzOo
X-Google-Smtp-Source: AGHT+IF+SmG7dfaoAa1qC2kpdzGi0r18sncoCP3fDIRGhZkDdqhqISVh6FI5fBZhd/k3s6IjdEQWcQ==
X-Received: by 2002:a0d:f286:0:b0:56d:9e2:7d9e with SMTP id b128-20020a0df286000000b0056d09e27d9emr11503098ywf.21.1692040849022;
        Mon, 14 Aug 2023 12:20:49 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:2098:93bd:9768:5e65? ([2600:1700:e72:80a0:2098:93bd:9768:5e65])
        by smtp.gmail.com with ESMTPSA id z192-20020a0dd7c9000000b00583b40d907esm431544ywd.16.2023.08.14.12.20.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Aug 2023 12:20:48 -0700 (PDT)
Message-ID: <abae52d5-47d5-4439-9d2b-68bb6e1c96fa@github.com>
Date:   Mon, 14 Aug 2023 15:20:45 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/3] scalar: add --[no-]src option
To:     Junio C Hamano <gitster@pobox.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, johannes.schindelin@gmx.de
References: <pull.1569.git.1692025937.gitgitgadget@gmail.com>
 <c1c7e2f049e762b9b60614a5732e4d41db1d0da5.1692025937.git.gitgitgadget@gmail.com>
 <xmqqcyzpmx2g.fsf@gitster.g>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <xmqqcyzpmx2g.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/14/2023 12:02 PM, Junio C Hamano wrote:
> "Derrick Stolee via GitGitGadget" <gitgitgadget@gmail.com> writes:

>> +--[no-]src::
>> +	Specify if the repository should be created within a `src` directory
>> +	within `<enlistment>`. This is the default behavior, so use
>> +	`--no-src` to opt-out of the creation of the `src` directory.
> 
> While there is nothing incorrect in the above per-se, and the first
> half of the description is perfectly good, but I find the latter
> half places too much stress on the existence of the "src" directory.
> As a mere mortal end-user, what is more important is not the
> presence of an extra directory, but the fact that everything I have
> is now moved one level down in the directory hierarchy to "src/"
> directory.
> 
> 	This is the default behavior; use `--no-src` to place the
> 	root of the working tree of the repository directly at
> 	`<enlistment>`.
> 
> or something along that line would have been easier to understand
> for me.  It is not the creation of `src`, but that everything is
> moved into it, is what some users may find unusual.

Your confusion makes sense. Focusing on the location of the cloned
repository is a good way to focus the option for the reader.
 
>> +test_expect_success '`scalar clone --no-src`' '
>> +	scalar clone --src "file://$(pwd)/to-clone" with-src &&
>> +	scalar clone --no-src "file://$(pwd)/to-clone" without-src &&
>> +
>> +	test_path_is_dir with-src/src &&
>> +	test_path_is_missing without-src/src
>> +'
> 
> And another thing that may be interesting, from the above point of
> view, is to compare these two:
> 
> 	(cd with-src/src && ls ?*) >with &&
> 	(cd without && ls ?*) >without &&
> 	test_cmp with without

Good idea.

Thanks,
-Stolee
