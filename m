Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.6 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 42CCA205F4
	for <e@80x24.org>; Mon,  2 Jan 2017 11:23:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1755563AbdABLX2 (ORCPT <rfc822;e@80x24.org>);
        Mon, 2 Jan 2017 06:23:28 -0500
Received: from mail-lf0-f66.google.com ([209.85.215.66]:33468 "EHLO
        mail-lf0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751307AbdABLX0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 2 Jan 2017 06:23:26 -0500
Received: by mail-lf0-f66.google.com with SMTP id y21so39867758lfa.0
        for <git@vger.kernel.org>; Mon, 02 Jan 2017 03:23:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc;
        bh=r2x4LeluC6Cxp3yIFLEF3gQFIIj/AMyLkpgSKOhT6pQ=;
        b=jn6FJPnq5pbI/fX8KPMBeHV94NdfIX8ysB7v79jshf/bmanrBBmWprBMrcDuYgEjzE
         snRc5bnU+VK+3kSdR9ZAXld3RUjrDhnVNzrS//0O5vrDEhtxuVr3zvyR9maHkUQQBzQp
         ijHPbXnFTJaK9Vnkqb/rLBlw1kTUf9r5ebHsHpJqHPXLnjWxDMwe16CPa2lexplEImVF
         cywKdHcFAmb+Xb9Q5KvlTuWANOTZSo8UQ82U7M4gnY2EyH3w3Sob2nkdh08f7wi74y7/
         SY1Ld5p38ilp1UOfHYJCsWHNnjUVR2FRxyDI5gVqS8Y7BXmQnVHl5I4lpWcKigZnw765
         fJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:in-reply-to:references:from:date
         :message-id:subject:to:cc;
        bh=r2x4LeluC6Cxp3yIFLEF3gQFIIj/AMyLkpgSKOhT6pQ=;
        b=ppB8Wh5E6fBfMxn+5SLbRLzqz/ld3tp2EBUUK2qd90gGV6FjkkBVM8Fgx0dM+1jCZD
         mTSoRjhMzhMwm50/MHvAwCywBNuYotzDhKenJCcW25gAJncRKEJ7NV3FmleZJqR0VjQS
         o5mVBTN/iCbBeQ0d/iz1XSl/sPdfoYzdZjtcWv+kF5RWv/3HN+yUCVDRyVv5h5Um8anE
         49R87bjmOmaAi0dYUFzDz6ZBV8/2bZPZHt3ZLy0+dVOlG65iZZSvu5qiAIoP/ZfLXt46
         pY9KfDTd7Q0Jk1TlhJZKsNzkEgQiyc69PSxLNmmgxPTThkPPzm2qw28Y2fD98iUKhzRG
         bjPQ==
X-Gm-Message-State: AIkVDXLH96/a1gJyOD0U8sWX+CRR8uSUJdTJ1Y57qbxheTsUmYUVUZpf9bY2r1V/DijlrHY56Rnoa891YFUH0w==
X-Received: by 10.46.7.10 with SMTP id 10mr20684727ljh.60.1483356204955; Mon,
 02 Jan 2017 03:23:24 -0800 (PST)
MIME-Version: 1.0
Received: by 10.25.135.198 with HTTP; Mon, 2 Jan 2017 03:23:24 -0800 (PST)
In-Reply-To: <xmqqk2al9ocv.fsf@gitster.mtv.corp.google.com>
References: <20161226102222.17150-1-chriscool@tuxfamily.org>
 <20161226102222.17150-11-chriscool@tuxfamily.org> <xmqqk2al9ocv.fsf@gitster.mtv.corp.google.com>
From:   Christian Couder <christian.couder@gmail.com>
Date:   Mon, 2 Jan 2017 12:23:24 +0100
Message-ID: <CAP8UFD3_1EN=0EsD12Cew1MuW8yhtPAZw0M_g3wmvKFk-uGXxw@mail.gmail.com>
Subject: Re: [PATCH v3 10/21] read-cache: regenerate shared index if necessary
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git <git@vger.kernel.org>,
        Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Christian Couder <chriscool@tuxfamily.org>
Content-Type: text/plain; charset=UTF-8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Dec 27, 2016 at 8:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Christian Couder <christian.couder@gmail.com> writes:
>
>> +     case 0:
>> +             return 1; /* 0% means always write a new shared index */
>> +     case 100:
>> +             return 0; /* 100% means never write a new shared index */
>> +     default:
>> +             ; /* do nothing: just use the configured value */
>> +     }
>
> Just like you did in 04/21, write "break" to avoid mistakes made in
> the future, i.e.
>
>         default:
>                 break; /* just use the configured value */

Ok, I will do that.

>> +
>> +     /* Count not shared entries */
>> +     for (i = 0; i < istate->cache_nr; i++) {
>> +             struct cache_entry *ce = istate->cache[i];
>> +             if (!ce->index)
>> +                     not_shared++;
>> +     }
>> +
>> +     return istate->cache_nr * max_split < not_shared * 100;
>
> On a 32-bit arch with 2G int and more than 20 million paths in the
> index, multiplying by max_split that can come close to 100 can
> theoretically cause integer overflow, but in practice it probably
> does not matter.  Or does it?

From a cursory look a "struct cache_entry" takes at least 80 bytes
without counting the "char name[FLEX_ARRAY]" on a 32 bit machine, so I
don't think it would be a good idea to work on a repo with 20 million
paths on a 32 bit machine, but maybe theoretically it could be a
problem.

To be safe I think I will use:

return (int64_t)istate->cache_nr * max_split < (int64_t)not_shared * 100;
