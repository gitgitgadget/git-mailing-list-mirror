Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1B524C05027
	for <git@archiver.kernel.org>; Thu,  2 Feb 2023 16:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231855AbjBBQRR (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 2 Feb 2023 11:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229710AbjBBQRN (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 2 Feb 2023 11:17:13 -0500
Received: from mail-wr1-x434.google.com (mail-wr1-x434.google.com [IPv6:2a00:1450:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B98472B5
        for <git@vger.kernel.org>; Thu,  2 Feb 2023 08:17:12 -0800 (PST)
Received: by mail-wr1-x434.google.com with SMTP id a2so1910030wrd.6
        for <git@vger.kernel.org>; Thu, 02 Feb 2023 08:17:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject
         :reply-to:user-agent:mime-version:date:message-id:from:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qNT70jL516fZ5jRvHoGcKkxMxknMofCoYyzPSUVaVjk=;
        b=mIzORinyuOTEam6UwEJ9eqKy6HLdIeCVy0wTP3BOsgm7UbCWYd43tf6IOQNyQu7g6w
         Mt2Ias50zMbFqDSTImDM2VGNkJ6Zkv4zMe6Zp7Oxkoy/LaEOHjkCkAWOAo1hpk33oCVS
         3w2L7QMF9iRsfNvAqJiNsoxDs+2T2qYsh+neBgGLw2tR32Nix/SLofuxCkj5+Wrk0zfH
         +jhIavbp9MZ8XNStZI3jVEMlPI+lPxrPA7Si3E7Pffe/MEHkt1oWDzcokjJt6nTHsNTh
         Txb9/P14QrIVqNhxuBHyz8+uE28s2p7sSnfACOj8QK1fw7ux2+wsR/sYbV+zJZyfLYUj
         jNlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:subject
         :reply-to:user-agent:mime-version:date:message-id:from
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qNT70jL516fZ5jRvHoGcKkxMxknMofCoYyzPSUVaVjk=;
        b=m32YvC23W7D0ufxwDV6OxSl4UhX2nr/B6oqcUedlKFM6gL8Q4Vpf+wJ2JNSqoYRzJ4
         xuGWJNUF3674fvOBIqK8T7JZpaLnApwPqUazPJWoGmMuP/POKCjGk7l3/0lMkWZJvGO6
         qiPOagfPVW7l4n2/pYb8ZSEGgF1nPFwKXuVtryd70Q7wQwwdwbUfV0FzIDmBNF5BA8vI
         ShpV5DVOni5xDC5rXxj4/ZgtB/60fGJRdqe1cAUHrwtZ/09Hibtz1XjQr3A34/v+ikk9
         MaGuUatI2xc/rue2KeqPKrdL028Qs22ujXN6c/3pJbjzGSRtLlPh9/tWogCblcJ9Qu5J
         BgHQ==
X-Gm-Message-State: AO0yUKW6hXSRfl2OJZGo0bz0fwLwSEsdc7ULL6zlxKMPaX5RgKN/ycau
        kTKdV7tue83HwmH2s1PFBcc=
X-Google-Smtp-Source: AK7set9q6YpgGFTTQ0BvcJTE+rGjrxbJiJbECHjuj4cWfDcZ+DOKIdpO/wSmTkTgfXUzGJbeNiL1mQ==
X-Received: by 2002:a5d:4c48:0:b0:2be:184a:5d5c with SMTP id n8-20020a5d4c48000000b002be184a5d5cmr5287914wrt.59.1675354631019;
        Thu, 02 Feb 2023 08:17:11 -0800 (PST)
Received: from [192.168.1.212] ([90.248.183.175])
        by smtp.gmail.com with ESMTPSA id r6-20020adff106000000b002bfe05bf6dcsm15284026wro.88.2023.02.02.08.17.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 08:17:10 -0800 (PST)
From:   Phillip Wood <phillip.wood123@gmail.com>
X-Google-Original-From: Phillip Wood <phillip.wood@dunelm.org.uk>
Message-ID: <771a98ca-9540-ad4e-dfba-9d304e1dff09@dunelm.org.uk>
Date:   Thu, 2 Feb 2023 16:17:09 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Reply-To: phillip.wood@dunelm.org.uk
Subject: Re: [PATCH 0/9] git archive: use gzip again by default, document
 output stabilty
To:     =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Eli Schwartz <eschwartz93@gmail.com>,
        =?UTF-8?Q?Ren=c3=a9_Scharfe?= <l.s.r@web.de>,
        "brian m . carlson" <sandals@crustytoothpaste.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        =?UTF-8?Q?Michal_Such=c3=a1nek?= <msuchanek@suse.de>,
        "Raymond E . Pasco" <ray@ameretat.dev>,
        demerphq <demerphq@gmail.com>, Theodore Ts'o <tytso@mit.edu>
References: <230131.86357rrtsg.gmgdl@evledraar.gmail.com>
 <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
In-Reply-To: <cover-0.9-00000000000-20230202T093212Z-avarab@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi Ævar

On 02/02/2023 09:32, Ævar Arnfjörð Bjarmason wrote:
> As reported in
> https://lore.kernel.org/git/a812a664-67ea-c0ba-599f-cb79e2d96694@gmail.com/
> changing the default "tgz" output method of from "gzip(1)" to our
> internal "git archive gzip" (using zlib ) broke things for users in
> the wild that assume that the "git archive" output is stable, most
> notably GitHub: https://github.com/orgs/community/discussions/45830
 >
> Leaving aside the larger question of whether we're going to promise
> output stability for "git archive" in general, the motivation for that
> change was to have a working compression method on systems that lacked
> a gzip(1).

As I recall the reduction in cpu time used to create a compressed 
archive was a factor in making it the default.

> As the disruption of changing the default isn't worth it, let's use
> gzip(1) again by default, and only fall back on the new "git archive
> gzip" if it isn't available.

Playing devil's advocate for a moment as we're not going to promise that 
the compressed output of "git archive" will be stable in the future 
perhaps we should use this breakage as an opportunity to highlight that 
to users and to advertize the config setting that allows them to use 
gzip for compressing archives. Reverting the change gives the misleading 
impression that we're making a commitment to keeping the output stable. 
The focus of this thread seems to be the problems relating to github 
which they have already addressed.

I think there is general agreement that it is not practical to promise 
that the compressed output of "git archive" is stable so maybe it is 
better to make that clear now while users can work around it in the 
short term with a config setting rather than waiting until we're faced 
with some security or other issue that forces a change to the output 
which users cannot work around so easily.

Best Wishes

Phillip


> The later parts of this series then document and test for the output
> stability of the command.
> 
> We're not promising anything new there, except that we now promise
> that we're going to use "gzip" as the default compressor, but that
> it's up to that command to be stable, should the user desire output
> stability.
> 
> The documentation discusses the various caveats involved, suggests
> alternatives to checksumming compressed archives, but in the end notes
> what's been the policy so far: We're not promising that the "tar"
> output is going to be stable.
> 
> The early parts of this series (1-2/9) are clean-up for existing
> config drift, as later in the series we'll otherwise need to change
> the divergent config documentation in two places.
> 
> CI & branch for this at:
> https://github.com/avar/git/tree/avar/archive-internal-gzip-not-the-default
> 
> Ævar Arnfjörð Bjarmason (9):
>    archive & tar config docs: de-duplicate configuration section
>    git config docs: document "tar.<format>.{command,remote}"
>    archiver API: make the "flags" in "struct archiver" an enum
>    archive: omit the shell for built-in "command" filters
>    archive-tar.c: move internal gzip implementation to a function
>    archive: use "gzip -cn" for stability, not "git archive gzip"
>    test-lib.sh: add a lazy GZIP prerequisite
>    archive tests: test for "gzip -cn" and "git archive gzip" stability
>    git archive docs: document output non-stability
> 
>   Documentation/config/tar.txt           | 29 +++++++-
>   Documentation/git-archive.txt          | 96 +++++++++++++++++++-------
>   archive-tar.c                          | 78 ++++++++++++++-------
>   archive.h                              | 11 +--
>   t/t5000-tar-tree.sh                    |  2 -
>   t/t5005-archive-stability.sh           | 70 +++++++++++++++++++
>   t/t5562-http-backend-content-length.sh |  2 -
>   t/test-lib.sh                          |  4 ++
>   8 files changed, 231 insertions(+), 61 deletions(-)
>   create mode 100755 t/t5005-archive-stability.sh
> 
