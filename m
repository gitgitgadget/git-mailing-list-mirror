Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B2AA9C54EE9
	for <git@archiver.kernel.org>; Wed,  7 Sep 2022 16:25:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbiIGQZs (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 7 Sep 2022 12:25:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229506AbiIGQZr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2022 12:25:47 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7720D59259
        for <git@vger.kernel.org>; Wed,  7 Sep 2022 09:25:45 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id t11-20020a17090a510b00b001fac77e9d1fso18830445pjh.5
        for <git@vger.kernel.org>; Wed, 07 Sep 2022 09:25:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender:from:to:cc
         :subject:date;
        bh=mxV6nBzZbVkItvponi3/2ZUKq2MnnQchYd1FtHAYSwo=;
        b=Owt5oEAccSHbrpxbxiU8lUQdtJuxvjvwn6+6A8YpmacglgHvFIHpkpvYQdtC134Vx8
         UsKKJZiJ6c6tpt+9t6HLRF6MN0R6vMXXD4640647YzvN7R/hV9HybC3CMU6r43nLnMXG
         PbKU+SXX0abRJ7gZkZUM29FMSb83ax582Hv3NsuWyECIcKV+0fUPAvqnezQ/T9J/h2xC
         uMqs65rtpvvTBpnSNa7buDC6xiIlha/l2brNeIsbGaMT/SnndrVOeqgaTh+Hluyyk7cp
         +NdkQM0R5N9AthneC5prTg2wPFvppT09cW6eMi6Q4HT0SJJw8SWb3xvkVslVIxNMWw9s
         RjkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:user-agent:message-id
         :in-reply-to:date:references:subject:cc:to:from:sender
         :x-gm-message-state:from:to:cc:subject:date;
        bh=mxV6nBzZbVkItvponi3/2ZUKq2MnnQchYd1FtHAYSwo=;
        b=zn81o+CSkrresL6v01wmdtlQefofZi2FX/oFm17+ekvnuwh84t9yHBXCvKAscsh4Zi
         yk2OIk/MFMUaqQSV/lU5SNxrkqbiKQCzyhIFm2JqxMqf6huFI9m46yx/bSQHt+DaNB0f
         hYFw69kGFkQawR/nWBtvKgKXjuCpeptTrJbqwNaySBRkUukiKXK9jFueU7CTmNycNvSh
         EzpsSIECPK1Bg2F0bsTMX21eCBmIDbT1ZbNK4+glBN1uz2EyQDfFn1EHa7dkJJOJnkhs
         JJ9ELQ2/OzPuHa8qEhcEckJ477fK1i9BIjiHbHvf5MyA2PweGYrzn30YVb7iASkb6Gi0
         boCA==
X-Gm-Message-State: ACgBeo2Sj0YGpm1k5YyGUyyAAY9RY3sh6MF7RCoJqRCvwbOyCs+4S0i2
        QsBAdq7V4llHy78naqw8JpI=
X-Google-Smtp-Source: AA6agR7k66yHB3mK50BOvzhuHdQ0tUYTVw3n/siMk4bz2wkx0V0ND4i6Ia4W9wH7G8MgSg86vqJLmw==
X-Received: by 2002:a17:90b:1b12:b0:200:5dbd:adff with SMTP id nu18-20020a17090b1b1200b002005dbdadffmr4980681pjb.43.1662567944872;
        Wed, 07 Sep 2022 09:25:44 -0700 (PDT)
Received: from localhost (33.5.83.34.bc.googleusercontent.com. [34.83.5.33])
        by smtp.gmail.com with ESMTPSA id e10-20020a17090301ca00b0016dbdf7b97bsm12610092plh.266.2022.09.07.09.25.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Sep 2022 09:25:44 -0700 (PDT)
Sender: Junio C Hamano <jch2355@gmail.com>
From:   Junio C Hamano <gitster@pobox.com>
To:     =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>
Cc:     Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] tests: replace mingw_test_cmp with a helper in C
References: <pull.1309.git.1659106382128.gitgitgadget@gmail.com>
        <xmqqwnbv7trp.fsf@gitster.g>
        <354qp59q-r4r3-1971-5o09-71q224911orp@tzk.qr>
        <b21d2b60-428f-58ec-28b6-3c617b9f2e45@web.de>
Date:   Wed, 07 Sep 2022 09:25:44 -0700
In-Reply-To: <b21d2b60-428f-58ec-28b6-3c617b9f2e45@web.de> (=?utf-8?Q?=22R?=
 =?utf-8?Q?en=C3=A9?= Scharfe"'s
        message of "Wed, 7 Sep 2022 14:09:27 +0200")
Message-ID: <xmqq7d2fywvr.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

René Scharfe <l.s.r@web.de> writes:

> "git diff --no-index - -" also doesn't complain, by the way.

True, but in this case hopefully it is worth to call it out, as both
this code that uses "diff --no-index" and "diff --no-index" itself
came from the same author ;-)

I think "git diff --no-index - -" should just exit 0 after slurping
all its input (i.e. allow it to be placed downstream of a pipe
without blocking the upstream), but it is also fine to exit with 0
without reading a single byte from the standard input.  Of course
the latter is easier to implement ;-)

>>> But otherwise the idea is sound.  We compare them line by line,
>>> using strbuf_getline() to ignore differences in CRLF and LF that
>>> originates at 4d715ac0 (Windows: a test_cmp that is agnostic to
>>> random LF <> CRLF conversions, 2013-10-26).  Only when we find the
>>> input different, we use "git diff --no-index" to make the difference
>>> (and unfortunately more, as it does not ignore CRLF <> LF
>>> differences) visible.
>
> Why not use "git diff --no-index --ignore-cr-at-eol"?  Do you even need
> to wrap it?

Hmph.  That surely sounds sensible if it works, and I offhand do not
see why it shouldn't work.
