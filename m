Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41BB8ECAAD1
	for <git@archiver.kernel.org>; Wed, 31 Aug 2022 08:44:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiHaIoN (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 31 Aug 2022 04:44:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiHaIoI (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 31 Aug 2022 04:44:08 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F8DCC4833
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:44:07 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id w2so1923189edc.0
        for <git@vger.kernel.org>; Wed, 31 Aug 2022 01:44:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=GUN+p5OJvf5fEIc0eoTFXSACKbptocfKAj/CIpzhIao=;
        b=XY34bLnRU3Fop/zQ7FCTcyZyEJ6RCixo/VAdEuJBXuN/i6WgROOEX0nTU8lxnM0MZl
         fCnI8sfOhqQRyzxLG+R1HqHoh/FKvyiE6PMDkr24lyXSAnD17SG97RChCS5QnNSYm8Ll
         oN7Vvooqzu5jHliP2xmyostTULcNeOMCM6x8ftBybAeaHbYD9pc924GXbo5vEBT377gX
         jSG94xyVs2zYMc0q6auoFNjBltOXMT/pWe2uoC3TYlu/WQVIipn77ycdiA6eoUpvGJI9
         2Jw5hZ/+yaRcyUXbOB618e8Cdfx1FzKlCeLYXy0Y/L0XZtRQxdK7p80u2MGCyygXW6gN
         /1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=GUN+p5OJvf5fEIc0eoTFXSACKbptocfKAj/CIpzhIao=;
        b=6z3bgE03XJ5fVe/B+rGtHGlpXWdkgnrvgitKxYJmgC8A4gpysrpMDSUVcKTWtDh6B9
         B6izteZY4+RE8jrguimzuU6WA83c7n24zQ5XNp3bstFVOduetVVNZHBY3FotXBkGiMk7
         7QNj6Pnps+t7+dqLSvgIgJi/Gz/+HL+VJJnlH17UGRRIqjvgfjG8Bqv9W3VxcIn3acMx
         Nb9uOxzMkWR1WV9cuWPWAOiPjfidrSYIun8Is3buqTZlGcnJ6uDy6sETxwIzazpe4o9n
         ydkNIkFTt1+w1hTXbiTMJzTStlkrMmC3HewNmkBlTeWTq11kGJ+r6bCIsiLmKVCMaNWg
         pwfg==
X-Gm-Message-State: ACgBeo2+NArhJBCOhKU1WlWYJyO1o1hmfvkhEEaq2RZyGanAh6lViGAq
        ODE1cXscVqZpSbZ/Qf2TmBk=
X-Google-Smtp-Source: AA6agR6oEXFi617GbG0oH+WhkUmbs0ddcGdEQMEVjrkRHk01In2CPdlpPI2bNiqn6H6eubs0c05hgg==
X-Received: by 2002:a05:6402:2712:b0:448:e383:1f37 with SMTP id y18-20020a056402271200b00448e3831f37mr4233687edd.375.1661935445773;
        Wed, 31 Aug 2022 01:44:05 -0700 (PDT)
Received: from localhost (62-165-236-110.pool.digikabel.hu. [62.165.236.110])
        by smtp.gmail.com with ESMTPSA id a9-20020aa7d749000000b0043e581c30eesm8736847eds.31.2022.08.31.01.44.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Aug 2022 01:44:05 -0700 (PDT)
Date:   Wed, 31 Aug 2022 10:44:03 +0200
From:   SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>,
        =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
        Derrick Stolee <derrickstolee@github.com>,
        Derrick Stolee via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Subject: Re: [PATCH] ci: update 'static-analysis' to Ubuntu 22.04
Message-ID: <20220831084403.GA13663@szeder.dev>
References: <pull.1334.git.1661275691795.gitgitgadget@gmail.com>
 <xmqqwnax438x.fsf@gitster.g>
 <7364f631-e05b-0db8-aaa4-9f0101b6db56@github.com>
 <xmqqfshl3pbp.fsf@gitster.g>
 <220825.86ilmg4mil.gmgdl@evledraar.gmail.com>
 <Ywh6v8oo3nRl/O5h@coredump.intra.peff.net>
 <xmqqczcnymtd.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqczcnymtd.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Aug 26, 2022 at 09:46:54AM -0700, Junio C Hamano wrote:
> Jeff King <peff@peff.net> writes:
> 
> >> But the fix here isn't to delete unused.cocci, but to hold off on the
> >> UNUSEwork D() patches until we figure out how to make coccinelle jive with
> >> them.
> >
> > Yeah, my general skepticism and disappointment above notwithstanding,
> > this seems like the best path forward from here. I tried a few other
> > tricks (like --macro-file and --iso-file), but if its parser chokes, I
> > don't think there's much we can do about it. Even if we wrote a patch to
> > coccinelle itself (and I have no interest in doing that myself), it
> > would take a while to become available.
> 
> If it is just a single unused.cocci, I would actually think removing
> it would be a much better path forward.  UNUSED() that renames to
> help folks without checking compilers would help noticing bad code
> much earlier than unused.cocci many contributors are not running
> themselves anyway.

Here is another reason for the removal of 'unused.cocci': it's very
costly to apply that semantic patch to the whole code base.

  make SPATCH_BATCH_SIZE=32 contrib/coccinelle/unused.cocci.patch

takes 440s on my machine, whereas the second slowest 'object_id.cocci'
takes only 56s [1].  Applying 'unused.cocci' to some of our source files
individually takes well over a minute:

  $ time spatch --all-includes --sp-file contrib/coccinelle/unused.cocci builtin/log.c
  warning: Can't find macro file: /usr/local/bin/lib/coccinelle/standard.h
  warning: Can't find default iso file: /usr/local/bin/lib/coccinelle/standard.iso
  HANDLING: builtin/log.c
  Note: processing took    83.1s: builtin/log.c
  
  real	1m23.083s
  user	1m22.983s
  sys	0m0.033s
  $ time spatch --all-includes --sp-file contrib/coccinelle/unused.cocci builtin/rebase.c 
  warning: Can't find macro file: /usr/local/bin/lib/coccinelle/standard.h
  warning: Can't find default iso file: /usr/local/bin/lib/coccinelle/standard.iso
  HANDLING: builtin/rebase.c
  Note: processing took    83.2s: builtin/rebase.c
  
  real	1m23.223s
  user	1m23.156s
  sys	0m0.017s

In my opinion the benefits of having 'unused.cocci' clearly do not
justify the costs.

[1] https://public-inbox.org/git/20220824113901.GD1735@szeder.dev/

