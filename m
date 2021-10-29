Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3A5D3C433FE
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 11:29:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1646B6115C
	for <git@archiver.kernel.org>; Fri, 29 Oct 2021 11:29:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231872AbhJ2Lb2 (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 29 Oct 2021 07:31:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231670AbhJ2Lb1 (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 29 Oct 2021 07:31:27 -0400
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F554C061570;
        Fri, 29 Oct 2021 04:28:59 -0700 (PDT)
Received: by mail-wm1-x332.google.com with SMTP id v127so8555275wme.5;
        Fri, 29 Oct 2021 04:28:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:references:cc:in-reply-to:content-transfer-encoding;
        bh=3OtKDZH6u6meon+NIAzXtkJKHzFLB40f75M3A4SVnoQ=;
        b=DPBI5WMO3AFOivb+NmVNMc/+/F1Tw33ZE9JlAXWdin/wLiglRat5+6HOQOvrk5Pz8X
         g7GNpHGg4wOhghoCPLQhe87Rd2ZDLjfOJrBK5IGUf41I73FBcLXyqV1YswbVYi5TXU75
         58gsAXTOQbEpqkq4RYtw2IOLB6OQFTL0KAqzD9Vb2HMfWG2vpPJhNN4dgt5blL5fPd4X
         XgVxY+EXapkyQHhCLVvYdBMCKQwcZnbXsP1X80TSTR2wh0SGGPXGLauJhv7iXfxjYu2O
         vFHF44nxWoJNFWPNDbgwDpLWjVsmvxl+0t7q2zJ0Wbd7Rd92+Jh3UWsabYd7VVigpE70
         bysw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:references:cc:in-reply-to
         :content-transfer-encoding;
        bh=3OtKDZH6u6meon+NIAzXtkJKHzFLB40f75M3A4SVnoQ=;
        b=L2zQOHnGnkmynhEhVHkavwuCSEJc9Fqy/EbE5GHmIP3UIqa6UTcq+ZWg9OchimcX9x
         6EegfJMrDFetRWfNMz59b0xdE0V1x+8p+9vbYJSaPi/5ujRae0bHIFTtdJjnN6bqShNr
         MZwJN3buhdIesYl4ZH9mkC9gPMnAYLvy8xOfMdWxL3aickxoGupyo891IBGRgHVFx8a7
         XGIx8ju4QPqh4o5L+ejtZy3LKXWhvkeNoMfrCp/84FsLDfkDy3smGAJjd2/5jHih2pZV
         bXMOaW5QH9v2X2/PzwgYSW/KFksVGp3GbBTXwnfv5yY1d75XF+mb0a8Q7y80FUtFxrsS
         5esg==
X-Gm-Message-State: AOAM531lLRyxD7R2Kc2mrlMa6KVe2C+hSjomnL/hFSPWGrKjt90SEBaI
        0BHAlch9Hl2sF1kfCRZ02h1jM5cRgM0=
X-Google-Smtp-Source: ABdhPJyDPipSCgdKnazFNp9RAmjmx3v3lB1R0SKAnpklGZ3DKJr5RE1aP3ZcUAZGcruRp+oOBsMKnQ==
X-Received: by 2002:a1c:3504:: with SMTP id c4mr7893077wma.160.1635506937856;
        Fri, 29 Oct 2021 04:28:57 -0700 (PDT)
Received: from [10.168.10.11] ([170.253.36.171])
        by smtp.gmail.com with ESMTPSA id p1sm8743041wmq.23.2021.10.29.04.28.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 Oct 2021 04:28:57 -0700 (PDT)
Message-ID: <73ac38a2-c287-4cc1-4e9c-0f9766ac4c0c@gmail.com>
Date:   Fri, 29 Oct 2021 13:28:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.1
Subject: Re: Is getpass(3) really obsolete?
Content-Language: en-US
From:   "Alejandro Colomar (man-pages)" <alx.manpages@gmail.com>
To:     Libc-alpha <libc-alpha@sourceware.org>,
        linux-man <linux-man@vger.kernel.org>
References: <a0371f24-d8d3-07d9-83a3-00a4bf22c0f5@gmail.com>
Cc:     git@vger.kernel.org, "tech@openbsd.org" <tech@openbsd.org>
In-Reply-To: <a0371f24-d8d3-07d9-83a3-00a4bf22c0f5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

[Add a few CCs, since I mentioned them.]

On 10/29/21 13:15, Alejandro Colomar wrote:
> Hi,
> 
> As the manual pages says, SUSv2 marked it as LEGACY, and POSIX doesn't 
> have it at all.  The manual page goes further and says "This function is 
> obsolete. Do not use it." in its first lines.
> 
> But, glibc doesn't seem to have deprecated this function at all.  And it 
> seems to be the most portable way to get a password, even if it's not in 
> POSIX.
> 
> BSDs have readpassphrase(3), but glibc doesn't, so unless you recommend 

OpenBSD also marks getpass(3) as obsolete and recommends readpassphrase(3):
<https://man.openbsd.org/getpass>

> using readpassphrase(3) from libbsd, or plan to add it to glibc, I think 
> getpass(3) should be the recommended function in Linux, and therefore we 
> should remove the hard words against it.
> 
> As a real example, git(1) uses getpass(3).
> <https://github.com/git/git/blob/master/compat/terminal.c>
> 
> What are your thoughts?
> 
> Thanks,
> 
> Alex
> 
> 

-- 
Alejandro Colomar
Linux man-pages comaintainer; https://www.kernel.org/doc/man-pages/
http://www.alejandro-colomar.es/
