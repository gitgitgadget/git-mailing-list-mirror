Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 54427C433FE
	for <git@archiver.kernel.org>; Tue,  8 Nov 2022 22:04:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKHWEK (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 8 Nov 2022 17:04:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiKHWEI (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 8 Nov 2022 17:04:08 -0500
Received: from mail-il1-x12a.google.com (mail-il1-x12a.google.com [IPv6:2607:f8b0:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFAC01EEF2
        for <git@vger.kernel.org>; Tue,  8 Nov 2022 14:04:07 -0800 (PST)
Received: by mail-il1-x12a.google.com with SMTP id z9so8187577ilu.10
        for <git@vger.kernel.org>; Tue, 08 Nov 2022 14:04:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=GQSJVl5I30F0Fiae1kNSJq9hpeGc0AVfu6PAUh5Io5U=;
        b=KlBEGMo4DH5nievPf6Luj1XmDUw9OCAEKW/bo6giO1eANsXilwy7V7yqa3bGj05Vv0
         sSznRUvcDtO7rD/YCYXOFmhfSSp47HyuHVX+BONKppfrgz7MKYXoMYBe3KhObLCWAiQt
         vye7s4FuB0jVTF9M6T+tvWVwgFnw3l2N0TWA60wtktVmqlZcNIi+BfExiPCiPUMPsxoS
         RJIPJI+TvNZV1J8x9MKadesJRXhSByuqTHoWwTdVOlNcIS0yZHWSq6sSojaITpKjHsuf
         A37VwEYyrTHg0G3VALIr6notDOvn/hUYLfiHfG8BWNm2dCcWsgVS510vpDirVC2ilmDx
         c2VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GQSJVl5I30F0Fiae1kNSJq9hpeGc0AVfu6PAUh5Io5U=;
        b=UUTLI1qVizYPakLAe1xZm5DJYe0aeXQZuoW8HsSfZLzwZpv5rNHFBULzWxo96tysSd
         mrqD2J3JQXEHigFtxUtmKPzEdaZ8HUmXi19ujUIhsBRHPa+URWmohleovnMAhtNgwLKw
         apO/sa9hXfQYMyFBTp0h5Mipp5ouBQk7bUmzc0VbYlSsJJ2OSX9QCznVbTTMiZbK2PqP
         60ZcQ/f8h8B8V4BMf5b5UWzDm9qRJb4Ht+HuDm+uTmH+JCZ/0nLtqBN9U1OyhR/OJsVK
         0aiVqVyr+slGH4mf/mbjcacv7PEnEXoD1s4Tf8x4z50O2tk0sjzEJaaFM/ExN7ZDQj3s
         X8bA==
X-Gm-Message-State: ACrzQf3rHJl7MsLko3Wv3e6Dxyi/puNSKLKZdCUIFFS7WzkfFR/nS9un
        0WFR8zwz5bbgG/yv9NQ1JWAFGg==
X-Google-Smtp-Source: AMsMyM6egx1xv8pLPWYbtC9k+7GPApkngp6LDG5810xneKjztA2SfZxZDokJQS3p94mr04xtCAtPKA==
X-Received: by 2002:a92:d104:0:b0:300:a7ab:81cb with SMTP id a4-20020a92d104000000b00300a7ab81cbmr28327926ilb.265.1667945047269;
        Tue, 08 Nov 2022 14:04:07 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id h10-20020a02c72a000000b0036332a07adcsm4121360jao.173.2022.11.08.14.04.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 08 Nov 2022 14:04:06 -0800 (PST)
Date:   Tue, 8 Nov 2022 17:04:05 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org,
        Glen Choo <chooglen@google.com>
Subject: Re: ab/submodule-helper-prep-only (was: What's cooking in git.git
 (Nov 2022, #01; Thu, 3))
Message-ID: <Y2rSVSXWBEKgcIlJ@nand.local>
References: <Y2RldUHTwNzmez73@nand.local>
 <221108.86h6z9sfd9.gmgdl@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <221108.86h6z9sfd9.gmgdl@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Nov 08, 2022 at 03:13:23PM +0100, Ævar Arnfjörð Bjarmason wrote:
>
> On Thu, Nov 03 2022, Taylor Blau wrote:
>
> > * ab/submodule-helper-prep-only (2022-11-02) 8 commits
> >  - submodule--helper: use OPT_SUBCOMMAND() API
> >  - submodule--helper: drop "update --prefix <pfx>" for "-C <pfx> update"
> >  - submodule--helper: remove --prefix from "absorbgitdirs"
> >  - submodule API & "absorbgitdirs": remove "----recursive" option
> >  - submodule.c: refactor recursive block out of absorb function
> >  - submodule tests: test for a "foreach" blind-spot
> >  - submodule tests: add tests for top-level flag output
> >  - submodule--helper: move "config" to a test-tool
> >
> >  Preparation to remove git-submodule.sh and replace it with a builtin.
> >
> >  Waiting for review?
> >  source: <cover-0.8-00000000000-20221102T074148Z-avarab@gmail.com>
>
> It was waiting on a small re-roll I just sent in:
> https://lore.kernel.org/git/cover-v2-0.9-00000000000-20221108T140501Z-avarab@gmail.com/

Thanks. I took the updated round and I think that this is ready to start
merging down per Glen's review.

Thanks,
Taylor
