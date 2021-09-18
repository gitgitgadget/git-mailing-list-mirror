Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50DCDC433F5
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 15:56:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 327E661268
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 15:56:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240009AbhIRP5n (ORCPT <rfc822;git@archiver.kernel.org>);
        Sat, 18 Sep 2021 11:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237245AbhIRP5m (ORCPT <rfc822;git@vger.kernel.org>);
        Sat, 18 Sep 2021 11:57:42 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63872C061574
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 08:56:18 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id h20so13594901ilj.13
        for <git@vger.kernel.org>; Sat, 18 Sep 2021 08:56:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=K4q8jQQ9Ox1TP6FSpuLaK1ZK2LNd6blJdzIFUORKR9c=;
        b=xBdzN7mY+E06StbSfq+x8uRHJgDROVcEr535WkfQS5Ct9r16JBRAhWj6UZkOEbelQv
         JMM6+bwTQEzF61NUptQf1FyhXPkA9y5uBkKyOhtJFZGD1v6eYorkvJMRCt4x65lZPvkV
         f/mMH5xZrm2UCng+pQpm8nyGrkynG00jFEVyFrNmZ74dR91KQFm6vhpT7P2QQ2smDXKv
         6F/mxQ2Bo5eWcEneMlAyqwemJxs05+PC/d2gNgQwrsLV7JonTrep0NymmVbi6vxQN0PF
         OuZtCjAek7ywzlW7+ylZseKBC82ZN3rRAU87rdNlGkjeGxsCQ9xiydUToy4SWuPWRvo4
         o14Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=K4q8jQQ9Ox1TP6FSpuLaK1ZK2LNd6blJdzIFUORKR9c=;
        b=PhAwbgOgGUDVFAhzlBTNNUkK4RZRpd3ZfUgBOdufgpYZptROTP2KDdW/QqT+2Ydpt7
         vYMSVgSq5ymvmJbISy/phLO2vAjzRP2/8/FHkS+Hetl3rJzKCwTnj/ZyHpDmY1SWeLJQ
         0ax1XDuqkDXE3HnLnWIakih4KPLsXlfzKAWxVpGHSXksD6SpLcb/DBhdAOssl7PbEr3H
         rFj1VJdFqkhsfUdpRQb7e3n4NtVzmKZyGQagdj3INblojSZ5GsN6HVVZ1Rdn9zMZ13o3
         6sHEdQA4bfcWUJkvStKEA2Hq39Vhh87E7optp06PusWVytGjazoBboGiOwbJijO+F23Q
         UBzg==
X-Gm-Message-State: AOAM530saLytYOjL4payclGLJeQM9v8vZNmAriw+XyokOoHSxweprAsb
        uKCJlmXZhS8RCUGnSEgPFMTAfg==
X-Google-Smtp-Source: ABdhPJyqSq6H8sYxSfnv7Fb61leK/+Ski5/wKepaZwJIo24XDFODBgd2aBnTu1yqKfAyNY+ScNKYdA==
X-Received: by 2002:a92:b301:: with SMTP id p1mr11465788ilh.10.1631980577852;
        Sat, 18 Sep 2021 08:56:17 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id q11sm5671745ilg.85.2021.09.18.08.56.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 18 Sep 2021 08:56:17 -0700 (PDT)
Date:   Sat, 18 Sep 2021 11:56:16 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
Cc:     Taylor Blau <me@ttaylorr.com>, Jeff King <peff@peff.net>,
        SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>,
        git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
        dstolee@microsoft.com
Subject: Re: [PATCH 3/5] commit-graph: use parse_options_concat()
Message-ID: <YUYMINltnUlM8Ziv@nand.local>
References: <87r1lhb6z7.fsf@evledraar.gmail.com>
 <20210215184118.11306-4-avarab@gmail.com>
 <YCrCt8sEFJSPE+28@nand.local>
 <87czx1awwg.fsf@evledraar.gmail.com>
 <20210917211337.GC2118053@szeder.dev>
 <YUUQzswYL5x74Tps@coredump.intra.peff.net>
 <YUVreesWdRmBYl1C@nand.local>
 <87v92ycpil.fsf@evledraar.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87v92ycpil.fsf@evledraar.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Sat, Sep 18, 2021 at 09:20:38AM +0200, Ævar Arnfjörð Bjarmason wrote:
> If we came up with some call about what we want subcommands in general
> to look like I'd think it would be fine to convert multi-pack-index to
> it, perhaps with some deprecation period where it would issue a
> warning() while it understood both forms.

I'm not sure about what to do with the multi-pack-index command.
Probably going through a deprecation process makes the most sense if we
do want to get rid of the top-level `--[no-]progress` there, too. But
let's have the discussion elsewhere and not buried in the MIDX
bitmaps thread ;).

> This is a good change, but if you're up for bonus points leaves the docs
> in an odd where we (as noted in [1]) document the --object-dir and
> --progress options under OPTIONS, but now only take the former before
> the sub-command.

Thanks for noticing. I got up and did something in between writing and
sending this patch, and had a nagging feeling of forgetting something
before I sent. But I couldn't figure out what ;).

I'll resubmit this patch (with the doc changes squashed in) as a new
thread on the list so we can have the discussion not buried in another
thread.

Thanks,
Taylor
