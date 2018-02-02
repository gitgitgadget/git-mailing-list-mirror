Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,T_DKIM_INVALID,
	T_RP_MATCHES_RCVD shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id C31311F404
	for <e@80x24.org>; Fri,  2 Feb 2018 19:17:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753269AbeBBTRJ (ORCPT <rfc822;e@80x24.org>);
        Fri, 2 Feb 2018 14:17:09 -0500
Received: from mail-wr0-f194.google.com ([209.85.128.194]:46752 "EHLO
        mail-wr0-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752575AbeBBTRH (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 2 Feb 2018 14:17:07 -0500
Received: by mail-wr0-f194.google.com with SMTP id g21so23528181wrb.13
        for <git@vger.kernel.org>; Fri, 02 Feb 2018 11:17:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-transfer-encoding;
        bh=K33Y+E6nOGr4F2RVlO8tUFcbFhAi/0xVt4BrWAHkJ28=;
        b=pg0/9ErMZBEcjIUUvD44ZPKUTTjqNVreU0srpdZNt03PmU+57uMmjVi9HrfVVWJwY9
         7CTvlFQK9Zj1usk5yWxBWlodBkBK9RxaVuOWQOLsr//0hEoXFi0n84gK5hrug1dhVsli
         Zfa+VZMSyk4cqoK5E0p6N54Qrkm/Fpky9n7q86XencCb8lwesXXTX80bFK9NP2X4xHQi
         fjB7SEUkP0vben07CFTmy6nXqrGoHS6acuKpUSuJ7PTS7x0kRXTlD4KECH/NBTHjW9ba
         HuI1OdOcF6uObrqlw5QIj1EJZnuNiBJSxiaEPq5l390TBAtmhtRsoDwqI773tRM10O7w
         Z7Xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:references:date
         :in-reply-to:message-id:user-agent:mime-version
         :content-transfer-encoding;
        bh=K33Y+E6nOGr4F2RVlO8tUFcbFhAi/0xVt4BrWAHkJ28=;
        b=A3uXl/sO9U0fqzQg6EzNRvosU3SdLjuG4tlfiJNP0WpBzlxk2RIhqcXaKfFIcqwNHL
         qL0jSTdOKc9T1O92pDcUv6qwn4pVNtIZSfFhJAA2W1qhGR95YLhTg+Rb2FvTFn77N2tO
         OsyRZxUQKFbrcDpF1mnz96Jwq9pxsL0Qdpf4cYhXQoFDdGbYpc9e3rMvqBmNR2SPzQ05
         3Tyf9RPaR2koz2ABw56J/wi6N0gyw/VVA8Kx5C2KWJUN+EbUgn86ATTPW1unBUswWqhW
         NCZOnnDi50aDY9ZykQw01BpmAp57QCucRvd5nc4Y68KAfda+xnkGKN9keixPQWQEJLYA
         mnbg==
X-Gm-Message-State: AKwxytcNBClqVngC/OVLm5MzxaIPAn3YUZPc4Scwz2CNYl2YOwytmRol
        CIvZYDQFNNysW5hjCeYGhYE=
X-Google-Smtp-Source: AH8x227ut1l36ubcIWPmipwzZe2WBC6cVjasomhJPWON+DZXGNo3J8H0ECcxsp0EOrxnNnKPusiu9g==
X-Received: by 10.223.168.49 with SMTP id l46mr26758459wrc.29.1517599026168;
        Fri, 02 Feb 2018 11:17:06 -0800 (PST)
Received: from localhost (112.68.155.104.bc.googleusercontent.com. [104.155.68.112])
        by smtp.gmail.com with ESMTPSA id c14sm9003642wmh.2.2018.02.02.11.17.05
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 02 Feb 2018 11:17:05 -0800 (PST)
From:   Junio C Hamano <gitster@pobox.com>
To:     Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
Cc:     Lars Schneider <larsxschneider@gmail.com>,
        Git List <git@vger.kernel.org>, Johannes Sixt <j6t@kdbg.org>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Jeff King <peff@peff.net>,
        Ramsay Jones <ramsay@ramsayjones.plus.com>,
        Johannes.Schindelin@gmx.de
Subject: Re: [PATCH/RFC v5 7/7] Careful with CRLF when using e.g. UTF-16 for working-tree-encoding
References: <xmqqshawfgaa.fsf@gitster.mtv.corp.google.com>
        <20180129201911.9484-1-tboegi@web.de>
        <55B6C3D5-4131-4636-AD0E-20759EDBE8CD@gmail.com>
        <20180130144002.GA30211@tor.lan>
        <10091BA4-1069-4A65-9057-CAAD87F9B55F@gmail.com>
        <20180131172837.GA32723@tor.lan>
Date:   Fri, 02 Feb 2018 11:17:04 -0800
In-Reply-To: <20180131172837.GA32723@tor.lan> ("Torsten =?utf-8?Q?B=C3=B6g?=
 =?utf-8?Q?ershausen=22's?=
        message of "Wed, 31 Jan 2018 18:28:37 +0100")
Message-ID: <xmqqtvuzcibz.fsf@gitster-ct.c.googlers.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.2.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Torsten Bögershausen <tboegi@web.de> writes:

> There are 2 opposite opionions/user expectations here:
>
> a) They are binary in the working tree, so git should leave the line endings
>    as is. (Unless specified otherwise in the .attributes file)
> ...
> b) They are text files in the index. Git will convert line endings
>    if core.autocrlf is true (or the .gitattributes file specifies "-text")

I sense that you seem to be focusing on the distinction between "in
the working tree" vs "in the index" while contrasting.  The "binary
vs text" in your "binary in wt, text in index" is based on the
default heuristics without any input from end-users or the project
that uses Git that happens to contain such files.  If the users and
the project that uses Git want to treat contents in a path as text,
it is text even when it is (re-)encoded to UTF-16, no?

Such files may be (mis)classified as binary with the default
heuristics when there is no help from what is written in the
.gitattributes file, but here we are talking about the case where
the user explicitly tells us it is in UTF-16, right?  Is there such a
thing as UTF-16 binary?
