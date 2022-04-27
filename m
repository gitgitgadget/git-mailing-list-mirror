Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B01CCC4332F
	for <git@archiver.kernel.org>; Wed, 27 Apr 2022 16:31:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243156AbiD0Qee (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 27 Apr 2022 12:34:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243853AbiD0Qe2 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Apr 2022 12:34:28 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C9465D1A2
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 09:31:10 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id v12so3244473wrv.10
        for <git@vger.kernel.org>; Wed, 27 Apr 2022 09:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:reply-to:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pX0elE+tQmkbieKtu4di68Ehk8F9RmdlcnMWiY5mEOY=;
        b=Q1MufkWEjsHiYVWfX1lOg9mnBrrbgQ8C9PTrkUfJpsJNm51efTvueL5TfZWGv03rrD
         dh1duobeuKcUeYg4nreUcMMPruNPJY9wgOskwv3blMtSxk+M/rHbmnsdPYOqeAH4FVCj
         u6Rlap0vSBQVS2w1xYc0t5CfPRVFPb8b3E46KkfTe/HiPCKgWK8RyWInX3dTXLt2i3fZ
         GIqHhONwCiv347mNw2jm3crI1lbzuNTOscUhm+482iAkY2nOJR7vyKqPab9y+GPvghNw
         Jzt1jpVsy3rjpQXMjiSrFVwVI5jRle54HQ7tyo1RDP3B1x7vKMZafHuDTBt4HfXUe0+E
         M6zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:reply-to
         :subject:content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=pX0elE+tQmkbieKtu4di68Ehk8F9RmdlcnMWiY5mEOY=;
        b=J8qk6XHDaQjjrWwjvtr5JvH4ID/YVZ+0A9JAI1I+MWBzXxl+udBUvg38t6SVQKvHsm
         3Lo3rUqcRXrpIwLuOxL5GeZCj+r7GgKboDC7urnGvQkFwhJJX1HR9hB3YwwVjF5SUuu7
         pdstdUGhMUkwX4QWo7tkkjrVq2qRGJmbrsU4IuHwC+fNrD/mmh/XRXOpdv4vcHsEvuS8
         9nWHhGShfqrYKGtvbmRgl38oiyCzfj7x2j/wy9zJFw4vPG2lQ4d4NTco5Nv/zh3x1gkJ
         ieVfs8pcxBQ123xYjBxmr9su1z1NFnd605sWlrR4FN1lIvSHWQmQeqHx2kn4u4pz2jPB
         moCA==
X-Gm-Message-State: AOAM532FQBS53B0gQwit3tO4EPIqEoUt7LxaIzDtp8g5t4QpRcMry6pb
        Ehuz5bozxlGIK+cFyzboy6k=
X-Google-Smtp-Source: ABdhPJwduYO67UJD7Pu/11JXfzhVMaaSl9vUAOKzL2DYKT+H9pG3nDiJFWdb0BzwZe/bqV+Hzuvh6w==
X-Received: by 2002:a05:6000:15c5:b0:20a:f29b:ca4c with SMTP id y5-20020a05600015c500b0020af29bca4cmr1937707wry.256.1651077068635;
        Wed, 27 Apr 2022 09:31:08 -0700 (PDT)
Received: from [192.168.1.201] ([31.185.185.192])
        by smtp.googlemail.com with ESMTPSA id p3-20020adfaa03000000b00207a1db96cfsm14761522wrd.71.2022.04.27.09.31.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 27 Apr 2022 09:31:08 -0700 (PDT)
Message-ID: <57217c15-c6d1-32f1-a481-0003ba66e342@gmail.com>
Date:   Wed, 27 Apr 2022 17:31:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH] git-compat-util: avoid failing dir ownership checks if
 running privileged
Content-Language: en-US
To:     Carlo Arenas <carenas@gmail.com>, phillip.wood@dunelm.org.uk
Cc:     git@vger.kernel.org, philipoakley@iee.email, me@ttaylorr.com,
        guy.j@maurel.de, szeder.dev@gmail.com, johannes.Schindelin@gmx.de,
        gitster@pobox.com, derrickstolee@github.com,
        Randall Becker <rsbecker@nexbridge.com>
References: <20220426183105.99779-1-carenas@gmail.com>
 <20220427000522.15637-1-carenas@gmail.com>
 <6522673b-494a-951c-be5e-3ca01577c12b@gmail.com>
 <CAPUEsphEymVE1HHeDZE+Fh50fr7DJSpM_YFNC-v=m9hFhgz-UA@mail.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <CAPUEsphEymVE1HHeDZE+Fh50fr7DJSpM_YFNC-v=m9hFhgz-UA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 27/04/2022 16:38, Carlo Arenas wrote:
> On Wed, Apr 27, 2022 at 2:33 AM Phillip Wood <phillip.wood123@gmail.com> wrote:
>> On 27/04/2022 01:05, Carlo Marcelo Arenas Belón wrote:
> [...]
> FWIW, I still think that using atoi with a check to skip "" is
> probably as safe as doing all this extra checking as no one has shown
> yet a system where sizeof(uid_t) > sizeof(uint32_t), but agree with
> Junio that using long instead avoids issues with the systems where
> sizeof(uid_t) > sizeof(int) and unless sizeof(int) == sizeof(long)
> (ex: 32-bit Linux) which is then covered by the cast.

if sizeof(uid_t) < sizeof(long) then the cast will truncate the value 
returned by strtol() which means we are trusting that SUDO_UID is a 
valid uid otherwise it will be truncated.

>>> +{
>>> +     const char *real_uid = getenv(env);
>>> +
>>> +     if (real_uid && *real_uid) {
>>> +             char *error;
>>> +             long extracted_id = strtol(real_uid, &error, 10);
>>> +             if (!*error && LONG_MIN < extracted_id &&
>>> +                             extracted_id < LONG_MAX) {
>>
>> strtol() returns a long so the last two checks are redundant.
> 
> The last two checks were to check for underflow or overflow and to
> make sure that the bogus values this function returns in case of those
> errors are not taken into consideration.

Sorry I misread the code - this is checking if the value is valid, not 
if there is an error. On platforms where uid_t and long are the same 
size (e.g. where int and long are both 32 bits) the "< LONG_MAX" check 
is rejecting a valid uid. The fact that we are doing these checks makes 
me think we should care about the possible truncation above.

Best Wishes

Phillip

>> The standard is silent on what happens to error when the value is out of
>> range.
> 
> Which is why instead I was avoiding LONG_{MIN,MAX} which are
> described[1] as the bogus values that will be used in that case
> Agree with you that we could also add a check for >=0 as uid_t is
> usually unsigned, but it is not warranted to be so, and that is I was
> aiming for the wider possible range so we don't have to worry that
> much and let it be settled to a valid value through the cast.
> 
> Carlo
> 
> [1] https://pubs.opengroup.org/onlinepubs/007904875/functions/strtol.html

