Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB7D7C54EAA
	for <git@archiver.kernel.org>; Fri, 27 Jan 2023 22:14:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232688AbjA0WOt (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 27 Jan 2023 17:14:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231439AbjA0WOr (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 27 Jan 2023 17:14:47 -0500
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2924384942
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 14:14:47 -0800 (PST)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-16332831ed0so8322484fac.10
        for <git@vger.kernel.org>; Fri, 27 Jan 2023 14:14:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xpKL836fI5m59LSF3KpvnUtahbdBHottY0BqyEFVKbU=;
        b=Op1hL2dvZXLYigbMK1pVlU+Tg8rYNoCJGLeQSUuqCZXIDcyogcq5dYCjlEQ+dIL4Ct
         fEYP6UK9rU3u6K3qwlEOLtdsZxXrgIWYK4+JvfixJr352qDJDyuXtZyL7TwK+cdsyJWP
         UL3iMn6bpQrekxV5R5ScFZ9UQZw6oLnmAHt26vYIoeM6k5ddu1OM+pV27AtJCHKf0Wk6
         Dbd3DsTfWzBFjkjOJWBWInEid3rO/uQW+TK0YDUbVOovfx5XyHWpugbAW1auXJnTiFEA
         5NkLp6n/h+pXf33a3EbxOS/3M/oG+49VfCCX/qotPp8DG6nAeRrsNVIjcAtFG6zWP3ev
         isdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xpKL836fI5m59LSF3KpvnUtahbdBHottY0BqyEFVKbU=;
        b=Fc8qh5vNcn9q9l+MPfNxQk2vZaImtAk5pdZZkG0i09AGqNX/WiLrxetMp6l7tS0zFk
         QREBFFuW4fubrSrADHZGCrk58ipWXTTppxjMjAe/ieV4OOFB97mm3qy719/7iyNFxlji
         YZBfljjDTg06eycfmcDlFptDLedR1Bkh2vg2WsIvuAhNe04gsbFsrLM591byBvHSLlq5
         SOkUiku6cdXZfXPUA8lKWJdcwdGCN6zxmwgMEPFlYsQY/3ng+rtnHfPVtDeff13+nTAk
         2UgGv/IR//bVg6gaASyjHhLiOGnEaGR/7jyEwyLc905Y15lKvHEtOt3nc8xjSHSPL9dJ
         +knA==
X-Gm-Message-State: AO0yUKWy+nHcFXC3n9ScxNGilODnwEVKEloyKZG5lwulRFvWeXwGvhLQ
        S2l8DV9ckj8cWHOLMxYDXX/Dx+f8811EAfQ=
X-Google-Smtp-Source: AK7set/xFDrSsv7toTwI9HjIX1vtEOWPyvJ2H2WZSQbcvQm3pVSvrNorhANrzttFmPJg/UnBO8S3qg==
X-Received: by 2002:a05:6870:b6a7:b0:163:2ac2:742 with SMTP id cy39-20020a056870b6a700b001632ac20742mr7233101oab.54.1674857686367;
        Fri, 27 Jan 2023 14:14:46 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:a857:f20:476a:b382? ([2600:1700:e72:80a0:a857:f20:476a:b382])
        by smtp.gmail.com with ESMTPSA id eg37-20020a05687098a500b00150aca072e8sm2394110oab.38.2023.01.27.14.14.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 27 Jan 2023 14:14:45 -0800 (PST)
Message-ID: <7070bd26-3020-5a17-2f51-2df9ae00df8c@github.com>
Date:   Fri, 27 Jan 2023 17:14:43 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 3/3] scalar: only warn when background maintenance fails
To:     Victoria Dye <vdye@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     gitster@pobox.com
References: <pull.1473.git.1674849963.gitgitgadget@gmail.com>
 <d75780e0567b5f765816ab7522afe550ebaa3521.1674849963.git.gitgitgadget@gmail.com>
 <65b1735b-7ea6-5f7c-e1d9-6c986c7beb1d@github.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <65b1735b-7ea6-5f7c-e1d9-6c986c7beb1d@github.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 1/27/2023 5:06 PM, Victoria Dye wrote:
> Derrick Stolee via GitGitGadget wrote:
>>  	if (toggle_maintenance(1))
>> -		return error(_("could not turn on maintenance"));
>> +		warning(_("could not turn on maintenance"));
> 
> Should we do the same thing for 'unregister_dir()'? Unlike 'register_dir()',
> it doesn't break immediately (and finishes removing the enlistment), but it
> still returns a nonzero error code from 'scalar unregister'.

The interesting thing about unregister_dir() is that
toggle_maintenance(0) "turns of maintenance" by removing the
maintenance.repo config value pointing to this repository,
not by removing the maintenance schedule. Thus, we don't get
the failure in the same way.

>> -test_expect_success 'scalar clone fails when background maintenance fails' '
>> +test_expect_success 'scalar clone warns when background maintenance fails' '
>>  	GIT_TEST_MAINT_SCHEDULER="crontab:false,launchctl:false,schtasks:false" \
>> -		test_must_fail scalar clone "file://$(pwd)/to-clone" maint-fail 2>err &&
>> +		scalar clone "file://$(pwd)/to-clone" maint-fail 2>err &&
>>  	grep "could not turn on maintenance" err
>>  '
> 
> Similarly, it might be nice to show how 'scalar unregister' behaves when
> maintenance fails in the tests.
 
And the way I found out was by making the same tests, but since
they actually never failed or listed a warning (for this reason)
I left it out.

Thanks,
-Stolee
