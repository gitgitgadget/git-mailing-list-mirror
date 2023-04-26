Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A28FC7618E
	for <git@archiver.kernel.org>; Wed, 26 Apr 2023 14:06:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241058AbjDZOG1 (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 26 Apr 2023 10:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239947AbjDZOG0 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 26 Apr 2023 10:06:26 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15D006591
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 07:06:25 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id 5b1f17b1804b1-3f178da219bso71405065e9.1
        for <git@vger.kernel.org>; Wed, 26 Apr 2023 07:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682517983; x=1685109983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=yH5ZNHgWEjoXgRsdTUrNQ2jp5x6U24OKipDQZTVEvfQ=;
        b=heXoy+uycfGuLGkL0QWqevsCjh6bb27W3dhWMqasjHWm12VE6pphdzttsBVmZ4lB3Z
         bGy8ccY2d+7X98Z9OWgtuvHczFLTS+AIFksskpguQTYxHCgUaUZhlnXJEueOErCei/nZ
         DWOJs35pfl2CsUwu5htBWxp0IldCWAF+Q8edFDZAh1Y5X3AhB2+4CMIxwxP/3z/9VYs8
         Batm3sG0M02eO6OdjNE0/XSNjmtFWKR21Tx+aDIHfbq1IvVTSD0UXOGBCCRXxP9qlAXU
         jM1vTx8sPwwpo4IwvhwN71+s8NSxuw/uTq5x9jE5kMfjcnm1ki1k7Ch+sm1rKiW3pw4E
         EzCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682517983; x=1685109983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yH5ZNHgWEjoXgRsdTUrNQ2jp5x6U24OKipDQZTVEvfQ=;
        b=lVeSCcvh9QV7sho0oFdzPUtPjwD91TogbbNKu1bS98JbHQy7sy5CjKqkKjV+G0la0C
         XjUe1zA0jcmaw8NKP7FOy5RG+U2bxw2B0AxhBTxgMQe9aR+1OX5hrN1l4Ihm1UrrqCn8
         Fie7THeDnilsZun9BF7SLzzO5scEnBzgjCpEnG6/EaSMdiN8KkOzxxyBh5VywVaYAZdW
         xjqc3bC6Ciw2HU7iywZVViJ8swyvMFDkwDF4ilM63ntTCmM0yfwn6fae8si7A3Prvtqb
         NdsvZd7IQoxSp23WjCn1C7mhjXBoHs/l4ENYWIc+utLhvbXaf8x/IdLa2TXOQeNQIqe0
         /Slw==
X-Gm-Message-State: AAQBX9dA+RxdDvSxfCGze4H7Fkela+kSKCqImxSJXnlA+QtgG/siwKIl
        LBNI1jiwi9mcEMfjAJxXA0c=
X-Google-Smtp-Source: AKy350YAKXGnbm8dIC5QQFnL7JnNm1ULUTdAy6qrJAYmeg3WJVDmYAjh3XdqJpfgnL+VWOW39oVh4w==
X-Received: by 2002:adf:e3ca:0:b0:2ef:ab51:15c2 with SMTP id k10-20020adfe3ca000000b002efab5115c2mr15297973wrm.15.1682517983374;
        Wed, 26 Apr 2023 07:06:23 -0700 (PDT)
Received: from [192.168.1.212] ([90.255.142.254])
        by smtp.gmail.com with ESMTPSA id i3-20020adff303000000b002f4cf72fce6sm16027646wro.46.2023.04.26.07.06.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 07:06:22 -0700 (PDT)
Message-ID: <a6ce9393-331c-3ee0-648b-182614a7d275@gmail.com>
Date:   Wed, 26 Apr 2023 15:06:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2 3/4] parse_commit(): handle broken whitespace-only
 timestamp
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        Thomas Bock <bockthom@cs.uni-saarland.de>,
        Derrick Stolee <derrickstolee@github.com>, git@vger.kernel.org,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>
References: <20230425055244.GA4014505@coredump.intra.peff.net>
 <20230425055458.GC4015649@coredump.intra.peff.net>
 <06bc5530-55b0-7299-a6e6-fde1deab6605@gmail.com> <xmqqttx43q08.fsf@gitster.g>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <xmqqttx43q08.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 25/04/2023 17:06, Junio C Hamano wrote:
> Phillip Wood <phillip.wood123@gmail.com> writes:
> 
>> This probably doesn't matter in practice but we define our own
>> isspace() that does not treat '\v' and '\f' as whitespace. However
>> parse_timestamp() (which is just strtoumax()) uses the standard
>> library's isspace() which does treat those characters as whitespace
>> and is locale dependent. This means we can potentially stop at a
>> character that parse_timestamp() treats as whitespace and if there are
>> no digits after it we'll still walk past the end of the line. Using
>> Rene's suggestion of testing the character with isdigit() would fix
>> that. It would also avoid parsing negative timestamps as positive
>> numbers 

>> and reject any timestamps that begin with a locale dependent
>> digit.

Sorry, that bit is not correct, I've since checked the C standard and I 
think strtoul() and friends expect ascii digits (isdigit() and 
isxdigit() are also locale independent unlike isspace(), isalpha() etc.)

> A very interesting observation.  I wonder if a curious person can
> craft a malformed timestamp with "hash-object --literally" to do
> more than DoS themselves?
> 
> We are not going to put anything other than [ 0-9+-] after the '>'
> we scan for, and making sure '>' is followed by SP and then [0-9]
> would be sufficient to ensure strtoumax() to stop before the '\n'
> but does not ensure that the "signal a bad timestamp with 0"
> happens.  Perhaps that would be sufficient.  I dunno.
> 
>> I'm not familiar with this code, but would it be worth changing
>> parse_timestamp() to stop parsing if it sees a newline?
> 
> Meaning replace or write our own strtoumax() equivalent?

I was thinking of a wrapper around strtoumax() that skipped the leading 
whitespace itself and returned 0 if it saw '\n' or the first 
non-whitespace character was not a digit. It would help other callers 
avoid the problem with missing timestamps that is being fixed in this 
series. I was surprised to see that callers are expected to pass a base 
to parse_timestamp(). All of them seem to pass "10" apart from a caller 
in upload-pack.c that passes "0" when parsing the argument to 
"deepen-since" - do we really want to support octal and hexadecimal 
timestamps there?.

Best Wishes

Phillip
