Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_BL_SPAMCOP_NET,
	RCVD_IN_DNSWL_HI,T_DKIM_INVALID shortcircuit=no autolearn=no
	autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id B5D771F62D
	for <e@80x24.org>; Fri,  6 Jul 2018 18:17:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933992AbeGFSRL (ORCPT <rfc822;e@80x24.org>);
        Fri, 6 Jul 2018 14:17:11 -0400
Received: from mail-wr1-f68.google.com ([209.85.221.68]:35574 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933872AbeGFSRL (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 6 Jul 2018 14:17:11 -0400
Received: by mail-wr1-f68.google.com with SMTP id h40-v6so5009540wrh.2
        for <git@vger.kernel.org>; Fri, 06 Jul 2018 11:17:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version;
        bh=zrhNHLUapigdthceLTsjjRu/EsYpvxpHzdfs+ISRiCo=;
        b=ZfiNgGGgAoM9W67YXRE4IXqpFUl42TgcN4WfjCD+joQjSSB7lhNQpAtlmGiaSen4ln
         fHP0+pRt91P2JCSKYkFT8uMBjPKIBjETDIixltGxZB0Bwy1TsYmBDdlF1P1dLzyqborY
         SojNk7LzduR3Pdvged1Dg/+yPYn4iocbwxw6b8MyzfEGe6JRSlbXVKfyMHRmW6PpMx1v
         Bt8+LOuE0OtxjfaBn+OAFrgjB8QzfPh781uiPGRTwhVt5AH+uPe/q7ZjCDMKM24Hs2yn
         +n2hhpRVnsP9TP57qCyEa0b/FIHIIReKbsxAWYrYwd95ymrFTd76PU7Az4XSaczz3XCN
         2eMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version;
        bh=zrhNHLUapigdthceLTsjjRu/EsYpvxpHzdfs+ISRiCo=;
        b=DkoMF8G0OvXGD/0oV2xLwddH6ppG2BkbsgETZnceS/QEx7DyBN0NuePdZ2/zb/9lC4
         Z4c6vVeGJbn5FAf7OP7CxYXgKHgxRujNLnTTEVte+A7faigGJvjOXq9Y2CbKVJUu9pLq
         GzJEH0j7eOTScVEqmEVXCZWPZswnBOQgTnk/nDlAERpK3+OtOBoDp6P+qeGL3fqWIR/6
         GaJc2FAtmcwcRnOL6DjUhCX8gS9lzvMifEo6pidkp1yf6342vt3ml7Iw/Ks2Zg3ZwShh
         qOm7QUhQn2YMmIPvZqYlrnjJSnOGwrHu+YZbukfFBLRPyojd63KEpiTwhUX6k305QYTM
         3O3A==
X-Gm-Message-State: APt69E04ZM+fFUBLqmpYXgBCG7UcKDGUueA84DBnX3MJSf0Iy6rC6bok
        yBI/E5/MsAAkwaryK5GT1OjkLOoT
X-Google-Smtp-Source: AAOMgpdtxUrBzqZy7Y43ibiyLUXf19aE00kFQi0MlNv1rDflPvYqdnR0dTA5BgFLw/s5fIUQkFGIEA==
X-Received: by 2002:adf:ffc7:: with SMTP id x7-v6mr6800084wrs.137.1530901029703;
        Fri, 06 Jul 2018 11:17:09 -0700 (PDT)
Received: from localhost (168.50.187.35.bc.googleusercontent.com. [35.187.50.168])
        by smtp.gmail.com with ESMTPSA id p3-v6sm17458598wrg.47.2018.07.06.11.17.08
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 06 Jul 2018 11:17:08 -0700 (PDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Taylor Blau <me@ttaylorr.com>
Cc:     git@vger.kernel.org, peff@peff.net, avarab@gmail.com
Subject: Re: [PATCH v2] grep.c: teach 'git grep --only-matching'
References: <702e1d2a26704c7c932ee4b96f32bff4c45e485e.1530654455.git.me@ttaylorr.com>
        <bf53ea90c9114d0c4e3cc2b1df05464bfeb6e84f.1530716005.git.me@ttaylorr.com>
        <20180704145540.GA51949@syl.attlocal.net>
Date:   Fri, 06 Jul 2018 11:17:08 -0700
In-Reply-To: <20180704145540.GA51949@syl.attlocal.net> (Taylor Blau's message
        of "Wed, 4 Jul 2018 09:55:40 -0500")
Message-ID: <xmqqpo00kz4r.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Taylor Blau <me@ttaylorr.com> writes:

> On Mon, Jun 25, 2018 at 02:59:07PM -0500, Taylor Blau wrote:
>> Teach 'git grep --only-matching', a new option to only print the
>> matching part(s) of a line.
>>
>> [ ... ]
>>
>> diff --git a/Documentation/git-grep.txt b/Documentation/git-grep.txt
>> index 0de3493b80..078b4e3730 100644
>> --- a/Documentation/git-grep.txt
>> +++ b/Documentation/git-grep.txt
>> @@ -17,7 +17,7 @@ SYNOPSIS
>>  	   [-l | --files-with-matches] [-L | --files-without-match]
>>  	   [(-O | --open-files-in-pager) [<pager>]]
>>  	   [-z | --null]
>> -	   [-c | --count] [--all-match] [-q | --quiet]
>> +	   [ -o | --only-matching ] [-c | --count] [--all-match] [-q | --quiet]
>>  	   [--max-depth <depth>]
>>  	   [--color[=<when>] | --no-color]
>>  	   [--break] [--heading] [-p | --show-function]
>> @@ -201,6 +201,10 @@ providing this option will cause it to die.
>>  	Output \0 instead of the character that normally follows a
>>  	file name.
>>
>> +-o::
>> +--only-matching::
>> +	Output only the matching part of the lines.
>
> Junio,
>
> My apologies that I sent the previous patch with incorrect indentation on this
> line. Would you mind queueing this one instead?

Surely, and thanks for telling me what difference to look for
between the versions.  Will replace with the one with indent before
"Output only ...".

