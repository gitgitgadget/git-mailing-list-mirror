Return-Path: <SRS0=g4/7=2A=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77EEDC43603
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:38:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4990F2073B
	for <git@archiver.kernel.org>; Tue, 10 Dec 2019 20:38:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="vNZC2c31"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726682AbfLJUiv (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 10 Dec 2019 15:38:51 -0500
Received: from mail-yw1-f47.google.com ([209.85.161.47]:38199 "EHLO
        mail-yw1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726366AbfLJUiv (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 10 Dec 2019 15:38:51 -0500
Received: by mail-yw1-f47.google.com with SMTP id 10so7847778ywv.5
        for <git@vger.kernel.org>; Tue, 10 Dec 2019 12:38:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=aDjdTvrUeK/bSN0v8pN7r/Ux0R/486Hmt5WKTy520I8=;
        b=vNZC2c31KXhPicaWILMmB43gFnc/c8xfTm1LXdDlhirRWAg7gvrr2KxZvjWqQ9NO/q
         SJWRPMh4Rda+ujyqqoAD5+ryanUkOk7v4eCQHx3gQyjiEphsUuMTYzzELJ3QYwG9a34H
         cdTHtu06BbT7ZX6pHSLbSKdf4GwNU++0LKJytZOI0Hpl1jf1v16juSpUpBn0DlA290pW
         q7CviIP4vz1nyLUVHxzWI/8M4gEuqDLW+lHfWLysun14KJ+PjS+LNxm0GbOCLUleLaEi
         aaME26tW3uSS5qaeu1STH0G2aCFehjgh2GQP/CbnnCxnpj82pzKhhQz0AVNNwvSdImjv
         8MNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=aDjdTvrUeK/bSN0v8pN7r/Ux0R/486Hmt5WKTy520I8=;
        b=fd094Opm5Na35OJ9qYFVz0fgeUQ3eVfXLnNmP+oLYdMY6FKrtwStlqYY0U5s49v0u2
         PhzD8JQB+B/XsMVJ70kUu+OIATprFK6WJAa07w02spTFknE36HEBs3eK4Itwf4dzwQbf
         bYm6XAR6eF2g17oIAM2aq7keOc08ZexehdAq0ngzG5QLCRaJqE/fnN58cT7Eubi000BO
         6VbCc4fCfytWTx67iwAZomdxNTkoil2bYLNJdnt76/TXQBjza4Pu61yZoU2PRJnO4+pj
         Uyf1Tp61W4gDhK+npPc1VFLbwig7gdRRMXa50jvbtMB89Rj626H0Bs49RrgrUw1Q4yhJ
         rn8A==
X-Gm-Message-State: APjAAAVVkueyjw/N+s96pDXwjTxhSFKlVpl0JJfWLVspv43Jl/JZMyfC
        C3NslCNIuYGdjVwgqWnfbhI=
X-Google-Smtp-Source: APXvYqxsfbS+lV2GCPCEkxKT1OBL2fxU56VxXLK8g4XCOeDGjVBg8/i3M1+m+Pzrk2kaeE82OoZl1Q==
X-Received: by 2002:a0d:ca82:: with SMTP id m124mr25712670ywd.453.1576010329901;
        Tue, 10 Dec 2019 12:38:49 -0800 (PST)
Received: from [192.168.1.83] ([99.85.27.166])
        by smtp.gmail.com with ESMTPSA id t3sm2091985ywi.18.2019.12.10.12.38.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Dec 2019 12:38:49 -0800 (PST)
Subject: Re: Could /Documentation/technical/commit-graph.txt be relicensed
 under a permissive license?
To:     Junio C Hamano <gitster@pobox.com>, KOLANICH <kolan_n@mail.ru>
Cc:     git@vger.kernel.org, Derrick Stolee <dstolee@microsoft.com>,
        Jeff King <peff@peff.net>, Elijah Newren <newren@gmail.com>
References: <E2770343-BB39-458C-835E-04F0753783C3@mail.ru>
 <xmqqimmoq6vw.fsf@gitster-ct.c.googlers.com>
From:   Derrick Stolee <stolee@gmail.com>
Message-ID: <70575b23-6adb-a29b-8df8-f9099f86eb0e@gmail.com>
Date:   Tue, 10 Dec 2019 15:38:35 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:72.0) Gecko/20100101
 Thunderbird/72.0
MIME-Version: 1.0
In-Reply-To: <xmqqimmoq6vw.fsf@gitster-ct.c.googlers.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 12/10/2019 3:10 PM, Junio C Hamano wrote:
> KOLANICH <kolan_n@mail.ru> writes:

I don't appear to have the original message? Perhaps it was
directly addressed to Junio?

>> ... the license of git itself is GPL, so I am not
>> allowed to use these 2 files to create an own permissive-licensed
>> tool reading this file. 
> 
> It is a wrong conclusion, isn't it?
> 
> GPL copyright protects the expression of the document, but the
> copyright protects only the expression, and does not protect the
> underlying format itself and the idea behind it.  So I do not see a
> need to relicense the documentation text at all.

(Insert "I am not a lawyer" warning.)

I think this is the correct interpretation. One can interact with
binary files as you want. In fact, there are likely privately
licensed products that interact with Git's pack-files even though
their format documentation is under GPL.

What _could_ be problematic is repeating the documentation directly
in another permissive-licensed repository.

Thanks,
-Stolee

