Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A76E8C7619A
	for <git@archiver.kernel.org>; Tue, 11 Apr 2023 09:58:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229501AbjDKJ6O (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 11 Apr 2023 05:58:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDKJ6N (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 11 Apr 2023 05:58:13 -0400
Received: from mail-wr1-x436.google.com (mail-wr1-x436.google.com [IPv6:2a00:1450:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587181989
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 02:58:08 -0700 (PDT)
Received: by mail-wr1-x436.google.com with SMTP id w21so6823965wra.4
        for <git@vger.kernel.org>; Tue, 11 Apr 2023 02:58:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681207087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=uBlW4bUp73VyS7LQLJ1qxXxNpgyCXYZyYnIMtrBW9DI=;
        b=SVcgYKRMCEATUFKK13nmQk33TwYAIklmgHKae9bR5nWu+c/lBkwwtiC1OZvU8QZCvK
         3i93ZQFwBbt0RaMaMsngXLjz76+E+pN+zhLTbblp0570ylw3bGNiU/iJ5/9rWSTfXxw5
         RbWNKZj+QOnZ5toaw3vPrxC7ZTDaKIvRaqW5Nqc/2DtMjLLM4P/2cEXmsBNkE3i2lU5Z
         RPIYEJ8/bjjSVXvXOYopf1Jb086anNtN4dQ9tpT8t6W2zvdp1lEnPPT5BgZkTL0r9CrJ
         uUcQhvXfqxNldjFLd+wH5VQHpDM9zHbBk+2bfloapzkhHOLktovLcueA874FM545QHFr
         Is+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681207087;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uBlW4bUp73VyS7LQLJ1qxXxNpgyCXYZyYnIMtrBW9DI=;
        b=qNEg5wy0N1iiBQaaxjrsBq3RfipUyfGaTp9yuUt9cZukB7QS7Z8AaAVx6dKCKBVQ8A
         jUKV7dsX2Vh0Tk2pMU0kRCOIMSEXYkyuU+LkiwLJBhCGwCHNie4iIPmpgAwaoFHcBthK
         c76PXsDTDxhsuuICqnTlRc044snUXV8UiJqZo7hPkfhOivGbzbB+oxeSTWgUrzNE9wjW
         kRw4mO06ijSUyX355+Sfh2FtcPkgjab5YbeP8lZsohM1jnMjTV6U2pjHfo1/2Te3jrud
         HHTc+7VrOavoXgRXeJCmnUDkloQN+8Qe9P7SpxNN+4xpkHDm0Vnu/672UknahFACLIGl
         dGRQ==
X-Gm-Message-State: AAQBX9fHamUBd+j42NtOJtQAsbPPzbcVtIGQcHPRdo0yDROFyHIaHSBS
        Pz4I/TeuG3OrFKSWz0JRU3E=
X-Google-Smtp-Source: AKy350a1RaK1EtQyfsY6jnRqcDtY4x2a5vJIa+Ara3h/YaDNaycR54a6j3SCjo3Ts38bW3+IgfIFMg==
X-Received: by 2002:adf:ee85:0:b0:2ef:b123:46d9 with SMTP id b5-20020adfee85000000b002efb12346d9mr1684239wro.3.1681207086471;
        Tue, 11 Apr 2023 02:58:06 -0700 (PDT)
Received: from [192.168.1.195] ([90.253.53.152])
        by smtp.googlemail.com with ESMTPSA id i5-20020adfefc5000000b002e5e7ee11besm14188375wrp.94.2023.04.11.02.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Apr 2023 02:58:06 -0700 (PDT)
Message-ID: <9b8d6cc4-741a-5081-d5de-df0972efec37@gmail.com>
Date:   Tue, 11 Apr 2023 10:58:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH v2] hooks: add sendemail-validate-series
Content-Language: en-US
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        Robin Jarry <robin@jarry.cc>
Cc:     git@vger.kernel.org, Tim Culverhouse <tim@timculverhouse.com>,
        Nicolas Dichtel <nicolas.dichtel@6wind.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Junio C Hamano <gitster@pobox.com>,
        Eric Sunshine <sunshine@sunshineco.com>,
        Michael Strawbridge <michael.strawbridge@amd.com>
References: <20230402185635.302653-1-robin@jarry.cc>
 <20230405231305.96996-1-robin@jarry.cc>
 <230406.868rf5tkzs.gmgdl@evledraar.gmail.com>
From:   Phillip Wood <phillip.wood123@gmail.com>
In-Reply-To: <230406.868rf5tkzs.gmgdl@evledraar.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 06/04/2023 09:56, Ævar Arnfjörð Bjarmason wrote:
> 
> On Thu, Apr 06 2023, Robin Jarry wrote:
> 
> Honestly, I don't really get the use-case. If your 02/N depends on 01/N
> couldn't your hook just maintain its own state, e.g. in some file
> created in the passed $GIT_DIR?

A hook that wants to check some property of the whole series needs to 
know which patch is the final one. We could pass that via the 
environment as we do for external diff commands with 
GIT_DIFF_PATH_COUNTER and GIT_DIFF_PATH_TOTAL.

> With the upcoming parallel hooks, I'm also skeptical of a an interface
> that would preclude validating these in parallel.

I'd not thought of that, I thought the idea of parallel hooks was to run 
different scripts for the same hook in parallel, not have multiple 
instances of the same script running simultaneously.

> I also don't understand the reason for the stdin interface. The
> "git-send-email" program itself takes a <file|directory>, so concerns
> about the files exceeding argument list seem out the window, i.e. we
> could just pass the dir/files, and as we'd have the same limitations
> here we should be able to pass the full set of files, no?

No, not if the user passes something like "HEAD~1000.." instead of a 
list of paths.

Best Wishes

Phillip

> I.e. why not a sendemail-validate-all that just takes a dir or file(s)?

