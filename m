Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.1 required=3.0 tests=AWL,BAYES_00,BODY_8BITS,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1F50D1F461
	for <e@80x24.org>; Thu, 27 Jun 2019 13:42:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbfF0NmO (ORCPT <rfc822;e@80x24.org>);
        Thu, 27 Jun 2019 09:42:14 -0400
Received: from mail-qt1-f194.google.com ([209.85.160.194]:42867 "EHLO
        mail-qt1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726497AbfF0NmN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 27 Jun 2019 09:42:13 -0400
Received: by mail-qt1-f194.google.com with SMTP id s15so2420730qtk.9
        for <git@vger.kernel.org>; Thu, 27 Jun 2019 06:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=Gu5OYztU0bl48/+M4UUBxM0olpFEHXW775LmBDR3/LI=;
        b=tXuOOlB0L1GdjRbdJ5+WKSzhElUp3uT/1DZiBpEpqHacV6nw+yT1p0LoTEEIjjanFO
         DkO0BMgU+KaoaWC+QolqX7ZLbuibw635UWIQySjIq2hqzAnoD0K9eD3XsuUzapnp+Z5Q
         xxzdIvoJYc1agTWLqFOjrzO8EX5BgPcSUjdfkNEnKgd89gl5lAbqoxnLCJ5rIyrQOwo9
         QHqpA0lloPWYlgoAA4+BY30nrYnoZWBK0Et4BR4WN+lCHBYLOKQQnudDHpzOFkVfYczc
         caXJRTcsTFTvt8YCmZV+nCWgfXcNZR+qnJZikUfOqhjby0YGM8S8GaQffTbU0V9DMS2b
         kdLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gu5OYztU0bl48/+M4UUBxM0olpFEHXW775LmBDR3/LI=;
        b=US48Tu3pzh6Bpgng2QsPbk8MDY1SYgEfIwtLmF/ppebwwtwL/q8NU9+TS11+ORBUbs
         ZYcvb9T30z/Iaus03XpWRF8bH2ykZMUqYVT5NRnXFiw1Y4SX+4NFP+g7/RmcV3ScSheD
         n5gXZ4LYgsBfrfttLNSaWLR5yYGfX1SXrzyzXO/bZQ4+6ga3zhEQUMfvP5rVGWiTX+1v
         9kSxlIc94KnGUf3QPm1+XuzIVcPInUqPD1yHse3ipc+/glrMSOSL4sfuo4WYPyuvf0s5
         TIwFZiDSkDy62b699RCSwCoT/078WPskn6qAM5f5DjsRXjaMXF7cmhRNhMWEh+2zlQsk
         l1FQ==
X-Gm-Message-State: APjAAAWPNqs8cuLnJOO0yLJE87dsmLfoX0pysmnJEf4XITl0cFSc/D6x
        PYAZj5c2XEzBfX+uoLy0oquLp582
X-Google-Smtp-Source: APXvYqx2yiP+9DrjA3hgpJ7V2uQKBqCXv5ntbz6vI+LVgrk4AJ5fubHuuNeFku9kOhL6bhPfKwjFKg==
X-Received: by 2002:ac8:384c:: with SMTP id r12mr3169897qtb.153.1561642932849;
        Thu, 27 Jun 2019 06:42:12 -0700 (PDT)
Received: from ?IPv6:2001:4898:6808:13e:9905:3db8:5a6f:f512? ([2001:4898:a800:1010:4a3b:3db8:5a6f:f512])
        by smtp.gmail.com with ESMTPSA id p13sm826083qkj.4.2019.06.27.06.42.11
        (version=TLS1_3 cipher=AEAD-AES128-GCM-SHA256 bits=128/128);
        Thu, 27 Jun 2019 06:42:12 -0700 (PDT)
Subject: Re: [PATCH v2 05/10] split-index.c: dump "link" extension as json
To:     Jeff Hostetler <git@jeffhostetler.com>,
        Duy Nguyen <pclouds@gmail.com>
Cc:     Git Mailing List <git@vger.kernel.org>,
        Junio C Hamano <gitster@pobox.com>,
        Jeff King <peff@peff.net>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
References: <20190624130226.17293-1-pclouds@gmail.com>
 <20190624130226.17293-6-pclouds@gmail.com>
 <55f81571-ba45-edcf-49bd-05418cc309c5@jeffhostetler.com>
 <CACsJy8BjhQD-g69dr-yDCycgfrHZ8xJLgjD=LanRUBxAN6=Zrg@mail.gmail.com>
 <98afb501-ef57-9b64-7ffb-f13cea6fd58a@gmail.com>
 <CACsJy8CwWvKNbYvDqWc-zCwEPc_rz-P4y-SvXV-9jL8_XCFjZQ@mail.gmail.com>
 <93562f66-07a7-d074-e225-65afd7ced1d4@jeffhostetler.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <f4f82ab4-2846-34f9-45ee-a2149fb15d17@gmail.com>
Date:   Thu, 27 Jun 2019 09:42:09 -0400
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.0
MIME-Version: 1.0
In-Reply-To: <93562f66-07a7-d074-e225-65afd7ced1d4@jeffhostetler.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 6/27/2019 9:24 AM, Jeff Hostetler wrote:
> On 6/27/2019 6:48 AM, Duy Nguyen wrote:
>> On Tue, Jun 25, 2019 at 7:40 PM Derrick Stolee <stolee@gmail.com> wrote:
>>>
>>> On 6/25/2019 6:29 AM, Duy Nguyen wrote:
>>>> On Tue, Jun 25, 2019 at 3:06 AM Jeff Hostetler <git@jeffhostetler.com> wrote:
>>>>> I'm curious how big these EWAHs will be in practice and
>>>>> how useful an array of integers will be (especially as the
>>>>> pretty format will be one integer per line).  Perhaps it
>>>>> would helpful to have an extended example in one of the
>>>>> tests.
>>>>
>>>> It's one integer per updated entry. So if you have a giant index and
>>>> updated every single one of them, the EWAH bitmap contains that many
>>>> integers.
>>>>
>>>> If it was easy to just merge these bitmaps back to the entry (e.g. in
>>>> this example, add "replaced": true to entry zero) I would have done
>>>> it. But we dump as we stream and it's already too late to do it.
>>>>
>>>>> Would it be better to have the caller of ewah_each_bit()
>>>>> build a hex or bit string in a strbuf and then write it
>>>>> as a single string?
>>>>
>>>> I don't think the current EWAH representation is easy to read in the
>>>> first place. You'll probably have to run through some script to update
>>>> the main entries part and will have a much better view, but that's
>>>> pretty quick. If it's for scripts, then it's probably best to keep as
>>>> an array of integers, not a string. Less post processing.
>>>
>>> I don't think the intent is to dump the EWAH directly, but instead to
>>> dump a string of the uncompressed bitmap. Something like:
>>>
>>>          "delete_bitmap" : "01101101101"
>>>
>>> instead of
>>>
>>>          "delete_bitmap" : [ 0, 1, 1, 0, 1, 1, 0, 1, 1, 1, 0, 1 ]
>>
>> I get this part. But the numbers in the array were the position of the
>> set bits. It's not showing just the actual bit map.
>>
>> The same bitmap would be currently displayed as
>>
>>   "delete_bitmap": [ 1, 2, 4, 5, 7, 8, 9, 11 ]
>>
>> And that maps back to the entry[1], entry[2], entry[4]... in the index
>> being deleted from the base index. So displaying as a real bit map
>> actually adds more work for both the reader and the tool because you
>> have to calculate the position either way. And it gets harder if the
>> bit you're intereted in is on the far right.
> 
> 
> Thanks for the clarification.  That helps.

Same here! We expect these to be much smaller than the full set, correct?

Thanks,
-Stolee

