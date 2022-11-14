Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3E17EC433FE
	for <git@archiver.kernel.org>; Mon, 14 Nov 2022 22:40:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237351AbiKNWka (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 14 Nov 2022 17:40:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237302AbiKNWk0 (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 14 Nov 2022 17:40:26 -0500
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E00167F1
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:40:23 -0800 (PST)
Received: by mail-il1-x133.google.com with SMTP id q5so6506630ilt.13
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 14:40:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=N4KuzpCZVtsywhq/AmVAajoE74w+oVEA+oEhHO0WiHM=;
        b=07FV9qcD2LMqf8fdE4mn8niGGcOBmTyYIANBmB17I75kv7OTUn+SmcX9uwfPG8xpwQ
         XIKZjDBIO/9IFyyGzWNSlsoOwlM3ATMLFFcngfXF8mUVqD9WJk25WUe9kwwNrnoa6nYV
         1MKgD3/e2OAPIWr+k7Qnm4tbcSFqVIPA0StWVRkamIA1rM1LSkYYDWyp/m3KSJMU/y7e
         JsLCfXUUgYV0zVqkFULFTCBUYHG3rqojPN5mJIVM7MP/jBKaopyXhxBRzAE85bTq5CwG
         4h9q0e95d6Xd4/WqJq7rG9zblTd6VfEL1gXLFn0VKgZioHUrHZ7hTYgRSmwJshIBNT/z
         Gt+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N4KuzpCZVtsywhq/AmVAajoE74w+oVEA+oEhHO0WiHM=;
        b=F/9yxFwowm7i4pKWx+M7XQuCSPxyPgo2OSzkgP5X+POwGqEdTd6EVtY16ZB40SEj8y
         8UZZGTL1VBdmEDml6F626Rwy51H8BNRbTnapN91d5OEq/eemZX465bE10YAGmHB+6C3q
         /FN+/GGQexZJveDB2RZ20z9Xp36kIefSKDu3bRloI3kjNpnkPOzY3B0XiNjDdXg1DAL9
         aY7tNcUOcuFDUsqKc7ZjAxi2BbFA9nXEtqfYvfFcTp6z4ANwKeWhXzxaV48+/1sGwUeZ
         MjrYT7bAPlHpykkT8Jw36Zt1Zhdpyq5oy2zFBhMObX0m1JcrQ8P50ctF/YwEze45x3ti
         KcwA==
X-Gm-Message-State: ANoB5pl8/R7p0gPri/dU1UkGnOi7N7ToecdTT53bqQl6ke5DFg9a+8u7
        qMaJoaVKxnexOndi35IzsOTYhg==
X-Google-Smtp-Source: AA0mqf4DP/BAzEHaKWm+CP++7njL2v+oPH2rTz52QYJBqz4syj9l6zvKp2HweXuRyWuk8/P4vxG88g==
X-Received: by 2002:a92:d812:0:b0:300:9aba:294c with SMTP id y18-20020a92d812000000b003009aba294cmr6722954ilm.25.1668465622585;
        Mon, 14 Nov 2022 14:40:22 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id cx19-20020a056638491300b003753b6452f9sm3836978jab.35.2022.11.14.14.40.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 14:40:21 -0800 (PST)
Date:   Mon, 14 Nov 2022 17:40:20 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>
Cc:     git@vger.kernel.org, =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: Re: [PATCH v4 2/2] tests(mingw): avoid very slow `mingw_test_cmp`
Message-ID: <Y3LD1CtKBoDhPdSZ@nand.local>
References: <pull.1309.v3.git.1668290855.gitgitgadget@gmail.com>
 <pull.1309.v4.git.1668434812.gitgitgadget@gmail.com>
 <128b1f348d8fad730cac1c36d3082fab49904b2c.1668434812.git.gitgitgadget@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <128b1f348d8fad730cac1c36d3082fab49904b2c.1668434812.git.gitgitgadget@gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2022 at 02:06:52PM +0000, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
>
> It is more performant to run `git diff --no-index` than running the
> `mingw_test_cmp` code with MSYS2's Bash, i.e. the Bash that Git for
> Windows uses. And a lot more readable.
>
> The original reason why Git's test suite needs the `mingw_test_cmp`
> function at all (and why `cmp` is not good enough) is that Git's test
> suite is not actually trying to compare binary files when it calls
> `test_cmp`, but it compares text files. And those text files can contain
> CR/LF line endings depending on the circumstances.
>
> Note: The original fix in the Git for Windows project implemented a test
> helper that avoids the overhead of the diff machinery, in favor of
> implementing a behavior that is more in line with what `mingw_test_cmp`
> does now. This was done to minimize the risk in using something as
> complex as the diff machinery to perform something as simple as
> determining whether text output is identical to the expected output or
> not. This approach has served Git for Windows well for years, but the
> attempt to upstream this saw a lot of backlash and distractions during
> the review, was disliked by the Git maintainer and was therefore
> abandoned. For full details, see the thread at
> https://lore.kernel.org/git/pull.1309.git.1659106382128.gitgitgadget@gmail.com/t

In the previous round, you wrote that this paragraph:

    It explains why we replace a relatively simple logic with a relatively
    complex one.

But I'm not sure the rewritten version does what you claim, at least in
my own personal opinion.

It is not helpful to say the original approach "saw a lot of backlash".
It is helpful, on the other hand, to say what about the original
approach gave reviewers pause, and why that alternative approach isn't
pursued here.

Maybe I'm splitting hairs here, but I really do stand by my original
suggestion from back in [1].

Thanks,
Taylor

[1]: https://lore.kernel.org/git/Y3B36HjDJhIY5jNz@nand.local/
