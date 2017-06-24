Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id AF4792082E
	for <e@80x24.org>; Sat, 24 Jun 2017 10:59:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1751333AbdFXK74 (ORCPT <rfc822;e@80x24.org>);
        Sat, 24 Jun 2017 06:59:56 -0400
Received: from mail-wr0-f193.google.com ([209.85.128.193]:33438 "EHLO
        mail-wr0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751272AbdFXK7z (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 24 Jun 2017 06:59:55 -0400
Received: by mail-wr0-f193.google.com with SMTP id x23so18600586wrb.0
        for <git@vger.kernel.org>; Sat, 24 Jun 2017 03:59:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:references:user-agent:in-reply-to:date
         :message-id:mime-version:content-transfer-encoding;
        bh=MlUrKMh1Kp0yOOmlLJEU8Nuk7OFVrsNAxzntYqEhPug=;
        b=mRl/DGN6hVY3ZRtrp0Asf3ndIS1zB1Hk7EOxgPO+Ju+47UkNsud2OCX16D7rlM/SLV
         Zi4aJY9ePm5u9RW5sSqdjh9c0xgaxPwkuO4sEW444IaV7FTDe7jf1JCt4zJ8TThuF50E
         1Dz2r1dnGSPsmHy9xpWHuezuGd1OFPLryZ1kePLbnWDFOEaTvIwI7uHFdYAHy9s8FoEx
         T18vwp+4QjP1ydriOKHcvK/tusw0Rv9VK8zcwtl/IQuBnPBxZLNyNlKICmOjPqQedSbo
         aiQI0LfX4+TAAHJWokGwpevDgUJcTQE+mIsNX8CbD6/8KNA4aZaOBrKG88q7IjBTbw/7
         /7jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:references:user-agent
         :in-reply-to:date:message-id:mime-version:content-transfer-encoding;
        bh=MlUrKMh1Kp0yOOmlLJEU8Nuk7OFVrsNAxzntYqEhPug=;
        b=GMHsq6JcvPUWirc2CHJdE3dVKF6foLEbMPzbcg06NsA0ovKDRgrTs8LTals6iDpvTv
         9wvo30mjwGIK81d4u//ymHAIglTUPXMdcfJFXapDd1dT8hBbZ5FWRt7S5Eh7jIyXnvok
         PZ/4bMMOVhI7+GEIWURCCDcI1PHTund5OOaBu/JYksZaxnZy/6tcoUkbsI77H3cEnUPV
         bAX9QInONmEFaHylVc7+ZbMBzDzF+vFU82nMJ7Btlmc6CIyoedcls0ehBiLEgvTf++fj
         X4onN+DoZZ8EWzzxcN6PKHyMA/boKIs59lWZjetuwX4/bOX6GhMRHy5e6CSpSDacA3Wf
         pD9g==
X-Gm-Message-State: AKS2vOylJvhcPgKbLR5M0dZN3bpUwdJgxlBi+G5x4xZ0NmYmy5YVcyGa
        iQvgjdpJc9HLXg==
X-Received: by 10.80.172.93 with SMTP id w29mr4696973edc.13.1498301993640;
        Sat, 24 Jun 2017 03:59:53 -0700 (PDT)
Received: from snth (g74110.upc-g.chello.nl. [80.57.74.110])
        by smtp.gmail.com with ESMTPSA id h57sm3332625edh.52.2017.06.24.03.59.52
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 24 Jun 2017 03:59:52 -0700 (PDT)
Received: from avar by snth with local (Exim 4.84_2)
        (envelope-from <avarab@gmail.com>)
        id 1dOin9-00029r-T0; Sat, 24 Jun 2017 12:59:51 +0200
From:   =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org,
        =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
        Brandon Williams <bmwill@google.com>
Subject: Re: [RFC/PATCH 2/3] wildmatch: add interface for precompiling wildmatch() patterns
References: <20170622213810.14785-1-avarab@gmail.com> <20170622213810.14785-3-avarab@gmail.com> <xmqqshiq9naq.fsf@gitster.mtv.corp.google.com>
User-agent: Debian GNU/Linux 8.8 (jessie); Emacs 25.1.1; mu4e 0.9.19
In-reply-to: <xmqqshiq9naq.fsf@gitster.mtv.corp.google.com>
Date:   Sat, 24 Jun 2017 12:59:51 +0200
Message-ID: <87zicx1wig.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


On Sat, Jun 24 2017, Junio C. Hamano jotted:

> Ævar Arnfjörð Bjarmason  <avarab@gmail.com> writes:
>
>> +struct wildmatch_compiled *wildmatch_compile(const char *pattern, unsigned int flags)
>> +{
>> +	struct wildmatch_compiled *code = xmalloc(sizeof(struct wildmatch_compiled));
>> +	code->pattern = xstrdup(pattern);
>> +	code->flags = flags;
>> +
>> +	return code;
>> +}
>> +
>> +int wildmatch_match(struct wildmatch_compiled *code, const char *text)
>> +{
>> +	return wildmatch(code->pattern, text, code->flags);
>> +}
>
> Is the far-in-the-future vision to make this the other way around?
> That is, this being scaffolding, wildmatch_match() which is supposed
> to be precompiled match actually uses wildmatch() as its underlying
> engine, but when a viable compilation machinery is plugged in, the
> wildmatch_match() that takes a precompiled pattern will call into
> the machinery to execute the compiled pattern, and wildmatch() will
> be reimplemented as "compile, call wildmatch_match() once and
> discard" sequence?

Exactly there would be no functional difference in the results, only
fixed overhead.

wildmatch() would be the one-off lazy interface and
wildmatch_{compile,match,free}(), just like how you can have a wrapper
function that calls regcomp() followed by regexec() & regfree(), but
it's better to structure your code so you're not compiling & freeing the
pattern all the time.

Right now of course there's no difference in the behavior, and a
trivially more overhead with the extra xstrdup() & free(), but I wanted
to split up the discussion of the semantics of the interface from any
actual behavior change in wildmatch() which would make use of it further
down the line.

> Otherwise I'd be worried about wildmatch() vs wildmatch_match()
> introducing subtle behaviour differences that leads to hard to debug
> problems.
