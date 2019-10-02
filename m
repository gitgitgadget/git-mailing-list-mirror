Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id BA4001F4BD
	for <e@80x24.org>; Wed,  2 Oct 2019 18:03:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727685AbfJBSDR (ORCPT <rfc822;e@80x24.org>);
        Wed, 2 Oct 2019 14:03:17 -0400
Received: from mail-wr1-f65.google.com ([209.85.221.65]:34076 "EHLO
        mail-wr1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726669AbfJBSDR (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Oct 2019 14:03:17 -0400
Received: by mail-wr1-f65.google.com with SMTP id a11so94065wrx.1
        for <git@vger.kernel.org>; Wed, 02 Oct 2019 11:03:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:openpgp:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=u+6YvN6FI/kT9GcrhWMd0WtchUsEg7F+dRwK5wcyHak=;
        b=pVcYq69oCkr02lQ1kQg9636K4FSduXDN5Pz5Doo1eSuI4UAnotKme2jOi2swzAI58Z
         YZ/x70XD2pyjvijev+RRdLwdsIzqYtmHv9x6o+7fVyi+uMPsSGSBP8z29LS1Ntbvy2uG
         uuHQDCMRTtoczn0XtRUYxlCBLEm3VdGT/Mbg/UpaCB+ZlNhjkrq86TTaUnVHfDev7KK0
         IcygU4/Hxqtx1TmPWmGSxikTEoQTmW7SHRq9Yyo6+TOKdstt6CxdLxwMHlvwciEjUrK/
         dfyTjOu/9aS/I5o0cLR09RtZcMcFfT/3nZNJ5KMiqMwiJkq7oc0mknC1gMvnx5GFCMF+
         xDRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:openpgp:message-id
         :date:user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=u+6YvN6FI/kT9GcrhWMd0WtchUsEg7F+dRwK5wcyHak=;
        b=c+fxgx/IbOhpJgQcgMTrSinLUGZ0ZYEA7jFf+C/1IC9l+Fd/bRJPOO9Tm3POZgbUVA
         rz4rsx6lqOqTfQYy626RD8ROp+QomNei8s8qveBmi7N+wp5Wo1ty8QDGb+GNz+VyJQbY
         CgMHcp635VCfu3CnDmOHQZGpnJqMNJ0Fb+smjOaedDP6UxckHXe9hBk5J5UTFXsaey2l
         1O7PaMzRHSM9PmTqvKSWKgY2d4YroLXl2T4SO2ivN3+dSXQ2ihJN6PW/wobaExshQc7x
         kzWzKKR/kmg4ZDq2ShSZpnawL+3Thwllg7Ad8+pRszBnoLdzz5qCouCzBnTkAhf204gE
         T/cg==
X-Gm-Message-State: APjAAAVxmdB8yZK/G+XFURSx8+4FZw8eCc0rZxifUjspj/1OLqS5vvK1
        3XY/b0YSQikoDbwK4T+E1n0sfuyp
X-Google-Smtp-Source: APXvYqzy87aV/IelTOiV570sbs4HcYNAFnAImHU2UbGKCEOeAqOHUCICF8fNYgB+kjVCm2vtBVE4eQ==
X-Received: by 2002:adf:f547:: with SMTP id j7mr3902986wrp.119.1570039395556;
        Wed, 02 Oct 2019 11:03:15 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-658-1-236-54.w90-38.abo.wanadoo.fr. [90.38.111.54])
        by smtp.gmail.com with ESMTPSA id u22sm73847wru.72.2019.10.02.11.03.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2019 11:03:14 -0700 (PDT)
Subject: Re: [PATCH v1 1/5] sequencer: update `total_nr' when adding an item
 to a todo list
To:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Phillip Wood <phillip.wood@dunelm.org.uk>
References: <20190925201315.19722-1-alban.gruin@gmail.com>
 <20190925201315.19722-2-alban.gruin@gmail.com>
 <xmqqbluzhp8g.fsf@gitster-ct.c.googlers.com>
 <nycvar.QRO.7.76.6.1910021005050.46@tvgsbejvaqbjf.bet>
 <xmqqh84red54.fsf@gitster-ct.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
Openpgp: preference=signencrypt
Message-ID: <88ea97e2-664f-33f9-5f94-fe66b5e4220c@gmail.com>
Date:   Wed, 2 Oct 2019 20:03:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <xmqqh84red54.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Junio and Johannes,

Le 02/10/2019 à 10:59, Junio C Hamano a écrit :
> Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:
> 
>> Hi Junio,
>>
>> On Wed, 2 Oct 2019, Junio C Hamano wrote:
>>
>>> Alban Gruin <alban.gruin@gmail.com> writes:
>>>
>>>> `total_nr' is the total amount of items, done and toto, that are in a
>>>> todo list.  But unlike `nr', it was not updated when an item was
>>>> appended to the list.
>>>
>>> s/amount/number/, as amount is specifically for something
>>> that cannot be counted.
>>>

Thank you for these corrections, I really appreciate it :)

>>> Perhaps a stupid language question but what is "toto"?
>>
>> "in toto" is Latin for "in total", if I remember correctly.
> 
> And "Toto" can also be "Toyo Toki", one of the two large and well
> known Japanese manufacturers of porcelain things you see in
> bathrooms--oh how appropriate in this project ;-).
> 

In French, it’s the name of a recurring character in children’s jokes.
It’s also used sometimes as a dummy variable name like foo or bar.

>> But in this instance, I think it is merely a typo and should have been
>> "todo" instead. That is what the "total_nr" is about: the number of
>> "done" and "todo" items, added together.
> 

Correct.

> If I were writing this, I would probably say "... the total number
> of items, counting both done and todo,..." and with 'counting both'
> I wouldn't have been so puzzled.
> 

I will change this.

Cheers,
Alban



> Thanks.
> 
>>
>> Ciao,
>> Dscho
>>
>>>
>>>
>>>> This variable is mostly used by command prompts (ie. git-prompt.sh and
>>>> the like).
>>>>
>>>> Signed-off-by: Alban Gruin <alban.gruin@gmail.com>
>>>> ---
>>>>  sequencer.c | 1 +
>>>>  1 file changed, 1 insertion(+)
>>>>
>>>> diff --git a/sequencer.c b/sequencer.c
>>>> index d648aaf416..575b852a5a 100644
>>>> --- a/sequencer.c
>>>> +++ b/sequencer.c
>>>> @@ -2070,6 +2070,7 @@ void todo_list_release(struct todo_list *todo_list)
>>>>  static struct todo_item *append_new_todo(struct todo_list *todo_list)
>>>>  {
>>>>  	ALLOC_GROW(todo_list->items, todo_list->nr + 1, todo_list->alloc);
>>>> +	todo_list->total_nr++;
>>>>  	return todo_list->items + todo_list->nr++;
>>>>  }
>>>

