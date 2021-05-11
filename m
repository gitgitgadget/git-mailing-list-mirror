Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1686C433B4
	for <git@archiver.kernel.org>; Tue, 11 May 2021 00:18:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A904F61492
	for <git@archiver.kernel.org>; Tue, 11 May 2021 00:18:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbhEKATw (ORCPT <rfc822;git@archiver.kernel.org>);
        Mon, 10 May 2021 20:19:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229719AbhEKATv (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 10 May 2021 20:19:51 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4C26C061574
        for <git@vger.kernel.org>; Mon, 10 May 2021 17:18:45 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id j3-20020a05600c4843b02901484662c4ebso259464wmo.0
        for <git@vger.kernel.org>; Mon, 10 May 2021 17:18:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:in-reply-to:references:date:message-id
         :mime-version;
        bh=x7II1Idd/VPcWPCSdiCP1q/UVGejv04esFTsiZBp/MM=;
        b=SktSm2jhIcEK7i6TvxPT14Ea7XRD3qiX5/I4P8i3tk8lT2VF6Fd6rM3G6Ff4YWzhLq
         bZ/Q7bLWMTTzDPLayLzljI/SQoB9LzWuemyN7SH+mhpdn/BCY3K+w3FmpBw/nraSRVH/
         C2T6TQrCrJDDgaK63MapUXWzvIHxkoQnd/dDD97cP+KWOomx0xEmPMD1GGwWFZyvwxul
         Apg1qOo4oldBEyEUlQA32i9HzTPm/7Zpt41plsQkST2mOGsgwJVaMJD3/PHSrmcTkJP+
         jndNxAi70PmB3kZ87DrM9q5+yc3QSIdc9oIfVrPqDP0Xn/TdHYWwrHwK0nGSn8LzMzpw
         VvuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=x7II1Idd/VPcWPCSdiCP1q/UVGejv04esFTsiZBp/MM=;
        b=Nk6OUicL6G0ll1tn19fOHfHiqx4KT+995xB1xuxR1J2dy0ThZiAVLQ15Ad3LGzR7UD
         c+6ZlDfvyU/5enhfv6FSAmCln6vNzl986zFaKx99co6Ow3vsrj36UqU4Rq0VclIWax2X
         kjmGwwxA2eG9sjsKRfALmYjH982MDUlsEo3TdezR52JZU/rvBtdCLv/qsEvHqhmkLC86
         K39fCYhIlhSxlXlArIh26xr0f6uSocuOBm8NOEqMLC9pyDnqz8WmQc2IqBeTW355Lk6r
         7N8TOKHUmp25pyPPMRbl/pDpPt2LhFe3qaKMbbJzN8JCIIwUHPVCsV4Vqa/vzERp30dv
         lEDQ==
X-Gm-Message-State: AOAM5306Ova+YF2ly7+IMQw7Amm2TuuTGLJt0MjFAb7JVw8D+6kGWC6m
        ChEGezeZu8RWdcnyok2I29EWgfylFevAIJll
X-Google-Smtp-Source: ABdhPJzeIggqDjfigRyW04ESh+ZYJUjK2t1+vB/R5wMvGMQXvTBSruwvn8t0+8WBGoiT7w7mowfg1w==
X-Received: by 2002:a05:600c:2102:: with SMTP id u2mr1997393wml.124.1620692324477;
        Mon, 10 May 2021 17:18:44 -0700 (PDT)
Received: from Inspiron (2a01cb04010c4200a87bd4460637fee8.ipv6.abo.wanadoo.fr. [2a01:cb04:10c:4200:a87b:d446:637:fee8])
        by smtp.gmail.com with ESMTPSA id x8sm24450212wru.70.2021.05.10.17.18.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 May 2021 17:18:44 -0700 (PDT)
From:   Firmin Martin <firminmartin24@gmail.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org, Jeff King <peff@peff.net>,
        Johannes Schindelin <johannes.schindelin@gmail.com>,
        Erik Faye-Lund <kusmabite@gmail.com>,
        Denton Liu <liu.denton@gmail.com>
Subject: Re: [PATCH v1 0/8] format-patch: introduce --confirm-overwrite
In-Reply-To: <xmqqv97vwkzo.fsf@gitster.g>
References: <20210506165102.123739-1-firminmartin24@gmail.com>
 <xmqqv97vwkzo.fsf@gitster.g>
Date:   Tue, 11 May 2021 02:18:42 +0200
Message-ID: <87zgx2f7h9.fsf@Inspiron.i-did-not-set--mail-host-address--so-tickle-me>
MIME-Version: 1.0
Content-Type: text/plain
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Junio C Hamano <gitster@pobox.com> writes:

> Firmin Martin <firminmartin24@gmail.com> writes:
>
>> Particulary, this behaviour could be awkward in the following
>> hypothetical situations:
>>
>> * The user can easily erase a cover letter coming from prior versions or
>> another patch series by reusing an old command line (e.g. autocompleted
>> from the shell history).
>
> "prior versions" implies that the user is better off using -v$n
> where $n is the number greater than the one used for the prior
> iteration by one, and there won't be any overwriting, so this is not
> a very compelling use case.

True, silly of me.

>
> But the next one is real.
>
>> * Assuming that the user is writing a cover letter and realizes that
>> small changes should be made. They make the change, amend and
>> format-patch again to regenerate patches. If it happens that they use
>> the same command again (e.g. with --cover-letter), the cover letter
>> being written is gone.
>
> Yes, after preparing, say, -v2, but before sending them out, it is
> very plausible that proofreading of your own patches may make you
> realize more issues in the series, which may make you go back to your
> commits, "rebase -i" to improve them and re-run "format-patch -v2".
>
> We do want to encourage such careful preparation of your patch
> series before sending it out, and we want to support it well with
> our tools.  Preventing overwriting of the cover (which will have the
> same filename, with the same v2- prefix) is very valuable here.
>
> There is another thing that I suspect people may find irritating in
> the same workflow.  If you fix the commit title while "rebase -i" to
> polish your v2 patch, it would result in a different filename from
> the original v2, so you'd end up with something like
>
>     v2-0000-cover-letter.patch
>     v2-0001-thes-forny-change.patch
>     v2-0001-this-phoney-change.patch
>     v2-0002-another-sample-change.patch
>
> while redoing a two-patch series.  The "thes-forny" thing is a
> leftover from the first "format-patch -v2" run, you fixed typoes
> with "rebase -i" after a self-review and other three files have the
> result of the second "format-patch -v2" run.  You need a way to
> somehow exclude that stale file when driving send-email; in other
> words, before running
>
>     git send-email v2-*.patch
>
> you would want to move away v2-0001-thes-forny-change.patch that no
> longer is part of the series.  I wonder if format-patch can help by
> looking at the output directory before writing its output and move
> the old files away, say, to "old-v2-*.patch" or something?  That

I would go with v2-*.patch.old as it won't be matched by *.patch
(something tempting to do when only one version is present). Or, we can
even keep their filenames unchanged and move them into a subdirectory
old_<timestamp>/.

The case of --numbered-files should also be taking into account. In the
same fashion, the files that will be renamed/moved would be those which
are constituted with numbers.

> incidentally would solve your "files getting overwritten is
> irritating" issue at the same time.

I will work towards this.

>
> Coming back to the topic of cover letter, even when there is no risk
> of ovetwriting, there is another thing we may want to improve to
> help our users.  Suppose you are preparing your v2 patch after
> sending out the v1.  The cover letter we generate for v2 will have
> the same **BOILERPLATE** placeholders that need to be filled from
> scratch.  As many things you wrote for the cover letter in the
> previous round should be reusable, even though the list of titles of
> the patch should be generated afresh, it would be nice if
> format-patch can carry forward what you wrote in the cover letter
> for the v1 iteration to the cover letter for this v2 iteration.
>
> And when we have such a "reuse description in the existing cover
> letter" support, the value of "don't overwrite" knob will mostly go
> away.  Instead of failing the command by refusing to overwrite, you
> can read what is in the existing cover-letter that is about to be
> overwritten, combine the hand-written description with the material
> automatically generated, and ovewrite the existing file, and as long
> as you do a good job of preserving, nobody would complain that you
> overwrote the file.

I have thought about that before this series and agree that this is the
way to go, but I found it a bit challenging: how should I distinguish
the cover letter body and the shortlog (i.e. any content we don't want
to keep to the next cover letter), given that the user could do anything
they want (e.g. remove the shortlog, write after the shortlog, etc.) ?

To easier this task, should we introduce a delimiter between the letter
body and the shortlog as we already do with patches right after the
commit message and before the diffstat (e.g. "---") ? I ignore whether
there are functions we can directly reuse in trailer.c for this purpose.

Thanks,

Firmin
