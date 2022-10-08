Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E12E9C433F5
	for <git@archiver.kernel.org>; Sat,  8 Oct 2022 09:12:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229658AbiJHJM2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 8 Oct 2022 05:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55592 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJHJM1 (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 8 Oct 2022 05:12:27 -0400
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4640F4D259
        for <git@vger.kernel.org>; Sat,  8 Oct 2022 02:12:26 -0700 (PDT)
Received: by mail-wr1-x434.google.com with SMTP id j16so10338660wrh.5
        for <git@vger.kernel.org>; Sat, 08 Oct 2022 02:12:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=J+MWjW+8rEG9MzBDJzUB0ZBQWu54/h3KY0auy4S3dGI=;
        b=GupXWgwEU4xlIsAWfC9wO8nqgKP7+2SqPy2AfJcOPv7qvsuo+OIklyEq17YKE+rPp4
         6v3Q47D6w4WU3Y05ikUNiU0Cq+2nY17nEZsJpd7nd0ykqUN/L2ma1L33ryYIJrKAwL4d
         feX2LSwLRQQHJY3SW89Evps8bV+91D/qrKWjdXU6SKCM2IQ8pppJp+j1+AicL7xMJiED
         ahQadK7goxe1UfGMwcIWcTvublC8WyoRvgYP0RAz0KZc6Ybhb9R2/aTcU0WjHW6BsNgP
         ucbfnl005dM/ClJuzw1oC9kSxxGhaTTtKQhL9j9TQ1GH/Y+IofyESDbgIJkTwHE+4yPC
         48pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=J+MWjW+8rEG9MzBDJzUB0ZBQWu54/h3KY0auy4S3dGI=;
        b=jltWZ//3750HGI0awLp1o00dSoT++TuHlMhiN1xIwJ9G4Ff7thZXH8tAB76toVdm0E
         HIWbsjMTLZNlp/gRHBnvQ4BEgTDCiB5Dp5MLfbJ9OD9nfjaWRWgjsslDmp8SIvgSLTZx
         CRJbWxcGJBHm2EGVuaEZEdTWu2fTlra5mMdqxk35B+imEw4SsOWjv0F6gHz86NtbTN7F
         CTSXH7e5Vbd0GRtuegCLEx8qfFhJpkyUPukD0fMwXPupv0LCpsUx0AupEFrInFnTL3dv
         8XasT2AuJTA3qFiG2ruGXGOVd+OToD17yRfkiEa1sKKA0m5O/BnXAaGA+0a+pC4RHSsR
         DJ2A==
X-Gm-Message-State: ACrzQf2rdYpKd6AXiu1xQ9PeXqnVqgRoUyiu3S5pIe4w4bffOF8dMeL9
        MlhnY9wsQxRB84PUrlpGrx0=
X-Google-Smtp-Source: AMsMyM6YqjL/gasOAMHWc45yRc7ZYkQcj59IRoIiyRKTZUKc6k0tX9z2fupcGQRhPPGhtj4YvPuIkw==
X-Received: by 2002:adf:fcc6:0:b0:22e:3ab7:e170 with SMTP id f6-20020adffcc6000000b0022e3ab7e170mr5448393wrs.263.1665220344818;
        Sat, 08 Oct 2022 02:12:24 -0700 (PDT)
Received: from [192.168.2.52] (138.83-213-116.dynamic.clientes.euskaltel.es. [83.213.116.138])
        by smtp.gmail.com with ESMTPSA id w8-20020adfee48000000b002205a5de337sm3949399wro.102.2022.10.08.02.12.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Oct 2022 02:12:24 -0700 (PDT)
Subject: Re: [PATCH v4] branch: support for shortcuts like @{-1}, completed
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Git List <git@vger.kernel.org>, Junio C Hamano <gitster@pobox.com>
References: <pull.1346.git.1662388460.gitgitgadget@gmail.com>
 <93b0b442-b277-66a6-3f5f-5a498593aa07@gmail.com>
 <7abdb5a9-5707-7897-4196-8d2892beeb81@gmail.com>
 <2e164aea-7dd8-5018-474a-01643553ea49@gmail.com>
 <CAPig+cSX9jSPc_fJc0tuiER1-AqnbFGOk0r1tXEkv9gycVH-CA@mail.gmail.com>
 <f24837e9-7873-c34c-bd78-8ae3be0fc97a@gmail.com>
 <CAPig+cSn29Fq4ywC9zXoJYRVG8KUEhHuDdwEUSioFMUVs+S-ow@mail.gmail.com>
From:   =?UTF-8?Q?Rub=c3=a9n_Justo?= <rjusto@gmail.com>
Message-ID: <a7aca891-dd37-7e5e-61fc-8012fec18ae9@gmail.com>
Date:   Sat, 8 Oct 2022 11:12:23 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAPig+cSn29Fq4ywC9zXoJYRVG8KUEhHuDdwEUSioFMUVs+S-ow@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 8/10/22 9:23, Eric Sunshine wrote:
> On Sat, Oct 8, 2022 at 3:07 AM Rubén Justo <rjusto@gmail.com> wrote:
>> On 8/10/22 5:17, Eric Sunshine wrote:
>>> On Fri, Oct 7, 2022 at 9:36 PM Rubén Justo <rjusto@gmail.com> wrote:
>>>> +       echo "Branch description\n" >expect &&
>>>
>>> Is the intention here with the embedded "\n" that `echo` should emit
>>> two newlines? If so, interpreting "\n" specially is not POSIX behavior
>>> for `echo`, thus we probably don't want to rely upon it.
>>
>> Oops. Thank you! I'll reroll back to using "git stripspace".
> 
> `git stripspace` is perhaps unnecessarily heavyweight. Lightweight
> alternatives would include:
> 
>     printf "Branch description\n\n" >expect &&
> 
>     test_write_lines "Branch description" "" >expect &&
> 
>     { echo "Branch description" && echo; } >expect &&
> 
>     cat >expect <<-\EOF &&
>     Branch description
> 
>     EOF
> 

Yeah, I thought about that.  What convinced me to use "git stripspace" was
that maybe that '\n' tail could be removed sometime from the description
setting and this will be fine with that.  I haven't found any reason for
that '\n' and it bugs me a little seeing it in the config :-)

But I agree with you about the unnecessarily heavyweight, though all
involves a new process, probably echo, cat or printf are lightweight than
another instance of git for that.

All of this involves two files and that is how it is done almost everywhere
except in some places where it looks like an 'older way' (test_i18ngrep) of
doing it.  Is there any reason to do it this way and not using variables,
process substitution,..?

Anyway I'll switch to one of your suggestions, as it is definitely easier
to read, understand and therefore change if needed.

Thanks!
