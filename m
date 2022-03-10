Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 03523C433FE
	for <git@archiver.kernel.org>; Thu, 10 Mar 2022 10:52:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241406AbiCJKxO (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Mar 2022 05:53:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241477AbiCJKxL (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Mar 2022 05:53:11 -0500
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98B0D5D19D
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 02:52:10 -0800 (PST)
Received: by mail-pg1-x52b.google.com with SMTP id t187so4418687pgb.1
        for <git@vger.kernel.org>; Thu, 10 Mar 2022 02:52:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=Ehs9JtR3/T/yDRQceRlFCHJZo38toji9vfGrB6yT4tU=;
        b=S34XEvYx/fCePoHJh6sPxGdAi9NN44vI56Tr489f8RHztUae9UAnd2a0U5RKLU5EZD
         9WcyMKLuDUk1yxnEdVoTMWhUMDuT6dt0uK3XHThzFUHEp9RRSl2Ne18PFSmVydZb9Sk9
         xICpCtY2neZ/0Wo4TE+1l2NvGffPG9jZKyJv61BW+81X6fYj2ZzRLrl5MvBKvYsV1j/A
         yaxbMAsj/3/G++PGu4mnzndWz2S0kixvjH67vjSHfa3luJ4XG8MwZ3rTnux3ivwZ5ksX
         DOt5B8yJ9+toNU6SMAlDhM8YZlugMvFoKRGN6WMeh6YkV7SyE01fqSKgXS2zmnyginfo
         l1/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :subject:references:in-reply-to:content-transfer-encoding;
        bh=Ehs9JtR3/T/yDRQceRlFCHJZo38toji9vfGrB6yT4tU=;
        b=bZLQJEZY3QT/sMAd8QSFRkabRXN0iZ7KYHD7wjWzGtF1af5C0ynllkq8063SU5jPaE
         ht06vwVBaFDAQQEjUEiVFEk8lkeWuieP6hcJH6Ohmq7MTG/+8RfXOJOdim8RJIydZE/I
         Na4dOhRi5ZEJnhnSEVShKCss7z+rsN8qCt4R3Ita+9a6S5GDmKJ1l15lcBVCNDZu0BW+
         rHoyj3WsDLjmdi1FgmZdI49Us238eRpUkanWrnyulPjOAafJEGzItBCheNJJzHhkCu01
         OntSa2leL1x8BGqY+nkPdxrRG0EIzIIsnawclPogtbVq6UfRqGxF6Ab5r35wGORs0ZJJ
         Fuiw==
X-Gm-Message-State: AOAM531mtVZg6Ls1dWrCvuiminVSuN+AkPRqnQKWeEgMl2s3ET3KGVuP
        XQPi7KE0xoHgagvN0tgkqR95LV1NIuZtaw==
X-Google-Smtp-Source: ABdhPJy1s1V+lK7tP5grtfpYQR8G7z9AJDjp2o2EAnsNLlG2aYhSymAGGR6YPDyXE5IanUzVHhLaCA==
X-Received: by 2002:a65:6050:0:b0:378:c9e5:b3ab with SMTP id a16-20020a656050000000b00378c9e5b3abmr3544155pgp.338.1646909530105;
        Thu, 10 Mar 2022 02:52:10 -0800 (PST)
Received: from ?IPV6:2405:201:a800:4df9:5194:c9b1:2d1f:598e? ([2405:201:a800:4df9:5194:c9b1:2d1f:598e])
        by smtp.gmail.com with ESMTPSA id y34-20020a056a00182200b004f71c56a7e8sm6516708pfa.213.2022.03.10.02.52.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 10 Mar 2022 02:52:09 -0800 (PST)
Message-ID: <8d411f30-bfe9-ffbe-5ec5-1ae7b5c9588f@gmail.com>
Date:   Thu, 10 Mar 2022 16:22:05 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   jaydeepjd.8914@gmail.com
To:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH v5] userdiff: add builtin diff driver for kotlin language.
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220306111539.336475-1-jaydeepjd.8914@gmail.com>
 <8799cd42-bb05-a827-187d-33fb03565f21@kdbg.org>
 <cf8a9316-c81e-2477-a565-1c38a168fc67@gmail.com>
 <72aca675-4c65-36bf-1337-34b2d1f40bb4@kdbg.org>
In-Reply-To: <72aca675-4c65-36bf-1337-34b2d1f40bb4@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Sorry for the late reply. 

On 3/9/22 12:02 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 08.03.22 um 17:54 schrieb jaydeepjd.8914@gmail.com:
> > So, the final regexes are these, right?:
> 
> Not quite.
> 
> >
> >       "[a-zA-Z_][a-zA-Z0-9_]*"
> >       /* hexadecimal and binary numbers */
> >       "|0[xXbB][0-9a-fA-F_]+[lLuU]*"
> >       /* integers and floats */
> >       "|[0-9][.]?[0-9_]+([Ee][-+]?[0-9]+)?[fFlLuU]*"
> 
> This would not match 12.5 because you allow only a single digit before
> the decimal point. Perhaps
> 
> 	"|[0-9][.0-9_]*([Ee][-+]?[0-9]+)?[fFlLuU]*"

Okay. 

> >       /* floating point numbers beginning with decimal point */
> >       "|[.][0-9][0-9_]*([Ee][-+]?[0-9]+)?[fFlL]?"
> >       /* unary and binary operators */
> >      
> > "|[-+*/<>%&^|=!]?==?|--|\\+\\+|<<=|>>=|&&|[||]|->|\\.\\*|!!|::|[?:.][.:]"),
> 
> [||] does not work as you intend. A new suggestion: do not start with an
> initial optional character in order to reduce the number of
> backtrackings that the regular expression evaluation has to do. I would
> write this line as
> 
> 	"|[-+*/<>%&^|=!]==?|--|\\+\\+|<<=|>>=|&&|\\|\\||->|\\.\\*|!!|::|[?:.][.:]"),
> 
> BTW which operators are handled by "[?:.][.:]"? I'm asking because you
> list :: separatly that would also be matched by this sub-expression.

It matches the following operators: `?:`, `?.`, `..` `::`. Although matching `::` is
unnecessary since its matched before.

https://kotlinlang.org/docs/keyword-reference.html#operators-and-special-symbols


 

