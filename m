Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 04F2FC07E95
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 20:00:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CEFAC61353
	for <git@archiver.kernel.org>; Sat, 10 Jul 2021 20:00:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230057AbhGJUDS (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 10 Jul 2021 16:03:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbhGJUDQ (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 10 Jul 2021 16:03:16 -0400
Received: from mail-oi1-x231.google.com (mail-oi1-x231.google.com [IPv6:2607:f8b0:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF7CDC0613DD
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 13:00:29 -0700 (PDT)
Received: by mail-oi1-x231.google.com with SMTP id s23so2684621oij.0
        for <git@vger.kernel.org>; Sat, 10 Jul 2021 13:00:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-transfer-encoding;
        bh=uLH7BwAZb5XaRK0UPliJ5jwdFR55nRzw95XDN25efV8=;
        b=SI58J2w7eS+7WwfAggwNjYw3t04H5NoPHacaTjUIuh7cYSxLAUVB7Rwk0AYxi3TJt7
         2f0CUj7LoigPVBV8ZnTmbj35kAOK5syFde5zwH8fVyX2wt2jn3BB0MXTcnSFo8E0sv4F
         XxmiG/SPLKamj/CAmYmuJsbcSmcu6MtoWejP+EqjeJ8uz3RkWkcE0rRJEkmo3aO24NtJ
         9/WD9uUs1xeTJ6ZUQcVNvsaWLtQOEvFTXgTLu3jWfYWgtsUZh6MwpdvP9Aeooj+XicjR
         FtaxvWEaqkeJNNAbCkOE+3SnxvDfROhuCGTl+ATsNMk0xTi8/4wMnJuw13HUtluCUWiG
         kd1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:message-id:in-reply-to
         :references:subject:mime-version:content-transfer-encoding;
        bh=uLH7BwAZb5XaRK0UPliJ5jwdFR55nRzw95XDN25efV8=;
        b=Q5XnSVP044rGXl/u+1e/bqxlv3Ki5jSRZArrr8sfI0hQsLyCoV7yB/2sy8wRlPq0IW
         Tin4hY5T9aiX4rhd53djLTupkDKgR4FAW0kDd8cbX9lnv1+6Au5TT3yR7NZHto4k7N/E
         QhhSUZ2QQ5g1GzfQEzYxGwMUgF89UnjzEEyaUo/w9fvqFB+2OgGMcpBmbvPhIVals/sw
         /UgGcv8xBzULMpPTj5qGzyEkMBRz0J712jDFmMn28ydm8a3GrzB/xZ9XPULGlKAqdOom
         DLjnSH0IGr0mbA+2zD1vZJ3lNudf6VsjMxfR0wagQMH20NAkfaHU5eCfI+Jbvbh5cP1I
         YICg==
X-Gm-Message-State: AOAM532KBU+RyBvG+lIxYdjUCvLFZY8iWWpfTAVcm3v95kOMy4VLNNKW
        DehgCza28ukgDskXyQu8QDI=
X-Google-Smtp-Source: ABdhPJyiSysLa838FqXGloDbhovV1ijcCH8bsr4i8ekP6SRC8K2vYDOCJz/bVRrue/j+m9n8fTd0Nw==
X-Received: by 2002:a05:6808:2081:: with SMTP id s1mr2183105oiw.161.1625947229419;
        Sat, 10 Jul 2021 13:00:29 -0700 (PDT)
Received: from localhost (fixed-187-189-167-231.totalplay.net. [187.189.167.231])
        by smtp.gmail.com with ESMTPSA id o1sm2065817oik.19.2021.07.10.13.00.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 10 Jul 2021 13:00:28 -0700 (PDT)
Date:   Sat, 10 Jul 2021 15:00:27 -0500
From:   Felipe Contreras <felipe.contreras@gmail.com>
To:     Martin <git@mfriebe.de>, Sergey Organov <sorganov@gmail.com>
Cc:     Felipe Contreras <felipe.contreras@gmail.com>,
        Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
Message-ID: <60e9fc5b83c2a_7ef20880@natae.notmuch>
In-Reply-To: <1bd36aa2-ac90-f7d4-9d48-1aa39159b263@mfriebe.de>
References: <c593a699-eaf2-c7ab-b522-bfd224fce829@mfriebe.de>
 <xmqqpmw4uwh2.fsf@gitster.g>
 <7870a0ad-8fa1-9dbd-1978-1f44ec6970c5@mfriebe.de>
 <xmqqy2arrmba.fsf@gitster.g>
 <b80bf908-0c31-2b3a-6d6c-1a3fba5b2334@mfriebe.de>
 <87wnqaclz8.fsf@osv.gnss.ru>
 <60e5f3981de5f_301437208bc@natae.notmuch>
 <87bl7d3l8r.fsf@osv.gnss.ru>
 <60e61bbd7a37d_3030aa2081a@natae.notmuch>
 <877di13hhe.fsf@osv.gnss.ru>
 <c740a4f0-011f-762e-4f49-f85d1b3abc99@mfriebe.de>
 <60e67389a4adc_306ac1208fd@natae.notmuch>
 <4057b3ac-a77c-0d5f-d3f4-ad781754aae4@mfriebe.de>
 <60e736e72da68_30939020850@natae.notmuch>
 <155308af-42ad-b044-fb37-676251a9b7e1@mfriebe.de>
 <60e762243aab1_30a7b02089@natae.notmuch>
 <2b85a7eb-d0be-65e7-ecbb-1750abf53e53@mfriebe.de>
 <60e79c31aaa72_30b8a4208c1@natae.notmuch>
 <65362688-b65b-661c-20c1-94d7dc2118c7@mfriebe.de>
 <60e874e1c6845_215320861@natae.notmuch>
 <dbfa96f0-558e-ccaf-6e34-6d95c43848b5@mfriebe.de>
 <87im1ieaba.fsf@osv.gnss.ru>
 <1bd36aa2-ac90-f7d4-9d48-1aa39159b263@mfriebe.de>
Subject: Re: PATCH: improve git switch documentation
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Martin wrote:
> There is even discussion to add "-c" for  "copy branch + switch" to git 
> switch.
> Which I have no personal objection. Only find it regrettable that it 
> means an incompatible change to -c. (Never mind that git switch is still 
> "experimental". It has been so for a long time, for many people out 
> there long enough to forget the "experimental")

This is relative.

`git switch` has existed for 1.9 years. I've been using git for about 15
years, so that's 13% of the time (although I've been using it even less
time than that). I understand that for more recent users this might seem
like a long time, but it isn't.

Git UI development is dead slow.

-- 
Felipe Contreras
