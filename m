Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7D58C43217
	for <git@archiver.kernel.org>; Thu, 13 Oct 2022 10:10:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbiJMKKs (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 13 Oct 2022 06:10:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229705AbiJMKKl (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 13 Oct 2022 06:10:41 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DA76EB76D
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 03:10:39 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id c9-20020a05600c100900b003c6da0f9b62so1143802wmc.1
        for <git@vger.kernel.org>; Thu, 13 Oct 2022 03:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=4V70CQNhdvWlRStkV4++ZehA+Oiq0Cv13k3xcNqxcOI=;
        b=aItMWOnCSA1PTH5ImPw4dDVFV73Y3LhXRlHmro8dehCV7A3SvTltZsaABcQjZeZ7jQ
         E4w7w3C7sUbwGW1z2r32a1odyqelCPVwLlk9QLWhJDmiiwXF18luwzq/2Tcrc37QezR2
         lhH3Wsa88bWLkXOLRk+faAB755DzKNwjqQtqiBNHUC6zW1XK5PWVBmMboeqdOmtA+uD7
         5QRM4Ktmm0Ep43mxNJQpS9qpZ/hLaJ9QP26TtxfjpXjy6I8ZomUaAsmIG+Cfn/4pjNto
         JsY7j24MATC0IeqMqLhGCPBQZZSmLxojCkIzYhAIpUnxDC67Bv5dkAc0AsmyENtjBw1u
         yYng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4V70CQNhdvWlRStkV4++ZehA+Oiq0Cv13k3xcNqxcOI=;
        b=OTnpqtbiO0QEhMu3miee6Xk+/tRVoaJxhH9MMO6f0lAog/onkpYXG108/ifpZgAOnU
         ovc90oEGPwHx6gxP0321ThbrbTPGTkHTKxBROVVsOcPPAiCLBzL6XVKC98qORFUasVS+
         veGPQpKCLO+IJdjecHB1umuUsMprIe4FA8zLoA+8CKpkczcnX3dpw3fAQmKjacoCYFP/
         6XW6sKaSUFYb6IXKzcqr9vMKYUIc9a+zYP0Gw240///2AYr3picQG1KujTEI+7gUxjCg
         /joPS9WS3HqbeJrSAI91Nhq5D5TZySUi0X0/tQEhgqoUnJyMBtVcTaoMcHaWMgWJ+330
         h3Jw==
X-Gm-Message-State: ACrzQf3C+q0SZ+J7sr3j26bVykYeAqIfVibkcDJW48Mcfvz+Ui5GIt+2
        rT3lWKLjd32KMG3/GqOFr6nfFsl/yAk=
X-Google-Smtp-Source: AMsMyM4zoD+iwdBtTj5g9fdsbOSWrIinq0IKuczlCjyNjHnc3z/kMO5FZmpw+f7uzpkj740czAcSMA==
X-Received: by 2002:a05:600c:418b:b0:3c6:c1e6:b01c with SMTP id p11-20020a05600c418b00b003c6c1e6b01cmr6049876wmh.118.1665655837409;
        Thu, 13 Oct 2022 03:10:37 -0700 (PDT)
Received: from [192.168.1.81] ([31.185.185.144])
        by smtp.googlemail.com with ESMTPSA id v3-20020a05600c214300b003a531c7aa66sm4020222wml.1.2022.10.13.03.10.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 03:10:36 -0700 (PDT)
Message-ID: <c0211f35-bb26-7ca8-6f9d-a62507e55e8a@gmail.com>
Date:   Thu, 13 Oct 2022 11:10:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [RFC PATCH 2/2] notes.c: fixed tip when target and append note
 are both empty
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Teng Long <dyroneteng@gmail.com>
Cc:     git@vger.kernel.org, --cc=avarab@gmail.com,
        tenglong.tl@alibaba-inc.com
References: <20221013055654.39628-1-tenglong.tl@alibaba-inc.com>
 <20221013055654.39628-3-tenglong.tl@alibaba-inc.com>
 <221013.86wn94kqq1.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <221013.86wn94kqq1.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 13/10/2022 10:36, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Oct 13 2022, Teng Long wrote:
> 
>> From: Teng Long <dyroneteng@gmail.com>
>>
>> When "git notes append <object>" is executed, if there is no note in
>> the given object and the appended note is empty, the command line
>> prompt will be as follows:
>>
>>       "Removing note for object <object>"
>>
>> Actually, this tip is not that accurate, because there is no note in
>> the original <object>, and it also does no remove work on the notes
>> reference, so let's fix this and give the correct tip.
>>
>> Signed-off-by: Teng Long <dyroneteng@gmail.com>
>> ---
>>   builtin/notes.c  | 13 +++++++++++--
>>   t/t3301-notes.sh |  3 ++-
>>   2 files changed, 13 insertions(+), 3 deletions(-)
>>
>> diff --git a/builtin/notes.c b/builtin/notes.c
>> index 1ca0476a27..cc1e3aa2b6 100644
>> --- a/builtin/notes.c
>> +++ b/builtin/notes.c
>> @@ -567,9 +567,10 @@ static int append_edit(int argc, const char **argv, const char *prefix)
>>   	struct notes_tree *t;
>>   	struct object_id object, new_note;
>>   	const struct object_id *note;
>> -	char *logmsg;
>> +	char *logmsg = NULL;
> 
> Hrm, interesting that (at least my) gcc doesn't catch if we don't
> NULL-initialize this, but -fanalyzer does (usually it's not needed for
> such trivial cases0. Anyawy...

I don't think its written to if we take the 'else if' branch added by 
this patch so we need to initialize it for the free() at the end.

>>   	const char * const *usage;
>>   	struct note_data d = { 0, 0, NULL, STRBUF_INIT };
>> +	struct note_data cp = { 0, 0, NULL, STRBUF_INIT };
> 
> This is probably better "fixed while at it" to set both to use "{ .buf =
> STRBUF_INIT }", rather than copying the pre-C99 pattern.

We only seem to be using cp.buf.len so we can test check if the original 
note was empty so I think it would be better just to add

	int note_was_empty;

`	...

	note_was_empty = !d.buf.len

instead.

Best Wishes

Phillip
