Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1043AC74A5B
	for <git@archiver.kernel.org>; Sat, 18 Mar 2023 15:17:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbjCRPRa (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Mar 2023 11:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229553AbjCRPR3 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Mar 2023 11:17:29 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECE6431BD5
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:17:26 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id y4so31211743edo.2
        for <git@vger.kernel.org>; Sat, 18 Mar 2023 08:17:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679152645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UZgDp7igQAU4b8/oOYfnrvPVXizU7F/z/d5gcHGsuJ0=;
        b=aeuv2Z3cTTBsiXCbkf3O5+OmM7kPjgyNDO4R1pvVawsLZ4VWge4ObrWE1hRHn/8BZs
         DIXABkoyjeazxkfJlPf58ykZZ5C0ZjX/rq5H9gg/nPNjIn7fS13ZTG9dkCiUU+9VMVJ6
         Wnni2l5xicKMsOfN6RJq0O+OPZPZnc/gsXA7FE5J+kXJcVCgCPJk8lhCSrnL0H8bLcjG
         sStupW1eW+BdwVofjpN8sSwQXI7S+NDT1AeCrzN951BBIOQsnUamDbgRC04LjTdn18ZF
         0s0CaKPtCaX9jHdKRcGYrMWvqV9atU332pHeRfKpPcnj95Z2T54paDGUyHuxxl3+j5fC
         uLXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679152645;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZgDp7igQAU4b8/oOYfnrvPVXizU7F/z/d5gcHGsuJ0=;
        b=20lpabirQp1K+m7UCoUdm+gw4KUIT8K0fvVEkLeR1nIn3Up75QWLATzvczRgXBO2/7
         K2S20LjMjO3OjUEfwJa9HbPdeYjVbxHWYWF/SApf80/cb/KIpSLjpxFBdTYCCEVchuaL
         Ul9L1mBkxm+DiRr6IEwA76NDJ5mVukrWosCMG/nM3WL+DuSlfPl7mcH1ZoIsmHjyz5/W
         qSWM23m8zcTXeFP4/S4woAhHPJIFFFTYqIMUb6kd4e0t47LzCFispKUP72gRzdmSw80L
         R0aCy6rU4VPO/mt5e91UDLSlDmeWeS0XXun05z3tIP1JmDSn4W7DzuBGFacvR8PimXDg
         kAxw==
X-Gm-Message-State: AO0yUKXVXHabrgmJZV85UlHjCTcmPRfl3f8w8NnWDxLvLucUQ8MQ2yQS
        bmQ4e7jzTb9h4/SjeGlDsYw=
X-Google-Smtp-Source: AK7set/jnBK1xpJSAiO2z5LG2nbHjeVzfTzER5EhssGiWTD5QeqdgjBaDfRhhQzCaxNhPhKmVBEcog==
X-Received: by 2002:a17:906:3947:b0:92f:a00c:ee52 with SMTP id g7-20020a170906394700b0092fa00cee52mr3277489eje.18.1679152645295;
        Sat, 18 Mar 2023 08:17:25 -0700 (PDT)
Received: from [10.10.18.218] ([216.24.216.227])
        by smtp.gmail.com with ESMTPSA id o2-20020a170906774200b009273859a9bdsm2247116ejn.122.2023.03.18.08.17.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Mar 2023 08:17:24 -0700 (PDT)
Message-ID: <fa093fe4-e237-6f65-6ac5-7088f263b91f@gmail.com>
Date:   Sat, 18 Mar 2023 16:17:21 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 1/7] t1005: assert output of ls-files
To:     Michael J Gruber <git@grubix.eu>, git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Jeff King <peff@peff.net>, Patrick Steinhardt <ps@pks.im>,
        Michael Haggerty <mhagger@alum.mit.edu>
References: <20230312201520.370234-1-rybak.a.v@gmail.com>
 <20230312201520.370234-2-rybak.a.v@gmail.com>
 <167878391659.3913.5697119728018854973.git@grubix.eu>
Content-Language: en-US
From:   Andrei Rybak <rybak.a.v@gmail.com>
In-Reply-To: <167878391659.3913.5697119728018854973.git@grubix.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 14/03/2023 09:51, Michael J Gruber wrote:
> Andrei Rybak venit, vidit, dixit 2023-03-12 21:15:13:
>>   t/t1005-read-tree-reset.sh | 15 ++++++++++-----
>>   1 file changed, 10 insertions(+), 5 deletions(-)
>>
>> [...]
> 
> Just in case someone else was wondering, too:
> 
> All these subtests write to `expect` just before the provided context
> lines, so there indeed is something to compare to, and it is the output
> of `git ls-files -s` before any changes and resets. As a consequence,
> these subtests checked only removal of remnants in the woring tree
> before the patch, and they check removal of index bits after the patch
> (additionally).
> 
> Looks fine to me - though one could probably use `git ls-files -s -o` or
> such instead, the suggested version is more "explicit".

Thank you for reviewing this.

None the tests (both in t1005 and other files) use this combination of flags
for `ls-files` right now.  Checked using:

     $ git grep 'ls-files.*[^a-z-][-][os][^|]*[^a-z-][-][so]' || echo none
     none
     $ git grep -E 'ls-files .* --(stage|others)'
     Documentation/git-ls-files.txt:'git ls-files --unmerged' and 'git ls-files --stage' can be used to examine
     contrib/hg-to-git/hg-to-git.py:    os.system('git ls-files -x .hg --others | git update-index --add --stdin')
     t/t1092-sparse-checkout-compatibility.sh:       git -C sparse-index ls-files --sparse --stage >cache &&
     t/t1092-sparse-checkout-compatibility.sh:       git -C sparse-index ls-files --sparse --stage >cache &&
     t/t1306-xdg-files.sh:    git ls-files --exclude-standard --ignored --others >actual) &&

In this topic, I plan to focus on just fixes of unused files and to leave
flags of `git ls-files` as is for now.
