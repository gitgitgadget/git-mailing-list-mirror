Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED82AC433EF
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 03:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BE8EE608FE
	for <git@archiver.kernel.org>; Tue, 12 Oct 2021 03:14:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232018AbhJLDQy (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 11 Oct 2021 23:16:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbhJLDQw (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 11 Oct 2021 23:16:52 -0400
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55A15C061570
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 20:14:51 -0700 (PDT)
Received: by mail-pg1-x532.google.com with SMTP id q5so4517621pgr.7
        for <git@vger.kernel.org>; Mon, 11 Oct 2021 20:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=mAjLDYOWS14KqmOjzTrPpHaOisGEReWo1xGOKQv3wS0=;
        b=kpy3J5W0dq046Bpc1PUJy7SXWGDHSTrJglZU5ZQUez5EvyULZ4HdrA4uogQec99mIv
         T0uISyx6CQUN/LJst4yYWReLjiKYuLOtDskHNhR3IbOneil7wJp8bHwhc8gRnMydAEH7
         ySmy/ZTuIMxEunVTVt1r02VTdVtDqC1lZ1kgVPl/hTynLadCrq7s5hDjjAXCZ8cZfvX8
         8EXHBSHhpp2zi0rm7bARUa1Km6RbszILwKm/7P552ZiAnduvXhQS/jGp5j61uc9DtB8/
         eM84KthPYbWYW60HKOtYsHHoiTP7r9B5TFOt4Txy7a5RWD1blrghNsiG+3f/2VV+P7ia
         TYOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=mAjLDYOWS14KqmOjzTrPpHaOisGEReWo1xGOKQv3wS0=;
        b=QB/q7k9GVog0nwOMpzpRGsyq+ZMPEQRAFu0KXZ49aEiPfylfK8OlfC7oEKSqafCe/9
         8BaXnDux9vKfGqWZXVbA4YgQZeJJDWCLAZHoBzol3nSFa0H6hgtaske2fGrXrKH07oKo
         nRvuDmfgX6sizxiEJ8BL0rY+SsY9mxWo8Mrdy1UYXfkKFUgGEPl79trbwFO7O3xluowc
         5odxyT3BfrG5aGchD0cZLe1EqICvuPc2n7NXubF4b4rIKDdREPYphzrDIF49KqP55dCV
         R05h0ACPlKyQ5ks6W1LR29lRAfPJMN1/306PqY9lo+CzkBuiDH/4mki26wVqo7sXR/uq
         jpkg==
X-Gm-Message-State: AOAM530s1A/ifoWvpi3Ba5rJtPBrYaadmm5S97CPyPAY57oOhVtE847j
        fglxpFDYzDA5fJE3IIXrmAI=
X-Google-Smtp-Source: ABdhPJy25IFjqoc2hBCjcsJpE5a5Vob+nqtJFWAzee6+ELHsZ9upPgpAU7hoFTSHrj8AYhDTlWBOtQ==
X-Received: by 2002:a62:bd09:0:b0:44c:8a7e:77a1 with SMTP id a9-20020a62bd09000000b0044c8a7e77a1mr29145742pff.66.1634008490638;
        Mon, 11 Oct 2021 20:14:50 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-52.three.co.id. [116.206.12.52])
        by smtp.gmail.com with ESMTPSA id rm6sm818339pjb.18.2021.10.11.20.14.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 11 Oct 2021 20:14:50 -0700 (PDT)
Message-ID: <fab92b70-8004-5765-1b8a-2cf1d12abb63@gmail.com>
Date:   Tue, 12 Oct 2021 10:14:46 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Subject: Re: [PATCH] archive: add test testing MIME for created archive
 through compression filter
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        Jeff King <peff@peff.net>
References: <20211011112712.475306-1-bagasdotme@gmail.com>
 <xmqqlf2zd0d4.fsf@gitster.g>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <xmqqlf2zd0d4.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/10/21 22.53, Junio C Hamano wrote:
> I think a lot more portable and robust way to test the feature is to
> configure git config tar.tar.test.command (or come up with a name for
> a suffix to be used in the test), point it at a script created in this
> test script and run git archive with output filename that would trigger
> the command.  Then, arrange the test to notice if the "test" script was
> called with expected command line arguments and standard input.
> 
> That way, you do not need to rely on prereqs and you do not have to
> resort to un-portable use of the "file" command.  After all, you are
> *not* testing if "bzip2 -c" the user happens to have on their $PATH
> produces output their "find" recognises as bzip2 compressed.
> 

The intent of this test is to ensure `git archive -o 
something.tar.<format>` produces proper compressed tar archive that can 
be decompressed with the corresponding decompression tool (such as 
gunzip for gz files), and not just with `tar xvf`.

-- 
An old man doll... just what I always wanted! - Clara
