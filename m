Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.3 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 4DFD91F597
	for <e@80x24.org>; Fri, 28 Dec 2018 19:42:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387882AbeL1TmZ (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Dec 2018 14:42:25 -0500
Received: from mail-ed1-f65.google.com ([209.85.208.65]:42861 "EHLO
        mail-ed1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387775AbeL1TmZ (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Dec 2018 14:42:25 -0500
Received: by mail-ed1-f65.google.com with SMTP id y20so18254581edw.9
        for <git@vger.kernel.org>; Fri, 28 Dec 2018 11:42:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:subject:to:cc:references:openpgp:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=R+a8v98/nE++RDMNYfDKy4dUz7C8vnMAju3fE6PGKCo=;
        b=KS8EUrnKCJ7MzBQUkw1uHrpkrX6svIfacluXcCa64INnBPY/a4PSx5jd4wOZ1nO8cZ
         k0k4y3d7UwwIpcsqEjMKGSGTENVgVqO6QoxheOsUuVROQgwLGTcjtZhisklKzzQ4oHBi
         NL7LEFuJiQdcVlRXBDT3MoG/UtEfamfyTRALM3afaq7swEOzaKtqV6rG68yxMnYUV2xy
         rHk3nBRS2duxodWSNLttnBqBVzOSgoopSArokNim+1RhfHb8ZXnhi/HZ8NoMi9MjTNiP
         3LTn1xkrbePFq8D0CJGNMXKze6B8WSULxAe30qPBQufkDXNWUYYzY+dXJu+ZfoPRW3ZC
         34Aw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:subject:to:cc:references:openpgp:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=R+a8v98/nE++RDMNYfDKy4dUz7C8vnMAju3fE6PGKCo=;
        b=mjU7Ch0aE7dPhbaFCRtE9GNRrcMcPrpubu03fbBLMO+HtcO0BmUmi9HxjpVek/HZcl
         noahq9F1oG1jB1XfKuDKwq7qWd6G/bDZi6YJaeAROiqdJ9UebxkQdtXw0ML3pcprEQyf
         Q/BRA4hEzY5uJz+BrLeHt+0Nmg6nJlLSQrkaFF7AoBIu9cUpaoK1qwuGJmMyi1HH8r1D
         879Fj9SoMMNvwQQ4BbgFkCbGYi/0qJWB+4t9WSBWbw6m9Q3UAvL1uikjNzd91VDf5/CG
         z3sRmibBPCAdOijMltgXfFptmrfGQabHuOArqB+NlYBY8ytlnFSbgKGbFaehXyEjeyjm
         DKMA==
X-Gm-Message-State: AA+aEWZdQ6J7w2nvaIJbsLwTpjZOAUkQuH/MPjlIgioH8wtSYynevFJ7
        Kl+AQntHNdGqRPnw5Swg9ardzo4a
X-Google-Smtp-Source: AFSGD/UBXk+Bg7thZc1KA+5UiNq4BfRYnsLIFvtU3wysBoSz59Dj3wRU7iolzYGPlpdE/pDyQPKu6w==
X-Received: by 2002:a50:999b:: with SMTP id m27mr23715438edb.10.1546026141449;
        Fri, 28 Dec 2018 11:42:21 -0800 (PST)
Received: from [192.168.0.104] (atoulouse-658-1-184-107.w86-199.abo.wanadoo.fr. [86.199.39.107])
        by smtp.gmail.com with ESMTPSA id m44sm12826218edm.54.2018.12.28.11.42.20
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Dec 2018 11:42:20 -0800 (PST)
From:   Alban Gruin <alban.gruin@gmail.com>
Subject: Re: [PATCH v3 06/16] sequencer: refactor
 sequencer_add_exec_commands() to work on a todo_list
To:     phillip.wood@dunelm.org.uk,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Cc:     git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
References: <20181027212930.9303-1-alban.gruin@gmail.com>
 <20181109080805.6350-1-alban.gruin@gmail.com>
 <20181109080805.6350-7-alban.gruin@gmail.com>
 <0e00acd9-5b09-b712-2e21-550e348ea0df@talktalk.net>
 <nycvar.QRO.7.76.6.1811302002340.41@tvgsbejvaqbjf.bet>
 <a1a828e5-6faa-b1f2-20c3-a53b1a3d779a@talktalk.net>
Openpgp: preference=signencrypt
Autocrypt: addr=alban.gruin@gmail.com; prefer-encrypt=mutual; keydata=
 mQINBFcsWp4BEAC6dalBNr/CZCvvfeARylnjAaZCxMPwUHXAyf4xotA59sNcyVmaFQ6KxQEs
 R20CSJhO6HqCh4bR9/994vdc4cGuNaWf82eYRYzqCzwFWvFJHj83QgDR2cjtz4frKpj3jSFJ
 No3KBlMmpU8yvSnYaCxjqHxBB+fZwkmmONj/57KdFRU83DvDllQdAxXfxEavL3qUKjVbld29
 o82M2xsN8ZN5KTw7rAMHcigYVnlrgP50euxz3WvfrV+Mky2W7q7m5rTK7eXqOKhewsKcxo0I
 AP+H0Nt91YTmMIAX2Ba25IfHI99kUCLpbHX9xdvj5UH1SZsG84APahdI3CXYibfYIS+qssoo
 72qj7eBIoCFbVS4Q5AINxojio32orGBDE8CaCy3EzTF+vwJ+h4uUKrTX4wyUMy8nXS0UxZqD
 aQsS7Di6LdAHu+4uf064mXdgjehJ2uHAydFnCThMoxckRoSZ70iCPwgconhNrnuTmunJ43BF
 YjAurjg8y3WrMPJuJaI42q0sYbAX21XeayyMI8dzoNwyG6s+v0Udb/uxdYnHhsGx1oXjYCeR
 nyBdVwdMLWFP4XmJH7JueGUZ37TLh719ME6HYRpfM3sh915ywPxKxQYmGC9iXRThXdGK7ipq
 hJM5RtMq4QPGg+/ShgTZaDdFuMnG8Zrq6W+O29h9NB5rQ/UvBwARAQABtCNBbGJhbiBHcnVp
 biA8YWxiYW4uZ3J1aW5AZ21haWwuY29tPokCcAQTAQIAWgIbAwIeAQIXgAULBwgJCgQVCAkK
 BRYAAQIDHxhoa3A6Ly9wb29sLnNrcy1rZXlzZXJ2ZXJzLm5ldC8CGQEWIQS1T1bLFrFdtpxn
 TIMOC58lWpNWKgUCWRSuYAAKCRAOC58lWpNWKoCfEACHmff95NF5OrBKN+GPYo3TOojjgjio
 CREt9BNIU1ltbks33N/84QF1ifjFF5xjK1XpNhZdk2Nxk+Uf3ByAS24i0b7/BM58RX3sJMHd
 mklCbqBGLBTS+bO/3nc+1snb7FPmjoi3IXznQ25ZXiV/9MUABUBZi7odwNhxeI3Hd2PaX/x5
 ZM0BApqhmBrueUd0JKqY7f/7a+0rTJ8fIHV9ml3cVWf72t2BVnxJMeNLSAIT1FaL8Okp8ViO
 t7RfjF0JZsYZouhCcw2fx7U0VxXGu6bONdVGxu07I7G3+vjhd2C/ld0dgRRjx8viA5HecUSf
 bwbviEXlc44TVo8D6tkrKOezctqNTLII498C7gIQZjc+6HmIIQrOzzLX/C27JQbXch+6KtHO
 ThYGzmD0d7EttTRtXnFJFTMbQMMFnc2X+Rh1ubvfp4Zp2U3a7Nh1//4+ikqIAPV8poJcEdQ0
 A6CaGD8pTCMdExDovizfJRU0ZN3AU9UgFsZWkMK7MFyJneRObUf26oXCQH8zVuJEJHrEsYPk
 VHdV1G86d++CdipKqe9iDNBGNa/5Q9IvYEKK6vj4wLS5ZaOwLGfApbsOcDJvFA1ll/KeHvzx
 Ig9dhUnNCtYXKJ1npChigwRbAiAADoTFI2rI69g6ZTTzBd0+9GM4z6RcOJvtGLnViO4tOCmy
 sbwbxLkBDQRXLFwDAQgAx0ri+CyXslFrT7Ksvf2nlkZILQHtdatPP8VwSOJBDSmaYVDWWZEB
 h+uS2b6EKCr//JKPZCof0/RtvpWwHHDFKzJtLBBZoK9AVfl3cCZIpqaEc0N73fKOQBX4h4BU
 e1fVBcC5YRXlHSRoNbv2+w25f8AO0Pmmx+oEtW3lKVb+7rOEOTfvwlNg7Iy1zkSJ7nhMwftC
 xrUJpqo3pVY3DW6FxOwoT+1FAmHUHXqes+C41qpr6H7yn6xE835t5OtJbOiS+af/a8PrWvjv
 vE2Vztn3QWvHWhbMDB8NjSCNnVsLHyu3qr66meTkJMlJgZA1LcmE+GAM2/HV5z11u779zJHO
 VQARAQABiQI8BBgBAgAmAhsMFiEEtU9WyxaxXbacZ0yDDgufJVqTVioFAlt76q0FCQYwwioA
 CgkQDgufJVqTVioQ2A//UEkF5EOPBqV45CMNA5yvq7rBP01CzAJsTExBi2572UBiMDiGt9g6
 bRU+coRK8fHWga+U3tO+7ubtnzysBLHOJ6Yq48GcIrFYu9ky0GEaxc3+Nu7muVxHs+ltiaxC
 EaARhnYGm3MsRjlLwCgGbfjdhajprjdDooA7czE/JZEXrFt3HEUtZw9z9hNh7OJ8ENIYXlFO
 jtnnlJuCrlKEGN2S9PA4zU6/vSznBUBXNCQzCueBGf09iiuERxTwrmfn65REhUOkE7o9mKp1
 4dR4/zuONnLttzIwkuUNGyP2OId/FFeAjrx7sPDPrHaGPBFJ3FBx/VI+3/HCajEIPcM9h3Nk
 kS1K6xmzsExaR81lYkKyWR/drBT4bv2mmYh4H8ksMCWFecCLPe77ydgStSIqhgtJx53XVyWl
 aL3vMwzmG3fihq8fUdFxXfQWcUlI++qe/e7Ye8weLTCrNB0TM/T/c6gnQHF1VdIwbMPJVB/Q
 Up74CgX7geoMmEYmsYH+P0DR/+yBqgiWgpPtLAdD9ALwVgvdQs/zZCvBLrXMLd5kEIbtFoTG
 +n3xU7zare4Jcz45Tt4/ECsGGIt6rul+J9HBjuCG8STEbmTtlauZmZ4uGf2uxpj0H3cPzwgE
 9NQcuwgB9Z4DVNTZYA6LMAi57ITqC84t2RfaYbOk+7iSI1kLBtZzdwW5AQ0EVyxchwEIAN2I
 RfTJqy3LwQQQo7oyvfZbf3VpgGhA2VUWC7fNFwWwoyWEVYOqVN+rRHISvynYZRK3LefmDzlY
 K/vB2VR7vPziwgS1EUXg8x/7sYbt2c3vk4aS86xlgfYZ5kEuITLcxzbndKr0oO/uFn3Hh1Rq
 Bzd/yRA8qpONQbOtPhBzECYaFo5lBGkewQn565bHoz7Heq1AXy2VhfkyKu9I6ob+adkm66NJ
 XTGJVbqZi0J7EGvCnGk5iRnP6O+K5btDyhrD/vxgMC5Fa8dt5I1+gC7E5huK9jKrqOsjmasf
 7e4+A8jd7qCf9X824MGlYbBmLzx9lphWNukQ0aymYc5RiQSxBLcAEQEAAYkDWwQYAQIAJgIb
 AhYhBLVPVssWsV22nGdMgw4LnyVak1YqBQJbe+qtBQkGMMGmASnAXSAEGQECAAYFAlcsXIcA
 CgkQ9kVaGWSIuvbbrggAjnXiqUlb3KNk4YIibMI0HPmw8lMQcRH5RAmFIKKGvbeb05TM7/qx
 JzDNtmVtCFP3cSSRhCDuhXlCdJJXk8MptFYVijGFRXAYelOwXWd2JnUuybt1zPE5QgGAI9Lv
 orUKFuyzT9mmk/IVylpYZ6V9GHDBoR1hstSBCfPlz2XUfE3nsRGSzhWBuKVBvibG+H0rraNb
 rPmTQf/VvH8lmdjWIZEMzI9aIGnvFUytIuHXnS3vK/4J3LsXX+dr5DrzlHZNOwVZu/u3/oKe
 6/wNNFGxpDJ3vVN/XWS5cAU+ouhx7r4HTeAIZRIj8GjxFfP3R590uGjiloR8NbiEoAFqUJZR
 awkQDgufJVqTVipfbQ//X8M4+V+lnYNVi3ByXkal56tOgra9MyOh6jz73QV0gctEyeWyopps
 h3b+903N/oX1Rd8HP9xWI8WqMpfHJi7qerrcllUDsuR94RQ06BoR0TV+LgXpAO1hkzYSdkTf
 sDkdCZ0XoJjCljnj1bGh8xfUG/e/66KkfoXM7K3EIbbugLWrQykdhSwYf/MPS1Xoxn+UDlt7
 Z2iT/E5eFaLGrx7W86EwVe0ulYypQQZOblekOx87pOOmXFcRZEwe5kVSCoXj2qmCzQHTqnO/
 Er4g9Pi5QKxK7mCk/zF1lJvdN+nKzVJJrntP/WCkXGUeRAGZSiJA9USJ8JApdS/5Umux6siq
 dWaqQLCz/SRJ5gRlXhvYAJLCdoUG4Df8kdQwQYGuWRbnUoUU1u1Hs25IzdJMJS8FIYg/or5I
 yKBJDLoFArFEP0/SeKP1R/veOtcvATa6Neo+fpiJ1HXFCvKqndlGVUdJFMaWh6lE3XQ/bgx3
 yl/kHs42wTS/M6EylpBS10/RLxLF1TKK39xgGXtzRz86lqxz9IIEcLpOXsNi2ieoVOfykgbG
 lvAXpIk/WT7BKd1ncK71sTuBGWpnytCjlTFHM6Lp70yZT9TAKaBevkn5JaSlhv4/QcfJtTgJ
 HkyVQTh250fC9P/9C9azPjnxB9hnBktfiihx+wISlDARk/X+JCZfJrM=
Message-ID: <58d2a1e9-e798-acb6-d8af-3e67e18df057@gmail.com>
Date:   Fri, 28 Dec 2018 20:42:18 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.0
MIME-Version: 1.0
In-Reply-To: <a1a828e5-6faa-b1f2-20c3-a53b1a3d779a@talktalk.net>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Phillip and Johannes,

many thanks for your suggestions and feedback, I really appreciate it.

Le 10/12/2018 à 15:33, Phillip Wood a écrit :
> On 30/11/2018 19:06, Johannes Schindelin wrote:
>> Hi,
>>
>> On Fri, 30 Nov 2018, Phillip Wood wrote:
>>
>>>> diff --git a/sequencer.c b/sequencer.c
>>>> index 900899ef20..11692d0b98 100644
>>>> --- a/sequencer.c
>>>> +++ b/sequencer.c
>>>> @@ -4394,24 +4394,29 @@ int sequencer_make_script(FILE *out, int
>>>> argc, const
>>>> char **argv,
>>>>       return 0;
>>>>   }
>>>>   -/*
>>>> - * Add commands after pick and (series of) squash/fixup commands
>>>> - * in the todo list.
>>>> - */
>>>> -int sequencer_add_exec_commands(const char *commands)
>>>> +static void todo_list_add_exec_commands(struct todo_list *todo_list,
>>>> +                    struct string_list *commands)
>>>> {
>>>> -    const char *todo_file = rebase_path_todo();
>>>> -    struct todo_list todo_list = TODO_LIST_INIT;
>>>> -    struct strbuf *buf = &todo_list.buf;
>>>> -    size_t offset = 0, commands_len = strlen(commands);
>>>> -    int i, insert;
>>>> +    struct strbuf *buf = &todo_list->buf;
>>>> +    const char *old_buf = buf->buf;
>>>> +    size_t base_length = buf->len;
>>>> +    int i, insert, nr = 0, alloc = 0;
>>>> +    struct todo_item *items = NULL, *base_items = NULL;
>>>>
>>>> -    if (strbuf_read_file(&todo_list.buf, todo_file, 0) < 0)
>>>> -        return error(_("could not read '%s'."), todo_file);
>>>> +    for (i = 0; i < commands->nr; ++i) {
>>>> +        strbuf_addstr(buf, commands->items[i].string);
>>>> +        strbuf_addch(buf, '\n');
>>>> +    }
>>>
>>> This could cause buf->buf to be reallocated in which case all the
>>> todo_list_item.arg pointers will be invalidated.
>>
>> I guess it is a good time for me to admit that the `arg` idea was not my
>> best. Maybe it would be good to convert that from a pointer to an offset,
>> e.g. `size_t arg_offset_in_buf;`? Or maybe we should just drop the
>> `_in_buf` suffix and clarify in a comment next to the declaration of the
>> fields that they are offsets in the strbuf?
> 
> I think that sounds sensible (though I haven't looked at how much work
> it would be), having a comment and calling it arg_offset would be my
> preference.
> 

It’s not a lot of work, actually.  Most usages of 'arg' are concentrated
in two functions (parse_insn_line() and pick_commits()).  Some of the
subsequent patches of this series also use 'arg', and adapting them is
trivial.

In the end, most of the work went into todo_list_add_exec_commands(),
and the result is pretty clean.

Cheers,
Alban

