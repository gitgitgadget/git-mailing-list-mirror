Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE1C7C43217
	for <git@archiver.kernel.org>; Thu,  1 Dec 2022 14:51:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiLAOvg (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 1 Dec 2022 09:51:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiLAOvd (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 1 Dec 2022 09:51:33 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B473AC6F5
        for <git@vger.kernel.org>; Thu,  1 Dec 2022 06:51:32 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m7-20020a05600c090700b003cf8a105d9eso1720556wmp.5
        for <git@vger.kernel.org>; Thu, 01 Dec 2022 06:51:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:from:to:cc:subject:date:message-id:reply-to;
        bh=tcHczZpzp7kGmEfUzNVeOf20SHjybuW/EDwrBJq/6io=;
        b=MUK26xTDxxhpphgWsKXgdAfuUqIqRgafc/aibTyDqzEGsB2nZwL0IaXMfoGf9ptu/t
         JhkyUf/GctkgBSjITwP+W3qOJKsmNKjazfQpmn1XUDBGM/C/46OO4qdKE8Fmbrz8+tDv
         nM8162jDHVAjUBfwto2eSn38XTa1I2a0yHqCVr8Dq0qCULolHWnLOvTTDRJh9nwi7fHF
         Of7W5Rm5ZmLqs4CXXaD23rVlQfNe8i3DeV/TA2yAUpNbjWeH2lp46q7uezKtQUjDWta2
         wTNOimWf7T2tsyCfMyKo5cC9keYvbUnXWlYlrwME6Mz3xSr593IeISvuO+u9qzvtIBDf
         0/OA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to
         :content-language:subject:reply-to:user-agent:mime-version:date
         :message-id:from:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcHczZpzp7kGmEfUzNVeOf20SHjybuW/EDwrBJq/6io=;
        b=0Miwq+oxfrCyWRDCal0VGcqTF9LV3SbC+UUXl0t9kjUhbhYWXFzgHbnIY0pLVfS3LP
         fM56yeJ5/QKuhVz0F3ipxnnUzHa3yYb5t5qQ42t0TExMk99YdSyDPR2qmXsBlktssFg1
         B9q3VzjOiBsD5DQAJZdEbcXIfEE9xTZyfsIQRTWid+TFJ9YEX2Q8hW3k0dr4ut7QUunV
         yVjyXu/pf/MOxTPTd2xce83Mo/vp3Yo1fpkaXKf3QZ3t121fYazYlbzohvj91gvu19hd
         tsxuLmARlAwn5Rb69D/6/zQYgIGQljefaP48b2ulQb/kLYQE2RhU/zEZNotZ5q5ZGNYS
         FTBA==
X-Gm-Message-State: ANoB5plMV1uAaPcFBZ4aQi6rE+EO7qRFU4N9HGnXTRQIHMOh73BvX2RU
        8TneqXpLgDdVIwnuDo3FOZ8=
X-Google-Smtp-Source: AA0mqf5R7YqMdazT4esVUM4H1qdaldPt4Zq7HwCeKkT52hZkVJjIKmjzCNrCBlHEH6fUawe08qbYhQ==
X-Received: by 2002:a05:600c:35cf:b0:3cf:aa11:93a8 with SMTP id r15-20020a05600c35cf00b003cfaa1193a8mr52795794wmq.31.1669906291109;
        Thu, 01 Dec 2022 06:51:31 -0800 (PST)
Received: from [192.168.1.74] ([31.185.185.212])
        by smtp.gmail.com with ESMTPSA id n187-20020a1ca4c4000000b003d005aab31asm5925689wme.40.2022.12.01.06.51.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 06:51:30 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <4dac768f-1104-a565-db4c-8a1b7eb2870d@dunelm.org.uk>
Date:   Thu, 1 Dec 2022 14:51:29 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [bug] git diff --word-diff gives wrong result for utf-8 chinese
Content-Language: en-US
To:     Ping Yin <pkufranky@gmail.com>, Jeff King <peff@peff.net>
Cc:     Junio C Hamano <gitster@pobox.com>,
        =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        mailinggit list <git@vger.kernel.org>
References: <CACSwcnQfTOYHxSJQqc+viiqkCqt=WZieuCw70PqOdvo88XdeOQ@mail.gmail.com>
 <221129.867czejabi.gmgdl@evledraar.gmail.com> <xmqqlenu2dxx.fsf@gitster.g>
 <Y4ZOHwwgtztwhbhr@coredump.intra.peff.net>
 <Y4ZVXWNHO25IFYQL@coredump.intra.peff.net>
 <CACSwcnRDmiiJU8hL+ON6c+b4Q8UtLVbtku_rHSD+c+BwcNEX+Q@mail.gmail.com>
In-Reply-To: <CACSwcnRDmiiJU8hL+ON6c+b4Q8UtLVbtku_rHSD+c+BwcNEX+Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ping

On 01/12/2022 07:33, Ping Yin wrote:
>>> If the rule is "break on ascii whitespace",
> 
> Is there a way to achieve this: break english by word, and break
> chinese by utf-8 character

You could extend your current regex so that it matches whole utf-8 
codepoints which is what git does for the builtin userdiff regexes. I've 
not tested it but I think

git config --global diff.wordregex "[[:alnum:]_]+|[^[:space:]]|$(printf 
'[\xc0-\xff][\x80-\xbf]+')"

should work. The downside is that you end up with a .gitconfig that is 
not valid utf-8. Perhaps someone else has a clever idea to get around that.

Best Wishes

Phillip
