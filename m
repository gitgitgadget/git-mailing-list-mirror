Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3D321C433FE
	for <git@archiver.kernel.org>; Tue, 15 Nov 2022 05:01:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiKOFBd (ORCPT <rfc822;git@archiver.kernel.org>);
        Tue, 15 Nov 2022 00:01:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiKOFBb (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 15 Nov 2022 00:01:31 -0500
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B3FD2666
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 21:01:30 -0800 (PST)
Received: by mail-io1-xd34.google.com with SMTP id 11so9918423iou.0
        for <git@vger.kernel.org>; Mon, 14 Nov 2022 21:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ttaylorr-com.20210112.gappssmtp.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=2F7ELnozS61wrpmpSYuKCXj0te50ImvFCwJg91/Ji9w=;
        b=wSTwlA6ntV/rFxtNc/jtDdSz1ypBJqK9ru1TzBesUWydPfGttInbJ8PvSrCMR5C1JK
         KqGqXcNm9qOH8gnhjF9AuT1KQyOw3lLu4F4+Ib/c74VD79JxWp78c0RqtxOKrWGPob2n
         loUqMJiK2hfdCGYcJttqnhdA8Hp4kzVHivqdNu3jEmi6STkQU+d3VSEcgWfBcssKfzJc
         5f8l1URlAnWowpvaLXca5N6K3piSTSFYOsWQcKoCIgKPZTy3r4kOCREbIhny3UpRAf6V
         iGIOxwQPcWgGdJmRoTg3MPj/Jm8NrJIDaX3ZzwxwfB2tJ/rA/zwFkSBeS4aKaT9ZBMWB
         GTDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2F7ELnozS61wrpmpSYuKCXj0te50ImvFCwJg91/Ji9w=;
        b=Qu/4cID1pXitzHoK6dBlvebD0Di3Z8oCoLT/N+Jz47HOLxV56KOg7FbY4AjL9vgJus
         XbHOa6/QP3w+/Gn6CekUd8xVoe15kM3GFT5r6DmLjqdZTToT6jzF1mTXUheOqqGPOMlV
         EHPA9ljIkYt8PHLbRGPZIm93cyGwZvay/9jYUxo4AT5/GBw3h4psqrCmZGRn1BObSjzq
         wKi+wR3lMa/+c4ZwAE6/VHbhlyi6AsUYg4pw+s6MOscjDEWQPD/2Mf28elHNDvduvy8t
         O2Ysy849ncwDXcCMvcMK9JIVljBZpEX8Prr3LpcY+PRazLkZyTlexl/nyH78ZWixIthy
         GvAw==
X-Gm-Message-State: ANoB5pnocfOpZVEeRUE3fbMoxPjg5j1Heovu4F7dbx9hFA7Spftxglqf
        kHgSnC9qRYikp3GakIoeF1+ItYXPxEOMLg==
X-Google-Smtp-Source: AA0mqf6yh4v5uTdNqbHKg09Q09O4cVTSyZhQ09stEasc+/HKwSJr3WMbwpQDHtqN82tlZIfCQyjfYQ==
X-Received: by 2002:a02:9f0f:0:b0:363:79c4:b889 with SMTP id z15-20020a029f0f000000b0036379c4b889mr7119829jal.292.1668488489673;
        Mon, 14 Nov 2022 21:01:29 -0800 (PST)
Received: from localhost (104-178-186-189.lightspeed.milwwi.sbcglobal.net. [104.178.186.189])
        by smtp.gmail.com with ESMTPSA id u8-20020a02b1c8000000b003760a6b7d12sm2487782jah.157.2022.11.14.21.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Nov 2022 21:01:29 -0800 (PST)
Date:   Tue, 15 Nov 2022 00:01:27 -0500
From:   Taylor Blau <me@ttaylorr.com>
To:     Eric Sunshine <sunshine@sunshineco.com>
Cc:     Taylor Blau <me@ttaylorr.com>, git@vger.kernel.org
Subject: Re: What's cooking in git.git (Nov 2022, #03; Mon, 14)
Message-ID: <Y3MdJ1VDmbkP+T/D@nand.local>
References: <Y3Mag8qG2D3qjlmg@nand.local>
 <CAPig+cT-QhG+7phOYsq5WQvg9tLu3zsJrajgL=+53bEZ9ZiBNg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAPig+cT-QhG+7phOYsq5WQvg9tLu3zsJrajgL=+53bEZ9ZiBNg@mail.gmail.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, Nov 14, 2022 at 11:59:28PM -0500, Eric Sunshine wrote:
> On Mon, Nov 14, 2022 at 11:53 PM Taylor Blau <me@ttaylorr.com> wrote:
> > * es/chainlint-lineno (2022-11-11) 4 commits
> >  - chainlint: prefix annotated test definition with line numbers
> >  - chainlint: latch line numbers at which each token starts and ends
> >  - chainlint: sidestep impoverished macOS "terminfo"
> >  - Merge branch 'es/chainlint-output' into es/chainlint-lineno
> >  (this branch uses es/chainlint-output.)
> >
> >  Teach chainlint.pl to annotate the original test definition instead
> >  of the token stream.
> >
> > * es/chainlint-output (2022-11-08) 4 commits
> >   (merged to 'next' on 2022-11-14 at 9cd7d30183)
> >  + chainlint: annotate original test definition rather than token stream
> >  + chainlint: latch start/end position of each token
> >  + chainlint: tighten accuracy when consuming input stream
> >  + chainlint: add explanatory comments
> >  (this branch is used by es/chainlint-lineno.)
> >
> >  Teach chainlint.pl to annotate the original test definition instead
> >  of the token stream.
>
> These two topics have the same description. Perhaps the
> es/chainlint-lineno topic should be described as:
>
>     Teach chainlint.pl to decorate output with line numbers.
>
> or something.

Oops, thanks for spotting. Luckily since es/chainlint-lineno hasn't been
merged into 'next' yet, this isn't yet memorialized. I'll make a note of
it for when I push out the next integration cycle.

Thanks,
Taylor
