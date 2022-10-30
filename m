Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9B58C38A02
	for <git@archiver.kernel.org>; Sun, 30 Oct 2022 19:46:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229743AbiJ3TqY (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 30 Oct 2022 15:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbiJ3TqX (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 30 Oct 2022 15:46:23 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CE9E7677
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 12:46:22 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id d26-20020a05683018fa00b0066ab705617aso5773198otf.13
        for <git@vger.kernel.org>; Sun, 30 Oct 2022 12:46:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=github.com; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=C4mSHX17bSsyrxm8+Wi7jFrWRztGpri2C8VwnKS/kTE=;
        b=B3I23rhCxy8NKYFbhw/lzaG9ZorNauEZy9JQo4Gf+C8k1W7JwD3iHJ2xNCsnqFsm9g
         viu7gRqndbRWcWB8qX068rClMzN3pwf34bHtdHlISPf/Pk9iGT2AGP4GkeygVwpOMiWg
         /Jkqp0azvtt867QKS9I2+52uPLO2Iltvc8in3ztB3aoQBavJuyGiDnnsPAjYgi7z8E1E
         Ic36LQs7TRVgA2LBTxU1klJ4lvZitTX7X9idNl4n+CLMdmNIcRe12P1IXDStWMBTlqt2
         wU7rAQkdu2FEZNj88XSWpd68I3GUJ0XKfEASo94Fg7zgIeQ60L667qk6Zzi/+elbz2+m
         F39g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=C4mSHX17bSsyrxm8+Wi7jFrWRztGpri2C8VwnKS/kTE=;
        b=DXUhdv3wAnY77nIKptmAFTHpbOU9a8hRjTWyxdGAHpYnUVE5881+Nx3V52f54IzhKt
         zKngvJzeafap5wnJhoXgjWMcPlYGlX3CmuXh0i2WLpl/Zn9aytKSoUWeftttai/FetxN
         KpSEfn9/YRJQw/0ULYC/0pj0bMKMJ51STX7Xel6KEjemgdp6cikIkYjqreyd66///81L
         JjKWKQmttJ5R+hRREWguSLX9jnLX3uVEPba9J55Ghw7wfoHlZ38h2Jo83KajmiH7kRCB
         jJfpfMYUkUVKF/pbw2YTyYHwUidJ7JSIx7lkcjzdjaoYIVInflU7fZdqwYurY8/5udiD
         c+9Q==
X-Gm-Message-State: ACrzQf3BNy+SGqB+um+Mv/rHRK4c7tv45/0dQUYmk7lYjYFgahKm8OlW
        a9j4U4bkiYzb8W1YqGQIBbYN
X-Google-Smtp-Source: AMsMyM7JLMhXZbZ3PfCS0d+iuKbvtsM9+QYhQ6KCUq6GWO0Tocw1YzzKNK+YKNkx1uvaeruVTDj+nw==
X-Received: by 2002:a9d:64c3:0:b0:656:d706:1df with SMTP id n3-20020a9d64c3000000b00656d70601dfmr4680489otl.212.1667159181877;
        Sun, 30 Oct 2022 12:46:21 -0700 (PDT)
Received: from ?IPV6:2600:1700:e72:80a0:a899:7648:578c:78af? ([2600:1700:e72:80a0:a899:7648:578c:78af])
        by smtp.gmail.com with ESMTPSA id k6-20020a056870148600b0011f00b027bdsm2106576oab.45.2022.10.30.12.46.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 30 Oct 2022 12:46:21 -0700 (PDT)
Message-ID: <58841dcd-e732-416f-5ab0-fd5a5d8de4c7@github.com>
Date:   Sun, 30 Oct 2022 15:46:20 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH 3/5] roaring: teach Git to write roaring bitmaps
To:     Abhradeep Chakraborty <chakrabortyabhradeep79@gmail.com>,
        Junio C Hamano <gitster@pobox.com>
Cc:     Abhradeep Chakraborty via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org, Taylor Blau <me@ttaylorr.com>,
        Kaartic Sivaram <kaartic.sivaraam@gmail.com>
References: <pull.1357.git.1663609659.gitgitgadget@gmail.com>
 <4364224f9bddc8f1e40875ebc540b28225317176.1663609659.git.gitgitgadget@gmail.com>
 <xmqqczbdl6wl.fsf@gitster.g>
 <CAPOJW5yxRETdVk014gQYFud9_Nrt+OQGSVNQ8Pw2wDEMMFMm1Q@mail.gmail.com>
 <CAPOJW5z_ZRChNo8PGBmJu=vvjTL2cYL8oTdVwoDRh-UHt2Dy4w@mail.gmail.com>
Content-Language: en-US
From:   Derrick Stolee <derrickstolee@github.com>
In-Reply-To: <CAPOJW5z_ZRChNo8PGBmJu=vvjTL2cYL8oTdVwoDRh-UHt2Dy4w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 10/30/2022 2:35 AM, Abhradeep Chakraborty wrote:
> Hello all,
> 
> It has been a month since I didn't get involved in any open source
> contributions (including Git). This is due to the fact that I was
> focusing more on mastering theories and also that it was a festive
> month. So, I am now resuming my work. There are many things I have to
> cover (including this patch series).
> But before that I want to ask you a question - As you have noticed
> already, the Roaring library has a lot of styling issues (Moreover it
> is using C11). So Should I fix all these issues? or Should I make a
> new library (using Git's compatibility library "git-compat-util.h") by
> taking CRoaring as a reference? The pros are that it would be easier
> to format the bitmap library specific files and it can use Git
> compatible functions.
> 
> I would love to hear your opinions. Thanks :)

I HAVE OPINIONS! :D

Mostly, there are two things I'd like for you to keep in mind:

1. Using the library as-is is a great way to prototype and dig in on
   the performance measurement side. Can you construct or clone enough
   interesting repositories to get a feeling of the effect of the
   roaring format compared to the EWAH format? If there is no benefit
   to switching, then we can save everyone a lot of work by marking
   that as an incorrect road. However, if there is sufficient evidence
   that it's working well, then we have established a baseline that
   the full implementation should match (at least, if not do better).

2. Once deciding to do the work, we can think about the reasons to use
   the existing library over writing our own. The most basic reason is
   that the library is extensively tested, so we gain all of those
   benefits. Can we incorporate their test suite into our own? The
   next main benefit is that we can take any changes from their version
   into our code with minimal fuss. How often do you think that they
   have bug fixes or enhancements in the repo? How would those changes
   translate into our mailing list workflow? If we restyled the library,
   then we are unlikely to get easy benefits from taking upstream
   changes, but we could recreate them with manual effort.

3. After carefully considering the benefits/drawbacks of using the
   existing library, consider the same for writing one from scratch.
   The most important thing I will say here is that the core idea is
   rather simple. There may even be ways that we can take advantage
   of the format and its data structures with the expectations we have
   in Git repositories that are not always possible for generic
   databases. We should be able to build a much smaller library that's
   limited to our needs and customized to our use case. However, we
   would need to test it carefully, both for correctness and for
   performance, and that is not a small undertaking.

Hopefully this gives you something to chew on. Investigating each of
these directions should help you come to a conclusion that you can
bring to the community as the expert, then we can examine your
findings to see if we agree.

Remember that code speaks. If you're willing to build it one way,
then that concrete implementation is already worth more than a
hypothetical alternative in many regards. That can be a starting
point to move forward.

Thanks,
-Stolee
