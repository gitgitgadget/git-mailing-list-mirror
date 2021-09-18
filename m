Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6554C433EF
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 03:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D37560F50
	for <git@archiver.kernel.org>; Sat, 18 Sep 2021 03:30:01 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241734AbhIRDbX (ORCPT <rfc822;git@archiver.kernel.org>);
        Fri, 17 Sep 2021 23:31:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234698AbhIRDbW (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 17 Sep 2021 23:31:22 -0400
Received: from mail-il1-x12b.google.com (mail-il1-x12b.google.com [IPv6:2607:f8b0:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F68C061574
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 20:29:59 -0700 (PDT)
Received: by mail-il1-x12b.google.com with SMTP id a20so12356090ilq.7
        for <git@vger.kernel.org>; Fri, 17 Sep 2021 20:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Pzajq182CzbmXunzIAxYiJS7J0s8D7rp+tkTQK8pm7w=;
        b=8JQImEwOOnCKpwFzvWBzBIkfZOAC1UC/EqsVPtP7wBguQJ858Vf9iyNALzMNKbo8Zl
         5XzJ5/2zc1RFLBY2u5aTLcGu40CqBbAkSQ3Hom9sGW3wNn4Pj/zUOspoxMuWyNfN47XV
         QKHVd9U44SzcDqaVQVcfgEUR7sx4Z0MfDWAPZ6wgQK1MfU5lSmkAZUO3NKP+DT+iPWL+
         eu5xtomxMa05yOtigv7MejC6qzFNh5LBs9QfFKustMnFM9Y1JkAxkc66Bp0ymj36/Rou
         lmOevw7EdrVDmfUFFHmvnNM0Yr1lq4wdrYFty/VnCLjqRgDJjPZFsa9DR1BNFTKBc0fh
         vXAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Pzajq182CzbmXunzIAxYiJS7J0s8D7rp+tkTQK8pm7w=;
        b=cQZjAaRx3UZKqZK/wl0zjHwAO67n/tGpByUXA7+ClYMsTkTxo2vffGjCNMci1dDxWp
         VJo15B/eFfPpq/6kNZ0a03ise7LhyAcvQ5wIEdOLtIakCwuUqSSrkAQ1jV86JRix2od5
         0GSe4bx5/GfTms+PFxB4AdmQJT59hmOp3ueiAnOW0wWy1iTHDL85S02wPmt2aTrj+Q+/
         EqIq87EwXUDzpUAJmH9OSrT+UxbXPNaT9oy2owI/AZMybMcIfkeeH47hG3h5uCFMBrX2
         HOvx/A/areSimnsY41WgrBsRhbm6xolTKKFzAklIsU+OfaCgpwGAmjzrly311guaA4Sx
         Ty/w==
X-Gm-Message-State: AOAM531Rn5UFla9JDm/d/CbvMH3exBO2tstOhYkScLUZyeESbc/HgUoh
        wFrSMPWMjoOYRMS7lTy2CwCdIPPJE+TO9yZf
X-Google-Smtp-Source: ABdhPJy/JaKRNTzcih2/qDiTkt65SjzqCrTB+xn8HzEoaS0g+iMhXzXUhMxmPwqhAeqsSr63h+DiaQ==
X-Received: by 2002:a05:6e02:1065:: with SMTP id q5mr10346849ilj.14.1631935799236;
        Fri, 17 Sep 2021 20:29:59 -0700 (PDT)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id r16sm4915465ilj.77.2021.09.17.20.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Sep 2021 20:29:58 -0700 (PDT)
Date:   Fri, 17 Sep 2021 23:29:53 -0400
From:   Taylor Blau <me@ttaylorr.com>
To:     Junio C Hamano <gitster@pobox.com>
Cc:     git@vger.kernel.org
Subject: Re: [PATCH/RFC] range-diff: make output format more useful for
 "rebase --onto"
Message-ID: <YUVdMVCuOTfg5zc3@nand.local>
References: <xmqqv92yg5y6.fsf@gitster.g>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqv92yg5y6.fsf@gitster.g>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Sep 17, 2021 at 04:04:01PM -0700, Junio C Hamano wrote:
> In a range-diff output, we often see an early part of an updated
> series having no changes since the previous iteration.  After
> applying an updated patch submission to the same base as the
> previous round,
>
>     $ git range-diff master..topic@{1} master..topic
>
> to view the differences since the previous edition, we might see
> something like this:
>
> [...]

Hmm... looks familiar :).

> The updated output format looks like this instead:
>
>     1 = 1 a05f02b1d9 a05f02b1d9 : t/helper/test-bitmap.c: add  ...
>     2 = 2 8de300e1f7 8de300e1f7 : pack-bitmap.c: propagate nam ...
>     3 = 3 caca3c9f07 caca3c9f07 : midx.c: respect 'pack.writeB ...
>     4 = 4 2082224f17 2082224f17 : p5326: create missing 'perf- ...
>     5 = 5 97b89c8150 97b89c8150 : p5326: don't set core.multiP ...
>     6 < - a1dd4c97b9 ---------- : p5326: generate pack bitmaps ...
>     - > 6 ---------- bf4a60874a : p5326: generate pack bitmaps ...
>     7 ! 7 2b909ebad3 54156af0d6 : t5326: test propagating hash ...
> 	@@ t/t5326-multi-pack-bitmaps.sh: test_expect_success 'pack.preferBitmapTips' '
> 	 +	(
> 	 +		cd repo &&

I do not feel strongly about either format, and can understand an appeal
for both. I think that I find the existing format a little clearer to
read, but it's possible that I'm just biased since it's always been
that way.

But I can equally understand why it would be nicer to have both hashes
next to each other separated by whitespace.

I also don't care to make it configurable, or to work on more flexible
formatting options for range-diff. I would be fine with the proposed
format. As an alternative, something like this could work:

  perl -ale 'if (@F[2] ne "=") { print "$l $r"; exit }; $l = @F[1]; $r = @F[4]'

when piped the output of range-diff with --no-patch. That gives you
empty output when the two series aren't related, which may or may not be
what you want.

Thanks,
Taylor
