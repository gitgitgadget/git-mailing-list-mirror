Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F0470C433FE
	for <git@archiver.kernel.org>; Thu, 16 Dec 2021 14:11:53 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237831AbhLPOLx (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 16 Dec 2021 09:11:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237902AbhLPOLw (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 16 Dec 2021 09:11:52 -0500
Received: from mail-qv1-xf2c.google.com (mail-qv1-xf2c.google.com [IPv6:2607:f8b0:4864:20::f2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4F31C061748
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 06:11:51 -0800 (PST)
Received: by mail-qv1-xf2c.google.com with SMTP id m6so6311632qvh.10
        for <git@vger.kernel.org>; Thu, 16 Dec 2021 06:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=/+t21u5C0xJQ5S2gldyzgTSacmvXfOLjNfdHtvpVCKA=;
        b=UbBIEez5cho2L/sX8xeXzZHdtzGSY9/ioLwSUUX1EIymAmXmqwNdMNJfjHI245s6Pc
         J5bMfqNYobWW2UsxNitBRQEQ7dAlNxoWOtxifIVZni9Xg7zn/yl7fSNKCa+hYUvg3+yT
         EGSM6gNWFnNooamrFwRAYztc5go2zbGYdJduFp70KAd/bOZ4a4DE9x2HODwvxTIDP3cP
         8+0k4Yt/7oRRsOHnifH6DHQcgfWDl9EyVsa2DDOxFQ01LSzFS1xtQVGoZpuN+GsFPbfv
         SGu4rTuv28rx1LCK6tLyuZbuswx7Fmq4d5sT3iNoJ2Rbj9uWaMvEWbYdGFhaocydscF6
         sobg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=/+t21u5C0xJQ5S2gldyzgTSacmvXfOLjNfdHtvpVCKA=;
        b=rPGz4p6EhnItOdeYK3S9kC266UWoUBWYoeMnxsf8ZLVKQ/+xv7qq7P2IIp1ca9lOXc
         VVYPYabeH9SThFUVVLgbNfnrdDZEUmqw7tGxfg0wzmt+5T2e5zsw6pDI70LGZxsGlKss
         rtlce6JQ8CP6s1T1QZpINeMuBldqZr4dzf7WrqPIbwW7jrCNMID+69ECjl6F2WffXrcF
         0VvhY0SIn2g2vrFEftegnx6DOrRdxr4bZZTCH02lS+RO750qKST23aj037HKMjvzNo8D
         dtehQzzcEsNuW/tYlk9UkMNMv6iIFqAkXxHml/CnPlid5/hywu/0lYAbR1hc6q/YTiSP
         UhAw==
X-Gm-Message-State: AOAM532EmKh6zF0YfLOJACC2LcPDk7xVJ4dDU9qyYx71oyeh2JiuVxAM
        kwx1+JLYBUihU4ComJGRtyg=
X-Google-Smtp-Source: ABdhPJzHj8qHMUHvMQptcwYkrJyZLyusDJV7nyRWEu0zjviD4bpjCOc0xLiBjA/SEDfynkgQIluiZA==
X-Received: by 2002:a05:6214:2682:: with SMTP id gm2mr15943398qvb.64.1639663911010;
        Thu, 16 Dec 2021 06:11:51 -0800 (PST)
Received: from ?IPV6:2600:1700:e72:80a0:f174:15fc:4a5c:9d45? ([2600:1700:e72:80a0:f174:15fc:4a5c:9d45])
        by smtp.gmail.com with ESMTPSA id d19sm4312588qtb.47.2021.12.16.06.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Dec 2021 06:11:50 -0800 (PST)
Message-ID: <3910553a-019c-24bf-a058-ef47dfe28393@gmail.com>
Date:   Thu, 16 Dec 2021 09:11:49 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Subject: Re: [PATCH 2/2] ls-files: add --sparse option
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Elijah Newren <newren@gmail.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Victoria Dye <vdye@github.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee <dstolee@microsoft.com>
References: <pull.1080.git.1637077083.gitgitgadget@gmail.com>
 <e42c0feec94de0e4869cda1fc6b28bd7055774e3.1637077083.git.gitgitgadget@gmail.com>
 <211123.86h7c3wrg2.gmgdl@evledraar.gmail.com>
 <03a642fc-6310-1ea4-083e-9fe4530cf761@gmail.com>
 <CABPp-BGJJM757CoOPjP=XBK-cMMGJemaeruxXSN9TEGmk+NKvg@mail.gmail.com>
 <d1275b30-b9b0-a416-3300-9809d880eb55@gmail.com>
 <CABPp-BEyvkRdxJoJZcNF1VoQBcJajq1CVUrNTfHnHG433Q=cNQ@mail.gmail.com>
 <c8e22885-1759-d3d9-3944-2d70c70960e2@gmail.com>
 <211209.86v8zydjjl.gmgdl@evledraar.gmail.com>
 <745e79e3-521d-58bd-2ddf-1da4e0f6fe26@gmail.com> <xmqq7dc8co3d.fsf@gitster.g>
From:   Derrick Stolee <stolee@gmail.com>
In-Reply-To: <xmqq7dc8co3d.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/13/2021 2:16 PM, Junio C Hamano wrote:
> Derrick Stolee <stolee@gmail.com> writes:
> 
>> You're talking about this hunk, right?
>>
>> if test -z "$GIT_TEST_CMP"
>> then
>> 	if test -n "$GIT_TEST_CMP_USE_COPIED_CONTEXT"
>> 	then
>> 		GIT_TEST_CMP="$DIFF -c"
>> 	else
>> 		GIT_TEST_CMP="$DIFF -u"
>> 	fi
>> fi
>>
>> This only switches from "diff -u" to "diff -c" if the
>> GIT_TEST_CMP_USE_COPIED_CONTEXT variable is set, but it is not set
>> by default. Thus, we are using "diff -u" by default throughout.
> 
> That it can be set merely means that somebody needed to work around
> the lack of "-u" format in their implementation of "diff".  It came
> to POSIX only at the Issue 7 of the standard (cf. [*1*]).
> 
> Unconditional use of "diff -u" is a breaking change for them.

Yes, noted. I'm currently waiting for ld/sparse-diff-blame to
merge to 'master' before sending a new version, since there are
unrelated build failures without taking newer changes in 'master'.

Thanks,
-Stolee
