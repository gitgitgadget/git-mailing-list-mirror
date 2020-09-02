Return-Path: <SRS0=xf+W=CL=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28EF1C433E7
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 15:37:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E16E7207EA
	for <git@archiver.kernel.org>; Wed,  2 Sep 2020 15:37:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eQCEnOCe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgIBPhX (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 2 Sep 2020 11:37:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726618AbgIBPhI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 2 Sep 2020 11:37:08 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70068C061244
        for <git@vger.kernel.org>; Wed,  2 Sep 2020 08:37:08 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id o5so5697032wrn.13
        for <git@vger.kernel.org>; Wed, 02 Sep 2020 08:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=m3xFvyC/eparpnJd335nMSJ3AYZcHlqDpK8JXNeWo24=;
        b=eQCEnOCeAwAYuBXMGlTJNoOEKQh9C+2+NXam9QUIznB7wySyprCSIgvvD3RJAADZsU
         mU+k3q9tCMaAaCp9WTn6kzDYaLviogQjxDd3DOfAmQMpc/Ky2rcAyVN9GL7Pm3BePqSS
         qXZ8iKPntK5Fg3mVzUA0Vy9bqrEgsxy6ohrp0NDE479vS6ouQ/s9iCPvoSE2XgbEVsME
         MVk8+YQwCCytvQN3vqX6g7DqwoQtiJ8P/Beew18kUYkrqzgrGmUpuZe0M8lCT9NW+5De
         PqwKgzdyt9ySaf0Fkqe3CEttR2PAnorSYzERuaiYf3oxsdKV4vzqh6DCvoH3Ggm16Hkf
         Qd3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=m3xFvyC/eparpnJd335nMSJ3AYZcHlqDpK8JXNeWo24=;
        b=oV8/NWkqQL6ixkCDI+UZqm9nPlxOLeR+LU7T+aPbTxcSQy6LJe31mkM737e8aQrOO1
         l/s1T+tEQZcYnEXRdoCR20TGsTWkWir7t1hDarTe3vz1sG6KlG4+bQHRwYr9KCBxH9DR
         JBlzvc819AMDvpijXja1NA6nYMY7EX3MkNeIz1PALDB8Ayt+yj7vMa9HDyOVy9de/A50
         xQPoC58hp3OKbIxWr8YQ+sxnniPwwl22o0T6iHZpMROcEYwb4XKNdJXK4EXxvRq04Jet
         jmBA9GISAUpOfDVH02PQNBj2ElhPeG1FigN2X0gJRnpmKnP3Mq1B9FIB7i9wctBn6+LN
         ZhJg==
X-Gm-Message-State: AOAM530+xY3IfFMycH/ExWtM5eKuMHl+K78zBkPqLclbpi1u04jexAWe
        Apsdeo1xDOEEGbFNElZOSwEcT734cjY=
X-Google-Smtp-Source: ABdhPJwB+rzrXAWT4pZ40bHvXaa90dZsJHT/qvl+gF481YvHqn8/gw/Y1mFscrN9Slk8YZi6kRx+cw==
X-Received: by 2002:adf:eb05:: with SMTP id s5mr8540470wrn.0.1599061026927;
        Wed, 02 Sep 2020 08:37:06 -0700 (PDT)
Received: from [192.168.0.104] (atoulouse-654-1-378-135.w86-199.abo.wanadoo.fr. [86.199.233.135])
        by smtp.gmail.com with ESMTPSA id n124sm55620wmn.29.2020.09.02.08.37.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Sep 2020 08:37:06 -0700 (PDT)
Subject: Re: [PATCH v2 03/11] merge-index: libify merge_one_path() and
 merge_all()
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, phillip.wood@dunelm.org.uk
References: <20200625121953.16991-1-alban.gruin@gmail.com>
 <20200901105705.6059-1-alban.gruin@gmail.com>
 <20200901105705.6059-4-alban.gruin@gmail.com>
 <xmqqft81cidt.fsf@gitster.c.googlers.com>
From:   Alban Gruin <alban.gruin@gmail.com>
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
 sbwbxA==
Message-ID: <6e16673b-2c66-ddaf-5dec-abdd770adcff@gmail.com>
Date:   Wed, 2 Sep 2020 17:37:04 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.12.0
MIME-Version: 1.0
In-Reply-To: <xmqqft81cidt.fsf@gitster.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: fr-FR
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Le 01/09/2020 à 23:11, Junio C Hamano a écrit :
> Alban Gruin <alban.gruin@gmail.com> writes:
> 
>> The "resolve" and "octopus" merge strategies do not call directly `git
>> merge-one-file', they delegate the work to another git command, `git
>> merge-index', that will loop over files in the index and call the
>> specified command.  Unfortunately, these functions are not part of
>> libgit.a, which means that once rewritten, the strategies would still
>> have to invoke `merge-one-file' by spawning a new process first.
>>
>> To avoid this, this moves merge_one_path(), merge_all(), and their
>> helpers to merge-strategies.c.  They also take a callback to dictate
>> what they should do for each file.  For now, only one launching a new
>> process is defined to preserve the behaviour of the builtin version.
> 
> ... of the "builtin" version?  I thought this series is introducing
> a new builtin version?  Puzzled...
> 

`merge-index' is already a builtin, this step libifies it.  Its core
feature is to call repeatedly a command (usually it's
`git-merge-one-file'), but the new version will call a callback instead,
so its behaviour is not hardcoded.  This patch only provides a callback
starting a new command to preserve its behaviour.

Perhaps rewording the last sentence like this would be better?

  For now, only one launching a new process is defined, to preserve the
behaviour of `merge-index'.

