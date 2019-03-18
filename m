Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	RCVD_IN_DNSWL_HI shortcircuit=no autolearn=ham autolearn_force=no
	version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 6DB0D20248
	for <e@80x24.org>; Mon, 18 Mar 2019 06:05:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726646AbfCRGFC (ORCPT <rfc822;e@80x24.org>);
        Mon, 18 Mar 2019 02:05:02 -0400
Received: from mail-wm1-f66.google.com ([209.85.128.66]:54146 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725967AbfCRGFC (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 18 Mar 2019 02:05:02 -0400
Received: by mail-wm1-f66.google.com with SMTP id e74so11648188wmg.3
        for <git@vger.kernel.org>; Sun, 17 Mar 2019 23:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=60fxf/dXo0i2IZkTXsanehXrNTjv9wv8KG5YYAfWaiw=;
        b=BJ6PvuUq9bEhx6HKs3/cCO4rzV/8X1Cb3FCbQkVhWqinlaCcYcFN4CWiMZhEgUZDXR
         W/IjBaadJQ0L1X+ewLbxNQeI+i1IpCyBHWx9/VGF2wLmj9Jx9ajkcHtfNZ2waEd5Vdvo
         1DxrwdhoT8ufPi6uuA89gtjkysl7j+r5Dc0WW2BpetPUS9xYonsF2Y5Q6q14JNt6HFf3
         b61dRysrprWcaU3hkjO2CJL8NghrpJwRfBaK38Fmv7QkszxiZollznJA9YnGUG8p5Deq
         5yWj6AdaFusuLDYxnltsefBq9Uge/LT3snCZwmAO56jwgPUKOWZT5WZ+QN2uh6qJr5hk
         /2Pw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=60fxf/dXo0i2IZkTXsanehXrNTjv9wv8KG5YYAfWaiw=;
        b=U+VOEYMRQLJUGZsqzFsjsOIq1LL6yOKNaOkd9ts/t9iQTJPFZrvcMFKgA5ZZcPFU3C
         Vfbiy79r9QH365PODZZbVthrdzn532ZaVQOwyGtMyMGkwvIeQQTHU3TiC5Bctn7K5hJx
         VixhBFTxHlsdb/rIkb7QAcIH2S1u0zFxl9FCdHLpu5vfDSiLUT6YMdhis6lHzFhRHnhs
         esoLHk9n769J7eSqMe2ROQc69gAf516TAsBWSQU820UMfCUS3+ods0ErsE/HkIWjNqJM
         /wnPZpnewyh31MVs2OxVG0fjfXSb1jVVxNtnxbdcFsI1kytqZz2R2nr+W03NxN6xXfO0
         wITA==
X-Gm-Message-State: APjAAAWBt1DVU1nMPmDvaowlLZGzN1UnMJqajweMvPDT/LInLnnZ8RWh
        GNN4+EglTIm9Fp26G0WVtvQ=
X-Google-Smtp-Source: APXvYqyuKKdLW2iE0Dw9eNzwq7DD9HZR4rvT8M/rEqwivbXLPFl4oC2ui3IyGQnZ1ooQIchftuKg9g==
X-Received: by 2002:a1c:35c5:: with SMTP id c188mr9429405wma.79.1552889100934;
        Sun, 17 Mar 2019 23:05:00 -0700 (PDT)
Received: from localhost (141.255.76.34.bc.googleusercontent.com. [34.76.255.141])
        by smtp.gmail.com with ESMTPSA id c17sm7751621wrs.17.2019.03.17.23.04.58
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 17 Mar 2019 23:04:58 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Duy Nguyen <pclouds@gmail.com>,
        Git Mailing List <git@vger.kernel.org>,
        Jeff King <peff@peff.net>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Stefan Beller <stefanbeller@gmail.com>,
        Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v2 6/7] gc: don't run "reflog expire" when keeping reflogs
References: <20190313235439.30439-1-avarab@gmail.com>
        <20190314123439.4347-7-avarab@gmail.com>
        <CACsJy8B=76dMKhvdzOyyOMK5o-s8t+77ZE-hBmezhxLdv7E9dQ@mail.gmail.com>
        <877ed0bfl9.fsf@evledraar.gmail.com>
Date:   Mon, 18 Mar 2019 15:04:58 +0900
In-Reply-To: <877ed0bfl9.fsf@evledraar.gmail.com> (=?utf-8?B?IsOGdmFyIEFy?=
 =?utf-8?B?bmZqw7Zyw7A=?= Bjarmason"'s
        message of "Fri, 15 Mar 2019 11:24:18 +0100")
Message-ID: <xmqq1s344t11.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Ævar Arnfjörð Bjarmason <avarab@gmail.com> writes:

>>> +       if (gc_config_is_timestamp_never("gc.reflogexpire") &&
>>> +           gc_config_is_timestamp_never("gc.reflogexpireunreachable"))
>>
>> Nit. configset api normalizes the key internally, so we can safely
>> write gc.reflogExpireUnreachable here, which is a bit easier to read.
>
> I didn't know that, do we want to do that?
>
> I'd think that as a matter of coding style always sticking to lower case
> in the C code made more sense, because e.g. you might #define a config
> key, and then use it both in git_config_*() as well as via strcmp() in
> some callback. Mixing the two would lead to confusion and possible bugs
> as we'd refactor the former of those patterns to the latter.

When parsing end-user supplied value in a "const char *var", with

    #define REU "gc.reflogexpireunreacahble"

strcmp(var, REU) is wrong.  You must use strcasecmp(var, REU)
because the end-user supplied value may be in camelCase.

And once the code uses strcasecmp(var, REU), using camelCase

    #define REU "gc.reflogExpireUnreacahble"

to compare against would not break it, either.  The only difference
is that being able to see the word boundary may make it easier to
read.

So even when git_config-*() and str*cmp() are used in a mixed way, I
do not think it is a good justification to make the string constant
all lowercase (assuming that camel is easier than all lowercase to
read, that is).

Parsing three-level names is tricky.  Without breaking it down into
components first, you cannot use strcmp nor strcasecmp; comparing
the whole variable name with either function is wrong.
