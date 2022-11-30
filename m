Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89FD3C352A1
	for <git@archiver.kernel.org>; Wed, 30 Nov 2022 10:02:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235286AbiK3KCd (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 30 Nov 2022 05:02:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235263AbiK3KCa (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 30 Nov 2022 05:02:30 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C27C2FC2C
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 02:02:29 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id y16so6477109wrm.2
        for <git@vger.kernel.org>; Wed, 30 Nov 2022 02:02:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ty0uMMG43LjeWWqwLAxKbBajCw9F1TuRV5v8FDJ+oGo=;
        b=T8JzFHQNKhWcMEqmqxgo1MOxVkOyKLOKo+XSq30X7x5kuXrc1JCxYeBrQxbYPtobDw
         56p2J1Ckvt1rZW8jJqcLY0RqtMVh6Fbfol5lJwVkMDEXJz57i0eoT/csbHyvnGb4cihb
         BX0ofdZdbmXyeTU3iTMXew5vXY3HF4CR86b7SwDI6OLfxBj8ss3ud408nsYCX2v/i1o3
         A/8tInKbBjm9gWaRS/JwjlTJM8me5xJfY9TJhM1Wl5YZDJKbGS3v0xX354rYEpHd88HT
         RzxmY2IjazfmLNd2JJBN2HUiVvSZ3dvpNxeBQQEE6Wwi9PFpattboA1ZPe1k47N4W755
         mgcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ty0uMMG43LjeWWqwLAxKbBajCw9F1TuRV5v8FDJ+oGo=;
        b=kfMe1B5hEiCJuHQCXGDKvsnrGUzrH7fYOPbGnDSd8kIaTgardcsiWYXwdRlD2gUc7b
         aVMAPynUf2WztSEMVwRdQPfToE0Uxu2SNqqrM4EfT06DtAjo8+vLt0pgvhU/OGzAx2Oe
         sM2+ULJnL0AXkQBBNjgHGFT9mmEKbeQh8m8ev76p8CdCcH8nzox4ZGWxBWPyrr/xChG7
         4XpGj0vHB9jBnP1NnIg5t9WviFsUHy25XGnsV8SR+oZaR+fdu3copStnwUifiBPQKiDl
         MDp9W6dNMNgf/D+hgzD5P2EVbkp/Jtu4+gC7fZn2aQXXZ8Y+TDABmRs8HqFkWL99YGWf
         bqyA==
X-Gm-Message-State: ANoB5pkNZiGbulGHIIBq30g1uRelYg31VqBf6FcWM9cwjXCHTXFWcMbk
        +u6yQqJ3PSzfffpX51pebrIoGzEUNmQ=
X-Google-Smtp-Source: AA0mqf4NK8Kc1tt1b13dDfWPMrAnAk1d+eEf0fWo4Rmp+LXPU4iFnGj8CuIAmgK4sPgWdAWVG5QUnw==
X-Received: by 2002:adf:de88:0:b0:242:15d5:7dd1 with SMTP id w8-20020adfde88000000b0024215d57dd1mr9416761wrl.207.1669802548075;
        Wed, 30 Nov 2022 02:02:28 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id a16-20020a5d4570000000b00242109cf587sm1115603wrc.28.2022.11.30.02.02.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Nov 2022 02:02:27 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <b50066fb-e958-baa8-2cd9-6e7f964f7e30@dunelm.org.uk>
Date:   Wed, 30 Nov 2022 10:02:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: What's cooking in git.git (Nov 2022, #07; Tue, 29)
Content-Language: en-US
To:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
References: <xmqqsfi22j67.fsf@gitster.g>
In-Reply-To: <xmqqsfi22j67.fsf@gitster.g>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 29/11/2022 09:40, Junio C Hamano wrote:
> * pw/test-todo (2022-10-06) 3 commits
>   . test_todo: allow [verbose] test as the command
>   . test_todo: allow [!] grep as the command
>   . tests: add test_todo() to mark known breakages
> 
>   RFC for test framework improvement.
> 
>   Needs review.
>   source: <pull.1374.git.1665068476.gitgitgadget@gmail.com>

I'm planning to re-roll this but I probably wont have time before the 
new year. If anyone has time to take a look before that would be really 
helpful. Ævar has given some useful feedback but it would be good to 
know if others think this is useful.

Best Wishes

Phillip
