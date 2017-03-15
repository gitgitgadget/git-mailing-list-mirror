Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 069A9202C1
	for <e@80x24.org>; Wed, 15 Mar 2017 20:29:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753532AbdCOU3b (ORCPT <rfc822;e@80x24.org>);
        Wed, 15 Mar 2017 16:29:31 -0400
Received: from mail-pg0-f53.google.com ([74.125.83.53]:34364 "EHLO
        mail-pg0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753484AbdCOU33 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 15 Mar 2017 16:29:29 -0400
Received: by mail-pg0-f53.google.com with SMTP id 141so14130378pgd.1
        for <git@vger.kernel.org>; Wed, 15 Mar 2017 13:29:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=RUEk1KtX70O8TggIluR2p+h41awK9T1/WsCitbgxBwc=;
        b=HqSnFpB9akbWLpuc35Wc67ClqRpegg3P7HyhwuD8ygx4Ms2xADSYprqrS13H3PIb1A
         sEFGxvuGUjH4t0zLo5vAwX0hYWai+H/TmYzvib75IcozAVa3iB0kbmq6zMPCsNPiZPgg
         VdRVvnnCucMub9a7TCe5APwnRmxyjWXH/3ifxtvoAXlQCpRIWzyiD6QvKIChx2cCZiMC
         LOTufJnRLdQXKsuQYLMLWxgG/SA+xRgZ2CKBiSF7cM0wI7sMww/XDa1YcAuIOwJ7FkpU
         88ItELjVwMsny5ZksRYsAAizvHgCp03A/khsjtWwa5jG4kqSmGEe5ojqPH+TzgzIPFDw
         5Z8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=RUEk1KtX70O8TggIluR2p+h41awK9T1/WsCitbgxBwc=;
        b=iD9XCdz24nBsCd/mD/8cZ2AKEZXpp6BgfvLn7rOzgYadvtq02X7d7qGbvSfRb5v3UZ
         gH+xzzIf0mUJkb8SJntcw6EcIQ6j26S7u35Pm87w4/oGZVO7XOExdKA/z+ORIPUwMsud
         nAC0l4S4pVbC32ahRBwHnLiJXKRe8F54MrMqqy0Lv0lt4zRz1ALfNG69i7tzlXTv4uv2
         Z9aEC9SgdGL+iT/Hevj63DLi5UWZYoXt6P72vhVdoKPwdiOVJFRGzQaSxq2FuXxLzWOp
         GAPBT5ZQa4HpN/Je9ji4O4xlOWGR81ZAFtxL2+aT6AmSiIyXGHC9cpKKvr4dOizOwXdp
         LM8w==
X-Gm-Message-State: AFeK/H1IyKcMop4FUNQNgYP6oGDkcjtFDhLYCGGaPoJoCja2udXSqZoxafb5V8I8orFFDa0m/EL/c4+0BjL4RFHd
X-Received: by 10.99.134.199 with SMTP id x190mr5682713pgd.194.1489609299991;
 Wed, 15 Mar 2017 13:21:39 -0700 (PDT)
MIME-Version: 1.0
Received: by 10.100.187.5 with HTTP; Wed, 15 Mar 2017 13:21:39 -0700 (PDT)
In-Reply-To: <xmqqh92ue2ra.fsf@gitster.mtv.corp.google.com>
References: <20170314221440.18259-1-sbeller@google.com> <xmqqefxyfl6b.fsf@gitster.mtv.corp.google.com>
 <xmqqh92ue2ra.fsf@gitster.mtv.corp.google.com>
From:   Stefan Beller <sbeller@google.com>
Date:   Wed, 15 Mar 2017 13:21:39 -0700
Message-ID: <CAGZ79kb4rd27rwkYXjerTc=oXUOuo=wb9SOk8vvoMJTEmkRvWw@mail.gmail.com>
Subject: Re: [PATCH] submodule-config: correct error reporting for invalid
 ignore value
To:     Junio C Hamano <gitster@pobox.com>
Cc:     "git@vger.kernel.org" <git@vger.kernel.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Mar 15, 2017 at 12:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
>> Stefan Beller <sbeller@google.com> writes:
>>
>>> As 'var' contains the whole value we get error messages that repeat
>>> the section and key currently:
>>>
>>> warning: Invalid parameter 'true' for config option 'submodule.submodule.plugins/hooks.ignore.ignore'
>>>
>>> Fix this by only giving the section name in the warning.
>>>
>>> Signed-off-by: Stefan Beller <sbeller@google.com>
>>> ---
>>>  submodule-config.c | 2 +-
>>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/submodule-config.c b/submodule-config.c
>>> index 93453909cf..bb069bc097 100644
>>> --- a/submodule-config.c
>>> +++ b/submodule-config.c
>>> @@ -333,7 +333,7 @@ static int parse_config(const char *var, const char *value, void *data)
>>>                       strcmp(value, "all") &&
>>>                       strcmp(value, "none"))
>>>                      warning("Invalid parameter '%s' for config option "
>>> -                                    "'submodule.%s.ignore'", value, var);
>>> +                                    "'submodule.%s.ignore'", value, name.buf);
>>
>> Obviously correct.
>
> But isn't this even more obviously correct?
>
>         warning("invalid parameter '%s' for option %s", value, var);
>

Yes. I considered this when writing the patch. It is also obviously correct.
The difference is whether you relay funny capitalization to the error message,
which I thought we might not want to do?

git grep warning yields e.g.
diff.c:                 warning(_("Unknown value for 'diff.submodule'
config variable: '%s'"),
diff.c:                 warning(_("Found errors in 'diff.dirstat'
config variable:\n%s"),

So I conclude that we want to present normalized capitalization for
config options
for error messages.

Thanks,
Stefan
