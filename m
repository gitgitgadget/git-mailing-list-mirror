Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CC70C4332F
	for <git@archiver.kernel.org>; Thu, 17 Nov 2022 10:26:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234294AbiKQK0P (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 17 Nov 2022 05:26:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234673AbiKQK0K (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 17 Nov 2022 05:26:10 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81B6528BF
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 02:26:09 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id h186-20020a1c21c3000000b003cfe48519a6so4657583wmh.0
        for <git@vger.kernel.org>; Thu, 17 Nov 2022 02:26:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Izxt41wHnfYX+3HuWgl8C6GGFshpLKSqi4aqsyVp6wQ=;
        b=GVWclRrbEcaFdUmku4X9dER7DMejfBLbenRaPX/h5Z74bC/AIUY5u0Z9W9DBQx9BCK
         JQnmkxvCGpDfb/te6hsG8ONM1lvPFV2X2he3WI6DRLU+byMut1tfb8eTo6GEEM4B0eaV
         y4ElZmWa+fkedhmOt8sIUR4i4md4KsY2mGPZZWBg1KEukyoCxchdkcuYTJO5a9Skt1ZL
         pBFx6MWnZwYghsc1/LTqMaANRCY11DOWRX/ARdWxntgCuJoGeo6umNB7k9VGfGm+iyrt
         shA+GXNLJ0JniRX1SOwgw2SWeDBIb/w53ugy7tadql5aGPY6//OrbDosWwo60FjOkHc9
         CepA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Izxt41wHnfYX+3HuWgl8C6GGFshpLKSqi4aqsyVp6wQ=;
        b=WhZFIWna548QbRyC2SATfvRlhVIch5Nwpe0vS8OPNqwzr2wP5Fjx3siO3j24rGjcf6
         9sQiYhBSkaOMEh0VeMSHllYelYhdjuRm3WTmPZ/7SqmW1oeupOt7GCH2dwUKf4WT5wD+
         b1k3jDkHSgYOBT0XaH59fXZRgOHbLn1uuXDO/JyE631aeBfo28uOUiB6hsx9uDYw2TOA
         jKSG/gtLAkc/u2KrH0zHdRYcZKBZcpIC/75TdwmPnWA0GeYvrhaUPUf/grinS4YRtsfN
         U9XIXcjepgPLXnQrpQvdATbTnEJZEulev5l20r3YYbBQIXiITx4QR0+pll2LTHSFEsI4
         GYQg==
X-Gm-Message-State: ANoB5pnYLxoQNgVKn1hAy/c0cnb9GaoLN4D/761nCTehP7oLsX0j1bcA
        lEVMCeG8dwxSHd+KPz2jb6t3PG61Fiw=
X-Google-Smtp-Source: AA0mqf6H6BYbTKYSWKuFn146hEo7+VZzrrnxqEmhctCNEK7kvcbl4ainautcfGMeWBj0aX1vGhqFhA==
X-Received: by 2002:a1c:c918:0:b0:3cf:f2aa:3dc2 with SMTP id f24-20020a1cc918000000b003cff2aa3dc2mr1167635wmb.175.1668680768349;
        Thu, 17 Nov 2022 02:26:08 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id s18-20020adfdb12000000b00241727795c4sm697422wri.63.2022.11.17.02.26.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 02:26:07 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <50d8767b-cb8c-74c5-b280-43472fa074a2@dunelm.org.uk>
Date:   Thu, 17 Nov 2022 10:26:07 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] range-diff: support reading mbox files
Content-Language: en-US
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Johannes Schindelin <johannes.schindelin@gmx.de>,
        Taylor Blau <me@ttaylorr.com>
References: <pull.1420.git.1668536405563.gitgitgadget@gmail.com>
 <dfe0190c-1d2e-804a-5312-877b7b2f5822@dunelm.org.uk>
In-Reply-To: <dfe0190c-1d2e-804a-5312-877b7b2f5822@dunelm.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Dscho

Having slept on it I think I misunderstood what was happening in the 
diff parsing yesterday

On 16/11/2022 14:40, Phillip Wood wrote:
>> +        } else if (state == MBOX_IN_DIFF) {
>> +            switch (line[0]) {
>> +            case '\0':
>> +                continue; /* ignore empty lines after diff */
>> +            case '+':
>> +            case '-':
>> +            case ' ':
>> +                if (!old_count && !new_count)
>> +                    break;
> 
> This shouldn't happen in a well formed diff. Below we happily accept bad 
> counts, is there a reason to reject them here?

I think this might be picking up the "--" at the end of the patch as we 
don't want to break here at the end of a hunk. If so then a comment 
would be helpful.

>> +                if (old_count && line[0] != '+')
>> +                    old_count--;
>> +                if (new_count && line[0] != '-')
>> +                    new_count--;
> 
> The diff is malformed if old_count == 0 and we see '-' or ' ' or 
> new_count == 0 and we see '+' or ' '. The code is careful not to 
> decrement the count in that case so I think it is harmless to accept 
> diffs with bad line counts in the hunk header.
>> +                /* fallthrough */
>> +            case '\\':
>> +                strbuf_addstr(&buf, line);
>> +                strbuf_addch(&buf, '\n');
>> +                util->diffsize++;
> 
> I think this might be a better place to break if old_count and new_count 
> are both zero.

It would be the right place to break at the end of each hunk, but I 
don't think we want to do that.

>> +                continue;
>> +            case '@':
>> +                if (parse_hunk_header(line, &old_count,
>> +                              &new_count, &p))
>> +                    break;
>> +
>> +                strbuf_addstr(&buf, "@@");
>> +                if (current_filename && *p)
>> +                    strbuf_addf(&buf, " %s:",
>> +                            current_filename);
>> +                strbuf_addstr(&buf, p);
>> +                strbuf_addch(&buf, '\n');
>> +                util->diffsize++;
>> +                continue;
>> +            }
> 
> This is effectively the `default:` clause as it is executed when we 
> don't handle the line above. We ignore the contents of this line which 
> makes me wonder what happens if it is the start of another diff.

We'll pick that up earlier with "if (starts_with(line, "diff --git"))"

We only get here at the end of a patch (assuming it has the "--" line 
from format-patch)

Best Wishes

Phillip

> Do we 
> have tests that alter more than one file in a single commit?
> 
> I think this is a useful addition, it could perhaps benefit from more 
> tests though. Having tests for bad input, "\r\n" line endings and 
> getting the author from a From: header as well as an in-body From: line 
> would give a bit more reassurance about how robust the parser is.
> 
> Best Wishes
> 
> Phillip
