Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21E01C433E0
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:49:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFA2322228
	for <git@archiver.kernel.org>; Tue, 26 Jan 2021 20:49:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727827AbhAZFDx (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 26 Jan 2021 00:03:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730877AbhAYTZH (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 25 Jan 2021 14:25:07 -0500
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E03FC061573
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:15:22 -0800 (PST)
Received: by mail-qt1-x830.google.com with SMTP id z6so10551234qtn.0
        for <git@vger.kernel.org>; Mon, 25 Jan 2021 11:15:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=57pRHSfLW3lDF4zUofKtR3a4kimg4cuROmJIjECDSCU=;
        b=DNaxTS8AhIxL9/5N9EauPO5zw9wrtZAS6qMMPtZOvvjLVcdW6oU084IagMCVBhs6S3
         urQ2PCtjiyJr45oevgHCGqYlaS3M4PzeHejIqE0a2GGZdcywcu5BaJZ3RO3f49lTbnPo
         xZfBRAJRSXiZUo0QxIiPCTAIApUENpGp3fnMKyvd0aUhPfW0h72iDDb6KTYd0GZ47PFS
         lGSM+xYjId4U1sXTBzQX3Q1vIZ48H7/vz8k6m3umCf8MNT+uStE0uE8jsv7Eoe/bVb4/
         O5zJuyDa67QgsMC8pZ3ahKz/GZ+jGzWEiS0UJfrLF/KdiKiw4WjWKhFD9fOkyRLuUOwI
         xaEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=57pRHSfLW3lDF4zUofKtR3a4kimg4cuROmJIjECDSCU=;
        b=tY9n/lzLJShRR75ZUuGm8JqqKliLAsfHDypqs6WDxYqzBXr8v6L9Qjcwet6fd0DDq8
         9bzOf8tYZ+znk9NMRmsu5Lt7Ujg/nNZzDow6MMT2JDahV4BHDucT8oQzG701D4qFX//c
         YkhedCTFKnGXm1tNdHLpBEwMNhDA5XUS5YMdYVIhJGqZZKDf7iqhS9SUQK6NFVwatU1g
         u5r+zM1slDbMBp8Q2xLBAqQX4uN/Xxtb6FEkEkrPitQkh/3doaEqpLRseRgt4Fm+C1pK
         3Nfa1eOx9laYptwQ139t4uxJSI03Npw6c0pKEH8m+9wGuWQex/U/Ze+FwMAACAUB0Y5o
         97YQ==
X-Gm-Message-State: AOAM531AviRVPGlOH0edkpVRzC6OPnupN0eQJ3fVnzRo2vNFYXFvchHg
        U2dgjuvW/WQZLUUOgXPXZ7OeLiDYyqAbGA==
X-Google-Smtp-Source: ABdhPJy0aVyuz4U8dFbLL1naB55i4kfJuSIsUDegVk6NLUFxtyMCgfr4D+Rzeic/GxuM3TL0ihYBmA==
X-Received: by 2002:ac8:7767:: with SMTP id h7mr2000298qtu.136.1611602121592;
        Mon, 25 Jan 2021 11:15:21 -0800 (PST)
Received: from localhost ([2605:9480:22e:ff10:5e9f:a2e5:e7ac:394d])
        by smtp.gmail.com with ESMTPSA id o20sm12103894qki.93.2021.01.25.11.15.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 Jan 2021 11:15:21 -0800 (PST)
Date:   Mon, 25 Jan 2021 14:15:18 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Jeff King <peff@peff.net>
Cc:     git@vger.kernel.org, dstolee@microsoft.com, gitster@pobox.com,
        jrnieder@gmail.com
Subject: Re: [PATCH v2 2/8] pack-write.c: prepare to write 'pack-*.rev' files
Message-ID: <YA8YxtUUwE0lLxQt@nand.local>
References: <cover.1610129989.git.me@ttaylorr.com>
 <cover.1610576805.git.me@ttaylorr.com>
 <8648c87fa71aec427dc11afcba6548fb66a1413b.1610576805.git.me@ttaylorr.com>
 <YAtey9krU32mgEBV@coredump.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YAtey9krU32mgEBV@coredump.intra.peff.net>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Fri, Jan 22, 2021 at 06:24:59PM -0500, Jeff King wrote:
> On Wed, Jan 13, 2021 at 05:28:11PM -0500, Taylor Blau wrote:
>
> [...]
>
> qsort? Don't we have a perfectly good radix sort for this exact purpose? :)

Yeah, I think your argument against it (which I agree with is
basically):

  We could, and it would be faster, but it would (1) require allocating
  twice as much data, and (2) the speed increase is a drop in the bucket
  on any repository with enough objects to even notice it.

I'll add something to that effect to the commit message.

> Dereferencing a pointer to index another array always makes me nervous
> that we may have a bounds problem with bogus data.
>
> In this case we know it is OK because we filled the array ourselves with
> in-bound numbers in write_rev_index_positions.

Right.

> I was surprised we didn't define these already on the reading side, but
> it looks like we didn't. In patch 1, we probably should be checking
> RIDX_SIGNATURE in load_revindex_from_disk(). But much more importantly,
> we should be checking that we find version 1, since that's what will
> make it safe to later invent a version 2.

:-). Thanks for noticing, fixed.

> I forgot to comment on this in patch 1, but: I think the format is
> really independent of the hash size. The contents are identical for a
> sha-1 versus sha-256 file.

Right; the format is identical. That is, the fields are the same, but
the hashes are longer.

> That said, I don't overly mind having a hash identifier if it might help
> debug things (OTOH, how the heck do you end up with one that matches the
> trailer's packfile but  _doesn't_ match the trailer's contents?).
>
> If we do have it, should we also be checking it in the loading function?

I'm not opposed to it, but I imagined that this field would be primarily
for debugging purposes. I was surprised to learn that we _don't_ verify
the checksum for .idx files. So, I'm reluctant to start doing so here,
honestly.

> So if the caller gave us a name, we force-overwrite it. That seemed
> weird to me at first, but it makes sense; the atomic rename-into-place
> writers will not be passing in the name. And this is exactly how
> write_idx_file() works.

Yep.

> I wonder if we could factor out some of this repeated logic, but I
> suspect it is mostly diminishing returns. Maybe this "open a pack file
> for writing" could become a helper function, though.

Yeah. I tried factoring it out before replying, and it's a little gross.
Most of my discomfort with it lies in the complexity of the parameters.

Consider extracting the code in write_idx_file():

  - There would need to be a double pointer for 'index_name' (which is
    sometimes read, and sometimes written to).

  - There would be an unsigned bit for "verify" (i.e., "open with
    hashfd_check() or not").

  - There would be a "pattern" variable if we were creating a new
    temporary file with odb_mkstemp().

Having the caller be forced to juggle the combinations of passing
NULL/0 or not for each of those three makes me leery that this is worth
doing, so I tend to agree with your judgement that this provides a
diminishing return.

Thanks,
Taylor
