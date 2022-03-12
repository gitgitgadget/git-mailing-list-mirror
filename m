Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14184C433F5
	for <git@archiver.kernel.org>; Sat, 12 Mar 2022 04:36:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230221AbiCLEhW (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 11 Mar 2022 23:37:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbiCLEhV (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 11 Mar 2022 23:37:21 -0500
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B3E0159EAF
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 20:36:17 -0800 (PST)
Received: by mail-pf1-x42b.google.com with SMTP id z16so9574559pfh.3
        for <git@vger.kernel.org>; Fri, 11 Mar 2022 20:36:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:from:to:subject:references
         :in-reply-to:content-transfer-encoding;
        bh=CvZH3Xbe0wekTJUTxjeJZcXi0gNT91vvK3QlT1tiELk=;
        b=CleXO7jmW7sLxvpiAPax9mLs7/VKapunxEZn2VhhFnWhURt4XYfI38furpYgJ4Bxug
         7JOpdrDddUFReM+l9uHyETs4bEm8CqWx771CzLBoBG4hX4FHyDJV8R2/P+VDXyWKFe3H
         XaauNFCXOSCFYlVu14vtEH0dOYTqDQ6XpyHQ8GWZ3d29qLzd0/RCmq5TWCwxCDoUC6FC
         Y2Qml8OCoIQ7SSenm6DN/vxG2q5NyrN3nuCL+yplN5jZNI3OTFrXUiTw+Ur/gupSXIAc
         eWbLQp+5yuzEwEf4LWm1SIO/W1yGfdX/XuOZ67j0uKTwJrJpBFmjXUKQf2ppDt9DH7Zi
         OmSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:from:to
         :subject:references:in-reply-to:content-transfer-encoding;
        bh=CvZH3Xbe0wekTJUTxjeJZcXi0gNT91vvK3QlT1tiELk=;
        b=MgmIhD09m8gePYrylwPh/X2ZkRZQ2F4k3wjJj4FX2LiLV0fuXWDO7nfD04+3ycph21
         qCF+Y/ZO80KwHV6B2d+t3XHcQJmcQI/9noQbmMTfoWvR/c+YixEVG0t16b3IB2vNb443
         n/oC+JTv0SAxVHV0fHD0qD3TKpExEvBXk9EWcpHgue3TsOhqD/5WAa9DrSHxXkTu7dal
         uFG4jwP2rbUyIBfZc8AannMj7kmnsMzQAO1Yi9aQnjE+wFz4JioD12mu7U6QABVZYKjd
         mG7C+hMA16vIK83QtPgIToZBIFQ5tP7XoCDojteEO8Jat9CLED3WG8VDU8uivsK3DjIb
         vkeg==
X-Gm-Message-State: AOAM533XX6P1aLLN14fz0qTcyNlEgyJvHjFJHZvVMj9+TGBudHgqndME
        k7nXbmDmMqIRVP/ts/x8rdw=
X-Google-Smtp-Source: ABdhPJx1xIAinrcB8ukiOy7SP5xGEsIdc59cH2kxZGFXVzCo6p0MydE+4OyZKeaeTKEpl6cT3sBaLg==
X-Received: by 2002:a63:86:0:b0:36c:48e8:627e with SMTP id 128-20020a630086000000b0036c48e8627emr11361442pga.53.1647059776459;
        Fri, 11 Mar 2022 20:36:16 -0800 (PST)
Received: from ?IPV6:2405:201:a800:4df9:6560:dadc:f905:6d19? ([2405:201:a800:4df9:6560:dadc:f905:6d19])
        by smtp.gmail.com with ESMTPSA id nk5-20020a17090b194500b001bf01e6e558sm10553155pjb.29.2022.03.11.20.36.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 20:36:16 -0800 (PST)
Message-ID: <62e13889-315a-1a42-f37b-390702c0aa9d@gmail.com>
Date:   Sat, 12 Mar 2022 10:06:08 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
From:   jaydeepjd.8914@gmail.com
To:     Johannes Sixt <j6t@kdbg.org>, git@vger.kernel.org
Subject: Re: [PATCH v6] userdiff: add builtin diff driver for kotlin language.
References: <20220301070226.2477769-1-jaydeepjd.8914@gmail.com>
 <20220311072716.674808-1-jaydeepjd.8914@gmail.com>
 <16543315-8515-a4d7-d75b-e7fe9731a7cf@kdbg.org>
In-Reply-To: <16543315-8515-a4d7-d75b-e7fe9731a7cf@kdbg.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 3/12/22 1:37 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 11.03.22 um 08:27 schrieb Jaydeep P Das:
> > The xfuncname pattern finds func/class declarations
> > in diffs to display as a hunk header. The word_regex
> > pattern finds individual tokens in Kotlin code to generate
> > appropriate diffs.
> >
> > This patch adds xfuncname regex and word_regex for Kotlin
> > language.
> >
> > Signed-off-by: Jaydeep P Das <jaydeepjd.8914@gmail.com>
> > ---
> 
> Thank you. At first, I thought this round is it, but then I noticed this
> line:
> 
> > +<RED>0xFF_EC_DE_5E 0b100_000 1<RESET><GREEN>0xFF_E1_DE_5E 0b100_100 2<RESET>00_000
> 
> Notice how the change from 100_000 to 200_000 breaks out the first digit
> into its own token.

Wow. I completely missed it.

> > diff --git a/userdiff.c b/userdiff.c
> > index 8578cb0d12..c416c9b426 100644
> > --- a/userdiff.c
> > +++ b/userdiff.c
> > @@ -168,6 +168,18 @@ PATTERNS("java",
> >   	 "|[-+0-9.e]+[fFlL]?|0[xXbB]?[0-9a-fA-F]+[lL]?"
> >   	 "|[-+*/<>%&^|=!]="
> >   	 "|--|\\+\\+|<<=?|>>>?=?|&&|\\|\\|"),
> > +PATTERNS("kotlin",
> > +	 "^[ \t]*(([a-z]+[ \t]+)*(fun|class|interface)[ \t]+.*)$",
> > +	 /* -- */
> > +	 "[a-zA-Z_][a-zA-Z0-9_]*"
> > +	 /* hexadecimal and binary numbers */
> > +	 "|0[xXbB][0-9a-fA-F_]+[lLuU]*"
> > +	 /* integers and floats */
> > +	 "|[0-9][0-9_]*([.][0-9_]*)([Ee][-+]?[0-9]+)?[fFlLuU]*"
> 
> This line matches a non-empty digit sequence of any length, and I
> thought the longest match would win. Why is that not the case here?
> Frankly, I'm scratching my head over it. Any ideas?

Yes. The capture group ([.][0-9_]*) should occur once or zero times. So
this `([.][0-9_]*)?` will fix it.


